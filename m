Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F9635F185
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779752348; cv=pass; b=uOAI4ARRVAFCNrlQtnJa7bqLN2Q+GEGpiNGf7S4mkDPMn17mrzNuUzynLuvGVfUdy+HEY7gxwJ01GPTYmm5+1uo0t1bg5jtasYsxLMXqLXVCpVBa/xmIHag4Syw9jh1ctfJd29/ikzghQoYrDuz19mqfpQO+ebWooSWfKO6d54I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779752348; c=relaxed/simple;
	bh=Bc0IsRXAvJe/fNYdOKIK6Q9O1WhYNBkVDDPWbceO+Lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=FgOzdQFLcNoPw0NzwY5GOVIG5fU5QWDsX/bQmtiXzsODwQ5e+8dO1mMHNam1e1gyHIYvqEqNIeP4U/ZXcLQiZzWlv4RvjkUkr/eYyIojbniexm3SGB7d6w37vWT31m/ASLfO0cQo75bTfYE8PKRkeZsZZcdtXE0ioUzflA5yX8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a209cTW+; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a209cTW+"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba180a022dso05ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 16:39:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779752344; cv=none;
        d=google.com; s=arc-20240605;
        b=a/H46O6wQl3lrPIpmON1nR6VoEjI+wxV4dZMfebSoZVpB+MjLTvPmG4f7MxzQU/NXC
         V6aRCW0oMgOeD1hCFzITqy6XfX6AhzQVjclJSlmPR/BzBXaMHwH0MPq4wxQzEirQAwGr
         Gfld2ltTWp+CpTbJTb2unY7GAItj859CcUYgUfXrF3Hqjp9gjakJrPMeazK2RJvCMHku
         7cqh4Ue1ARxbfva2EoWCBr3nY3NRLeBALlcICtI3S/ZtmidYaYKj98jTGXXr+2P82pmM
         xFcWhCYorXkIS0BXo61nE85VCvd1MArb00652LMLvJV5JD0UXGLbcPVLkrUEHu+Yaasr
         LAUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=KzwMF1O+wyJypiX2Z5KEQQCxchttAjME6XOHaeAzqZM=;
        fh=IjLvujN0g0DpOjXbbwJDi2DdaoHzS/0hcGzgBnFL0y8=;
        b=RB5YOnGgsvXeRCI7gppXoo2lYh7PYQrKOW86t9T7w2rXy196RPFCnyZ1aotUD/elyi
         ff2gauzXU/JyF/PTEYaNsitL8tNOhAVi6WiSnuNi8GZSAZ3lqCXPtTGctVWYFfhGIKY0
         2j28h2uZke9YNA/0jrie9jevHhwPsKY222JjbtpYDS+REl2ltrlxB1uUwDTGZq8t4QVy
         V3G9KdIww/izu0uwW6zxvPlJji0azqNBoStcnQ478FixUyYI8HMoErHcItNh0e+fOGk8
         EF4gBDH/x6JqpBdYn9ZwvAYgPlJ5ibMFrauXIB77+rXB8o6PTcI6pQdUmVWxOURHdqzh
         W/cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779752344; x=1780357144; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KzwMF1O+wyJypiX2Z5KEQQCxchttAjME6XOHaeAzqZM=;
        b=a209cTW+u3mYP+37iD7B9T6UwaCQpbqO+GrLDkcw+HKkxpX2xTDjEDq3+QwfJ8qdTK
         +wDa51Vdd2VFq6+gJjcq8Zb2sGO5Pd+jOSMV3/YNXRtc79uxTKZhHHaHRwEQhwwuD3Ma
         5rcPfPFF95giNX3Qi+s1x9Rd5MbMcG5/Vb+wulXJR/rPtByEKnXuH4HO7pG3s2glRr/i
         OVRJo7LS1agLn/Cc5JI3dQFVBD6YDaAFYYt0RrQS3OPUOCV45mMV+EfnMA+azGTjcEc8
         8yU12dO2FwMFshOk8cQrTIy7Gs91fedkSJ4vzacMlhamXo7zb+meLUSNFS3qh9cVztnl
         MR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779752344; x=1780357144;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KzwMF1O+wyJypiX2Z5KEQQCxchttAjME6XOHaeAzqZM=;
        b=OaWieHhFgg726LIQsVOgmMM3VHIoxA72uNJqQlb5tbeK02EYWWAA7eiTQxYG8ocCiI
         mohraqtW6P17PmHlMGEghTwmE0YA5VtzJR32a+Gp60w4n6jCtFWVJmmqWQFJHuTUM71S
         i3E5EX2t7DwXS1iT8R2E+lP2mI5fZxykC7hLLDg8P9ltr1/CwLTyT6ELkOcAdBJiPh6Z
         LbjIEE6bjW+pZUKOjQPoKfu6cdU4HK9ZfSgZ4OKy79TFGVUAaE59YyVjCIkiQncLut/3
         3siEYQ6tvF0hWCHTWefOBx35pL/NgY6mcY/ax2KsKc043old8lCZqlZouJP8NyTE5t3z
         ZglQ==
X-Forwarded-Encrypted: i=1; AFNElJ9n07r1LrX0b3ThPNrEG0m+14JX4/NauL4y08k/gdB5TlfFbAQuDwWt87kNjnggQCqYy708dr6bFdbJ7IAEOvX8@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8kDzh08wJ4Tn7gCIvmPAn855PAFI+92W+w7/0QPuO7bD3gOrW
	onsLdYf2tkaExuDsdfPbf7Aok3lL/ed6XoGB2d/aQ1Hgisvjf3Grq9b4BLAF7/voT2wIkquE0Sm
	hWJ5SR0a28PrzgK29PnLST+NF/uEtNTK/vjE5qg0o
