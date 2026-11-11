Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364555;
	b=t8jdOGJW15sUVCOJCOPxGOaDsqN0algwguJEWabY0JQjSz6XRJwiWWVmkM99WrnXXzEt
	 U6elIUYDKy+HWoqNvygg+FP1/m1z6/QNObH7UvO9//v0V1VstXKvC4qyXqrlMNQ9Q2Uam
	 p+AouD4UO9yzBGSl/9SUUPfdQp8ZCd5aJY1o+n682bsv6Y4fGwQtcmw6+fSxfbLlqdiSX
	 aLNjsgwZCb7HRYlYSvSl40bD9PBw6zU4pWQXNaYyUlgi8I2rJlbA5+Wdg0rHc1IuQfvEc
	 0JsCU549Lm6Bxh/3Yxa/uNEz/A4VEROzAla3owSCV7+AyzcKgj6ez7J31p6lAegobNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364555;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6zeVpQQIPxzRW921jNzANvtYeiWb1Rf7rLm7zqTskZk=;
	b=fJ1JNfMFolguA+Zfm8vqeah+2WhLPH8i69t4r84nUaZiDkaAP0QcLwdMAOmIeJjz7X6a
	 Be94FPW0KZE/1S/YkSvkmB1DLRAqGF9bpC1K8dZYDSXajK+6zHbSZlJQeX3VzZVa8RQxk
	 WYe3bfti5KpvWNAmVrN+47vvIf+BVl8H3oDUqR1Mccf504Mq4v/D18dooQbroKRSxxqqA
	 eBLk8QgWOHapNFl89f7VO4Nh7Ng23m+10Jr9k4UAarS+QLDtcaxkPlmSxVVLtFmf8LTyJ
	 mqBczzoJCZPyTh8SgL2AfrwiEsPlw11cEanDk40UunG3qPhtW95l2/ZT/NTai2oAYSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kdpO8OlD;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE0A606A321
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 02:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEE0A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kdpO8OlD
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so5373288eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 18:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794364554; x=1794969354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6zeVpQQIPxzRW921jNzANvtYeiWb1Rf7rLm7zqTskZk=;
        b=kdpO8OlDuqFGxJ6pYbm8Eaa90beQ0xoCFDd3zMa/4VEP+NaHxsAXkHAvgi28M/RDnF
         RAMYOXkE952mBG90pGuP/RY8/psMI/ddWvyJAzpCX3fLPcN/Ogr7/MzO5OYCLiaKOkrq
         pkr1abSKO9yLHD34ENOIJS668yBBCud4Ynmo0/7go9ggpgfrBYoAJWpevHj1NajYfiBV
         Ve2p5Zt5IdMTPTypm8YgI1HO6FrmFSPyR7COQbjw1G5jr3bRVjril9MOilyETwxtzBy0
         4KOEc+B3e0GTJiNasFdeX18tbLmKUu9CXgg6/olRgTsP+AJ8fDZvTFcocQOJuCv+EaNB
         p9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794364554; x=1794969354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6zeVpQQIPxzRW921jNzANvtYeiWb1Rf7rLm7zqTskZk=;
        b=S8DZB4NtUnL+xiCPL+x01avB1dsVOPqerMoeqqIl7ZZaCuy1YDgb90uhvzz1dcjSzm
         wYZBz2j9eB2kdCA0F8iKRUelJmrIAAXVe/91UI452y1KigM1kFq90vEOsKBt38aBspYL
         HUqn6u/oBqg9YArPdR+GLOL/z7MlY133dNezAU7G4nc8haVk+NdUgJTYHbZe3kEClogq
         N6e9ECRlsiwiuuDTPIQ2D/XJ1zgHQ3Zk5l97fYq42PZ715u3nVe2CLCP3PHl70luzWVS
         FYSDDAxggz+o2Ij7fDuQpLAsdVr+xK1UAmqcWLBlGC6RcpcOrDHcd0berGuG3srjOcFf
         Bp8Q==
X-Forwarded-Encrypted: i=1; AL+hErEhsoWjjFOxLDn2zhl9MCV1lUyCa0mfWL1wa8VjdB7VUYUytXy3+btcMHiQSCSg+OcDf/0mjkMgt5FjkBy++4RI@vger.kernel.org
X-Gm-Message-State: APuU4Z/0Jxq5Uy8Zu/1CeZEJsmIBsjoXg2+IoZR/JbwqPS8cWacpmb+6
	XIJGIbTudtbpY/qtxSm+SrTaVTrdPzkSqMIzU/vINa0QNxFzhHmDFDgu
X-Gm-Gg: AYBFou0IQZUhImBXuQvVG9ofHytts31uyvzKNitVCO7BIZP8cazaWLie3mEMiMxEMre
	T24xcHzL79rzBId3CBYLC/7yb6Za678UPiTGvioiUbCLeNpQ6YR9CAGCaIYjbrEHnlXjvAk3XLv
	bQqZ2CEZFNVvVIl3yBtfyseHmECnspNv8mv3WTxb5/YV5F7DTvHWDAm/XKs2Gd3AqW5zNGuJI0G
	2gPV1TeTuw4n5/a7bL6Md4uQMNmd1Bs7KSG7YIhOA8joRwu7jaRlKG7dXk396qwLzpXBHYIzpRN
	S2J6PAo+j/RTtz6WHq7eYZCfh+9Z6zcVBmTTtAXqpZeuIPjBSU/EJyP6fNrtl7acPEgJYNiQ+v+
	SVZmGM7FU5+kgovzO3HVtKtDja9Lr4aCpxdVphIaP3qCKx/iQxEBzqWz6NIwTjTTQQB/1clhi/P
	WH/3NbkYX2nmQiRyfTjjZwWHQA3K+U1l30jspPLlRAODqQ3fteQepxHNVb7PhRGiJN3gsR4D9WV
	wdQ9wjrd8B0eo6/IUZ7ywnm7AuKl7hhn8Jb+ZWlM2h2BnC7IwZ1vA6qciQEXkY4QoIVQqVCuHtq
	q7WuYK9EduGY2pRWRi+a
X-Received: by 2002:a05:7300:1486:b0:376:feb:2df3 with SMTP id 5a478bee46e88-376861801e9mr2280854eec.20.1794364553911;
        Tue, 10 Nov 2026 18:35:53 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bfb58dsm20493219eec.18.2026.11.10.18.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 18:35:53 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v2] arm64: perf: Drop the example the userspace counter section points at
Date: Wed, 11 Nov 2026 02:35:50 +0000
Message-ID: <20261111023550.1971639-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106234551.1474417-1-takano32@gmail.com>
References: <20261106234551.1474417-1-takano32@gmail.com>
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
target, but the file does not exist: no file of that name is in
tools/perf/arch/arm64/tests/, and no commit in the history leading to this
base has added one.

The section already describes how to use the libperf helpers and points at
tools/lib/perf/tests/test-evsel.c as the example, so the sentence that
sends the reader elsewhere is redundant. Remove it and the link target
rather than pointing at another test, and move the instruction for running
the example into the How-to section, next to the reference it belongs to.

v1 pointed the reference at tools/perf/tests/mmap-basic.c. The review said
that file is a confusing example and that the section above already covers
the how-to, which is what this version does.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
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
 

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.53.0

