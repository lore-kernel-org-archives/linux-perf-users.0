Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0361A3166;
	Sat, 12 Apr 2025 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744490333; cv=none; b=NWVY8+TLkXZjI3FMcsWKcwVksETtHw9I/RV9zlxZP0eTzHLI58XRYl7floxosMrQvqvkBaMCFDljX8dasy7vtVkRTZenxCwTrm+FL+QypX4n2qgg6FWRiuSNZHkOM2NvX1HgvGbzlkoW7BHW7L9qpaxGKTthzG2gU7oc0e9ZCAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744490333; c=relaxed/simple;
	bh=wNYXzw5DmJDatYJ1BMioEnL4R5AmfwnRAAULrwduwbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iu3QQgzgKq+7toeeAsUssYLESf0AXcFxdzgnZbZLPE/1RYtzm5sfi7LnfDYB45Ax3vwX7o/+Yjx3P1y05kMrTRHzswYvaq/oxea28uce95F65pODJuriMNQy9qRy2NMzEzo36m8KOFtpii3/H1Xom4v3eReTnQRxq+q47R9NTBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCuAJj+X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCuAJj+X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FDBC4CEE3;
	Sat, 12 Apr 2025 20:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744490332;
	bh=wNYXzw5DmJDatYJ1BMioEnL4R5AmfwnRAAULrwduwbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VCuAJj+XagMTaoz0MvHU8WvZ9hVBMRmlvhLMSwHCQrpe0b2qHEHKQ1uVzV+JtbomX
	 o4tz1PUlChUmxhGaydXldfcqgXEWyvldirD4U2/WxQiF2Lm3vrfhJcCFYN9AGw/fKN
	 B90KfXf76wG9ugWMeNH3i2yq8Rf8Ywrh4a3sPXBbViOkwZzn+E4+DDA8sDXe9ueKIn
	 eGs8kT4vogbPdMbYa5jMlDRMJzJU0Umz/KtDwkpwzIZzEPGqghHa/mmRCSMXYER6Fc
	 IsAZyuo8w13voxNWJselPtYJma9E8XOjSsGofFN077xLUDH6twSifmd4jvhRdCuJ4n
	 gHZ08tBklerjA==
Date: Sat, 12 Apr 2025 22:38:46 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Mark Barnett <mark.barnett@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, irogers@google.com, ben.gainey@arm.com,
	deepak.surti@arm.com, ak@linux.intel.com, will@kernel.org,
	james.clark@arm.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/5] A mechanism for efficient support for
 per-function metrics
Message-ID: <Z_rPVq2Emx697SIA@gmail.com>
References: <20250408171530.140858-1-mark.barnett@arm.com>
 <Z_ZcRiHTGljxEEdN@gmail.com>
 <2fa741d8-13c7-49c0-a6c5-540a7c2cf3a7@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fa741d8-13c7-49c0-a6c5-540a7c2cf3a7@arm.com>


* Mark Barnett <mark.barnett@arm.com> wrote:

> Tool Integration
> ==================
> 
> We've been using a python script to process the data into a report. We can
> look at implementing this directly in perf report, if that is required.
> However, I'm nervous about making the new feature the default behaviour for
> the tool.

That's OK - but it should be very simple to activate for perf 
record/top. A single option or so to get some sane default behavior, 
without having to micro-manage the period values?

In particular perf defaults to 4000 Hz auto-freq samples (at least on 
my x86 devel box), and it would be nice to make this new feature work 
well with the freq representation too, without complicating it too 
much.

> This feature has been integrated into our tools [1] for the last 12 
> months, and has received a lot of testing on Arm Neoverse hardware. 
> Other platforms have received less rigorous testing. In my opinion, 
> more work would be needed to validate the PMU hardware & software 
> characteristics of other architectures before this can be made the 
> default.

Sure. As long as the switch is simple, I think it will be a popular 
change once the kernel feature goes upstream.

In other words: please add a simple, idiot-proof switch to perf 
top/record for maintainers with chronically short attention spans who 
want to try out your kernel feature. ;)

Please Cc: the perf tooling people to those changes, in general they 
are very open to such features.

> Burst Sampling
> ================
> 
> I like the burst sampling idea. Increased I-Cache pressure is an inherent
> weakness of this sampling method, and this would help to alleviate that
> somewhat. I'll add this in the next spin.

Great, thanks!

> Period Jitter
> ===============
> 
> Yes, we can apply this to both periods. I will make that change.
> 
> I'm not sure I've fully understood your suggestion here. In its 
> current state, the 4-bit jitter field acts as a base-2 exponent. This 
> gives us a random jitter value of up to 2**15. Is the suggestion to 
> change this to a fixed, absolute value that can be applied to both 
> long & short periods?

Oh, I missed the base-2 exponent aspect, I assumed it was a flat period 
in the small integers range, a kind of micro-jitter to counter 
resonance with the finest CPU microarchitectural base-frequencies.

What is the typical useful jitter range in your experience? base-2 
exponents sound a bit too limiting - although the prandom32() indeed 
smears it between [0..2^param). I'd guess that jitter would rarely want 
to be larger than the long-period? (Although that might not always be 
the case.)

I'd generally err on the side of being a bit too generic & generous in 
the design of ABI parameters, because we never know what people will 
use it for ... Within reason that is.

Thanks,

	Ingo