X-Gm-Gg: Acq92OGX2cds+reEXC4xR0QtwcIGo2lY9jDEveZmYoIa8KS1SQZykgMudALdI17V1LZ
	vuwhj4utL+7unfyfo6MjV0w9pO8Nl9bUC40x8nD9OeWQKbBPQrUFSmgB4QSS9cQG3xaEmrRgq7+
	VLkgq18cU7hCRLYbZ5pQHJCXJjgPXBcosXi6vwOvH0PU+QH6cy4Upu9+zQ0ON/QrLYQ3zJOH4mW
	o84DOI0pK/InfX6euQdgnIjH7Wt4xRceTE+Ha8k8pgU/VaA1d4cLCZcaBHFdelAMMFIN8pg6Err
	mJAZL+jv86neZ7G/ijz4LmpLPkerAQ==
X-Received: by 2002:a17:902:e548:b0:2bd:bbe:e3a3 with SMTP id
 d9443c01a7336-2bebe9edcd4mr4032565ad.10.1779752343754; Mon, 25 May 2026
 16:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fX=vEmTaz6mWgExmrgyYMJmSyOD+1sMCzf7JTk1SkA-zQ@mail.gmail.com>
 <CAP-5=fU0pLzo8DGETQD3eWig747sGkwRwNs4AvcgGRQi+FGh4g@mail.gmail.com>
In-Reply-To: <CAP-5=fU0pLzo8DGETQD3eWig747sGkwRwNs4AvcgGRQi+FGh4g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 May 2026 16:38:52 -0700
X-Gm-Features: AVHnY4LKtWNXjaQEAXDrCCHEt0TuEcvoY5rQ5ao5vCMgJ4zOv-lTh2cJOKKQNGg
Message-ID: <CAP-5=fUkOHPJPZ3rT_HdFt8A-nzfGNEeeK76FNc3pEj1a4tzZQ@mail.gmail.com>
Subject: Re: Summary of perf-tools-next changes and patches sent to linux-perf-users
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

================================================================================
WEEK: 2026-05-11 to 2026-05-18
================================================================================

>>> MERGED PATCHES <<<
  [Merged] perf libunwind multiple remote support
           Author   : Ian Rogers <irogers@google.com>
           Commit   : 834c557167a9 - perf unwind-libunwind: Add RISC-V
libunwind support (by Ian Rogers)
           Commit   : 88b4275ff542 - perf unwind-libunwind: Remove
libunwind-local (by Ian Rogers)
           Commit   : 2723e9f8b5cf - perf unwind-libunwind: Move
flush/finish access out of local (by Ian Rogers)
           Commit   : fdf08e4b5a33 - perf unwind-libunwind: Make
libunwind register reading cross platform (by Ian Rogers)
           Commit   : 444508cd7c7b - perf build: Be more programmatic
when setting up libunwind variables (by Ian Rogers)
           Commit   : 4248ae6e7996 - perf unwind: Refactor get_entries
to allow dynamic libdw/libunwind selection (by Ian Rogers)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260513233151.572332-1-irogers%40google.com/
           Sashiko  :
https://sashiko.dev/#/patchset/20260513233151.572332-1-irogers%40google.com

  [Merged] perf trace: Introduce --show-cpu option to display cpu id
           Author   : Aaron Tomlin <atomlin@atomlin.com>
           Commit   : e445b78ffb8d - perf trace: Introduce --show-cpu
option to display cpu id (by Aaron Tomlin)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260424212933.151154-1-atomlin%40atomlin.com/
           Sashiko  :
https://sashiko.dev/#/patchset/20260424212933.151154-1-atomlin%40atomlin.com

  [Merged] perf trace beauty fcntl: Fix build with older kernel headers
           Author   : Florian Fainelli <florian.fainelli@broadcom.com>
           Commit   : 7ee7f48413c4 - perf trace beauty fcntl: Fix
build with older kernel headers (by Florian Fainelli)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260513192347.4007895-1-florian.fainelli%40broadcom.com/
           Sashiko  :
https://sashiko.dev/#/patchset/20260513192347.4007895-1-florian.fainelli%40broadcom.com

  [Merged] perf record: Refactor ARM64 leaf caller setup out of arch
           Author   : Ian Rogers <irogers@google.com>
           Commit   : 165daffc7c33 - perf record: Refactor ARM64 leaf
caller setup out of arch (by Ian Rogers)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260512054140.3427725-1-irogers%40google.com/
           Sashiko  :
https://sashiko.dev/#/patchset/20260512054140.3427725-1-irogers%40google.com

  [Merged] perf pmu: Skip test on Arm64 when #slots is zero
           Author   : Leo Yan <leo.yan@arm.com>
           Commit   : 2e2ba7d1ea55 - perf pmu: Skip test on Arm64 when
#slots is zero (by Leo Yan)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260410-perf_fix_pmu_metrics_test-v2-1-61826ab3ca8b%40arm.com/
           Sashiko  :
https://sashiko.dev/#/patchset/20260410-perf_fix_pmu_metrics_test-v2-1-61826ab3ca8b%40arm.com

  [Merged] perf sched stats: Fix segmentation faults, memory leaks,
and stale pointers in diff mode
           Author   : Ian Rogers <irogers@google.com>
           Commit   : 111388a0c01e - perf sched stats: Fix
segmentation faults, memory leaks, and stale pointers in diff mode (by
Ian Rogers)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260506041004.3196084-1-irogers%40google.com/
           Sashiko  :
https://sashiko.dev/#/patchset/20260506041004.3196084-1-irogers%40google.com

  [Merged] perf metricgroup: Avoid scanning unnecessary PMUs for
identifier match
           Author   : Ian Rogers <irogers@google.com>
           Commit   : e356a67cc4b6 - perf metricgroup: Avoid scanning
unnecessary PMUs for identifier match (by Ian Rogers)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260430161725.3131665-1-irogers%40google.com/
           Sashiko  :
