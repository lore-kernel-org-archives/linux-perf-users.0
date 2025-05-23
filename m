Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AB5214209;
	Fri, 23 May 2025 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748038919; cv=none; b=ediDZBDWc4JXHa96Vi1ScXBGzc8pNVLiyXyFNxuWqBawHmjVRU3RCaER8Mxw8PFFgXdy5COa20VXVU4pxubPHMPJRXcZF4/4PEhh/fWvd5t1Et1UsrbBsi7I8IZufA+9nKUSOkNwazYebSVvxGcaEAiDAHmgJ6wTED6vRBca4jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748038919; c=relaxed/simple;
	bh=zxitASd+O6SYq9RsPDNfexVCOfAcsttgQPgvZjKB8XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qX578PVOWP78E31nOr8kIYOWwioEAPYmYaWBSMF7N6P5IrNQDxV0HyzH30SIahGo/ZrorIuugpOzH37f13KrkX7Gg9fqtEaitsXv/D3tbPLp1XO9Ax41fYTqzXoDlPLws4E9RnSn4cqPBKYiIBHtuhqIeBJjiPF8T8hyava52wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWg4ZKLj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWg4ZKLj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BA2C4CEF6;
	Fri, 23 May 2025 22:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748038919;
	bh=zxitASd+O6SYq9RsPDNfexVCOfAcsttgQPgvZjKB8XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rWg4ZKLjVXdNJKGmX4m0YMfJCU7Pk1m5aMhJwrZ5VnE+1IefMp5lMvZkkzKyfsa9D
	 0Rpk8HhQXGKj3U3et+s7ZClBQgbfDZyrvorl0+1hNXVpJ9bVLTKgU6IPPETJZNmd2G
	 ZZ7Q9sd6QZVUAUi58vubUmLoB+XHmBNJjjo3g61IcjTj5HhaJ3f6XRHJPOsa2JvY0n
	 aSzM6Bvq6K0OhUmC/T8yrdLIF8OTIOQ+MhsXvN5Hn/xw/BsIjjCbf20d6tFeEp9br6
	 rp//S7FRWQlXEERsCCqulH92fyC50q7O2D9rkCysKVr9xzEjYr2x3g25riKg6VjrNY
	 YVYOZ2rGHLAXA==
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
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Leo Yan <leo.yan@arm.com>,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 3/3] perf mem: Show absolute percent in mem_stat output
Date: Fri, 23 May 2025 15:21:57 -0700
Message-ID: <20250523222157.1259998-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523222157.1259998-1-namhyung@kernel.org>
References: <20250523222157.1259998-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the output sums up to 100% for each entry.  But it can be
confusing when it's displayed with 'overhead'.

Before:
  $ perf mem report -F overhead,sample,cache,comm
  ...
  #                         -------------- Cache --------------
  # Overhead       Samples       L1     L2     L3 L1-buf  Other  Command
  # ........  ............  ...................................  ...............
  #
      25.38%           517    34.6%   0.0%  15.8%  23.3%  26.2%  swapper
       9.03%           239    35.4%   0.8%   9.1%  22.1%  32.6%  chrome
       8.61%           233    45.3%   1.2%   8.9%  22.7%  21.9%  Chrome_ChildIOT
       7.81%           189    33.6%   0.4%   5.5%  35.9%  24.6%  Isolated Web Co
       3.73%           103    40.4%   0.3%   2.7%  39.4%  17.2%  gnome-shell

Let's convert it to use absolute percent value so that it can add up to
the overhead for that entry.

After:
  #                         -------------- Cache --------------
  # Overhead       Samples       L1     L2     L3 L1-buf  Other  Command
  # ........  ............  ...................................  ...............
  #
      25.38%           517     8.8%   0.0%   4.0%   5.9%   6.7%  swapper
       9.03%           239     3.2%   0.1%   0.8%   2.0%   2.9%  chrome
       8.61%           233     3.9%   0.1%   0.8%   2.0%   1.9%  Chrome_ChildIOT
       7.81%           189     2.6%   0.0%   0.4%   2.8%   1.9%  Isolated Web Co
       3.73%           103     1.5%   0.0%   0.1%   1.5%   0.6%  gnome-shell

This aligns well with the existing 'mem' sort key.

  $ perf mem report -s comm,mem -H
  ...
  #
  #    Overhead       Samples  Command / Memory access
  # .........................  ..........................................
  #
      25.38%           517     swapper
          8.78%           150     L1 hit
          6.66%            72     RAM hit
          5.92%           137     LFB/MAB hit
          4.02%           157     L3 hit
          0.00%             1     L3 miss
       9.03%           239     chrome
          3.19%           117     L1 hit
          2.94%            35     RAM hit
          1.99%            48     LFB/MAB hit
          0.82%            32     L3 hit
          0.08%             5     L2 hit
          0.00%             2     L3 miss

We can add an option or a config to change the setting later.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index ed5c40ebd906f076..b085eb0de84997f4 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -172,7 +172,7 @@ int hpp__fmt_mem_stat(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *
 	assert(mem_stat_idx != -1);
 
 	for (int i = 0; i < MEM_STAT_LEN; i++)
-		total += he->mem_stat[mem_stat_idx].entries[i];
+		total += hists->mem_stat_total[mem_stat_idx].entries[i];
 	assert(total != 0);
 
 	for (int i = 0; i < MEM_STAT_LEN; i++) {
-- 
2.49.0.1151.ga128411c76-goog

