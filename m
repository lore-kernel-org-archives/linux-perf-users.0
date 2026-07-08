Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F32D187346
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 04:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783486633; cv=none; b=X3vIa5827xHee+Kr2PbeVD986Z25dWY2OtA9uffWFDa97CcHZyRuwATdCiWM4+SRPKTvEp6F5nC/kjGaliCAF6uRsWxEHXSLmZwUrfvNddeyMy4NhrmcvEAxFhjQdHEEj9+6KpQdb7gMHFlTnx+akzcPQltGDOhvmtWliMuYbZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783486633; c=relaxed/simple;
	bh=zI0WpqSrdRntTg06btNBs60tjlon9tisG+kqlXXl/z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrBJjsSOyE67SgNRn4/wo1bgoq1B4gPWTE6yqC7eLk57nRZMHf92z4+nB7uL4KLmaCKFFDdy4eBvU3Dv/Y7U6s/CXR2D39ddAl3vAT8/LoTw75KWolBh8ZZkvSzSoblf71l+vgCshZV9LQMVsqGHhi0R1X2wJ5nWn3vjj05zm0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/a3HVwP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/a3HVwP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783486631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xITz2obDV3LAUccx/apcLm8g4fUeKw7tbSQpXXJ7nko=;
	b=R/a3HVwPtMmbl5JirgAmhMuG5V8zA+pr8wsUX9anH9f8RWmwSEqSDDCEs3du/twTwze31u
	Rk8vabxqRyKAsrSFixXHABAtrkT8A+JPSeM2rGn/N1WbYcI7VFgToALeGGfYNQybD/1tld
	TuL2P2V1bmgxCPZlpxtkNSzy8gWjCsM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-WyQ8Id2MMGO7341XIL59Ag-1; Wed,
 08 Jul 2026 00:57:06 -0400
X-MC-Unique: WyQ8Id2MMGO7341XIL59Ag-1
X-Mimecast-MFC-AGG-ID: WyQ8Id2MMGO7341XIL59Ag_1783486625
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E0781955EB2;
	Wed,  8 Jul 2026 04:57:05 +0000 (UTC)
Received: from tallison-mac.redhat.com (unknown [10.22.81.130])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 327F21800664;
	Wed,  8 Jul 2026 04:57:02 +0000 (UTC)
From: Trevor Allison <tallison@redhat.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	tallison@redhat.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] perf x86: Add .note.gnu.property to assembly linked into perf
Date: Wed,  8 Jul 2026 00:56:06 -0400
Message-ID: <20260708045606.43649-4-tallison@redhat.com>
In-Reply-To: <20260708045606.43649-1-tallison@redhat.com>
References: <20260708045606.43649-1-tallison@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Assembly sources do not get .note.gnu.property from the compiler.
Add the section to the x86 files that are linked into perf, using the
same approach as the existing .note.GNU-stack notes.

Signed-off-by: Trevor Allison <tallison@redhat.com>
---
 tools/perf/arch/x86/tests/regs_load.S    | 24 ++++++++++++++++++++++++
 tools/perf/bench/mem-memcpy-x86-64-asm.S | 24 ++++++++++++++++++++++++
 tools/perf/bench/mem-memset-x86-64-asm.S | 24 ++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/tools/perf/arch/x86/tests/regs_load.S b/tools/perf/arch/x86/tests/regs_load.S
index 80f14f52e3f6..1947f95cceda 100644
--- a/tools/perf/arch/x86/tests/regs_load.S
+++ b/tools/perf/arch/x86/tests/regs_load.S
@@ -97,3 +97,27 @@ SYM_FUNC_END(perf_regs_load)
  * the ELF stack should not be restricted at all and set it RWX.
  */
 .section .note.GNU-stack,"",@progbits
+
+/*
+ * We need to provide .note.gnu.property section with IBT and SHSTK,
+ * saying that this object supports the same CET properties as C code
+ * built with -fcf-protection. Otherwise static linking drops CET from
+ * the final perf binary when other objects are CET-enabled.
+ */
+	.pushsection .note.gnu.property, "a"
+	.p2align 3
+	.long 1f - 0f
+	.long 4f - 1f
+	.long 5
+0:
+	.asciz "GNU"
+1:
+	.p2align 3
+	.long 0xc0000002
+	.long 3f - 2f
+2:
+	.long 3
+3:
+	.p2align 3
+4:
+	.popsection
diff --git a/tools/perf/bench/mem-memcpy-x86-64-asm.S b/tools/perf/bench/mem-memcpy-x86-64-asm.S
index 1b9fef7efcdc..e7b84aa43ab4 100644
--- a/tools/perf/bench/mem-memcpy-x86-64-asm.S
+++ b/tools/perf/bench/mem-memcpy-x86-64-asm.S
@@ -18,3 +18,27 @@
  * the ELF stack should not be restricted at all and set it RWX.
  */
 .section .note.GNU-stack,"",@progbits
+
+/*
+ * We need to provide .note.gnu.property section with IBT and SHSTK,
+ * saying that this object supports the same CET properties as C code
+ * built with -fcf-protection. Otherwise static linking drops CET from
+ * the final perf binary when other objects are CET-enabled.
+ */
+	.pushsection .note.gnu.property, "a"
+	.p2align 3
+	.long 1f - 0f
+	.long 4f - 1f
+	.long 5
+0:
+	.asciz "GNU"
+1:
+	.p2align 3
+	.long 0xc0000002
+	.long 3f - 2f
+2:
+	.long 3
+3:
+	.p2align 3
+4:
+	.popsection
diff --git a/tools/perf/bench/mem-memset-x86-64-asm.S b/tools/perf/bench/mem-memset-x86-64-asm.S
index abd26c95f1aa..f8002da91c3c 100644
--- a/tools/perf/bench/mem-memset-x86-64-asm.S
+++ b/tools/perf/bench/mem-memset-x86-64-asm.S
@@ -13,3 +13,27 @@
  * the ELF stack should not be restricted at all and set it RWX.
  */
 .section .note.GNU-stack,"",@progbits
+
+/*
+ * We need to provide .note.gnu.property section with IBT and SHSTK,
+ * saying that this object supports the same CET properties as C code
+ * built with -fcf-protection. Otherwise static linking drops CET from
+ * the final perf binary when other objects are CET-enabled.
+ */
+	.pushsection .note.gnu.property, "a"
+	.p2align 3
+	.long 1f - 0f
+	.long 4f - 1f
+	.long 5
+0:
+	.asciz "GNU"
+1:
+	.p2align 3
+	.long 0xc0000002
+	.long 3f - 2f
+2:
+	.long 3
+3:
+	.p2align 3
+4:
+	.popsection
-- 
2.50.1 (Apple Git-155)

