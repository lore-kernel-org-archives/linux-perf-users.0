Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC9F51C346;
	Mon, 31 Aug 2026 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188830; cv=none; b=sGCcvt9mmMhHLQ8kWyysN96wZdjv5DOwqJziFODBIRCzSX7u5YX71ammwB5qITbNgiNWt8va2jobokwFffL1c6s2F4RK81YE6D973PvyO0L+5pcgUVGbBXTGTEle6VfNE85Z5BimtmOXJ9vINe180jrYY1Omuu7Kx+BIkXT5ZPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188830; c=relaxed/simple;
	bh=JwBePEAHxtQ1qKlEXBV5BJladoY0vDTlR3J0iwQhUOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCeEjnStzXdTXvvQyymAsoKRFdZxijw4+O0vP4cWDwyrk99sQe5yHycslw/YDDEYzFfr8GTEWmykiH3nLkylAUoR9SIM4GsK/TePnA6wHEmDbe4IV4GkfhTSFiVzjYrT3Wf3NHJHfHO0BgGWvXHb8py4MwVUtEn5PcBASZ7C1q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 39FA15F575;
	Mon, 31 Aug 2026 17:07:06 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id F1D5116225A; Mon, 31 Aug 2026 08:07:02 -0700 (PDT)
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
Subject: [RFC v1 02/19] uprobes: Correctly reject anonymous VMAs for breakpoint installation
Date: Mon, 31 Aug 2026 08:04:38 -0700
Message-ID: <20260831150651.1134594-3-ak@kernel.org>
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

Checking for anonymous VMAs is supposed to use this special function,
not just check vm_file.

Assisted-by: omp:gpt-5.6-luna sashiko
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 kernel/events/uprobes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 7709ea882477..4287c4ff4c0f 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -139,7 +139,8 @@ static bool valid_vma(struct vm_area_struct *vma, bool is_register)
 	if (is_register)
 		flags |= VM_WRITE;
 
-	return vma->vm_file && (vma->vm_flags & flags) == VM_MAYEXEC;
+	return !vma_is_anonymous(vma) && vma->vm_file &&
+		(vma->vm_flags & flags) == VM_MAYEXEC;
 }
 
 static unsigned long offset_to_vaddr(struct vm_area_struct *vma, loff_t offset)
-- 
2.54.0

