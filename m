Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2805A474249
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625853; cv=none; b=TI/KWYYD1C6vJ1RPEhJK4Hu76T6yy6pcWPLb826y7wZLsxw76YscY/fiHUPP5PcDNq2cHoNq0eIDhBXou7AfYrFZ3HnUW9ushSLSIIqXZSKXDvS0UE1s4v7We5NUXtgqf7zlD4nMzkFz5nr3ItIBehOlRWbAr4qS/F0JoeswZ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625853; c=relaxed/simple;
	bh=pT7C26Ldy9DHRXWPk1esuTAQ2YpR84dxOvIP8nSLG8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGsSkzj2KKigldGc0+sLnhSr8YCP7nL0k4l3KhaGQXYNKGhYgH3eW8yS7Uq4Oenom8jqgsPhM9qir7eomVffKivlkl31p8ex0XKL0zdi+7Zd1sMdeRAces+fEEhWzhBMiMdPGQAE3oZh476+o/zMX968XkdfFRmlrGUSxQFSLnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NM3qr4vm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NM3qr4vm"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-495773ee3edso1680315e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 05:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786625849; x=1787230649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9fiE24ll9NgTLTpdzffi902DeMDS19T/hW1M1NBO/qc=;
        b=NM3qr4vmyxiJ0TeK7wi2HphIcsrhQjrlDq4GSUUn41N3qLbDVm+qSV6NiRLcbAwXrw
         ubbM4iWQ6csCXYCj+ZsVAf5dguW1jtfCszIA5aysNRADZk5FBU47+jZTW4aTe8qy9AHY
         b1v60kLYVVT2RivJQBYy7R5P1JmdoEg7mO6EqT4Qh+50fztVfzbenWUeHjr0O7ES94/G
         56GFBj3jdQK5qR0RcWuMjMOFOT+u3bu5rHCjnV+01OmsfxnUA7ntA0yZ/K6MUehlGCrM
         xRoeYJgdHxQ35cvcjAsMrHfSwu6DRTprP/WaNbgPvUX3IR9H1lPl5XNzRqeur1dbXyie
         7c1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786625849; x=1787230649;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9fiE24ll9NgTLTpdzffi902DeMDS19T/hW1M1NBO/qc=;
        b=WLXyrttDMU/YOb9K8OKRhdSTXoZsQX+MqtInDUsn4YFlDt69sdjtUxPgg1Snj3ARPi
         GO4h76za/nbQfaIK45jVVFS6/2PdFHjY9EetR2XyRqNI9qlLkh8i1p3UbHZKwOUpOef+
         kCw/QwP1bE+s4UaRk5WqKppXQDQuwEqchn8DM4wI0PA95enB+Gq3GyKvPGSGzAx/kA46
         SV6o3NOM4Dv1E2deR4pl1fJYFqpEq9UYPOnmMfCWrDxOKNY88qHRobU2NsvLWstlvO11
         cFUNsJ9KBATh4lIhgm8+n53d1oksL9/TcrC10BM0orGBTrjcXJy4I1YHfSTbiQ0/C0wt
         YSTw==
X-Forwarded-Encrypted: i=1; AHgh+RrZHtbn2agQibb4s9rGWgI62yDUmjY+CYiAiQBKG3UTtck2waMmU+1YslpGyvwXVA9KEXhzaprC+SqbNE+jJw5H@vger.kernel.org
X-Gm-Message-State: AOJu0YxSiTC2G4SomzhojajfMwbfVL7Ydg0fidaCTHIpvqNAZA4Vzd3u
	RAL4CWXskCJPnN1f3Hu/K9IYu84+ydEeaNaw2tWR7G8Dhp6OtV7/10x//OhbyfDt4Hg=
X-Gm-Gg: AR+sD10ZsfIjJGVHSMzwStvjU9+ic/cwLDOPWfO/EVNW6AOclrzNHji0DzoHEd8ZowQ
	SxzIrLSADWWsOAQzWRWudC3g8Qt2y+8tBC3031V58bmkmtu82cubEcG5oyfdkgvaJNICowhmRaN
	QvcWClxnNZpeQAWp7dYScjUtgs2l2jZO8IQm/X/mzp8YTnhIfkjiL0zNZ/9TpillH/iLI+St2jj
	y9Oa9cYavC4xNyJe8JjK2ohLtZpWFQt/MnhnpX6jQ/d/0AtulnW+5dUm7AXfTEZCJWAaeDZPpq5
	EQwNKpGg182Sw+NPnubNqvrxwoo/8WrcOFZaYYN/LtMg0pDXfShvtLd5TpRnUh/43U1hY+b2sWL
	ym/fpT5Q+ktb51Sr4mftIJMRl93jm9ilgV+LdjZANCBx+hrBca6FlzHajGH5SWoKr4TCpvc6hWT
	B0DidJTk/VTD1qP0wyCFoKY9Ae052I82iaQRaQ7BDyg4CWhCt482e7fBa1PCsXsYw+6OWJWBLDW
	gqi7wltrcxuRys9jhHdAtC7a62rwvIcnA+ipwbv2nG1Ps/rmD1S5vHLM+kdchog
