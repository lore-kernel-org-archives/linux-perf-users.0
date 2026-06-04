Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA22225403;
	Thu,  4 Jun 2026 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580946; cv=none; b=DZ6H4Me5IoBo95iyKkinNq9t2/DcF5fUsj+M2uCILEmxtu4yESwKvewc1YEkMLpb15NPjikB8JNjqk5KNMClHUm85BJk9kP/OcnDN6yucZsaniKrSxTz5AaUOH+EIpfWYdn08t4Bhm0lT2c4p1JhxDoVNsRJ75KGGbTT3A6JS9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580946; c=relaxed/simple;
	bh=zvZ5o33Va276sQFe7QVX8cWnqDo/EBXJ1azrTCF0gUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mL/p8M64MmdNmfeOTpuviuUzIrbE/MvV6ZuhYEGo147oI7HT4dFSJ8OzHiRtEl8Vj/TBhWd4VVdE33QbK7+dqZDGS4G1LJAp0vka0XnDojlPiX9hnWRPyIK+bCuPLbEEnkq7f0m3Sbpy1r7RtdmeXhn9Q418fpwxxNShA57qq40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlVMAnfb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlVMAnfb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8631F00893;
	Thu,  4 Jun 2026 13:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780580945;
	bh=IbHJB9X04kdwmBvK0j1bE3YssO2Qn0uRP/tuiYOAjsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QlVMAnfbVRz6kMP70clDdJBUebWPWEbcHITXaUl0lzIICiK87j5CtKgkKS0wvqP8l
	 2G+6PSt9f2vQTISjVNB5aSQNOcUk4Efv3lVkClcbojJxFilRFVBH+E6bnfeMky10GY
	 1hx5iiGQ+p/UTXgSvGN22BpU/qfIduUNYYNAxVHsBiva7UF2Dp4m7f0C6DKfC+Kb/x
	 jUBXkcNtsGKGwAHkipA+qW4RjPBCrIxETcQ2WHrz6eyrOCbkDsfYlo5IDBepBOF5dz
	 fjixuwUURBPUt1QOAwP4SIyTusrn+vlE0jz6WO9WlZw9aaYlJdgOEV7j5OXjoHKDf3
	 LG12YGlYgpUvw==
Date: Thu, 4 Jun 2026 10:49:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
	sandipan.das@amd.com, leo.yan@arm.com, thomas.falcon@intel.com,
	yang.lee@linux.alibaba.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] perf stat: Fix uncore metric scaling across
 aggregation modes
Message-ID: <aiGCTTH1BKTdmlsG@x1>
References: <20260521201505.124690-1-ctshao@google.com>
 <ahiU5Te_KR7KRI9Z@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahiU5Te_KR7KRI9Z@google.com>

On Thu, May 28, 2026 at 12:17:57PM -0700, Namhyung Kim wrote:
> On Thu, May 21, 2026 at 01:15:03PM -0700, Chun-Tse Shao wrote:
> > This series fixes a scaling issue for metrics (like lpm_miss_lat) across
> > different runtime aggregation modes.
> > 
> > Uncore metrics currently use `source_count` to scale events. However,
> > `source_count` returns the total uncore unit count regardless of the
> > selected aggregation mode. When evaluating metrics in different
> > aggregation mode other than `--per-socket`, this incorrectly divides
> > aggregated uncore events against the total uncore count rather than the
> > uncores belonging to the aggregation, leading to wrong metric results.
> > 
> > To fix this, we:
> > 1. Introduce the aggr_nr() keyword to the metric parser, which
> > dynamically resolves to the active units in the current aggregation
> > group (`gr->nr`).
> > 
> > 2. Update the python metrics to use `aggr_nr` instead of `source_count`,
> > ensuring correct scaling across all runtime aggregation boundaries.
> > 
> > Before the fix (incorrect low latency in global mode):
> >   $ perf stat -M lpm_miss_lat --metric-only -a -j -- sleep 1
> >   {"ns  lpm_miss_lat_rem" : "122.8", "ns  lpm_miss_lat_loc" : "114.5"}
> >   $ perf stat -M lpm_miss_lat --per-socket --metric-only -a -j -- sleep 1
> >   {"socket" : "S0", "ns  lpm_miss_lat_rem" : "232.1", "ns  lpm_miss_lat_loc" : "278.2"}
> >   {"socket" : "S1", "ns  lpm_miss_lat_rem" : "233.9", "ns  lpm_miss_lat_loc" : "257.5"}
> > 
> > After the fix (correct scaled latency in all aggregation modes):
> >   $ perf stat -M lpm_miss_lat --metric-only -a -j -- sleep 1
> >   {"ns  lpm_miss_lat_rem" : "231.7", "ns  lpm_miss_lat_loc" : "245.0"}
> >   $ perf stat -M lpm_miss_lat --per-socket --metric-only -a -j -- sleep 1
> >   {"socket" : "S0", "ns  lpm_miss_lat_rem" : "238.3", "ns  lpm_miss_lat_loc" : "249.4"}
> >   {"socket" : "S1", "ns  lpm_miss_lat_rem" : "259.1", "ns  lpm_miss_lat_loc" : "253.1"}
> > 
> > v3:
> >   Fixed based on Sashiko review:
> >   - Removed the unnecessary, copied `redefined-builtin` pylint-disable
> >     comment from `aggr_nr` definition inside `metric.py`.
> > 
> > v2: lore.kernel.org/20260521035941.3860145-1-ctshao@google.com
> >   Fixed based on Sashiko review:
> >   - Fixed `aggr_nr` setting when an uncore event fails to run
> >     (counts.run == 0) to explicitly set it to 0 instead of defaulting to
> >     1.
> >   - Accumulated `aggr_nr` when multiple unmerged PMU events are
> >     associated with the same metric ID to prevent incorrect scaling
> >     across active sockets.
> >   - Removed unused `List` import from `typing` in `intel_metrics.py`.
> > 
> > v1: lore.kernel.org/20260520180032.3045144-1-ctshao@google.com
> > 
> > Chun-Tse Shao (2):
> >   perf stat: Add aggr_nr metric parser support
> >   perf stat: Use aggr_nr scaling for Intel uncore miss latency metrics
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
