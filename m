Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794008756;
	b=TwsCyTIAG10k7rGUWbPWQbDcMKQcab0QxS0vp5mngaoaqnvuROd6JgOmUzA8qojccheA
	 HYy1/DZolDbb/Pwo5Qf73DCRcrcANNFCru7Yrc1qFi9q5I24evkFfbxhkvVOZyPFScyUA
	 omxC5A+Fz/Ra64WyueVryDMojQFNM5rhlpmlV4CCV8N3DPX4EpnTlxg3x+e4pHOB5uU7M
	 X5uFTb1+B3aoDnPLcU+AAm7qdhE0wT3obW/dcZvHcs8D7ZvN04CT6JmRVxwJ8HC02bDob
	 luXQ0oXzzjMYQ/D8TSnur530nWP6sZtI6JMdErwNopBjiMyY9Y8B5PaMC9nCNijzORw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794008756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MhHGkTaEbydCxyY9SDqSj3oHzv+5SX+XHoiBwpfap0o=;
	b=nEEnqf5WtJUC5nqkDDeg18mCw5JBBrneGnG29r/HZ07EC2Qlud6IVKSBIJ4dR2U/7pdj
	 CAfO6UZiniPNPpTtJhTXv6QWV76FEWmwA7glxPNjDzsBMrtZ5RX1r8BeNrT7yD2q9p7Wq
	 n3E4Jey/q8i0nUR3l7l9KBzuRj5kea4kZwUxM0T/nwqFvZQgVY47/kKsHHlyh9QWId9Jm
	 tbdkgDhdCC+Ylyr30thtiN4i1J6duqWjUXLvka2/97hEDXxZivZT9/tcJBi0S+Ssr82Vl
	 RstRkpoWCLK1Xa1Y12EfcyVT/Dya/X0DrpnO1z6nIDv3PySbDm1KkQreK4GwNLlEJHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LgmCNSc0;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7B5606A32D
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 23:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C7B5606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LgmCNSc0
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b09a65c76dso1003323a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 15:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794008755; x=1794613555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MhHGkTaEbydCxyY9SDqSj3oHzv+5SX+XHoiBwpfap0o=;
        b=LgmCNSc0ZP7OCBFSx1oQ7UrzGDI/kgVRawRPNOAcNFCk2o1h9JTdAiwth7Ae/vJDRR
         ZQ3Hgzw92KMNVOWX2hNDXisE3FWQkxo6hx8x9GuL86uOXuIHc1BKOKEqWg0j1OvmVKUn
         elW5r6p0bo93EGTZnZtC4eMQ1P40c+EKh0Z25lVytxMdvQ78Bm5yDW2XOoZxkvnYLe88
         oCztE+GYfpoAVd2y4imyuV8j7ilNO6KarcGGW4Cq1+qOKZ+z/TFydemQgvyI3gCDRkoz
         isPj2dHoP3eALDL/S3XGyUsit3Itexrww8et+k/uAWx4KXAkLXXTbLUIZFTGAEfMHVWJ
         2bKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794008755; x=1794613555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MhHGkTaEbydCxyY9SDqSj3oHzv+5SX+XHoiBwpfap0o=;
        b=g+mXTTlpCoMgrrsI/Z6R/xVbfhKLuYA42sKuJuasqxFI1SiIDAHXVQwQ57t7dRsGaa
         XiyvnhfYMmccQiixSKss4mJzyw8OTLIgsu2vPdv83udnBnmnYdPYeSw1IpNKQ4Qporf+
         vEgmfuBHocb14g7dmh9d6H4gTOuINbPjGb/4j9jGIBvVerflPKIWV+J7mwL6plHhKMUV
         TIOG6m568IsDDkY74OkkVDifs4/yFUFgZMo1aCdVVcBsq4/lBC8j/ei3JMN9lGicQRzy
         yMBSzJSynJYdS+0ZqbEVXTN3AC/oFLYydFRrTibFleo1kFlH9v5afNo3QjGLEm1be8O1
         FCdQ==
X-Forwarded-Encrypted: i=1; AL+hErFQ1oViengIV6acou1FIEhTPKycpbv80ML0zgRq966DlcmxUl807+9LwA4zKQ7bjr7OlKeqvOyVCR1mGvznrRji@vger.kernel.org
X-Gm-Message-State: APuU4Z99S8/rSbbHr4v24fqrUanwky7e7Oc6do8uGnXb/+8OTt5VAOfe
	YHUftjFTLWLTD0AeU+OnB/yz7WI3xxoeRhNodDqQVXqroLLHVmY4S58s
