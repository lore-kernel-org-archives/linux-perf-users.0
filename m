Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5F530DD2A
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776194071; cv=none; b=g3nhFSUxk4TWWQmonprqQn6ppJtw1Ud1YWmGG+Bm3Vr9bXlASNoGaHgZV8OsTJHzu/uIDyIIxolyV8fU8XzvK+pxUsKWd1zhF/qapai/raKEsiAoLEdo8hZ5O/uDx+Txc0hA7z7RVUeycYfAgHtoH2rFWgVFkbxJ1n2JOwNbM2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776194071; c=relaxed/simple;
	bh=Hqjfb4UHro0/tCw0trNzNsptlp3oTgVT7DeeM9tnrSE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SJuXFzgykAH7jq+lFiGamttOrFVkJGWZUSz/fExLcYmjgC3b3TLIAd8z4PnbrXMSpYFamWu80PtT7Bv1GQkX3oumTw3SUREpCgiQIMincJMqm3pyWIhQEvPoZTs60uRfSkOvFxHhEZNNcIf5RRdgPVNdO1f4oorvUrLTN/aiGPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M/Lp7cOq; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/Lp7cOq"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f0f2b2641so3079408b3a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 12:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776194070; x=1776798870; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBk0Qgh13xOWDZmdaDsLDUaSKogcM0uH9b/OnvPK9Jg=;
        b=M/Lp7cOqEVj4wr6pX8fwgPoSwbu1VPKQr5qC4JVEksJld27b30GAm8BVdGmAOzsqMf
         /fw7gGicC2Wh6buhML0l9if+AIwUCEJ5w02JlcOqY5qEJUbFgl/b7M80Y2JQ2T/jZDuv
         WtTDPMwvKh2mN6QkymmIaHAnmphGwJ7BJegcb5ypk013V0FSGIMtEaQvtSY1TyBxcuiD
         KxAFcHjHJfjw7V6ptuf7UO4nKodY5e+NGVSuQ0h0JDSVoL9sJiCPJ8PtclekEzS5rkcs
         J0CVLSw64tJbeFEUKtLExics6bnzQuuUfUkTakGRgPDUUI6R+YNfCwNRXLOuJGWP4ySv
         oyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776194070; x=1776798870;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DBk0Qgh13xOWDZmdaDsLDUaSKogcM0uH9b/OnvPK9Jg=;
        b=AnkoZmQgFbkI6GCv6ZsMSsExLA9b8fsIG7/AqrSGRgP/vrG03IPAxfA7PvL2cs8H3f
         /igOl6zxuyiPB+NsJG8YdU5R8yLATeWvxyUaExGG+IcNOslQdod+CHauzlh3pxqCfGiG
         I74q+A/aww/vZzumgEOtS9nfNWSgZu0sf1lhKruEOSi3qfAXaokI7ZDF8DcdnPoRFZC5
         tJ7iwm3I7yUYuCZLmHMk2V9yBhan9Q+lC+tViHo7H92MCLdekPmCB+F8d7NuC8Mv/zRA
         7+vy4IoX2c5qc7YmwhmNEfs4ZFMbJmTTDsPphpfR2qmUH2mtK33P61+w5YXAnlbK3wlR
         ENFQ==
X-Gm-Message-State: AOJu0YzJo7yLvhMdrzQ8v9XiZTXlJYG4ulvyAoALCdTcyFlcXbujp2XQ
	61fzgUtJFFz7aRjTPPvofPLHs5ZxRFzwJOYpP5F7IQ1MvWyW7H9IjemPQ1/ncSaSEqitQj8xfVT
	T4eHA3A==
X-Received: from pfbkh38.prod.google.com ([2002:a05:6a00:9466:b0:82a:5ddb:b051])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:35ce:b0:781:2291:1045
 with SMTP id d2e1a72fcca58-82f0c1cf099mr18003866b3a.8.1776194069443; Tue, 14
 Apr 2026 12:14:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 14 Apr 2026 12:14:21 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414191425.2697918-1-seanjc@google.com>
Subject: [PATCH 0/4] perf/x86: Don't write PEBS_ENABLED on KVM transitions
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Rework the handling of PEBS_ENABLED (and related PEBS MSRs) to *never* touch
PEBS_ENABLED if the CPU provides PEBS isolation, in which case disabling
counters via PERF_GLOBAL_CTRL is sufficient to prevent generation of unwanted
PEBS records.  For vCPUs without PEBS enabled, this saves upwards of 6 MSR
writes on each roundtrip between the guest and host.  For vCPUS with PEBS,
this saves 2 MSR writes per roundtrip.

However, performance isn't the underlying motiviation.  We (more accurately,
Jim, Mingwei, and Stephane) have been chasing issues where PEBS_ENABLED bits
can get "stuck" in a '1' state when running KVM guests while profiling the host
with PEBS events.  The working theory is that perf throttles PEBS events in
NMI context, and thus clears bits in cpuc->pebs_enabled and PEBS_ENABLED, after
generating the list of PMU MSRs to context switch but before VM-Entry.  And so
when the host's PEBS_ENABLED is loaded on VM-Exit, the CPU ends up with a
stale PEBS_ENABLED that doesn't get reset until something triggers an explicit
reload in perf.

Testing this against our "PEBS_ENABLED is stuck" reproducer is a work
in-progress (largely because the "reproducer" is currently "throw the kernel in
a big test pool"), i.e. I don't know if this actually resolves the problems we
are seeing.  But even if it doesn't fully resolve our woes, it seems like a
no-brainer improvement, and if we're missing something with respect to "stuck"
PEBS_ENABLED, it'd be nice to get feedback/input asap.

Note, if the throttling theory is correct, then there are likely more fixes
that need to be done, e.g. for CPUs without isolation, and/or if
PERF_GLOBAL_CTRL can be modified from NMI context too.

Patch 4 is a clean up that I posted as a standalone patch almost a year ago.
I included it here because it's very related, and because I needed to refresh
it anyways.

Sean Christopherson (4):
  perf/x86/intel: Don't write PEBS_ENABLED on host<=>guest xfers if CPU
    has isolation
  perf/x86/intel: Don't context switch DS_AREA (and PEBS config) if PEBS
    is unused
  perf/x86/intel: Make @data a mandatory param for
    intel_guest_get_msrs()
  perf/x86: KVM: Have perf define a dedicated struct for getting guest
    PEBS data

 arch/x86/events/core.c            |  5 ++-
 arch/x86/events/intel/core.c      | 71 +++++++++++++++++++------------
 arch/x86/events/perf_event.h      |  3 +-
 arch/x86/include/asm/kvm_host.h   |  9 ----
 arch/x86/include/asm/perf_event.h | 12 +++++-
 arch/x86/kvm/vmx/pmu_intel.c      | 20 +++++++--
 arch/x86/kvm/vmx/vmx.c            | 11 +++--
 arch/x86/kvm/vmx/vmx.h            |  2 +-
 8 files changed, 84 insertions(+), 49 deletions(-)


base-commit: 6b802031877a995456c528095c41d1948546bf45
-- 
2.54.0.rc0.605.g598a273b03-goog