https://sashiko.dev/#/patchset/20260430161725.3131665-1-irogers%40google.com

  [Merged] perf pmu-events AMD: Switch l2_itlb_misses to
bp_l1_tlb_miss_l2_tlb_miss.all
           Author   : Ian Rogers <irogers@google.com>
           Commit   : 41a543c86d11 - perf pmu-events AMD: Switch
l2_itlb_misses to bp_l1_tlb_miss_l2_tlb_miss.all (by Ian Rogers)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260414175855.2089482-1-irogers%40google.com/
           Sashiko  :
https://sashiko.dev/#/patchset/20260414175855.2089482-1-irogers%40google.com

  [Merged] perf build: Update kernel headers
           Author   : Namhyung Kim <namhyung@kernel.org>
           Commit   : 5a433107fab6 - perf trace: Update beautifier
script for clone flags (by Namhyung Kim)
           Commit   : 552636b9317c - perf trace: Add beautifier script
for fsmount flags (by Namhyung Kim)
           Commit   : be81aed3f749 - perf build: Add make
check-headers target (by Namhyung Kim)
           Commit   : ad2cd6f9def4 - perf trace: Sync
uapi/linux/sched.h with the kernel source (by Namhyung Kim)
           Commit   : ca706027b5bd - perf trace: Sync
uapi/linux/mount.h with the kernel source (by Namhyung Kim)
           Commit   : b30e1493e3e2 - perf trace: Sync uapi/linux/fs.h
with the kernel source (by Namhyung Kim)
           Commit   : aa13e4b120f9 - perf trace: Sync linux/socket.h
with the kernel source (by Namhyung Kim)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260510202346.49853-1-namhyung%40kernel.org/
           Sashiko  :
https://sashiko.dev/#/patchset/20260510202346.49853-1-namhyung%40kernel.org

  [Merged] perf: fix some tests for musl
           Author   : Martin Kaiser <martin@kaiser.cx>
           Commit   : e1c19cd376a3 - perf test: Fix "trace summary"
test for musl-based systems (by Martin Kaiser)
           Commit   : 9a4a67dddc3d - perf test: Fix sys_enter_openat
event test for musl (by Martin Kaiser)
           Commit   : a4cbd51862d4 - perf test: Fix nanosleep check in
the ftrace test (by Martin Kaiser)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260428143920.2466185-1-martin%40kaiser.cx/
           Sashiko  :
https://sashiko.dev/#/patchset/20260428143920.2466185-1-martin%40kaiser.cx

  [Merged (Git Only)] perf tool: Fix missing schedstat delegates and
dont_split_sample_group in delegate_tool
                      Commit: 09d355618f7c by Ian Rogers


>>> ACTIVE & MISSING PATCHES <<<
  Series : perf/x86/intel/uncore: Bug fixes and cleanups
  Author : Zide Chen <zide.chen@intel.com>
  Version: v1
  Date   : Mon, 11 May 2026 23:05:27 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260511230527.26096-1-zide.chen%40intel.com)
  Unapplied Patches (6):
    -> [1] [PATCH 1/6] perf/x86/intel/uncore: Fix discovery unit
lookup for multi-die systems
       Link   :
https://lore.kernel.org/linux-perf-users/20260511230527.26096-2-zide.chen%40intel.com/
       Sashiko: Reviewed (0 Critical, 1 High, 0 Medium, 0 Low)
    -> [2] [PATCH 2/6] perf/x86/intel/uncore: Fix PCI device refcount
leak in UPI discovery
       Link   :
https://lore.kernel.org/linux-perf-users/20260511230527.26096-3-zide.chen%40intel.com/
       Sashiko: Reviewed (No regressions)
    -> [3] [PATCH 3/6] perf/x86/intel/uncore: Defer ADL global PMON
enable to enable_box()
       Link   :
https://lore.kernel.org/linux-perf-users/20260511230527.26096-4-zide.chen%40intel.com/
       Sashiko: Reviewed (0 Critical, 1 High, 0 Medium, 0 Low)
    -> [4] [PATCH 4/6] perf/x86/intel/uncore: Move die_to_cpu() to uncore.c
       Link   :
https://lore.kernel.org/linux-perf-users/20260511230527.26096-5-zide.chen%40intel.com/
       Sashiko: Reviewed (0 Critical, 1 High, 0 Medium, 0 Low)
    -> [5] [PATCH 5/6] perf/x86/intel/uncore: Fix uncore_die_to_cpu()
for offline dies
       Link   :
https://lore.kernel.org/linux-perf-users/20260511230527.26096-6-zide.chen%40intel.com/
       Sashiko: Reviewed (No regressions)
    -> [6] [PATCH 6/6] perf/x86/intel/uncore: Implement global init
callback for GNR uncore
       Link   :
https://lore.kernel.org/linux-perf-users/20260511230527.26096-7-zide.chen%40intel.com/
       Sashiko: Reviewed (0 Critical, 0 High, 1 Medium, 0 Low)
----------------------------------------
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
  Series : Silence spurious warnings and crashes from kunit test suites
  Author : Jia He <justin.he@arm.com>
  Version: v1
  Date   : Thu, 14 May 2026 05:04:55 +0000 (Latest Activity)
  Status : Maintainer work (Review tags present on unapplied patches
or cover letter)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260514050455.2954509-1-justin.he%40arm.com)
  Unapplied Patches (7):
    -> [1] [TAGGED] [PATCH 1/7] init/initramfs_test:
wait_for_initramfs() before running
       Link   :
https://lore.kernel.org/linux-perf-users/20260514050455.2954509-2-justin.he%40arm.com/
       Sashiko: Reviewed (0 Critical, 0 High, 0 Medium, 1 Low)
    -> [2] [TAGGED] [PATCH 2/7] kfence: kunit: skip when no pool is available
       Link   :
