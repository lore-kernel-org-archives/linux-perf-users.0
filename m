Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1928734B662
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779752439; cv=pass; b=rRV/ObTxanKBRbwzT7Wd/A87a03+KvYIQJdzcIGlgLqxLIRnpva+Ugn0jveI/aKML6TQxa+G0r5p1i0iolc9nnC46gAZzvfHv0Jax8pO3jjWXrS586F1JStxwnfOhvzkGKAv/c5UfEWTE7fLb2GrEmZ7uODNtEFtC08m+bYlsn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779752439; c=relaxed/simple;
	bh=DJp4Z0gMpdLY6qGQDFSDYvtf5Awtg0fcuOJFFBu3GGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=D7jh2I42zsve0fm+CPIrp+yCW8d7uTg2923Pwa+iwkTEGFf0ZYlTuJ9Nu5Yrrkas57JCLlMhrp48pENZc1A1ukfnXKkDnnRvs53zJwjc0upcyIEFQzd8tqmyJq9MqP044WOCW6EQKQFnkfxvXswCjBR+Cll0dWggQWTNxfPqhf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UU0ZsIkq; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UU0ZsIkq"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba180a022dso75ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 16:40:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779752436; cv=none;
        d=google.com; s=arc-20240605;
        b=Zq2nqj/rLudz5mEnxPk2VzekMorcUXdOc1j9ni7tCuSINTp3Eil4Rt40zdhMPH8PB/
         QhB9zZ53K4tWBXnZOxFVfw61CqDBoDOA/0zEPkBXIxmDbrL6QQ/b5CzjpQX8qGmxH6HH
         kIqp5fJh1v5ha/pm0oZfdrH+/gIiMhcT68Tg45PGRy4ckgUgc7OcMVfPvLUTpTdCfINa
         9MwpRQP8c8Ga7OxhMJlIAo0nmuMUui2EHFKhR+1rZbNN7d342PIbcA2fZnjYskUkeq1a
         pW7eC/O1If+NTiJgrm21DIYHQwJh3R2ABoPBL85p+4Ul1SCehxlqsVtWxroJnYQDhjEG
         7/Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=HLWPXRYNbt4llUxRwc27nItWaY7HNx7TyQMQvD6dCfk=;
        fh=L5P1Ec6hWNoFdSb2JaTAfMZzzpBBvF+Qa7spr9F8DO4=;
        b=eT+ofxEYPVsh0KkU+o1123ak5f0P34tbnN5/PWVgYQdgkbbf9V3rCiM+2DPQPYHiY4
         W4f0Rl2px4yqENiqXmJZfc8N2+zDxio+fcA4B0Jlw03KFWsuqgu6hFlJLG3oLCMKIIRY
         c3GSZXNgv9wKUigD8cizHM2LMet67t24O2tLg18w6OkLJ31wU30SQKK3ZHIkoiqsPQNj
         Uv5+BvIbTyJoNjDwEoJ7mFuolcl6D8F5MnW0AsZEmuMnHDfZcdV3hdBNYVAcgxDvrgEL
         3MrvklGWjHZ/3XsjskxVdHwE+NSkvrISyQuegeyFA0ZnLXXDwI41EnBlzNItBUjb+cET
         OIOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779752436; x=1780357236; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HLWPXRYNbt4llUxRwc27nItWaY7HNx7TyQMQvD6dCfk=;
        b=UU0ZsIkqOVdJzG0q1eZZj1VVRTr8QnmBXupI2dpvA1A5anFxK7rRMGGjCfhJGhLfu+
         lMoaZihd64+KCcz0pR7l4sBAI5IXMlwvFWGFAJjyvU+r9JKNW3Gc5dkYS2/lEaeKuur+
         aPcqyZpL3DV/KddlCFC66eZhobI2fw1nUv46YTn8hkR0iCSTNyKaGGJ/KvRy3maS+Dcw
         QBfB3liOEhZlaasAZWeMEEHFMLW/zIFTIxbiAOATh0iUeE2R79RaTUV2HAVEBch9MQ8i
         upLuL4cx8KB1fsMkf/NPoQ2iT+0yIOamGpDJsoOQ7rxiaeGilt5vT3euvomjMOy9exNK
         sk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779752436; x=1780357236;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLWPXRYNbt4llUxRwc27nItWaY7HNx7TyQMQvD6dCfk=;
        b=LiwJfZoFXgjuUQySWA5+mKQzGM4ZUitNSfDJrAgwTmfPMn3l42cT+xllZv1rbPPkUu
         X3lJTHQaq/lqmZXeHmTjmJdwyYv43RCukP7IW4Q6S4r3dJFTMiZ+xkoFPVMbpd9UyprQ
         Gw79+Fs0CpcpgXob8uxucjGF86Jy7WqUEQC/Tgnbanyy+Q/oC8NzyGOzz2qpfF/gxT2N
         kK1VILncIGCu+hQ2iGClOblzM1Q2WvzO6ZveaxMBieKzvjxMxPk6LZQoBJs7FuXm9QN5
         9VJKGah+PEgI/i3mwxXRAfL3rNceQcmwLYpIAbAsRQi4hYQSvkvTJj/PBBvpj0MUAEod
         IQ0w==
