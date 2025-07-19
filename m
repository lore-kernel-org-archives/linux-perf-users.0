Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D899F21D5BE;
	Sat, 19 Jul 2025 04:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752899878; cv=none; b=kLDH+DuI6kBSKzNIXpPG5U0D1bNS0oEhAobsw1aJik0qFa7HJ3e3xyV/FRqeLlGNnF7gFrKAwwE8nBADuAhPztB3153HZA4GeTmcTW0U+dw52hc3o4fIgBOMGCXRPi1+5yDFG9YkWepbzTYjplor2EnPEiF7MbQW6ujXCw/3r5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752899878; c=relaxed/simple;
	bh=URCnOS97CjnYCCCAFA4WMVqU8SoBUYBJkyKO4o/slyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubx8BjXOP+pTtrKR/iKCK38YBs51e2fsLGrCh8S2FOXlLo9S/Z+3U1RD/A4nC5nfFVfx72Jq2RvS00I9e+3UvSsgHpYGTtW3caktISqMf+wROm9K+oMPswFglELGUecTOYymr1LnbsuMNU+cLdoyXxmYmiuYKftFsedDi1CUkKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7600522EE;
	Fri, 18 Jul 2025 21:37:49 -0700 (PDT)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 632693F66E;
	Fri, 18 Jul 2025 21:37:55 -0700 (PDT)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	thiago.bauermann@linaro.org,
	broonie@kernel.org,
	yury.khrustalev@arm.com,
	kristina.martsenko@arm.com,
	liaochang1@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v4 3/8] arm64: uaccess: Move existing GCS accessors definitions to gcs.h
Date: Fri, 18 Jul 2025 23:37:35 -0500
Message-ID: <20250719043740.4548-4-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250719043740.4548-1-jeremy.linton@arm.com>
References: <20250719043740.4548-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are going to add some additional GCS access helpers to gcs.h in
order to avoid some forward reference problems with uaccess.

In preparation for that, lets move the existing gcssttr() and
put_user_gcs() routines into gcs.h where it makes sense to keep all
the accessors together. Further, the code which uses them already
includes gcs.h and there is an existing CONFIG_ARM64_GCS check we can
reuse.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/gcs.h     | 35 ++++++++++++++++++++++++++++
 arch/arm64/include/asm/uaccess.h | 40 --------------------------------
 2 files changed, 35 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/include/asm/gcs.h b/arch/arm64/include/asm/gcs.h
index 5bc432234d3a..e3b360c9dba4 100644
--- a/arch/arm64/include/asm/gcs.h
+++ b/arch/arm64/include/asm/gcs.h
@@ -81,6 +81,41 @@ static inline int gcs_check_locked(struct task_struct *task,
 	return 0;
 }
 
+static inline int gcssttr(unsigned long __user *addr, unsigned long val)
+{
+	register unsigned long __user *_addr __asm__ ("x0") = addr;
+	register unsigned long _val __asm__ ("x1") = val;
+	int err = 0;
+
+	/* GCSSTTR x1, x0 */
+	asm volatile(
+		"1: .inst 0xd91f1c01\n"
+		"2: \n"
+		_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %w0)
+		: "+r" (err)
+		: "rZ" (_val), "r" (_addr)
+		: "memory");
+
+	return err;
+}
+
+static inline void put_user_gcs(unsigned long val, unsigned long __user *addr,
+				int *err)
+{
+	int ret;
+
+	if (!access_ok((char __user *)addr, sizeof(u64))) {
+		*err = -EFAULT;
+		return;
+	}
+
+	uaccess_ttbr0_enable();
+	ret = gcssttr(addr, val);
+	if (ret != 0)
+		*err = ret;
+	uaccess_ttbr0_disable();
+}
+
 #else
 
 static inline bool task_gcs_el0_enabled(struct task_struct *task)
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 5b91803201ef..1aa4ecb73429 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -502,44 +502,4 @@ static inline size_t probe_subpage_writeable(const char __user *uaddr,
 
 #endif /* CONFIG_ARCH_HAS_SUBPAGE_FAULTS */
 
-#ifdef CONFIG_ARM64_GCS
-
-static inline int gcssttr(unsigned long __user *addr, unsigned long val)
-{
-	register unsigned long __user *_addr __asm__ ("x0") = addr;
-	register unsigned long _val __asm__ ("x1") = val;
-	int err = 0;
-
-	/* GCSSTTR x1, x0 */
-	asm volatile(
-		"1: .inst 0xd91f1c01\n"
-		"2: \n"
-		_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %w0)
-		: "+r" (err)
-		: "rZ" (_val), "r" (_addr)
-		: "memory");
-
-	return err;
-}
-
-static inline void put_user_gcs(unsigned long val, unsigned long __user *addr,
-				int *err)
-{
-	int ret;
-
-	if (!access_ok((char __user *)addr, sizeof(u64))) {
-		*err = -EFAULT;
-		return;
-	}
-
-	uaccess_ttbr0_enable();
-	ret = gcssttr(addr, val);
-	if (ret != 0)
-		*err = ret;
-	uaccess_ttbr0_disable();
-}
-
-
-#endif /* CONFIG_ARM64_GCS */
-
 #endif /* __ASM_UACCESS_H */
-- 
2.50.1

