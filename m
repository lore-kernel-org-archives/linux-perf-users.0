Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2736D394EA6
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 07:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348282; cv=none; b=GUypVfeUbk05OfvwVOnTqoarbAPKt2zoukVEzzChl23Of3pinYSljEg75zhwce3fkf9tgtWka56blzatg3rjVXykMHflp1t+b4Nh7UiLojr+iuTF/3Q9A4XL/42XHDHYjIUcgEJc6t7DK1UAemftzCYXlKnDrVjFkLrNlIL2lLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348282; c=relaxed/simple;
	bh=JK2FsdWqIpbhnUUJbc5gzblW88l4umGonHORdmDOtks=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=ebO5wpHBwr4WysvHfJ7v7wRGpgC1bMfGjSVhUfgHaZI5tkZ/Pg1iPNkhnh4TcTeBzgDI/3wgabF3UoyCjoEwW7F2moD//vO5IlXfSLUse8O4E5JY6Dpe4YJJf25rHdgsQnp4U0eyG4Hj26jGlC1slQon/4rqVugHKtYc2grOx48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pDMqgbjb; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDMqgbjb"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-303b38ec2f6so8167382eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 00:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779348280; x=1779953080; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+hKqzR/snvn9EXJnft+YCqVPmN3stCDgEVe3UpCIIg0=;
        b=pDMqgbjbMkjUDPSzps2ZVDuf+oGWic03zoS96AvHb9rXEpdQXJdO7vh5BJUfhkmT/r
         szw4eFFo0z0VWUTcNe6l/Ofdk3FDq6tus1m6eVp5GX01bhZ81I5x+EkC8UfZDfkRgeIc
         dojC+zABLEld1U7JX6GaU+5uj7UsFbEPfOGNMgZKcjP1FiIjXXr7futzeVTGKu7jdkc7
         CGnGkGNTBRehHDOIEmFl838z+3LGamribIbWBRwwI1z6+TXLaveXqL2ZKJwWCAsfDYi2
         iDw+K4BJC5F+YrhH1O/4JL/m8cq3DX8pVT4FTIeUdDmoRpwZ3eVODbKsqdc8ajyz7Os2
         fetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779348280; x=1779953080;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+hKqzR/snvn9EXJnft+YCqVPmN3stCDgEVe3UpCIIg0=;
        b=J1ggVXjETEcW2EYSnMBb+IJtgW9lIdWl5sitXXjWJY0xemStq98fghmfPdOgYVJoBM
         g9DagSGHCb8u9F+D/bR2uKAr1dgimz2aPG9d0xqs4npBKPIVrm9xdy10Fy4NnJMpyVbo
         bOCV9629Ima7oMtuwPh/bqV5el9MCmtlaZ776B+uuc/BTa/auWeOocWQOiykgQb8gZx2
         8CWMnJvNSxA0coIKayNK4crLU3u63BLPfMwxB2nrVRK8lxAEn2DfbaRg/pGhG8CayOv3
         D7LhBSnPSKO1MWOhqsCuKO3YLom5ha3iJH1fTunzRBQrOfzeOvIFSVn9O7Xls5FxFtdI
         hVMA==
X-Forwarded-Encrypted: i=1; AFNElJ+OTFcbRmA8G8DoEudkyCudOGN4szpnxT+AJmEyln00qaGOvSROwvgSNkljpg1V8mQmOEMbs3neim5Go4v4W1RF@vger.kernel.org
X-Gm-Message-State: AOJu0YxfkvjQQ9jSWVJd4Hf1+YobMPrmNJ7chBIyKxxSp1XZ8APuItPS
	y28Rur0JqFoubV//i/RLKG3WK8heLYiUwF+8rONwX3iK7cFp4hwA2j2UxXxYTiRst1JidBChvwn
	0D20Qobkb1w==
X-Received: from dlbts4-n1.prod.google.com ([2002:a05:7022:b044:10b0:135:5a9c:4291])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:220:b0:135:ce5a:98b5
 with SMTP id a92af1059eb24-136328f2112mr872643c88.13.1779348279909; Thu, 21
 May 2026 00:24:39 -0700 (PDT)
Date: Thu, 21 May 2026 00:24:26 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260521072429.1283423-1-irogers@google.com>
Subject: [PATCH v1 0/3] perf: Fix kwork memory sanitization and libunwind test builds
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The combination of the libunwind refactoring and build system changes
exposed a build-test regression for the libunwind build using a cached
feature dump. Re-send kwork fixes [1] moving a definition to kwork.h
to avoid breaking no libbpf builds.

1. Build Fix for libunwind:
   "make feature-dump" runs without LIBUNWIND=1, skipping the setup of
   libunwind LDFLAGS. When Makefile.feature is included to generate the
   cached FEATURE-DUMP, the local test-libunwind.bin compiles without
   arch-specific link flags (-lunwind-x86_64) and fails, caching a false
   negative ("feature-libunwind=0"). Later builds (such as make_libunwind_O
   reusing the dump) compile the unwinder based on CONFIG_LIBUNWIND (remote)
   but disable HAVE_LIBUNWIND_SUPPORT (local), breaking compilation due to
   missing maps__e_machine declarations in maps.h. Fixed by unconditionally
   setting up libunwind feature build flags in Makefile.config.

2. kwork ASAN Double-Free & Leaks:
   - Solves double-free in the record command argument array due to
     parse_options mutation, by preserving original pointers in a calloc'ed
     to_free buffer.
   - Ensures kwork_usage string is freed on all exit paths.

3. kwork Unified Memory Lifecycle:
   - Establishes a unified memory ownership model for kwork_work by
     ensuring work names are dynamically duplicated via strdup() and
     consistently freed using work_exit() and a central perf_kwork__exit()
     teardown path.

[1] https://lore.kernel.org/linux-perf-users/20260520190538.142018-32-irogers@google.com/

Ian Rogers (3):
  perf build: Unconditionally set up libunwind feature build flags
  perf kwork: Fix address sanitizer issues
  perf kwork: Fix memory management of kwork_work

 tools/perf/Makefile.config  | 103 ++++++++++++------------
 tools/perf/builtin-kwork.c  | 151 ++++++++++++++++++++++++++++--------
 tools/perf/util/bpf_kwork.c |  14 +++-
 tools/perf/util/kwork.h     |   9 +++
 4 files changed, 188 insertions(+), 89 deletions(-)

-- 
2.54.0.746.g67dd491aae-goog

