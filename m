From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/10] perf annotate: Fix printing of unaugmented disassembled instructions from BPF
Date: Thu,  8 Aug 2019 15:53:50 -0300
Message-ID: <20190808185358.20125-3-acme@kernel.org>
References: <20190808185358.20125-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808185358.20125-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <songliubraving@fb.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The code to disassemble BPF programs uses binutil's disassembling
routines, and those use in turn fprintf to print to a memstream FILE,
adding a newline at the end of each line, which ends up confusing the
TUI routines called from:

  annotate_browser__write()
    annotate_line__write()
      annotate_browser__printf()
        ui_browser__vprintf()
          SLsmg_vprintf()

The SLsmg_vprintf() function in the slang library gets confused with the
terminating newline, so make the disasm_line__parse() function that
parses the lines produced by the BPF specific disassembler (that uses
binutil's libopcodes) and the lines produced by the objdump based
disassembler used for everything else (and that doesn't adds this
terminating newline) trim the end of the line in addition of the
beginning.

This way when disasm_line->ops.raw, i.e. for instructions without a
special scnprintf() method, we'll not have that \n getting in the way of
filling the screen right after the instruction with spaces to avoid
leaving what was on the screen before and thus garbling the annotation
screen, breaking scrolling, etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Fixes: 6987561c9e86 ("perf annotate: Enable annotation of BPF programs")
Link: https://lkml.kernel.org/n/tip-unbr5a5efakobfr6rhxq99ta@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ac9ad2330f93..163536720149 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1122,7 +1122,7 @@ static int disasm_line__parse(char *line, const char **namep, char **rawp)
 		goto out;
 
 	(*rawp)[0] = tmp;
-	*rawp = skip_spaces(*rawp);
+	*rawp = strim(*rawp);
 
 	return 0;
 
-- 
2.21.0
