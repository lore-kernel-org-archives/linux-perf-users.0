Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3894357D0E
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 23:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779752263; cv=pass; b=ACx/OzLsEHJy6zuKuN/hYGUHoKJirMtad3qvQ8CpvzSfYR9uvPmgjymnGTqOzv6l4GPiT02mZEmenhpdbQf/VFAhjAF/xpVPaQ6KUUv8M/KX1bCv314/ClSx71ADPwCpVs92Jaki5vnxv/o3Pz3eyiEYP3l18JtFaeaNL3BvxbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779752263; c=relaxed/simple;
	bh=UAocp6BnwK9e3cZt7Joig+EIdGPtFjVnHZ3sjgwgd6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=qZeLeWrvBE/BS41Jp+LyDfBLcCzpE0YgA9fuLM4HMkHvfDRfYfaik7OZi21DKItGF7J8tmsKR/VANq8GmQklJjplfcU8Ox4oAIgb4GT/ZSGue7fOlkHo/Ifzb2nMt0W42KaHAT7BvPsvXwkMwMJUdmTNCwOs1ZOCy//9hH610u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y8tKP5hK; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y8tKP5hK"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso255ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 16:37:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779752259; cv=none;
        d=google.com; s=arc-20240605;
        b=G4JSdQXf87sW7D5Lb40iPLZZiMOVMiCMz9pDV+5V5QkOIoof7/SrOLDtDC7YHmJii8
         9DxDq6wf1LlBJcpjsw2VHTfxvJrLS+V06PnWTFL4Eiw4pGsyMDbUQaaP1FYxk3NaQN1y
         3Zqsr9KRFCvIKHzreoR2GVgXA3vVW8vVvjJ7t4bjW1maz9uKIrVj3jKKtEC+EE5Naci1
         apn9GTtXNKVkSpA1c9pFFP0ElvSeiTgW9nO6cldLp+hXFf9Fu5WMyXw2QK9FBGB9JxKo
         p6bmsUwiyhTZLrR4ehfb8EvruiX+a8iw2df2qwf0mID3KPX0LzLyr5ErLYEa7JIzEBuB
         inBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=CWlbFUKlWt96YVDyU5CqOIbt+yJKd7O8RCmDBZgrw28=;
        fh=ikxdUn2JWSEHDShUuDDGFawVdhf0jeIkxeIM8BwGDF0=;
        b=b4rmsGGBybkm+WjBI9Ase9wTpE3X8/VyhHmdp+Xeu/FLnAvt6ckWakJJ/nbrN0F7d4
         42tDdOwmgHK3Jl2P2VjnbD7OCgJEU4rUIoWIcx07hhYFv81JEVhjKsZHEe31+xUuJ9L9
         rpubTceroYOxZ7n+ZH/KSDyyelE1REaNrmje/Lws8zlYE5BQVBBJSsMJyeKMEyeJ/QaN
         5+ISquN0B6ugRZt6fgepoj5gu+5ux8YuwPFreXbhPT0GJnSfC1ZQthwLy1aKDfwWOsMB
         wv1b4YYr/1QSiVjAQ6ibMV4YtgMUK02HdmOdYDe73yQGawX6qodORtcvXYSyRccbWoNK
         GNHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779752259; x=1780357059; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CWlbFUKlWt96YVDyU5CqOIbt+yJKd7O8RCmDBZgrw28=;
        b=Y8tKP5hKMZDuDt1rxxaWWPOJUZl5BHm+KXQPgRf1PDowY+y20+1XbKpINxjPYc0+OQ
         BPrnbhvbX8A12uo4gzq4pvsxPjz0Jj/ijMxulKMZT4M/2QPlaNdYSKWKOL2lyVeuhzGO
         fSJmX9VcWE8g7sOjcNT1oXjsOGBSUMyOZYM7T/kA98e5YjwmfXnn0dD+z4pMAvmdf9a9
         4ieFDYY5mzUoGgvRbHlH9sg6dHkDcTNwnke0wDK8N9IaOQ72f9sCXAxz5+fCJVw725Zx
         ftpzT3VouItueznnxsA26VXO2l37lZ4NmbBZbKej3ypNixUOFR8qq705kNj7RnU3oq1z
         pE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779752259; x=1780357059;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWlbFUKlWt96YVDyU5CqOIbt+yJKd7O8RCmDBZgrw28=;
        b=nXU4Gs00XvwNYEc05KrWw+wPJlkKIANVoYCW6yP7R2kDeSi/k9+qEDZbLF0HXGW3dR
         6MgztjR6K42OrMB+MSUd6dt9iqS6bZG+5FLOi+7jz8Fzt9IEZkIMGO1yv3e8U0I71r2m
         uXO0sPNDGUuymOmCUr9MTejK+X81PX+n62t37BUl59UUGP8gXjsQAjvJwnEYqgb+Czu9
         LSs+cyatjefvxyKwIKv5tj16funoK1ZB4ocwgiJ1+C/2cW5OFZY8Q1QNmz6nPfDjrxXw
         1x5BOrnbGMSqgNBtu6HslwmA4GJ3mhjdetyBKNVHD7CzLZ0z0HywXPC1cIY+v2qRYevo
         dvgQ==
X-Forwarded-Encrypted: i=1; AFNElJ+wFBGd75I7h/8yAUj78NmAC3y8dXYD9LwSY4neDUOuO5vIEQW23H1bGQMb5kf2yl6yRcDhr7wJbZ2Eo3z9xYdv@vger.kernel.org
X-Gm-Message-State: AOJu0YzMssZzu3ZuYcHSu5wGIbFk3OQyArS5N0JwUEicvTwYAX83M+7j
	CjhChksHWe/xhw04fiwOqQX6HBHTCZUGyZszlbMGFYLv0NQCpJBcO+nNAMmw/SpuBVx67hfX0qT
	TXNg7BWFkWuYb4mIXzKMOilWFjgwUDWkYtCVV5kw/
X-Gm-Gg: Acq92OEl03VVfGdlvPfX/rn7UX78eOZbc4N12lkrI14orZ+Hu7BfVSnbQobYYmGdx8n
	reXFioOR2SKMt4OMzz9K2lFZCxRe7bt1JyMGrSMtRM98jk3raCzeAdyCG2FrHPyLnUXqTGSo/Qz
	g6fHwpMUu5g8j5oYwINLHdQ+ExtqxsnIt3kchgeL841Qs3rfqViqIkKxt5iD6TtOwvwGB9c8rjp
	ZDAIpe/LJxWrNM3roCIsUV5bHNyWNfJA4/KYbudetx8ubJiNhGREI8sb5Enl5km4fj4yDoytLDd
	RCUNgzIV00uWOb5N1FY=
X-Received: by 2002:a17:903:3c2b:b0:2bd:3c1b:3073 with SMTP id
 d9443c01a7336-2bebf41888cmr4549435ad.16.1779752258358; Mon, 25 May 2026
 16:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fX=vEmTaz6mWgExmrgyYMJmSyOD+1sMCzf7JTk1SkA-zQ@mail.gmail.com>
In-Reply-To: <CAP-5=fX=vEmTaz6mWgExmrgyYMJmSyOD+1sMCzf7JTk1SkA-zQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 May 2026 16:37:25 -0700
X-Gm-Features: AVHnY4L6gFsbHqtwSSEp167o-zXt5Usl_SaJu1xJ1oLC1JJdFj8HWZ-n776VjKg
Message-ID: <CAP-5=fU0pLzo8DGETQD3eWig747sGkwRwNs4AvcgGRQi+FGh4g@mail.gmail.com>
Subject: Re: Summary of perf-tools-next changes and patches sent to linux-perf-users
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

================================================================================
WEEK: 2026-05-18 to 2026-05-25
================================================================================

>>> MERGED PATCHES <<<
  [Merged] perf tool_pmu: Support enable/disable for tool PMU events
           Author   : Ian Rogers <irogers@google.com>
           Commit   : f83deb058025 - perf tests: Add test for stat
delay option with duration_time (by Ian Rogers)
           Commit   : 0b18bced5444 - perf tool_pmu: Make tool PMU
events respect enable/disable (by Ian Rogers)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260519014106.3089452-1-irogers%40google.com/
           Sashiko  :
