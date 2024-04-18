Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA27199EA2
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Apr 2024 21:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477166; cv=none; b=DjoAJPJLEyOgklSwu53obPgGKydcTSjqqYSENYcmrXJDoXbKFerd6UbwUc6UsPl9z7xpWse/XmvGbzpcn9mNYCtaXFaJ6pQautiu7VCRKZRz9nFcuJ8jCkRMOrLb31ut7N8PwS20KSTLd/3gQYhpN7Y5Wx8qq9AQpo+l0Dj46EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477166; c=relaxed/simple;
	bh=ezV0icFcjPk7kT1FzU6+3by93YDM7KV56yEGQnLRAiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nkqakj5z0xNAbqKkeqaCAt7FFZDBw6H2YcjVaauN5j/0SNlhvXJnX+agkLRvzNQaIz6H1RgWw+FaV1E9YO7R663ZifB5VJRD6PZQREqy4ItjKDYP1pwbtbrEBaav3nvDuzQY8RHLII4XmcavSNKIQmnJAzQglkyQSWqXa9sNqd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qVrR819A; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qVrR819A"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso1031521a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Apr 2024 14:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713477164; x=1714081964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RdyamX5oRtAAPkdk0lIVrHAoc5Qo5F/4kYkO26HP/k0=;
        b=qVrR819APu26AC7YcR+TfA/MLOmzeaNH1T+2Jn0li9jxlWAEjCO/e+t+8ZliU4RpA0
         7zKVn9ueH960f5g5LMZ1Kax7qgTrTYAYacE5lskS3tIKhseufbmrNOcaV1qjZhujcJLr
         Kup5tz0ciyLqeAC8m2aIvCuIKQkGsiarTvauL+kDo2PoS0a5mIqeMVsL2aaos6riJSqH
         9vLTlRfupFqy/ZAW8xpv0y9zRJ+NYkPf39qT9vFeuPTDMpVjyIUX82SUa5gtWmTshSVC
         3vWfUjE9vyx32BffEfT8Sd44UCW+TGR2Txz7XoBF3iqGPkoj3EhvFmcilZvHUL4Z/Bek
         5BVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713477164; x=1714081964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdyamX5oRtAAPkdk0lIVrHAoc5Qo5F/4kYkO26HP/k0=;
        b=oaEdWaGb8UWOPasyDqFRFfhEf7B5B8YzwMPOUtVCOSp5D/uETYKnN3YguDcO1HXfQ6
         cKuIR0yyVIQL0LqYYqvXH6HvsOQnhX69E9z9HdvrCIz/Ro9DVnkWif55bCVY1eEIi0/p
         m7y2DN0dMilMrlWVHvd86GNMCZ9PIOLfotAtruQ38RHFi6LksE3rIGMBsYvoDD55V8B8
         wczQ63GwS5Vtw2EGYpe/mo1KR6yCTCjVJ1xMx5OWesRSQILeDuZSQDzjv0TeDKRxTC4a
         dnpn8Y7u1JQF5LJW7SCW9GJhsbsNMnnAninIH5m1bzWQ8Uk2fw4b41MBwJxCd3irIQWn
         YpWw==
X-Forwarded-Encrypted: i=1; AJvYcCXv1orYRI+zbq1TOfCF7PCCoavXZpCtWixfMQZhl3EPz0PIUvMgEylgFXn8uOMTMH8knm6NrK9d+xw16VuRgwOrk3bAGy0sXuFocb6g8/YwAQ==
X-Gm-Message-State: AOJu0YyCWJVwQTfvk+rT6C6FlCRP7WhKH71F7916sCwRKsAkeOLt5T0S
	CHiz4pp0W2rUu/XtsjAzrMXkVNLx4sAlEdWtZZ3pfVJFh730X2uIUKSolgfoLQ==
X-Google-Smtp-Source: AGHT+IG2W9MyAOiOJVxr5Xta4LFJMxhEydPX2LSZYQBwft9A0f6a7422klHmL7/WusDyegWE2aNcqw==
X-Received: by 2002:a17:90a:ab0e:b0:2ac:116c:6fb5 with SMTP id m14-20020a17090aab0e00b002ac116c6fb5mr424478pjq.11.1713477163948;
        Thu, 18 Apr 2024 14:52:43 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id ju6-20020a170903428600b001e2b36d0c8esm2013911plb.7.2024.04.18.14.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 14:52:43 -0700 (PDT)
Date: Thu, 18 Apr 2024 21:52:39 +0000
From: Mingwei Zhang <mizhang@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Xiong Zhang <xiong.y.zhang@linux.intel.com>, pbonzini@redhat.com,
	peterz@infradead.org, kan.liang@intel.com, zhenyuw@linux.intel.com,
	dapeng1.mi@linux.intel.com, jmattson@google.com,
	kvm@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com,
	eranian@google.com, irogers@google.com, samantha.alt@intel.com,
	like.xu.linux@gmail.com, chao.gao@intel.com
Subject: Re: [RFC PATCH 00/41] KVM: x86/pmu: Introduce passthrough vPM
Message-ID: <ZiGWJ3J1hYBpRjRQ@google.com>
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com>
 <ZhgX6BStTh05OfEd@google.com>
 <ZiGGiOspm6N-vIta@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiGGiOspm6N-vIta@google.com>