X-Gm-Gg: AYBFou2jJhTJIEhoEaK1HU9hh3kEqJ3QCP8kAOMzq2hjBh6q9ZEmN+go4J7f6/+xnpj
	61tgIFbIdsIfL7PLTkxh5ShYde3nrHUMRrjNlOuW4+T/3HBNMtptWYNkvXzZC0Czcp4khsx08gY
	A9fbyt1uubi/9TG3ocVb7ZPoCUzovJaM2M9RirTF6bsRCWwblkZW+OSkPeBSnR/knts4kxviqvc
	3nMuriWU73qhZPNmzNSYC3F9uqiEn+9RGjTy1zURJOetXCm6EqwLTAWhPXZs35l/OPSTZl2bTYU
	Ff7y0lHUgKeh/xGvKiZustHz80Y9aj9j+oMbA5r8HEICKPg28fWxdNV4CTiRmQyJkG5f30BeoO9
	iFCjBhMjMQs4JT4Rzzfc+bksKyGsJFqH+zINKFcZE3dZQmzQh8y4xL8l8Y0Dn+Svz8Itowv8HHc
	lzlM/SKjMmgeUEZrbnVkqkrkXjnmxxMhypgdmzf8fp3eP7dhRzARI3T9pFK6ehBIesJ+xYIhZJf
	mrQGLLSo/8RcoHakWVJAr9nHxwcOjbkqrOjSARYpIDjgALEFOszGBb75xQANTr3cR7scRl9xyRW
	uPX28lWISzy1BV6NtHFAWDiZARTARMOkBM5ftpfx5A==
X-Received: by 2002:a17:90a:e708:b0:3b0:9162:948e with SMTP id 98e67ed59e1d1-3b0db6d3fc1mr3846365a91.27.1794008754637;
        Fri, 06 Nov 2026 15:45:54 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1057c3db1sm796145a91.4.2026.11.06.15.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 15:45:54 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH] arm64: perf: Fix the userspace counter example link
Date: Fri,  6 Nov 2026 23:45:51 +0000
Message-ID: <20261106234551.1474417-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
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
tools/perf/arch/arm64/tests/, and no commit in the history leading to
this base has added one.

The userspace register access described in this section is covered by
the "User space counter reading of instructions" and "User space
counter reading of cycles" cases in tools/perf/tests/mmap-basic.c.
That file is the only in-tree userspace test that walks the core PMUs,
pins the test task to each PMU's CPUs, and selects the PMU by its type
number when the kernel accepts the extended type.

perf test -v user runs the four cases in that file; the two reading
cases ask for user access through config1.

Point the text and the link target at that file.

make htmldocs does not fetch external links, so a plain documentation
build does not report it, but make linkcheckdocs does.  I checked that
the old link target returns 404 and the new one returns 200.  No kernel
was built.

The edit and this changelog were written with the help of an LLM
assistant (Hermes Agent).  I reviewed the diff and the reasoning, and I
am responsible for the submission.

Fixes: aa1005d15d2a ("Documentation: arm64: Document PMU counters access from userspace")
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 Documentation/arch/arm64/perf.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/arch/arm64/perf.rst b/Documentation/arch/arm64/perf.rst
index 997fd716b82f..236cb5da425a 100644
--- a/Documentation/arch/arm64/perf.rst
+++ b/Documentation/arch/arm64/perf.rst
@@ -140,9 +140,9 @@ only be enabled when the tasks are pinned to a homogeneous subset of cores and
 the corresponding PMU instance is opened by specifying the 'type' attribute.
 The use of generic event types is not supported in this case.
 
-Have a look at `tools/perf/arch/arm64/tests/user-events.c`_ for an example. It
-can be run using the perf tool to check that the access to the registers works
-correctly from userspace:
+Have a look at `tools/perf/tests/mmap-basic.c`_ for an example. The two
+'User space counter reading' tests in it can be run using the perf tool to
+check that the access to the registers works correctly from userspace:
 
 .. code-block:: sh
 
@@ -160,8 +160,8 @@ userspace must treat the upper 32-bits read from the counter as UNKNOWN. The
 and should be used to mask the upper bits as needed.
 
 .. Links
-.. _tools/perf/arch/arm64/tests/user-events.c:
-   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/arch/arm64/tests/user-events.c
+.. _tools/perf/tests/mmap-basic.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/tests/mmap-basic.c
 .. _tools/lib/perf/tests/test-evsel.c:
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/perf/tests/test-evsel.c
 

base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee
-- 
2.53.0