https://sashiko.dev/#/patchset/20260519014106.3089452-1-irogers%40google.com

  [Merged] perf: Fix kwork memory sanitization and libunwind test builds
           Author   : Ian Rogers <irogers@google.com>
           Commit   : e898c505b0ee - perf kwork: Fix memory management
of kwork_work (by Ian Rogers)
           Commit   : ca426c0f6e9c - perf kwork: Fix address sanitizer
issues (by Ian Rogers)
           Commit   : fdec0a81cad5 - perf build: Unconditionally set
up libunwind feature build flags (by Ian Rogers)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260521072429.1283423-1-irogers%40google.com/
           Sashiko  :
https://sashiko.dev/#/patchset/20260521072429.1283423-1-irogers%40google.com

  [Merged] perf tests: Add uncore and x86 topdown event sorting tests
           Author   : Ian Rogers <irogers@google.com>
           Commit   : b439c20b2fe1 - perf arch x86 tests: Add test for
topdown event sorting (by Ian Rogers)
           Commit   : 9f116f4b811b - perf tests: Add test for uncore
event sorting (by Ian Rogers)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260518062904.2591616-1-irogers%40google.com/
           Sashiko  :
https://sashiko.dev/#/patchset/20260518062904.2591616-1-irogers%40google.com

  [Merged] perf tools: Add evsel to perf_sample
           Author   : Ian Rogers <irogers@google.com>
           Commit   : 9aa1ec2e1d21 - perf evsel: Add bounds checking
to trace point raw data accessors (by Ian Rogers)
           Commit   : a41a462334a2 - perf timechart: Bounds check CPU
(by Ian Rogers)
           Commit   : 16ccbec0f3e1 - perf sched: Bounds check CPU in
sched switch events (by Ian Rogers)
           Commit   : 1bd2c9403ec5 - perf kmem: Add bounds checks to
tracepoint read values (by Ian Rogers)
           Commit   : e454fef5d2c6 - perf synthetic-events: Bound
check when synthesizing mmap2 and build_id events (by Ian Rogers)
           Commit   : b3ab66876178 - perf kmem: Fix memory leaks on
error path and when skipping (by Ian Rogers)
           Commit   : 00b36b394c15 - perf timechart: Fix memory leaks
(by Ian Rogers)
           Commit   : 8dca7ad2c257 - perf lock: Avoid segv if event is
missing a callchain (by Ian Rogers)
           Commit   : 9890b403d49e - perf lock: Constify
trace_lock_handler variables (by Ian Rogers)
           Commit   : 2856524e4ef7 - perf evsel: Don't pass evsel with
sample (by Ian Rogers)
           Commit   : ec319c4d3552 - perf s390-sample-raw: Don't pass
evsel or its PMU with sample (by Ian Rogers)
           Commit   : 5e807647e155 - perf script: Don't pass evsel
with sample (by Ian Rogers)
           Commit   : 675073ddf877 - perf evlist: Try to avoid
computing evsel from sample (by Ian Rogers)
           Commit   : 1f44e8fe3d12 - perf trace: Don't pass evsel with
sample (by Ian Rogers)
           Commit   : 6d2b06b4ef18 - perf timechart: Don't pass evsel
with sample (by Ian Rogers)
           Commit   : 1ac10645bb29 - perf sched: Don't pass evsel with
sample (by Ian Rogers)
           Commit   : bad8999c6889 - perf kwork: Don't pass evsel with
sample (by Ian Rogers)
           Commit   : 511bcd0ca0ff - perf kmem: Don't pass evsel with
sample (by Ian Rogers)
           Commit   : ed9475b215d5 - perf inject: Don't pass evsel
with sample (by Ian Rogers)
           Commit   : 603495ab589d - perf annotate: Don't pass evsel
to add_sample (by Ian Rogers)
           Commit   : a8cb37a5b050 - perf report: Directly use
sample->evsel to avoid computing from sample->id (by Ian Rogers)
           Commit   : 7e0e6ac66cc4 - perf hist: Remove evsel from
struct hist_entry_iter (by Ian Rogers)
           Commit   : 948b5874ef5e - perf db-export: Remove evsel from
struct export_sample (by Ian Rogers)
           Commit   : 05e1a8077146 - perf hist: Remove evsel parameter
from inc samples functions (by Ian Rogers)
           Commit   : 9d491ab9ede2 - perf lock: Only pass sample to
handlers (by Ian Rogers)
           Commit   : 859e49597088 - perf callchain: Don't pass evsel
and sample (by Ian Rogers)
           Commit   : a50a9b0d6e9b - perf trace: Don't pass evsel with
sample (by Ian Rogers)
           Commit   : fd7dd303c430 - perf evsel: Refactor evsel
tracepoint sample accessors perf_sample (by Ian Rogers)
           Commit   : 1c8b07788618 - perf kvm: Don't pass evsel with
sample (by Ian Rogers)
           Commit   : fc444d05b4e4 - perf tool: Remove evsel from tool
APIs that pass the sample (by Ian Rogers)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260520190538.142018-1-irogers%40google.com/
           Sashiko  :
https://sashiko.dev/#/patchset/20260520190538.142018-1-irogers%40google.com

  [Merged] perf stat: Make metric only column line up with header
           Author   : Andi Kleen <ak@linux.intel.com>
           Commit   : 7a978c2ac722 - perf stat: Make metric only
column line up with header (by Andi Kleen)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260513144906.557896-1-ak%40linux.intel.com/
           Sashiko  :
https://sashiko.dev/#/patchset/20260513144906.557896-1-ak%40linux.intel.com

  [Merged] perf riscv: Fix discarded const qualifier in _get_field()
           Author   : Li Guan <guanli.oerv@isrc.iscas.ac.cn>
           Commit   : 7378b6656aa4 - perf riscv: Fix discarded const
qualifier in _get_field() (by Li Guan)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260513180721.1179904-1-guanli.oerv%40isrc.iscas.ac.cn/
           Sashiko  :
https://sashiko.dev/#/patchset/20260513180721.1179904-1-guanli.oerv%40isrc.iscas.ac.cn

  [Merged] perf riscv: Add SDT argument parsing for RISC-V
           Author   : Chen Pei <cp0613@linux.alibaba.com>
           Commit   : 6a082433bcc7 - perf riscv: Add SDT argument
parsing for RISC-V (by Chen Pei)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260520134004.30573-1-cp0613%40linux.alibaba.com/
           Sashiko  :
https://sashiko.dev/#/patchset/20260520134004.30573-1-cp0613%40linux.alibaba.com

  [Merged] perf: Fix SIGCHLD vs pause() race with short-lived workloads
           Author   : Swapnil Sapkal <swapnil.sapkal@amd.com>
           Commit   : 35c9fb22000f - perf lock contention: Fix SIGCHLD
vs pause() race in __cmd_contention() (by Swapnil Sapkal)
           Commit   : 5b8c90e06622 - perf sched stats: Fix SIGCHLD vs
pause() race in schedstat_live() (by Swapnil Sapkal)
           Commit   : 9416008e5462 - perf sched stats: Fix SIGCHLD vs
pause() race in schedstat_record() (by Swapnil Sapkal)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260520102017.293419-1-swapnil.sapkal%40amd.com/
           Sashiko  :
https://sashiko.dev/#/patchset/20260520102017.293419-1-swapnil.sapkal%40amd.com

  [Merged] perf clang-format: Add a perf clang-format that overrides
some kernel behaviors
           Author   : Ian Rogers <irogers@google.com>
           Commit   : b5050b133e7a - perf clang-format: Add a perf
clang-format that overrides some kernel behaviors (by Ian Rogers)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260428065432.1877423-1-irogers%40google.com/
           Sashiko  :
https://sashiko.dev/#/patchset/20260428065432.1877423-1-irogers%40google.com

  [Merged] perf build-id: Fix off-by-one bug when printing
kernel/module build-id
           Author   : Michael Petlan <mpetlan@redhat.com>
           Commit   : 017bca78e4d7 - perf build-id: Fix off-by-one bug
when printing kernel/module build-id (by Michael Petlan)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260519223855.191637-1-mpetlan%40redhat.com/
           Sashiko  :
