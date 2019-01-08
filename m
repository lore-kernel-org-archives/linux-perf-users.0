From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/16] perf beauty: Switch from using uapi/linux/fs.h to uapi/linux/mount.h
Date: Tue,  8 Jan 2019 16:59:08 -0300
Message-ID: <20190108195910.17726-15-acme@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108195910.17726-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Howells <dhowells@redhat.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As now we'll update our fs.h copy and what tools/perf/trace/beauty/mount_flags.sh
needs just got moved to mount.h, use that instead.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ls19h376xukeouxrw9dswkcn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/mount_flags.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/trace/beauty/mount_flags.sh b/tools/perf/trace/beauty/mount_flags.sh
index 45547573a1db..847850b2ef6c 100755
--- a/tools/perf/trace/beauty/mount_flags.sh
+++ b/tools/perf/trace/beauty/mount_flags.sh
@@ -5,11 +5,11 @@
 
 printf "static const char *mount_flags[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MS_([[:alnum:]_]+)[[:space:]]+([[:digit:]]+)[[:space:]]*.*'
-egrep $regex ${header_dir}/fs.h | egrep -v '(MSK|VERBOSE|MGC_VAL)\>' | \
+egrep $regex ${header_dir}/mount.h | egrep -v '(MSK|VERBOSE|MGC_VAL)\>' | \
 	sed -r "s/$regex/\2 \2 \1/g" | sort -n | \
 	xargs printf "\t[%s ? (ilog2(%s) + 1) : 0] = \"%s\",\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MS_([[:alnum:]_]+)[[:space:]]+\(1<<([[:digit:]]+)\)[[:space:]]*.*'
-egrep $regex ${header_dir}/fs.h | \
+egrep $regex ${header_dir}/mount.h | \
 	sed -r "s/$regex/\2 \1/g" | \
 	xargs printf "\t[%s + 1] = \"%s\",\n"
 printf "};\n"
-- 
2.20.1