X-Forwarded-Encrypted: i=1; AFNElJ/2yl/rj7V3qWFxI3L7os7O11ZS6QNFCmpGGBRyHoGjGHiBr7gZ4dxB12ZDupICtYZSDOXm6sstsStRfQcVUYUi@vger.kernel.org
X-Gm-Message-State: AOJu0YwbMtjlCQvdNKQldv+f+TM/fpTwMga74QNcjsN9/1DM6qau/lCb
	GQ/WzwBrtALMELBCT5ycJexIXw2mb0mKApPCTFStpzkpOiALwpPeuN+5nmBRffSv/EPXSxEB/Sj
	iVnKWss03cDse+yV0brs2jTZL7IN85o+R+reKmg1BuHatEY6uuWN498goOqU=
X-Gm-Gg: Acq92OHEAdUPmDqe/RYM+HMRM/SY3YzxznwkiOpNWniaDmrqa5TKXL80veZoKDOE6fX
	fWiukLMA6tGle9Y9Wrn3QbQ7+ktUCI60V6Rq6uL6U5d6W09YiAsC8lLmxqUV1+gy8dFfdi/6IlT
	uDcV26mxyjNlpVueiFalNT+cogKIKVrtyjI94K9zXgg4Ut3FYAD94PKIRDf5bd+5zb3JilYtDmv
	Zbcd/UZaBdqc9mDHaLzjCvUqmt+ZXheotRDXVAiw8w79znmb4Ns9vuiGi+kOb0a1oeBvFp+sZ4c
	LUAkpavIHsbx4eTn3qg=
X-Received: by 2002:a17:903:1aeb:b0:2b4:6529:7bae with SMTP id
 d9443c01a7336-2bec11c2cc4mr3752345ad.17.1779752435509; Mon, 25 May 2026
 16:40:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fX=vEmTaz6mWgExmrgyYMJmSyOD+1sMCzf7JTk1SkA-zQ@mail.gmail.com>
 <CAP-5=fU0pLzo8DGETQD3eWig747sGkwRwNs4AvcgGRQi+FGh4g@mail.gmail.com> <CAP-5=fUkOHPJPZ3rT_HdFt8A-nzfGNEeeK76FNc3pEj1a4tzZQ@mail.gmail.com>
In-Reply-To: <CAP-5=fUkOHPJPZ3rT_HdFt8A-nzfGNEeeK76FNc3pEj1a4tzZQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 May 2026 16:40:23 -0700
X-Gm-Features: AVHnY4Lp8igS3SQidgY7BHtIDtclirjyVwsc2HoiPIvv4jO4BE_HRPsq9M4t7q8
Message-ID: <CAP-5=fXmDViUUkKj1OOzG_DOL6w40kA=CM3xh5edmxqcxL6Suw@mail.gmail.com>
Subject: Re: Summary of perf-tools-next changes and patches sent to linux-perf-users
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

================================================================================
WEEK: 2026-05-04 to 2026-05-11
================================================================================

>>> MERGED PATCHES <<<
  [Merged] perf arm_spe: Dump IMPDEF events
           Author   : James Clark <james.clark@linaro.org>
           Commit   : e7ef46178494 - perf arm_spe: Print remaining
IMPDEF event numbers (by James Clark)
           Commit   : b566a7404161 - perf arm_spe: Decode Arm N1
IMPDEF events (by James Clark)
           Commit   : 96b4910c3c6c - perf arm_spe: Turn event name
mappings into an array (by James Clark)
           Commit   : 8cf4d17ec7f0 - perf arm_spe: Store MIDR in
arm_spe_pkt (by James Clark)
           Commit   : 0c7e4d11fb8d - perf arm_spe: Handle missing CPU
IDs (by James Clark)
           Commit   : 8e32bd775cc8 - perf arm_spe: Make a function to
get the MIDR (by James Clark)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260414-james-spe-impdef-decode-v4-0-1dd30783a33b%40linaro.org/
           Sashiko  :
