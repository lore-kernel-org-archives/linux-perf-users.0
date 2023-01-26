Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883C1C05027
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Jan 2023 20:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjAZUo6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 Jan 2023 15:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjAZUox (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Jan 2023 15:44:53 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC2B126D2
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Jan 2023 12:44:52 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z17-20020a256651000000b007907852ca4dso3146034ybm.16
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Jan 2023 12:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j9eMGsuOboeDFLvBXbf4EoVuBvplDzjiR8R35kRzRzk=;
        b=cQMw6FAyg6mYnU7VIMqrgDwFxLs3c6Kcg0P38Z+Sg43jVxky6lvNicUFY568YhVD3h
         geRQGIU7S03l1YTAZxjjbutQ49edTKuPIY8miJd7qbBgwJ+MPl5LZnYUfzGCJRZmJk+4
         qDE0VWTF35oajtWZ5Zl+pazWx+IQjQBxJjREDohEa5TEf05b0EvBRyT+YJaAwNk7OAGV
         NWsCw4Ya2caGs5rfbN1+UcSZi9jzqO2PSxD3XSumV+QUlO4R77YNCBsOAnZ4CF3Q0wfg
         K4FMpUmHtmmEf9l1bhupZMqZ65fzTTljYHVLYRI3nJqvR3Xtu/Yxs0Ng/WvpqqfdsPjM
         AHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j9eMGsuOboeDFLvBXbf4EoVuBvplDzjiR8R35kRzRzk=;
        b=PX5s9Wg6SXXuVnz9q32OrFMDGvJkl640tJ5k8eK4VX1StuV6+BhAcQfkpyA24ST7WY
         MRyDixaqNQMLevc97ttJpPwxAIG3FcSI44/kl7Ax/T5ST5b3+d6dsF3j509NRzSlPixH
         BD79yj85YrK9eZYAgLLQYt/oelou4oPI1YiSp1/SWsLUIefMsJvEre5esncomdipirtx
         j7hJgRH0Te4V+kx8vV1DcEKj/HfjLZws7CNrgKoJdkPpujMvtn6AeElazQv+sB08KHo2
         u7/ULP79/WRWtJYQKAchJ8GFFZBHBpWXvgvA1UZLMXJjec7IWQqH0uQVK/P0HHxsug+g
         djKw==
X-Gm-Message-State: AFqh2krG9GBTHAnSfvbyUAoc3DG+iO6YZrusQD5ESc6LtOR8aERuuTqw
        DKGtSO/wpKPzfNf4H9kH8EL9o0PwUP5slSA=
X-Google-Smtp-Source: AMrXdXvqgrjYC0YYc4Slv5mogwPRxgYozsZ3TTkpden02y5nqgY7MNNJj+RJ44bjJRb/eYtnJkbmDMOppy9uU7M=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a25:3c82:0:b0:7e2:76a6:a641 with SMTP id
 j124-20020a253c82000000b007e276a6a641mr4484003yba.645.1674765891585; Thu, 26
 Jan 2023 12:44:51 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:44:36 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230126204444.2204061-1-zalbassam@google.com>
Subject: [PATCH 0/8] perf: arm: Make PMUv3 driver available for aarch32
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

Currently, PMUv3 driver is only available for ARMv8 aarch64
platforms, ARMv8 running in aarch32 mode dont have access to
the driver. This is, especially, a problem for ARMv8 platforms
that only have aarch32 support, like the Cortex-A32.

Make the PMUv3 driver available to arm arch (ARMv8 aarch32) by
moving the PMUv3 driver from arm64 to drivers, that makes the
driver common to both arm and arm64 architectures, then add
PMUv3 arm Support.

The main work in this patchset was made a while back by Marc
Zyngier on a private branch. This patchset rebases Marc's
patches to the latest kernel revision and adds additional
patches to accommodate the changes in the kernel since Marc
wrote the patches.

Marc Zyngier (5):
  arm64: perf: Move PMUv3 driver to drivers/perf
  arm64: perf: Abstract system register accesses away
  ARM: Make CONFIG_CPU_V7 valid for 32bit ARMv8 implementations
  ARM: perf: Allow the use of the PMUv3 driver on 32bit ARM
  ARM: mach-virt: Select PMUv3 driver by default

Zaid Al-Bassam (3):
  perf: pmuv3: Add common defines for the PMU version
  perf: pmuv3: Add wrappers for KVM accesses
  perf: pmuv3: Change GENMASK to GENMASK_ULL

 arch/arm/Kconfig                              |   1 +
 arch/arm/include/asm/arm_pmuv3.h              | 238 +++++++++++++++
 arch/arm/mm/Kconfig                           |   2 +-
 arch/arm64/include/asm/arm_pmuv3.h            | 210 +++++++++++++
 arch/arm64/include/asm/perf_event.h           | 249 ----------------
 arch/arm64/kernel/Makefile                    |   1 -
 drivers/perf/Kconfig                          |  10 +
 drivers/perf/Makefile                         |   1 +
 .../perf_event.c => drivers/perf/arm_pmuv3.c  | 139 +++------
 include/kvm/arm_pmu.h                         |   2 +-
 include/linux/perf/arm_pmuv3.h                | 276 ++++++++++++++++++
 11 files changed, 773 insertions(+), 356 deletions(-)
 create mode 100644 arch/arm/include/asm/arm_pmuv3.h
 create mode 100644 arch/arm64/include/asm/arm_pmuv3.h
 rename arch/arm64/kernel/perf_event.c => drivers/perf/arm_pmuv3.c (92%)
 create mode 100644 include/linux/perf/arm_pmuv3.h

-- 
2.39.0.246.g2a6d74b583-goog

