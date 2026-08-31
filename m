Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5353551E42E;
	Mon, 31 Aug 2026 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188834; cv=none; b=ViI9oUjpFhVq4jC4L6CEi1vOP2GG6mlH//c4j7q64mNXRrGk9ONE9nR/WqqTN1g4M95aNnVQu3ZdcJWC3ModGDeqC2Qx3591NG+Pvej5fips+0zZPxXsufNlLxl41J78A4lPF2nWMiH/ardHuUONwQ6sqbG0Hu2KEONDKU7/5LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188834; c=relaxed/simple;
	bh=Io7aVEcMllQwS93EcPOo5wddbrGteKIzNWT3jJ/kd54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVffyUpPV5486qp2F4Cghyr6bOykv49rkeWkDDjiSyfYZk0ItSiClCfQYG96cloI9ukAsHCWCPL/zkXz0QDpzY1zHx8tTEjXsaj1tyQW1lCQNKD9yqUQluhAQHrH/5O7DLjb/KKpFin73HZGtfxhJMHOHgVfvvzkHhnvEnqnRwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 9D88E63F88;
	Mon, 31 Aug 2026 17:07:08 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id 14857162288; Mon, 31 Aug 2026 08:07:03 -0700 (PDT)
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
Subject: [RFC v1 09/19] ptwrite uprobes: Factor file-backed instruction reads
Date: Mon, 31 Aug 2026 08:04:45 -0700
Message-ID: <20260831150651.1134594-10-ak@kernel.org>
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

Refactor copy_insn into a more generic uprobe_copy_from_file.
The existing copy_insn is still there, but uses the generic
version now. The generic version will be used in later patches.

No semantic change intended.

Assisted-by: omp:gpt-5.6-luna
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 include/linux/uprobes.h |  2 ++
 kernel/events/uprobes.c | 56 ++++++++++++++++++++++++++++-------------
 2 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 6d2a430f88ca..c0d65ea5353e 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -304,6 +304,8 @@ extern void uprobe_handle_trampoline(struct pt_regs *regs);
 extern void *arch_uretprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
 extern void uprobe_copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len);
+extern int uprobe_copy_from_file(struct inode *inode, struct file *file,
+					 loff_t offset, void *buf, int size);
 extern void arch_uprobe_clear_state(struct mm_struct *mm);
 extern void arch_uprobe_init_state(struct mm_struct *mm);
 extern int arch_uprobe_dup_ptwrite(struct mm_struct *oldmm, struct mm_struct *newmm);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 23202df2b51a..20fa16ed8519 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1073,30 +1073,52 @@ static int __copy_insn(struct address_space *mapping, struct file *filp,
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
+ * Handles page-crossing reads transparently.  The return value is the number
+ * of bytes copied, or a negative error code.  Callers that require a full
+ * instruction must check that the requested size was copied.
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
+	loff_t file_size;
+	int len, copied = 0, err;
 
-	/* Copy only available bytes, -EIO if nothing was read */
-	do {
-		if (offs >= i_size_read(uprobe->inode))
+	if (offset < 0 || size < 0)
+		return -EINVAL;
+	while (copied < size) {
+		file_size = i_size_read(inode);
+		if (offset >= file_size)
 			break;
 
-		len = min_t(int, size, PAGE_SIZE - (offs & ~PAGE_MASK));
-		err = __copy_insn(mapping, filp, insn, len, offs);
+		len = min_t(loff_t, size - copied, file_size - offset);
+		len = min_t(int, len, PAGE_SIZE - (offset & ~PAGE_MASK));
+		err = __copy_insn(mapping, file, buf + copied, len, offset);
 		if (err)
-			break;
+			return err;
 
-		insn += len;
-		offs += len;
-		size -= len;
-	} while (size);
+		copied += len;
+		offset += len;
+	}
+	return copied;
+}
 
-	return err;
+static int copy_insn(struct uprobe *uprobe, struct file *filp)
+{
+	int ret;
+
+	ret = uprobe_copy_from_file(uprobe->inode, filp, uprobe->offset,
+				   &uprobe->arch.insn,
+				   sizeof(uprobe->arch.insn));
+	return ret < 0 ? ret : ret == sizeof(uprobe->arch.insn) ? 0 : -EIO;
 }
 
 static int prepare_uprobe(struct uprobe *uprobe, struct file *file,
-- 
2.54.0