https://sashiko.dev/#/patchset/20260414-james-spe-impdef-decode-v4-0-1dd30783a33b%40linaro.org

  [Merged] perf callchain: Handle multiple address spaces
           Author   : Thomas Richter <tmricht@linux.ibm.com>
           Commit   : ae15db3e9b63 - perf callchain: Handle multiple
address spaces (by Thomas Richter)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260414124241.490185-1-tmricht%40linux.ibm.com/
           Sashiko  :
https://sashiko.dev/#/patchset/20260414124241.490185-1-tmricht%40linux.ibm.com

  [Merged] [PATCH v5 0/9] perf DWARF: Fix libdw API contract
violations and crashes
           Author   : Ian Rogers <irogers@google.com>
           Commit   : 9c6d535ddb79 - perf libdw: Fix libdw API
contract violations and memory leaks (by Ian Rogers)
           Commit   : 15f8c22c462b - perf libdw: Support DWARF line 0
in inline list (by Ian Rogers)
           Commit   : 0e18b5bb7c9d - perf libdw: Fix callchain parent
update in ORDER_CALLER mode (by Ian Rogers)
           Commit   : 674dea094ef6 - perf srcline: Introduce
inline_node__clear_frames() (by Ian Rogers)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260504081227.2203848-1-irogers%40google.com/
           Sashiko  :
https://sashiko.dev/#/patchset/20260504081227.2203848-1-irogers%40google.com

  [Merged (Sent: 2026-04-21)] perf callchain: Handle multiple address spaces
                       Author   : Thomas Richter <tmricht@linux.ibm.com>
                       Commit   : ae15db3e9b63 (Likely, date: 2026-05-05)
                       LORE Link:
https://lore.kernel.org/linux-perf-users/f00388eb-a3d9-4df2-8786-70b938e57a78%40linux.ibm.com/

  [Merged (Git Only)] perf build: Remove NO_GTK2 build test
                      Commit: 8c8f20936143 by Namhyung Kim

  [Merged (Git Only)] perf build: Add -fms-extensions for GEN_VMLINUX_H=1
                      Commit: 53bc03289278 by Namhyung Kim

  [Merged (Git Only)] perf build: Update error message for BUILD_NONDISTRO=1
                      Commit: e41cac8617a9 by Namhyung Kim


>>> ACTIVE & MISSING PATCHES <<<
  Series : riscv: add SBI Supervisor Software Events support
  Author : Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
  Version: v9
  Date   : Sat, 09 May 2026 13:10:02 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/cover.1778331862.git.zhangzhanpeng.jasper%40bytedance.com)
  Unapplied Patches (5):
    -> [1] [PATCH v9 1/5] riscv: add SBI SSE extension definitions
       Link   :
https://lore.kernel.org/linux-perf-users/2a8913d680ccf162d5d697fde1a125c48b2f1d0a.1778331862.1.git.zhangzhanpeng.jasper%40bytedance.com/
       Sashiko: Reviewed (No regressions)
    -> [2] [PATCH v9 2/5] riscv: add support for SBI Supervisor
Software Events extension
       Link   :
https://lore.kernel.org/linux-perf-users/45918ddc68df98ec25ac93c0bbab7da90a4ecbf9.1778331862.2.git.zhangzhanpeng.jasper%40bytedance.com/
       Sashiko: Reviewed (2 Critical, 5 High, 1 Medium, 0 Low)
    -> [3] [PATCH v9 3/5] drivers: firmware: add riscv SSE support
       Link   :
https://lore.kernel.org/linux-perf-users/7d86cbd47688700fbdfc27e530e824a6bec0548c.1778331862.3.git.zhangzhanpeng.jasper%40bytedance.com/
       Sashiko: Reviewed (1 Critical, 8 High, 3 Medium, 0 Low)
    -> [4] [PATCH v9 4/5] perf: RISC-V: add support for SSE event
       Link   :
https://lore.kernel.org/linux-perf-users/7989b7338b7480164bda55131fb7537bd9416591.1778331862.4.git.zhangzhanpeng.jasper%40bytedance.com/
       Sashiko: Reviewed (0 Critical, 2 High, 2 Medium, 0 Low)
    -> [5] [PATCH v9 5/5] selftests/riscv: add SSE test module
       Link   :
https://lore.kernel.org/linux-perf-users/1f66bfb775e8b6658c6f2f2f48aa4f668f911db5.1778331862.5.git.zhangzhanpeng.jasper%40bytedance.com/
       Sashiko: Reviewed (0 Critical, 3 High, 4 Medium, 0 Low)
----------------------------------------
  Series : perf/lock: Fix non-atomic max/time and min_time updates in