https://lore.kernel.org/linux-perf-users/20260514050455.2954509-3-justin.he%40arm.com/
       Sashiko: Reviewed (No regressions)
    -> [3] [PATCH 3/7] lib/math/int_log: drop WARN_ON for value == 0
       Link   :
https://lore.kernel.org/linux-perf-users/20260514050455.2954509-4-justin.he%40arm.com/
       Sashiko: Reviewed (No regressions)
    -> [4] [PATCH 4/7] kunit: platform: catch duplicate (name, id) in
kunit_platform_device_add()
       Link   :
https://lore.kernel.org/linux-perf-users/20260514050455.2954509-5-justin.he%40arm.com/
       Sashiko: Reviewed (0 Critical, 1 High, 1 Medium, 0 Low)
    -> [5] [PATCH 5/7] misc: reject duplicate names in misc_register()
       Link   :
https://lore.kernel.org/linux-perf-users/20260514050455.2954509-6-justin.he%40arm.com/
       Sashiko: Reviewed (0 Critical, 1 High, 0 Medium, 0 Low)
    -> [6] [TAGGED] [PATCH 6/7] hw_breakpoint_test: fix test_many_cpus
failure on large systems
       Link   :
https://lore.kernel.org/linux-perf-users/20260514050455.2954509-7-justin.he%40arm.com/
       Sashiko: Reviewed (No regressions)
    -> [7] [PATCH 7/7] lib/tests: test_ratelimit: fix stress test
thread lifecycle and leak
       Link   :
https://lore.kernel.org/linux-perf-users/20260514050455.2954509-8-justin.he%40arm.com/
       Sashiko: Reviewed (0 Critical, 1 High, 0 Medium, 0 Low)
----------------------------------------
  Series : perf: Improve refresh limit in overflow handler
  Author : Leo Yan <leo.yan@arm.com>
  Version: v2
  Date   : Thu, 14 May 2026 16:21:20 +0000 (Latest Activity)
  Status : Reviewer work (No replies to series)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260514-arm_cs_clean_perf_handle-v2-0-cbb29c3b3661%40arm.com)
  Unapplied Patches (2):
    -> [1] [PATCH v2 1/2] selftests/perf_events: Add test for refresh
limit signals
       Link   :
https://lore.kernel.org/linux-perf-users/20260514-arm_cs_clean_perf_handle-v2-1-cbb29c3b3661%40arm.com/
       Sashiko: Reviewed (0 Critical, 0 High, 0 Medium, 3 Low)
    -> [2] [PATCH v2 2/2] perf/core: Ignore overflows while disable is pending
       Link   :
https://lore.kernel.org/linux-perf-users/20260514-arm_cs_clean_perf_handle-v2-2-cbb29c3b3661%40arm.com/
       Sashiko: Reviewed (0 Critical, 3 High, 0 Medium, 0 Low)
----------------------------------------
  Series : perf/core: Use AUX pause/resume for throttling
  Author : Leo Yan <leo.yan@arm.com>
  Version: v1
  Date   : Thu, 14 May 2026 15:06:08 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260514-aux-throttle-fix-v1-1-92bdc84f5922%40arm.com)
  Unapplied Patches (1):
    -> [1] [PATCH] perf/core: Use AUX pause/resume for throttling
       Link   :
https://lore.kernel.org/linux-perf-users/20260514-aux-throttle-fix-v1-1-92bdc84f5922%40arm.com/
       Sashiko: Reviewed (0 Critical, 5 High, 0 Medium, 0 Low)
----------------------------------------
  Series : Enable perf tracing for unprivileged users
  Author : Anubhav Shelat <ashelat@redhat.com>
  Version: v4
  Date   : Fri, 15 May 2026 19:40:07 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Failed
(https://sashiko.dev/#/patchset/20260515194010.93725-2-ashelat%40redhat.com)
  Unapplied Patches (3):
    -> [1] [PATCH v4 1/3] perf evsel: don't set PERF_SAMPLE_IP for
unprivileged tracepoints
       Link   :
https://lore.kernel.org/linux-perf-users/20260515194010.93725-3-ashelat%40redhat.com/
       Sashiko: Reviewed (0 Critical, 1 High, 0 Medium, 0 Low)
    -> [2] [PATCH v4 2/3] perf: enable unprivileged syscall tracing
with perf trace
       Link   :
https://lore.kernel.org/linux-perf-users/20260515194010.93725-4-ashelat%40redhat.com/
       Sashiko: Reviewed (No regressions)
    -> [3] [PATCH v4 3/3] tracefs: make root directory world-traversable
       Link   :
https://lore.kernel.org/linux-perf-users/20260515194010.93725-5-ashelat%40redhat.com/
       Sashiko: Failed
----------------------------------------
  Series : treewide: replace /usr/bin/python3 shebangs with env python3
  Author : Oli R <sigmatwojastara@gmail.com>
  Version: v1
  Date   : Fri, 15 May 2026 18:07:59 +0000 (Latest Activity)
  Status : Maintainer work (Review tags present on unapplied patches
or cover letter)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260515180806.246914-1-sigmatwojastara%40gmail.com)
  Unapplied Patches (1):
    -> [1] [TAGGED] [PATCH] treewide: replace /usr/bin/python3
shebangs with env python3
       Link   :
https://lore.kernel.org/linux-perf-users/20260515180806.246914-1-sigmatwojastara%40gmail.com/
       Sashiko: Reviewed (0 Critical, 0 High, 1 Medium, 0 Low)
----------------------------------------
  Series : perf build: Fix cross-arch build failures and GCC 14 warnings
  Author : Li Guan <guanli.oerv@isrc.iscas.ac.cn>
  Version: v1
  Date   : Wed, 13 May 2026 15:48:51 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260513154851.1085334-1-guanli.oerv%40isrc.iscas.ac.cn)
  Unapplied Patches (3):
    -> [1] [PATCH 1/3] perf build: Fix cross-arch build failures by
