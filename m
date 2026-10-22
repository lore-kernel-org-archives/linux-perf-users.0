Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701995;
	b=030pfuN5eUat5LIx9n3eGPtcB334bIkq/Px/okENo71luY8Cf00mj6H6T8F8NuhDPBIJ
	 oo5xLBHBVddMsesDhPiXI6/vlXM4r0ukj2GXvvW12rigsmNd6eyjRwXIy6ZW+034HpD+g
	 e7CO2DO/uQ76FQgWBFtsQMjdNFlDkOIhNIpFSkhypFu45BEDzswAKyUIexYyNo/qAFcv6
	 IRcF5eW5CNByjAFFD64htzFalBqXMORmEXGPSKeuimeSp+w6OnP9iTfC7o8aTN1MkIwxS
	 pK8dHWnmqcix3pQK3YTK1DmY7NEwOwwhEzcVbfYprExxbbjRcQD3f5kPL8kFoN9QdkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Ysl1d/0h3aeNG4530gdQo/Cgx+FMPRdnoywPZWHvZao=;
	b=p79cyrSqC3To75qWqDPZID/Xra92CI+DyyNLOHhLpadbZFM6ac8xGJ8ea9av3FmO0seW
	 3h4ERnwDy+LsBBOzrAvCUvg7rz3cMVgGumFwtfj/Gg6eQIWG+ajpe1hCL15dgW/RiS2HQ
	 hxBwt+8hYGcx+hxNxbAAXp3LXg4MhfzBPTa634wazs9HYqcvnkuzRiPu4XGw5EgtiC/eH
	 j4JwUisSMfA46+fzareZvAFi3yVw4Gmd+dhPJ60GkVgEcnI/cctbA6eUai6LWFkQ3XxZo
	 kXybLfkPZTPVP2b+3MuM301e4UAjKuFo4AmQmCVZc3cmVVPevdwpwuZJ4Q65qwlxx1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=aQbgPcX1;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4154606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 20:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4154606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=aQbgPcX1
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so467945eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 13:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792701994; x=1793306794; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ysl1d/0h3aeNG4530gdQo/Cgx+FMPRdnoywPZWHvZao=;
        b=aQbgPcX1pBs8f1P4KXdtCBMhSowNeKF9oMdqJJPFRsHCO5joE2rxR9MLL60e0iQ+VC
         kDRf8l78j1ccdlAYvqK+cYABojRKj2NWcTvIl/zm5eZXjNnHA76BVdn+r26/A9ceaTZi
         176YSSWEDEloOPIGAPzsL5jIqsoHoy7HI5K46ubcgojk2rUgnyZNZ+VrLvx0ITT5Ru5O
         QW0r/y8MexFXzN5KH78w6H60XwDlahNMkzNWfnoOI58b13yp2ad6nUDm/sCNljzjinQT
         ZsIkox/7PHljmC5/VeAL1LhVBBc44GlGjlSS4n84n54sAIVej5sFJcCAv2bX8TkfNQu4
         gppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792701994; x=1793306794;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ysl1d/0h3aeNG4530gdQo/Cgx+FMPRdnoywPZWHvZao=;
        b=LIUZCxycB3B/TRvT8r3faZaUaEVzorwdJ+9OhlpiQX//xuuUUa2ojnLxxQ6fN6f50h
         q8tTbobUSWIRMCsmTVvA8lfVPQ59XA3ZaIIjf59wp4WS109sfhYDUrA3MhRgOk9ybYwp
         93n5z9COZ0wLHPiuQBfaCLUVevMMg20AycAcG8TvIQWB+ZCNJRkXE9pMuYZnMHu5sTUs
         A3NUB9ewnlabyPA1ClrBC6zjX0kY9kJ/CLVUUaPhLZhU45vuQe0swUfmHVdlsb2e8lCe
         Ng5+8hZIPP+lQJXwt5F+CSD+MtxoFRiZqp8BFXAKtto/FGw/dbnIItSGbmkgnOobq7vn
         S6Tw==
X-Forwarded-Encrypted: i=1; AKwUvBzLArCzaVSkpjmhQeUtMy3G64Qq+JtuVFPudKB1r5OBprR41RslEJaNKpc0oWVTsiXXYIZpxEEvYLloWDydLW31@vger.kernel.org
X-Gm-Message-State: AFq9FYICw02SE9oFXFvGs33eqkUAE5dp20/2kriPjpq9Yw3BLtxEfvJs
	VT4IhKr5qWn6xWNpEM0vACt9qYCPauhF2iGLixUlUgr/or3AR0IDZxSMhrV+LRRzJY0a224Y0UP
	18KvRhgiKJA==
X-Received: from dyau28.prod.google.com ([2002:a05:7300:601c:b0:35a:f5b8:c8c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:87d7:10b0:366:83dd:46f7
 with SMTP id 5a478bee46e88-369d98074admr318643eec.17.1792701993349; Thu, 22
 Oct 2026 13:46:33 -0700 (PDT)
Date: Thu, 22 Oct 2026 13:46:25 -0700
In-Reply-To: <20261013231430.2163505-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261013231430.2163505-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261022204627.1813821-1-irogers@google.com>
Subject: [PATCH v3 0/2] perf build: Support building BPF skeletons with bpf-gcc
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, cupertino.miranda@oracle.com, 
	jose.marchesi@oracle.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, andrii@kernel.org, eddyz87@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Currently the perf build requires clang (>= 12.0.1) to compile BPF
skeleton programs (.bpf.c -> .bpf.o). bpf-gcc (>= 14.0.0) also supports
BPF CO-RE and BTF generation and is already supported in
tools/testing/selftests/bpf/Makefile.

This series updates the perf build to support both clang and bpf-gcc:
- Patch 1 updates Makefile.config, Makefile.perf, and bpf_skel.mak to
  prefer bpf-gcc when building perf with GCC (CC_NO_CLANG=1) and clang
  when building with Clang/LLVM (CC_NO_CLANG=0), while respecting
  explicit BPF_GCC=... or CLANG=... command-line overrides and falling
  back to whichever compiler is available.
- Patch 2 adds make_bpf_skel_clang and make_bpf_skel_bpf_gcc build-test
  targets to tools/perf/tests/make, reuses tools/build/Makefile.feature
  for feature detection, and verifies with
  'perf check -q feature bpf_skeletons' that BPF skeleton support is
  enabled (or disabled for make_no_bpf_skel) as expected.

v3: Reuse tools/build/Makefile.feature and tools/scripts/utilities.mak
    in tools/perf/tests/make rather than open-coding compiler feature
    probes, and explicitly check for exit code 1 from 'perf check' in
    make_no_bpf_skel so crashes are not masked by shell negation.
v2: Pass only -dumpfullversion when querying BPF_GCC_VERSION, guard
    against an empty version string, and fix version-ge3 / version-lt3
    in tools/scripts/utilities.mak so empty or <3-component version
    strings do not shift awk fields and evaluate as false in version-lt3.

Ian Rogers (2):
  perf build: Support building BPF skeletons with bpf-gcc
  perf test make: Add BPF skeleton build tests for clang and bpf-gcc

 tools/perf/Makefile.config     | 83 +++++++++++++++++++++++++++-------
 tools/perf/Makefile.perf       |  8 +++-
 tools/perf/bpf_skel.mak        | 36 ++++++++++-----
 tools/perf/tests/make          | 71 ++++++++++++++++++++++------
 tools/scripts/Makefile.include |  1 +
 tools/scripts/utilities.mak    |  4 +-
 6 files changed, 159 insertions(+), 44 deletions(-)

-- 
2.56.0.307.g5fe7bd680c-goog

