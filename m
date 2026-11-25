Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601043;
	b=yi2nAlpcvh7vfpP7Gd0RN11n92SBXHs6bn3p2/jaWChkrU2b9tuOhVkC8ROck9KMMhS1
	 Ghgs9q0KAjEtdHr1L/az68iRU1j4cWjghrOIbOdePPEif5JlEpZm4lV/3rdd5aOzeWLCV
	 Ryl9IwlkDcTm+1xjNDBrgDV44SoVVTR9CJBOgpk7W0GMtUWhGqXsG7dZNogCfurw7q2wC
	 3TJ54c7eOwfjbVYaY7g00f+QkxQS85chXN4glVP1Ej8ogNc8G5mVvwFgmFnJPcib0vEwo
	 fgVjg9diGzoF++h15amFJrlAE/PkWxM+xLkL2arxps8vUbLsUrqVfh4DXg2tOJpXo0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jY9qOc0xWy86TYB23oPhSaWC0qCicnAeytX8EZDNghU=;
	b=DCng99s2fHqNhzdmFrgYOBnafxlHS7IIo8ULRVZEuMzvDVJtj0XpJ2LKIwQJSQAf6dsO
	 srjvrq+QQP4ymkFYrSAALlH5OhpYxYZTR9a9BOcW0hTo/SVOZaHm/ZEiNe8tTnQL5r/8b
	 llmPkurqWccsYK8sOYCzG3/2cMlITASLWCcutd7dFl8ZIl7zrVbyJPBnsViLWD9PH5VWx
	 iderb20dIFX1bUd2RvTLiDHFkGD7WRxQ4EMEO5IhDP7JTHlTFzsL9FFOXdfRYXwLz39xy
	 ryVV//VEoCCS/q33B+CqTKCv9K4KChazTdHN/BkFrTGZJ7Lsk3HVPYZ+HTN1SvWwTKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z6O+preA;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCF0606A32A
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 10:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DCF0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z6O+preA
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-170135e43c7so8517167c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 02:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795601041; x=1796205841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jY9qOc0xWy86TYB23oPhSaWC0qCicnAeytX8EZDNghU=;
        b=z6O+preAdIolvfuN+jX8kUQlDus4PRUpHLxLCJAFY6MqqPHg24PvRv5TNlbtYCjx3N
         l3dmDoHhKMexzrvmzvuONr90yOMj5ZbfQiUWKo5DkAT+o042s71GFCmIpGjNWCFggoPR
         9+LgyLUxOuS0Cmf50jtYFv9aT/jDFyevtyT/RklgIujtUrnnPFjMwAwKSBTTwxYln5WI
         CvJNysUa4auHWQr7KGhzKSxmSGX+wyvYgtJYVcdh9SosiIywyR14z2+wkJGUuJyY3Odw
         OgEQod33oicHWnQpYvA3pb9rg/q3kWc7Fdh29haqAyhh0eIGM8O2o1eFEqE7lYhhUp4K
         0UWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795601041; x=1796205841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jY9qOc0xWy86TYB23oPhSaWC0qCicnAeytX8EZDNghU=;
        b=IgwYFHp3dTMtu2r4hSzdj+QCP5UmKCpyHpi27pYxtqFbKVKFKcgPyhGLOsCgXR1dWS
         LR3xaPm5WRjenbmYZxwlvMPv01uK8nlu6Q14NfkyRSp2ac1fG10lNFQiHpb0gSN/W3yu
         jZ5SzWKNFeaQs3pFchZmtTyVwN3JfD730Uag0vQZXmud2h6lzkM2wXISZfKGePx8MpZl
         dMC8EKY8ljguZy+0hvlbg+57eyPk5hoDVYWLq2or3yCdbfFIYIDA3uwnRN08KDIalG3h
         1l/SiKSJONqpL9XH/Eg3Z4bHUYx1OTzH3Y/61MZbvoOvzvcAaqPmdz16IAcppmxZZsda
         43cw==
X-Forwarded-Encrypted: i=1; AL+hErG09hWWdutVxtORzo82ODU9BMdS95xfQHGJ/2IHjeHWnsFrZNs5frYLmuopxA2MmFtkBmutKODt/ZkU5cuncO75@vger.kernel.org
X-Gm-Message-State: APuU4Z+FDXZsfXjxAev9VKcWjJzxnd2UVJxShAHY78nREF+cfyblTQqw
	P049mEO+pYquUxfaTBYyzCge8+OFY9eFDY07ICVt5e5m3rv7lMNZcVJp
