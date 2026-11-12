Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446124;
	b=ek0okW3Fjt/u4GkvM0PF50B06N3bPduQDWZXBzobOe91HEtmczc6trvzVsYg984DD1/r
	 ZWaoEoshv4jdP3qGSWFWmRfZx7jXWNu1SeXrQl2qqBf+nWVZ+c/RjjLrm1T/d7g2o5a/a
	 bzSqkKBya+H4EDVRygr7EzYejS/BRiPsqUkcgIXbEtmTVlvQIL3Cjh2Dts+BkdOSFf4vx
	 sF5fJjammKAlKUfDHasQeyildrdwVQLYnVPLzfLbKoV9qTGkN0qd7VK97UuGSOEt4QsiU
	 AacYpuj7L/pfDgvlwcU2PUxJYTVQaHtnebp9lCbLG0cdYmP9UrvT9qiJCDJxrPLATGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=t4mmpYAAB5nspJI5JB7CDrr7JDrHcqy1ptTPlsjfoME=;
	b=jVKwNGKJsoDZ3SUOxeKhwmIRHbNAzoP+21dEBwYRMG48bvSimePS+TxMFtcEc2NpQ4DN
	 FvLhYV7XashGK3zucpxhnGdD3aOH6LuEH0hFqzcFsy86iHjUSFNnI0Xxn1aiYieZyanXm
	 E5qJeqE5gsHoFVkXaWJvBFGnYE6SCZqt+UJACmsJu+zMTdC+zZv32m3ah5cdn4zuB/Mb5
	 Xs9sJ4p7S5oITX87SoVejMCfmVgfJJbDvC40PIRt22vSOiOcZTycKLS6TlBN0A5t/XhTV
	 zMtSNl0/qbTgIo6bmYF6i8oshVTId7Ad5v/P/2rvIvwt2ss1TmOzQ+tpu32nAjk3ACw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S9Mmbbnw;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88612606A326
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 01:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88612606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S9Mmbbnw
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36ecd5db581so511644eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 17:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794446122; x=1795050922; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t4mmpYAAB5nspJI5JB7CDrr7JDrHcqy1ptTPlsjfoME=;
        b=S9MmbbnwvxMFaVSXSZ0+LcX04EvxGcthAHSv2gJ9cadC5/Iil6qn9szX+oGBO0YnIq
         x3lzzVYbAL27ZEii8AF6vpXW0ujtqkJNOR9qDRXjjr4v3hwE+PAYu0hezxUFgorTKLrg
         /2a2Y9ntzOKgPk0KMl9cf4B+f8uu0wrmYYC0Tje3lGJ+YJrN39xDcJPerMQWFvZhNKPf
         XxZwWTG+0JClT0+bc/wp5ouTsDi3PmGLcdh9DhXlZlTAI8HN2jVQPttKPuXmxAbCIg9d
         PCpFH397QpW1yvsf8DwCIBshCxFJI43J/JZ5h/N06knBHn4s2W3DgSA/Kc5/g56zNKAf
         909g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794446122; x=1795050922;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t4mmpYAAB5nspJI5JB7CDrr7JDrHcqy1ptTPlsjfoME=;
        b=kGe86H5BT1YPUmq7vW+f461VAfzDJytTtzvaDvhkSxzf5mXEfHGtXasf9zJXvFLFgt
         R3bRIGIK/IGRguSrmm93Vz+TIl6q/XKbG0AsXckSEQutOG3RnNjZERBC2hHmOfw2Xcz/
         Y7CAG+PTeuecXpNC42q1APhWrDlVYT7KogHPkVs0V9BS4pKlruf/VB8ty9fYlY91SlcJ
         vADc0ay02XSOiyNbwnQkwgtq06/MgfxXsxbsIwdi2lEjTm+NXwzy0aVNy3+60OER+/J2
         ivFdfWREWmS/GQCUrkQSDlWr6WjgmSCLiLHf8ja0Hj2bf6f+IGqDc3ouQhgPzKO67gr6
         XaiQ==
X-Forwarded-Encrypted: i=1; AL+hErFB67fGGHxqDGIfpQIvdtUsgy/mMA9eMqyCD2ytqTp9MXX4vxVc/hZ7fb8R4z+TlN7bnHhtQsB6NzJwrm/lXvxX@vger.kernel.org
X-Gm-Message-State: APuU4Z+phWUOastlC/MGkum7mHlz0lH4qSs0DnCzE4zNVAtvlh7TQxLr
	XAcsAZZPz7vAx0ReV0JaYJy0+ZSZax2OsG7hY6/FE2F2XNolXUYNqWebPJKWWESVDDDng8CqkVZ
	1FeRx8LDHpw==
