Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0914B13A268;
	Sat,  3 Aug 2024 21:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722719617; cv=none; b=UuirK7rFlo6IsdkVwoinROzBR7zYXF33LkJ326F77r38bMoCZb1EoW0R7H+VDR/DFNXa7gjLNddp3hrbgvcmI5/j7RJcXBcGT53SiWJTY1eaMSTa8J6CjAYzBCJ0IwpWsDKq9iAdlbfIvKpovPwWZq/wP9n7xHIyVZTEsK6+MeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722719617; c=relaxed/simple;
	bh=bzxWFY3qSDkeG5BTvniUSpMK/drRzTB6XLQAiW1I2O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ra9Xxs9Ux3oZ+FTddhwFYnPuuSc/uVycJi3SWpofkhjYoQOxTPXoBoKkG0GfVkY5B2Fkw/skmmwOZWPkhaYcA0HtmgpS/lNashYD5GOPsvkJlyVJCceOm2aiLN1WfyTSc/9i4Y6M8bx2xUlrX0dFzSqCx0Hg3ez6MZik+ZNAPDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkU2DGCi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkU2DGCi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380B8C4AF0E;
	Sat,  3 Aug 2024 21:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722719616;
	bh=bzxWFY3qSDkeG5BTvniUSpMK/drRzTB6XLQAiW1I2O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mkU2DGCiQYdlEBQ0VHLWXGJXC2j4OM+frPhwBtjVTLrKp7s8ncHPmNp8WUgsIKenU
	 YBYRZlUjOzpotcWlYouPkRu3dDRj30dfgSSp65AyuwdvkEPhtZyBiOQhHwsgOCVdH/
	 BteBxkseM0XFp8SFjvITnMyzbeZ3S7DXz5QlwLX3yaY0UrimORb751teVP+JAD3dwe
	 HqMpoWW1fcaz06ggq4Gn/z+fNm9SFvTaytTC5bjdxCJRMjD/j5WH/qSDlT7tIbkhbj
	 14HasQ9Uh572Hp6OqlVQ5PCDcFfWnt2Sj6+4FrEjI6O42ceykZvQo98wvB5WVSZgGW
	 UhTAqAmE3RucQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 5/5] perf annotate: Add --skip-empty option
Date: Sat,  3 Aug 2024 14:13:32 -0700
Message-ID: <20240803211332.1107222-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
In-Reply-To: <20240803211332.1107222-1-namhyung@kernel.org>
References: <20240803211332.1107222-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like in perf report, we want to hide empty events in the perf annotate
output.  This is consistent when the option is set in perf report.

For example, the following command would use 3 events including dummy.

  $ perf mem record -a -- perf test -w noploop

  $ perf evlist
  cpu/mem-loads,ldlat=30/P
  cpu/mem-stores/P
  dummy:u

Just using perf annotate with --group will show the all 3 events.

  $ perf annotate --group --stdio | head
   Percent                 |	Source code & Disassembly of ...
  --------------------------------------------------------------
                           : 0     0xe060 <_dl_relocate_object>:
      0.00    0.00    0.00 :    e060:       pushq   %rbp
      0.00    0.00    0.00 :    e061:       movq    %rsp, %rbp
      0.00    0.00    0.00 :    e064:       pushq   %r15
      0.00    0.00    0.00 :    e066:       movq    %rdi, %r15
      0.00    0.00    0.00 :    e069:       pushq   %r14
      0.00    0.00    0.00 :    e06b:       pushq   %r13
      0.00    0.00    0.00 :    e06d:       movl    %edx, %r13d

Now with --skip-empty, it'll hide the last dummy event.

  $ perf annotate --group --stdio --skip-empty | head
   Percent         |	Source code & Disassembly of ...
  ------------------------------------------------------
                   : 0     0xe060 <_dl_relocate_object>:
      0.00    0.00 :    e060:       pushq   %rbp
      0.00    0.00 :    e061:       movq    %rsp, %rbp
      0.00    0.00 :    e064:       pushq   %r15
      0.00    0.00 :    e066:       movq    %rdi, %r15
      0.00    0.00 :    e069:       pushq   %r14
      0.00    0.00 :    e06b:       pushq   %r13
      0.00    0.00 :    e06d:       movl    %edx, %r13d

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-annotate.txt |  3 +++
 tools/perf/builtin-annotate.c              |  2 ++
 tools/perf/util/annotate.c                 | 22 +++++++++++++++++-----
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index b95524bea021..156c5f37b051 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -165,6 +165,9 @@ include::itrace.txt[]
 --type-stat::
 	Show stats for the data type annotation.
 
+--skip-empty::
+	Do not display empty (or dummy) events.
+
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index cf60392b1c19..efcadb7620b8 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -795,6 +795,8 @@ int cmd_annotate(int argc, const char **argv)
 		    "Show stats for the data type annotation"),
 	OPT_BOOLEAN(0, "insn-stat", &annotate.insn_stat,
 		    "Show instruction stats for the data type annotation"),
+	OPT_BOOLEAN(0, "skip-empty", &symbol_conf.skip_empty,
+		    "Do not display empty (or dummy) events in the output"),
 	OPT_END()
 	};
 	int ret;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 917897fe44a2..eafe8d65052e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -848,6 +848,10 @@ static void annotation__calc_percent(struct annotation *notes,
 
 			BUG_ON(i >= al->data_nr);
 
+			if (symbol_conf.skip_empty &&
+			    evsel__hists(evsel)->stats.nr_samples == 0)
+				continue;
+
 			data = &al->data[i++];
 
 			calc_percent(notes, evsel, data, al->offset, end);
@@ -901,7 +905,7 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 		.options	= &annotate_opts,
 	};
 	struct arch *arch = NULL;
-	int err;
+	int err, nr;
 
 	err = evsel__get_arch(evsel, &arch);
 	if (err < 0)
@@ -922,10 +926,18 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 			return -1;
 	}
 
-	if (evsel__is_group_event(evsel))
-		notes->src->nr_events = evsel->core.nr_members;
-	else
-		notes->src->nr_events = 1;
+	nr = 0;
+	if (evsel__is_group_event(evsel)) {
+		struct evsel *pos;
+
+		for_each_group_evsel(pos, evsel) {
+			if (symbol_conf.skip_empty &&
+			    evsel__hists(pos)->stats.nr_samples == 0)
+				continue;
+			nr++;
+		}
+	}
+	notes->src->nr_events = nr ? nr : 1;
 
 	if (annotate_opts.full_addr)
 		notes->src->start = map__objdump_2mem(ms->map, ms->sym->start);
-- 
2.46.0.rc2.264.g509ed76dc8-goog