https://sashiko.dev/#/patchset/20260519223855.191637-1-mpetlan%40redhat.com

  [Merged] perf tools amd ibs: Fixes + Zen6 enhancements
           Author   : Ravi Bangoria <ravi.bangoria@amd.com>
           Commit   : a31423e67c0e - perf doc: Document new IBS
capabilities in man page (by Ravi Bangoria)
           Commit   : 873f232d0962 - perf amd ibs: Decode
Streaming-store flag in IBS OP raw dump (by Ravi Bangoria)
           Commit   : 7c04195ccefc - perf amd ibs: Decode
Remote-Socket flag in IBS OP raw dump (by Ravi Bangoria)
           Commit   : ea0ce2e12ed5 - perf amd ibs: Make Fetch status
bits dependent on PhyAddrValid for newer platforms (by Ravi Bangoria)
           Commit   : f04a8a7649f9 - perf amd ibs: Suppress bogus
TlbRefillLat and DCPhysAd on Zen4+ (by Ravi Bangoria)
           Commit   : 540dc628ab5d - perf test ibs: Skip privilege
test on Zen6 and newer platforms (by Ravi Bangoria)
           Commit   : 0b97e92393a1 - perf test amd ibs: Fix incorrect
kernel version check (by Ravi Bangoria)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260508060004.2575-1-ravi.bangoria%40amd.com/
           Sashiko  :
https://sashiko.dev/#/patchset/20260508060004.2575-1-ravi.bangoria%40amd.com

  [Merged] perf inject intel-PT LBR/brstack synthesis fixes
           Author   : Ian Rogers <irogers@google.com>
           Commit   : daac18e7c42c - perf inject: Fix itrace branch
stack synthesis (by Ian Rogers)
           Commit   : 059e9100d82a - perf event: Fix size of
synthesized sample with branch stacks (by Ian Rogers)
           LORE Link:
https://lore.kernel.org/linux-perf-users/20260518224325.3037838-1-irogers%40google.com/
           Sashiko  :
https://sashiko.dev/#/patchset/20260518224325.3037838-1-irogers%40google.com

  [Merged (Sent: 2026-03-31)] perf tests: Add tests for uncore and
perf metric event sorting
                       Author   : Ian Rogers <irogers@google.com>
                       Commit   : 9f116f4b811b (Likely, date: 2026-05-20)
                       LORE Link:
https://lore.kernel.org/linux-perf-users/20260331165207.4016392-1-irogers%40google.com/

  [Merged (Sent: 2026-03-31)] Add tests for uncore and perf metric event sorting
                       Author   : Ian Rogers <irogers@google.com>
                       Commit   : 9f116f4b811b (Likely, date: 2026-05-20)
                       LORE Link:
https://lore.kernel.org/linux-perf-users/20260331185419.4085479-1-irogers%40google.com/

  [Merged (Sent: 2026-05-12)] perf tool: Add evsel to perf_sample
                       Author   : Ian Rogers <irogers@google.com>
                       Commit   : fc444d05b4e4 (Likely, date: 2026-05-20)
                       LORE Link:
https://lore.kernel.org/linux-perf-users/20260512223001.2952848-1-irogers%40google.com/

  [Merged (Git Only)] perf build: Fix fsmount.o build
                      Commit: f8d0db39bcc5 by Ian Rogers


>>> ACTIVE & MISSING PATCHES <<<
  Series : MAINTAINERS: Update HiSilicon PMU driver maintainer to Yushan Wang
  Author : Jonathan Cameron <Jonathan.Cameron@huawei.com>
  Version: v1
  Date   : Thu, 16 Apr 2026 09:51:10 +0000 (Latest Activity)
  Status : Maintainer work (Review tags present on unapplied patches
or cover letter)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260416095110.25612-1-Jonathan.Cameron%40huawei.com)
  Unapplied Patches (1):
    -> [1] [TAGGED] [PATCH] MAINTAINERS: Update HiSilicon PMU driver
maintainer to Yushan Wang
       Link   :
https://lore.kernel.org/linux-perf-users/20260416095110.25612-1-Jonathan.Cameron%40huawei.com/
       Sashiko: Skipped
----------------------------------------
  Series : tools/build: Allow versioning of all LLVM tools
  Author : James Clark <james.clark@linaro.org>
  Version: v2
  Date   : Mon, 18 May 2026 09:03:12 +0000 (Latest Activity)
  Status : Maintainer work (Review tags present on unapplied patches
or cover letter)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260518-james-perf-llvm-version-v2-0-f12cc4f031d8%40linaro.org)
  Unapplied Patches (6):
    -> [1] [PATCH v2 1/6] tools/build: Allow versioning of all LLVM
tools defined in Makefile.include
       Link   :
https://lore.kernel.org/linux-perf-users/20260518-james-perf-llvm-version-v2-1-f12cc4f031d8%40linaro.org/
       Sashiko: Reviewed (No regressions)
    -> [2] [PATCH v2 2/6] tools/build: Indent if else blocks
       Link   :
https://lore.kernel.org/linux-perf-users/20260518-james-perf-llvm-version-v2-2-f12cc4f031d8%40linaro.org/
       Sashiko: Reviewed (No regressions)
    -> [3] [PATCH v2 3/6] selftests: Remove unused LLD variable
       Link   :
https://lore.kernel.org/linux-perf-users/20260518-james-perf-llvm-version-v2-3-f12cc4f031d8%40linaro.org/
       Sashiko: Reviewed (No regressions)
    -> [4] [TAGGED] [PATCH v2 4/6] tools/build: Allow versioning LLVM readelf
       Link   :
https://lore.kernel.org/linux-perf-users/20260518-james-perf-llvm-version-v2-4-f12cc4f031d8%40linaro.org/
       Sashiko: Reviewed (No regressions)
    -> [5] [PATCH v2 5/6] tools/build: selftests: Allow versioning LLVM lld
       Link   :
https://lore.kernel.org/linux-perf-users/20260518-james-perf-llvm-version-v2-5-f12cc4f031d8%40linaro.org/
       Sashiko: Reviewed (0 Critical, 0 High, 1 Medium, 0 Low)
    -> [6] [PATCH v2 6/6] tools/build: selftests: Remove some
duplicate toolchain definitions
       Link   :
https://lore.kernel.org/linux-perf-users/20260518-james-perf-llvm-version-v2-6-f12cc4f031d8%40linaro.org/
       Sashiko: Reviewed (No regressions)
----------------------------------------
  Series : perf: Add is_ignored_kernel_symbol() for kernel symbol filtering
  Author : "Rui Qi" <qirui.001@bytedance.com>
  Version: v4
  Date   : Fri, 22 May 2026 08:26:04 +0000 (Latest Activity)
  Status : Reviewer work (No replies to series)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260522082604.89447-1-qirui.001%40bytedance.com)
  Unapplied Patches (2):
    -> [1] [PATCH v4 1/2] perf: Extract is_ignored_kernel_symbol() for
kernel mapping symbol filtering
       Link   :
https://lore.kernel.org/linux-perf-users/20260522082604.89447-2-qirui.001%40bytedance.com/
       Sashiko: Reviewed (No regressions)
    -> [2] [PATCH v4 2/2] perf: Apply is_ignored_kernel_symbol()
filter in ELF loading path for kernel DSOs
       Link   :
https://lore.kernel.org/linux-perf-users/20260522082604.89447-3-qirui.001%40bytedance.com/
       Sashiko: Reviewed (No regressions)
----------------------------------------
  Series : perf: evsel: Fix error handling in tp_format lookup
  Author : Hongling Zeng <zenghongling@kylinos.cn>
  Version: v1
  Date   : Thu, 21 May 2026 02:57:38 +0000 (Latest Activity)
  Status : Reviewer work (No replies to series)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260521025738.17867-1-zenghongling%40kylinos.cn)
  Unapplied Patches (1):
    -> [1] [PATCH] perf: evsel: Fix error handling in tp_format lookup
       Link   :
https://lore.kernel.org/linux-perf-users/20260521025738.17867-1-zenghongling%40kylinos.cn/
       Sashiko: Reviewed (No regressions)
----------------------------------------
  Series : perf python: Modernize and extend Python API (Phase 1)
  Author : Ian Rogers <irogers@google.com>
  Version: v9
  Date   : Fri, 22 May 2026 22:04:34 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Not Found
  Unapplied Patches (23):
    -> [1] [PATCH v9 01/23] perf arch arm: Sort includes and add
