Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3C9281375
	for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748369258; cv=none; b=MxfsBoBfqFNqS4LTPnckeQtYDvlcLvldX29gKTrE3vlFkqhEiHfwDQhkD5J6CAhWLTWThJEnoSecMi5Fe12UuKhvPkMk4zaWm6b8HZ+UlcTtbm79Qlwnq8EaB+XnNrl/HfyvwANMq8ORBxgWqhhXYW1u60LP0xsR4enCfb6SP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748369258; c=relaxed/simple;
	bh=hYhJhw9lgUIEnIxwZHfufmbd/yzFeT8cZT61HtEgsyg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=OtpS8+jX4Lx3khM+c5cSY2fLvQbBUI4zIKWe3hxkS0IYvMBJonFuIUzpmxA/dmyhG9dkCwZdiCBmbNLZbCZdy7fSAX1E4MWg88Qy/yjcEfDbkqYY4fO8dYo0DIpFstF7H/1f2jdkgalc0rGqxITmF5kPyJrchRDD3z0VCIkWrZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kf0i/w/9; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kf0i/w/9"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-745e89b0c32so5613337b3a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 11:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748369256; x=1748974056; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nD2QkUBNtYWidhmQthg28IqOzebmfKqF2U7ClZ+k9CY=;
        b=Kf0i/w/932fCLWp4iAySJsElkA10IwKFC70JitopUi0d2/1VjhUTNSq8GL0DyF+w5h
         ofUy4gKSii5vdS8tK7gPpRXb4hG+pVP/cb6gpjQKH9S6ovBCs06LBSVXk8wrIlGBm0GA
         hzlZAkwY0usD1088HZjG4fOKatCFyif/nL5EEPrii7+aJQnvRFRq8XRTVtCnIIpRcC9F
         0HYpYDQZ1zC/5EOJYfem5GXinbzfPxWi1VXe2o2Aej0UoC79aeA25tsh7uC66ZM/91SX
         W9hf60hwBKyQc170fbPU4ZeQA8a2w4q+Kr++1XcZoKU6j72mJF7DigM6SG/vdMmXTlhf
         05kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748369256; x=1748974056;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nD2QkUBNtYWidhmQthg28IqOzebmfKqF2U7ClZ+k9CY=;
        b=lh4PZeX1RniEB53DRCaoW3GRIob9esl/rqjmx/CP0KreFhnCqqBAy/ZjIvXmr58Z1B
         8r73lcRdJBTc68fNqXystowEa3nPa8WecW2oDYLIDr8IelY+GNXjhyIiAJlCgqzn7RaR
         cTHI6whjzfk0GghdhMYkPnC/eKq2kEzTdrrwjNTCELZcNvl1WD9wy2+Un9inWGuqbzXw
         tUUWD4sISWWJWFbeSbvk0npGD+p2BI6+9ftr2wt8BddbLuo2Szdm/zKCDILc2rBP5WHw
         Oftyf1VNCGHnBPM7oz5fX1IGkEo5xots5qZ1gjJVacEZmUA8dxsvvJ6AKyKGUhKPftjc
         sVmA==
X-Forwarded-Encrypted: i=1; AJvYcCWv58Qg7KYNz9DcVTpCC/RpFP/bStcKZP+PmygP6qa2Vv+xYhrGUor8wC1M4BcYtueqRv7N4k2gytaLYc1VRD+S@vger.kernel.org
X-Gm-Message-State: AOJu0YyWkxe7Jfxx+riePJzbQVUoFl94csGfF+feKugarjfkiRy0UU+g
	AiyXpybdPmIgYyGCpADTOfYfuXxBVMld9LzEfjRloPjgUbeo1g0jkFdoDziXgNhgbVPG4twC/tM
	H9fqCNeuMkw==
X-Google-Smtp-Source: AGHT+IE4fW6g74Tthm48qNxM7YBO8dkYBPd3gBkxzs41uElkUtHuH5YcJ4K+ZN7/1wnwXfEfwdwixMyWs3MB
X-Received: from pllw5.prod.google.com ([2002:a17:902:7b85:b0:234:4c97:1e84])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db03:b0:224:1001:677c
 with SMTP id d9443c01a7336-23414f32ca9mr193634635ad.9.1748369245048; Tue, 27
 May 2025 11:07:25 -0700 (PDT)
Date: Tue, 27 May 2025 11:06:59 -0700
In-Reply-To: <20250527180703.129336-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250527180703.129336-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250527180703.129336-3-irogers@google.com>
Subject: [PATCH v1 2/6] perf test demangle-java: Don't segv if demangling fails
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

The buffer returned by dso__demangle_sym may be NULL, don't segv in
strcmp if this happens. Currently this happens for NO_LIBELF=1 builds.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/demangle-java-test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/tests/demangle-java-test.c b/tools/perf/tests/demangle-java-test.c
index ebaf60cdfa99..0fb3e5a4a0ed 100644
--- a/tools/perf/tests/demangle-java-test.c
+++ b/tools/perf/tests/demangle-java-test.c
@@ -30,6 +30,11 @@ static int test__demangle_java(struct test_suite *test __maybe_unused, int subte
 
 	for (i = 0; i < ARRAY_SIZE(test_cases); i++) {
 		buf = dso__demangle_sym(/*dso=*/NULL, /*kmodule=*/0, test_cases[i].mangled);
+		if (!buf) {
+			pr_debug("FAILED to demangle: \"%s\"\n \"%s\"\n", test_cases[i].mangled,
+				 test_cases[i].demangled);
+			continue;
+		}
 		if (strcmp(buf, test_cases[i].demangled)) {
 			pr_debug("FAILED: %s: %s != %s\n", test_cases[i].mangled,
 				 buf, test_cases[i].demangled);
-- 
2.49.0.1204.g71687c7c1d-goog

