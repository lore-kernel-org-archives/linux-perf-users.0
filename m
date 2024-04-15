Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D66762C9
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Apr 2024 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193523; cv=none; b=F19uoNhiq191ISvTvAFAZ/7ND8buWxnrS0L3m6ee5vbBcUNFKi5mTmAxDQbF5hZutnJLrttxslEPVQz0JLdSwzL0ZMfw8NEpHL/pUUbXA1srOuG2peY5a7qe+Mg6Gyb5nRuQpmyphtSxKusD+Xmw8U9LXmXgAJDfg1SlXvyzYC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193523; c=relaxed/simple;
	bh=cb5LU6UaG6mCWdz046rKlGo0stuTeCVzOZo2+XGijNA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VQfk/ERCFj6DCwWaMgv6/azEq8V3gHQcQXlJjQsUDSAPRgrC5304cgiwNrplRJS4xjzl1LG3ZFXazHCZTrbHZOd1480fTmXZ+uJBTe+Pl3Yt1vf4E27Pn7C1uQaxY+oMIVK7X7xythfM3x2XwjxoPvp3GwIkA50sBt4rc5zY4lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZBlNeQBz; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZBlNeQBz"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5ca4ee5b97aso1853108a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Apr 2024 08:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713193522; x=1713798322; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SuVb06F6Umo7w+6KN9zon9oyW6hYaksRHCECH15MmFs=;
        b=ZBlNeQBzzD39USQV4lQSX6WrcoklFD9NW0c4qPmRBdW8NLfAD4/kS/lmRulYQDyH92
         m5z8F4C+c9dZzluHbT2S3okES3oPdmKsu2ZaHHAiEfL6YqPxVzLQ130qIuNiACKppDpR
         Uurle3zSkmDP6n66B4S9CuGCN4wfKHY+55c2UhAzSQ3HrZvGGMFeTp1iaM3FzgRyx8rj
         l5gA4xgz7xJ7cbwHxrcLQlaGcuOATonP4UEyACnI98t5cNBmyS2gr8Z7yn5+jlaxmynX
         a2sFZRJsZEEOBJFLsVkOj1iM/Ndt8sSw5rJga7lmkoLKpmwoW934Oe01ZbxWp0aUrERy
         U0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713193522; x=1713798322;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SuVb06F6Umo7w+6KN9zon9oyW6hYaksRHCECH15MmFs=;
        b=j688TFvCot+9/J92tECA4L2E7FNG3SOjqMhroNKh1S8sKaxbpXZUtSGAClJw4BCZmG
         NDe028PdWiRuyYAMXp54U0qfmNaQ+Pqhik6CJU+3rRE2rIjvez8PoChfwKEyyFDcK9is
         H8BxPcVkuQwVkVlEMC8spv8wY+6PXZg/1xVEHPTPIjcNMEs6p+FcfFSAPgRj3GzjZuHB
         75bBh0bboUBnzLAQXEPQI0E3wl+FnbGpV6fmEBekdJBxFS8V7cDSClu5KnvSTMtApp2I
         NI6NOQ0guZGPrTt6VtFBHOYkbdqt499aoJWFK+ZQQ4N+OyZAJkDJg9HD+xpV6DL+hfHk
         Hwpg==
X-Forwarded-Encrypted: i=1; AJvYcCUrxQrMjNUAFtzqFcpU0DEFD/R3QRQih4VOVSUarxzWAPZwWYLOH+UJhvqj/hoEByPzBI12VwrMNS0vNuKJrl1IqdPA13uiL8xgvGPvFM49Sw==
X-Gm-Message-State: AOJu0YyhDAlWY+t7U+uWELkhfw7LGxa80pZUxRZ9rticeOoidc4EXSlm
	eKMs9fZFn9rLuWGjNPRYkM7p+wKMxt8OiLnGIycQ+facXWRNtzTg+wLxVtTSCx7ZVhPz9M4EvmE
	qWQ==
X-Google-Smtp-Source: AGHT+IFNVZQ/MDJQfcv6+VmiHpGKHgYit0QrR1jndoJek9xGhKOIiS0f9IOscBG23RSnBreqsUFbs1m2Wmg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:ff21:0:b0:5dc:aa2a:777c with SMTP id
 k33-20020a63ff21000000b005dcaa2a777cmr28179pgi.6.1713193521588; Mon, 15 Apr
 2024 08:05:21 -0700 (PDT)
Date: Mon, 15 Apr 2024 08:05:19 -0700
In-Reply-To: <9469faf7-1659-4436-848f-53ec01d967f2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com>
 <ZhgX6BStTh05OfEd@google.com> <f6f714ef-eb58-4aa9-9c4d-12bfe29c383b@linux.intel.com>
 <Zhl-JFk5hw-hlyGi@google.com> <9469faf7-1659-4436-848f-53ec01d967f2@linux.intel.com>