missed explicit dependencies
       Link   :
https://lore.kernel.org/linux-perf-users/20260522220435.2378363-2-irogers%40google.com/
       Sashiko: Not Found
    -> [2] [PATCH v9 02/23] perf arch x86: Sort includes and add
missed explicit dependencies
       Link   :
https://lore.kernel.org/linux-perf-users/20260522220435.2378363-3-irogers%40google.com/
       Sashiko: Not Found
    -> [3] [PATCH v9 03/23] perf tests: Sort includes and add missed
explicit dependencies
       Link   :
https://lore.kernel.org/linux-perf-users/20260522220435.2378363-4-irogers%40google.com/
       Sashiko: Not Found
    -> [4] [PATCH v9 04/23] perf script: Sort includes and add missed
explicit dependencies
       Link   :
https://lore.kernel.org/linux-perf-users/20260522220435.2378363-5-irogers%40google.com/
       Sashiko: Not Found
    -> [5] [PATCH v9 05/23] perf util: Sort includes and add missed
explicit dependencies
       Link   :
https://lore.kernel.org/linux-perf-users/20260522220435.2378363-6-irogers%40google.com/
       Sashiko: Not Found
    -> [6] [PATCH v9 06/23] perf python: Add missed explicit dependencies
       Link   :
https://lore.kernel.org/linux-perf-users/20260522220435.2378363-7-irogers%40google.com/
       Sashiko: Not Found
    -> [7] [PATCH v9 07/23] perf evsel/evlist: Avoid unnecessary #includes
       Link   :
https://lore.kernel.org/linux-perf-users/20260522220435.2378363-8-irogers%40google.com/
       Sashiko: Not Found
    -> [8] [PATCH v9 08/23] perf data: Add open flag
       Link   :
https://lore.kernel.org/linux-perf-users/20260522220435.2378363-9-irogers%40google.com/
       Sashiko: Not Found
    -> [9] [PATCH v9 09/23] perf evlist: Add reference count
       Link   :
https://lore.kernel.org/linux-perf-users/20260522220435.2378363-10-irogers%40google.com/
       Sashiko: Not Found
    -> [10] [PATCH v9 10/23] perf evsel: Add reference count
       Link   :
https://lore.kernel.org/linux-perf-users/20260522220435.2378363-11-irogers%40google.com/
       Sashiko: Not Found
    -> [11] [PATCH v9 11/23] perf evlist: Add reference count checking
       Link   :
https://lore.kernel.org/linux-perf-users/20260522220435.2378363-12-irogers%40google.com/
       Sashiko: Not Found
    -> [12] [PATCH v9 12/23] perf python: Use evsel in sample in pyrf_event
       Link   :
https://lore.kernel.org/linux-perf-users/20260522220435.2378363-13-irogers%40google.com/
       Sashiko: Not Found
    -> [13] [PATCH v9 13/23] perf python: Add wrapper for perf_data
file abstraction
       Link   :
https://lore.kernel.org/linux-perf-users/20260522220435.2378363-14-irogers%40google.com/
       Sashiko: Not Found
    -> [14] [PATCH v9 14/23] perf python: Add python session
abstraction wrapping perf's session
       Link   :
https://lore.kernel.org/linux-perf-users/20260522220435.2378363-15-irogers%40google.com/
       Sashiko: Not Found
    -> [15] [PATCH v9 15/23] perf python: Refactor and add accessors
to sample event
       Link   :
https://lore.kernel.org/linux-perf-users/20260522220435.2378363-16-irogers%40google.com/
       Sashiko: Not Found
    -> [16] [PATCH v9 16/23] perf python: Add mmap2 event
       Link   :
https://lore.kernel.org/linux-perf-users/20260522220435.2378363-17-irogers%40google.com/
       Sashiko: Not Found
    -> [17] [PATCH v9 17/23] perf python: Add callchain support
       Link   :
https://lore.kernel.org/linux-perf-users/20260522220435.2378363-18-irogers%40google.com/
       Sashiko: Not Found
    -> [18] [PATCH v9 18/23] perf python: Extend API for stat events in python.c
       Link   :
https://lore.kernel.org/linux-perf-users/20260522220435.2378363-19-irogers%40google.com/
       Sashiko: Not Found
    -> [19] [PATCH v9 19/23] perf python: Expose brstack in sample event
       Link   :
https://lore.kernel.org/linux-perf-users/20260522220435.2378363-20-irogers%40google.com/
       Sashiko: Not Found
    -> [20] [PATCH v9 20/23] perf python: Add syscall name/id to
convert syscall number and name
       Link   :
https://lore.kernel.org/linux-perf-users/20260522220435.2378363-21-irogers%40google.com/
       Sashiko: Not Found
    -> [21] [PATCH v9 21/23] perf python: Add config file access
       Link   :
https://lore.kernel.org/linux-perf-users/20260522220435.2378363-22-irogers%40google.com/
       Sashiko: Not Found
    -> [22] [PATCH v9 22/23] perf python: Add perf.pyi stubs file
       Link   :
https://lore.kernel.org/linux-perf-users/20260522220435.2378363-23-irogers%40google.com/
       Sashiko: Not Found
    -> [23] [PATCH v9 23/23] perf python: Add LiveSession helper
       Link   :
https://lore.kernel.org/linux-perf-users/20260522220435.2378363-24-irogers%40google.com/
       Sashiko: Not Found
----------------------------------------
  Series : perf/x86/intel: Remove anythread_deprecated bit from
perf_capabilities
  Author : Dapeng Mi <dapeng1.mi@linux.intel.com>
  Version: v2
  Date   : Thu, 23 Apr 2026 05:33:06 +0000 (Latest Activity)
  Status : Maintainer work (Review tags present on unapplied patches
or cover letter)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260423053306.3033331-1-dapeng1.mi%40linux.intel.com)
  Unapplied Patches (1):
    -> [1] [TAGGED] [Patch v2] perf/x86/intel: Remove
anythread_deprecated bit from perf_capabilities
       Link   :
https://lore.kernel.org/linux-perf-users/20260423053306.3033331-1-dapeng1.mi%40linux.intel.com/
       Sashiko: Reviewed (No regressions)
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
  Series : perf data ctf: replace libbabeltrace with babeltrace2-ctf-writer
  Author : Michael Jeanson <mjeanson@efficios.com>
  Version: v3
  Date   : Wed, 20 May 2026 19:14:50 +0000 (Latest Activity)
  Status : Maintainer work (Review tags present on unapplied patches
or cover letter)
  Sashiko: Failed To Apply
(https://sashiko.dev/#/patchset/20260520191452.218717-1-mjeanson%40efficios.com)
  Unapplied Patches (1):
    -> [1] [TAGGED] [PATCH v3] perf data ctf: replace libbabeltrace
with babeltrace2-ctf-writer
       Link   :
https://lore.kernel.org/linux-perf-users/20260520191452.218717-1-mjeanson%40efficios.com/
       Sashiko: Not Found
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
  Series : perf.data validation and hardening
  Author : Arnaldo Carvalho de Melo <acme@kernel.org>
  Version: v1
  Date   : Thu, 21 May 2026 01:10:12 +0000 (Latest Activity)
  Status : Reviewer work (No replies to series)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260521011027.622268-1-acme%40kernel.org)
  Unapplied Patches (27):
    -> [1] [PATCH 01/27] perf session: Add minimum event size and
alignment validation
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-2-acme%40kernel.org/
       Sashiko: Reviewed (0 Critical, 3 High, 0 Medium, 0 Low)
    -> [2] [PATCH 02/27] perf tools: Fix event_contains() macro to
verify full field extent
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-3-acme%40kernel.org/
       Sashiko: Reviewed (No regressions)
    -> [3] [PATCH 03/27] perf zstd: Fix compression error path in
zstd_compress_stream_to_records()
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-4-acme%40kernel.org/
       Sashiko: Reviewed (0 Critical, 3 High, 0 Medium, 0 Low)
    -> [4] [PATCH 04/27] perf zstd: Fix multi-iteration decompression
and error handling
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-5-acme%40kernel.org/
       Sashiko: Reviewed (No regressions)
    -> [5] [PATCH 05/27] perf session: Fix PERF_RECORD_READ swap and
