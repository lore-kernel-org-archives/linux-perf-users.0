Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EFB386575
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 23:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778282037; cv=none; b=BDEUhzmdWluSHYTVX+dmSpH4ohJWGw9u/VoNGewOJeHKq2BF1M1GAGekOnk6Xuh5l7covBFLCOy9OPnk8B+DuzSOXaM3EFAH5Q2UHZrkYJFNgNFq6YV5qT8jqrCCz0+YJl7PvEyUeuV/f7Tl3cE0uLzByAegCWLmyTB1etOEbi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778282037; c=relaxed/simple;
	bh=rnvoE/xB7a5bFEXpoj9AvEEEt+M9LTp2jfe7XdGzg28=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lN0bNqg/KgHOoOJMKm0pBPExVRJ5TKKCfl4cqzoZzWDO3IFWGTVgAEFMoHD+BxTs91o0zyw2d/St5kPV4f2NSTJ6H0Jg+LkCSijuA/FXObFWgfafGKztzgZkFOA2SWfXTlrYlfWUiUYURZHrvxhni828nxYlRwV5xmOOd/yy5Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JOphXGSh; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JOphXGSh"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c6e24ee93a6so2049879a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 08 May 2026 16:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778282036; x=1778886836; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+4lRAP9/8mOHdhTtrTDIWQTXnIlr9s4JbegNLLxb7s=;
        b=JOphXGShk+yuZLsX0Q/LhB5VeJKqUteTXyaAlZdIDu9oZyb7qOESUIKpzbmi2ahRdB
         LPsU7OhqxiFUQaeN1hrx8kznMNXKDGW/+QoQk26mQkr2gLP+ZBKoEepzMkPck+eXXJ4C
         B+krKM7rchax+NAz8yuzXJKwVK+k1qeE8PCZHXgkWpm4/sPAvm/zJrThCMmMuTXNA773
         QkvYpqpZGZrJnlUGwSudWnPZMrPihi0Pj6w30B1DJg2IlUprXL2R4QwyNQq2C4k2wpYE
         N492DTp9x+pEFNqc7rb0U5rY55MDOag6u9XuywOamBnPrTTLsQ9DBTD6g0ARP3ZUtuha
         XhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778282036; x=1778886836;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+4lRAP9/8mOHdhTtrTDIWQTXnIlr9s4JbegNLLxb7s=;
        b=P5d0TgXUxZTwG40gXxcF8AEDhzy7RdrsYc33KuHzZlYGfrlpISTufTFqxv4zRZB+xK
         Y+f+EZlL9dq9iM4uVpmo7HqkkTxq8DV9b96c/Ei+pdDYZJZaqmIpL4TiUW+2MTMPPYnp
         nEMHPVxLh5OWLGcrDPPnEFiCA28QgfZso87YlpQ7+tu86KQZdXUwc4TKNDbEQmp1iv2i
         uSx8mpK3Shb6dwpjAd8IDX9HR+7ymk4Mpb7CseYih7DBtrDRNWzaDyOqFbikqlDSMo60
         Yzc4K7V7l7ITwzMu+9B+pI8SRICqGbtDP819b65m8jtMfq2xy122JqMO/4eDRv3SDA8t
         UK+g==
X-Forwarded-Encrypted: i=1; AFNElJ+LQuzHxGYX6w9sWM5/pvbQ7hUY31AqS2+KlhKYpLDWU9Lt+mbU/Pytk9DwnXg0oBxyjx6P/XGS15x3sPfkipa/@vger.kernel.org
X-Gm-Message-State: AOJu0YwUa9Etwc58xAlNNVv2j7XQIEfXrNZBSsEbpOdD/CFZpO4CF+AM
	3iN6o4VZgtC4Zj6LkBYJysVu869trRVdsKkjDQyK6AfpRRqlMA/gQhV7/tR8Oo1uxGivEaI00On
	Z7gmpJA==
