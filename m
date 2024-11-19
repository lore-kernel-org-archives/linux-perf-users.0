Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FCBE571
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 00:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731977445; cv=none; b=uVOj/SYPMQ5m8A8wCdhFSHhnVwTXBPh57ZIkLZd8y65c0jB5WW/eo2YSvMdBdr/0o46B3h8bznkjtQ8zAOA6153R0ETtKPMT8tHslIrXA9KZMj0bhPO/FPxiIEpPu19uP5jQ4npQFACRHpSK3CDw3GiKa1K4J/1AZ3uP9zKCwu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731977445; c=relaxed/simple;
	bh=/nZgaz5ARlbH0uzVpXUDsnD8nbe6X7ViKDzjBp0NjNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjUt06wGL4/W1Qz8STUxHpMGoojlWoFXBnFp+WvsHi9CJnihS2ZbgjcpwyZXVIdcbCi8WFJBA6FdobHmyWGBo340CblU/lXmH57luMr9nc8vhyFghjhIkr2hXdY0fZ0NG8RLcMNBTwrpUsAtp7his3wWWJOkuIO7g1AVunmC3xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czy5GXVi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czy5GXVi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAF0C4CECF;
	Tue, 19 Nov 2024 00:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731977445;
	bh=/nZgaz5ARlbH0uzVpXUDsnD8nbe6X7ViKDzjBp0NjNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=czy5GXViBBA9eXmFqM23OY309uWh6+7QADrMvU0iBl70rUw5aod6CXbw7yVqmysiQ
	 uKY4NKLR5B38ltAuJprRkdFiMT1pdlSMgaGjfAuqIckJ5bL+voVBirqo/JkTURJZ9P
	 E/WZuOIZmfA6hYIQixx5WiIsaA5sI0VaQ6x9s+QMBPNRrHsNvKn6TWO5Qri6i9PYm4
	 o/Zhb6uQFv4AU5chAIlZE9oHxgr4c677Wp7ucTNTkAfHbbtVQXKPW0JSYDww0kfLHl
	 JlJG9GxC+XjIndM2/Q/wMOl4uB01z9b/N4MvkKfuqHj0b0SVwYdy5tOUtaDWBK9/xB
	 SMfQbOO2ZVa1Q==
Date: Mon, 18 Nov 2024 16:50:43 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Qiao Zhao <qzhao@redhat.com>, Michael Petlan <mpetlan@redhat.com>,
	alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, vmolnaro@redhat.com
Subject: Re: Intel Arrowlake and hwcache events
Message-ID: <Zzvg41ngE0oQeWx4@google.com>
References: <ea7b2c27-7512-f412-32c0-3a247fd930f9@redhat.com>
 <e37d7c6b-91c7-4fd7-831b-98f0dca5d46c@linux.intel.com>
 <CAATMXfkt28rjB03xFEcYzvhWsgtCe9Fp6eaFgDMEJq3c8_2hAQ@mail.gmail.com>
 <d3fffe92-8e64-423d-8ab7-075dfaa8a0dd@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3fffe92-8e64-423d-8ab7-075dfaa8a0dd@linux.intel.com>

Hello,

On Fri, Nov 15, 2024 at 08:36:55AM -0500, Liang, Kan wrote:
> 
> 
> On 2024-11-15 12:43 a.m., Qiao Zhao wrote:
> > On Thu, Nov 14, 2024 at 10:33 PM Liang, Kan <kan.liang@linux.intel.com>
> > wrote:
> > 
> >>
> >>
> >> On 2024-11-14 4:54 a.m., Michael Petlan wrote:
> >>> Hello!
> >>>
> >>> Qiao Zhao (CC'd) has found out that there are no hwcache events available
> >>> on an Arrowlake system he was testing perf on.
> >>
> >> There are several variants for Arrowlake.
> >> #define INTEL_ARROWLAKE_H               IFM(6, 0xC5)
> >> #define INTEL_ARROWLAKE                 IFM(6, 0xC6)
> >> #define INTEL_ARROWLAKE_U               IFM(6, 0xB5)
> >>
> >> The INTEL_ARROWLAKE should be supported in 6.10 and later.
> >> The INTEL_ARROWLAKE_H was just merged and should be available in the
> >> upcoming 6.13-rc.
> >>
> >> https://lore.kernel.org/lkml/20240808140210.1666783-1-dapeng1.mi@linux.intel.com/
> >>
> >> The patch to support INTEL_ARROWLAKE_U hasn't been posted yet.
> >>
> >> Which system were you testing?
> >>
> > 
> > Hi Kan, thank you for explaining this. I checked my testing history, and I
> > happened to use Arrow Lake-U for testing.
> 
> Thanks for the confirmation.
> I will find a machine and post a patch to fix it ASAP.
> 
> Thanks,
> Kan
> 
> > # lscpu
> > Architecture:             x86_64
> >   CPU op-mode(s):         32-bit, 64-bit
> >   Address sizes:          46 bits physical, 48 bits virtual
> >   Byte Order:             Little Endian
> > CPU(s):                   14
> >   On-line CPU(s) list:    0-13
> > Vendor ID:                GenuineIntel
> >   BIOS Vendor ID:         Intel(R) Corporation
> >   Model name:             Genuine Intel(R) 0000
> >     BIOS Model name:      Genuine Intel(R) 0000
> >     CPU family:           6
> >     Model:                197

  $ python -c 'print(hex(197))'
  0xc5

Isn't it ArrowLake-H ?

Thanks,
Namhyung


> >     Thread(s) per core:   1
> >     Core(s) per socket:   14
> >     Socket(s):            1
> >     Stepping:             2
> > 
> > 
> >>
> >>> We have found out that it
> >>> does not work even on 6.12.0-rc6+. Are there still drivers that haven't
> >>> been merged yet?
> >>>
> >>> Happens that nothing matches in this loop:
> >>
> >> The HW cache events are usually model specific events. You cannot see it
> >> unless there is specific support.
> >>
> >> You may also get more clues via dmesg | grep PMU.
> >> If you see "generic architected perfmon", it means the specific support
> >> isn't ready in the kernel.
> >>
> > 
> > Understand! Thank you Ken.
> > 
> > - Qiao
> > 
> > 
> >>
> >> Thanks,
> >> Kan
> >>>
> >>> int print_hwcache_events(const struct print_callbacks *print_cb, void
> >> *print_state)
> >>> [...]
> >>> 305           for (int type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++)
> >> {
> >>> 306           for (int op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
> >>> 307                   /* skip invalid cache type */
> >>> 308                   if (!evsel__is_cache_op_valid(type, op))
> >>> 309                                   continue;
> >>> 310
> >>> 311                   for (int res = 0; res <
> >> PERF_COUNT_HW_CACHE_RESULT_MAX; res++) {
> >>> 312                   char name[64];
> >>> 313                           char alias_name[128];
> >>> 314                           __u64 config;
> >>> 315                           int ret;
> >>> 316
> >>> 317                           __evsel__hw_cache_type_op_res_name(type,
> >> op, res,
> >>> 318
> >>                              name, sizeof(name));
> >>> 319
> >>> 320                           ret =
> >> parse_events__decode_legacy_cache(name, pmu->type,
> >>> 321
> >>                              &config);
> >>> 322                           if (ret ||
> >> !is_event_supported(PERF_TYPE_HW_CACHE, config))
> >>> 323                                   continue;
> >>>
> >>> Thanks,
> >>> Michael
> >>>
> >>>
> >>
> >>
> > 
> 
