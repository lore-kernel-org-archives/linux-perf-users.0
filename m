Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F313E1FF7C2;
	Tue, 29 Oct 2024 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730230146; cv=none; b=IwFkLXgsKOyplqtKqvxFkWW7dMNM3e6OL0mvUTBpkMwN/xGrqVcGFueoc9x4uQQEB5vcMzVScLqBbCgrMTvDwnNGBP/D0QCJJxORaWZ6JsSFUxWzkcpF8LWo9so37KJw+kD36hLAk8kUylf9nphGlKRJsOKX5vH1N+2vgd9sK/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730230146; c=relaxed/simple;
	bh=HOB+KSzpRb8gsJms7HlIvIrtCFgY5v/fQLYW50/LoLM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TIwKvOr655NEsLuy9+RDkL7SFkEqeUUEgMaZo+HkaMo3RON1f1t7A2kPnoi2qG2lQn+84QTT613Er7C5LaEgMHE8kQ2EKeM+QkT1oul4UIUUOePMONQ+rZ4SIpDjFF0h3lXfrzvae8B0oTTUDZUaGQTUhZQV5WGE+btLOBBaAGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhiUsBgP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhiUsBgP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763E4C4CECD;
	Tue, 29 Oct 2024 19:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730230145;
	bh=HOB+KSzpRb8gsJms7HlIvIrtCFgY5v/fQLYW50/LoLM=;
	h=Date:From:To:Cc:Subject:From;
	b=DhiUsBgPfWmtZwVxlAH0NMNtAb3M6mHIEDR2HAN47UAbtiPGg3TrXXsgL+UcPqOXa
	 eBK9mQuiNAheXmF4xG0lF4YYgxXE1YPZlS0km18NW9wU/xKy7kMLoDyvykqdD+ASTT
	 YiNbatrrkShdCu7FGlAOWeZRC1R14P0bRKgOf8EgDS5nteqYdLO2R8ydE5c1JOW+C2
	 SSwgYOZxExSWPPOGJSemoUvwpghP4Xn4zI5PUVEgyHsYXMFnYGxGVS+hjRcwm1s/6+
	 vIh5ShYgRvKBaw+8plnQOjyleLbM9peRlElp7QQwzBfVUHc8LYk+5rddZvhLyp2RaH
	 U/oW2YXj11IYg==
Date: Tue, 29 Oct 2024 16:29:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 perf-tools-next] perf ftrace latency: Fix unit on
 histogram first entry when using --use-nsec
Message-ID: <ZyE3frB-hMXHCnMO@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The use_nsec arg wasn't being taken into account when printing the first
histogram entry, fix it:

  root@number:~# perf ftrace latency --use-nsec -T switch_mm_irqs_off -a sleep 2
  #   DURATION     |      COUNT | GRAPH                                          |
       0 - 1    us |          0 |                                                |
       1 - 2    ns |          0 |                                                |
       2 - 4    ns |          0 |                                                |
       4 - 8    ns |          0 |                                                |
       8 - 16   ns |          0 |                                                |
      16 - 32   ns |          0 |                                                |
      32 - 64   ns |        125 |                                                |
      64 - 128  ns |        335 |                                                |
     128 - 256  ns |       2155 | ####                                           |
     256 - 512  ns |       9996 | ###################                            |
     512 - 1024 ns |       4958 | #########                                      |
       1 - 2    us |       4636 | #########                                      |
       2 - 4    us |       1053 | ##                                             |
       4 - 8    us |         15 |                                                |
       8 - 16   us |          1 |                                                |
      16 - 32   us |          0 |                                                |
      32 - 64   us |          0 |                                                |
      64 - 128  us |          0 |                                                |
     128 - 256  us |          0 |                                                |
     256 - 512  us |          0 |                                                |
     512 - 1024 us |          0 |                                                |
       1 - ...  ms |          0 |                                                |
  root@number:~#

After:

  root@number:~# perf ftrace latency --use-nsec -T switch_mm_irqs_off -a sleep 2
  #   DURATION     |      COUNT | GRAPH                                          |
       0 - 1    ns |          0 |                                                |
       1 - 2    ns |          0 |                                                |
       2 - 4    ns |          0 |                                                |
       4 - 8    ns |          0 |                                                |
       8 - 16   ns |          0 |                                                |
      16 - 32   ns |          0 |                                                |
      32 - 64   ns |         19 |                                                |
      64 - 128  ns |         94 |                                                |
     128 - 256  ns |       2191 | ####                                           |
     256 - 512  ns |       9719 | ####################                           |
     512 - 1024 ns |       5330 | ###########                                    |
       1 - 2    us |       4104 | ########                                       |
       2 - 4    us |        807 | #                                              |
       4 - 8    us |          9 |                                                |
       8 - 16   us |          0 |                                                |
      16 - 32   us |          0 |                                                |
      32 - 64   us |          0 |                                                |
      64 - 128  us |          0 |                                                |
     128 - 256  us |          0 |                                                |
     256 - 512  us |          0 |                                                |
     512 - 1024 us |          0 |                                                |
       1 - ...  ms |          0 |                                                |
  root@number:~#

Fixes: 84005bb6148618cc ("perf ftrace latency: Add -n/--use-nsec option")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index abcdc49b7a987f82..272d3c70810e7dc3 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -815,7 +815,7 @@ static void display_histogram(int buckets[], bool use_nsec)
 
 	bar_len = buckets[0] * bar_total / total;
 	printf("  %4d - %-4d %s | %10d | %.*s%*s |\n",
-	       0, 1, "us", buckets[0], bar_len, bar, bar_total - bar_len, "");
+	       0, 1, use_nsec ? "ns" : "us", buckets[0], bar_len, bar, bar_total - bar_len, "");
 
 	for (i = 1; i < NUM_BUCKET - 1; i++) {
 		int start = (1 << (i - 1));
-- 
2.47.0