On Thu, Apr 18, 2024, Mingwei Zhang wrote:
> On Thu, Apr 11, 2024, Sean Christopherson wrote:
> > <bikeshed>
> > 
> > I think we should call this a mediated PMU, not a passthrough PMU.  KVM still
> > emulates the control plane (controls and event selectors), while the data is
> > fully passed through (counters).
> > 
> > </bikeshed>
> Sean,
> 
> I feel "mediated PMU" seems to be a little bit off the ..., no? In
> KVM, almost all of features are mediated. In our specific case, the
> legacy PMU is mediated by KVM and perf subsystem on the host. In new
> design, it is mediated by KVM only.
> 
> We intercept the control plan in current design, but the only thing
> we do is the event filtering. No fancy code change to emulate the control
> registers. So, it is still a passthrough logic.
> 
> In some (rare) business cases, I think maybe we could fully passthrough
> the control plan as well. For instance, sole-tenant machine, or
> full-machine VM + full offload. In case if there is a cpu errata, KVM
> can force vmexit and dynamically intercept the selectors on all vcpus
> with filters checked. It is not supported in current RFC, but maybe
> doable in later versions.
> 
> With the above, I wonder if we can still use passthrough PMU for
> simplicity? But no strong opinion if you really want to keep this name.
> I would have to take some time to convince myself.
> 

One propoal. Maybe "direct vPMU"? I think there would be many words that
focus on the "passthrough" side but not on the "interception/mediation"
side?

> Thanks.
> -Mingwei
> > 
> > On Fri, Jan 26, 2024, Xiong Zhang wrote:
> > 
> > > 1. host system wide / QEMU events handling during VM running
> > >    At VM-entry, all the host perf events which use host x86 PMU will be
> > >    stopped. These events with attr.exclude_guest = 1 will be stopped here
> > >    and re-started after vm-exit. These events without attr.exclude_guest=1
> > >    will be in error state, and they cannot recovery into active state even
> > >    if the guest stops running. This impacts host perf a lot and request
> > >    host system wide perf events have attr.exclude_guest=1.
> > > 
> > >    This requests QEMU Process's perf event with attr.exclude_guest=1 also.
> > > 
> > >    During VM running, perf event creation for system wide and QEMU
> > >    process without attr.exclude_guest=1 fail with -EBUSY. 
> > > 
> > > 2. NMI watchdog
> > >    the perf event for NMI watchdog is a system wide cpu pinned event, it
> > >    will be stopped also during vm running, but it doesn't have
> > >    attr.exclude_guest=1, we add it in this RFC. But this still means NMI
> > >    watchdog loses function during VM running.
> > > 
> > >    Two candidates exist for replacing perf event of NMI watchdog:
> > >    a. Buddy hardlock detector[3] may be not reliable to replace perf event.
> > >    b. HPET-based hardlock detector [4] isn't in the upstream kernel.
> > 
> > I think the simplest solution is to allow mediated PMU usage if and only if
> > the NMI watchdog is disabled.  Then whether or not the host replaces the NMI
> > watchdog with something else becomes an orthogonal discussion, i.e. not KVM's
> > problem to solve.
> > 
> > > 3. Dedicated kvm_pmi_vector
> > >    In emulated vPMU, host PMI handler notify KVM to inject a virtual
> > >    PMI into guest when physical PMI belongs to guest counter. If the
> > >    same mechanism is used in passthrough vPMU and PMI skid exists
> > >    which cause physical PMI belonging to guest happens after VM-exit,
> > >    then the host PMI handler couldn't identify this PMI belongs to
> > >    host or guest.
> > >    So this RFC uses a dedicated kvm_pmi_vector, PMI belonging to guest
> > >    has this vector only. The PMI belonging to host still has an NMI
> > >    vector.
> > > 
> > >    Without considering PMI skid especially for AMD, the host NMI vector
> > >    could be used for guest PMI also, this method is simpler and doesn't
> > 
> > I don't see how multiplexing NMIs between guest and host is simpler.  At best,
> > the complexity is a wash, just in different locations, and I highly doubt it's
> > a wash.  AFAIK, there is no way to precisely know that an NMI came in via the
> > LVTPC.
> > 
> > E.g. if an IPI NMI arrives before the host's PMU is loaded, confusion may ensue.
> > SVM has the luxury of running with GIF=0, but that simply isn't an option on VMX.
> > 
> > >    need x86 subsystem to reserve the dedicated kvm_pmi_vector, and we
> > >    didn't meet the skid PMI issue on modern Intel processors.
> > > 
> > > 4. per-VM passthrough mode configuration
> > >    Current RFC uses a KVM module enable_passthrough_pmu RO parameter,
> > >    it decides vPMU is passthrough mode or emulated mode at kvm module
> > >    load time.
> > >    Do we need the capability of per-VM passthrough mode configuration?
> > >    So an admin can launch some non-passthrough VM and profile these
> > >    non-passthrough VMs in host, but admin still cannot profile all
> > >    the VMs once passthrough VM existence. This means passthrough vPMU
> > >    and emulated vPMU mix on one platform, it has challenges to implement.
> > >    As the commit message in commit 0011, the main challenge is 
> > >    passthrough vPMU and emulated vPMU have different vPMU features, this
> > >    ends up with two different values for kvm_cap.supported_perf_cap, which
> > >    is initialized at module load time. To support it, more refactor is
> > >    needed.
> > 
> > I have no objection to an all-or-nothing setup.  I'd honestly love to rip out the
> > existing vPMU support entirely, but that's probably not be realistic, at least not
> > in the near future.
> > 
> > > Remain Works
> > > ===
> > > 1. To reduce passthrough vPMU overhead, optimize the PMU context switch.
> > 
> > Before this gets out of its "RFC" phase, I would at least like line of sight to
> > a more optimized switch.  I 100% agree that starting with a conservative
> > implementation is the way to go, and the kernel absolutely needs to be able to
> > profile KVM itself (and everything KVM calls into), i.e. _always_ keeping the
> > guest PMU loaded for the entirety of KVM_RUN isn't a viable option.
> > 
> > But I also don't want to get into a situation where can't figure out a clean,
> > robust way to do the optimized context switch without needing (another) massive
> > rewrite.
