Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4319E1E9B21
	for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 03:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402806; cv=none; b=U68aiGSnLODOKtqX5J+By/VXc9bvaMK2fZKtZ5l6urGI1XNIv4yi5oIXDx+OBOmlI2ju4xd4iDa6O0jTh/JdMoXN6/QZiHf3T4LBnIVR1LaAL+Fq0DO+7eDouB0TVtEEsl4CXcH0NZeTZTCNiG6BZJIa6BKosX+RRcGENOaaDbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402806; c=relaxed/simple;
	bh=jUc1IY6H9eX9DWwv3dKNMS3/gSoGAX++OjVGeG8jIn4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iWWdX05yNW8r9bIfF5Jko+J4zuO7q7Np5AwPvafT9lgcp9+sOcGy+DVoEl/ygdIIceLmUtZ6ztChTamV39NCufx8qTl0FQKFu5UUVEMA8VAwVMENxAmu6d+mJkJK2ZSHYNKj6s3nzdR8rT5wjRvHH/3dZ4YgFtTGh6/vz0WxfXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lD5O86WR; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lD5O86WR"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30ea0e890ccso3579033a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 20:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748402804; x=1749007604; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nyC4vVVpudJGC7Yei8x1Vk6ZbLyamLbVvLo7R069uYY=;
        b=lD5O86WRpHqfcZyaVVgiXskQv8T8ZiGRk5sS9mrG4eObcMRx/CTF3psZbEikBT9DEz
         MPRtBc32stDM0qkZmmPNVnuuZCQKDVALrHnHpyRyyGnS/Cg9xlyI7SiFHX8mBeN7P+4s
         Srufg0VwJkpzlPnKjvtmTJqBeT5/BohRjPKZeIZy8gj55wnxs/DcQtd5hLDylQelAGEe
         jxYKuC8Llw0Opy2qwBHEyU6b5WHMHrQ15szXJmHcVT1oeQAe7xFo2ba7FLMTB5V48MOj
         5O+3Xgb43kRhcaVqo8yBpW9lRFMDHXh6H2JNQU4QnPFRbPJ752C8eeGat/vC/awp/+Sz
         mj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748402804; x=1749007604;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nyC4vVVpudJGC7Yei8x1Vk6ZbLyamLbVvLo7R069uYY=;
        b=XTOUgAt4+3TtnEh74Nc/2hJq4pJcgSTQe9JzvSQ6dULFkQ90RIYGP+gAjAY4d14f44
         6nLoi9woUWSbT9oe6baSlCP3jGVW4jceLdKqpF/XFmXll8N4oIFYkc1CEIo8rMj+aIwS
         P7J/9wHIi4G8csqnL3UOqDS6PLmZaLAtrT/kmslRkCRO43XN2I+Bpmd/6gamPL0/d67c
         tqis1ofXEpkaRauYVSh4WeoryQElpWQqAUU1rKePVbUEtiDiYKrkUUGZ9BRWqQTGECVh
         /kra9MFwdFF0jrHKPycHiefvGKWp31FvAvQjWcAp+U24xlSSCTlizVoVETeaqBu9oaOr
         Lwjg==
X-Forwarded-Encrypted: i=1; AJvYcCUkd0VuWTMu1AR2OmcdiHIrzNkLmpPCbDfiNhCql4hfiQ4n1tuaCeJQjQX0Hzf8p03MX3uiFI9L8BDtCOFJ60nC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+coWJYZZ66e02gGMxwXZJxBZlHMjDOhTEE26xsr9TLdnS5GTE
	/9iTooZT60TFM3d3HoGxgShH0cR3Mf4BUJBL95at4w8U/LefaTkPdrbJBSM3CPZOmduloJD372j
	/SojeukzK+w==
X-Google-Smtp-Source: AGHT+IHsmZ9V8XQOmtKGv1In/BlcAjGYP1GDQLFYIWoxLijfD7JzDEKYuwg9FA+tOrPj5A3tH4xiTqileuFx
X-Received: from pjbns20.prod.google.com ([2002:a17:90b:2514:b0:311:be10:7246])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:39cc:b0:311:d05c:936
 with SMTP id 98e67ed59e1d1-311d05c0abbmr4775310a91.17.1748402804546; Tue, 27
 May 2025 20:26:44 -0700 (PDT)
Date: Tue, 27 May 2025 20:26:32 -0700
In-Reply-To: <20250528032637.198960-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250528032637.198960-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1238.gf8c92423fb-goog
Message-ID: <20250528032637.198960-3-irogers@google.com>
Subject: [PATCH v2 2/7] perf test demangle-java: Don't segv if demangling fails
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
2.49.0.1238.gf8c92423fb-goog