isolating auxtrace objects
       Link   :
https://lore.kernel.org/linux-perf-users/20260513154851.1085334-2-guanli.oerv%40isrc.iscas.ac.cn/
       Sashiko: Reviewed (1 Critical, 3 High, 0 Medium, 2 Low)
    -> [2] [PATCH 2/3] perf riscv: Fix discarded const qualifier error
in _get_field()
       Link   :
https://lore.kernel.org/linux-perf-users/20260513154851.1085334-3-guanli.oerv%40isrc.iscas.ac.cn/
       Sashiko: Reviewed (0 Critical, 1 High, 0 Medium, 1 Low)
    -> [3] [PATCH 3/3] perf script: Provide weak stubs for instruction decoding
       Link   :
https://lore.kernel.org/linux-perf-users/20260513154851.1085334-4-guanli.oerv%40isrc.iscas.ac.cn/
       Sashiko: Reviewed (0 Critical, 1 High, 0 Medium, 1 Low)
----------------------------------------
  Series : x86/events/amd/iommu: Fix cpumask of IOMMU events
  Author : Vasant Hegde <vasant.hegde@amd.com>
  Version: v1
  Date   : Sun, 17 May 2026 11:40:26 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260517114026.6817-1-vasant.hegde%40amd.com)
  Unapplied Patches (1):
    -> [1] [PATCH] x86/events/amd/iommu: Fix cpumask of IOMMU events
       Link   :
https://lore.kernel.org/linux-perf-users/20260517114026.6817-1-vasant.hegde%40amd.com/
       Sashiko: Reviewed (0 Critical, 1 High, 0 Medium, 0 Low)
----------------------------------------
  Series : perf/x86/intel/uncore: PMU setup robustness fixes
  Author : Zide Chen <zide.chen@intel.com>
  Version: v1
  Date   : Tue, 12 May 2026 23:30:48 +0000 (Latest Activity)
  Status : Maintainer work (Review tags present on unapplied patches
or cover letter)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260512233048.9577-1-zide.chen%40intel.com)
  Unapplied Patches (7):
    -> [1] [TAGGED] [PATCH 1/7] perf/x86/intel/uncore: Rename refcount
fields and other cleanups
       Link   :
https://lore.kernel.org/linux-perf-users/20260512233048.9577-2-zide.chen%40intel.com/
       Sashiko: Reviewed (0 Critical, 2 High, 0 Medium, 0 Low)
    -> [2] [TAGGED] [PATCH 2/7] perf/x86/intel/uncore: Let init_box()
callback report failures
       Link   :
https://lore.kernel.org/linux-perf-users/20260512233048.9577-3-zide.chen%40intel.com/
       Sashiko: Reviewed (0 Critical, 1 High, 0 Medium, 0 Low)
    -> [3] [TAGGED] [PATCH 3/7] perf/x86/intel/uncore: Keep PCI PMUs
working when MMIO/MSR setup fails
       Link   :
https://lore.kernel.org/linux-perf-users/20260512233048.9577-4-zide.chen%40intel.com/
       Sashiko: Reviewed (No regressions)
    -> [4] [TAGGED] [PATCH 4/7] perf/x86/intel/uncore: Factor out box setup code
       Link   :
https://lore.kernel.org/linux-perf-users/20260512233048.9577-5-zide.chen%40intel.com/
       Sashiko: Reviewed (0 Critical, 1 High, 0 Medium, 0 Low)
    -> [5] [TAGGED] [PATCH 5/7] perf/x86/intel/uncore: Introduce PMU
flags and broken state
       Link   :
https://lore.kernel.org/linux-perf-users/20260512233048.9577-6-zide.chen%40intel.com/
       Sashiko: Reviewed (1 Critical, 1 High, 2 Medium, 0 Low)
    -> [6] [TAGGED] [PATCH 6/7] perf/x86/intel/uncore: Fix uncore_box
ref/unref ordering on CPU hotplug
       Link   :
https://lore.kernel.org/linux-perf-users/20260512233048.9577-7-zide.chen%40intel.com/
       Sashiko: Reviewed (1 Critical, 0 High, 0 Medium, 0 Low)
    -> [7] [TAGGED] [PATCH 7/7] perf/x86/intel/uncore: Implement lazy
setup for MSR/MMIO PMU
       Link   :
https://lore.kernel.org/linux-perf-users/20260512233048.9577-8-zide.chen%40intel.com/
       Sashiko: Reviewed (0 Critical, 1 High, 0 Medium, 0 Low)
----------------------------------------
  Series : perf: Fix missing branch counter information in script and annotate
  Author : Thomas Falcon <thomas.falcon@intel.com>
  Version: v2
  Date   : Wed, 29 Apr 2026 15:29:17 +0000 (Latest Activity)
  Status : Maintainer work (Review tags present on unapplied patches
or cover letter)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260429152917.178803-1-thomas.falcon%40intel.com)
  Unapplied Patches (2):
    -> [1] [TAGGED] [PATCH 1/2 v2] perf script: Fix missing '+'
indicator when branch counter reaches upper limit
       Link   :
https://lore.kernel.org/linux-perf-users/20260429152917.178803-2-thomas.falcon%40intel.com/
       Sashiko: Reviewed (0 Critical, 0 High, 1 Medium, 0 Low)
    -> [2] [TAGGED] [PATCH 2/2 v2] perf annotate: Fix missing branch
counter column in TUI mode
       Link   :
https://lore.kernel.org/linux-perf-users/20260429152917.178803-3-thomas.falcon%40intel.com/
       Sashiko: Reviewed (No regressions)
