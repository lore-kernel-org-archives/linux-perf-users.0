From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/13] perf scripts python: exported-sql-viewer.py: Fix python3 support
Date: Fri, 29 Mar 2019 10:38:00 -0300
Message-ID: <20190329133801.21004-13-acme@kernel.org>
References: <20190329133801.21004-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329133801.21004-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Unlike python2, python3 strings are not compatible with byte strings.
That results in disassembly not working for the branches reports. Fixup
those places overlooked in the port to python3.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Fixes: beda0e725e5f ("perf script python: Add Python3 support to exported-sql-viewer.py")
Link: http://lkml.kernel.org/r/20190327072826.19168-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/scripts/python/exported-sql-viewer.py  | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 0cf30956064a..74ef92f1d19a 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -2908,9 +2908,13 @@ class LibXED():
 		ok = self.xed_format_context(2, inst.xedp, inst.bufferp, sizeof(inst.buffer), ip, 0, 0)
 		if not ok:
 			return 0, ""
+		if sys.version_info[0] == 2:
+			result = inst.buffer.value
+		else:
+			result = inst.buffer.value.decode()
 		# Return instruction length and the disassembled instruction text
 		# For now, assume the length is in byte 166
-		return inst.xedd[166], inst.buffer.value
+		return inst.xedd[166], result
 
 def TryOpen(file_name):
 	try:
@@ -2926,9 +2930,14 @@ def Is64Bit(f):
 	header = f.read(7)
 	f.seek(pos)
 	magic = header[0:4]
-	eclass = ord(header[4])
-	encoding = ord(header[5])
-	version = ord(header[6])
+	if sys.version_info[0] == 2:
+		eclass = ord(header[4])
+		encoding = ord(header[5])
+		version = ord(header[6])
+	else:
+		eclass = header[4]
+		encoding = header[5]
+		version = header[6]
 	if magic == chr(127) + "ELF" and eclass > 0 and eclass < 3 and encoding > 0 and encoding < 3 and version == 1:
 		result = True if eclass == 2 else False
 	return result
-- 
2.20.1