dump for variable-length events
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-6-acme%40kernel.org/
       Sashiko: Reviewed (No regressions)
    -> [6] [PATCH 06/27] perf session: Fix swap_sample_id_all() crash
on crafted events
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-7-acme%40kernel.org/
       Sashiko: Reviewed (No regressions)
    -> [7] [PATCH 07/27] perf session: Add validated swap
infrastructure with null-termination checks
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-8-acme%40kernel.org/
       Sashiko: Reviewed (0 Critical, 0 High, 2 Medium, 0 Low)
    -> [8] [PATCH 08/27] perf session: Use bounded copy for
PERF_RECORD_TIME_CONV
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-9-acme%40kernel.org/
       Sashiko: Reviewed (No regressions)
    -> [9] [PATCH 09/27] perf session: Validate HEADER_ATTR attr.size
before swapping
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-10-acme%40kernel.org/
       Sashiko: Reviewed (2 Critical, 1 High, 0 Medium, 0 Low)
    -> [10] [PATCH 10/27] perf session: Validate nr fields against
event size on both swap and common paths
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-11-acme%40kernel.org/
       Sashiko: Reviewed (No regressions)
    -> [11] [PATCH 11/27] perf header: Byte-swap build ID event pid
and bounds check section entries
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-12-acme%40kernel.org/
       Sashiko: Reviewed (No regressions)
    -> [12] [PATCH 12/27] perf cpumap: Reject RANGE_CPUS with
start_cpu > end_cpu
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-13-acme%40kernel.org/
       Sashiko: Reviewed (No regressions)
    -> [13] [PATCH 13/27] perf auxtrace: Harden auxtrace_error event handling
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-14-acme%40kernel.org/
       Sashiko: Reviewed (No regressions)
    -> [14] [PATCH 14/27] perf session: Add byte-swap and bounds check
for PERF_RECORD_BPF_METADATA events
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-15-acme%40kernel.org/
       Sashiko: Reviewed (0 Critical, 0 High, 1 Medium, 0 Low)
    -> [15] [PATCH 15/27] perf header: Validate null-termination in
PERF_RECORD_EVENT_UPDATE string fields
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-16-acme%40kernel.org/
       Sashiko: Reviewed (No regressions)
    -> [16] [PATCH 16/27] perf tools: Bounds check perf_event_attr
fields against attr.size before printing
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-17-acme%40kernel.org/
       Sashiko: Reviewed (No regressions)
    -> [17] [PATCH 17/27] perf header: Propagate feature section
processing errors
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-18-acme%40kernel.org/
       Sashiko: Reviewed (No regressions)
    -> [18] [PATCH 18/27] perf header: Validate f_attr.ids section
before use in perf_session__read_header()
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-19-acme%40kernel.org/
       Sashiko: Reviewed (No regressions)
    -> [19] [PATCH 19/27] perf header: Validate feature section size
and add read path bounds checking
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-20-acme%40kernel.org/
       Sashiko: Reviewed (1 Critical, 0 High, 0 Medium, 0 Low)
    -> [20] [PATCH 20/27] perf header: Sanity check HEADER_EVENT_DESC
attr.size before swap
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-21-acme%40kernel.org/
       Sashiko: Reviewed (No regressions)
    -> [21] [PATCH 21/27] perf header: Validate bitmap size before
allocating in do_read_bitmap()
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-22-acme%40kernel.org/
       Sashiko: Reviewed (No regressions)
    -> [22] [PATCH 22/27] perf session: Add byte-swap for
PERF_RECORD_COMPRESSED2 events
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-23-acme%40kernel.org/
       Sashiko: Reviewed (No regressions)
    -> [23] [PATCH 23/27] perf tools: Harden compressed event processing
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-24-acme%40kernel.org/
       Sashiko: Reviewed (No regressions)
    -> [24] [PATCH 24/27] perf session: Check for decompression buffer
size overflow
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-25-acme%40kernel.org/
       Sashiko: Reviewed (No regressions)
    -> [25] [PATCH 25/27] perf session: Bound nr_cpus_avail and
validate sample CPU
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-26-acme%40kernel.org/
       Sashiko: Reviewed (0 Critical, 2 High, 0 Medium, 0 Low)
    -> [26] [PATCH 26/27] perf kwork: Bounds check work->cpu before
indexing cpus_runtime[]
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-27-acme%40kernel.org/
       Sashiko: Reviewed (No regressions)
    -> [27] [PATCH 27/27] perf test: Add truncated perf.data robustness test
       Link   :
https://lore.kernel.org/linux-perf-users/20260521011027.622268-28-acme%40kernel.org/
       Sashiko: Reviewed (0 Critical, 0 High, 1 Medium, 0 Low)
----------------------------------------
  Series : perf/x86/amd/uncore: turn amd_uncore_ctx events into a flexible array
  Author : Rosen Penev <rosenp@gmail.com>
  Version: v1
  Date   : Sat, 23 May 2026 01:19:04 +0000 (Latest Activity)
  Status : Reviewer work (No replies to series)
  Sashiko: Not Found
  Unapplied Patches (1):
    -> [1] [PATCH] perf/x86/amd/uncore: turn amd_uncore_ctx events
into a flexible array
       Link   :
https://lore.kernel.org/linux-perf-users/20260523011904.101720-1-rosenp%40gmail.com/
       Sashiko: Not Found
----------------------------------------
  Series : perf test: probe_vfs_getname add do_getname() probing fallback
  Author : Thomas Richter <tmricht@linux.ibm.com>
  Version: v1
  Date   : Tue, 19 May 2026 11:06:43 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260519110643.1424411-1-tmricht%40linux.ibm.com)
  Unapplied Patches (1):
    -> [1] [PATCH ping2 linux-next] perf test: probe_vfs_getname add
do_getname() probing fallback
       Link   :
https://lore.kernel.org/linux-perf-users/20260519110643.1424411-1-tmricht%40linux.ibm.com/
       Sashiko: Reviewed (0 Critical, 0 High, 2 Medium, 0 Low)
----------------------------------------
  Series : Fix cgroup metric association with BPF counters
  Author : Ian Rogers <irogers@google.com>
  Version: v4
  Date   : Tue, 19 May 2026 15:27:16 +0000 (Latest Activity)
  Status : Reviewer work (No replies to series)
  Sashiko: Failed
(https://sashiko.dev/#/patchset/20260519152716.3464144-1-irogers%40google.com)
  Unapplied Patches (2):
    -> [1] [PATCH v4 1/2] perf stat: Propagate supported flag to
follower cgroup BPF events
       Link   :
https://lore.kernel.org/linux-perf-users/20260519152716.3464144-2-irogers%40google.com/
       Sashiko: Reviewed (No regressions)
    -> [2] [PATCH v4 2/2] perf test: Add stat metrics --for-each-cgroup test
       Link   :
https://lore.kernel.org/linux-perf-users/20260519152716.3464144-3-irogers%40google.com/
       Sashiko: Failed
----------------------------------------
  Series : perf/x86/amd/core: Mark perf_nmi_window as __ro_after_init
  Author : Len Bao <len.bao@gmx.us>
  Version: v1
  Date   : Sat, 23 May 2026 15:57:26 +0000 (Latest Activity)
  Status : Reviewer work (No replies to series)
  Sashiko: Not Found
  Unapplied Patches (1):
    -> [1] [PATCH] perf/x86/amd/core: Mark perf_nmi_window as __ro_after_init
       Link   :
https://lore.kernel.org/linux-perf-users/20260523155728.52909-1-len.bao%40gmx.us/
       Sashiko: Not Found
----------------------------------------
  Series : perf: Fix missing branch counter information in script and annotate
  Author : Thomas Falcon <thomas.falcon@intel.com>
  Version: v2
  Date   : Tue, 19 May 2026 17:50:43 +0000 (Latest Activity)
  Status : Maintainer work (Review tags present on unapplied patches
or cover letter)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260519175043.1490261-1-thomas.falcon%40intel.com)
  Unapplied Patches (2):
    -> [1] [TAGGED] [RESEND PATCH 1/2 v2] perf script: Fix missing '+'
indicator when branch counter reaches upper limit
       Link   :