contention_data
  Author : Suchit Karunakaran <suchitkarunakaran@gmail.com>
  Version: v1
  Date   : Mon, 04 May 2026 13:51:38 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Not Found
  Unapplied Patches (1):
    -> [1] [PATCH RESEND] perf/lock: Fix non-atomic max/time and
min_time updates in contention_data
       Link   :
https://lore.kernel.org/linux-perf-users/20260504135138.17050-1-suchitkarunakaran%40gmail.com/
       Sashiko: Not Found
----------------------------------------
  Series : perf tools: Ensure event leader stays at head of evlist after sorting
  Author : Chun-Tse Shao <ctshao@google.com>
  Version: v2
  Date   : Tue, 05 May 2026 21:19:00 +0000 (Latest Activity)
  Status : Maintainer work (Review tags present on unapplied patches
or cover letter)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260505211924.1961056-2-ctshao%40google.com)
  Unapplied Patches (1):
    -> [1] [TAGGED] [RESEND PATCH v2] perf tools: Ensure event leader
stays at head of evlist after sorting
       Link   :
https://lore.kernel.org/linux-perf-users/20260505211924.1961056-2-ctshao%40google.com/
       Sashiko: Reviewed (No regressions)
----------------------------------------
  Series : [next] perf/x86: Avoid multiple
