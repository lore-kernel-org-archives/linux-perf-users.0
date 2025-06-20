Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13A31E47B7;
	Fri, 20 Jun 2025 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750420314; cv=none; b=mM2sgyJqPFOwjA1wb27YwlIXV42oDeJTj6KR3MtXHPwlRDNcXAyqOmgOme1SNdtGEKaBsSn/WSq2w06pS4elcjnVpM9nzapi2J1Z10dqd5wk0THxPwZ+6y6hK1MFVgoEcm8P7hjgmEqrYzBTqqEtoJJ7tHNYJh9llL6trINbE7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750420314; c=relaxed/simple;
	bh=OpaRy6f5lV+HSoFPNPnqy/zc1+kY/2E7JDK8AUK1DJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KRJIXW9zq3LQ/X8+NcplYUMd8sH8wSAzEIpYRO+r6kyy4lgTV9Ikik5Tbxci9ND+LD4aRZ0+5290AkacSv7DSJycpNRzfA9tOXsJSMVBiwsNgAHDjmXQYXFJhSKSBzpPDMWM7iORT5CD9twWrYhWrRoHN1ID23v+jth0sXRcnjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrtCc/v8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrtCc/v8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B14BC4CEE3;
	Fri, 20 Jun 2025 11:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750420314;
	bh=OpaRy6f5lV+HSoFPNPnqy/zc1+kY/2E7JDK8AUK1DJ4=;
	h=From:To:Cc:Subject:Date:From;
	b=XrtCc/v8dMuE04TYZw1YGGg1thbNCP8HJNEPDmkkKWdK1GcQzOizJwjviPUc8Uax9
	 81F7xgs0eBMN/FeesttDLCDJzpDNKofWgOjVLau7IuIAEdj3zutt2SEfeI5uU0JIBy
	 bwc5j97TxFtjvNxwMtTwSRN0uVxg4Rcf0XX67drJK39oD9v4qO+3dgIDenMYZBopVD
	 O6dWw0W8cd8Rq5+HSu9PF+OZ7X8AlLnmRDGOZ0m5AEfHRw91TShoEfaslKTkKQx8S5
	 uyuAJkhauye50uOH3EpnQaVUUEDW0/kUPY6TJQbm53ofchkTRyGZjVjeHJNcDltV+n
	 txIZ/Gd5xQUqg==
From: Arnd Bergmann <arnd@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] perf/arm-cmn: reduce stack usage in arm_cmn_probe()
Date: Fri, 20 Jun 2025 13:51:42 +0200
Message-Id: <20250620115149.132845-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This function has a rather large stack usage, which triggers the
warning limit with clang if I reduce the default to 1280 bytes:

drivers/perf/arm-cmn.c:2541:12: error: stack frame size (1312) exceeds limit (1280) in 'arm_cmn_probe' [-Werror,-Wframe-larger-than]

This is a combination of two problems:

 - The arm_cmn_discover() function has some large local variables and
   gets inlined here by clang (but not gcc)

 - The (struct pmu) assignment adds an extra copy of the pmu structure
   on the stack and does a memcpy() from that

Address the first one here by marking arm_cmn_discover() as noinline_for_stack,
making clang behave more like gcc here. This gets it under the warning
limit, though the total stack usage does not actually get reduced.

It would be nice to also change the way struct pmu is initialized, but I
see that this is done consistently for all pmu drivers. Ideally the function
pointers should be moved into a 'static const' structure per driver as this
is done in most other subsystems.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/perf/arm-cmn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 031d45d0fe3d..430c89760391 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2243,7 +2243,8 @@ static enum cmn_node_type arm_cmn_subtype(enum cmn_node_type type)
 	}
 }
 
-static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
+static noinline_for_stack int arm_cmn_discover(struct arm_cmn *cmn,
+					       unsigned int rgn_offset)
 {
 	void __iomem *cfg_region;
 	struct arm_cmn_node cfg, *dn;
-- 
2.39.5