----------------------------------------
  Series : perf test: Harness improvements
  Author : Ian Rogers <irogers@google.com>
  Version: v1
  Date   : Wed, 13 May 2026 23:04:50 +0000 (Latest Activity)
  Status : Reviewer work (No replies to series)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260513230450.529380-1-irogers%40google.com)
  Unapplied Patches (14):
    -> [1] [PATCH v1 01/14] perf jevents.py: Make generated C code
more kernel style
       Link   :
https://lore.kernel.org/linux-perf-users/20260513230450.529380-2-irogers%40google.com/
       Sashiko: Reviewed (No regressions)
    -> [2] [PATCH v1 02/14] perf pmu-events: Add API to get metric
table name and iterate tables
       Link   :
https://lore.kernel.org/linux-perf-users/20260513230450.529380-3-irogers%40google.com/
       Sashiko: Reviewed (0 Critical, 0 High, 2 Medium, 0 Low)
    -> [3] [PATCH v1 03/14] perf test: Drain pipe after child finishes
to avoid losing output
       Link   :
https://lore.kernel.org/linux-perf-users/20260513230450.529380-4-irogers%40google.com/
       Sashiko: Reviewed (No regressions)
    -> [4] [PATCH v1 04/14] perf test: Support dynamic test suites
with setup callback and private data
       Link   :
https://lore.kernel.org/linux-perf-users/20260513230450.529380-5-irogers%40google.com/
       Sashiko: Reviewed (0 Critical, 1 High, 1 Medium, 0 Low)
    -> [5] [PATCH v1 05/14] perf test pmu-events: A sub-test per metric table
       Link   :
https://lore.kernel.org/linux-perf-users/20260513230450.529380-6-irogers%40google.com/
       Sashiko: Reviewed (No regressions)
    -> [6] [PATCH v1 06/14] perf test: Refactor parallel poll loop to
drain all pipes simultaneously
       Link   :
https://lore.kernel.org/linux-perf-users/20260513230450.529380-7-irogers%40google.com/
       Sashiko: Reviewed (0 Critical, 0 High, 3 Medium, 1 Low)
    -> [7] [PATCH v1 07/14] perf test: Show snippet failure output for verbose=1
       Link   :
https://lore.kernel.org/linux-perf-users/20260513230450.529380-8-irogers%40google.com/
       Sashiko: Reviewed (0 Critical, 0 High, 1 Medium, 1 Low)
    -> [8] [PATCH v1 08/14] perf test: Add summary reporting
       Link   :
https://lore.kernel.org/linux-perf-users/20260513230450.529380-9-irogers%40google.com/
       Sashiko: Reviewed (0 Critical, 0 High, 3 Medium, 0 Low)
    -> [9] [PATCH v1 09/14] perf test: Fix subtest status alignment
for multi-digit indexes
       Link   :
https://lore.kernel.org/linux-perf-users/20260513230450.529380-10-irogers%40google.com/
       Sashiko: Reviewed (No regressions)
    -> [10] [PATCH v1 10/14] perf test: Skip shebang and SPDX comments
in shell test descriptions
       Link   :
https://lore.kernel.org/linux-perf-users/20260513230450.529380-11-irogers%40google.com/
       Sashiko: Reviewed (No regressions)
    -> [11] [PATCH v1 11/14] perf test: Split monolithic 'util' test
suite into sub-tests
       Link   :
https://lore.kernel.org/linux-perf-users/20260513230450.529380-12-irogers%40google.com/
       Sashiko: Reviewed (No regressions)
    -> [12] [PATCH v1 12/14] perf test: Add -j/--junit option for
JUnit XML test reports
       Link   :
https://lore.kernel.org/linux-perf-users/20260513230450.529380-13-irogers%40google.com/
       Sashiko: Reviewed (0 Critical, 0 High, 3 Medium, 1 Low)
    -> [13] [PATCH v1 13/14] perf test: Add shell test to validate
JUnit XML reporting output
       Link   :
https://lore.kernel.org/linux-perf-users/20260513230450.529380-14-irogers%40google.com/
       Sashiko: Reviewed (No regressions)
    -> [14] [PATCH v1 14/14] perf test: Remove /usr/bin/cc dependency
from Intel PT shell test
       Link   :
https://lore.kernel.org/linux-perf-users/20260513230450.529380-15-irogers%40google.com/
       Sashiko: Reviewed (0 Critical, 1 High, 2 Medium, 2 Low)
----------------------------------------
  Series : perf script powerpc: Update the hcall list with new hcalls
  Author : Gautam Menghani <Gautam.Menghani@ibm.com>
  Version: v1
  Date   : Tue, 12 May 2026 08:46:51 +0000 (Latest Activity)
  Status : Reviewer work (No replies to series)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260512084654.57729-1-Gautam.Menghani%40ibm.com)
  Unapplied Patches (1):
    -> [1] [PATCH] perf script powerpc: Update the hcall list with new hcalls
       Link   :
https://lore.kernel.org/linux-perf-users/20260512084654.57729-1-Gautam.Menghani%40ibm.com/
       Sashiko: Reviewed (No regressions)
----------------------------------------
  Series : perf cs-etm: stamp pid/tid/EL on each buffered packet to
fix cross-pid attribution
  Author : Amir Ayupov <aaupov@meta.com>
  Version: v1
  Date   : Fri, 15 May 2026 02:11:34 +0000 (Latest Activity)
  Status : Reviewer work (No replies to series)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260515021135.1729028-1-aaupov%40meta.com)
  Unapplied Patches (1):
    -> [1] [PATCH] perf cs-etm: stamp pid/tid/EL on each buffered
packet to fix cross-pid attribution
       Link   :
https://lore.kernel.org/linux-perf-users/20260515021135.1729028-1-aaupov%40meta.com/
       Sashiko: Reviewed (No regressions)
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
  Series : perf build: Reduce build time by one third
  Author : Ian Rogers <irogers@google.com>
  Version: v1
  Date   : Tue, 12 May 2026 05:35:39 +0000 (Latest Activity)
  Status : Maintainer work (Review tags present on unapplied patches
or cover letter)
  Sashiko: Not Found
  Unapplied Patches (5):
    -> [1] [TAGGED] [PATCH v1 01/14] bpftool build: Restrict feature
