Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893769;
	b=p/lL3gLFMTsQiPoUty641ELeYokIhQEXNClxQjD6ESDCuPO49MbAJiVE80nVQW4rGIoF
	 Pou+CL6rySiv85WMM9amc8uc/rCj/vHirObDrkOO2njjmULnW9volVkrSVci25/6jOMoG
	 BgYmaphw2Ep4yVvaebJV+fLoj99ob8q8bm1pBbQMoWg0EKP+hTSKk2XDzjY2llOwEvJRV
	 ZK4n0iHbtCPb8lRlV4WQPpW8BoGKxaTg0V9C86iyEnO0vWIVpyihjR7CV38ju0Flf56BO
	 5sX7aa4hJSqWPWbO3oaNytCCGTn33+gXcutl7FLOVrCg2Zbm7876y+qVTVrNUUAChkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=PzGMliZ3WOBYHJV/Xe0iatQI3eyl/QNxFOq3R+DZ0B4=;
	b=Ogf7QETZOTyS1oqD4kBy6rwhxxRkt99fUrXCdCHUJDzVnolmPW7qUO9u3u4n698QFU7/
	 HonPnje5acIqN/p33ujCcF1s+HzVjByfS/F4K/MyU+UcOwUrNNp2oGVDA2uRJIxelOoqe
	 c/zKTADy1rLviR/JQ6uMRz+SVSi6CvD/bkEJVl2MN5cyLJ4IWxVgGJMsdumkZURSCiAqo
	 FUoUDmzDPA+kvyIxJKR3BUe7yuqk53EroU4qlNB0u5H0gtQRxoPHuf1cWgufvZHabWeeT
	 xt3mTAu6+yHjAPlzUQbq4X2GE2pDfk7RT2zYEBTvmivKuY53danrvK6NnW8QDY3e9Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JLyFB9GI;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687886083636
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 15:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 687886083636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JLyFB9GI
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-490d59c3edaso612284f8f.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 07:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793893763; x=1794498563; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PzGMliZ3WOBYHJV/Xe0iatQI3eyl/QNxFOq3R+DZ0B4=;
        b=JLyFB9GI5TTRlzsZIeifx4bcrVYPEh2xsT3YFffJH3lsGPu5e1kLggA134dYv3TBc3
         xPsXICZJkcYWt/NeuF5DDaBUToOSLqWkv3B1JsEExGF62PJqNPejV8d+VAQ9DuD5V5IW
         cekPB4x45m+CWeNEbHX0n0sWJof+TjK8I6IfHo0o+vb6fDFF+78KfhDEyxTfYAD9w6Zm
         Sg6vdYrUwIMKJmmrHAQoPkiw3Ex+MgoUjbtUEitSsCzrq4zxvx9C0neO5IBYEk3OlVWa
         d3jeqWyfL5AHePAm9Xyx24PKPKIy5Y6l4TYydwjqMPXbZTa8ZW3JpK7SgHBBp5wMgVe+
         sHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793893763; x=1794498563;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PzGMliZ3WOBYHJV/Xe0iatQI3eyl/QNxFOq3R+DZ0B4=;
        b=KQFDHXiVqPHbH3PWR7MPD+zXYO1MM4oAkzeGwYA6VCS0NJ56vj5frmHgzpsAtyq/Hl
         bdPmOn/qR4SX5juPyxdO3sfXkQPSrwy+/fW7TADB0jd+n9xieVzo3w7l0FjJNyRs5BUC
         PCveRBK/8hju+ac3FJT1YgKkjGjHB++rg2fgOckNYanPmLOBReTuOyi2NElrphZfgefb
         NVkzEjdlQt033Y9iMWzm37POBIOUB2KLzw1c69or9EKtKMTvx7SCrqql4wh4VLhBs68L
         FR4GB/8sVW87iDb4u8MeBg8MwM64rRWgfMFcsYqfAs4TUKLAqtKJ61ZdTklb5GNbjoMY
         hIVg==
X-Forwarded-Encrypted: i=1; AKwUvBxSiIQ5dxB9AmeSkHpmbzQRGaw/f3mP4lZveOhW1iNGX0TtugwWmI9bMS4UUVPUvYsZEn4CGL36kAmbM4MRvAN7@vger.kernel.org
X-Gm-Message-State: APuU4Z9TOEUGxLHfZRawAGTt1ttbKZVrWuSM9kmCOvC9/3odRU9BV9MO
	0q2VqAon7kdvpC/hqB3qYFeRU1mkBU51VzOps/tHW65dRE5kjx1xycXXREgF6O5WRbo=
