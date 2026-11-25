Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630157;
	b=A40fw+1mgIUZPbUk/ex8BPj16NohjsxDMe76DuDzx0gs9LOU3YOzIPymseUgpynMT4DZ
	 G1m+yARmlX2qQ8+EzFzDiEGo06B43BeYVy9nq5UvrOmvaldCq+Rxjhs/jBbUoFkmtvGFs
	 ntfm+00hoA96KfzGvflUsQkjmYDzhGh79d6Q3+iL1IAxR3WchSahH5HAhWygK2DRkY4pm
	 BP35Nc547kIXRR7QkhO6/tuMgmtdHrF2SNA+ToWFQHYL5G6WftejIPUHP6vUZmL1Www1r
	 +m8R1XsYGZi2+LqSC6IyT+ftYJusvSNM540IMWLYOuyxkUGvP9fwWUdx/7FQnmOPuig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=n8n5tDJ1QOqDEhRtmlicy55Rb8TPjcq3KM03nYmFhZc=;
	b=jezBKz/IROp7MbG2IEtCm8F2DOx1V2Q63jWd+I9dALSXNek0JeOJFyYR9vEU3+5PcPbz
	 pvKcZMFhhiEK8vFGVt6ZkUBeh7j/k1kgFif0uE8Y1RXPgfBDi2h8yILf6gDWq+WtjblJD
	 YJq05dhnyFV5p+Lw8o3IDmTOf5Eeh1onY1ZShTvCw/Se2NF+7Ge+uPeB0kLaUA2Eg1LwV
	 DB9lWdjGw3qT0tCvgRM0WcD1AwYbygXgTJ81/DhdaLwCSSjBE+7cCK9q6pzdvjMcai+/M
	 mhO/mZlG3ZSpS4qPrkUUOWWeD3OaVLaG+oteiLQK0fAcN7UlP2hrI/UZRJ8NJkDvCoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PMkj2F6l;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD36606A32D
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 18:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AD36606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PMkj2F6l
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-38190551625so12059492eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 10:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795630157; x=1796234957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n8n5tDJ1QOqDEhRtmlicy55Rb8TPjcq3KM03nYmFhZc=;
        b=PMkj2F6l9Kte4r4QCIegXGVBJYBAWUVVgBZPDs/+h67BY99iDAMnxIbu+mfxpR3wPL
         EGyLZkCVK8khjxw2zgIxaDsd/NkVCW2OnHJqqoYcb58+uOrk6qlCaXyAz9DjlR0PSEip
         +r/uExs0fuiSkgc/qdh7JDfDIgfUaWRlUtzHaF5z/HQ6M9SBtGmDoAzEI8cbUOdndDiM
         HUSCXBa67p3T0brBxhbYuGSKdRSxQLKP4zcOHpCmj8MzE3nJJL+dFZIRkFPeUpA6QTaK
         m7lxwQ0t4qzn1GZ9arQEEIBj8JiUlccY1Qs2FnAzId05hYHhMRa7+IiPSmfGhPRbCziT
         JRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795630157; x=1796234957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n8n5tDJ1QOqDEhRtmlicy55Rb8TPjcq3KM03nYmFhZc=;
        b=FnYiT/qThivQpqJ9fLJ3Bv2aZS51EKGSDu9tv9ElZ9csANEqpkjJr5QH4jqrCv6eCf
         HsOzVmGmnmZXT+FmFdLm+CysceP3A58X0PiHO5p5LNJkD2IzvDhm9RkuaNYYffX2xjXE
         ZCAUgFu9Uk+pKrwd9lzvc75DlsU/D0qE0ltpp73lY5YWtOCal/MTdt2ZfzFEs0dCkntq
         ijgg2aAET13VjLcp0krVZlRmz07eOJJwwnDhp3PZChyhr1KxHF5fiIiE8DDtkjCIcDLp
         odNTFZuC5uz0J3nDgmWgDq1KMxUF7e1sFWUDCKpKf7QZJpYsQlV7D3wYYye9NzdkvBvs
         oztQ==
X-Gm-Message-State: APuU4Z/+HcZhXvCkh1SEzH8a26EMoDWYW8zHzHZl/LJpuvcUA5EMALlq
	i3xzUEV2A6894Sgwh3Zna9g/vMwMe/zBPObo4M7Elt6FtnIYZPDfoXpU25PQANUB
X-Gm-Gg: AZFdTZffNS0i6t75xtJHBr9a7BFtnXDtrCOBllCFeetXIszfyUouLk7khu5S1nbWHaW
	kI/j2AZFZp/TlTa3RlC3dP3/eWzKJjcacxAU+0Ghm21s6AdxVrNDTcr2TembIMwNaMl3G+zxnwW
	wUC0FvB3uOhkl0aA1lKrzZHPCgikx2NM8SnBPKmizT0wVmwwnjxuOI+nPen7zVXh3vWgMInKI8e
	4c6beApgCwZqfnzzLRhC8oS//tG5I+kCBjEvnDf/iDk1byDHFkDPPBwMpGa3qeyRFG4z4gYvNEX
	7GKjdXKRpGB/r9qAEzonUXdARGuUCNp8RGEXYIr3AQd62P/4s3z87G6oAbEaeDB67r9HBb2WcMf
	KRj4UcZ3amMT67utuk+A4MzlzwiUcTXURf/FN4cPq3ZIzPvVmxWkE7LqGs9brsu95CTD0DxCk2p
	ge6KJPM4jrSUccCtSh4OYnaL/ThcYhg674Nr8AaIpC5Fir7Ngy05MYH21Rxfq0bU55sfLKLM/P3
	qqHqal0SjcdqoPdEUjT0oiaAzo5xq67j01XFGTpd99Wf5ejRbGpTYj16EtU4arIoxRPUGXh0+66
	C/wzNiwDGu3ykXT+qysIBTRIA0f2LHv0pUMz3pt5jQ==
X-Received: by 2002:a05:7301:6188:10b0:386:9ba8:2864 with SMTP id 5a478bee46e88-3869ba82acfmr13784633eec.0.1795630156307;
        Wed, 25 Nov 2026 10:09:16 -0800 (PST)
Received: from a1-free ([2603:c021:8021:f000:0:1865:8c38:18fc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm98983110eec.3.2026.11.25.10.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:09:15 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH 1/2] perf tools: Sync the x86 cpufeatures header
Date: Wed, 25 Nov 2026 18:09:11 +0000
Message-ID: <20261125180912.2388197-1-takano32@gmail.com>
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

X86_FEATURE_TSA_FILL_NO was added to the kernel copy in
commit cf27412f19c9 ("x86/bugs: Mitigate TSA on AMD Zen5") and not to
the copy perf carries, so check-headers.sh reports a difference:

  diff -u tools/arch/x86/include/asm/cpufeatures.h \
         arch/x86/include/asm/cpufeatures.h

Copy the line over, which is what the script asks for.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 61930f0d4578..303467a498b8 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -432,6 +432,7 @@
 #define X86_FEATURE_CPPC_PERF_PRIO	(17*32+ 2) /* CPPC Floor Perf support */
 #define X86_FEATURE_SMCA		(17*32+ 3) /* "smca" Scalable MCA */
 #define X86_FEATURE_BTB_CTX_ISOLATION	(17*32+ 4) /* AMD: Branch predictions contexts isolated */
+#define X86_FEATURE_TSA_FILL_NO		(17*32+ 5) /* AMD CPU not vulnerable to TSA-FILL */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
 #define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* "avx512_4vnniw" AVX-512 Neural Network Instructions */

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.53.0

