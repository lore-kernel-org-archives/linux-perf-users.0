Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25121C19F28
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Aug 2022 19:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbiHCT1G (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Aug 2022 15:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbiHCT1E (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 Aug 2022 15:27:04 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CDB57218
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Aug 2022 12:27:03 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id q12-20020a17090aa00c00b001f228eb8b84so1553435pjp.3
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Aug 2022 12:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:reply-to:from:to:cc;
        bh=3RPOTZgLH8z1mj6S/J2PJvuGpfhZNmF41DEbta7HrMo=;
        b=gKuIIBdvQdBJu4sMYgx0Q90wW6lAC9OxXICWsrcsxMFPRuEUESQwb5lFSQVlxB5M3l
         KYvk4/WS21iPidCi1NOprQmF5glOHs1jagHWpFq4vyPuxvEGlvDBSF3G/SEIARiwW58W
         dkcwKi1TGOe2JtSdnws1BPabQEsQa68tBLCq1ON+yguApZeW0273w6rIIo8KHUtOJ0oE
         abP2CCLzkEMHdbdIn8XM6a700vkIVxoQNYLM28ri08U8AXVy3PGSJ/cmn39/4eejnV24
         lXnpQIMPF/jz6Sg11yUn1r/RGmjtK44kIbygKPZBdd8Vrm7S1QZ/vpaPwiQl7e1TzuKn
         cvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:reply-to
         :x-gm-message-state:from:to:cc;
        bh=3RPOTZgLH8z1mj6S/J2PJvuGpfhZNmF41DEbta7HrMo=;
        b=K4nLSGlVgTvFClmTePCFQRLbq7WzqkGFv1vwjM+rr1sFsiPANjbCemts/ojFe/AOS5
         cx/1NaUaI1rX4qdxrM0CiVF32/KHwdJ4yJJ65+MZTysKXrNBfPsJte+kpwaVli713jbj
         4sftYHQbgmy5swromZoKF3wsU7f3QLZK2bCKWpJ7oaUHc30YHCjlHnyhbwuT5eNYTrnF
         GcKTnvot8Sy339HRnb/5TjUt0Iun/lapDzc7zo78+xeDHO1r9TeLEn9PZEmwc3DlEO7T
         l9JCP+JSJz77Z4ECVrHcUbu06xe0NEIH0RCBuAwkRF5i3U4JrIZWuQhhrSsltBNFXcCb
         g7YQ==
X-Gm-Message-State: ACgBeo2yeovQ/JrPa/kr9klCMQzy0ZlCRgdACiJq2EL4+/N8PrTI4hFD
        8cj0a60M86MInV2s+T2VjUNZd0ifjm8=
X-Google-Smtp-Source: AA6agR5/G+xmOFeILNiqYjsu2HB21yEsKdqFRR0RpP9Yl20POWePtSeiNqhqUeJqaXc6xllutDPlQynosOU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:32d2:b0:16e:dfed:b4b6 with SMTP id
 i18-20020a17090332d200b0016edfedb4b6mr18139404plr.108.1659554823230; Wed, 03
 Aug 2022 12:27:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  3 Aug 2022 19:26:51 +0000
Message-Id: <20220803192658.860033-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v2 0/7] KVM: x86: Intel PERF_CAPABILITIES fixes and cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Bug fixes and cleanups related to KVM's handling of PERF_CAPABILITIES.

Bug #1 - Refresh KVM's vPMU after userspace writes PERF_CAPABILITIES, and
then leverage that fix to avoiding checking guest_cpuid_has(X86_FEATURE_PDCM)
during VM-Enter, which is slow enough that it shows up in perf traces[*].

Bug #2 - Don't advertise PMU_CAP_LBR_FMT to userspace if perf has disabled
LBRs, e.g. because probing one or more LBR MSRs during setup hit a #GP.

The non-KVM patches remove unnecessary stubs and unreachable error paths,
which allows for a cleaner fix for bug #2.

[*] https://gist.github.com/avagin/f50a6d569440c9ae382281448c187f4e

v2:
 - Add patches to fix bug #2. [Like]
 - Add a patch to clean up the capability check.
 - Tweak the changelog for the PMU refresh bug fix to call out that
   KVM should disallow changing feature MSRs after KVM_RUN. [Like]

v1: https://lore.kernel.org/all/20220727233424.2968356-1-seanjc@google.com

Sean Christopherson (7):
  KVM: x86: Refresh PMU after writes to MSR_IA32_PERF_CAPABILITIES
  perf/x86/core: Remove unnecessary stubs provided for KVM-only helpers
  perf/x86/core: Drop the unnecessary return value from
    x86_perf_get_lbr()
  KVM: VMX: Advertise PMU LBRs if and only if perf supports LBRs
  KVM: VMX: Use proper type-safe functions for vCPU => LBRs helpers
  KVM: VMX: Adjust number of LBR records for PERF_CAPABILITIES at
    refresh
  KVM: VMX: Simplify capability check when handling PERF_CAPABILITIES
    write

 arch/x86/events/intel/lbr.c       |  6 +---
 arch/x86/include/asm/perf_event.h | 55 ++++++++-----------------------
 arch/x86/kvm/vmx/capabilities.h   |  5 ++-
 arch/x86/kvm/vmx/pmu_intel.c      | 12 ++-----
 arch/x86/kvm/vmx/vmx.c            |  6 ++--
 arch/x86/kvm/vmx/vmx.h            | 53 +++++++++++++++++------------
 arch/x86/kvm/x86.c                |  4 +--
 7 files changed, 58 insertions(+), 83 deletions(-)


base-commit: 93472b79715378a2386598d6632c654a2223267b
-- 
2.37.1.559.g78731f0fdb-goog

