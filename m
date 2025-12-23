Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC38346A15
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Dec 2025 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766509256; cv=none; b=Co5MwbmYdjbbmILnINPba9sx6HY+cBMMqSs2ItQcueEJ5oVDrlnlD2zZQRNgSsDQBfj1OoP+9xP4j0gSZrJkNI6Q3yoX4GGhixAoSGQlJF9cy+8V2MWDczu6O1vGhUM2IuN1/uqFVtN1WF0Jmltk+87rG6WdIMj0RXYyxW43QlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766509256; c=relaxed/simple;
	bh=0umdUXyTX5rgSuGain8DW3LGBh7mYqc+EdcYA++gvKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V3faKmmIDiDrxftpfzqrserGbK8OKbbYPefeB48+dHjsUo74/CKE2ehB8Eq17n4coPYYC4xHWA59ZZLtMMC+YlQY35r0KfDRc9Lcem7XUacbEOkh15xURrVoIe2EEOzSWoA5aImpy5Zujr7skXrz1UqtOiYr5CmlhJgaos9O48k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x1XSo8p+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x1XSo8p+"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so38543255e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Dec 2025 09:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766509253; x=1767114053; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMhU1Ise8/cj2uC/iqpEOfTTyoX7j88WyHRNEPk+wjQ=;
        b=x1XSo8p+JwayqQbC81UyMQE+K12s83oCP2hiiPqMHldzuNtCXny2bl3Y/F+xUZ419X
         A/VsUmcPN+Jfe4jijSpzBUWZnPcPgL+sb/GT/gc0b4D4AK8swfl8nk7BiRuFQsgZIiq1
         A1xIidyhaId7rHKXG0l9OM02LX5BiXV16Tovjzdz5nYXKbzyOA5jEj20Fw7w9SM7bg7f
         h66IztXpfm8VTP3ocRnDDH7w0SQBe6LdfZpyklvHXBtsshPNbs2EsHAM40+WnXK2xVG7
         TjLO4vgOWChNRGVOoqU7VZBtFX7nOeszepYm2c7Iv0Po9pqskXMwLviQyIxG03s1Vuxg
         l6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766509253; x=1767114053;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BMhU1Ise8/cj2uC/iqpEOfTTyoX7j88WyHRNEPk+wjQ=;
        b=alKmO+5Evhk3OT/KEM1UrsklNnzsAr49LChRDXCQ6Qlv5xnQrvBAEf7oCmoSFdYf9R
         XOixYQmpjKBJjyNwAHkaRKaZe4sdWa2FwaPtS96fjWSEBUOObsPSNaCIKdk3lCeHrZJ8
         NACyhdNLwTOrsrds0IfYyl+H37hv5FsDlW0xF/sVPTLTIfb7sBoY1QqimB/PwEksTdY/
         VlAsWwQBI4hypDIdTA5NbMAZ2zwbTA/OUbwt9x1eUMn16Ws1C7+yLjOcsb8oajPjx/dK
         6uPAAHmUnziOuWgIVM/tv+pGoVznsW5ivCGBKaMvjo9mFakdNfU4tIaxwl30lNhJH/wM
         Qnxg==
X-Gm-Message-State: AOJu0YyrM9U6TTzXfRjIgOnf4ln9j+mIhUUMm4jJZ6aw/qv1h3Be2GPY
	fUZe8BxfV6814T/SHZY0soJxrG1pm8bzown1YjbpFQR5GnCf3CDJjcbrY6M4UDhwU5+lYO5kv9d
	AP0fsXQc=
X-Gm-Gg: AY/fxX6F8G8LrQ+c3sFxddv99256eRbBDWX/GsFV16+cMxO12k8yAAwby5xVvcxjbeV
	Qll1MCd3YYrMkveoeRsAUAdl0sPbKDzlsfVX7rwpBIBMIOYeCebAIWmjZMnGiOuiL8eTTpXhaNr
	5i3g6m3zO+S3Ns5NxL9bWxEL2viRlo8PP0g/+H5w18II+xjiB3SgigWnBywFNQGhEk2HNETdFNP
	uMX4tZ6wmetykosYrh6Np1azN60+xgc8JaP+hFyBaECBiKySENWWG31QO1y5PIWajBDa7l+09ru
	ZyXjALwugRGLAAoZlcD92x7/LdTSpervFVy5McJGjTSQdR/LL/NbDYGPg0FRBGDdOMwtVmQ9B7k
	zzIjqYOf6vJ3wG8D80wO1pC5Cqo3BnjDk7k0MI7/EotOwPFsCV639n5a+g2cPK3dUX8U5OntGpS
	TfkPJPHRCYxbSzt/x+Ql6x
X-Google-Smtp-Source: AGHT+IEmXyr4Uj9u2sWEA01aAu2FLZncuAO3EyjxyoVdSQ4fiNDLouXhbcKF21puEyCjFiiIWbg4AQ==
X-Received: by 2002:a05:600c:8b11:b0:477:55ce:f3bc with SMTP id 5b1f17b1804b1-47d2d273515mr83353075e9.19.1766509252601;
        Tue, 23 Dec 2025 09:00:52 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aef7sm28895137f8f.7.2025.12.23.09.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 09:00:52 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Tue, 23 Dec 2025 17:00:28 +0000
Subject: [PATCH 5/5] perf build: Skip nondistro build test if libbfd is old
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-james-libbfd-feat-check-v1-5-0e901ba32ed9@linaro.org>
References: <20251223-james-libbfd-feat-check-v1-0-0e901ba32ed9@linaro.org>
In-Reply-To: <20251223-james-libbfd-feat-check-v1-0-0e901ba32ed9@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Leo Yan <leo.yan@arm.com>, 
 Justin Stitt <justinstitt@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Non distro builds now require a new version of libbfd, so skip the test
if the library is too old.

The grep test isn't a strong as the feature test in
test-libbfd-threadsafe.c, but there seems to be precedent for feature
testing this way here and it's good enough for the build-test rule. If
the function exists but returns an error it will be picked up by the
feature test when attempting the build.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/make | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 6641701e4828..36411b4b6d2b 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -124,6 +124,9 @@ make_minimal        += NO_LIBDW_DWARF_UNWIND=1 NO_LIBBPF=1
 make_minimal        += NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
 make_minimal        += NO_LIBCAP=1 NO_CAPSTONE=1
 
+# binutils 2_42 and newer have bfd_thread_init()
+new_libbfd := $(shell echo '#include <bfd.h>' | $(CC) -E -x c - | grep bfd_thread_init)
+
 # $(run) contains all available tests
 run := make_pure
 # Targets 'clean all' can be run together only through top level
@@ -137,7 +140,9 @@ MAKE_F := $(MAKE) -f $(MK)
 endif
 run += make_python_perf_so
 run += make_debug
+ifneq ($(new_libbfd),)
 run += make_nondistro
+endif
 run += make_extra_tests
 run += make_jevents_all
 run += make_no_bpf_skel

-- 
2.34.1

