Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5816BC636CC
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Feb 2023 21:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBMVDe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Feb 2023 16:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjBMVDd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Feb 2023 16:03:33 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DB51ABD1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Feb 2023 13:03:32 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id j28-20020a63551c000000b004fb3343142dso5094030pgb.5
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Feb 2023 13:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676322212;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IH3jJcJ/IoZtR7vL3Ek1HckoQScJmDuoE0WIjUb4KK8=;
        b=dGWV2JGDl4a32c3CxY9ycW7JCWmkwvjFsm2CupzNfand10jYMJ8qQlpFj3kbO3CZmR
         6UX2IUVXTGA5e0VFugUjCDsKiugRnjCaocM4DNhnQztU3vqv54Bbb+Vw/ok5L+3DXntf
         tA5tXBCVz3JlE0ZIIZavJflsEsOQhD5AUtNkEqa4YHoSl8TozBtbpcuW05NZ3xDux+vV
         kF4d7mkBmEexy897IFi7oIbSOFhVzUctYylJNqrD20l0bJP1ummHvXInwWF1MUvn6BNm
         /da2V5/XfFq4NKrOTQqriI8mCv/OYTfAhW2opih+oXTmKx9zMM0/mSrxCERtqg09QL0+
         C09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676322212;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IH3jJcJ/IoZtR7vL3Ek1HckoQScJmDuoE0WIjUb4KK8=;
        b=kJNYTdmTs4JlSI4U0iOiZmifon2fDS5dmqLpCkR2meyb4+u/9DFzX8GA2At4Wx74Ge
         YpOw1KZNgc/+3OynMJK5unL6AtLKiIqLB1ubKQdKfu2CnSCN/RpSsFzy+EYRbBGda6sI
         sXRkfvPgT/ZVg7KgDIi+H5wDFgerSpuz72jvJz+hqvX2Qc8Do1IoUvZFjKhhYYOZ98Xg
         38HvYuaA24efotE6BoobEJMxoGT/06qnV3z9103ouBgeOwggEHJSK/InaUW/4U/G3g9J
         zmfOX30SS8HSzuD0UQIFtbF5xF69ufYjUj8vDHdLc3GXYd7jry5dHSrY1Q7z09zl/Sza
         KAeg==
X-Gm-Message-State: AO0yUKXMl52OwUIKVzzgkhLoXqD+3fIffUKI0Lk6/eNwF/6igG3KCT+2
        ttPVOT4ZGdCCdC4Y03bZtf09OiiR7fUKl3w=
X-Google-Smtp-Source: AK7set+CiP9aL8UBtV5TmqF28XLkt6IaxJ0mcncY8JVwJXtnw2rLbvuAxo6bzvnfqn8OHGaKAqhZ2FFHm5R13Uc=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a17:903:2309:b0:19a:b302:516d with SMTP
 id d9-20020a170903230900b0019ab302516dmr94777plh.1.1676322212079; Mon, 13 Feb
 2023 13:03:32 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:03:11 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213210319.1075872-1-zalbassam@google.com>
Subject: [PATCH v3 0/8] perf: arm: Make PMUv3 driver available for aarch32
From:   Zaid Al-Bassam <zalbassam@google.com>
To:     Jesus Sanchez-Palencia <jesussanp@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu
Cc:     Zaid Al-Bassam <zalbassam@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Currently, PMUv3 driver is only available for ARMv8 aarch64 platforms,
ARMv8 platorms running in aarch32 mode dont have access to the driver.
This is, especially, a problem for ARMv8 platforms that only have
aarch32 support, like the Cortex-A32.

Make the PMUv3 driver available to arm arch (ARMv8 aarch32) by moving
the PMUv3 driver from arm64 to drivers, that makes the driver common
to both arm and arm64 architectures, then add PMUv3 arm Support.

The main work in this patchset was made a while back by Marc Zyngier
in [1]. Patchset version 1 [v1] rebases Marc's patches to the latest
kernel revision and adds additional patches to accommodate the changes
in the kernel since Marc wrote the patches.

version 2 [v2] of the patchset was created by Marc Zyngier and I
picked it up from [2].

Changes in v2:
- Flattened the nested switches in the arm_pmuv3.h for arm.
- Removed wrappers and added stubs for the PMU KVM functions for arm.
- Added PMU version abstractions.

Changes in v3:
- Removed the link tag from the commit messages.
- Fixed the license header in the arm_pmuv3.h files.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=kvm-arm/pmuv3-32bit
[2] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=arm/pmuv3

[v1] https://lore.kernel.org/all/20230126204444.2204061-1-zalbassam@google.com/
[v2] https://lore.kernel.org/all/20230210165500.2292608-1-zalbassam@google.com/

Thank you,
Zaid Al-Bassam

Marc Zyngier (5):
  arm64: perf: Move PMUv3 driver to drivers/perf
  arm64: perf: Abstract system register accesses away
  ARM: Make CONFIG_CPU_V7 valid for 32bit ARMv8 implementations
  ARM: perf: Allow the use of the PMUv3 driver on 32bit ARM
  ARM: mach-virt: Select PMUv3 driver by default

Zaid Al-Bassam (3):
  perf: pmuv3: Abstract PMU version checks
  perf: pmuv3: Move inclusion of kvm_host.h to the arch-specific helper
  perf: pmuv3: Change GENMASK to GENMASK_ULL

 arch/arm/Kconfig                              |   1 +
 arch/arm/include/asm/arm_pmuv3.h              | 247 ++++++++++++++
 arch/arm/mm/Kconfig                           |   2 +-
 arch/arm64/include/asm/arm_pmuv3.h            | 155 +++++++++
 arch/arm64/include/asm/perf_event.h           | 249 --------------
 arch/arm64/kernel/Makefile                    |   1 -
 drivers/perf/Kconfig                          |  10 +
 drivers/perf/Makefile                         |   1 +
 .../perf_event.c => drivers/perf/arm_pmuv3.c  | 131 ++------
 include/kvm/arm_pmu.h                         |   2 +-
 include/linux/perf/arm_pmuv3.h                | 303 ++++++++++++++++++
 11 files changed, 751 insertions(+), 351 deletions(-)
 create mode 100644 arch/arm/include/asm/arm_pmuv3.h
 create mode 100644 arch/arm64/include/asm/arm_pmuv3.h
 rename arch/arm64/kernel/perf_event.c => drivers/perf/arm_pmuv3.c (93%)
 create mode 100644 include/linux/perf/arm_pmuv3.h

-- 
2.39.1.581.gbfd45094c4-goog

