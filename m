Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCFD1DF273
	for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 03:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402802; cv=none; b=ndRFE4caaSmOLgoibZ7Plxtt06viRNuqPHG6Dgwq7Y3EMjPAffac4nphAKdb9UgRfR82p4kFVKMKoksnss52bhoTvVo5whQNFOqfJ4nqn/dewRN6oS2aMrK2GKqhiUiMO5g9fNNPxnlljFUOb1ROmg3lmnMxBI6SlDU6uAo5n3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402802; c=relaxed/simple;
	bh=rNzkr9PD/Dn687T+AGetBIv/1kfPiIBsjmnIT83qck4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=VBZlvQE24hIzz1xAziAal1v5Oo6A0HkeJ8KZR/hAdG93f4DwfpEZxh0HCswj8VJ/LhJYbcZ/B76fLq5VmOt46KiNQ2IUMGjIsYeSQKMzLXyuS0kSPLKlxw6SIrdBt10+aSYVK3ZwKjvBRTsRGrQbXx6b2t4fTYq8g3DwqUUsG3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q2dUn5jV; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q2dUn5jV"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2c37558eccso1496714a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 20:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748402800; x=1749007600; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qthGPSnrY3//sB/RtQQS5H9LtWVtNZRKXA0sksz8t9E=;
        b=Q2dUn5jVZeX/+/mi+5W92XiMHFs0yaoHvCSoo2Y819Ar2q5QXeaolfyTwT5rvZlr3R
         gZjfkJrAfVJDN85p5hpcoND1fHWMogJhLA9GOTpO7WGCObUJiESVeL/N/7CYka30CWKJ
         LTHZHSZHOiAkQwyoGihY6KsLcVM2mUomVUfUBqzE+R78jbpKWzZBZyC3ne5/36M5nZj4
         zJvCQWQrzhSvS4UpBy7moL4Hq6HHfiV5AWwPiGgW12ScmYSquHde6ByyzzrXKGpXa8/D
         hK78av9MI7u711cUnhG6XRnn+nCpgqsKy0OMhpnUe60aX2fBDzgYtv66Hcc3FwCl+ebQ
         AoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748402800; x=1749007600;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qthGPSnrY3//sB/RtQQS5H9LtWVtNZRKXA0sksz8t9E=;
        b=pxcoz1vaT4K8XV1dHJuFajcMb18sbslAMJ5J0KIa9igN8O9Qji+Likqu+IHVyLLBgz
         NP7dMh/Kbs2yJRTpSywfl99eea5cSyvUn1x82bSH1nK2SLHlsczR6L8i+1n8liJHYmeM
         tgrhzlgNNOpqGF0iDBDwbBVMYqk3nAOc/b9VFot+9P4wQm5hFENrM/DsxOehLlzedp9C
         XaISrn31CHDX3sIAfeTk+7r5jlWU1Nc7GeduyI3D1j1SIOtN1RaaWQl0jgVajk5rIYDg
         FDvqNbwdKp4CNdi5n11p3SCF6HpuGoBK5bXisDu2he+bhcRJF226Si4My3xJ6D8nbRD+
         0ucw==
X-Forwarded-Encrypted: i=1; AJvYcCXuBQLZomEmuoAdM1NDmHl4w3yYeBPkhcopy+zk10EZNY10kttjKK3I9Sye0Bt9t/TkJ0n+vZ9qxweONKVXq/RY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4UTDQpnI1nfFODcWN2gXOGbOhKPsW1gIRPeeGEfUfZlhrrLr0
	tkP9LJy0lTcCvvZGnAANsMUjLVwaA++/BZNG8PgEB+u/smHLRBXV4rFBTKT05ODc9fI5vGR7OKi
	B4Y9hDLlTKQ==
X-Google-Smtp-Source: AGHT+IEieyR9hfyUbMGNfOASge5qq2XRjAhfP7DHYG9bUxzx9nIbSVq4zNmmetxMqCCk80MpvM4NnSqoC0uW
X-Received: from pgbfq14.prod.google.com ([2002:a05:6a02:298e:b0:b2d:aac5:e874])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c6cd:b0:1fd:e9c8:cf3b
 with SMTP id adf61e73a8af0-2188c32800bmr26426139637.30.1748402800192; Tue, 27
 May 2025 20:26:40 -0700 (PDT)
Date: Tue, 27 May 2025 20:26:30 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1238.gf8c92423fb-goog
Message-ID: <20250528032637.198960-1-irogers@google.com>
Subject: [PATCH v2 0/7] Various asan and test fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When testing removing perf_env with asan I noticed a number of test
failures either because of asan issues or because of building with
NO_LIBELF=1 and NO_LIBBPF=1 to avoid false memory leaks. Address these
issues so that real test failures stand out.

v2: Fix wrong elf size use in filename__read_build_id fix. Add
    thread__comm_lock fix.

Ian Rogers (7):
  perf symbol: Fix use-after-free in filename__read_build_id
  perf test demangle-java: Don't segv if demangling fails
  perf symbol: Move demangling code out of symbol-elf.c
  perf intel-tpebs: Avoid race when evlist is being deleted
  perf test intel-pt: Skip jitdump test if no libelf
  perf test trace_summary: Skip --bpf-summary tests if no libbpf
  perf thread: Avoid recursively taking thread__comm_lock

 tools/perf/tests/demangle-java-test.c   |   5 +
 tools/perf/tests/shell/test_intel_pt.sh |   5 +
 tools/perf/tests/shell/trace_summary.sh |   6 +
 tools/perf/util/demangle-cxx.h          |   2 +
 tools/perf/util/intel-tpebs.c           |  12 +-
 tools/perf/util/symbol-elf.c            |  86 ------------
 tools/perf/util/symbol-minimal.c        | 175 ++++++++++--------------
 tools/perf/util/symbol.c                |  87 ++++++++++++
 tools/perf/util/thread.c                |  17 ++-
 9 files changed, 198 insertions(+), 197 deletions(-)

-- 
2.49.0.1238.gf8c92423fb-goog

