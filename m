Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEF0215F5C
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Feb 2026 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770553370; cv=none; b=GpbyFICeiwoD3ZQX5nyxmnX/7Vvv/+42e5yRCRR2JtHyEJS4hQRrSVBS3YN5iycTLsIpxEEfjhSs+JRiY79t85k4RtdZMpGGw6RyfebsBmUr4pPFRY4gM0OflGBBU6fNx2/QQwJqYcEhs/I6dZ+pUtodLFd8Y5LVtcQniIj06uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770553370; c=relaxed/simple;
	bh=/m9tesA7qDwNs+gTiVoRyLuuZj/IH/8c7/P/vQCp3E0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AMBGj2DKb9hrf2wFOH0NLotSwKv8qiy33rzBJg8KH0LrrOJGOMFkxIyoFjrnNK86x4rpI+rSMnR9YpuZjJ8lyXDjfSXCNtQEJk8120tyhOuTimXy2TqC6Pnxv3ibJEa4AawBcmJWnRElXyA0b64z23pQ8fda4ENsgxyu8dTuxdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQ6fN+J4; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQ6fN+J4"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b9dfc146fso5528759a12.0
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Feb 2026 04:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770553369; x=1771158169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S2DMo+8YZo7GYuhFe4EugWrXd+pHtT3uV5wQt5vaWuQ=;
        b=hQ6fN+J47wK/vhNpfxEtxIRrO8F3TebE1t8ZSFjZO1YFUJuVWq5qdJYqZ5I3Wh3kSS
         VnzjTrQ5eozrpf3H1hu2j+AtZ352uXCjvG9fIJN/408An71oKLxMqmn1l/Ajx7sRCp6x
         rEdGCMLdCcvB/oLAhSTz4CfXKQX+/hcNplsRs41rHJ7mBjWh6ZGpS3HAUtKmI0MLqekc
         VVKz+QX+Yd2/exbXYsuZc+nbtMGZnC+W5JvEhE88y3Y0I3Bs3MYCEc43jG9uppwCOtcX
         xk6AcCjYJmS6EixDjX1km3KdzuqOCVj7FemVR7sycuXWkBY5TKVtXszcrXalVTQVkFBK
         UXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770553369; x=1771158169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2DMo+8YZo7GYuhFe4EugWrXd+pHtT3uV5wQt5vaWuQ=;
        b=B+N7/HxvrqINISJhftw0GTy3KxqrZ/UFDT1wIlj97V5uRO7+1QLtq+DMGBfni0T+vA
         NwNmvfTwx+TUcgR/gT/qXtGhIEqcdHyE3ZED62a3nhm3O//dDbDloYYzJAZCofubXdSl
         MOMSVSmMXSJmuXjVQ7/7OnIs3Vkynte9gwubzYrh9IyO3wKNgEbvM4SH9SRbTmLKsSn0
         yZDoWUVT9DvmQCyCf5dvriJ0VqbF+KCvrkDis+MoJqBI0FxxNpSHD/TdmTdhL4K9P0ue
         8rU3Vv5pp1KTwgOg0BWd2vLDzMfU69ufUB33NSyTxtOcCud/PkeG+AmsURJlGGeiWDDG
         iFWg==
X-Gm-Message-State: AOJu0Yz4JvUh3U0ez66ezwzTyu+nrpT/GQf20vhKWQzh13Bz5VbY3W8C
	4+dHWS2+lIGMUizuVBoA1DeUhVBOiTefV4mK55UpOlpBI0PoBzaYBwED0991Zg==
X-Gm-Gg: AZuq6aIsNXSLAJePBtROrec8qVfO5fGoX/fVPo4XgW8oYQOxfK8EibDsV6zDsVyeHJ3
	luTsM/5r3M4uqCB9emycifPTc7iPIDOlO4keD+eX5SdqS1FEae9JluHmaLYXG24Jqq9NPkOFvvh
	Q4LNZE5OQojf/CulHdEvyXFNkvm2XF0RH4xjNL+rYKrKDRfOwUtdViQB++u25mvODUG/TuFWxd6
	ktUdTztVsAxS9yNtQqQT7bossYFgTeYjDCgGKL0DP4I42b+nq9ilhpEo3o6hLZ7kYKUZwchAhiF
	RHw6PLFPNGr1Sx6nTzBHSR0VpzhAzyQXcXvIsWCSD+nlz1/sRF83nD/QtrgsZLRUKpEBdaVM/4s
	OvlSMjDqlh2iwxnOQC3SankgumYsx84eT0BECbxpETxgp8QzrQS44BgMU5Tca3YsNha0KulP1Ia
	wjcdwjUZoQBqgRrlGu6XOlsbs4khRWQnd5umapQzpJVBMNsaWn52zHmVcC8X9mGiPQURptq5eqQ
	tQvhPK9mIZkWOn4Ouac6XfeGFcjLg==
X-Received: by 2002:a05:6402:a21c:10b0:658:218b:1bf8 with SMTP id 4fb4d7f45d1cf-65962a57043mr5263640a12.8.1770553368757;
        Sun, 08 Feb 2026 04:22:48 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.local (dslb-002-207-075-089.002.207.pools.vodafone-ip.de. [2.207.75.89])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65984024e11sm2011658a12.32.2026.02.08.04.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 04:22:47 -0800 (PST)
From: Dmitrii Dolgov <9erthalion6@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [RFC PATCH v2 0/4] Test annotate with data type profiling
Date: Sun,  8 Feb 2026 13:22:22 +0100
Message-ID: <20260208122227.3524-1-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add shell tests for data type profiling, including C and rust.

To support the rust test, a new workload with rust code was introduced.
To build it only when rust is actually available, also add a feature
test for rust compiler and guard everything behind it.

Changes in v2:
- Switched to use mem record.
- Fixed the build issue with a custom output.
- Separated patches for the workload and tests.
- Added new test for C code.
- Added a feature test for rust compiler.

Dmitrii Dolgov (4):
  tools/build: Add a feature test for rust compiler
  perf test workload: Add code_with_type test workload
  perf tests: Test annotate with data type profiling and rust
  perf tests: Test annotate with data type profiling and C

 tools/build/Makefile.build                    | 14 ++++
 tools/build/Makefile.feature                  |  6 +-
 tools/build/feature/Makefile                  |  7 ++
 tools/build/feature/test-rust.rs              |  4 +
 tools/perf/Makefile.config                    | 11 +++
 tools/perf/Makefile.perf                      |  2 +-
 tools/perf/builtin-check.c                    |  1 +
 tools/perf/tests/builtin-test.c               |  4 +
 tools/perf/tests/shell/data_type_profiling.sh | 84 +++++++++++++++++++
 tools/perf/tests/tests.h                      |  4 +
 tools/perf/tests/workloads/Build              |  5 ++
 tools/perf/tests/workloads/code_with_type.c   | 46 ++++++++++
 tools/perf/tests/workloads/code_with_type.rs  | 23 +++++
 tools/scripts/Makefile.include                |  2 +
 14 files changed, 210 insertions(+), 3 deletions(-)
 create mode 100644 tools/build/feature/test-rust.rs
 create mode 100755 tools/perf/tests/shell/data_type_profiling.sh
 create mode 100644 tools/perf/tests/workloads/code_with_type.c
 create mode 100644 tools/perf/tests/workloads/code_with_type.rs


base-commit: 36a1b0061a584430277861fe5d8bd107aef26137
-- 
2.52.0

