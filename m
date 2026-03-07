Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B65B3F9FB;
	Sat,  7 Mar 2026 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772892375; cv=none; b=Olf0jzZrFvR2fSVgyumKGfQSTIumf1IzxmiCUE+WqRQPNOp4jz5Vx3YZcD4FGJVOy6412ek2AgHxdI/UVsYHsz2wtYSbzGkwo2MeFH5S9LnLJRAy2frldfMr+bHOMMm3PT7s1SmRs1nyn7nsi7iVLKD0+zcmrcQV7G6nyCqTr+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772892375; c=relaxed/simple;
	bh=HRSiaf0sy5O+OIaIyJs11RCR7ttEuAwJ3I3eFhYiVDI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NjYoN1XtPOvRlq3W5m4rK1mE1GE+hrcIM0guriKcs+vCsaBgh8Ql/uqiqgIVRryUahRhGI8jc8DxdLGl7GvwajoBdhX7qiZSCrrP77CqzIHuIvCHPE9cm0yR4FCHA2LxjBP4Fyqp1Kl7WLAn9zpkZS/vChMbGuV1Pon6YofDeSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5962B1762;
	Sat,  7 Mar 2026 06:06:01 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F27553F836;
	Sat,  7 Mar 2026 06:06:05 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Dmitrii Dolgov <9erthalion6@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Blake Jones <blakejones@google.com>,
	Yuzhuo Jing <yuzhuo@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH] tools build: Link crypto lib for libopenssl feature
Date: Sat,  7 Mar 2026 14:05:53 +0000
Message-Id: <20260307140553.2021539-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The perf static build reports that the BPF skeleton is disabled due to
the missing libopenssl feature.

Linking the crypto library fixes the static build failure.

Fixes: 7678523109d1 ("tools/build: Add a feature test for libopenssl")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/build/feature/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 1fbcb3ce74d2..8b1e32cb22fd 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -384,7 +384,7 @@ $(OUTPUT)test-libpfm4.bin:
 	$(BUILD) -lpfm
 
 $(OUTPUT)test-libopenssl.bin:
-	$(BUILD) -lssl
+	$(BUILD) -lssl -lcrypto
 
 $(OUTPUT)test-bpftool-skeletons.bin:
 	$(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons' \
-- 
2.34.1

