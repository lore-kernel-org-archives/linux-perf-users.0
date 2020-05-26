From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] perf tools: Fix debuginfo search for Ubuntu
Date: Tue, 26 May 2020 18:29:10 +0300
Message-ID: <20200526152910.1587-1-adrian.hunter@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, Travis Downs <travis.downs@gmail.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Reportedly, from 19.10 Ubuntu has begun mixing up the location of some
debug symbol files, putting files expected to be in
/usr/lib/debug/usr/lib into /usr/lib/debug/lib instead. Fix by adding
another dso_binary_type.

Example on Ubuntu 20.04

  Before:

    $ perf record -e intel_pt//u uname
    Linux
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.030 MB perf.data ]
    $ perf script --call-trace | head -5
           uname 14003 [005] 15321.764958566:  cbr: 42 freq: 4219 MHz (156%)
           uname 14003 [005] 15321.764958566: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )          7f1e71cc4100
           uname 14003 [005] 15321.764961566: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )              7f1e71cc4df0
           uname 14003 [005] 15321.764961900: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )              7f1e71cc4e18
           uname 14003 [005] 15321.764963233: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )              7f1e71cc5128

  After:

    $ perf script --call-trace | head -5
           uname 14003 [005] 15321.764958566:  cbr: 42 freq: 4219 MHz (156%)
           uname 14003 [005] 15321.764958566: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )      _start
           uname 14003 [005] 15321.764961566: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )          _dl_start
           uname 14003 [005] 15321.764961900: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )          _dl_start
           uname 14003 [005] 15321.764963233: (/usr/lib/x86_64-linux-gnu/ld-2.31.so              )          _dl_start

Reported-by: Travis Downs <travis.downs@gmail.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
---
 tools/perf/util/dso.c          | 14 ++++++++++++++
 tools/perf/util/dso.h          |  1 +
 tools/perf/util/probe-finder.c |  1 +
 tools/perf/util/symbol.c       |  2 ++
 4 files changed, 18 insertions(+)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index e68e1375e3c0..15b635d6c83c 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -47,6 +47,7 @@ char dso__symtab_origin(const struct dso *dso)
 		[DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO]	= 'D',
 		[DSO_BINARY_TYPE__FEDORA_DEBUGINFO]		= 'f',
 		[DSO_BINARY_TYPE__UBUNTU_DEBUGINFO]		= 'u',
+		[DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO]	= 'x',
 		[DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO]	= 'o',
 		[DSO_BINARY_TYPE__BUILDID_DEBUGINFO]		= 'b',
 		[DSO_BINARY_TYPE__SYSTEM_PATH_DSO]		= 'd',
@@ -129,6 +130,19 @@ int dso__read_binary_type_filename(const struct dso *dso,
 		snprintf(filename + len, size - len, "%s", dso->long_name);
 		break;
 
+	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
+		/*
+		 * Ubuntu can mixup /usr/lib with /lib, putting debuginfo in
+		 * /usr/lib/debug/lib when it is expected to be in
+		 * /usr/lib/debug/usr/lib
+		 */
+		if (strlen(dso->long_name) < 9 ||
+		    strncmp(dso->long_name, "/usr/lib/", 9))
+			ret = -1;
+		len = __symbol__join_symfs(filename, size, "/usr/lib/debug");
+		snprintf(filename + len, size - len, "%s", dso->long_name + 4);
+		break;
+
 	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
 	{
 		const char *last_slash;
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 42b3a278ac59..8b7958f02609 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -30,6 +30,7 @@ enum dso_binary_type {
 	DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO,
 	DSO_BINARY_TYPE__FEDORA_DEBUGINFO,
 	DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
+	DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
 	DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
 	DSO_BINARY_TYPE__SYSTEM_PATH_DSO,
 	DSO_BINARY_TYPE__GUEST_KMODULE,
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index e4cff49384f4..55924255c535 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -101,6 +101,7 @@ enum dso_binary_type distro_dwarf_types[] = {
 	DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
 	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
 	DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
+	DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
 	DSO_BINARY_TYPE__NOT_FOUND,
 };
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 7725c83996f4..44d81f90b604 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -79,6 +79,7 @@ static enum dso_binary_type binary_type_symtab[] = {
 	DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE,
 	DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP,
 	DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
+	DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
 	DSO_BINARY_TYPE__NOT_FOUND,
 };
 
@@ -1529,6 +1530,7 @@ static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
 	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
 	case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
 	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
+	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
 	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
 	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
 		return !kmod && dso->kernel == DSO_TYPE_USER;
-- 
2.17.1