-Wflex-array-member-not-at-end warnings
  Author : "Gustavo A. R. Silva" <gustavoars@kernel.org>
  Version: v1
  Date   : Wed, 29 Apr 2026 19:29:18 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Reviewed (https://sashiko.dev/#/patchset/afJcDg1I5ZU5ZkXf%40kspp)
  Unapplied Patches (1):
    -> [1] [PATCH][next] perf/x86: Avoid multiple
-Wflex-array-member-not-at-end warnings
       Link   :
https://lore.kernel.org/linux-perf-users/afJcDg1I5ZU5ZkXf%40kspp/
       Sashiko: Reviewed (0 Critical, 0 High, 0 Medium, 1 Low)
----------------------------------------
  Series : perf: Extract is_mapping_symbol() helper for mapping symbol filtering
  Author : "Rui Qi" <qirui.001@bytedance.com>
  Version: v1
  Date   : Mon, 04 May 2026 09:06:09 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Not Found
  Unapplied Patches (1):
    -> [1] [PATCH] perf: Extract is_mapping_symbol() helper for
mapping symbol filtering
       Link   :
https://lore.kernel.org/linux-perf-users/20260504090609.1801880-1-qirui.001%40bytedance.com/
       Sashiko: Not Found
----------------------------------------
  Series : ARM64 PMU Partitioning
  Author : Colton Lewis <coltonlewis@google.com>
  Version: v7
  Date   : Mon, 04 May 2026 21:18:13 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Not Found
  Unapplied Patches (20):
    -> [1] [PATCH v7 01/20] arm64: cpufeature: Add cpucap for HPMN0
       Link   :
https://lore.kernel.org/linux-perf-users/20260504211813.1804997-2-coltonlewis%40google.com/
       Sashiko: Not Found
    -> [2] [PATCH v7 02/20] KVM: arm64: Reorganize PMU includes
       Link   :
https://lore.kernel.org/linux-perf-users/20260504211813.1804997-3-coltonlewis%40google.com/
       Sashiko: Not Found
    -> [3] [PATCH v7 03/20] KVM: arm64: Reorganize PMU functions
       Link   :
https://lore.kernel.org/linux-perf-users/20260504211813.1804997-4-coltonlewis%40google.com/
       Sashiko: Not Found
    -> [4] [PATCH v7 04/20] perf: arm_pmuv3: Generalize counter bitmasks
       Link   :
https://lore.kernel.org/linux-perf-users/20260504211813.1804997-5-coltonlewis%40google.com/
       Sashiko: Not Found
    -> [5] [PATCH v7 05/20] perf: arm_pmuv3: Check cntr_mask before
using pmccntr
       Link   :
https://lore.kernel.org/linux-perf-users/20260504211813.1804997-6-coltonlewis%40google.com/
       Sashiko: Not Found
    -> [6] [PATCH v7 06/20] perf: arm_pmuv3: Add method to partition the PMU
       Link   :
https://lore.kernel.org/linux-perf-users/20260504211813.1804997-7-coltonlewis%40google.com/
       Sashiko: Not Found
    -> [7] [PATCH v7 07/20] KVM: arm64: Set up FGT for Partitioned PMU
       Link   :
https://lore.kernel.org/linux-perf-users/20260504211813.1804997-8-coltonlewis%40google.com/
       Sashiko: Not Found
    -> [8] [PATCH v7 08/20] KVM: arm64: Add Partitioned PMU register
trap handlers
       Link   :
https://lore.kernel.org/linux-perf-users/20260504211813.1804997-9-coltonlewis%40google.com/
       Sashiko: Not Found
    -> [9] [PATCH v7 09/20] KVM: arm64: Set up MDCR_EL2 to handle a
Partitioned PMU
       Link   :
https://lore.kernel.org/linux-perf-users/20260504211813.1804997-10-coltonlewis%40google.com/
       Sashiko: Not Found
    -> [10] [PATCH v7 10/20] KVM: arm64: Context swap Partitioned PMU
guest registers
       Link   :
https://lore.kernel.org/linux-perf-users/20260504211813.1804997-11-coltonlewis%40google.com/
       Sashiko: Not Found
    -> [11] [PATCH v7 11/20] KVM: arm64: Enforce PMU event filter at vcpu_load()
       Link   :
https://lore.kernel.org/linux-perf-users/20260504211813.1804997-12-coltonlewis%40google.com/
       Sashiko: Not Found
    -> [12] [PATCH v7 12/20] perf: Add perf_pmu_resched_update()
       Link   :
https://lore.kernel.org/linux-perf-users/20260504211813.1804997-13-coltonlewis%40google.com/
       Sashiko: Not Found
    -> [13] [PATCH v7 13/20] KVM: arm64: Apply dynamic guest counter
reservations
       Link   :
https://lore.kernel.org/linux-perf-users/20260504211813.1804997-14-coltonlewis%40google.com/
       Sashiko: Not Found
    -> [14] [PATCH v7 14/20] KVM: arm64: Implement lazy PMU context swaps
       Link   :
https://lore.kernel.org/linux-perf-users/20260504211813.1804997-15-coltonlewis%40google.com/
       Sashiko: Not Found
    -> [15] [PATCH v7 15/20] perf: arm_pmuv3: Handle IRQs for
Partitioned PMU guest counters
       Link   :
https://lore.kernel.org/linux-perf-users/20260504211813.1804997-16-coltonlewis%40google.com/
       Sashiko: Not Found
    -> [16] [PATCH v7 16/20] KVM: arm64: Detect overflows for the
Partitioned PMU
       Link   :
https://lore.kernel.org/linux-perf-users/20260504211813.1804997-17-coltonlewis%40google.com/
       Sashiko: Not Found
    -> [17] [PATCH v7 17/20] KVM: arm64: Add vCPU device attr to
partition the PMU
       Link   :
https://lore.kernel.org/linux-perf-users/20260504211813.1804997-18-coltonlewis%40google.com/
       Sashiko: Not Found
    -> [18] [PATCH v7 18/20] KVM: selftests: Add find_bit to KVM library
       Link   :
https://lore.kernel.org/linux-perf-users/20260504211813.1804997-19-coltonlewis%40google.com/
       Sashiko: Not Found
    -> [19] [PATCH v7 19/20] KVM: arm64: selftests: Add test case for
Partitioned PMU
       Link   :
https://lore.kernel.org/linux-perf-users/20260504211813.1804997-20-coltonlewis%40google.com/
       Sashiko: Not Found
    -> [20] [PATCH v7 20/20] KVM: arm64: selftests: Relax testing for
exceptions when partitioned
       Link   :
https://lore.kernel.org/linux-perf-users/20260504211813.1804997-21-coltonlewis%40google.com/
       Sashiko: Not Found
----------------------------------------
  Series : perf symbol/env: ELF machine clean up and lazy idle computation
  Author : Ian Rogers <irogers@google.com>
  Version: v9
  Date   : Sun, 03 May 2026 00:22:48 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Not Found
  Unapplied Patches (18):
    -> [1] [PATCH v9 01/18] perf env: Add perf_env__e_machine helper
and use in perf_env__arch
       Link   :
https://lore.kernel.org/linux-perf-users/20260503002248.1040791-2-irogers%40google.com/
       Sashiko: Not Found
    -> [2] [PATCH v9 02/18] perf tests topology: Switch env->arch use
to env->e_machine
       Link   :
https://lore.kernel.org/linux-perf-users/20260503002248.1040791-3-irogers%40google.com/
       Sashiko: Not Found
    -> [3] [PATCH v9 03/18] perf env, dso, thread: Add _endian
variants for e_machine helpers
       Link   :
https://lore.kernel.org/linux-perf-users/20260503002248.1040791-4-irogers%40google.com/
       Sashiko: Not Found
    -> [4] [PATCH v9 04/18] perf capstone: Determine architecture from e_machine
       Link   :
https://lore.kernel.org/linux-perf-users/20260503002248.1040791-5-irogers%40google.com/
       Sashiko: Not Found
    -> [5] [PATCH v9 05/18] perf print_insn: Use e_machine for
fallback IP length check
       Link   :
https://lore.kernel.org/linux-perf-users/20260503002248.1040791-6-irogers%40google.com/
       Sashiko: Not Found
    -> [6] [PATCH v9 06/18] perf symbol: Avoid use of machine__is
       Link   :
https://lore.kernel.org/linux-perf-users/20260503002248.1040791-7-irogers%40google.com/
       Sashiko: Not Found
    -> [7] [PATCH v9 07/18] perf machine: Use perf_env e_machine
rather than arch
       Link   :
https://lore.kernel.org/linux-perf-users/20260503002248.1040791-8-irogers%40google.com/
       Sashiko: Not Found
    -> [8] [PATCH v9 08/18] perf sample-raw: Use perf_env e_machine
rather than arch
       Link   :
https://lore.kernel.org/linux-perf-users/20260503002248.1040791-9-irogers%40google.com/
       Sashiko: Not Found
    -> [9] [PATCH v9 09/18] perf sort: Use perf_env e_machine rather than arch
       Link   :
https://lore.kernel.org/linux-perf-users/20260503002248.1040791-10-irogers%40google.com/
       Sashiko: Not Found
    -> [10] [PATCH v9 10/18] perf arch common: Use perf_env e_machine
rather than arch
       Link   :
https://lore.kernel.org/linux-perf-users/20260503002248.1040791-11-irogers%40google.com/
       Sashiko: Not Found
    -> [11] [PATCH v9 11/18] perf header: In print_pmu_caps use
perf_env e_machine
       Link   :
https://lore.kernel.org/linux-perf-users/20260503002248.1040791-12-irogers%40google.com/
       Sashiko: Not Found
    -> [12] [PATCH v9 12/18] perf c2c: Use perf_env e_machine rather than arch
       Link   :
https://lore.kernel.org/linux-perf-users/20260503002248.1040791-13-irogers%40google.com/
       Sashiko: Not Found
    -> [13] [PATCH v9 13/18] perf lock-contention: Use perf_env
e_machine rather than arch
       Link   :
https://lore.kernel.org/linux-perf-users/20260503002248.1040791-14-irogers%40google.com/
       Sashiko: Not Found
    -> [14] [PATCH v9 14/18] perf env: Refactor perf_env__arch_strerrno
       Link   :
https://lore.kernel.org/linux-perf-users/20260503002248.1040791-15-irogers%40google.com/
       Sashiko: Not Found
    -> [15] [PATCH v9 15/18] perf env: Remove unused perf_env__raw_arch
       Link   :
https://lore.kernel.org/linux-perf-users/20260503002248.1040791-16-irogers%40google.com/
       Sashiko: Not Found
    -> [16] [PATCH v9 16/18] perf env: Add helper to lazily compute
the os_release
       Link   :
https://lore.kernel.org/linux-perf-users/20260503002248.1040791-17-irogers%40google.com/
       Sashiko: Not Found
    -> [17] [PATCH v9 17/18] perf symbol: Add setters for bitfields
sharing a byte to avoid concurrent update issues
       Link   :
https://lore.kernel.org/linux-perf-users/20260503002248.1040791-18-irogers%40google.com/
       Sashiko: Not Found
    -> [18] [PATCH v9 18/18] perf symbol: Lazily compute idle
       Link   :
https://lore.kernel.org/linux-perf-users/20260503002248.1040791-19-irogers%40google.com/
       Sashiko: Not Found
----------------------------------------
  Series : perf lock contention: Allow 'mmap_lock' in -L/--lock-filter
  Author : Namhyung Kim <namhyung@kernel.org>
  Version: v3
  Date   : Wed, 06 May 2026 16:19:19 +0000 (Latest Activity)
  Status : Reviewer work (No replies to series)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260506161920.847604-1-namhyung%40kernel.org)
  Unapplied Patches (1):
    -> [1] [PATCH v3] perf lock contention: Allow 'mmap_lock' in