https://lore.kernel.org/linux-perf-users/20260519175043.1490261-2-thomas.falcon%40intel.com/
       Sashiko: Reviewed (0 Critical, 0 High, 1 Medium, 0 Low)
    -> [2] [TAGGED] [RESEND PATCH 2/2 v2] perf annotate: Fix missing
branch counter column in TUI mode
       Link   :
https://lore.kernel.org/linux-perf-users/20260519175043.1490261-3-thomas.falcon%40intel.com/
       Sashiko: Reviewed (No regressions)
----------------------------------------
  Series : complete perf_allow_* trio and use in drm/xe
  Author : John Hubbard <jhubbard@nvidia.com>
  Version: v2
  Date   : Sat, 23 May 2026 01:33:26 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Not Found
  Unapplied Patches (2):
    -> [1] [PATCH v2 1/2] perf/core: out-of-line and export
perf_allow_cpu/tracepoint()
       Link   :
https://lore.kernel.org/linux-perf-users/20260523013326.129491-2-jhubbard%40nvidia.com/
       Sashiko: Not Found
    -> [2] [PATCH v2 2/2] drm/xe: gate observation streams with perf_allow_cpu()
       Link   :
https://lore.kernel.org/linux-perf-users/20260523013326.129491-3-jhubbard%40nvidia.com/
       Sashiko: Not Found
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
  Series : tools/perf/tests: Update test_adding_kernel.sh to handle
proper debuginfo check
  Author : Athira Rajeev <atrajeev@linux.ibm.com>
  Version: v3
  Date   : Fri, 24 Apr 2026 17:24:35 +0000 (Latest Activity)
  Status : Maintainer work (Review tags present on unapplied patches
or cover letter)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260424172435.91725-1-atrajeev%40linux.ibm.com)
  Unapplied Patches (1):
    -> [1] [TAGGED] [PATCH V3] tools/perf/tests: Update
test_adding_kernel.sh to handle proper debuginfo check
       Link   :
https://lore.kernel.org/linux-perf-users/20260424172435.91725-1-atrajeev%40linux.ibm.com/
       Sashiko: Reviewed (No regressions)
----------------------------------------
  Series : perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5
  Author : Aviv Bakal <avivb@amazon.com>
  Version: v3
  Date   : Sun, 24 May 2026 15:38:48 +0000 (Latest Activity)
  Status : Reviewer work (No replies to series)
  Sashiko: Not Found
  Unapplied Patches (2):
    -> [1] [PATCH v3 1/2] perf/arm-cmn: Move struct arm_cmn_hw_event
into struct hw_perf_event
       Link   :
https://lore.kernel.org/linux-perf-users/20260524153848.16334-2-avivb%40amazon.com/
       Sashiko: Not Found
    -> [2] [PATCH v3 2/2] perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5
       Link   :
https://lore.kernel.org/linux-perf-users/20260524153848.16334-3-avivb%40amazon.com/
       Sashiko: Not Found
----------------------------------------
  Series : perf build fixes
  Author : Florian Fainelli <florian.fainelli@broadcom.com>
  Version: v2
  Date   : Wed, 20 May 2026 16:33:20 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Failed To Apply
(https://sashiko.dev/#/patchset/20260520163320.3073037-1-florian.fainelli%40broadcom.com)
  Unapplied Patches (5):
    -> [1] [PATCH stable 6.1 v2 1/5] perf build: Conditionally define NDEBUG
       Link   :
https://lore.kernel.org/linux-perf-users/20260520163320.3073037-2-florian.fainelli%40broadcom.com/
       Sashiko: Not Found
    -> [2] [PATCH stable 6.1 v2 2/5] perf parse-events: Make YYDEBUG
dependent on doing a debug build
       Link   :
https://lore.kernel.org/linux-perf-users/20260520163320.3073037-3-florian.fainelli%40broadcom.com/
       Sashiko: Not Found
    -> [3] [PATCH stable 6.1 v2 3/5] perf build: Disable fewer bison warnings
       Link   :
https://lore.kernel.org/linux-perf-users/20260520163320.3073037-4-florian.fainelli%40broadcom.com/
       Sashiko: Not Found
    -> [4] [PATCH stable 6.1 v2 4/5] tools build: Add 3-component
logical version comparators
       Link   :
https://lore.kernel.org/linux-perf-users/20260520163320.3073037-5-florian.fainelli%40broadcom.com/
       Sashiko: Not Found
    -> [5] [PATCH stable 6.1 v2 5/5] perf build: Remove
-Wno-unused-but-set-variable from the flex flags when building with
clang < 13.0.0
       Link   :
https://lore.kernel.org/linux-perf-users/20260520163320.3073037-6-florian.fainelli%40broadcom.com/
       Sashiko: Not Found
----------------------------------------
  Series : AF_ALG: Remove support for AIO and old-style drivers
  Author : Demi Marie Obenour via B4 Relay
<devnull+demiobenour.gmail.com@kernel.org>
  Version: v1
  Date   : Sat, 23 May 2026 19:43:04 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Not Found
  Unapplied Patches (3):
    -> [1] [PATCH 1/3] net: Remove support for AIO on sockets
       Link   :
https://lore.kernel.org/linux-perf-users/20260523-af-alg-harden-v1-1-c76755c3a5c5%40gmail.com/
       Sashiko: Not Found
    -> [2] [PATCH 2/3] AF_ALG: Drop support for off-CPU cryptography
       Link   :
https://lore.kernel.org/linux-perf-users/20260523-af-alg-harden-v1-2-c76755c3a5c5%40gmail.com/
       Sashiko: Not Found
    -> [3] [PATCH 3/3] AF_ALG: Document that it is *always* slower
       Link   :
https://lore.kernel.org/linux-perf-users/20260523-af-alg-harden-v1-3-c76755c3a5c5%40gmail.com/
       Sashiko: Not Found
----------------------------------------
  Series : perf: qcom: Unify user-visible "Qualcomm" name
  Author : Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
  Version: v1
  Date   : Mon, 27 Apr 2026 07:00:57 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260427070056.18140-2-krzysztof.kozlowski%40oss.qualcomm.com)
  Unapplied Patches (1):
    -> [1] [PATCH] perf: qcom: Unify user-visible "Qualcomm" name
       Link   :
https://lore.kernel.org/linux-perf-users/20260427070056.18140-2-krzysztof.kozlowski%40oss.qualcomm.com/
       Sashiko: Reviewed (No regressions)
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
  Series : perf build: Fix Python extension build with GCC 16 hardening
  Author : Jan Polensky <japo@linux.ibm.com>
  Version: v1
  Date   : Wed, 20 May 2026 12:56:37 +0000 (Latest Activity)
  Status : Maintainer work (Review tags present on unapplied patches
or cover letter)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260520125637.105681-1-japo%40linux.ibm.com)
  Unapplied Patches (1):
    -> [1] [TAGGED] [PATCH 1/1] perf build: Fix Python extension build
with GCC 16 hardening
       Link   :
https://lore.kernel.org/linux-perf-users/20260520125637.105681-1-japo%40linux.ibm.com/
       Sashiko: Reviewed (0 Critical, 0 High, 1 Medium, 0 Low)
----------------------------------------
  Series : tools/perf/sched: Update process names of processes in
zombie state for both -s and -S options
  Author : Athira Rajeev <atrajeev@linux.ibm.com>
  Version: v1
  Date   : Sun, 26 Apr 2026 09:39:30 +0000 (Latest Activity)
  Status : Maintainer work (Review tags present on unapplied patches
or cover letter)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260426093930.47809-1-atrajeev%40linux.ibm.com)
  Unapplied Patches (1):
    -> [1] [TAGGED] [PATCH] tools/perf/sched: Update process names of
processes in zombie state for both -s and -S options
       Link   :
https://lore.kernel.org/linux-perf-users/20260426093930.47809-1-atrajeev%40linux.ibm.com/
       Sashiko: Reviewed (No regressions)
----------------------------------------
  Series : perf tools: Add inject --aslr feature, early maps loading,
and decoupling fixes
  Author : Ian Rogers <irogers@google.com>
  Version: v8
  Date   : Wed, 20 May 2026 06:30:50 +0000 (Latest Activity)
  Status : Reviewer work (No replies to series)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260520063050.3917261-1-irogers%40google.com)
  Unapplied Patches (4):
    -> [1] [PATCH v8 1/4] perf maps: Add maps__mutate_mapping
       Link   :
