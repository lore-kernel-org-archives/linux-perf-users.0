Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEFD3B6C09;
	Thu, 15 Oct 2026 23:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107161; cv=none; b=Y8rhOXOSsGINxW0ogLoPSpUTkZNrj811s7wX1goWmjjYj190v7LS4FyzYPkFkSeGANUhu1e3c36wxGroxjL4Nz6NYC5Z/pfnHTkA45zUXkLyb0ilKq5TIZUbnzOIg6XM2fJwo/rlJMsV3X1AAMbBK7XS3sG8r4a+l6IUAX4Ms2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107161; c=relaxed/simple;
	bh=pTr+Kw2phrs8nFOpzgbcHU6qVLTfL1BPcohM5HqCXPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I2FToQcQoSUjhBm40xWIMzscterIQboSOVAZXhy0ac6P1BSEPLGDbUqVo+UTAS4s1JEUp7aHQWJuXelVc497ljwd/ab9rCwmWI4GEOB6URc8FMxBTbWcpdaS8r+K3lRQA6GKzYGEpo32Ebw6hdZCPaMIxD4sFnyzTr3WxeXPFdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdKSmMhx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdKSmMhx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98A21F000C4;
	Thu, 15 Oct 2026 23:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792107159;
	bh=rwcEpSGQ4lL7pCBm9rLrnz3JM1wrNZZfjauwMNISO8k=;
	h=From:To:Cc:Subject:Date;
	b=WdKSmMhxuJopk1hsyLc+p52EPtozpgZoZV1zLS5i5CBorS7lsE60S5hLKVj/DbdaZ
	 zUv6VgO7QI9gBkotwR3/zsObVLcLau5vysDk2VVNOye/o2wEua92vDdOfsmXFhc1er
	 0TwVrqFd/mBAwq6fDM2ZuxtQH5yA5KsWKakXWrLpLZdsKNr3azOvWdNid+AX4R5NLq
	 EwGXsPnvp9YkgNMXY4oXNq81T7dV+PaI2nEnqhYHnfXCJYwQX+ibnOxOxbUZ9t9tes
	 VCv4N2Gl6Aqe/aPQR3PAfymyo2WtmQ69OCfnioBMT/TxellvnVHdMuQwrWlsCwp7D0
	 fZ/7upSCzaRIQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2] perf c2c: Fix memory leaks on output fields
Date: Thu, 15 Oct 2026 16:32:37 -0700
Message-ID: <20261015233237.542258-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
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
 tools/perf/builtin-c2c.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 4222ac784fabef6b..f51fa23f3bf18b90 100644
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
@@ -2563,7 +2568,7 @@ static void print_pareto(FILE *out, struct perf_env *env)
 	ret = hpp_list__parse(&hpp_list, cl_output, /*evlist=*/NULL, env);
 
 	if (WARN_ONCE(ret, "failed to setup sort entries\n"))
-		return;
+		goto out;
 
 	nd = rb_first_cached(&c2c.hists.hists.entries);
 
@@ -2577,6 +2582,9 @@ static void print_pareto(FILE *out, struct perf_env *env)
 		c2c_he = container_of(he, struct c2c_hist_entry, he);
 		print_cacheline(c2c_he->hists, he, &hpp_list, out);
 	}
+
+out:
+	perf_hpp__reset_output_field(&hpp_list);
 }
 
 static void print_c2c_info(FILE *out, struct perf_session *session)
@@ -3378,12 +3386,12 @@ static int perf_c2c__report(int argc, const char **argv)
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
@@ -3525,6 +3533,8 @@ static int perf_c2c__report(int argc, const char **argv)
 	free(output_str);
 out_mem2node:
 	mem2node__exit(&c2c.mem2node);
+out_hists:
+	c2c_hists__exit(&c2c.hists);
 out_session:
 	perf_session__delete(session);
 out:
-- 
2.56.0.176.g3575e65682-goog

