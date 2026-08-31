Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B2051E43F;
	Mon, 31 Aug 2026 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188835; cv=none; b=g1fAv/z4W9VtLabGcpAuQymy7J0g6rKu+T/w59ZoD3Ivr+3jkhghpB2dTSzfCV1VVFKFyccqkYUJctFGdNPxE33L2bnHOtHwy9ct54H0GRdRnWFSkgoS7ymM29S54LnNl6ZXTrrM29FQ1wTnvbth5F3ExV9M5jnkMP5CPI9roDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188835; c=relaxed/simple;
	bh=2AI2VPuYqOdo/D7hXbXUjamF/NDzpTd1ItvUNX+udJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cm6+10p1nISuyo1ZyMeUg8ECRI2bUGLHPMV0DMETI/yz3yZkv/Sa9gJMFLJ5FD/9343aNyeKANRQpF8MoaGsqRT8U+4gMBRHQIwg3pipbbJoRqs4UKjQVHPHNIJuC22oPOOUTQppmxDLf9T5qyZytQDgUooZie0N21+73CKTDl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id EEDA563F8E;
	Mon, 31 Aug 2026 17:07:08 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 2423D16229D; Mon, 31 Aug 2026 08:07:03 -0700 (PDT)
From: Andi Kleen <ak@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	tglx@kernel.org,
	x86@kernel.org,
	jolsa@kernel.org,
	linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com,
	Andi Kleen <ak@kernel.org>
Subject: [RFC v1 14/19] ptwrite uprobes: Use atomic patching for multinop sites
Date: Mon, 31 Aug 2026 08:04:50 -0700
Message-ID: <20260831150651.1134594-15-ak@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831150651.1134594-1-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The earlier multinop patching is not quite safe because the cross
modified CPU could be already executing on a later nop when the
cross patching occurs. The Intel SDM allows cross modification
by larger stores as long as they are aligned. AMD has a similar
guarantee.

The motivation for multinop is mainly to support the gcc
function entry patch sites and these are always aligned.

So enforce 8 bytes alignment of the multinop and use a safe RMW 8 byte store
ot overwrite the 5 byte sequence. This assumes that the code is not
changing in parallel, but if that happens cross modification safety
is probably the smallest of the issues.

Assisted-by: omp:gpt-5.6-luna sashiko
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 arch/x86/kernel/uprobes.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 806e40f7b0ab..8d9dadc2b1fc 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1812,8 +1812,9 @@ get_uprobe_ptwrite_page(struct mm_struct *mm, unsigned long vaddr,
 }
 
 /*
- * A run of short NOPs is accepted only when requested. This validation does
- * not make the three-phase poke safe for threads that already passed byte 0.
+ * A run of short NOPs is accepted only when requested. It is patched with
+ * an aligned eight-byte read-modify-write, preserving the following bytes;
+ * code is not expected to change concurrently.
  */
 static bool pun_site_is_nop(const u8 *orig, bool allow_nop_run)
 {
@@ -1831,6 +1832,13 @@ static bool pun_site_is_nop(const u8 *orig, bool allow_nop_run)
 		orig[2] == 0x90 && orig[3] == 0x90 && orig[4] == 0x90;
 }
 
+/* Identify the explicitly opted-in run of five one-byte NOPs. */
+static bool ptwrite_site_is_multinop(const u8 *orig, bool allow_nop_run)
+{
+	return allow_nop_run && orig[0] == 0x90 && orig[1] == 0x90 &&
+		orig[2] == 0x90 && orig[3] == 0x90 && orig[4] == 0x90;
+}
+
 /*
  * Classify the site's single instruction for out-of-line execution.
  * Returns the length, or 0 when it cannot run safely out of line.
@@ -2224,6 +2232,9 @@ int arch_uprobe_install_ptwrite(struct arch_uprobe *auprobe,
 	ret = copy_from_vaddr(mm, vaddr, orig, sizeof(orig));
 	if (ret)
 		return ret;
+	if (ptwrite_site_is_multinop(orig, ptw_a->allow_nop_run) &&
+	    (vaddr & 7))
+		return pun_install(auprobe, vma, vaddr, orig);
 	if (ptwrite_is_installed(mm, vaddr, orig))
 		return 0;
 
@@ -2249,9 +2260,13 @@ int arch_uprobe_install_ptwrite(struct arch_uprobe *auprobe,
 			continue;
 		if (!__in_uprobe_ptwrite(mm, ptw->vaddr))
 			continue;
-		ret = ptwrite_text_poke(auprobe, vma, vaddr,
-					ptw->vaddr + ptw->index[b].off);
-		goto out;
+		if (ptwrite_site_is_multinop(orig, ptw_a->allow_nop_run))
+			ret = ptwrite_multinop_text_poke(auprobe, vma, vaddr,
+							ptw->vaddr + ptw->index[b].off);
+		else
+			ret = ptwrite_text_poke(auprobe, vma, vaddr,
+						ptw->vaddr + ptw->index[b].off);
+		return ret;
 	}
 	ptw = get_uprobe_ptwrite_page(mm, vaddr, ptw_a->stub_len);
 	if (!ptw)
@@ -2287,8 +2302,11 @@ int arch_uprobe_install_ptwrite(struct arch_uprobe *auprobe,
 	memcpy(kaddr + block_off + ptw_a->jmp_off, &rel, sizeof(rel));
 	kunmap_local(kaddr);
 
-	ret = ptwrite_text_poke(auprobe, vma, vaddr, stub_addr);
-	if (ret)
+	if (ptwrite_site_is_multinop(orig, ptw_a->allow_nop_run))
+		ret = ptwrite_multinop_text_poke(auprobe, vma, vaddr, stub_addr);
+	else
+		ret = ptwrite_text_poke(auprobe, vma, vaddr, stub_addr);
+	if (ret) {
 		/* Publish rollback before readers use the reduced block count. */
 		smp_store_release(&ptw->nblocks, ptw->nblocks - 1);
 		return ret;
-- 
2.54.0