https://lore.kernel.org/linux-perf-users/20260520063050.3917261-2-irogers%40google.com/
       Sashiko: Reviewed (0 Critical, 1 High, 0 Medium, 0 Low)
    -> [2] [PATCH v8 2/4] perf inject/aslr: Add aslr tool to
remap/obfuscate virtual addresses
       Link   :
https://lore.kernel.org/linux-perf-users/20260520063050.3917261-3-irogers%40google.com/
       Sashiko: Reviewed (1 Critical, 1 High, 0 Medium, 0 Low)
    -> [3] [PATCH v8 3/4] perf test: Add inject ASLR test
       Link   :
https://lore.kernel.org/linux-perf-users/20260520063050.3917261-4-irogers%40google.com/
       Sashiko: Reviewed (0 Critical, 0 High, 1 Medium, 0 Low)
    -> [4] [PATCH v8 4/4] perf aslr: Strip sample registers
       Link   :
https://lore.kernel.org/linux-perf-users/20260520063050.3917261-5-irogers%40google.com/
       Sashiko: Reviewed (1 Critical, 4 High, 1 Medium, 0 Low)
----------------------------------------
  Series : perf tests: Add auto counter reload (ACR) sampling test
  Author : Dapeng Mi <dapeng1.mi@linux.intel.com>
  Version: v3
  Date   : Tue, 21 Apr 2026 04:55:11 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260421045511.2401316-1-dapeng1.mi%40linux.intel.com)
  Unapplied Patches (1):
    -> [1] [Patch v3] perf tests: Add auto counter reload (ACR) sampling test
       Link   :
https://lore.kernel.org/linux-perf-users/20260421045511.2401316-1-dapeng1.mi%40linux.intel.com/
       Sashiko: Reviewed (No regressions)
----------------------------------------
  Series : arm64: perf: Skip device memory during user callchain unwinding
  Author : Fredrik Markstrom <fredrik.markstrom@est.tech>
  Version: v2
  Date   : Thu, 30 Apr 2026 10:55:15 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260430-master-with-pfix-v3-v2-0-bd526ec04a75%40est.tech)
  Unapplied Patches (3):
    -> [1] [PATCH v2 1/3] arm64: perf: Skip device memory during user
callchain unwinding
       Link   :
https://lore.kernel.org/linux-perf-users/20260430-master-with-pfix-v3-v2-1-bd526ec04a75%40est.tech/
       Sashiko: Reviewed (0 Critical, 1 High, 0 Medium, 0 Low)
    -> [2] [PATCH v2 2/3] DO NOT MERGE: arm64: perf: Add skip_vmio
parameter to control device memory callchain guard
       Link   :
https://lore.kernel.org/linux-perf-users/20260430-master-with-pfix-v3-v2-2-bd526ec04a75%40est.tech/
       Sashiko: Reviewed (0 Critical, 1 High, 0 Medium, 0 Low)
    -> [3] [PATCH v2 3/3] DO NOT MERGE: selftests: perf_events: Add
device memory callchain unwinding test
       Link   :
https://lore.kernel.org/linux-perf-users/20260430-master-with-pfix-v3-v2-3-bd526ec04a75%40est.tech/
       Sashiko: Reviewed (0 Critical, 0 High, 4 Medium, 0 Low)
----------------------------------------
  Series : perf: complete perf_allow_* trio and use in drm/xe
  Author : John Hubbard <jhubbard@nvidia.com>
  Version: v1
  Date   : Thu, 21 May 2026 02:49:04 +0000 (Latest Activity)
  Status : Reviewer work (No replies to series)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260521024904.331912-1-jhubbard%40nvidia.com)
  Unapplied Patches (2):
    -> [1] [PATCH 1/2] perf/core: out-of-line and export
perf_allow_cpu/tracepoint()
       Link   :
https://lore.kernel.org/linux-perf-users/20260521024904.331912-2-jhubbard%40nvidia.com/
       Sashiko: Reviewed (No regressions)
    -> [2] [PATCH 2/2] drm/xe: gate observation streams with perf_allow_cpu()
       Link   :
https://lore.kernel.org/linux-perf-users/20260521024904.331912-3-jhubbard%40nvidia.com/
       Sashiko: Reviewed (0 Critical, 2 High, 0 Medium, 1 Low)
----------------------------------------
  Series : rtla: Migrate to libsubcmd for command line option parsing
  Author : Tomas Glozar <tglozar@redhat.com>
  Version: v2
  Date   : Thu, 21 May 2026 14:18:33 +0000 (Latest Activity)
  Status : Reviewer work (No replies to series)
  Sashiko: Failed To Apply
(https://sashiko.dev/#/patchset/20260521141833.2353025-1-tglozar%40redhat.com)
  Unapplied Patches (6):
    -> [1] [PATCH v2 1/6] rtla: Add libsubcmd dependency
       Link   :
https://lore.kernel.org/linux-perf-users/20260521141833.2353025-2-tglozar%40redhat.com/
       Sashiko: Not Found
    -> [2] [PATCH v2 2/6] tools subcmd: support optarg as separate argument
       Link   :
https://lore.kernel.org/linux-perf-users/20260521141833.2353025-3-tglozar%40redhat.com/
       Sashiko: Not Found
    -> [3] [PATCH v2 3/6] tools subcmd: allow parsing distinct --opt
and --no-opt
       Link   :
https://lore.kernel.org/linux-perf-users/20260521141833.2353025-4-tglozar%40redhat.com/
       Sashiko: Not Found
    -> [4] [PATCH v2 4/6] rtla: Parse cmdline using libsubcmd
       Link   :
https://lore.kernel.org/linux-perf-users/20260521141833.2353025-5-tglozar%40redhat.com/
       Sashiko: Not Found
    -> [5] [PATCH v2 5/6] rtla/tests: Add unit tests for _parse_args() functions
       Link   :
https://lore.kernel.org/linux-perf-users/20260521141833.2353025-6-tglozar%40redhat.com/
       Sashiko: Not Found
    -> [6] [PATCH v2 6/6] rtla/tests: Add unit tests for CLI option callbacks
       Link   :
https://lore.kernel.org/linux-perf-users/20260521141833.2353025-7-tglozar%40redhat.com/
       Sashiko: Not Found
----------------------------------------
  Series : perf kvm stat: Add missing mappings for PPC kvm exit reasons
  Author : Gautam Menghani <gautam@linux.ibm.com>
  Version: v2
  Date   : Mon, 18 May 2026 12:50:38 +0000 (Latest Activity)
  Status : Reviewer work (No replies to series)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260518125041.39286-1-gautam%40linux.ibm.com)
  Unapplied Patches (1):
    -> [1] [PATCH v2] perf kvm stat: Add missing mappings for PPC kvm
exit reasons
       Link   :
https://lore.kernel.org/linux-perf-users/20260518125041.39286-1-gautam%40linux.ibm.com/
       Sashiko: Reviewed (No regressions)
----------------------------------------
  Series : perf bench: add --write-size option to sched pipe
  Author : Breno Leitao <leitao@debian.org>
  Version: v2
  Date   : Thu, 21 May 2026 16:15:37 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260521-perf_bench_pipe-v2-1-720b6ff7f0fa%40debian.org)
  Unapplied Patches (1):
    -> [1] [PATCH v2] perf bench: add --write-size option to sched pipe
       Link   :
https://lore.kernel.org/linux-perf-users/20260521-perf_bench_pipe-v2-1-720b6ff7f0fa%40debian.org/
       Sashiko: Reviewed (0 Critical, 0 High, 1 Medium, 0 Low)
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
  Series : perf/x86/amd/uncore: Add common helpers and Hygon support
  Author : Qi Liu <liuqi@hygon.cn>
  Version: v1
  Date   : Tue, 19 May 2026 03:32:25 +0000 (Latest Activity)
  Status : Reviewer work (No replies to series)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260519033225.1479907-1-liuqi%40hygon.cn)
  Unapplied Patches (3):
    -> [1] [RFC PATCH 1/3] perf/x86/amd/uncore: Add common PMU helper functions
       Link   :
https://lore.kernel.org/linux-perf-users/20260519033225.1479907-2-liuqi%40hygon.cn/
       Sashiko: Reviewed (0 Critical, 3 High, 1 Medium, 1 Low)
    -> [2] [RFC PATCH 2/3] perf/x86/amd/uncore: Convert AMD driver to
