import copy

with open("input.txt") as f:
    lines = [str.strip(s) for s in f.readlines()]
    dirs = []
    contents = {}

    listing = False

    for line in lines:
        if line.startswith("$"):
            listing = False
            line = line[2:]
            if line.startswith("cd"):
                dir = line.split(" ")[-1]
                if dir == "/":
                    dirs = [""]
                elif dir == "..":
                    dirs.pop()
                else:
                    dirs.append(dir)
            elif line.startswith("ls"):
                listing = True
        elif listing:
            key = "/".join(dirs)
            if key not in contents:
                contents[key] = {"size": 0, "files": []}
            if line.startswith("dir"):
                contents[key]["files"].append(line.split(" ")[1])
            else:
                contents[key]["size"] += int((line.split(" "))[0])

    def file_size(key):
        sub_size = sum([file_size(key + "/" + d) for d in contents[key]["files"]])
        return contents[key]["size"] + sub_size

    count = 0

    for key in contents:
        size = file_size(key)
        if size <= 100000:
            count += size

    print("Part 1 " + str(count))

    total = 70000000
    needed = 30000000
    best = 70000000

    for key in contents:
        old_size = file_size(key)
        new_contents = copy.deepcopy(contents)

        def remove(key):
            new_contents[key]["size"] = 0
            for f in new_contents[key]["files"]:
                remove(key + "/" + f)
            new_contents[key]["files"] = []

        remove(key)

        def rfs(key):
            sub_size = sum([rfs(key + "/" + d) for d in new_contents[key]["files"]])
            return new_contents[key]["size"] + sub_size

        c = rfs("")
        if total - c >= needed:
            if old_size < best:
                best = old_size
    print("Part 2 " + str(best))
