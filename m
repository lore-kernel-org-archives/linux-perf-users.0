Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792622185;
	b=tXK+DfeCFiCjs7ojIiMjCrvbAFhbssdDlTkuCPcVmkFx/OFSbeNwKBEAvAWZYLW1TCzA
	 ysNIwbhLE6O+4C9IjY6rPt9C/7FQdUc4PfIyopz7+99bULiZQl79D7aD1wpdIYlGu611O
	 nvReM9lK+hE0zLRqG92LFJ+1CsCPP3U+OB9gmrkVOsp/WQNbp9Ll1Th35kiTxKfiONpHE
	 OetyoMc9xjdneAYDFjB3XNz9JN+hw0NUvLWkxRkiXLHT6QX1X+7HdPcVmKfTDEr7QADHF
	 Sk/z8ozf7G7b90P3yI/s8DtPO147mP9gcSg7g5owP8S72dgIFjJknWAk3vWa/PJX7jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792622185;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=exd5Y4lpCd2BrAoy6JRTGbXkcvsNWaj+DuTKKJkB4N4=;
	b=Nb02Unqokn+mQ/vSKaeEIdARmtUgRtVrmR3ZyL83fb6hi1fBFLWLnbQINv7KEMrE+Wsr
	 sVimCKCPMvRXFT/mCrDzD/jVl91A84oOR38mTYkZjDUlmN7LSbWYgSLyG9o8Yk7LBAJUJ
	 m7CH5yAMz7JCyNX9TxulcRcCOBcCQrDTDv0OX3Lrk60aBaSBTSfGaaOU5VcIZW6xD1Zlr
	 CXMuFnjFkXyDikKcLY2m3Afou7WrCDzZy4qz4xo4F2sbd6M/tI7fgBgsThOTW44AMjBrn
	 VXe/Z+O7N+0qp66V1Potbfsy4ZGQymX+Usloam/ekO3ipaAMhB+MQ36vGc7aDspsCTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HmSNqZcR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE69606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HmSNqZcR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190B21F000C2;
	Wed, 21 Oct 2026 22:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792622185;
	bh=exd5Y4lpCd2BrAoy6JRTGbXkcvsNWaj+DuTKKJkB4N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HmSNqZcRkw20lnHGmXZGTmckug4rtiS0mBFzufQ05r3D/FWKWZ/2e90wsp/T5YDBY
	 YJhFB9BV+UmY2weNvJZwrKRLrJOPJ6+uv7AGVaDi64I1vGqF9fiM02nJwX1UdL7csj
	 +hrASAvdEl7DfqvBhvTgPMR2qtGrCNmAPDRqwvNpb2EgH6N5M2pVAV+IUM1NYBKIK5
	 flqfM9ZNOeEcorIcXNfx+tnA9Qfcz7wSrfulaMysEha3eqR9h2FwQ9zDl0UgQbjtXq
	 VG0F9VtJ+POemiBBnzaOKi3Ij0rYTBYhRvHTBSM5A4g09d8WvIiGaBp55MU27913jk
	 QDAMAoPTXGYiw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v2 06/12] tools arch x86: Sync the msr-index.h copy with the kernel sources
Date: Wed, 21 Oct 2026 19:35:45 -0300
Message-ID: <20261021223555.28372-7-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261021223555.28372-1-acme@kernel.org>
References: <20261021223555.28372-1-acme@kernel.org>
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

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in:

  ac5cc691eb4a ("x86/thermal: Add bit definitions for Intel Directed Package Thermal Interrupt")

That don't result in changes to the string tables generated from this header.

This addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h

Please see tools/include/uapi/README for further details.

Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 9c26d4075c5f421e..3a8e51a0c9e88cf3 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -350,13 +350,6 @@
 #define ARCH_PEBS_LBR_SHIFT		40
 #define ARCH_PEBS_LBR			(0x3ull << ARCH_PEBS_LBR_SHIFT)
 #define ARCH_PEBS_VECR_XMM		BIT_ULL(49)
-#define ARCH_PEBS_VECR_YMMH		BIT_ULL(50)
-#define ARCH_PEBS_VECR_EGPRS		BIT_ULL(51)
-#define ARCH_PEBS_VECR_OPMASK		BIT_ULL(53)
-#define ARCH_PEBS_VECR_ZMMH		BIT_ULL(54)
-#define ARCH_PEBS_VECR_H16ZMM		BIT_ULL(55)
-#define ARCH_PEBS_VECR_EXT_SHIFT	49
-#define ARCH_PEBS_VECR_EXT		(0x7full << ARCH_PEBS_VECR_EXT_SHIFT)
 #define ARCH_PEBS_GPR			BIT_ULL(61)
 #define ARCH_PEBS_AUX			BIT_ULL(62)
 #define ARCH_PEBS_EN			BIT_ULL(63)
@@ -1014,6 +1007,7 @@
 #define THERM_INT_HIGH_ENABLE		(1 << 0)
 #define THERM_INT_LOW_ENABLE		(1 << 1)
 #define THERM_INT_PLN_ENABLE		(1 << 24)
+#define THERM_INT_DPTI_ENABLE		(1 << 25)
 
 #define MSR_IA32_THERM_STATUS		0x0000019c
 
@@ -1043,6 +1037,7 @@
 
 #define PACKAGE_THERM_STATUS_PROCHOT		(1 << 0)
 #define PACKAGE_THERM_STATUS_POWER_LIMIT	(1 << 10)
+#define PACKAGE_THERM_STATUS_DPTI_ACK		(1 << 25)
 #define PACKAGE_THERM_STATUS_HFI_UPDATED	(1 << 26)
 
 #define MSR_IA32_PACKAGE_THERM_INTERRUPT	0x000001b2
-- 
2.56.0

