Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BCF51BB8
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 15:47:01 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A15DB
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 08:46:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d8671837a86so18210314276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 08:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696002418; x=1696607218; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G8/Q+35NLYw9HySOsQs1oSfJaoZjiMzWGb8dDgdqnZo=;
        b=CMfTzHFv2fEO3S5qnDTlDkhWaPzP28RauafiXFYIFwQjUfcQDPw2bxz+w/Zs20T/fX
         Z7pIIDTFsWdhTEWZ5hEaqdagW9vF1NDT/KkoPH3DUujBlAgCUqdnbVrm2yO9TCxGt7zv
         nrAChKn1UHLk3KBu1bgnCIp/I30ug/Ma2OfwvJOtOgjOq0DszX9gJ+VAAdG9eSzXMOE7
         f0JwQKxhRCGM7L6xNggeoalIeyfqqgnvJZsqh6IxA9qpjOci61UQPuiazGp5/d7M6WtD
         rW4jBEKSffhea1fVXzAeM2wXWKYIniP5vM+mbUWIUzQ1UoVhu7B2b+8VuBYY1GRZ25TB
         bv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696002418; x=1696607218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8/Q+35NLYw9HySOsQs1oSfJaoZjiMzWGb8dDgdqnZo=;
        b=kZZ5pknAzm6szQeNOpgl2zoTULTa8KAJ/NZlx8lk6pSPat18yvSUrm9w84x2QFFYRH
         4VsykFQEBoUmjf6DxHHeQyHqzGsIDLTl076TanK5hDUWE/g9qpFLsuk7u9wlS5JUoyAR
         QhcMUBdg0VgqYl4WEggoWHxE1FiZegzjQrHWurW6SVq3QvwwEsdCsFzx/aKLABcAILll
         PegI5LYYUM7/eXkcjnk4I2deCaAW8IBz4J2575UwlYRSC4LRq8wa3zimaZFAKZzavRsM
         /EI2oSQfr47X7jkdULNL0R5QhaSDI+p05xHbwaUsopzn1bGM+utsXlEL85Mm/pCcLask
         IMaQ==
X-Gm-Message-State: AOJu0YyLvn1Z6GI0zT//kfz7P4YRSOnRzmFAA28EzgB/yyTE0eAEdwPO
	8b03Co3R//lun7FLPcysCeuRz1/CZy8=
X-Google-Smtp-Source: AGHT+IHDh7IMtzu+1PO3dzsxkepM97Irjo5ZMB5bFahEOwFsP/VFLFg0ZqcwQb0X5RS1iM09MPGH9tHQKXQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:730d:0:b0:d85:ac12:aadb with SMTP id
 o13-20020a25730d000000b00d85ac12aadbmr71182ybc.9.1696002417694; Fri, 29 Sep
 2023 08:46:57 -0700 (PDT)
Date: Fri, 29 Sep 2023 15:46:55 +0000
In-Reply-To: <20230929115344.GE6282@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230927033124.1226509-1-dapeng1.mi@linux.intel.com>
 <20230927033124.1226509-8-dapeng1.mi@linux.intel.com> <20230927113312.GD21810@noisy.programming.kicks-ass.net>
 <ZRRl6y1GL-7RM63x@google.com> <20230929115344.GE6282@noisy.programming.kicks-ass.net>
Message-ID: <ZRbxb15Opa2_AusF@google.com>
Subject: Re: [Patch v4 07/13] perf/x86: Add constraint for guest perf metrics event
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Like Xu <likexu@tencent.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Zhang Xiong <xiong.y.zhang@intel.com>, 
	Lv Zhiyuan <zhiyuan.lv@intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>, Jim Mattson <jmattson@google.com>, 
	David Dunn <daviddunn@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023, Peter Zijlstra wrote:
> On Wed, Sep 27, 2023 at 10:27:07AM -0700, Sean Christopherson wrote:
> > Jumping the gun a bit (we're in the *super* early stages of scraping together a
> > rough PoC), but I think we should effectively put KVM's current vPMU support into
> > maintenance-only mode, i.e. stop adding new features unless they are *very* simple
> > to enable, and instead pursue an implementation that (a) lets userspace (and/or
> > the kernel builder) completely disable host perf (or possibly just host perf usage
> > of the hardware PMU) and (b) let KVM passthrough the entire hardware PMU when it
> > has been turned off in the host.
> 
> I don't think you need to go that far, host can use PMU just fine as
> long as it doesn't overlap with a vCPU. Basically, if you force
> perf_attr::exclude_guest on everything your vCPU can haz the full thing.

Complexity aside, my understanding is that the overhead of trapping and emulating
all of the guest counter and MSR accesses results in unacceptably degraded functionality
for the guest.  And we haven't even gotten to things like arch LBRs where context
switching MSRs between the guest and host is going to be quite costly.

> > Note, a similar idea was floated and rejected in the past[*], but that failed
> > proposal tried to retain host perf+PMU functionality by making the behavior dynamic,
> > which I agree would create an awful ABI for the host.  If we make the "knob" a
> > Kconfig 
> 
> Must not be Kconfig, distros would have no sane choice.

Or not only a Kconfig?  E.g. similar to how the kernel has
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS and nopku.

> > or kernel param, i.e. require the platform owner to opt-out of using perf
> > no later than at boot time, then I think we can provide a sane ABI, keep the
> > implementation simple, all without breaking existing users that utilize perf in
> > the host to profile guests.
> 
> It's a shit choice to have to make. At the same time I'm not sure I have
> a better proposal.
> 
> It does mean a host cannot profile one guest and have pass-through on the
> other. Eg. have a development and production guest on the same box. This
> is pretty crap.
> 
> Making it a guest-boot-option would allow that, but then the host gets
> complicated again. I think I can make it trivially work for per-task
> events, simply error the creation of events without exclude_guest for
> affected vCPU tasks. But the CPU events are tricky.
> 
> 
> I will firmly reject anything that takes the PMU away from the host
> entirely through.

Why?  What is so wrong with supporting use cases where the platform owner *wants*
to give up host PMU and NMI watchdog functionality?  If disabling host PMU usage
were complex, highly invasive, and/or difficult to maintain, then I can understand
the pushback.  

But if we simply allow hiding hardware PMU support, then isn't the cost to perf
just a few lines in init_hw_perf_events()?  And if we put a stake in the ground
and say that exposing "advanced" PMU features to KVM guests requires a passthrough
PMU, i.e. the PMU to be hidden from the host, that will significantly reduce our
maintenance and complexity.

The kernel allows disabling almost literally every other feature that is even
remotely optional, I don't understand why the hardware PMU is special.
