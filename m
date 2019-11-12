From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/15] perf symbols: Use kmaps(map)->machine when we know its a kernel map
Date: Tue, 12 Nov 2019 15:37:51 -0300
Message-ID: <20191112183757.28660-10-acme@kernel.org>
References: <20191112183757.28660-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191112183757.28660-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

And then stop using map->groups to achieve that.

To test that that branch is being taken, probe the function that is only
called from there and then run something like 'perf top' in another
xterm:

  # perf probe -x ~/bin/perf machine__map_x86_64_entry_trampolines
  Added new event:
    probe_perf:machine__map_x86_64_entry_trampolines (on machine__map_x86_64_entry_trampolines in /home/acme/bin/perf)

  You can now use it in all perf tools, such as:

  	perf record -e probe_perf:machine__map_x86_64_entry_trampolines -aR sleep 1

  # perf trace -e probe_perf:*
       0.000 bash/10614 probe_perf:machine__map_x86_64_entry_trampolines(__probe_ip: 5224944)
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lgrrzdxo2p9liq2keivcg887@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 2764863212b1..88f4cfbdb69a 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1588,7 +1588,7 @@ int dso__load(struct dso *dso, struct map *map)
 	char *name;
 	int ret = -1;
 	u_int i;
-	struct machine *machine;
+	struct machine *machine = NULL;
 	char *root_dir = (char *) "";
 	int ss_pos = 0;
 	struct symsrc ss_[2];
@@ -1617,17 +1617,13 @@ int dso__load(struct dso *dso, struct map *map)
 		goto out;
 	}
 
-	if (map->groups)
-		machine = map->groups->machine;
-	else
-		machine = NULL;
-
 	if (dso->kernel) {
 		if (dso->kernel == DSO_TYPE_KERNEL)
 			ret = dso__load_kernel_sym(dso, map);
 		else if (dso->kernel == DSO_TYPE_GUEST_KERNEL)
 			ret = dso__load_guest_kernel_sym(dso, map);
 
+		machine = map__kmaps(map)->machine;
 		if (machine__is(machine, "x86_64"))
 			machine__map_x86_64_entry_trampolines(machine, dso);
 		goto out;
@@ -2027,15 +2023,9 @@ static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map)
 {
 	int err;
 	const char *kallsyms_filename = NULL;
-	struct machine *machine;
+	struct machine *machine = map__kmaps(map)->machine;
 	char path[PATH_MAX];
 
-	if (!map->groups) {
-		pr_debug("Guest kernel map hasn't the point to groups\n");
-		return -1;
-	}
-	machine = map->groups->machine;
-
 	if (machine__is_default_guest(machine)) {
 		/*
 		 * if the user specified a vmlinux filename, use it and only
-- 
2.21.0