common PMU helpers
       Link   :
https://lore.kernel.org/linux-perf-users/20260519033225.1479907-3-liuqi%40hygon.cn/
       Sashiko: Reviewed (0 Critical, 1 High, 0 Medium, 0 Low)
    -> [3] [RFC PATCH 3/3] perf/x86/amd/uncore: Add Hygon uncore PMU support
       Link   :
https://lore.kernel.org/linux-perf-users/20260519033225.1479907-4-liuqi%40hygon.cn/
       Sashiko: Reviewed (0 Critical, 2 High, 1 Medium, 2 Low)
----------------------------------------
  Series : Fix out-of-tree build of some tools
  Author : Ben Hutchings <benh@debian.org>
  Version: v1
  Date   : Thu, 21 May 2026 14:35:46 +0000 (Latest Activity)
  Status : Maintainer work (Review tags present on unapplied patches
or cover letter)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/ag8X7gcDw6jpJsLq%40decadent.org.uk)
  Unapplied Patches (3):
    -> [1] [TAGGED] [PATCH 1/3] rtla: Fix output files in source tree
       Link   :
https://lore.kernel.org/linux-perf-users/ag8YLYKZTKOq0t4x%40decadent.org.uk/
       Sashiko: Reviewed (0 Critical, 0 High, 0 Medium, 1 Low)
    -> [2] [TAGGED] [PATCH 2/3] perf tools: Put Python egg info in
output directory
       Link   :
https://lore.kernel.org/linux-perf-users/ag8YOLn1tFuFAxaI%40decadent.org.uk/
       Sashiko: Reviewed (No regressions)
    -> [3] [TAGGED] [PATCH 3/3] perf tools: Put Python bytecode in
output directory
       Link   :
https://lore.kernel.org/linux-perf-users/ag8YQmHiaFc8Hpb-%40decadent.org.uk/
       Sashiko: Reviewed (0 Critical, 0 High, 1 Medium, 1 Low)
----------------------------------------
  Series : perf stat: Fix uncore metric scaling bug across sockets and nodes
  Author : Chun-Tse Shao <ctshao@google.com>
  Version: v1
  Date   : Mon, 18 May 2026 23:11:30 +0000 (Latest Activity)
  Status : Patch author work (Feedback present in series, but no relevant tags)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260518231150.1252420-1-ctshao%40google.com)
  Unapplied Patches (1):
    -> [1] [PATCH] perf stat: Fix uncore metric scaling bug across
sockets and nodes
       Link   :
https://lore.kernel.org/linux-perf-users/20260518231150.1252420-1-ctshao%40google.com/
       Sashiko: Reviewed (0 Critical, 0 High, 1 Medium, 0 Low)
----------------------------------------
  Series : perf python: Clean up and restructure setup.py
  Author : Ian Rogers <irogers@google.com>
  Version: v1
  Date   : Thu, 21 May 2026 17:55:35 +0000 (Latest Activity)
  Status : Reviewer work (No replies to series)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260521175535.1531810-1-irogers%40google.com)
  Unapplied Patches (1):
    -> [1] [PATCH v1] perf python: Clean up and restructure setup.py
       Link   :
https://lore.kernel.org/linux-perf-users/20260521175535.1531810-1-irogers%40google.com/
       Sashiko: Reviewed (No regressions)
----------------------------------------
  Series : perf stat: Fix uncore metric scaling across aggregation modes
  Author : Chun-Tse Shao <ctshao@google.com>
  Version: v3
  Date   : Thu, 21 May 2026 20:15:05 +0000 (Latest Activity)
  Status : Reviewer work (No replies to series)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260521201505.124690-1-ctshao%40google.com)
  Unapplied Patches (2):
    -> [1] [PATCH v3 1/2] perf stat: Add aggr_nr metric parser support
       Link   :
https://lore.kernel.org/linux-perf-users/20260521201505.124690-2-ctshao%40google.com/
       Sashiko: Reviewed (No regressions)
    -> [2] [PATCH v3 2/2] perf stat: Use aggr_nr scaling for Intel
uncore miss latency metrics
       Link   :
https://lore.kernel.org/linux-perf-users/20260521201505.124690-3-ctshao%40google.com/
       Sashiko: Reviewed (0 Critical, 0 High, 1 Medium, 0 Low)
----------------------------------------
  Series : perf: Fix off-by-one stack buffer overflow in kallsyms__parse()
  Author : "Rui Qi" <qirui.001@bytedance.com>
  Version: v2
  Date   : Fri, 22 May 2026 07:07:38 +0000 (Latest Activity)
  Status : Reviewer work (No replies to series)
  Sashiko: Reviewed
(https://sashiko.dev/#/patchset/20260522070738.31900-1-qirui.001%40bytedance.com)
  Unapplied Patches (1):
    -> [1] [PATCH v2] perf: Fix off-by-one stack buffer overflow in
kallsyms__parse()
       Link   :
https://lore.kernel.org/linux-perf-users/20260522070738.31900-1-qirui.001%40bytedance.com/
       Sashiko: Reviewed (No regressions)
----------------------------------------
  Series : perf build: Reduce build time by nearly half
  Author : Ian Rogers <irogers@google.com>
  Version: v7
  Date   : Mon, 18 May 2026 15:46:38 +0000 (Latest Activity)
  Status : Maintainer work (Review tags present on unapplied patches
or cover letter)
  Sashiko: Failed To Apply
(https://sashiko.dev/#/patchset/20260518154638.2798789-1-irogers%40google.com)
  Unapplied Patches (2):
    -> [1] [TAGGED] [PATCH v7 01/14] tools build: Fix feature checks
to touch target files on success
       Link   :
https://lore.kernel.org/linux-perf-users/20260518154638.2798789-2-irogers%40google.com/
       Sashiko: Not Found
    -> [11] [TAGGED] [PATCH v7 11/14] perf pmu-events: Parallelize
JSON and metric pre-computation in jevents.py
       Link   :
https://lore.kernel.org/linux-perf-users/20260518154638.2798789-12-irogers%40google.com/
       Sashiko: Not Found
  Applied Patches (12):
    -> [2] [PATCH v7 02/14] perf trace beauty: Make beauty generated C
code standalone .o files
       Commit: 537609924c43 (date: 2026-05-20)
    -> [3] [PATCH v7 03/14] perf build: Decouple pmu-events from
prepare umbrella target
       Commit: b9453fa7726a (date: 2026-05-20)
    -> [4] [PATCH v7 04/14] perf build: Remove empty archheaders target
       Commit: 5af31e15732e (date: 2026-05-20)
    -> [5] [PATCH v7 05/14] perf build: Move BPF skeleton generation
out of Makefile.perf
       Commit: 713eeb227940 (date: 2026-05-20)
    -> [6] [PATCH v7 06/14] perf build: Encapsulate vmlinux.h and
bpftool in bpf_skel.mak
       Commit: 9798ac0128da (date: 2026-05-20)
    -> [7] [PATCH v7 07/14] perf build: Pre-generate BPF skeleton
tooling during umbrella prepare phase
       Commit: 32969ef6e3e1 (date: 2026-05-20)
    -> [8] [PATCH v7 08/14] perf build: Move libsymbol dependency out
of prepare step
       Commit: 96e808e5671d (date: 2026-05-20)
    -> [9] [PATCH v7 09/14] perf build: Remove redundant libbpf
feature check for static builds
       Commit: 29331b2edb86 (date: 2026-05-20)
    -> [10] [PATCH v7 10/14] perf pmu-events: Split big_c_string
storage into standalone compilation unit
       Commit: bb922345eec1 (date: 2026-05-20)
    -> [12] [PATCH v7 12/14] perf build: Prefix SCRIPTS with output
directory to fix continuous rebuilds
       Commit: 85cc481af5ff (date: 2026-05-20)
    -> [13] [PATCH v7 13/14] perf pmu-events: Convert recursive shell
assignments and macros to Make built-ins
       Commit: 90a815a22abf (date: 2026-05-20)
    -> [14] [PATCH v7 14/14] perf build: Convert llvm-config shell
queries to simply expanded variables
       Commit: 98e68cb77823 (date: 2026-05-20)
----------------------------------------