-L/--lock-filter
       Link   :
https://lore.kernel.org/linux-perf-users/20260506161920.847604-1-namhyung%40kernel.org/
       Sashiko: Reviewed (No regressions)
----------------------------------------
  Series : perf tool: Support iostat for multiple platform
  Author : Yushan Wang <wangyushan12@huawei.com>
  Version: v2
  Date   : Thu, 07 May 2026 06:37:37 +0000 (Latest Activity)
  Status : Maintainer work (Review tags present on unapplied patches
or cover letter)
  Sashiko: Not Found
  Unapplied Patches (7):
    -> [1] [TAGGED] [RFT PATCH v2 1/7] perf stat: Check color's length
instead of the pointer
       Link   :
https://lore.kernel.org/linux-perf-users/20260507063737.3542950-2-wangyushan12%40huawei.com/
       Sashiko: Not Found
    -> [2] [TAGGED] [RFT PATCH v2 2/7] perf stat: Save unnecessary
print_metric() call
       Link   :
https://lore.kernel.org/linux-perf-users/20260507063737.3542950-3-wangyushan12%40huawei.com/
       Sashiko: Not Found
    -> [3] [RFT PATCH v2 3/7] perf-x86: iostat: Move iostat
arch-specific implementation to util
       Link   :
https://lore.kernel.org/linux-perf-users/20260507063737.3542950-4-wangyushan12%40huawei.com/
       Sashiko: Not Found
    -> [4] [TAGGED] [RFT PATCH v2 4/7] perf-x86: iostat: Change
