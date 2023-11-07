Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF64630652
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Nov 2023 23:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mTM9+LoP"
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F96B10C3
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Nov 2023 15:02:46 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cc42d3f61eso49424495ad.3
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Nov 2023 15:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699398165; x=1700002965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8EVsKpDQ2kjOduD9kf9++j1jY5Py297YD+PLdhOq3bk=;
        b=mTM9+LoPPe5ZETe1SinIcv6pmXVJ9H1CwVrT11XSmRiiHqfYFhjgdM03zf3WdJWTTG
         D1W9KBBn/YtjJBs7E9IlfVghrULoNHBj3ML8g0Dcxjw6jTwlSV27u8XJRMdIvf28smnN
         We0+fAs1U39aLGhqBUKpgGAVqdTt9nCcH+n3NK/t4+XWkzG3SWbaEMDan0hxnknnl/hz
         B9TeWrXN13+RLbRKqNk41PRXNzn9Ck/M6oCGsqcr7A9LoQIv5tQJdGosWxNytefga0Ed
         RJLVJUN1Ovs3Ix1Fn0cLX5mMeATRqdyGjWk+uL3uDlebcEHI1Gvax1VPsNcgBWHUF2pH
         MSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699398165; x=1700002965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EVsKpDQ2kjOduD9kf9++j1jY5Py297YD+PLdhOq3bk=;
        b=HkNS4+Q9SQO9uMG7hjZcRNJWNnuonfMPgkYRtzyPxztZqaNjpBBP5kUMWgehK1Srwt
         CzwW99NKnqLUrRSkQXAJvykD4+jCorw01cPWuTWQD4H4mnKiwRm2+xBlJb63yOtvj4Gk
         IZtAnLNODzhpg4Ztm3qVNeEhBYQkWE+EXqfvPLdFnLmdJZ6gMpXRPt+bzcP9FQeRfNzL
         wM9hx4oeLNn1b2xrKvQDLoiFJRKrZg7U4a4xRJ2J3rmT/e0fxUZ/thdTrGnM+oj24JOx
         fQ3grq2iDY2FJB5yKPVZsDCsBxunDLIV3WcslWLs+KFsQjzl1ZiM955FX5Kro44EQng2
         pMJA==
X-Gm-Message-State: AOJu0YxH2n9b6cNktqCwoR8uguKL3xdMOobmYozx54JcYLFAGgPp9wOr
	nyBiuxUcxjkuENsq9l1A7LawoKBfrvo=
X-Google-Smtp-Source: AGHT+IFLGhmdifdfEZseQ28YW9EhMqsnGxCCvj5bzGJ8Mr/sYu8XEsUXxO+Dn9NoXwtjRS0sPvB8BCRLmO4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ef84:b0:1cc:b65:fdb5 with SMTP id
 iz4-20020a170902ef8400b001cc0b65fdb5mr8143plb.0.1699398165461; Tue, 07 Nov
 2023 15:02:45 -0800 (PST)
Date: Tue, 7 Nov 2023 15:02:43 -0800
In-Reply-To: <ZUqSQKHwvKQs7_qA@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231107183605.409588-1-seanjc@google.com> <ZUqSQKHwvKQs7_qA@google.com>
Message-ID: <ZUrCE9j1Gvw4zacY@google.com>
Subject: Re: [PATCH] perf/x86: Don't enforce minimum period for KVM guest-only events
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Like Xu <likexu@tencent.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 07, 2023, Mingwei Zhang wrote:
> On Tue, Nov 07, 2023, Sean Christopherson wrote:
> >  arch/x86/events/core.c | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index 40ad1425ffa2..f8a8a4ea4d47 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -1388,16 +1388,25 @@ int x86_perf_event_set_period(struct perf_event *event)
> >  		hwc->last_period = period;
> >  		ret = 1;
> >  	}
> > -	/*
> > -	 * Quirk: certain CPUs dont like it if just 1 hw_event is left:
> > -	 */
> > -	if (unlikely(left < 2))
> > -		left = 2;
> >  
> >  	if (left > x86_pmu.max_period)
> >  		left = x86_pmu.max_period;
> >  
> > -	static_call_cond(x86_pmu_limit_period)(event, &left);
> > +	/*
> > +	 * Exempt KVM guest events from the minimum period requirements.  It's
> > +	 * the guest's responsibility to ensure it can make forward progress,
> > +	 * and it's KVM's responsibility to configure an appropriate "period"
> > +	 * to correctly virtualize overflow for the guest's PMCs.
> > +	 */
> > +	if (!event->attr.exclude_host) {
> > +		/*
> > +		 * Quirk: certain CPUs dont like it if just 1 event is left:
> > +		 */
> > +		if (unlikely(left < 2))
> > +			left = 2;
> > +
> > +		static_call_cond(x86_pmu_limit_period)(event, &left);
> > +	}
> >  
> >  	this_cpu_write(pmc_prev_left[idx], left);
> >  
> 
> Nice one. I am curious how you tested this one? I would like to
> reproduce that one on my side.

The check_emulated_instr() sub-test in KVM-Unit-Tests's x86/pmu.c fails when run
with "my" (which is really yours) fix for the KVM's handling of emulated PMC
events[*].  If KVM synthesizes an "instructions retired" event that bumps the
PMC to all ones, i.e. -1 for all intents and purposes, the test fails because
KVM creates a sample_period of '1', but perf programs a period of '2'.

I suspect a very simple test of writing -1 to a PMC from the guest would exhibit
the same behavior.

[*] https://lkml.kernel.org/r/ZUWAg3WP2XESCAR4%40google.com
