Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D0D433BC;
	Fri, 26 Jul 2024 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722018291; cv=none; b=Tna23ePrgWj7kqI1Xh6iVF5GQgG14zIerGsNoKe9Ur2D0uMAdSPGEl1XAl+31Hd8RF/cwsSTsklQXxe3DBzlkfat4w9uoef+QYks6q60NjrHtzQFCud5TBZhXOsr0vb10GkG7CD+SxaXjQ0cTRmn8NkHubyIHRhwdpxNjFQ0gek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722018291; c=relaxed/simple;
	bh=k5tMgQfi5S8plCaAhprxt7aj5C3lBFAlnVawZx/cpNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6/aQ4ITFeqxeJo3XCY9fiAOg7mtNRVV5wzZTv0viMC6aQ/ujpud9dIV6FepiZ4tdDLZSqdsNwMKGg1yjOdTI632auln2dKyDxdhTbZ0S1Qk4wejU5+oA3Z3Hk20tz+yUQof63jQf+ZGgTUPZPLNHLi2tcXkANSZa1U/ud/JCB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9QHcBMq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9QHcBMq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434A0C32782;
	Fri, 26 Jul 2024 18:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722018290;
	bh=k5tMgQfi5S8plCaAhprxt7aj5C3lBFAlnVawZx/cpNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A9QHcBMqu5PorqprRI10mvFJ40S8XNya7SNqDCyVoMJVPTunz/NmNAXC5qeveFaMP
	 C7wugfcbVSjCewQmOcVVRZ2FLxx9UbsQWVb4MUbjIEuMisnTsTBuipRS8ny6EVmh8+
	 r0ti9AG97yqCWihfTFLPu9fgTfnMv8sYdcrPgnRSwLMyyinOoBKhvyEbQvskiDbi0b
	 e0smyRGu4w3lVD4Cjohgpu9Q8jc33vxq0raHc3uIolt2UwvTrOibLgnTz/N0yrnPOi
	 U47FEKNxAKRq3oi8kr2gL8538ktI+oeqWDBPgJZy7JsVx+7r7dXGX7nAsKuM5NRZsn
	 ND4UVQYksQznw==
Date: Fri, 26 Jul 2024 15:24:47 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V9 02/13] perf/core: Add aux_pause, aux_resume,
 aux_start_paused
Message-ID: <ZqPp72SgDJaAb5x0@x1>
References: <20240715160712.127117-1-adrian.hunter@intel.com>
 <20240715160712.127117-3-adrian.hunter@intel.com>
 <20240718093846.GJ26750@noisy.programming.kicks-ass.net>
 <14cd68b2-eeee-42e3-87a6-c12d3814bd51@intel.com>
 <20240718115126.GK26750@noisy.programming.kicks-ass.net>
 <20240718125849.GI28838@noisy.programming.kicks-ass.net>
 <ef63885b-f762-4398-beff-c695b24304e6@intel.com>
 <ZqO1gBIYnLiDpQWv@x1>
 <137068c0-442b-4aba-8950-67828a15cda2@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <137068c0-442b-4aba-8950-67828a15cda2@intel.com>

On Fri, Jul 26, 2024 at 07:00:55PM +0300, Adrian Hunter wrote:
> On 26/07/24 17:41, Arnaldo Carvalho de Melo wrote:
> > On Thu, Jul 18, 2024 at 06:06:16PM +0300, Adrian Hunter wrote:
> >> On 18/07/24 15:58, Peter Zijlstra wrote:
> >>> On Thu, Jul 18, 2024 at 01:51:26PM +0200, Peter Zijlstra wrote:
> >>>
> >>>> OK, let me do that and make a few more edits and see if I can stare at
> >>>> that next patch some.
> >>>
> >>> I pushed out a stack of patches into queue.git perf/core
> >>> Could you please double check I didn't wreck anything?
> >>
> >> Looks fine, and seems to work OK in a brief test.
> >>
> >> Thank you! :-)
> > 
> > So should I go ahead and pick the tooling patches since the kernel bits
> > are merged?
> 
> Not exactly merged.  Probably should wait until it is in tip at least.
 
Ok, so I get just these, as you asked on another message:

acme@x1:~/git/perf-tools-next$ git log --oneline -5 perf-tools-next/tmp.perf-tools-next 
9140fec01b2de8d3 (HEAD -> perf-tools-next, perf-tools-next/tmp.perf-tools-next, perf-tools-next.korg/tmp.perf-tools-next, number/perf-tools-next, acme.korg/tmp.perf-tools-next) perf tools: Enable evsel__is_aux_event() to work for S390_CPUMSF
c3b7dba6ea81a5b1 perf tools: Enable evsel__is_aux_event() to work for ARM/ARM64
866400c0b08ef9d9 perf scripts python cs-etm: Restore first sample log in verbose mode
08ee74eb03e37191 perf cs-etm: Output 0 instead of 0xdeadbeef when exception packets are flushed
c22dd7ec2b2808b2 perf inject: Convert comma to semicolon
acme@x1:~/git/perf-tools-next$

It'll go to perf-tools-next once 6.11-rc1 is out.

- Arnaldo