X-Gm-Gg: AZFdTZd7hfhKDE5HBtDrJ+Me+ZqFKkNAvK7UGAaTPvKs3Db9aZvYoeIl+HiDpU/pSk/
	53BOs5kzpnTIEeVtePmhvtXGY+5/92h5jfATMWTwcr+Ljl7/epN7THJHXS2N9UwwK9+O6pIpe2s
	tuqq4zNniKTPm1bfOexKFc1wc4rbBW43ae8m7Nfg8tj21FY+NvEE+WqtcxLi4fQJSgpEvP500g1
	8sklaXIATrJFTGsCVZw+PnRuZcb+62XksSdJAnx5YuGdRPOrc9W1aKpyT3cn0fkFT53Z2AQMR3V
	QxJSrir9SlGKHAHhFuga3qHP/AInA8S0ywEi8wFsjOZFv9Vr7xd4tThBrhqHdSvusBFMS1gveY3
	NvxgPTdvTkVYjBnn5ZMQcm7DK8RyaFuS9Z8xYcHuY8sbWu7LYy6ZWXkX9mtXxmm//HxS5sM7BaC
	HmOm3z7UZ68DN9PNQcdEBOfg2CV3KEx3fgUdWmLtWL5G2WkHF37aIFK2JehWZOieZi43Z0bt67T
	MhJxZj25OK6Qy/RnqlsrPbQrxzTRTBmHGnJYBt71PaBXQdC2RISD/5eC0nxhAiiu041d26M+nj8
	6zoab5Df8FNl0+TSgXIR
X-Received: by 2002:a05:701b:2704:b0:1b5:4f6d:8277 with SMTP id a92af1059eb24-1b5568e78b1mr16762572c88.26.1795601041141;
        Wed, 25 Nov 2026 02:04:01 -0800 (PST)
Received: from a1-free ([2603:c021:8021:f000:0:1865:8c38:18fc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55ff0e4e6sm33863045c88.11.2026.11.25.02.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:04:00 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v4] arm64: perf: Drop the example the userspace counter section points at
Date: Wed, 25 Nov 2026 10:03:57 +0000
Message-ID: <20261125100357.1937729-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111034432.2020955-1-takano32@gmail.com>
References: <20261111034432.2020955-1-takano32@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/arch/arm64/perf.rst points at
tools/perf/arch/arm64/tests/user-events.c, in the text and in the link
target, but that file is not in the tree and no commit in the history
leading to this base has added one.

The section already describes how to use the libperf helpers and points at
tools/lib/perf/tests/test-evsel.c as the example, so the sentence that
sends the reader elsewhere is redundant.  Remove it and the link target
rather than pointing at another test, and give the commands to build and
run that example in the How-to section, next to the reference it belongs
to.

The edit and this changelog were written with the help of an LLM
assistant (Hermes Agent).  I reviewed the diff and the reasoning, and I
am responsible for the submission.

Fixes: aa1005d15d2a ("Documentation: arm64: Document PMU counters access from userspace")
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v2: drop the reference instead of pointing it at another file, and give
    the libperf build and run commands in the How-to section.  The
    perf test -v user step is not moved; it is gone.
v3: drop the v1 review history so the commit log is the change alone.  The
    missing file is stated once.  Raised by Sashiko:
    https://lore.kernel.org/all/sashiko-outbox-208137@kernel.org/
v4: rebased onto v7.4-rc4, with the Fixes tag and the note about the tool
    that wrote this changelog back.  The diff is unchanged from v3:
    https://lore.kernel.org/all/20261111034432.2020955-1-takano32@gmail.com/
    v2 and v3 did not go to linux-arm-kernel; v1 did, and James Clark
    answered it there.

 Documentation/arch/arm64/perf.rst | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/Documentation/arch/arm64/perf.rst b/Documentation/arch/arm64/perf.rst
index 997fd716b82f..5b9cc2aeb642 100644
--- a/Documentation/arch/arm64/perf.rst
+++ b/Documentation/arch/arm64/perf.rst
@@ -131,7 +131,12 @@ changed.
 
 The userspace access is supported in libperf using the perf_evsel__mmap()
 and perf_evsel__read() functions. See `tools/lib/perf/tests/test-evsel.c`_ for
-an example.
+an example, which can be built and run from the source tree:
+
+.. code-block:: sh
+
+  make -C tools/lib/perf make-tests
+  tools/lib/perf/tests-static
 
 About heterogeneous systems
 ---------------------------
@@ -140,14 +145,6 @@ only be enabled when the tasks are pinned to a homogeneous subset of cores and
 the corresponding PMU instance is opened by specifying the 'type' attribute.
 The use of generic event types is not supported in this case.
 
-Have a look at `tools/perf/arch/arm64/tests/user-events.c`_ for an example. It
-can be run using the perf tool to check that the access to the registers works
-correctly from userspace:
-
-.. code-block:: sh
-
-  perf test -v user
-
 About chained events and counter sizes
 --------------------------------------
 The user can request either a 32-bit (config1:0 == 0) or 64-bit (config1:0 == 1)
@@ -160,8 +157,6 @@ userspace must treat the upper 32-bits read from the counter as UNKNOWN. The
 and should be used to mask the upper bits as needed.
 
 .. Links
-.. _tools/perf/arch/arm64/tests/user-events.c:
-   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/arch/arm64/tests/user-events.c
 .. _tools/lib/perf/tests/test-evsel.c:
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/perf/tests/test-evsel.c
 

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.53.0