X-Received: from dlbrx10.prod.google.com ([2002:a05:7022:170a:b0:143:7311:4b88])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2906:b0:143:271a:3df2
 with SMTP id a92af1059eb24-1b3c0361cc2mr3305997c88.44.1794446122041; Wed, 11
 Nov 2026 17:15:22 -0800 (PST)
Date: Wed, 11 Nov 2026 17:15:09 -0800
In-Reply-To: <20261022204627.1813821-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261022204627.1813821-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112011514.4032822-1-irogers@google.com>
Subject: [PATCH v4 0/5] perf build: Support building BPF skeletons with bpf-gcc
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, andrii@kernel.org, cupertino.miranda@oracle.com, 
	eddyz87@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	jose.marchesi@oracle.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Currently the perf build requires clang (>= 12.0.1) to compile BPF
skeleton programs (.bpf.c -> .bpf.o). bpf-gcc (>= 14.0.0) also supports
BPF CO-RE and BTF generation and is already supported in
tools/testing/selftests/bpf/Makefile.

This series updates the perf build to support both clang and bpf-gcc,
broken into small bisectable commits:
- Patch 1 fixes version-ge3 and version-lt3 in tools/scripts/utilities.mak
  so empty or fewer-than-3-component version strings do not shift awk
  fields across arguments.
- Patch 2 syncs bpf_skel.mak's get_sys_includes with
  tools/testing/selftests/bpf/Makefile for LoongArch and MIPS.
- Patch 3 updates Makefile.config, Makefile.perf, and bpf_skel.mak to
  prefer bpf-gcc when building perf with GCC (CC_NO_CLANG=1) and clang
  when building with Clang/LLVM (CC_NO_CLANG=0), while respecting
  explicit BPF_GCC=... or CLANG=... command-line overrides and falling
  back to whichever compiler is available.
- Patch 4 introduces tools/build/Makefile.feature in
  tools/perf/tests/make and switches the existing libbfd and llvm probes
  to reuse libbfd-threadsafe and llvm-perf.
- Patch 5 adds make_bpf_skel_clang and make_bpf_skel_bpf_gcc build-test
  targets to tools/perf/tests/make and verifies with
  'perf check -q feature bpf_skeletons' that BPF skeleton support is
  enabled (or disabled with exit code 1 for make_no_bpf_skel) as
  expected.

This series was developed and reviewed with assistance from an AI coding
agent (Gemini 3.1 Pro) and reviewed with Sashiko.

v4:
  - Rebase onto perf-tools-next and drop Assisted-by tags per commit
    1e035297ffda ("docs: remove Assisted-by references").
  - Split the series into 5 smaller patches for bisection, separating
    the utilities.mak version-ge3/version-lt3 fix (requested by Namhyung
    Kim), the get_sys_includes sync, and the Makefile.feature
    refactoring in tools/perf/tests/make.
v3:
  - Reuse tools/build/Makefile.feature and tools/scripts/utilities.mak
    in tools/perf/tests/make rather than open-coding compiler feature
    probes, and explicitly check for exit code 1 from 'perf check' in
    make_no_bpf_skel so crashes are not masked by shell negation.
v2:
  - Pass only -dumpfullversion when querying BPF_GCC_VERSION, guard
    against an empty version string, and fix version-ge3 / version-lt3
    in tools/scripts/utilities.mak so empty or <3-component version
    strings do not shift awk fields and evaluate as false in version-lt3.

Ian Rogers (5):
  tools build: Fix version-ge3 and version-lt3 for <3-part versions
  perf build: Sync bpf_skel.mak get_sys_includes with selftests/bpf
  perf build: Support building BPF skeletons with bpf-gcc
  perf test make: Reuse Makefile.feature for libbfd and llvm probes
  perf test make: Add BPF skeleton build tests for clang and bpf-gcc

 tools/perf/Makefile.config     | 83 +++++++++++++++++++++++++++-------
 tools/perf/Makefile.perf       |  8 +++-
 tools/perf/bpf_skel.mak        | 36 ++++++++++-----
 tools/perf/tests/make          | 76 +++++++++++++++++++++++++------
 tools/scripts/Makefile.include |  1 +
 tools/scripts/utilities.mak    |  4 +-
 6 files changed, 164 insertions(+), 44 deletions(-)

-- 
2.56.0.567.gdb80ae8cd5-goog

