Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D44C343D78;
	Thu, 20 Nov 2025 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763665709; cv=none; b=C5OTXocnkqihYqS98anlIp20pIW0ZxrkGdfV2g6M2kJImhNWzEtRZ8nJX9W46d5P7+adI9PtNVauHuYCfIzkDebkWIiOUC1sYMO+pCdSeTrvB0oj2PUp7FFaoxEumKEknMUMUTmJaXoe+OuxhVIq8SXjQL/1qfdgKolk/cZNOs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763665709; c=relaxed/simple;
	bh=Rzff4obSKFIdFUbYUl7nlWEtOy9EsXbK0dihW/9ge1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dh3ZNEfpxPSmFfMb1JxS1OD/Fd8gHq+TNqLhe+CVhWgbRUwztggbtZ0TaQ1UgIgIW0Mhe48J1VQDpGtyb8lFs/Sm/DsNrez9amJMDPabZyhuZlC1YnuNi2H0U3LmY6k/kPsJqC5bzWAg2tB9oM7ThyaMbnKIvrrqkCiweuMDBJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/pihGfp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/pihGfp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6666C4CEF1;
	Thu, 20 Nov 2025 19:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763665709;
	bh=Rzff4obSKFIdFUbYUl7nlWEtOy9EsXbK0dihW/9ge1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/pihGfpE+WDWvg09+bI4I6jqq+yaE6m+7kFHnw4SihrJ8+chjY0ImGAZ3wOD/uUj
	 /hyBcrcpc3F2SfGD3oBzZFC7Cbi+jdUhdgVtDchOmZc8lMkdX8VAH2l6Y0wwpCxwNO
	 egScqe/ZBphtm+ik4/dkKH3V/1eCreYRRwuUBkeMFV8t4Zvdqpjn1GdzEUVIAwWcNY
	 RUnCIbiIAvp6bYYhrLppaXvcuoEHnLV27EYjdTNo7JMJeECCJZfXcXwCMhk1Dr9zVS
	 3p5sVdkhX1/Ekt4+FQpROvJXX5iceZnKp8KDKxCZaZbk1KhPiMCFVa/v34mHQEwfhK
	 baEpSgligT/Zg==
Date: Thu, 20 Nov 2025 11:08:26 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	James Clark <james.clark@linaro.org>,
	Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH v1] perf test all metrics: Fully ignore Default metric
 failures
Message-ID: <aR9nKoW0f-gByJQc@google.com>
References: <20251119193047.2238095-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251119193047.2238095-1-irogers@google.com>

On Wed, Nov 19, 2025 at 11:30:47AM -0800, Ian Rogers wrote:
> Determine if a metric is default from `perf list --raw-dump $m` eg:
> ```
> $ perf list --raw-dump l1_prefetch_miss_rate
> Default4 l1_prefetch_miss_rate
> ```
> If a metric has "not supported" or "no supported events" then ignore
> these failures for default metrics. Tidy up the skip/fail messages in
> the output to make them easier to spot/read.
> 
> Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> Closes: https://lore.kernel.org/linux-perf-users/20251119104751.51960-1-tmricht@linux.ibm.com/
> Reported-by: Namhyung Kim <namhyung@kernel.org>
> Reported-by: James Clark <james.clark@linaro.org>
> Closes: https://lore.kernel.org/lkml/aRi9xnwdLh3Dir9f@google.com/
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks for the fix!

  $ sudo ./perf test -vv "all metrics"
  103: perf all metrics test:
  --- start ---
  test child forked, pid 3329979
  Testing CPUs_utilized
  Testing backend_cycles_idle
  [Ignored backend_cycles_idle] failed but as a Default metric this can be expected
  Performance counter stats for 'system wide': <not counted> cpu-cycles <not supported> stalled-cycles-backend 0.013059060 seconds time elapsed
  Testing branch_frequency
  Testing branch_miss_rate
  Testing cs_per_second
  Testing cycles_frequency
  Testing frontend_cycles_idle
  Testing insn_per_cycle
  Testing migrations_per_second
  Testing page_faults_per_second
  Testing stalled_cycles_per_instruction
  [Ignored stalled_cycles_per_instruction] failed but as a Default metric this can be expected
  Error: No supported events found. The stalled-cycles-backend event is not supported.
  Testing l1d_miss_rate
  Testing llc_miss_rate
  [Ignored llc_miss_rate] failed but as a Default metric this can be expected
  Error: No supported events found. The LLC-loads event is not supported.
  Testing dtlb_miss_rate
  Testing itlb_miss_rate
  Testing l1i_miss_rate
  Testing l1_prefetch_miss_rate
  [Ignored l1_prefetch_miss_rate] failed but as a Default metric this can be expected
  Performance counter stats for 'system wide': <not counted> L1-dcache-prefetches <not supported> L1-dcache-prefetch-misses 0.012868128 seconds time elapsed
  Testing branch_misprediction_ratio
  Testing all_remote_links_outbound
  Testing nps1_die_to_dram
  Testing all_l2_cache_accesses
  Testing all_l2_cache_hits
  Testing all_l2_cache_misses
  Testing ic_fetch_miss_ratio
  Testing l2_cache_accesses_from_l2_hwpf
  Testing l2_cache_misses_from_l2_hwpf
  Testing l3_read_miss_latency
  Testing l1_itlb_misses
  ---- end(0) ----
  103: perf all metrics test                                           : Ok

