Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53A81A5B86;
	Fri,  7 Mar 2025 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741334911; cv=none; b=eWMNnZW4mJhGEU77mtpOBYs9qSc+b51FxRN2842FnmhE2RFvz45hrm6eQjNTghvODWUss+T7R3Kq1kHsksnzopaYa5sbRxDxY/kEyeuq0XCj02tFiR0KEG/TR9NXYAHnkdljB3WVki4okXnLvusGidrBUWaaXJdSS8IgPsdzc4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741334911; c=relaxed/simple;
	bh=xi2C9i3vt9fDKSf6b4tkkh3AN+9bjq/2yLoVS1c8XSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSDe1qSbGCRIHEJNYX91Bhy8RNc8za+rQkctf2mHyCfPEXfFZ+vy4YJQCU/iri8VZuBHMibGbuOxV6l4nC8T8FdMgoOTb43L4CZtFdJ3UiYsk8VR8Q+FzH5tDiEI9GirNlZVE5Q26f2jaOdF8PTvj+QCPHkGED3cUmza1JskoDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxr/fZso; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxr/fZso"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F61C4CEE2;
	Fri,  7 Mar 2025 08:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741334911;
	bh=xi2C9i3vt9fDKSf6b4tkkh3AN+9bjq/2yLoVS1c8XSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rxr/fZso73M+pjk7xsVSxgDoEYAY6JtnEmi0Xx3zhArewmgBnIYP/n+W1cAwUBWBr
	 DLgfuQS2edHJdw9h60yczac+nRZM1AvLb3HRCEcJXQB7mxU6EFPuvQThBRwEaPeNYz
	 Qhvx5D1NLpCZ1rlm/stk/kbfCz6ANF+nXVNTbdRSsI95EGBTXvwA36gvwrI9XX8YE4
	 UkQVpwIen5hE2v/6uKNSpRFS+AZV9eWHsRKi+VlIs9GZpET2Z0m0A+2RRm90jhikJZ
	 pUeQcq30n6k1WkRl3fxEc8mLQC2vkeC7Cse7OEYID+8M0s5MxRklHISooMsTv9n/Fo
	 Z0L+u0Rs9XXXw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH 2/3] perf report: Allow hierarchy mode for --children
Date: Fri,  7 Mar 2025 00:08:28 -0800
Message-ID: <20250307080829.354947-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250307080829.354947-1-namhyung@kernel.org>
References: <20250307080829.354947-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was prohibited because the output fields in the children mode were
not handled properly with hierarchy.  But we can have the output fields
in the same level, it can allow them together.

For example, latency mode adds more output fields by default and now
they are displayed properly.

  $ perf record --latency -g -- perf test -w thloop

  $ perf report -H --stdio
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 2K of event 'cycles:Pu'
  # Event count (approx.): 8266456478
  #
  #       Children  Latency  Overhead   Latency  Command / Shared Object / Symbol
  # ...........................................  ........................................................
  #
       0.08%    0.16%   100.00%   100.00%        perf
          0.08%    0.16%     0.24%     0.47%        ld-linux-x86-64.so.2
             0.12%    0.24%     0.12%     0.24%        [.] _dl_relocate_object
             0.08%    0.16%     0.08%     0.16%        [.] _dl_lookup_symbol_x
             0.03%    0.06%     0.03%     0.06%        [.] strcmp
             0.00%    0.01%     0.00%     0.01%        [.] _dl_start
             0.00%    0.00%     0.00%     0.00%        [.] _dl_start_user
             0.00%    0.00%     0.00%     0.00%        [.] _dl_sysdep_start
             0.00%    0.00%     0.00%     0.00%        [.] _start
             0.00%    0.00%     0.00%     0.00%        [.] dl_main
          0.03%    0.06%     0.03%     0.06%        libLLVM-16.so.1
             0.03%    0.06%     0.03%     0.06%        [.] llvm::StringMapImpl::RehashTable(unsigned int)
             0.00%    0.00%     0.00%     0.00%        [.] 0x00007f137ccd18e8
          0.00%    0.00%    99.66%    99.31%        perf
            99.66%   99.31%    99.66%    99.31%        [.] test_loop
              |
              |--49.86%--0x7f137b633d68
              |          0x55dbdbbb7d2c
              ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-report.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index c1226da6c610258f..fc776e9d7fdfa273 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1673,8 +1673,6 @@ int cmd_report(int argc, const char **argv)
 
 	if (symbol_conf.report_hierarchy) {
 		/* disable incompatible options */
-		symbol_conf.cumulate_callchain = false;
-
 		if (field_order) {
 			pr_err("Error: --hierarchy and --fields options cannot be used together\n");
 			parse_options_usage(report_usage, options, "F", 1);
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