iostat_prefix() to static
       Link   :
https://lore.kernel.org/linux-perf-users/20260507063737.3542950-5-wangyushan12%40huawei.com/
       Sashiko: Not Found
    -> [5] [RFT PATCH v2 5/7] perf-iostat: Extend iostat interface to
support different iostat PMUs
       Link   :
https://lore.kernel.org/linux-perf-users/20260507063737.3542950-6-wangyushan12%40huawei.com/
       Sashiko: Not Found
    -> [6] [RFT PATCH v2 6/7] perf-iostat: Make x86 iostat compatible
with new iostat framework
       Link   :
https://lore.kernel.org/linux-perf-users/20260507063737.3542950-7-wangyushan12%40huawei.com/
       Sashiko: Not Found
    -> [7] [RFT PATCH v2 7/7] perf-iostat: Enable iostat mode for
HiSilicon PCIe PMU
       Link   :
https://lore.kernel.org/linux-perf-users/20260507063737.3542950-8-wangyushan12%40huawei.com/
       Sashiko: Not Found
----------------------------------------
  Series : perf/core: Fix sampling period inconsistency across CPU migration
  Author : Minwoo Ahn <mwahn402@gmail.com>
  Version: v4
  Date   : Wed, 29 Apr 2026 09:51:34 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260429095134.10049-1-mwahn402%40gmail.com)
  Unapplied Patches (1):
    -> [1] [PATCH v4] perf/core: Fix sampling period inconsistency
across CPU migration
       Link   :
https://lore.kernel.org/linux-perf-users/20260429095134.10049-1-mwahn402%40gmail.com/
       Sashiko: Reviewed (0 Critical, 1 High, 2 Medium, 0 Low)
----------------------------------------
  Series : perf tools: Ensure event leader stays at head of evlist after sorting
  Author : Chun-Tse Shao <ctshao@google.com>
  Version: v2
  Date   : Fri, 01 May 2026 22:33:47 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260501223413.1001483-1-ctshao%40google.com)
  Unapplied Patches (1):
    -> [1] [PATCH v2] perf tools: Ensure event leader stays at head of
evlist after sorting
       Link   :
https://lore.kernel.org/linux-perf-users/20260501223413.1001483-1-ctshao%40google.com/
       Sashiko: Reviewed (No regressions)
----------------------------------------
  Series : perf tools: Add inject --aslr feature and prerequisite
robustness fixes
  Author : Ian Rogers <irogers@google.com>
  Version: v6
  Date   : Fri, 08 May 2026 08:27:26 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Not Found
  Unapplied Patches (5):
    -> [2] [PATCH v6 2/6] perf tool: Missing delegate_tool schedstat
delegates and dont_split_sample_group
       Link   :
https://lore.kernel.org/linux-perf-users/20260508082726.2795191-3-irogers%40google.com/
       Sashiko: Not Found
    -> [3] [PATCH v6 3/6] perf maps: Add maps__mutate_mapping
       Link   :
https://lore.kernel.org/linux-perf-users/20260508082726.2795191-4-irogers%40google.com/
       Sashiko: Not Found
    -> [4] [PATCH v6 4/6] perf inject/aslr: Add aslr tool to
remap/obfuscate virtual addresses
       Link   :
https://lore.kernel.org/linux-perf-users/20260508082726.2795191-5-irogers%40google.com/
       Sashiko: Not Found
    -> [5] [PATCH v6 5/6] perf test: Add inject ASLR test
       Link   :