tests during bootstrap compilation
       Link   :
https://lore.kernel.org/linux-perf-users/20260512053539.3410189-2-irogers%40google.com/
       Sashiko: Not Found
    -> [7] [TAGGED] [PATCH v1 07/14] perf build: Move static libbpf
dependency out of prepare step
       Link   :
https://lore.kernel.org/linux-perf-users/20260512053539.3410189-8-irogers%40google.com/
       Sashiko: Not Found
    -> [8] [TAGGED] [PATCH v1 08/14] perf build: Pre-generate BPF
skeletons during umbrella prepare phase
       Link   :
https://lore.kernel.org/linux-perf-users/20260512053539.3410189-9-irogers%40google.com/
       Sashiko: Not Found
    -> [11] [TAGGED] [PATCH v1 11/14] tools build: Integrate
libdebuginfod into test-all fast path
       Link   :
https://lore.kernel.org/linux-perf-users/20260512053539.3410189-12-irogers%40google.com/
       Sashiko: Not Found
    -> [13] [TAGGED] [PATCH v1 13/14] perf pmu-events: Parallelize
JSON and metric pre-computation in jevents.py
       Link   :
https://lore.kernel.org/linux-perf-users/20260512053539.3410189-14-irogers%40google.com/
       Sashiko: Not Found
  Applied Patches (9):
    -> [2] [PATCH v1 02/14] perf trace beauty: Make beauty generated C
code standalone .o files
       Commit: 537609924c43 (date: 2026-05-20)
    -> [3] [PATCH v1 03/14] perf build: Decouple pmu-events from
prepare umbrella target
       Commit: b9453fa7726a (date: 2026-05-20)
    -> [4] [PATCH v1 04/14] perf build: Remove empty archheaders target
       Commit: 5af31e15732e (date: 2026-05-20)
    -> [5] [PATCH v1 05/14] perf build: Move BPF skeleton generation
out of Makefile.perf
       Commit: 713eeb227940 (date: 2026-05-20)
    -> [6] [PATCH v1 06/14] perf build: Encapsulate vmlinux.h and
bpftool in bpf_skel.mak
       Commit: 9798ac0128da (date: 2026-05-20)
    -> [9] [PATCH v1 09/14] perf build: Move libsymbol dependency out
of prepare step
       Commit: 96e808e5671d (date: 2026-05-20)
    -> [10] [PATCH v1 10/14] perf build: Remove redundant libbpf
feature check for static builds
       Commit: 29331b2edb86 (date: 2026-05-20)
    -> [12] [PATCH v1 12/14] perf pmu-events: Split big_c_string
storage into standalone compilation unit
       Commit: bb922345eec1 (date: 2026-05-20)
    -> [14] [PATCH v1 14/14] perf build: Prefix SCRIPTS with output
directory to fix continuous rebuilds
       Commit: 85cc481af5ff (date: 2026-05-20)
----------------------------------------
  Series : perf/x86/intel: Fix inaccurate hard-coded event configurations
  Author : Dapeng Mi <dapeng1.mi@linux.intel.com>
  Version: v1
  Date   : Fri, 15 May 2026 06:11:43 +0000 (Latest Activity)
  Status : Maintainer work (Review tags present on unapplied patches
or cover letter)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260515061143.338553-1-dapeng1.mi%40linux.intel.com)
  Unapplied Patches (11):
    -> [1] [TAGGED] [PATCH 01/11] perf/x86/intel: Update event
constraints and cache_extra_regs[] for ICX
       Link   :
https://lore.kernel.org/linux-perf-users/20260515061143.338553-2-dapeng1.mi%40linux.intel.com/
       Sashiko: Reviewed (No regressions)
    -> [2] [PATCH 02/11] perf/x86/intel: Update event constraints and
cache_extra_regs[] for SPR
       Link   :
https://lore.kernel.org/linux-perf-users/20260515061143.338553-3-dapeng1.mi%40linux.intel.com/
       Sashiko: Reviewed (No regressions)
    -> [3] [TAGGED] [PATCH 03/11] perf/x86/intel: Update event
constraints for DMR
       Link   :
https://lore.kernel.org/linux-perf-users/20260515061143.338553-4-dapeng1.mi%40linux.intel.com/
       Sashiko: Reviewed (No regressions)
    -> [4] [PATCH 04/11] perf/x86/intel: Update event constraints and
cache_extra_regs[] for ADL
       Link   :
https://lore.kernel.org/linux-perf-users/20260515061143.338553-5-dapeng1.mi%40linux.intel.com/
       Sashiko: Reviewed (0 Critical, 0 High, 1 Medium, 1 Low)
    -> [5] [PATCH 05/11] perf/x86/intel: Update event constraints and
cache_extra_regs[] for MTL
       Link   :
https://lore.kernel.org/linux-perf-users/20260515061143.338553-6-dapeng1.mi%40linux.intel.com/
       Sashiko: Reviewed (No regressions)
    -> [6] [PATCH 06/11] perf/x86/intel: Update event constraints and
cache_extra_regs[] for LNL
       Link   :
https://lore.kernel.org/linux-perf-users/20260515061143.338553-7-dapeng1.mi%40linux.intel.com/
       Sashiko: Reviewed (No regressions)
    -> [7] [PATCH 07/11] perf/x86/intel: Update event constraints and
cache_extra_regs[] for ARL
       Link   :
https://lore.kernel.org/linux-perf-users/20260515061143.338553-8-dapeng1.mi%40linux.intel.com/
       Sashiko: Reviewed (0 Critical, 1 High, 0 Medium, 0 Low)
    -> [8] [PATCH 08/11] perf/x86/intel: Update event constraints for PTL
       Link   :