Message-ID: <Zh1CL8Gf1YpBvvXd@google.com>
Subject: Re: [RFC PATCH 00/41] KVM: x86/pmu: Introduce passthrough vPM
From: Sean Christopherson <seanjc@google.com>
To: Xiong Y Zhang <xiong.y.zhang@linux.intel.com>
Cc: pbonzini@redhat.com, peterz@infradead.org, mizhang@google.com, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 15, 2024, Xiong Y Zhang wrote:
> On 4/13/2024 2:32 AM, Sean Christopherson wrote:
> > On Fri, Apr 12, 2024, Xiong Y Zhang wrote:
> >>>> 2. NMI watchdog
> >>>>    the perf event for NMI watchdog is a system wide cpu pinned event, it
> >>>>    will be stopped also during vm running, but it doesn't have
> >>>>    attr.exclude_guest=1, we add it in this RFC. But this still means NMI
> >>>>    watchdog loses function during VM running.
> >>>>
> >>>>    Two candidates exist for replacing perf event of NMI watchdog:
> >>>>    a. Buddy hardlock detector[3] may be not reliable to replace perf event.
> >>>>    b. HPET-based hardlock detector [4] isn't in the upstream kernel.
> >>>
> >>> I think the simplest solution is to allow mediated PMU usage if and only if
> >>> the NMI watchdog is disabled.  Then whether or not the host replaces the NMI
> >>> watchdog with something else becomes an orthogonal discussion, i.e. not KVM's
> >>> problem to solve.
> >> Make sense. KVM should not affect host high priority work.
> >> NMI watchdog is a client of perf and is a system wide perf event, perf can't
> >> distinguish a system wide perf event is NMI watchdog or others, so how about
> >> we extend this suggestion to all the system wide perf events ?  mediated PMU
> >> is only allowed when all system wide perf events are disabled or non-exist at
> >> vm creation.
> > 
> > What other kernel-driven system wide perf events are there?
> does "kernel-driven" mean perf events created through
> perf_event_create_kernel_counter() like nmi_watchdog and kvm perf events ?

By kernel-driven I meant events that aren't tied to a single userspace process
or action.

E.g. KVM creates events, but those events are effectively user-driven because
they will go away if the associated VM terminates.

> User can create system wide perf event through "perf record -e {} -a" also, I
> call it as user-driven system wide perf events.  Perf subsystem doesn't
> distinguish "kernel-driven" and "user-driven" system wide perf events.

Right, but us humans can build a list, even if it's only for documentation, e.g.
to provide help for someone to run KVM guests with mediated PMUs, but can't
because there are active !exclude_guest events.

> >> but NMI watchdog is usually enabled, this will limit mediated PMU usage.
> > 
> > I don't think it is at all unreasonable to require users that want optimal PMU
> > virtualization to adjust their environment.  And we can and should document the
> > tradeoffs and alternatives, e.g. so that users that want better PMU results don't
> > need to re-discover all the "gotchas" on their own.
> > 
> > This would even be one of the rare times where I would be ok with a dmesg log.
> > E.g. if KVM is loaded with enable_mediated_pmu=true, but there are system wide
> > perf events, pr_warn() to explain the conflict and direct the user at documentation
> > explaining how to make their system compatible with mediate PMU usage.> 
> >>>> 3. Dedicated kvm_pmi_vector
> >>>>    In emulated vPMU, host PMI handler notify KVM to inject a virtual
> >>>>    PMI into guest when physical PMI belongs to guest counter. If the
> >>>>    same mechanism is used in passthrough vPMU and PMI skid exists
> >>>>    which cause physical PMI belonging to guest happens after VM-exit,
> >>>>    then the host PMI handler couldn't identify this PMI belongs to
> >>>>    host or guest.
> >>>>    So this RFC uses a dedicated kvm_pmi_vector, PMI belonging to guest
> >>>>    has this vector only. The PMI belonging to host still has an NMI
> >>>>    vector.
> >>>>
> >>>>    Without considering PMI skid especially for AMD, the host NMI vector
> >>>>    could be used for guest PMI also, this method is simpler and doesn't
> >>>
> >>> I don't see how multiplexing NMIs between guest and host is simpler.  At best,
> >>> the complexity is a wash, just in different locations, and I highly doubt it's
> >>> a wash.  AFAIK, there is no way to precisely know that an NMI came in via the
> >>> LVTPC.
> >> when kvm_intel.pt_mode=PT_MODE_HOST_GUEST, guest PT's PMI is a multiplexing
> >> NMI between guest and host, we could extend guest PT's PMI framework to
> >> mediated PMU. so I think this is simpler.
> > 
> > Heh, what do you mean by "this"?  Using a dedicated IRQ vector, or extending the
> > PT framework of multiplexing NMI?
> here "this" means "extending the PT framework of multiplexing NMI".

The PT framework's multiplexing is just as crude as regular PMIs though.  Perf
basically just asks KVM: is this yours?  And KVM simply checks that the callback
occurred while KVM_HANDLING_NMI is set.

E.g. prior to commit 11df586d774f ("KVM: VMX: Handle NMI VM-Exits in noinstr region"),
nothing would prevent perf from miscontruing a host PMI as a guest PMI, because
KVM re-enabled host PT prior to servicing guest NMIs, i.e. host PT would be active
while KVM_HANDLING_NMI is set.

And conversely, if a guest PMI skids past VM-Exit, as things currently stand, the
NMI will always be treated as host PMI, because KVM will not be in KVM_HANDLING_NMI.
KVM's emulated PMI can (and should) eliminate false positives for host PMIs by
precisely checking exclude_guest, but that doesn't help with false negatives for
guest PMIs, nor does it help with NMIs that aren't perf related, i.e. didn't come
from the LVTPC.

Is a naive implementation simpler?  Maybe.  But IMO, multiplexing NMI and getting
all the edge cases right is more complex than using a dedicated vector for guest
PMIs, as the latter provides a "hard" boundary and allows the kernel to _know_ that
an interrupt is for a guest PMI.
