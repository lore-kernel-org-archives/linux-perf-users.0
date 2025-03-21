Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB461F12ED;
	Fri, 21 Mar 2025 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742554684; cv=none; b=HZpI5qFYacoRq9zZaQtJ21mz8zKayuc4vvKRcabrZwx8ewI7uVD2RErJpWTgcTz+jcmumIZCgJ9AIKFFs4TcwYKsm69ojP1NVgtKS3XVN1Vv9cpDh8FzXvPcKx5ZT1q4/YoRXYn2QdhHRCqEh+y01+TTR6mowEDQO51rlMPe7eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742554684; c=relaxed/simple;
	bh=330Ilm/NXBOkAn55tYFhn9g897xzyhKdD9fJJ+oqQVg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ih3LD2Uvksq3mqCM9E9v4yM0F7FabyFF5T5tPPlw5i8SiZiBuHjKDzsPs+O5IMhhpGyDBDAIUcy96RsMUS/BH4EXM4bfwKXhm7+moUxDG7qqpJ7p5qeOkNaxrzxSiS+Rx+WmZ78kHy1QvkvEiTWPtf3NEhkwS9c+pwHAVO501pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxBVXAzn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxBVXAzn"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2235189adaeso33840875ad.0;
        Fri, 21 Mar 2025 03:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742554682; x=1743159482; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYqk6+eO/utId6wWxMGXeiNREiccAzRth3+AJTwbZH8=;
        b=BxBVXAzn9WT5f3QWrIx6JAvXfufXSbJI2YI4P6/PMtnFA5yQrKnz5vXPYiUGpbgG/t
         fufq1ZF9IWE2hqOJfZbCH+TsUN+HPWOz0e/WAQZzKEXUyo6TqM65ik0ylAGX7JEz3T/F
         NvXhbUvzFnBti4/hSraRbJO+nJu/3GitdQkW49DCivEPWuuuS2Y6qsAhvM+2L5Ag101R
         JWdJlZ9R1yzOfkhHZG0wMb1Pae7OwNkMHF3RJuEOHUSkY9NN8E23Ciw+vCnPC55VEI6R
         dErjX4JGssdKVAC/HhwOUYyMT/FSHwLc/YUXzI8Gr8leIeMvKaHSWWSe6+ZjwYmd51LQ
         T2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742554682; x=1743159482;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYqk6+eO/utId6wWxMGXeiNREiccAzRth3+AJTwbZH8=;
        b=lw1u85euc+GuQE0lIbbfeb4s01hjC5yS0du+7xynZ/eZ5bg2KAZk8ZLvPap2gMN8lB
         F5MJ8Gs/0w3hvYPsd2BGQhAgxYviVMbwkHJNiKh3yKGCdg3ul08fRq9u7GQJYJMsQrRp
         glnGTgAlD9/zaTFN5zyVoKSMT85ornu/bJe9H7ZtHWxyj2VpPkmLAaeNyvcX/YJ/J5G3
         fyi2P8wu5IyksX9WZ+F7g7DH/V9n94Ypk9PReg9UDRzsqKs46k856CD29rvVPUQ4NAUN
         wG5oVEWosQeBl215nJrkQ8daEPf+KwBCm1Xs6I8ho6nXeG9pLdDxY6lg/fyTBi4CKWwv
         4ycQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkMl2SNnTEbtk8S0WOyUxQ3wEtSBfAyilrRlg9j9BPf2aPff2pGMwGU8nWpgnlAIcvxDs805pAXnF1DLM+U0aO4wn0@vger.kernel.org, AJvYcCVrSdKnYeT0sgJhLBPvtJHMNLng2XIPhBLqS6SSA2pAivmjNv769A+IAsDgKQJocK4jAiWJeE0qCjK7RTU=@vger.kernel.org, AJvYcCWZhFcz4O9EoK8GKc00ghYu2x9FJeZz+msqk4U7xonzNljrz6mm5/5v0Ud/8RuMx5dGDFU7IiBExgNht0q3KvSg9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YywX4DS/thZgX+p1Q2hIhuETSbvhDrLQDh0PGXgalxO7Czm5QJu
	HFqJUxm7PWutuMpIMdl9GIzc6qPCW6u845vgtTXNCS6cVrLBT8Rg
X-Gm-Gg: ASbGncuJ3awMOivXb7cCHVxokfVYkMJii6tXy3X9HXX3dFkLQrA6CS8B3MaKuAWqA8g
	ppI/0iPw0qWTkFqR99HbFDy1AwC9K9FdSnyRV8W1NzkB4rF/pCGKdKLiA/DkMi5/+oZ+z0DURV2
	hIGblyG20KWQVR/6BFU9dZSNINmAAclW50hjCcRQ2Ht1VEwkz+hnE6K8O+IVsa1rw2XeQSi4RKc
	eGUj5snBCaoCxQM+bOUycrOD2H8U8ppaZffIQNGrSJC0+Vb1Bsf02PKX5mM7Sbti/6A3TmADolM
	qe5xhlRESrbcrTDVUSwTqwy088r0vGCfQZqHZVj9MgMOkVDNK88Uh6UTW7XWFa9ruZzTXA==
