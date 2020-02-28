From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/15] perf annotate: Fix perf config option description
Date: Fri, 28 Feb 2020 11:00:08 -0300
Message-ID: <20200228140014.1236-10-acme@kernel.org>
References: <20200228140014.1236-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200228140014.1236-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Changbin Du <changbin.du@intel.com>, Ian Rogers <irogers@google.com>, Jin Yao <yao.jin@linux.intel.com>, Leo Yan <leo.yan@linaro.org>, Song Liu <songliubraving@fb.com>, Taeung Song <treeze.taeung@gmail.com>, Thomas Richter <tmricht@linux.ibm.com>, Yisheng Xie <xieyisheng1@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

perf config annotate options says it works only with TUI, which is wrong.
Most of the TUI options are applicable to stdio2 as well. So remove that
generic line and add individual line with each option stating which
browsers supports that option. Also, annotate.show_nr_samples config is
missing in Documentation. Describe it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Changbin Du <changbin.du@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>
Link: http://lore.kernel.org/lkml/20200213064306.160480-8-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 30 +++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index c4dd23c4b478..9dae0df3ab7e 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -239,7 +239,6 @@ buildid.*::
 		set buildid.dir to /dev/null. The default is $HOME/.debug
 
 annotate.*::
-	These options work only for TUI.
 	These are in control of addresses, jump function, source code
 	in lines of assembly code from a specific program.
 
@@ -269,6 +268,8 @@ annotate.*::
 		│        mov    (%rdi),%rdx
 		│              return n;
 
+		This option works with tui, stdio2 browsers.
+
         annotate.use_offset::
 		Basing on a first address of a loaded function, offset can be used.
 		Instead of using original addresses of assembly code,
@@ -287,6 +288,8 @@ annotate.*::
 
 		             368:│  mov    0x8(%r14),%rdi
 
+		This option works with tui, stdio2 browsers.
+
 	annotate.jump_arrows::
 		There can be jump instruction among assembly code.
 		Depending on a boolean value of jump_arrows,
@@ -306,6 +309,8 @@ annotate.*::
 		│1330:   mov    %r15,%r10
 		│1333:   cmp    %r15,%r14
 
+		This option works with tui browser.
+
         annotate.show_linenr::
 		When showing source code if this option is 'true',
 		line numbers are printed as below.
@@ -325,6 +330,8 @@ annotate.*::
 		│                     array++;
 		│             }
 
+		This option works with tui, stdio2 browsers.
+
         annotate.show_nr_jumps::
 		Let's see a part of assembly code.
 
@@ -335,6 +342,8 @@ annotate.*::
 
 		│1 1382:   movb   $0x1,-0x270(%rbp)
 
+		This option works with tui, stdio2 browsers.
+
         annotate.show_total_period::
 		To compare two records on an instruction base, with this option
 		provided, display total number of samples that belong to a line
@@ -348,11 +357,30 @@ annotate.*::
 
 		99.93 │      mov    %eax,%eax
 
+		This option works with tui, stdio2, stdio browsers.
+
+	annotate.show_nr_samples::
+		By default perf annotate shows percentage of samples. This option
+		can be used to print absolute number of samples. Ex, when set as
+		false:
+
+		Percent│
+		 74.03 │      mov    %fs:0x28,%rax
+
+		When set as true:
+
+		Samples│
+		     6 │      mov    %fs:0x28,%rax
+
+		This option works with tui, stdio2, stdio browsers.
+
 	annotate.offset_level::
 		Default is '1', meaning just jump targets will have offsets show right beside
 		the instruction. When set to '2' 'call' instructions will also have its offsets
 		shown, 3 or higher will show offsets for all instructions.
 
+		This option works with tui, stdio2 browsers.
+
 hist.*::
 	hist.percentage::
 		This option control the way to calculate overhead of filtered entries -
-- 
2.21.1
