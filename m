From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/15] perf bpf: Tighten detection of BPF events
Date: Wed, 23 Aug 2017 16:36:02 -0300
Message-ID: <20170823193614.20394-4-acme@kernel.org>
References: <20170823193614.20394-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170823193614.20394-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

  perf stat -e cpu/uops_executed.core,cmask=1/

would be detected as a BPF source event because the .c matches the .c
source BPF pattern.

v2:

Originally I tried to use lex lookahead, but it doesn't seem to work.

This now extends the BPF pattern to match longer events, but then does
an extra check in the C code to reject BPF matches that do not end with
.c/.o/.obj

This uses REJECT, which makes the flex scanner slower, but that
shouldn't be a big problem for the perf events.

Committer testing:

  # perf trace -e write -e /home/acme/bpf/tracepoint.c cat /etc/passwd > /dev/null
     0.000 ( 0.006 ms): cat/18485 write(fd: 1, buf: 0x7f59eebe1000, count: 3494                         ) ...
     0.006 (         ): raw_syscalls:sys_enter:NR 1 (1, 7f59eebe1000, da6, 22, 7f59eebe0010, 0))
     0.008 (         ): perf_bpf_probe:_write:(ffffffff9626b2c0))
     0.000 ( 0.010 ms): cat/18485  ... [continued]: write()) = 3494
  #

It continues doing what was expected, i.e. identifying
/home/acme/bpf/tracepoint.c as a BPF event and activates the clang
machinery to build an eBPF object and then uses sys_bpf() to hook it up
to the raw_syscalls:sys_enter tracepoint, etc.

Andi forgot to add Wang to the CC list, fix it.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20170811232634.30465-4-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.l | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 660fca05bc93..c42edeac451f 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -53,6 +53,21 @@ static int str(yyscan_t scanner, int token)
 	return token;
 }
 
+static bool isbpf(yyscan_t scanner)
+{
+	char *text = parse_events_get_text(scanner);
+	int len = strlen(text);
+
+	if (len < 2)
+		return false;
+	if ((text[len - 1] == 'c' || text[len - 1] == 'o') &&
+	    text[len - 2] == '.')
+		return true;
+	if (len > 4 && !strcmp(text + len - 4, ".obj"))
+		return true;
+	return false;
+}
+
 /*
  * This function is called when the parser gets two kind of input:
  *
@@ -136,8 +151,8 @@ do {							\
 group		[^,{}/]*[{][^}]*[}][^,{}/]*
 event_pmu	[^,{}/]+[/][^/]*[/][^,{}/]*
 event		[^,{}/]+
-bpf_object	[^,{}]+\.(o|bpf)
-bpf_source	[^,{}]+\.c
+bpf_object	[^,{}]+\.(o|bpf)[a-zA-Z0-9._]*
+bpf_source	[^,{}]+\.c[a-zA-Z0-9._]*
 
 num_dec		[0-9]+
 num_hex		0x[a-fA-F0-9]+
@@ -307,8 +322,8 @@ r{num_raw_hex}		{ return raw(yyscanner); }
 {num_hex}		{ return value(yyscanner, 16); }
 
 {modifier_event}	{ return str(yyscanner, PE_MODIFIER_EVENT); }
-{bpf_object}		{ return str(yyscanner, PE_BPF_OBJECT); }
-{bpf_source}		{ return str(yyscanner, PE_BPF_SOURCE); }
+{bpf_object}		{ if (!isbpf(yyscanner)) REJECT; return str(yyscanner, PE_BPF_OBJECT); }
+{bpf_source}		{ if (!isbpf(yyscanner)) REJECT; return str(yyscanner, PE_BPF_SOURCE); }
 {name}			{ return pmu_str_check(yyscanner); }
 "/"			{ BEGIN(config); return '/'; }
 -			{ return '-'; }
-- 
2.13.5
