Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAAB19EED7;
	Fri,  7 Mar 2025 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741327975; cv=none; b=uSn4trCKpT1qVYTxCXRjAPAnRHMq8lvFjYBrtdqnxr7Pilh6fcQkWkzxQI2/sEhv0H4ie6mGp7yNp6gm0FAxJwcfdOnflCKBIm0JLxs12jtD+hnglnxsdVuIRKFzRSvo4sqbzXcFXtXPf9yWculmenodAVGAmjumJRuxF/DwKGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741327975; c=relaxed/simple;
	bh=CLDLM74rtz+CXjGoPhg97GQkxsWQI+oSAPMLW9niFH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFIIAhfSQg1FdmHIpDJE8TbTNI09Gw+j21JADNqeQtIKQxWxyBNhtEjpHmMklvC17RLUlnmx2PjK/Tv819hPLUCCPMZR9UJg6ozs4zI1cOC//my3L58QiLjass85tohBPJfHO6XazktoGQYCOzMcTcVIhEZyClRt+4TLD+SJjVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGPdPBMY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGPdPBMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194FAC4CEEA;
	Fri,  7 Mar 2025 06:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741327972;
	bh=CLDLM74rtz+CXjGoPhg97GQkxsWQI+oSAPMLW9niFH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bGPdPBMYh9LD68BiprBBbO2RTtwHMgKd/d2vquegjodnngZ3DZ7P0NsbYjZ6WDlIM
	 sqvVVnB7qaotDkVtDXzZgYjO5/rwJ/wkPWHYZCGodxUijLdGqAwLu8zXf3wxsrzZ5K
	 dW5okOP6j6MIyj5IcpJ04mrKszSnd6CM+dWV9QAGTM7tBtNCTXylDjm9l73ij+68ZT
	 PtszuIOSgnWsCdIJDWIT+6Ka0g4QOHTb2qArKm2Zwl39ce4N9Z16kWIPfueboJ66bl
	 M8CotaDciAKS8ZRSE25rSowcYshv73UyGk0DgdfOn6czz3Sr0p6DZFhpWtkjjTA/Qv
	 gQTA5oKrQh76A==
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
Subject: [PATCH v2 2/2] perf report: Fix memory leaks in the hierarchy mode
Date: Thu,  6 Mar 2025 22:12:50 -0800
Message-ID: <20250307061250.320849-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250307061250.320849-1-namhyung@kernel.org>
References: <20250307061250.320849-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ian told me that there are many memory leaks in the hierarchy mode.  I
can easily reproduce it with the follwing command.

  $ make DEBUG=1 EXTRA_CFLAGS=-fsanitize=leak

  $ perf record --latency -g -- ./perf test -w thloop

  $ perf report -H --stdio
  ...
  Indirect leak of 168 byte(s) in 21 object(s) allocated from:
      #0 0x7f3414c16c65 in malloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:75
      #1 0x55ed3602346e in map__get util/map.h:189
      #2 0x55ed36024cc4 in hist_entry__init util/hist.c:476
      #3 0x55ed36025208 in hist_entry__new util/hist.c:588
      #4 0x55ed36027c05 in hierarchy_insert_entry util/hist.c:1587
      #5 0x55ed36027e2e in hists__hierarchy_insert_entry util/hist.c:1638
      #6 0x55ed36027fa4 in hists__collapse_insert_entry util/hist.c:1685
      #7 0x55ed360283e8 in hists__collapse_resort util/hist.c:1776
      #8 0x55ed35de0323 in report__collapse_hists /home/namhyung/project/linux/tools/perf/builtin-report.c:735
      #9 0x55ed35de15b4 in __cmd_report /home/namhyung/project/linux/tools/perf/builtin-report.c:1119
      #10 0x55ed35de43dc in cmd_report /home/namhyung/project/linux/tools/perf/builtin-report.c:1867
      #11 0x55ed35e66767 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:351
      #12 0x55ed35e66a0e in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:404
      #13 0x55ed35e66b67 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:448
      #14 0x55ed35e66eb0 in main /home/namhyung/project/linux/tools/perf/perf.c:556
      #15 0x7f340ac33d67 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
  ...

  $ perf report -H --stdio 2>&1 | grep -c '^Indirect leak'
  93

I found that hist_entry__delete() missed to release child entries in the
hierarchy tree (hroot_{in,out}).  It needs to iterate the child entries
and call hist_entry__delete() recursively.

After this change:

  $ perf report -H --stdio 2>&1 | grep -c '^Indirect leak'
  0

Reported-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2) Use rbtree_postorder_for_each_entry_safe()  (Ian)

 tools/perf/util/hist.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index fbf131aeae7ffe9b..d65228c1141251fb 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1385,6 +1385,16 @@ void hist_entry__delete(struct hist_entry *he)
 {
 	struct hist_entry_ops *ops = he->ops;
 
+	if (symbol_conf.report_hierarchy) {
+		struct rb_root *root = &he->hroot_out.rb_root;
+		struct hist_entry *child, *tmp;
+
+		rbtree_postorder_for_each_entry_safe(child, tmp, root, rb_node)
+			hist_entry__delete(child);
+
+		*root = RB_ROOT;
+	}
+
 	thread__zput(he->thread);
 	map_symbol__exit(&he->ms);
 
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

