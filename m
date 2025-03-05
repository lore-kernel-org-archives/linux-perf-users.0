Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB442045AC;
	Wed,  5 Mar 2025 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741166816; cv=none; b=sdI1eWw/QcLnF1WdaVZqjUKoVkosJbRrrAV9kgwVeG2+28S5274WAbEbxa8yE+gIdkSFq3xtyd+7q96xzegJYy+NqSgdkYqbp6Og/lkVyGk3PcPtJHSGAZ0m9B181GYGhYxDtordqbBSyZ2o85agnwILCclAHIgpxEpzOVdmKkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741166816; c=relaxed/simple;
	bh=b4Szx6wCBHun8gol4ce0yFWCaLJ+iO99aifcOuewJAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SodDlJv3tmdjMtrm6jtpp3mkzkN/5ncS2nIoijklOeYmaNg22QciS81CXsYBNDTmmS4jzJkkYLqCIx/HVJs2PXUDQhsbq5BYzAX6FwBEmicj0smfmRxT+4YjUfKQ+rwaMJrqTo505uDw/TKv7trb5cgSXfVYzalL3R2Tbzj7uX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9505FEC;
	Wed,  5 Mar 2025 01:27:07 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE6133F66E;
	Wed,  5 Mar 2025 01:26:53 -0800 (PST)
Date: Wed, 5 Mar 2025 09:26:49 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] perf list: Collapse similar events across PMUs
Message-ID: <20250305092649.GC13418@e132581.arm.com>
References: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org>

On Tue, Mar 04, 2025 at 01:49:12PM +0000, James Clark wrote:

[...]

> As some background, the original commit for deduplication, commit
> 3241d46f5f54 ("perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu")
> mentions reducing the number of duplicate PMUs, and is presumably
> motivated by usability. But there are also other commits mentioning
> reducing openat()s, for example lazily loading formats 504026412162
> ("perf pmu: Make the loading of formats lazy"). Deduplicating based on
> the contents of the events/ folder is somewhat in contention with this
> reduction, but could be done along side some more lazy loading (like of
> the terms) and hashing the result of readdir() without opening any of
> the contents. JSON tables can have event name hashes calculated at build
> time if we want to consider them for deduplication too.
> 
> Then with the events hash, PMU's can be sorted based on this and the
> 'Unit:' string can be constructed with a set of values that collapses
> adjacent suffixes to display as ranges. I believe that could remove the
> need for any further changes to duplication based on suffix, but still
> avoids over deduplication.

I did a test with a simulated platform with cortex-a510 and cortex-a710
cores, the result looks correct to me:

  # perf list -d 2>&1 | grep br_mis_pred_retired -A 2
  br_mis_pred_retired
       [Instruction architecturally executed,mispredicted branch. Unit:
        armv9_cortex_a510,armv9_cortex_a710]

Tested-by: Leo Yan <leo.yan@arm.com>

However, I will have minor comments on two patches and reply
separately.  Please take a look.

Thanks,
Leo
