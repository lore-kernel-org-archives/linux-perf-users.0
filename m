Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D841CDA0D
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732024817; cv=none; b=BMn8p2obLBrA9bIl2hd26MJiuj6J3u5zfruvVnjXQR5yGC9kYTam4VA8DON3ef9P3qicGC6Xpj59OS0mXoCX+mgLYA14mhzaLoECMESwDP1m1UNPMK7gg5gJ4i3SXd2vxbWmB2x4RxXkJkWrjTnbr8R7kzF45thAjTn4RJ+PXTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732024817; c=relaxed/simple;
	bh=NNmtEzPeJrsLehi1WhmNqlBFpj9Ip1FKTLN9uY9VKy8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dt3mdjq0hCVRNAHaSed48C+yYe4GNYTuFvkynCV1WedfNkf1ilSMkH+Zd2kxbrSPFN6PHltxdGVBBgQYZfbqkVYZsnMtogGpsujjyyZjF7PPQYemTymakbPds+2bdhAtPm+CPH+pGu7bTm0yPYQ4lKo5fzFvCuXCtAnZcrwX3hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LN+rsl3Y; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LN+rsl3Y"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8a5e862eso70760617b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 06:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732024815; x=1732629615; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AOXHJiJ+SXG98Hij2HNzlC3M3lEHF7DmQUkB5bHSfGg=;
        b=LN+rsl3YfrD7jub0g9i8zCtO75raMuZ8fZoJ65yh01Z8d+Us5eC+GK0qJ2npCXhp0W
         TSsQkReELxkRagA9kf0f3mKz+dcHXsT4EsjhfkpUa3BnuAisaCaSEu/F5Mgxqd2i29+3
         nNt4TFvlcBQL0ZEDnrs+onSFhWR0mFP/fyQNUYdSxE9+MYdCATa0jxkob4gIe6LC/umD
         +0v+06800fnvUpLONY603olu6U7d8asCOaPRV2ltYmwmR0oecZ1sC9WXTSDtio4kwyn4
         ZN+WJ6gDh4giqmR1Rmyq7xs2gDhP+nyr5QuuveoMdqIHgswRgr1k5O+EtPw1xEUIFnxn
         DjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732024815; x=1732629615;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AOXHJiJ+SXG98Hij2HNzlC3M3lEHF7DmQUkB5bHSfGg=;
        b=wVt6kFs0yfaCCCXhyeC2P+FReOdI6wvYNlyVFeRCjFJcuUjs4E4Q1jgase4DcVnW0J
         rHgENFIZAxtMUXoTCQIZKmrcwYA38C/OiMt5FeLjzRoLBHjRlRPOtJqkXq3l2jiINPdL
         9sFbTFEfx2MliimDmr0C4ix1YG/B9g32WHaPuSDztJ15AjUK1hxFVa3rrfK9qHzJHfE0
         510wFgc3LWYTGmaUHpSfgqyN1GDxiEx3W8pbg3QLefioztJ3RZZhA3F1qYlEuepYc4ta
         Q1IsAF6MO4mrpcfeC5T+yAWCn5aEgOyb+JA4QNl25ZEvNpURox/Ii0TZV0UC1zcpNHoF
         RBuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXurdJjegnXAKMLewmbbjCpikojxrBC47ckhCcUjxL3fS3yJ6rE8gHVFwyN/CGrXnB9dN+rAXq6+s8arqvoQcU9@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxsq3F7R+ry9qcnChIbmjlHSDyOb0Rw7JJT+6XwO9X1Ezdo2bb
	Obe0IDSEtdkBfR+r4Gqeh5feMACGWiJQcX/QDW31c5LsvLI5XcOPSo6L0updD3VpRR0bxCa8LCT
	nNQ==
X-Google-Smtp-Source: AGHT+IF84+tXqMFcYD1nE5UAQFaK7SulZziKQGYlSvVLsWe37f0ou2CMMA7A5s+Ie0wwJEMH08XgyMK5H9I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:4512:b0:620:32ea:e1d4 with SMTP id
 00721157ae682-6eeaa0028f4mr1943287b3.0.1732024814819; Tue, 19 Nov 2024
 06:00:14 -0800 (PST)
Date: Tue, 19 Nov 2024 06:00:13 -0800
In-Reply-To: <20240801045907.4010984-1-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com>
Message-ID: <ZzyZ7U9C3EZyudz7@google.com>
Subject: Re: [RFC PATCH v3 00/58] Mediated Passthrough vPMU 3.0 for x86
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Xiong Zhang <xiong.y.zhang@intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Kan Liang <kan.liang@intel.com>, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Manali Shukla <manali.shukla@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Jim Mattson <jmattson@google.com>, 
	Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>, 
	Namhyung Kim <namhyung@kernel.org>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, Like Xu <like.xu.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 01, 2024, Mingwei Zhang wrote:
> This series contains perf interface improvements to address Peter's
> comments. In addition, fix several bugs for v2. This version is based on
> 6.10-rc4. The main changes are:
> 
>  - Use atomics to replace refcounts to track the nr_mediated_pmu_vms.
>  - Use the generic ctx_sched_{in,out}() to switch PMU resources when a
>    guest is entering and exiting.
>  - Add a new EVENT_GUEST flag to indicate the context switch case of
>    entering and exiting a guest. Updates the generic ctx_sched_{in,out}
>    to specifically handle this case, especially for time management.
>  - Switch PMI vector in perf_guest_{enter,exit}() as well. Add a new
>    driver-specific interface to facilitate the switch.
>  - Remove the PMU_FL_PASSTHROUGH flag and uses the PASSTHROUGH pmu
>    capability instead.
>  - Adjust commit sequence in PERF and KVM PMI interrupt functions.
>  - Use pmc_is_globally_enabled() check in emulated counter increment [1]
>  - Fix PMU context switch [2] by using rdpmc() instead of rdmsr().
> 
> AMD fixes:
>  - Add support for legacy PMU MSRs in MSR interception.
>  - Make MSR usage consistent if PerfMonV2 is available.
>  - Avoid enabling passthrough vPMU when local APIC is not in kernel.
>  - increment counters in emulation mode.
> 
> This series is organized in the following order:
> 
> Patches 1-3:
>  - Immediate bug fixes that can be applied to Linux tip.
>  - Note: will put immediate fixes ahead in the future. These patches
>    might be duplicated with existing posts.
>  - Note: patches 1-2 are needed for AMD when host kernel enables
>    preemption. Otherwise, guest will suffer from softlockup.
> 
> Patches 4-17:
>  - Perf side changes, infra changes in core pmu with API for KVM.
> 
> Patches 18-48:
>  - KVM mediated passthrough vPMU framework + Intel CPU implementation.
> 
> Patches 49-58:
>  - AMD CPU implementation for vPMU.

Please rename everything in KVM to drop "passthrough" and simply use "mediated"
for the overall concept.  This is not a passthrough setup by any stretch of the
word.  I realize it's a ton of renaming, but calling this "passthrough" is very
misleading and actively harmful for unsuspecting readers.

For helpers and/or comments that deal with intercepting (or not) MSRs, use
"intercept" and appropriate variations.  E.g. intel_pmu_update_msr_intercepts().

And for RDPMC, maybe kvm_rdpmc_in_guest() to follow kvm_{hlt,mwait,pause,cstate_in_guest()?
I don't love the terminology, but there's a lot of value in being consistent
throughout KVM.

I am not willing to budge on this, at all.

I'm ok with the perf side of things using "passthrough" if "mediated" feels weird
in that context and we can't come up with a better option, but for the KVM side,
"passthrough" is simply wrong.