X-Received: from pgbdo11.prod.google.com ([2002:a05:6a02:e8b:b0:c79:7d5e:795c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12cf:b0:39c:2d2a:632e
 with SMTP id adf61e73a8af0-3aa8bebfecdmr8604917637.11.1778282035372; Fri, 08
 May 2026 16:13:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 May 2026 16:13:44 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508231353.406465-1-seanjc@google.com>
Subject: [PATCH v3 0/9] perf/x86: Don't write PEBS_ENABLED on KVM transitions
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Stephane Eranian <eranian@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Rework the handling of PEBS_ENABLED (and related PEBS MSRs) to *never* touch
PEBS_ENABLED if the CPU provides PEBS isolation, in which case disabling
counters via PERF_GLOBAL_CTRL is sufficient to prevent generation of unwanted
PEBS records.  For vCPUs without PEBS enabled, this saves upwards of 7 MSR
writes on each roundtrip between the guest and host (KVM performs an immediate
WRMSR to zero out PEBS_ENABLED if it's in the load list).  For vCPUS with PEBS,
this saves 3 MSR writes per roundtrip.

E.g. without PEBS activity in the host, for a guest with a vPMU, this reduces
the roundtrip time for a fastpath exit from ~1120 => ~860 cycles on EMR.  With
host PEBS active, the reduction is ~1450 => ~900 cycles.

However, performance isn't the underlying motiviation (well, at least, it
didn't start that way).  Jim, Mingwei, and Stephane have been chasing issues
where PEBS_ENABLED bits can get "stuck" in a '1' state when running KVM guests
while profiling the host with PEBS events.  The working theory is that perf
throttles PEBS events in NMI context, and thus clears bits in cpuc->pebs_enabled
and PEBS_ENABLED, after generating the list of PMU MSRs to context switch but
before VM-Entry.  And so when the host's PEBS_ENABLED is loaded on VM-Exit, the
CPU ends up with a stale PEBS_ENABLED that doesn't get reset until something
triggers an explicit reload in perf.

Note, as Peter pointed out, more than likely KVM needs to zero PERF_GLOBAL_CTRL
before invoking perf_guest_get_msrs(), as that's the only way to guarantee
stable output.  I deliberately didn't include that here, as I want to keep this
series focused on PEBS.  I also wanted to let Jim and company bottom out on
their investigation (still ongoing) before pursuing fixes that we'll probably
want to send to stable@.

v3:
 - Ensure guest PEBS_ENABLE is a subset of intel_ctrl. [Jim]
 - Rename intel_ctrl_{guest,host}_mask to be less confusing. [Jim]
 - Do even more cleanup of the cross-mapped handling, and specifically avoid
   overhead when PEBS isn't in use. [Sashiko]
 - Leave behind a FIXME regarding the "disable guest PEBS if host is using
   PEBS" code.  I still don't know for sure why that restriction is in place,
   and I'm too scared too change it. :-)

v2:
 - https://lore.kernel.org/all/20260423150340.463896-1-seanjc@google.com
 - "Load" the host value for the guest when an MSR should remain unchanged,
    instead of omitting the MSR from the list entirely, as KVM may need to
    _remove_ the MSR from the list. [Sashiko, Jim]
 - Collect Jim's reviews. [Jim]
 - Call out that the bug being fixed is theoretical at this point.
 - Dropping PEBS_ENABLED from the lists save three MSR writes, not two, as
   KVM performs an explicit WRMSR prior to VM-Entry to guarantee PEBS is
   quiesced.

v1: https://lore.kernel.org/all/20260414191425.2697918-1-seanjc@google.com


Sean Christopherson (9):
  perf/x86/intel: Ensure guest PEBS path doesn't set unwanted
    PERF_GLOBAL_CTRL bits
  perf/x86/intel: Don't write PEBS_ENABLED on host<=>guest xfers if CPU
    has isolation
  perf/x86/intel: Don't context switch DS_AREA (and PEBS config) if PEBS
    is unused
  perf/x86/intel: Make @data a mandatory param for
    intel_guest_get_msrs()
  perf/x86/intel: Invert names of intel_ctrl_{guest,host}_mask
  perf/x86: KVM: Have perf define a dedicated struct for getting guest
    PEBS data
  perf/x86/intel: KVM: Handle cross-mapped PEBS PMCs entirely within KVM
  KVM: VMX: Drop a redundant pmu->global_ctrl check when processing
    pebs_enable
  KVM: VMX: Only tell perf to enable PEBS counters for fully enabled
    PMCs

 arch/x86/events/core.c            |  5 +-
 arch/x86/events/intel/core.c      | 92 +++++++++++++++++++------------
 arch/x86/events/intel/lbr.c       |  2 +-
 arch/x86/events/perf_event.h      |  7 ++-
 arch/x86/include/asm/kvm_host.h   |  9 ---
 arch/x86/include/asm/perf_event.h | 11 +++-
 arch/x86/kvm/vmx/pmu_intel.c      | 28 +++++++---
 arch/x86/kvm/vmx/vmx.c            | 10 ++--
 arch/x86/kvm/vmx/vmx.h            | 15 ++++-
 9 files changed, 114 insertions(+), 65 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.54.0.563.g4f69b47b94-goog

