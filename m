Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E853E20299B;
	Mon, 18 Aug 2025 21:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755552930; cv=none; b=BKOfa6SBuTCh0HIWOehrESaBWdbLT7XKRu9Z5Jm+fOaYWs6zNiP3yjD8o/Rq4Oeo2iJGxZ9XWb3rGCPe5YT8zk/Yr7H8aIwz/WFNkUG9sM8ePgcKyszbCo1hWZ2onYBQAXYjRiIHl331g4oN9Aap2o4gYT0Ux3JJbLK09x82w+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755552930; c=relaxed/simple;
	bh=7u1XK/uo4TT0kDc3irAADx/ZefFTQuIQw0F6eE3vIs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGUwsYzB1pfYhxo6iV+Yi4DNdgn7PWMz/48agkf8SQz+7ksU+mR8KMP+9zipf6nUlYEjaXi7CwvFMjFhq8nLw1wl4tOokTRwtSIqhQjOigV0GyIMS3FglzJqmmdaFVtGJOF7GPVYBae4V1GmuqjO5YmNldXrgBWQbF8e40Ae0Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A6381A9A;
	Mon, 18 Aug 2025 14:35:20 -0700 (PDT)
Received: from u200865.usa.arm.com (U203867.austin.arm.com [10.118.30.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B1003F738;
	Mon, 18 Aug 2025 14:35:27 -0700 (PDT)
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	mingo@redhat.com,
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
Subject: [PATCH v6 3/7] arm64: uaccess: Add additional userspace GCS accessors
Date: Mon, 18 Aug 2025 16:34:48 -0500
Message-ID: <20250818213452.50439-4-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818213452.50439-1-jeremy.linton@arm.com>
References: <20250818213452.50439-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Uprobes need more advanced read, push, and pop userspace GCS
functionality. Implement those features using the existing gcsstr()
and copy_from_user().

Its important to note that GCS pages can be read by normal
instructions, but the hardware validates that pages used by GCS
specific operations, have a GCS privilege set. We aren't validating this
in load_user_gcs because it requires stabilizing the VMA over the read
which may fault.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/gcs.h | 54 ++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/include/asm/gcs.h b/arch/arm64/include/asm/gcs.h
index e3b360c9dba4..7c621197169e 100644
--- a/arch/arm64/include/asm/gcs.h
+++ b/arch/arm64/include/asm/gcs.h
@@ -116,6 +116,47 @@ static inline void put_user_gcs(unsigned long val, unsigned long __user *addr,
 	uaccess_ttbr0_disable();
 }
 
+static inline void push_user_gcs(unsigned long val, int *err)
+{
+	u64 gcspr = read_sysreg_s(SYS_GCSPR_EL0);
+
+	gcspr -= sizeof(u64);
+	put_user_gcs(val, (unsigned long __user *)gcspr, err);
+	if (!*err)
+		write_sysreg_s(gcspr, SYS_GCSPR_EL0);
+}
+
+/*
+ * Unlike put/push_user_gcs() above, get/pop_user_gsc() doesn't
+ * validate the GCS permission is set on the page being read.  This
+ * differs from how the hardware works when it consumes data stored at
+ * GCSPR. Callers should assure this is acceptable.
+ */
+static inline u64 get_user_gcs(unsigned long __user *addr, int *err)
+{
+	unsigned long ret;
+	u64 load = 0;
+
+	/* Ensure previous GCS operation are visible before we read the page */
+	gcsb_dsync();
+	ret = copy_from_user(&load, addr, sizeof(load));
+	if (ret != 0)
+		*err = ret;
+	return load;
+}
+
+static inline u64 pop_user_gcs(int *err)
+{
+	u64 gcspr = read_sysreg_s(SYS_GCSPR_EL0);
+	u64 read_val;
+
+	read_val = get_user_gcs((unsigned long __user *)gcspr, err);
+	if (!*err)
+		write_sysreg_s(gcspr + sizeof(u64), SYS_GCSPR_EL0);
+
+	return read_val;
+}
+
 #else
 
 static inline bool task_gcs_el0_enabled(struct task_struct *task)
@@ -126,6 +167,10 @@ static inline bool task_gcs_el0_enabled(struct task_struct *task)
 static inline void gcs_set_el0_mode(struct task_struct *task) { }
 static inline void gcs_free(struct task_struct *task) { }
 static inline void gcs_preserve_current_state(void) { }
+static inline void put_user_gcs(unsigned long val, unsigned long __user *addr,
+				int *err) { }
+static inline void push_user_gcs(unsigned long val, int *err) { }
+
 static inline unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
 						   const struct kernel_clone_args *args)
 {
@@ -136,6 +181,15 @@ static inline int gcs_check_locked(struct task_struct *task,
 {
 	return 0;
 }
+static inline u64 get_user_gcs(unsigned long __user *addr, int *err)
+{
+	*err = -EFAULT;
+	return 0;
+}
+static inline u64 pop_user_gcs(int *err)
+{
+	return 0;
+}
 
 #endif
 
-- 
2.50.1

