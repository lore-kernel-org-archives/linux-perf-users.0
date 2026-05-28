Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E3F2EFD9B;
	Thu, 28 May 2026 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779995881; cv=none; b=CXc+F8djlXOSCOx7u3Ok6K9ht0bU5s9xsa864Kir1jcq270BTBvLJERM4mUli2WYamB+PGE0F1uXBl8sAZSa+SrtZNBaSZb7eIR3p+nf6zcbKxN4RiQ9ZUSqtPLTppxrJ0rR3gZ47CljM8s8P40Ao0jAcVxb/oUIkc/xRU039Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779995881; c=relaxed/simple;
	bh=kKMOHKRwqdeiHQoAfNXEJVaecPtX8B9m5aMmpfkepNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuIhLC/GdWDKenAlnbZQmPhVDvjz69aPSruMZa9nnAAmDa86t981qVuGZthYGHDb5XtYr7jpnrlQ8Ea6kmbKUqa35k9nQ/B57lqTuTptI8RwV0kOHhYfd1jUz2fMhfq+JdLGaWA+7tErTEO0hMQf0bXPegfldlPJblzrvsUvSmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VA4YtxXI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VA4YtxXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3102D1F000E9;
	Thu, 28 May 2026 19:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779995879;
	bh=6LPmsJoR/RiSByAYjB1GPYLlV/Br1pxUt/KKURJ7FkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VA4YtxXIgVoVWh2GgxrUNDCtKdKFyizCo0zu23+v3KGzd+gtSMBe6uCDEqCA9Dgt0
	 1QCwh+uUXqr9cjM5hqeY4rIpS919nKKGqNAEbTNNNejCSkBYAEILQSyiSheG4DSvqb
	 EMp09uAUjAEcT6/MxjQUwz32TPpDTdR/aMpAFIrjlZTN6CWrgMAMtKgoTFrzAsB+/j
	 6Q7MPTbgFAj1gpo8a0g2R97w+5nhjlKd17OhPNHp0kUjoSer/35OYUkRY535CgkDVV
	 QsTNQnxpARPavdK6aj52CldswsApbygksOQ7UV28C5JdRmMogjDwzxatDXpx71xnrW
	 zASNQZ5Iy17JQ==
Date: Thu, 28 May 2026 12:17:57 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	james.clark@linaro.org, sandipan.das@amd.com, leo.yan@arm.com,
	thomas.falcon@intel.com, yang.lee@linux.alibaba.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] perf stat: Fix uncore metric scaling across
 aggregation modes
Message-ID: <ahiU5Te_KR7KRI9Z@google.com>
References: <20260521201505.124690-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260521201505.124690-1-ctshao@google.com>

On Thu, May 21, 2026 at 01:15:03PM -0700, Chun-Tse Shao wrote:
> This series fixes a scaling issue for metrics (like lpm_miss_lat) across
> different runtime aggregation modes.
> 
> Uncore metrics currently use `source_count` to scale events. However,
> `source_count` returns the total uncore unit count regardless of the
> selected aggregation mode. When evaluating metrics in different
> aggregation mode other than `--per-socket`, this incorrectly divides
> aggregated uncore events against the total uncore count rather than the
> uncores belonging to the aggregation, leading to wrong metric results.
> 
> To fix this, we:
> 1. Introduce the aggr_nr() keyword to the metric parser, which
> dynamically resolves to the active units in the current aggregation
> group (`gr->nr`).
> 
> 2. Update the python metrics to use `aggr_nr` instead of `source_count`,
> ensuring correct scaling across all runtime aggregation boundaries.
> 
> Before the fix (incorrect low latency in global mode):
>   $ perf stat -M lpm_miss_lat --metric-only -a -j -- sleep 1
>   {"ns  lpm_miss_lat_rem" : "122.8", "ns  lpm_miss_lat_loc" : "114.5"}
>   $ perf stat -M lpm_miss_lat --per-socket --metric-only -a -j -- sleep 1
>   {"socket" : "S0", "ns  lpm_miss_lat_rem" : "232.1", "ns  lpm_miss_lat_loc" : "278.2"}
>   {"socket" : "S1", "ns  lpm_miss_lat_rem" : "233.9", "ns  lpm_miss_lat_loc" : "257.5"}
> 
> After the fix (correct scaled latency in all aggregation modes):
>   $ perf stat -M lpm_miss_lat --metric-only -a -j -- sleep 1
>   {"ns  lpm_miss_lat_rem" : "231.7", "ns  lpm_miss_lat_loc" : "245.0"}
>   $ perf stat -M lpm_miss_lat --per-socket --metric-only -a -j -- sleep 1
>   {"socket" : "S0", "ns  lpm_miss_lat_rem" : "238.3", "ns  lpm_miss_lat_loc" : "249.4"}
>   {"socket" : "S1", "ns  lpm_miss_lat_rem" : "259.1", "ns  lpm_miss_lat_loc" : "253.1"}
> 
> v3:
>   Fixed based on Sashiko review:
>   - Removed the unnecessary, copied `redefined-builtin` pylint-disable
>     comment from `aggr_nr` definition inside `metric.py`.
> 
> v2: lore.kernel.org/20260521035941.3860145-1-ctshao@google.com
>   Fixed based on Sashiko review:
>   - Fixed `aggr_nr` setting when an uncore event fails to run
>     (counts.run == 0) to explicitly set it to 0 instead of defaulting to
>     1.
>   - Accumulated `aggr_nr` when multiple unmerged PMU events are
>     associated with the same metric ID to prevent incorrect scaling
>     across active sockets.
>   - Removed unused `List` import from `typing` in `intel_metrics.py`.
> 
> v1: lore.kernel.org/20260520180032.3045144-1-ctshao@google.com
> 
> Chun-Tse Shao (2):
>   perf stat: Add aggr_nr metric parser support
>   perf stat: Use aggr_nr scaling for Intel uncore miss latency metrics

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/pmu-events/intel_metrics.py |  6 +++---
>  tools/perf/pmu-events/metric.py        |  9 +++++++--
>  tools/perf/util/expr.c                 | 26 ++++++++++++++++++++++----
>  tools/perf/util/expr.h                 |  6 +++++-
>  tools/perf/util/expr.l                 |  1 +
>  tools/perf/util/expr.y                 | 24 +++++++++++++++++-------
>  tools/perf/util/stat-shadow.c          |  6 +++++-
>  7 files changed, 60 insertions(+), 18 deletions(-)
> 
> --
> 2.54.0.746.g67dd491aae-goog
> 
