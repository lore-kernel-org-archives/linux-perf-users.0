Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F8E4B1292;
	Thu, 17 Sep 2026 23:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789686130; cv=none; b=TGQ2YiPKMjtvx+G7kzHcd1ukRV1q6CQaqAMvsafXCK3m9WrCIMIyGkZ4uO6RUXbD/yqbndD6cDLplAkD/ahO/EafUb/fDYemV3NV+LgsNNGdhEICO6QygywsnSMWEQTEoJV+FZAzRdHpPOilj84AQoqoOh8XbEEf5GDEFcC7Wwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789686130; c=relaxed/simple;
	bh=HACBz5dQpcVbJvEf42olvbFXeT4IGD2Ga0qwTUVOak4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxR3IenuCTqbpR9naKiyv4bRFTINImexgXS6lCvRqfzkmj2Pzz2M5Gb0ZO/LC1t4vjo9pWRokkgdK5uG554ksQnr+hGYqfT76jbAPZ2uJiNeuCc9uhwMTBpu6Wpguw3uwS1lJ15zyJBmQhcuJmfz985n+IP2LQ3sFA8AU6p7jfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id D52775E8A6;
	Fri, 18 Sep 2026 01:01:54 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 855211622B9; Thu, 17 Sep 2026 16:01:48 -0700 (PDT)
From: Andi Kleen <ak@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	tglx@kernel.org,
	jolsa@kernel.org,
	linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com,
	Andi Kleen <ak@kernel.org>
Subject: [RFC PATCH v2 05/11] ptwrite uprobes: Factor file-backed instruction reads
Date: Thu, 17 Sep 2026 16:00:32 -0700
Message-ID: <20260917230127.924985-6-ak@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260917230127.924985-1-ak@kernel.org>
References: <20260917230127.924985-1-ak@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor copy_insn into a more generic uprobe_copy_from_file.
The existing copy_insn is still there, but uses the generic
version now. The generic version will be used in later patches.

No semantic change intended.

Assisted-by: omp:gpt-5.6-luna
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 include/linux/uprobes.h |  2 ++
 kernel/events/uprobes.c | 59 +++++++++++++++++++++++++++++------------
 2 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 6cea2944ca8b..6fa70f3f648c 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -304,6 +304,8 @@ extern void uprobe_handle_trampoline(struct pt_regs *regs);
 extern void *arch_uretprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
 extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
+extern int uprobe_copy_from_file(struct inode *inode, struct file *file,
+				 loff_t offset, void *buf, int size);
 extern void arch_uprobe_clear_state(struct mm_struct *mm);
 extern void arch_uprobe_init_state(struct mm_struct *mm);
 extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 30c28625bb5f..894196f3089f 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1073,30 +1073,55 @@ static int __copy_insn(struct address_space *mapping, struct file *filp,
 	return 0;
 }
 
-static int copy_insn(struct uprobe *uprobe, struct file *filp)
+/**
+ * uprobe_copy_from_file - read bytes from a file's page cache
+ * @inode: the file's inode
+ * @file: file used by the filesystem's read_folio callback
+ * @offset: byte offset into the file
+ * @buf: destination buffer
+ * @size: number of bytes to read (may cross page boundaries)
+ *
+ * Callers that require a full instruction must check that the requested size
+ * was copied.
+ */
+int uprobe_copy_from_file(struct inode *inode, struct file *file,
+			  loff_t offset, void *buf, int size)
 {
-	struct address_space *mapping = uprobe->inode->i_mapping;
-	loff_t offs = uprobe->offset;
-	void *insn = &uprobe->arch.insn;
-	int size = sizeof(uprobe->arch.insn);
-	int len, err = -EIO;
+	struct address_space *mapping = inode->i_mapping;
+	int len, copied = 0, err;
 
-	/* Copy only available bytes, -EIO if nothing was read */
-	do {
-		if (offs >= i_size_read(uprobe->inode))
+	if (offset < 0 || size < 0)
+		return -EINVAL;
+
+	while (copied < size) {
+		if (offset >= i_size_read(inode))
 			break;
 
-		len = min_t(int, size, PAGE_SIZE - (offs & ~PAGE_MASK));
-		err = __copy_insn(mapping, filp, insn, len, offs);
+		/* Let the page cache zero-fill bytes past i_size in the final page. */
+		len = min_t(int, size - copied,
+			    PAGE_SIZE - (offset & ~PAGE_MASK));
+		err = __copy_insn(mapping, file, buf + copied, len, offset);
 		if (err)
-			break;
+			return err;
+
+		copied += len;
+		offset += len;
+	}
+	return copied;
+}
 
-		insn += len;
-		offs += len;
-		size -= len;
-	} while (size);
+static int copy_insn(struct uprobe *uprobe, struct file *filp)
+{
+	int ret;
 
-	return err;
+	ret = uprobe_copy_from_file(uprobe->inode, filp, uprobe->offset,
+				    &uprobe->arch.insn,
+				    sizeof(uprobe->arch.insn));
+	if (ret < 0)
+		return ret;
+	if (!ret)
+		return -EIO;
+	return 0;
 }
 
 static int prepare_uprobe(struct uprobe *uprobe, struct file *file,
-- 
2.54.0

