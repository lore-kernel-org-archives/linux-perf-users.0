Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B6D27057D;
	Thu, 15 Oct 2026 06:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046937; cv=none; b=eFbp4QvOCQkJBEc/Tn5E+5upGaPdNHsF5d2vgpTYfxhQE9KUqYxVncuXuElLIacTTi5Py534zqaCTlZFjS7D8kA3NVH+14iwxApmd1mcWnkD4bA3WTS8h18WWi7Ovc6WpFTWFKMitAS430v1baFARrqWMXaH+uGXajP5LljpD2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046937; c=relaxed/simple;
	bh=Vx4WNBNl7SOPDEKnt7RVr9r9XrczH2ZC8K4MYPdXKYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BpDVWx65jW3RAr41ylE75/Nu0TT8Qomdf7fpm+5VXsji+dEaUeA8J4YbbzzUOr1YUPuJ75CcCsUV/MGseCshhdCdoZWawjFrwQtOLm6NWrSxDaeYsGh2FqnH1LretU1arT1m7+VFJQVfTvkhfb99Ft+imaWlMs4zHSODzu3t9XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSvZh6T6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSvZh6T6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110961F000C4;
	Thu, 15 Oct 2026 06:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792046936;
	bh=INoA3eVpkm2e3ROHdK2qniT1eVroY4hUq1eYZv5DCfk=;
	h=From:To:Cc:Subject:Date;
	b=aSvZh6T6xahyGHhC0EW9wxXhrWhpEM8b0kFruRKRwBYOVP7S7kbkaxdvUzakZEpcq
	 R97WKRNx7PsoGU0GHXd3u9Bh00VCMBH37GUFgMt2cv54NKgXpdLIx9wp3XlacVH8dW
	 iRrLRizPNdWSu+WFto1NOfHCKjnXmbUU3um/WMU1MlSR3fxH3VvBx9MqjbKw0vRiEC
	 BlOSA0bXcvzUP/XgOZ0sWYq/YGxlyWycdudy8TIVU92zBaPy+S08OG5a7PoiTJYibO
	 0BhM4ZCzpyaGd4RBPQtemEVN3Mj9HsyuYFHJXWn30XtonSCYhMsA15GxWyMe+ddUmi
	 Bqo44S6hc5wQQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf c2c: Fix memory leaks on output fields
Date: Wed, 14 Oct 2026 23:48:50 -0700
Message-ID: <20261015064850.43366-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The perf_hpp_list was not freed after use.  Let's add it for the main
c2c hists list in perf c2c report and a local list in print_pareto().

Previously it was detected by ASAN like below.

  =================================================================
  ==42183==ERROR: LeakSanitizer: detected memory leaks

  Indirect leak of 1064 byte(s) in 7 object(s) allocated from:
      #0 0x7f17334ef24f in calloc (/lib64/libasan.so.8+0xef24f) (BuildId: 61e8165ca90f7a4f06b73f064a938c76deaae079)
      #1 0x0000005fa099 in zalloc  ../../lib/zalloc.c:8
      #2 0x0000004faf6d in get_format  tools/perf/builtin-c2c.c:1978
      #3 0x0000004fb45e in c2c_hists__init_output  tools/perf/builtin-c2c.c:2004
      #4 0x0000004fb7de in __hpp_list__parse  tools/perf/builtin-c2c.c:2047
      #5 0x0000004fbae9 in hpp_list__parse  tools/perf/builtin-c2c.c:2085
      #6 0x0000004fee13 in print_pareto  tools/perf/builtin-c2c.c:2563
      #7 0x0000004ffcd7 in perf_c2c__hists_fprintf  tools/perf/builtin-c2c.c:2708
      #8 0x000000500ab5 in perf_c2c_display  tools/perf/builtin-c2c.c:2949
      #9 0x0000005045c3 in perf_c2c__report  tools/perf/builtin-c2c.c:3522
      #10 0x000000505caa in cmd_c2c  tools/perf/builtin-c2c.c:3676
      #11 0x0000005df50e in run_builtin  tools/perf/perf.c:383
      #12 0x0000005df9b1 in handle_internal_command  tools/perf/perf.c:436
      #13 0x0000005dfd7f in run_argv  tools/perf/perf.c:480
      #14 0x0000005e02d6 in main  tools/perf/perf.c:581
      #15 0x7f1729450680 in __libc_start_call_main (/lib64/libc.so.6+0x3680) (BuildId: 85075e2ae2e13352a1413d41c327dacf6461526c)
      #16 0x7f1729450797 in __libc_start_main@GLIBC_2.2.5 (/lib64/libc.so.6+0x3797) (BuildId: 85075e2ae2e13352a1413d41c327dacf6461526c)
      #17 0x000000409c34 in _start (tools/perf/perf+0x409c34) (BuildId: 36a64600776d92e4ab7dfd5ca20c92280d72a645)

  SUMMARY: AddressSanitizer: 1064 byte(s) leaked in 7 allocation(s).

Fixes: c75540e3160f ("perf c2c report: Add dimension support")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-c2c.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 4222ac784fabef6b..b2b07e6a2a717466 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2155,6 +2155,11 @@ static int c2c_hists__reinit(struct c2c_hists *c2c_hists,
 	return ret;
 }
 
+static void c2c_hists__exit(struct c2c_hists *c2c_hists)
+{
+	perf_hpp__reset_output_field(&c2c_hists->list);
+}
+
 #define DISPLAY_LINE_LIMIT  0.001
 
 static u8 filter_display(u32 val, u32 sum)
@@ -2577,6 +2582,8 @@ static void print_pareto(FILE *out, struct perf_env *env)
 		c2c_he = container_of(he, struct c2c_hist_entry, he);
 		print_cacheline(c2c_he->hists, he, &hpp_list, out);
 	}
+
+	perf_hpp__reset_output_field(&hpp_list);
 }
 
 static void print_c2c_info(FILE *out, struct perf_session *session)
@@ -3378,12 +3385,12 @@ static int perf_c2c__report(int argc, const char **argv)
 	err = setup_nodes(session);
 	if (err) {
 		pr_err("Failed setup nodes\n");
-		goto out_session;
+		goto out_hists;
 	}
 
 	err = mem2node__init(&c2c.mem2node, env);
 	if (err)
-		goto out_session;
+		goto out_hists;
 
 	err = setup_callchain(session->evlist);
 	if (err)
@@ -3525,6 +3532,8 @@ static int perf_c2c__report(int argc, const char **argv)
 	free(output_str);
 out_mem2node:
 	mem2node__exit(&c2c.mem2node);
+out_hists:
+	c2c_hists__exit(&c2c.hists);
 out_session:
 	perf_session__delete(session);
 out:
-- 
2.56.0

