From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 2/2] perf tools: Unwind properly location after REJECT
Date: Fri, 27 Oct 2017 16:50:47 -0300
Message-ID: <20171027195047.27132-3-acme@kernel.org>
References: <20171027195047.27132-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171027195047.27132-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Changbin Du <changbin.du@intel.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We have defined YY_USER_ACTION to keep trace of the column location
during events parsing, but we need to clean it up when we call REJECT.

When REJECT is called, the lexer shrinks the text and re-runs the
matching, so we need to address it in resuming the previous location
value to keep it correct for error display, like:

Before:
  $ perf stat -e 'cpu/uops_executed.core,krava/'  true
  event syntax error: '..38;5;9:mi=01;05;37;41:su=48;5;196;38;5;15:sg=48;5;1\
1;38;5;16:ca=48;5;196;38;5;226:tw=48;5;10;38;5;16:ow=48;5;10;38;5;21:st=48;5;\
21;38;50
�'
                                  \___ unknown term

After:
  $ ./perf stat -e 'cpu/uops_executed.core,krava/'  true
  event syntax error: '..cuted.core,krava/'
                                    \___ unknown term

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Andi Kleen <ak@linux.intel.com>
Cc: Changbin Du <changbin.du@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-vug2hchlny30jfsfrumbym26@git.kernel.org
Link: http://lkml.kernel.org/r/20171009140944.GD28623@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.l | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index dcfdafdc2f1c..6680e4fb7967 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -154,6 +154,10 @@ do {							\
 	yycolumn += yyleng;				\
 } while (0);
 
+#define USER_REJECT		\
+	yycolumn -= yyleng;	\
+	REJECT
+
 %}
 
 %x mem
@@ -335,8 +339,8 @@ r{num_raw_hex}		{ return raw(yyscanner); }
 {num_hex}		{ return value(yyscanner, 16); }
 
 {modifier_event}	{ return str(yyscanner, PE_MODIFIER_EVENT); }
-{bpf_object}		{ if (!isbpf(yyscanner)) REJECT; return str(yyscanner, PE_BPF_OBJECT); }
-{bpf_source}		{ if (!isbpf(yyscanner)) REJECT; return str(yyscanner, PE_BPF_SOURCE); }
+{bpf_object}		{ if (!isbpf(yyscanner)) USER_REJECT; return str(yyscanner, PE_BPF_OBJECT); }
+{bpf_source}		{ if (!isbpf(yyscanner)) USER_REJECT; return str(yyscanner, PE_BPF_SOURCE); }
 {name}			{ return pmu_str_check(yyscanner); }
 "/"			{ BEGIN(config); return '/'; }
 -			{ return '-'; }
-- 
2.13.6
