From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 55/63] perf trace: When showing string prefixes show prefix + ??? for unknown entries
Date: Tue, 18 Dec 2018 19:07:25 -0300
Message-ID: <20181218220733.15839-56-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To match 'strace' output, like in:

  arch_prctl(0x3001 /* ARCH_??? */, 0x7ffc8a92dc80) = -1 EINVAL (Invalid argument)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-kx59j2dk5l1x04ou57mt99ck@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 9d30e0f3b7ea..6d9be952e3a7 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -365,8 +365,12 @@ size_t strarray__scnprintf(struct strarray *sa, char *bf, size_t size, const cha
 {
 	int idx = val - sa->offset;
 
-	if (idx < 0 || idx >= sa->nr_entries || sa->entries[idx] == NULL)
-		return scnprintf(bf, size, intfmt, val);
+	if (idx < 0 || idx >= sa->nr_entries || sa->entries[idx] == NULL) {
+		size_t printed = scnprintf(bf, size, intfmt, val);
+		if (show_prefix)
+			printed += scnprintf(bf + printed, size - printed, " /* %s??? */", sa->prefix);
+		return printed;
+	}
 
 	return scnprintf(bf, size, "%s%s", show_prefix ? sa->prefix : "", sa->entries[idx]);
 }
@@ -388,6 +392,7 @@ static size_t syscall_arg__scnprintf_strarray(char *bf, size_t size,
 
 size_t strarrays__scnprintf(struct strarrays *sas, char *bf, size_t size, const char *intfmt, bool show_prefix, int val)
 {
+	size_t printed;
 	int i;
 
 	for (i = 0; i < sas->nr_entries; ++i) {
@@ -401,7 +406,10 @@ size_t strarrays__scnprintf(struct strarrays *sas, char *bf, size_t size, const
 		}
 	}
 
-	return scnprintf(bf, size, intfmt, val);
+	printed = scnprintf(bf, size, intfmt, val);
+	if (show_prefix)
+		printed += scnprintf(bf + printed, size - printed, " /* %s??? */", sas->entries[0]->prefix);
+	return printed;
 }
 
 size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size,
-- 
2.19.2
