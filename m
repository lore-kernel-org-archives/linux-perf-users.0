Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C132F069E
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Oct 2025 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759909947; cv=none; b=sIA1ocUvKRqRN2JkjbpgGuoyvqrqgeN9GQNvMxQTmENCfwSXccFZX4Qf0d6URu/sTRPxHBSBwmbdak0QZjDOjSfh1iIaG9UXaxuJJqRoaH4vbF59vtHCrib0aqxxIAHIrUQQR5iNiKUY1fp0t2BohepnYZO2XW6058bxEWrmo+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759909947; c=relaxed/simple;
	bh=G0cbNSyBpXYxRhOXDRje58RJjj/D6lOV3JI1waB5eCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzyRibGSnkrAOznWIOT62RIyr9HD7uz3y+cKb8dhtTn9wGqeF5CQHuhPDUaPRMi8RFVdnQN4oSfmrSILta7faIvDvJhfFF/p+jldsmkGX8fULkZ5m672k9IKAR3FHOlLZEfte2H8dY2SkD8m19GDYmg5EPdoE1o4jNXi6oiJ1vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1tiRUv6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1tiRUv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36050C4CEF9;
	Wed,  8 Oct 2025 07:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759909947;
	bh=G0cbNSyBpXYxRhOXDRje58RJjj/D6lOV3JI1waB5eCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1tiRUv65mLXZbrlqGSetGJnHy+dB7mbQ59ivM/xlLnxM3/1pprgqwU2gRqtF3f2K
	 tw8Z7G26w3J96VWGWQB4RPfnA9Phydn1ixkBElqUzFcU86Ihl+qnbS4S/MtSXb/Vwp
	 zaW8ofY81AtnT5Fa1epTvL1Ci0DAQ3TTj6VtZlUIb/paeTy+/yL5j4EnAG8F6bK7l6
	 PCGlMniQNMhLfwHboxLvaIfSHbO11Ua5qMkHrlCbGnBFrpvROGRpiQWr5zpcSy3GHv
	 RLIrtwCLfYAr8M2jLLAFuxxtiSMwaCsI6Drj6loJR+bIM01ey6jowo/Bu+blR8hC74
	 w2lpcM1nME/gQ==
Date: Wed, 8 Oct 2025 16:52:21 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Anubhav Shelat <ashelat@redhat.com>, mpetlan@redhat.com,
	acme@kernel.org, irogers@google.com,
	linux-perf-users@vger.kernel.org, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	dapeng1.mi@linux.intel.com
Subject: Re: [PATCH] perf tests record: allow for some difference in cycle
 count in leader sampling test on aarch64
Message-ID: <aOYYNb98V2eL0QK6@google.com>
References: <20251001195047.541745-2-ashelat@redhat.com>
 <906a9e47-ec19-4897-bbc0-06101d7afd24@linux.ibm.com>
 <CA+G8DhL49FWD47bkbcXYeb9T=AbxNhC-ypqjkNxRnW0JqmYnPw@mail.gmail.com>
 <901d2d1d-647a-4a76-a0ee-d8a687ed3f85@linux.ibm.com>
 <ff157071-e241-4b81-8241-cfd15e5705ef@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff157071-e241-4b81-8241-cfd15e5705ef@linaro.org>

Hello,

On Tue, Oct 07, 2025 at 01:34:46PM +0100, James Clark wrote:
> 
> 
> On 07/10/2025 6:47 am, Thomas Richter wrote:
> > On 10/2/25 15:39, Anubhav Shelat wrote:
> > > On Oct 1, 2025 at 9:44 PM, Ian Rogers wrote:
> > > > If cycles is 0 then this will always pass, should this be checking a
> > > range?
> > > 
> > > Yes you're right this will be better.
> > > 
> > > On Oct 2, 2025 at 7:56 AM, Thomas Richter wrote:
> > > > Can we use a larger range to allow the test to pass?
> > > 
> > > What range do you get on s390? When I do group measurements using "perf
> > > record -e "{cycles,cycles}:Su" perf test -w brstack" like in the test I
> > > always get somewhere between 20 and 50 cycles difference. I haven't tested
> > > on s390x, but I see no cycle count difference when testing the same command
> > > on x86. I have observed much larger, more varied differences when using
> > > software events.
> > > 
> > > Anubhav
> > > 
> > 
> > Here is the output of the
> > 
> >   # perf record  -e "{cycles,cycles}:Su" -- ./perf test -w brstack
> >   # perf script | grep brstack
> > 
> > commands:
> > 
> > perf 1110782 426394.696874:    6885000 cycles:           116fc9e brstack_bench+0xae (/r>
> > perf 1110782 426394.696875:    1377000 cycles:           116fb98 brstack_foo+0x0 (/root>
> > perf 1110782 426394.696877:    1377000 cycles:           116fb48 brstack_bar+0x0 (/root>
> > perf 1110782 426394.696878:    1377000 cycles:           116fc94 brstack_bench+0xa4 (/r>
> > perf 1110782 426394.696880:    1377000 cycles:           116fc84 brstack_bench+0x94 (/r>
> > perf 1110782 426394.696881:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
> > perf 1110782 426394.696883:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
> > perf 1110782 426394.696884:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
> > perf 1110782 426394.696885:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
> > perf 1110782 426394.696887:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
> > perf 1110782 426394.696888:    1377000 cycles:           116fc98 brstack_bench+0xa8 (/r>
> > perf 1110782 426394.696890:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
> > perf 1110782 426394.696891:    1377000 cycles:           116fc9e brstack_bench+0xae (/r>
> > perf 1110782 426394.703542:    1377000 cycles:           116fb7c brstack_bar+0x34 (/roo>
> > perf 1110782 426394.703542:   30971975 cycles:           116fb7c brstack_bar+0x34 (/roo>
> > perf 1110782 426394.703543:    1377000 cycles:           116fc76 brstack_bench+0x86 (/r>
> > perf 1110782 426394.703545:    1377000 cycles:           116fc06 brstack_bench+0x16 (/r>
> > perf 1110782 426394.703546:    1377000 cycles:           116fc9e brstack_bench+0xae (/r>
> > perf 1110782 426394.703547:    1377000 cycles:           116fc20 brstack_bench+0x30 (/r>
> > perf 1110782 426394.703549:    1377000 cycles:           116fc9e brstack_bench+0xae (/r>
> > perf 1110782 426394.703550:    1377000 cycles:           116fcbc brstack_bench+0xcc
> > 
> > They are usual identical values beside one or two which are way off. Ignoring those would
> > be good.
> > 
> 
> FWIW I ran 100+ iterations my Arm Juno and N1SDP boards and the test passed
> every time.
> 
> Are we sure there isn't some kind of race condition or bug that the test has
> found? Rather than a bug in the test?

I suspect this too.

> 
> At least "This looks like the result of some hardware property of aarch64
> processors" in the commit message can't be accurate as this isn't the case
> everywhere.

I guess this depends on hardware capability to start/stop the PMU globally
rather than doing it for each counter.

Maybe we can have two set of checks depends on the hardware.  For
example, we keep the existing test on x86 (and selected ARM machines?)
and add a range test for others.  It'd be great if the kernel could
expose that information to userspace.

Thanks,
Namhyung

