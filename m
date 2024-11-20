Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069BB13BAF1
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Nov 2024 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732138772; cv=none; b=mcuxYeDP2yWLu0uzYQhCU5SdjQb3VZOgZZwYxkJfVNx2T6WCyaqisDt0p5AhNNG3mUzfVK9Z6JfjwYk9AM+7TstXmNlLFNEVZ5OAgkNTW2NaJ9koSEUOd13JHcADjaH1G3St2c59FTYiTDUgmBC92T1sWghuqwXYNPCL5dvLXGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732138772; c=relaxed/simple;
	bh=/BQe4Gbb+uFT+ujNwYhSJw/aS998Q0OG/ciGQw1NrNA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Oc+jFWwoQVl4cbfQBZ1Py/JZz78lWd/LIRZE/MntSgu/Pr3G2EPApZsVInd8iv1O2Q1RPAuCfkxu/EHFBoWgJo+Yoz5T9foy9kLIxpm+DTKitXF/BOi/qcRaRLvbV5cHSx+zN368iiviw71vCKtg6YqGm1JNi3P9sb94xYOaq3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q8QgZP5t; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q8QgZP5t"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7eb07db7812so152479a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Nov 2024 13:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732138770; x=1732743570; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gj0xnR+YihGSrOOdkMHXu8Ean1HEzyg0u0w41evgapo=;
        b=q8QgZP5tgWw/BTYORJMBbSnpnAhvLI3oBXhF244HP34+iQ+BO0ZHHYH2ohDJkOKyvz
         SDuTLuNlpPrpeI4oXUuG/BSYDZpWJOPvEUVYXfUZM4AFeh24GnqudDm7U/x+7CfKJ1LX
         2H+lyeTAVLMBn8vUyLcnEs/du9ltOqxPCgArAGgSXqie2WDKzV8Molm3JNoot66KD8qH
         3Mki1ritvbF+u86v1+2YPf+4WRxHIg6lPmubUwtz9bQwNQgyef6wDJEzY7Cb8xarrB7C
         0dS3YndkdjBxhfVtDIexLgUtWV6zzuphlqNOs3iA18ZC8vE/kuu8uDm4I9e78ebfJu5m
         4Wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732138770; x=1732743570;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gj0xnR+YihGSrOOdkMHXu8Ean1HEzyg0u0w41evgapo=;
        b=nE/e5nle/D54JZNvvxz6ex/T48BWCJyPG6nvUhyOo/ZacHzMZYPDMH+sqx6ZQM0oSX
         vJetCBdPb4uqjfMp/LFb6qu4BuQ2JHMfVztC4IZrqjyV6N8gPR53Jh48LQPGeUmYEbQT
         R5nSldqqtWgFDDJ70NF1uep5KcdyUPG8Hmq3bCo3uo4Kni6NnhI1CFsVibW7e8+/X9ok
         GVQ0YN5I5ZdRfVEKFS+eya4MSU9Zk3pUfb2K8wHihtwpwPLygcijk8q/4LUNur43WXlt
         4gXpKCQci3GpaIK0o8Mf5pL7sRbUaV1SinpJKyI6i5aqDmJt36tUOT/pThMMd+Gvtj9D
         YZ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX04cGlNZQKTKKax0KEYFvJDPM0gFsvhAzJwyPNjPTgA6NjPFrvmHovFaxOD2u8ZbMJyusnq4NB+l1fKf/Z2UKJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyGpIJBGDR5dkHrGGHLdKbvqAXbczH1bJgqS9DmTWYYGXJXDHaM
	AEEDy8KxcwhukFRNEL5Vf7VOkhyjzqXyIUkpdLcr3F9DPBpSiU9RMvcYh9/Xn4p5zKByVlTy/QF
	Acw==
X-Google-Smtp-Source: AGHT+IFwgpeCsF7E/mW3H6upLySUXX0/rHDdngq/k4/nA2K9Ab8EASBovRUGrgle1qVrbu3iHARQK/Uppmw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:7e57:0:b0:7a1:6a6b:4a5b with SMTP id
 41be03b00d2f7-7fbb44c2dfbmr540a12.2.1732138769987; Wed, 20 Nov 2024 13:39:29
 -0800 (PST)
Date: Wed, 20 Nov 2024 13:39:28 -0800
In-Reply-To: <20240801045907.4010984-57-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com> <20240801045907.4010984-57-mizhang@google.com>
Message-ID: <Zz5XEDX8NqnrHhj3@google.com>
Subject: Re: [RFC PATCH v3 56/58] KVM: x86/pmu/svm: Wire up PMU filtering
 functionality for passthrough PMU
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
> From: Manali Shukla <manali.shukla@amd.com>
> 
> With the Passthrough PMU enabled, the PERF_CTLx MSRs (event selectors) are
> always intercepted and the event filter checking can be directly done
> inside amd_pmu_set_msr().
> 
> Add a check to allow writing to event selector for GP counters if and only
> if the event is allowed in filter.

This belongs in the patch that adds AMD support for setting pmc->eventsel_hw.
E.g. reverting just this patch would leave KVM in a very broken state.  And it's
unnecessarily difficult to review.

> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/kvm/svm/pmu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index 86818da66bbe..9f3e910ee453 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
> @@ -166,6 +166,15 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		if (data != pmc->eventsel) {
>  			pmc->eventsel = data;
>  			if (is_passthrough_pmu_enabled(vcpu)) {
> +				if (!check_pmu_event_filter(pmc)) {
> +					/*
> +					 * When guest request an invalid event,
> +					 * stop the counter by clearing the
> +					 * event selector MSR.
> +					 */
> +					pmc->eventsel_hw = 0;
> +					return 0;
> +				}
>  				data &= ~AMD64_EVENTSEL_HOSTONLY;
>  				pmc->eventsel_hw = data | AMD64_EVENTSEL_GUESTONLY;
>  			} else {
> -- 
> 2.46.0.rc1.232.g9752f9e123-goog
> 
