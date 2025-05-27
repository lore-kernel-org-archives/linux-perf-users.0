Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BBB26A08C
	for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748369243; cv=none; b=dcuNPicQcBhfgKHNZShar5pPdx9O58SmaqqywIQ7xXDTVErPy+fhUYnuHivYiG46AgjFFnS+iuoe5Kvx2ULzJLteB3K/8HjCs8L+0bCT3NikTkuKxicp5MNYaNx3oHJe7DGQdv+KNG4KvFqrF6DBKOwOlfUoFMWHhLhh4MjlAkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748369243; c=relaxed/simple;
	bh=UKJYZ6cmRfc4HcZtUDu8cdSyp3ZTcwZXFnyTUcRgO9g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=ApZoMJ1iMn4oFyieQo7RIJibq7D72MWC/xZFd/v+mG5dXKQJv9dLIX8okxnc3X70FbwIIxcdYTjYjdg2JOAkiGSZlIZE+c+f4wBmYI+jiIyaKU9kf/lKy2b9z5N9veY9u6m8mLviGIrlUEyL1Z/SjKsqUCMbO2bN+w6xdNX4zn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1O6tAq7p; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1O6tAq7p"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7395d07a3dcso2676405b3a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 11:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748369242; x=1748974042; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D2EQVFnLCdguVRIPsu3XiE+bWSQOprE3/LWQz5iARng=;
        b=1O6tAq7p+JQnujbe+Z1hyowc6gbrCnLPUo+W/DfKQfgYKixRceAcVF3Jylx6o3JGaY
         jN0A0quXv+hsHAX6aV/NsymGvqAAkxKUqXZajvu6Z++yIfAjsAhYzR91d/T/AQJJ1Gfk
         vO8fvA6dLXfjtt8mfNkYE0tCvggcLHpAusbtOEylHjrXiwv0NIkFRbG1ARHy/oVov2qw
         oL8TyMqzic5RRqdKTB6JYO8OR0w/GKwrGOUCYsp8qYJygZFMug5K6S8v4LaFtTkri7H7
         KXLBsAdmB9EVGOAxun3+dvoz/YVb8v/37CQcjBFCRIeCK07j4twQFGTbeuMtKF4yJ5Hb
         mwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748369242; x=1748974042;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D2EQVFnLCdguVRIPsu3XiE+bWSQOprE3/LWQz5iARng=;
        b=PdGV83ljlFXs8RQ/l2Mc1l+0pbWDNfl1IrkEtJadcNPzqWdx8lsCJZ97E5M/acGzer
         GBQM2vYOFNE95Um5CwUckguLakHHFqWil0xA70Wfust1g1TfGWCeuhxO6w623JXZBgKh
         +MNxfXReT5esYXDRGcsl33DErv5gr/RlnNIuGmUWgjHheFahUzeSv3ZBNJHmqI7oFkI3
         dUIPnRVKR5AxmAye8tXgc4sZ9dYSC/WDMI7GRY2eZ3zTRRAIMLmG47sky2uZ54hKJL6H
         GOULZUtX2a/7WGV3igtVzTrY9b7gEW1KPVcX7lca2CMujHsxgKac3yxBZg5YEI1T5+Go
         QGyw==
X-Forwarded-Encrypted: i=1; AJvYcCWTY9X5/2Us1kkzUh7JfsNhSJZdceVitSZW7TRSVJ0ranD6wXHchfJorS33sSNqPa+iHovTdHqC34Y3uodxw6yh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ZeojLIt8wkDP2w7kU2kAjl7EvV7Z4WPx4DFSA9N3UqMEbFiH
	UXfvb8tT/Blow5Fnzn6KXGHiovcLyUi7xAbZBWYX1BJfLQs6sMa/1Nbl1siErA3sVyj+t0Y0q6B
	xyCe8MClhPQ==
X-Google-Smtp-Source: AGHT+IHmu0uWq1DhUhYZoSb1xLAzjCxuKAMOLpQEojTlSNXl2HZz+xJz+qapdhW4NW4CJmop/Wsycl1Xx6HG
X-Received: from pftb15.prod.google.com ([2002:a05:6a00:2cf:b0:746:2897:67f3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c88a:b0:206:ad2b:aa9a
 with SMTP id adf61e73a8af0-2188c3b2f3fmr24135257637.36.1748369241557; Tue, 27
 May 2025 11:07:21 -0700 (PDT)
Date: Tue, 27 May 2025 11:06:57 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250527180703.129336-1-irogers@google.com>
Subject: [PATCH v1 0/6] Various asan and test fixes
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

Ian Rogers (6):
  perf symbol: Fix use-after-free in filename__read_build_id
  perf test demangle-java: Don't segv if demangling fails
  perf symbol: Move demangling code out of symbol-elf.c
  perf intel-tpebs: Avoid race when evlist is being deleted
  perf test intel-pt: Skip jitdump test if no libelf
  perf test trace_summary: Skip --bpf-summary tests if no libbpf

 tools/perf/tests/demangle-java-test.c   |   5 +
 tools/perf/tests/shell/test_intel_pt.sh |   5 +
 tools/perf/tests/shell/trace_summary.sh |   6 +
 tools/perf/util/demangle-cxx.h          |   2 +
 tools/perf/util/intel-tpebs.c           |  12 +-
 tools/perf/util/symbol-elf.c            |  86 ------------
 tools/perf/util/symbol-minimal.c        | 175 ++++++++++--------------
 tools/perf/util/symbol.c                |  87 ++++++++++++
 8 files changed, 185 insertions(+), 193 deletions(-)

-- 
2.49.0.1204.g71687c7c1d-goog