X-Received: by 2002:a05:600c:4fcc:b0:495:4126:1e55 with SMTP id 5b1f17b1804b1-4998264bdafmr33971245e9.2.1786625849332;
        Thu, 13 Aug 2026 05:57:29 -0700 (PDT)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981e4435bsm29534935e9.3.2026.08.13.05.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 05:57:28 -0700 (PDT)
Date: Thu, 13 Aug 2026 14:57:25 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Thomas
 Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin"
 <hpa@zytor.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Ananth Narayan
 <ananth.narayan@amd.com>
Subject: Re: [PATCH 1/3] perf/x86: Add x86_pmu::print_debug
Message-ID: <20260813145725.22f21719@mordecai>
In-Reply-To: <7078a9e7-6493-42b0-b297-ce174effdfb3@linux.intel.com>
References: <cover.1786010408.git.sandipan.das@amd.com>
	<fc6ff612d26c2f5b0f015d9fac309cc58e913c1f.1786010408.git.sandipan.das@amd.com>
	<7078a9e7-6493-42b0-b297-ce174effdfb3@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 10:37:20 +0800
"Mi, Dapeng" <dapeng1.mi@linux.intel.com> wrote:

> On 8/6/2026 6:03 PM, Sandipan Das wrote:
> > perf_event_print_debug() dumps the global control and status MSRs
> > whenever x86_pmu.version >= 2, reading registers that exist only on
> > Intel-compatible PMUs. This is not safe since x86_pmu.version is not
> > Intel-specific and is now set by other vendors whose global registers
> > use different addresses.
> >
> > As a first step, split perf_event_print_debug() in two. The register
> > dump moves into a new common helper, x86_pmu_print_debug(), leaving
> > perf_event_print_debug() to handle the preamble and dispatch to an
> > optional x86_pmu::print_debug method. This lets each vendor-specific
> > PMU dump its own global state before chaining into the common helper.
> > PMUs that do not implement the method, such as those with
> > x86_pmu.version < 2, get the common helper alone.
> >
> > No functional change intended.
> >
> > Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> > ---
> >  arch/x86/events/core.c       | 29 ++++++++++++++++++++++-------
> >  arch/x86/events/perf_event.h |  4 ++++
> >  2 files changed, 26 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index af0b67ffb43d..17dc53a62378 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -1557,7 +1557,7 @@ static void x86_pmu_start(struct perf_event *event, int flags)
> >  	perf_event_update_userpage(event);
> >  }
> >  
> > -void perf_event_print_debug(void)
> > +void x86_pmu_print_debug(int cpu)
> >  {
> >  	u64 ctrl, status, overflow, pmc_ctrl, pmc_count, prev_left, fixed;
> >  	unsigned long *cntr_mask, *fixed_cntr_mask;
> > @@ -1566,17 +1566,11 @@ void perf_event_print_debug(void)
> >  	u64 pebs, debugctl;
> >  	int cpu, idx;
> >  
> > -	guard(irqsave)();
> > -
> > -	cpu = smp_processor_id();
> >  	cpuc = &per_cpu(cpu_hw_events, cpu);
> >  	cntr_mask = hybrid(cpuc->pmu, cntr_mask);
> >  	fixed_cntr_mask = hybrid(cpuc->pmu, fixed_cntr_mask);
> >  	pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
> >  
> > -	if (!*(u64 *)cntr_mask)
> > -		return;
> > -
> >  	if (x86_pmu.version >= 2) {
> >  		rdmsrq(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
> >  		rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
> > @@ -1622,6 +1616,27 @@ void perf_event_print_debug(void)
> >  	}
> >  }
> >  
> > +void perf_event_print_debug(void)
> > +{
> > +	struct cpu_hw_events *cpuc;
> > +	unsigned long *cntr_mask;
> > +	int cpu;
> > +
> > +	guard(irqsave)();
> > +
> > +	cpu = smp_processor_id();
> > +	cpuc = &per_cpu(cpu_hw_events, cpu);
> > +	cntr_mask = hybrid(cpuc->pmu, cntr_mask);
> > +
> > +	if (!*(u64 *)cntr_mask)
> > +		return;
> > +
> > +	if (x86_pmu.print_debug)
> > +		x86_pmu.print_debug(cpu);
> > +	else
> > +		x86_pmu_print_debug(cpu);  
> 
> The logic looks good, but better change this to the static_call() just like
> other x86_pmu callbacks. It eliminates the branch prediction cost. Thanks.

Is it worth the extra complexity for code that is used only by SysRq
debugging?

Of course, if it's trivial, let's do it anyway.

Petr T
