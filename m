Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB9338DFC
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Feb 2024 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485463; cv=none; b=hF9CcWtaLrGWvWAWJhtCXp5YZHbETPLOc7Fr1/GRBvqargyIgcVe1IQ0ah4uXHFKHbIu4Z88jXQAZ+MczyRC59qOr576uq2NQvZlBqdWwxhPWieBX2tnH3/ZZoN8Xd/NfT2ZQwkbI43TIunUIoBl9a9SOdvbJ4avTDENhQ+bZZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485463; c=relaxed/simple;
	bh=X9UT23q4jflkYNhET07+FdpL5S54z51fN49J+4SxEUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjae5hQOBa9HlKtW5jhNmtrC305tpdn7HyzhypHDRtEO1zwjwjschettWtv6SKcqt2aGhGqOeYzf+ustUK1cTGBLV2lhVMdYg99xjRqL8jibBoGjczWA8lcKzxAWB9m6qTwl2Y71jOdd9vOypmyvF5NteBPcF1bB5FbgSpz6trM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgTGY6KH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgTGY6KH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719A2C433C7;
	Fri,  9 Feb 2024 13:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707485463;
	bh=X9UT23q4jflkYNhET07+FdpL5S54z51fN49J+4SxEUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dgTGY6KHc0t2ujqtvx1VUkw+ZAL4tnKzGVVfwWFQdWAe/BrARQhbei9BsPWUOoTOu
	 hxsms5E4np8/AQJkVhqigmstU5qPI3yiuKY1JL+KNYmWj2fuJWRpiLjibdwBNPSy60
	 CqyS/DYJFdmSYoZH6NJ8q9R5VKs2sII8whrE3A2ZHepin8kQzuV8ynQhyNdBCG76oq
	 FTzeFUtjSLnmZDz8z2Cd7TdllOth6m9pNwCRbfHdUu8C/Lr9IkQI8CrA4pcdZ3fDcc
	 J0n/vmcFyyQkqoO7/+0YGSX/hHsPAdWX9837sYckuNs7+0zIKRYxzsdPSv+TS/qnvj
	 dHijDrPzwHbCw==
Date: Fri, 9 Feb 2024 10:30:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Yicong Yang <yangyicong@huawei.com>,
	will@kernel.org, john.g.garry@oracle.com, james.clark@arm.com,
	mike.leach@linaro.org, leo.yan@linaro.org, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, jonathan.cameron@huawei.com,
	hejunhao3@huawei.com, prime.zeng@hisilicon.com,
	yangyicong@hisilicon.com, linuxarm@huawei.com
Subject: Re: [PATCH v2] perf stat: Enable iostat mode for HiSilicon PCIe PMU
Message-ID: <ZcYpE35VxRClBP_W@x1>
References: <20240208032518.25830-1-yangyicong@huawei.com>
 <CAM9d7cga2rzcpUCa+5sZKQ3g_nC5=5XhSdkX1bRCQQUJca8uSw@mail.gmail.com>
 <4688a613-c94a-49b0-9d0f-09173c64082d@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4688a613-c94a-49b0-9d0f-09173c64082d@arm.com>

On Fri, Feb 09, 2024 at 10:59:04AM +0000, Robin Murphy wrote:
> On 2024-02-08 11:58 pm, Namhyung Kim wrote:
> > On Wed, Feb 7, 2024 at 7:29 PM Yicong Yang <yangyicong@huawei.com> wrote:
> > > From: Yicong Yang <yangyicong@hisilicon.com>
> > > Some HiSilicon platforms provide PCIe PMU devices for monitoring the
> > > throughput and latency of PCIe traffic. With the support of PCIe PMU
> > > we can enable the perf iostat mode.

> > Hmm.. so it only works for HiSilicon.  What if users run it on a different
> > platform?
 
> Same thing as if they run it on an AMD or older Intel platform ;)
 
> >  I think ARM should care about this.
 
> Arm don't make PCIe root ports, and there is no PMU standardisation between
> all the myriad different implementers and vendors of PCIe IP, so the best
> perf can reasonably do is simply support the particular PMUs that people
> want perf to support.

yeah, that will make perf more useful to more people, which is good.

And it is reusing something we did in the past for a similar mode on
Intel, from what I remember and by looking at:

---------------------------
commit f9ed693e8bc0e7de9eb766a3c7178590e8bb6cd5
Author: Alexander Antonov <alexander.antonov@linux.intel.com>
Date:   Mon Apr 19 12:41:46 2021 +0300

    perf stat: Enable iostat mode for x86 platforms

    This functionality is based on recently introduced sysfs attributes for
    Intel® Xeon® Scalable processor family (code name Skylake-SP):

    Commit bb42b3d39781d7fc ("perf/x86/intel/uncore: Expose an Uncore unit to IIO PMON mapping")

    Mode is intended to provide four I/O performance metrics in MB per each
    PCIe root port:

     - Inbound Read: I/O devices below root port read from the host memory
     - Inbound Write: I/O devices below root port write to the host memory
     - Outbound Read: CPU reads from I/O devices below root port
     - Outbound Write: CPU writes to I/O devices below root port

    Each metric requiries only one uncore event which increments at every 4B
    transfer in corresponding direction. The formulas to compute metrics
    are generic:
        #EventCount * 4B / (1024 * 1024)
---------------------------

And tools/perf/perf-iostat.sh.

Right?

- Arnaldo