X-Gm-Gg: AYBFou2YcEFHBAYRslv73xIUU72jVNnarhgjWlPDnB7K3UOiak3lFxlcGtJpLHTZXMy
	wE8DF4+JvR+O2gAkIvw/bfefz+urLqt0KPSx6zVfcebI/8PRCkNR60XWETRKi28NFhTHRpq+Yv7
	uAaRz751jdZ4y/Ln6HOugJU4o7+5trlU21lgqdhulNakMdOgZIG4fNC04wuI3w3WYcnRanNVTIo
	xxcv33hn9SKqKAFakEekwxxkB6JS3Tk9HOvCeXNYvwQSHjbm7SotE7Jox8d/qBHK25ZTVaOfgbh
	iEsfGxZ98ESp4kLigy75SKIWwXiiayLT/m8yEKh/ZUy2V1C0m/34Rq9FPZ5Dn5IwzQ94sFAIlBa
	/RKS12O+TspRzcSWfR7KlCZCMsGees72r+XZFoLxeLAO4DkrGXwHJH+UptNQuwxn86blKEm0Lfg
	udOk8jpw7w4sQ2YTRMk/7gXXkway8ET9cb9i/QbKhWJThqMJGWSStcYDeceSJwPT4BylaRY7SRM
	xl5m+Uo7w4E0Yh5KChk+YjQUEQhtcLEd8TbZi/fuQvvKsc5oGWmf91vO7TqxYluYJMndVwVrSCv
	GdpjoxL/79WK7Un6hd/Jnq2trZq5X+uo
X-Received: by 2002:a05:6000:2486:b0:492:3f98:5070 with SMTP id ffacd0b85a97d-4923f985212mr1557909f8f.12.1793893762839;
        Thu, 05 Nov 2026 07:49:22 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec9cd40csm10650462f8f.13.2026.11.05.07.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:49:22 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/4] perf tools: LLVM dwarf and flaky test fixes
Date: Thu, 05 Nov 2026 15:49:02 +0000
Message-Id: <20261105-james-perf-test-fixes-v1-0-0b279bee5830@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG6l7GoC/yXM0QqCQBCF4VeRuW7A2dKgV4kuNj1bI2Sys0Ygv
 nuTXn4c/rOQISuMLtVCGR81fY8OOVTUPeP4AGvvplCHVqQ+8RBfMJ6QExdY4aRfdzqH0DbNUXq
 J5O2UsQ2eXm+7bb4P6Mr/jNb1B39v2WF5AAAA
X-Change-ID: 20261104-james-perf-test-fixes-f72265531d1a
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jakub Brnak <jbrnak@redhat.com>, 
 Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Running the tests on an LLVM build results in some dwarf issues that
need fixing. And there is an easy fix for some flakiness caused when
tests are run in parallel.

Assisted by Claude Opus 5.5

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (4):
      perf libdw: Find the CU by iterating all CUs when aranges are missing
      perf dwarf-aux: Support DW_OP_addrx locations for global variables
      perf test probe_vfs_getname: Fix missing debuginfo detection
      perf test: Don't starve per-process tests with system-wide events

 tools/perf/tests/shell/lib/probe_vfs_getname.sh |  3 +-
 tools/perf/tests/shell/record.sh                |  6 +--
 tools/perf/tests/shell/record_lbr.sh            |  2 +-
 tools/perf/tests/shell/record_sideband.sh       |  4 +-
 tools/perf/util/annotate-data.c                 | 27 +---------
 tools/perf/util/dwarf-aux.c                     | 70 ++++++++++++++++++++++---
 tools/perf/util/dwarf-aux.h                     |  3 ++
 tools/perf/util/libdw.c                         | 19 +++----
 8 files changed, 86 insertions(+), 48 deletions(-)
---
base-commit: 29fd95dbd25cda35ac1e38d096a85809e952274b
change-id: 20261104-james-perf-test-fixes-f72265531d1a

Best regards,
--  
James Clark <james.clark@linaro.org>