X-Google-Smtp-Source: AGHT+IGGSkNGgWflCJsJixiy+tyVZZ5oPLdnB5WO1iaERff/XzyXRA6G3raRZahaFkS5W3mhxxUKXw==
X-Received: by 2002:a17:902:f684:b0:215:58be:3349 with SMTP id d9443c01a7336-227806d072amr51032515ad.14.1742554682217;
        Fri, 21 Mar 2025 03:58:02 -0700 (PDT)
Received: from ubuntu.localdomain ([221.214.202.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f45949sm13518835ad.63.2025.03.21.03.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 03:58:01 -0700 (PDT)
From: Penglei Jiang <superman.xpt@gmail.com>
To: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Penglei Jiang <superman.xpt@gmail.com>
Subject: [PATCH] uprop: Add new verification condition to verify_opcode
Date: Fri, 21 Mar 2025 03:56:52 -0700
Message-Id: <20250321105652.21711-1-superman.xpt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

If, during probe registration, the instruction at the probe point
differs between the file and memory (due to self-modifying code),
and the probe registration succeeds, the following errors occur:

  1. When unregistering the probe, it restores the wrong original
     instruction.
     - If the instruction crosses a page boundary: it restores only
       part of the instruction fetched from the file (the part saved
       in the first page) to the probe point, and does not restore
       the remaining part that crosses the page boundary, which can
       lead to unknown instruction.
     - If the instruction does not cross a page boundary: it restores
       the instruction fetched from the file to the probe point.

  2. The code logic changes because the saved original instruction
     is fetched from the file.

Fix:

  Add an extra check in the registration branch of verify_opcode.
  If the instruction at the probe point differs between the file
  and memory, the verification fails.

Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
---
 kernel/events/uprobes.c | 47 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index b4ca8898fe17..580dd9fe4015 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -264,10 +264,46 @@ static void copy_to_page(struct page *page, unsigned long vaddr, const void *src
 	kunmap_atomic(kaddr);
 }
 
-static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode)
+static int copy_insn_from_mem(struct page *p, unsigned long vaddr,
+		struct arch_uprobe *dst, struct mm_struct *mm)
+{
+	pgoff_t offset = offset_in_page(vaddr);
+	void *dst_insn = &dst->insn;
+	size_t size = sizeof(dst->insn);
+	size_t first_size;
+	int err;
+
+	first_size = min_t(size_t, size, PAGE_SIZE - offset);
+	copy_from_page(p, offset, dst_insn, first_size);
+	vaddr += first_size;
+	dst_insn += first_size;
+	size -= first_size;
+
+	/*
+	 * If the instruction spans the page boundary, continue copying
+	 * the remaining instruction from the second page.
+	 */
+	if (size) {
+		err = get_user_pages_remote(mm, vaddr, 1, FOLL_FORCE, &p, NULL);
+		if (err < 0)
+			return err;
+		if (err == 0)
+			return -EBUSY;
+
+		copy_from_page(p, 0, dst_insn, size);
+		put_page(p);
+	}
+
+	return 0;
+}
+
+static int verify_opcode(struct page *page, unsigned long vaddr,
+		uprobe_opcode_t *new_opcode, const struct arch_uprobe *auprobe,
+		struct mm_struct *mm)
 {
 	uprobe_opcode_t old_opcode;
 	bool is_swbp;
+	struct arch_uprobe current_insn;
 
 	/*
 	 * Note: We only check if the old_opcode is UPROBE_SWBP_INSN here.
@@ -284,6 +320,13 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
 	if (is_swbp_insn(new_opcode)) {
 		if (is_swbp)		/* register: already installed? */
 			return 0;
+
+		if (copy_insn_from_mem(page, vaddr, &current_insn, mm))
+			return 0;
+					/* register: was it changed by self-modifying code? */
+		if (memcmp(&current_insn.insn, &auprobe->insn,
+			sizeof(current_insn.insn)))
+			return 0;
 	} else {
 		if (!is_swbp)		/* unregister: was it changed by us? */
 			return 0;
@@ -491,7 +534,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (IS_ERR(old_page))
 		return PTR_ERR(old_page);
 
-	ret = verify_opcode(old_page, vaddr, &opcode);
+	ret = verify_opcode(old_page, vaddr, &opcode, auprobe, mm);
 	if (ret <= 0)
 		goto put_old;
 
-- 
2.17.1

