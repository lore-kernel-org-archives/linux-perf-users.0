Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PnOs/mTB"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267A510C0
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2023 17:33:19 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db403a0f25eso7456926276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2023 17:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701221598; x=1701826398; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uOZ4wahs3lobvOneDy8Jd5Ygdm6wAPNocIR2yUTw9Co=;
        b=PnOs/mTB+UZFcfgkl/eOoXceVOBF34eTKjpbAZnbEQcOnRB6OCbbpSa0nb+gFFnNBL
         R5QINtMz7/9/FfP4DrcVq6GwEkMl9Q/Kc1Y8MNpM0b/aYiGjHcMXlX1025le7eloitOP
         npjQ2la37cOxtlu30553XWGmVEcCHnBMJYLzpfMUMUvTIbn9IvUu8iu0msbfVh4/v5pZ
         ei5tDYcf1RA7KlHIVyJZCn8AMgBFBatvY3TJzSmLTYntWYG0aHZgMFrEPM4mmkxGNEIw
         Wurmx4nLt8sEdLgJ6xitjlVdgJDVABBHzHWsmQGox0qhvxF6MLiNHdMob5MZH5sxHqv7
         e6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701221598; x=1701826398;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOZ4wahs3lobvOneDy8Jd5Ygdm6wAPNocIR2yUTw9Co=;
        b=eNjc76JR3T1qZJTKq0NQUzH406SnasfTQxz8cbMdzLx6c1YRW6v6947ijzlEtRf4Jr
         TzB1lZ631vTITZJ3q4en6mEe3i9/XTF7jiKu7MFypMFVkT/yjnI2cUqeLnNFXxvKB/c8
         bwGWpe+5e95NcSjEEYUh9hnP32hlP0Y5oiEgqu7Vtt3ozyNYVfZT1TdUYcLAie9q4yvn
         sx98DX6SeGA1cIjhs/6MgaYY8uwbFuR7xNqJgQPVhFWb1+CEziYyRTyoZ5QPNspbqQM6
         Md0t9oNrgWzg0zNVzLjWzP8RIF0P+2PXM/1rWVAMMO9QFukryYqt1QX91uiW4atGP4b+
         mR9Q==
X-Gm-Message-State: AOJu0Yx3XneNf47A5TNBhsHDhDY1BXqYOnRy8UVQyksQw1QbxSi8YjjL
	dwDwswQ8vuDwAyS6Tb/N66EQLcL2EKM=
X-Google-Smtp-Source: AGHT+IFhGe4EXP7BVJs2IZlP2wbVgEkiFOTUDd8qRLyNsc8IhtYPIoOTFtT363Z5UQTHRTeqBUDaEInNAgo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ca04:0:b0:da3:a91c:7356 with SMTP id
 a4-20020a25ca04000000b00da3a91c7356mr428452ybg.8.1701221598425; Tue, 28 Nov
 2023 17:33:18 -0800 (PST)
Date: Tue, 28 Nov 2023 17:33:16 -0800
In-Reply-To: <20231117103236.GI3818@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231107183605.409588-1-seanjc@google.com> <20231117103236.GI3818@noisy.programming.kicks-ass.net>
Message-ID: <ZWaU3HZURCjms5DM@google.com>
Subject: Re: [PATCH] perf/x86: Don't enforce minimum period for KVM guest-only events
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Like Xu <likexu@tencent.com>, Jim Mattson <jmattson@google.com>, 
	Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 17, 2023, Peter Zijlstra wrote:
> On Tue, Nov 07, 2023 at 10:36:05AM -0800, Sean Christopherson wrote:
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
> 
> Hmm, IIRC we can disable that left < 2 thing for anything that doesn't
> have x86_pmu.pebs_no_isolation IIRC.
> 
> I'm not sure about taking out the limit_period call, why does it make
> sense to allow the guest to program obviously invalid settings?

I don't see how the guest behavior is obviously invalid.  Architecturally, writing
-1 to a counter should result in overflow after a single event.  Underlying uarch
goofiness shouldn't enter into that equation.

Honoring the guest's programming *might* cause oddness for the guest, whereas
not honoring the architecture is guaranteed to cause visible issues.

If programming a "period" of 1 puts the host at risk in some way, then I agree
that this is unsafe and we need a different solution.  But if the worst case
scenario is non-determinstic or odd behavior from the guest's perspective, then
that's the guest's problem (with the caveat that the guest might not have accurate
Family/Model/Stepping data to make informed decisions).

> That is, would something like the below work for you?

No, because the fix ideally wouldn't require fancy hardware, i.e. would work for
all CPUs for which KVM supports a virtual PMU.