https://lore.kernel.org/linux-perf-users/20260515061143.338553-9-dapeng1.mi%40linux.intel.com/
       Sashiko: Reviewed (No regressions)
    -> [9] [PATCH 09/11] perf/x86/intel: Update event constraints and
cache_extra_regs[] for NVL
       Link   :
https://lore.kernel.org/linux-perf-users/20260515061143.338553-10-dapeng1.mi%40linux.intel.com/
       Sashiko: Reviewed (No regressions)
    -> [10] [TAGGED] [PATCH 10/11] perf/x86/intel: Update event
constraints and cache_extra_regs[] for SRF
       Link   :
https://lore.kernel.org/linux-perf-users/20260515061143.338553-11-dapeng1.mi%40linux.intel.com/
       Sashiko: Reviewed (No regressions)
    -> [11] [PATCH 11/11] perf/x86/intel: Update event constraints and
cache_extra_regs[] for CWF
       Link   :
https://lore.kernel.org/linux-perf-users/20260515061143.338553-12-dapeng1.mi%40linux.intel.com/
       Sashiko: Reviewed (No regressions)
----------------------------------------
  Series : perf: Revert direct PMU stop for refresh limit
  Author : Leo Yan <leo.yan@arm.com>
  Version: v1
  Date   : Tue, 12 May 2026 14:59:53 +0000 (Latest Activity)
  Status : Reviewer work (No replies to series)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260512-arm_cs_clean_perf_handle-v1-0-75ff373ecd22%40arm.com)
  Unapplied Patches (2):
    -> [1] [PATCH 1/2] selftests/perf_events: Add test for refresh limit signals
       Link   :
https://lore.kernel.org/linux-perf-users/20260512-arm_cs_clean_perf_handle-v1-1-75ff373ecd22%40arm.com/
       Sashiko: Reviewed (0 Critical, 1 High, 1 Medium, 0 Low)
    -> [2] [PATCH 2/2] Revert "perf: Fix the POLL_HUP delivery breakage"
       Link   :
https://lore.kernel.org/linux-perf-users/20260512-arm_cs_clean_perf_handle-v1-2-75ff373ecd22%40arm.com/
       Sashiko: Reviewed (0 Critical, 1 High, 0 Medium, 0 Low)
----------------------------------------
  Series : perf kvm stat: Update the exit reason mappings
  Author : Gautam Menghani <gautam@linux.ibm.com>
  Version: v1
  Date   : Tue, 12 May 2026 12:04:08 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260512120408.59332-1-gautam%40linux.ibm.com)
  Unapplied Patches (1):
    -> [1] [PATCH] perf kvm stat: Update the exit reason mappings
       Link   :
https://lore.kernel.org/linux-perf-users/20260512120408.59332-1-gautam%40linux.ibm.com/
       Sashiko: Reviewed (0 Critical, 0 High, 1 Medium, 0 Low)
----------------------------------------
  Series : perf arm-spe: Don't warn about the discard bit if it doesn't exist
  Author : James Clark <james.clark@linaro.org>
  Version: v1
  Date   : Fri, 10 Apr 2026 11:05:12 +0000 (Latest Activity)
  Status : Maintainer work (Review tags present on unapplied patches
or cover letter)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260410-james-spe-discard-warning-v1-1-985c02756ee4%40linaro.org)
  Unapplied Patches (1):
    -> [1] [TAGGED] [PATCH] perf arm-spe: Don't warn about the discard
bit if it doesn't exist
       Link   :
https://lore.kernel.org/linux-perf-users/20260410-james-spe-discard-warning-v1-1-985c02756ee4%40linaro.org/
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
  Series : perf tests data_validation: Fixup test header
  Author : Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
  Version: v1
  Date   : Mon, 11 May 2026 12:10:47 +0000 (Latest Activity)
  Status : Maintainer work (Review tags present on unapplied patches
or cover letter)
  Sashiko: Failed To Apply
(https://sashiko.dev/#/patchset/agHHR56pFGeDJOxE%40x1)
  Unapplied Patches (1):
    -> [1] [TAGGED] [PATCH 1/1] perf tests data_validation: Fixup test header
       Link   : https://lore.kernel.org/linux-perf-users/agHHR56pFGeDJOxE%40x1/
       Sashiko: Not Found
----------------------------------------
  Series : perf test: Make leafloop workload immune to compiler options
  Author : James Clark <james.clark@linaro.org>
  Version: v2
  Date   : Mon, 11 May 2026 09:19:35 +0000 (Latest Activity)
  Status : Maintainer work (Review tags present on unapplied patches
or cover letter)
  Sashiko: Failed
(https://sashiko.dev/#/patchset/20260511-james-perf-leafloop-stack-v2-1-79f7383f545e%40linaro.org)
  Unapplied Patches (1):
    -> [1] [TAGGED] [PATCH v2] perf test: Make leafloop workload
immune to compiler options
       Link   :
https://lore.kernel.org/linux-perf-users/20260511-james-perf-leafloop-stack-v2-1-79f7383f545e%40linaro.org/
       Sashiko: Failed
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
  Series : uprobes: Use flexible array for xol_area bitmap
  Author : Rosen Penev <rosenp@gmail.com>
  Version: v2
  Date   : Mon, 11 May 2026 22:56:48 +0000 (Latest Activity)
  Status : Maintainer work (Review tags present on unapplied patches
or cover letter)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260511225648.27886-1-rosenp%40gmail.com)
  Unapplied Patches (1):
    -> [1] [TAGGED] [PATCHv2] uprobes: Use flexible array for xol_area bitmap
       Link   :
https://lore.kernel.org/linux-perf-users/20260511225648.27886-1-rosenp%40gmail.com/
       Sashiko: Reviewed (No regressions)
----------------------------------------
