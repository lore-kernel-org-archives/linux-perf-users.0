Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6133C15E88;
	Thu, 15 Aug 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737192; cv=none; b=OHuwKd8I0RgNIqEoSHXZyOgb87cfsGO5EfU2BFQXMv0X9Ydux6Y1+tgScznMnl99/0WGWFgkIbefCz/v0K6I8jds6v+/CYyAxxHtYytWvFhofjArfqEKu6mgTxl6BpKw/Vy+6vj2CQ+9gQ0C4i/M7jNJU1so+S++yDP6YV5oE8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737192; c=relaxed/simple;
	bh=kIHwKlAGat/GxPUv1Aw0uwybGy7KqXeGxpeOvG9E1xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIEo3U672O91k3HLkmFGJkKZEiumUVgDPRYuTUCFJf1ZcUS+F6vSNR+Opc61L8koLvmXxcePs/THC1vhVPR/r2zb7mR9dqweEMZ6zDRBOZ9GorqDlvq78382BO25B6KHciHyAMHkwzGhUCaXVnkwjUInsq+5wN7d28lZpHelicc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0efWJlM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0efWJlM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56468C32786;
	Thu, 15 Aug 2024 15:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723737191;
	bh=kIHwKlAGat/GxPUv1Aw0uwybGy7KqXeGxpeOvG9E1xM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S0efWJlMeM6/znYkeYaWJqqNNsz4whiJISa7Hoidcw8l79LxQqA0/4sb8S4ZI32Ub
	 L1jn3uh84PkTCNeTU2Rj55x0+KEaWsSMxPvMgKjs9LsQzwj5cLIN2pu3pCLKlEy6M7
	 NodYzYa+Okq6Heni75J8ion2wCTgtxzBS1VpRABkdBv+PuqEWAIGMMzZiVGnAZ6Hbx
	 XbYw/T3Q7F7MBL/D7+rN5g80koxR1dg0ztLNYZZ9Jfrfe4N1MZpWlvMYPARxoPn/rF
	 qpI3FcbUCCxBEIg7zfbxTlMe3t2iVHoKTj6KMAZ+dS9P4eEEUAEv/Dc+aEDTzD7+lt
	 D7aEBiA1Te4OA==
Date: Thu, 15 Aug 2024 12:53:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Linux perf Profiling <linux-perf-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	James Clark <james.clark@arm.com>,
	"cc: Marc Zyngier" <maz@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Asahi Linux <asahi@lists.linux.dev>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since
 v6.5
Message-ID: <Zr4kZTxgvD6bmi37@x1>
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <ZV1AnNB2CSbAUFVg@archie.me>
 <a9c14dfd-3269-4758-9174-4710bef07088@leemhuis.info>
 <CAP-5=fXqx_k1miPTkcAmS3z2GBPt2KeDtP5fknmdDghZqxXPew@mail.gmail.com>
 <714ed350-0e6c-4922-bf65-36de48f62879@leemhuis.info>
 <0de3b572-f5f7-42e4-b410-d1e315943a3c@linaro.org>
 <ZrzeRM3ekLl9zp3z@x1>
 <348ea015-eccf-4f44-a332-a1d9d8baf81f@linaro.org>
 <Zr4eWd6HWLHDcpC9@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr4eWd6HWLHDcpC9@x1>

On Thu, Aug 15, 2024 at 12:27:21PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Aug 15, 2024 at 04:15:41PM +0100, James Clark wrote:
> > In one of your investigations here
> > https://lore.kernel.org/lkml/Zld3dlJHjFMFG02v@x1/ comparing "cycles",
> > "cpu-cycles" and "cpu_cycles" events on Arm you say only some of them open
> > events on both core types. I wasn't able to reproduce that on
> > perf-tools-next (27ac597c0e) or v6.9 (a38297e3fb) for perf record or stat. I
> > guessed the 6.9 tag because you only mentioned it was on tip and it was 29th
> > May. For me they all open exactly the same two legacy events with the
> > extended type ID set.
> > 
> > It looks like the behavior you see would be caused by either missing this
> > kernel change:
> > 
> >   5c81672865 ("arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability")
> >    (v6.6 release)

What I have now is:

6.1.92-15907-gf36fd2695db3

It was a bit older, but 6.1 ish as well, I'll try to either get a new
kernel from Libre Computer or build one myself.

- Arnaldo

> > Or this userspace change, but unlikely as it was a fix for Apple M hardware:
> > 
> >   25412c036 ("perf print-events: make is_event_supported() more robust")
> >    (v6.9 release)
> > 
> > Do you remember if you were using a new kernel or only testing a new Perf?
> 
> I normally use the distro/SoC provided kernel, didn't I add the 'uname
> -a' output in those investigations (/me slaps himself in the face
> speculatively...)?
