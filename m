Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9775834DB4B
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773737419; cv=none; b=iEt3Xq0K1VoVc/xPEH18grNivzHJB9JRIcCWd2R8myz0MbJltYO2MRH5ruQ4hPgfjoKzyrqxhoht35Iy6HNC+zrdcdx7LXAmTCTkTMW7kSptU8HzRgQvFcD2BnwaiY85OymZDcp75b1vIqTOKu4w/0lwuwk1x55JCxJMIeug7tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773737419; c=relaxed/simple;
	bh=V2z8AagOQhIflZQZZOrfTu4jGiMGwd94SCW8I89B9jk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BoJ3GMESrfN1nnCVPzcGM35IFIrShiKisxMVXC82TjmnCxQkedesq02JmjQsSxn7ROM10cvA0ROsVaK8oAu3P/oSPBahZsytFi9wx+EiRxzpJAoay93iy+uEAEb6KakELUWLDvQVb8MRyCnwpDSFVsHpbYJjCxCAww08gN4xpPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1BB71756;
	Tue, 17 Mar 2026 01:50:11 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 139FF3F7BD;
	Tue, 17 Mar 2026 01:50:16 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 17 Mar 2026 08:50:02 +0000
Subject: [PATCH v2] tools build: Link static libs for libopenssl feature
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-tools_fix_build_libopenssl-v2-1-9362c14f04b8@arm.com>
X-B4-Tracking: v=1; b=H4sIALkVuWkC/x3MWwqAIBBA0a3EfCeYQq+tREjmVAOi4VQE0d6TP
 g9c7gOMiZChLx5IeBFTDBmqLGDeprCiIJcNSqpa6qoRR4yezUK3sSd5ZzzZuGNg9qJVnbQLWjf
 pGfJgT5i7fz6M7/sB15getWwAAAA=
X-Change-ID: 20260317-tools_fix_build_libopenssl-8290bfebda3c
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773737416; l=1058;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=V2z8AagOQhIflZQZZOrfTu4jGiMGwd94SCW8I89B9jk=;
 b=DxJsDXTsWef6wkY8J5MlgWy6dpWsOrsVbDgU66NPnUJfTEGkes6c0d6DMGkVW0eqSRlKymbnp
 oNhhjYoI4G2DnPWA1DqaUkAe0B0UsLYtVYHNfTXrChbUGWD4m/dSvED
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The perf static build reports that the BPF skeleton is disabled due to
the missing libopenssl feature.

Explicitly linking the libraries fixes the static build failure.

Fixes: 7678523109d1 ("tools/build: Add a feature test for libopenssl")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/build/feature/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 1fbcb3ce74d2173072748a417fc63bd9a5b13888..18a9abf6bfc43e86ecf58b96e0374a0e3c613bb0 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -384,7 +384,7 @@ $(OUTPUT)test-libpfm4.bin:
 	$(BUILD) -lpfm
 
 $(OUTPUT)test-libopenssl.bin:
-	$(BUILD) -lssl
+	$(BUILD) -lssl -lcrypto -lz -lzstd
 
 $(OUTPUT)test-bpftool-skeletons.bin:
 	$(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons' \

---
base-commit: bb551508e78c886e6d3bcca6c744d3bc3fd8ad59
change-id: 20260317-tools_fix_build_libopenssl-8290bfebda3c

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