https://lore.kernel.org/linux-perf-users/20260508082726.2795191-6-irogers%40google.com/
       Sashiko: Not Found
    -> [6] [PATCH v6 6/6] perf aslr: Strip sample registers
       Link   :
https://lore.kernel.org/linux-perf-users/20260508082726.2795191-7-irogers%40google.com/
       Sashiko: Not Found
  Applied Patches (1):
    -> [1] [PATCH v6 1/6] perf sched: Add missing mmap2 handler in timehist
       Commit: 91182741369b (date: 2026-05-11)
----------------------------------------
  Series : perf: Add is_mapping_symbol() helper for kernel mapping
symbol filtering
  Author : "Rui Qi" <qirui.001@bytedance.com>
  Version: v3
  Date   : Thu, 07 May 2026 07:11:03 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260506073820.2419087-1-qirui.001%40bytedance.com)
  Unapplied Patches (1):
    -> [1] [PATCH v2] perf: Extract is_mapping_symbol() helper for
kernel mapping symbol filtering
       Link   :
https://lore.kernel.org/linux-perf-users/20260506073820.2419087-1-qirui.001%40bytedance.com/
       Sashiko: Reviewed (0 Critical, 1 High, 1 Medium, 0 Low)
----------------------------------------
  Series : perf/x86: Don't write PEBS_ENABLED on KVM transitions
  Author : Sean Christopherson <seanjc@google.com>
  Version: v3
  Date   : Fri, 08 May 2026 23:13:53 +0000 (Latest Activity)
  Status : Maintainer work (Review tags present on unapplied patches
or cover letter)
  Sashiko: Failed
(https://sashiko.dev/#/patchset/20260508231353.406465-1-seanjc%40google.com)
  Unapplied Patches (9):
    -> [1] [TAGGED] [PATCH v3 1/9] perf/x86/intel: Ensure guest PEBS
path doesn't set unwanted PERF_GLOBAL_CTRL bits
       Link   :
https://lore.kernel.org/linux-perf-users/20260508231353.406465-2-seanjc%40google.com/
       Sashiko: Reviewed (0 Critical, 1 High, 0 Medium, 0 Low)
    -> [2] [TAGGED] [PATCH v3 2/9] perf/x86/intel: Don't write
PEBS_ENABLED on host<=>guest xfers if CPU has isolation
       Link   :
https://lore.kernel.org/linux-perf-users/20260508231353.406465-3-seanjc%40google.com/
       Sashiko: Reviewed (No regressions)
    -> [3] [PATCH v3 3/9] perf/x86/intel: Don't context switch DS_AREA
(and PEBS config) if PEBS is unused
       Link   :
https://lore.kernel.org/linux-perf-users/20260508231353.406465-4-seanjc%40google.com/
       Sashiko: Reviewed (No regressions)
    -> [4] [TAGGED] [PATCH v3 4/9] perf/x86/intel: Make @data a
mandatory param for intel_guest_get_msrs()
       Link   :
https://lore.kernel.org/linux-perf-users/20260508231353.406465-5-seanjc%40google.com/
       Sashiko: Reviewed (No regressions)
    -> [5] [TAGGED] [PATCH v3 5/9] perf/x86/intel: Invert names of
intel_ctrl_{guest,host}_mask
       Link   :
https://lore.kernel.org/linux-perf-users/20260508231353.406465-6-seanjc%40google.com/
       Sashiko: Reviewed (No regressions)
    -> [6] [PATCH v3 6/9] perf/x86: KVM: Have perf define a dedicated
struct for getting guest PEBS data
       Link   :
https://lore.kernel.org/linux-perf-users/20260508231353.406465-7-seanjc%40google.com/
       Sashiko: Reviewed (No regressions)
    -> [7] [TAGGED] [PATCH v3 7/9] perf/x86/intel: KVM: Handle
cross-mapped PEBS PMCs entirely within KVM
       Link   :
https://lore.kernel.org/linux-perf-users/20260508231353.406465-8-seanjc%40google.com/
       Sashiko: Failed
    -> [8] [TAGGED] [PATCH v3 8/9] KVM: VMX: Drop a redundant
pmu->global_ctrl check when processing pebs_enable
       Link   :
https://lore.kernel.org/linux-perf-users/20260508231353.406465-9-seanjc%40google.com/
       Sashiko: Failed
    -> [9] [TAGGED] [PATCH v3 9/9] KVM: VMX: Only tell perf to enable
PEBS counters for fully enabled PMCs
       Link   :
https://lore.kernel.org/linux-perf-users/20260508231353.406465-10-seanjc%40google.com/
       Sashiko: Failed
----------------------------------------
