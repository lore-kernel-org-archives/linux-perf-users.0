Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8023A20E333;
	Mon,  7 Apr 2025 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042813; cv=none; b=n8Q4EKaqicWrAYYfHCQIRzuv7W7CiiYLwJAEklAWGD8eP61tKiedBI4TnngSNba3CQX80Q/BVtJVpYCGgDM146Pj73o+/IXwokOX7wnBmml+F3nPt8CAF0QRA0AA5ppSxLf5WR9gkLw+6MJ0ipXxQR8McWCYJoVz3+5WlxN2Gyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042813; c=relaxed/simple;
	bh=74l8WQJx+JHUOxctsCLtwn1uQDcdHtUHH9jZWyzig0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWOR9VhrDEqJbqWpANjk0acFFw/z12DpJ7frRG+pLchdxU+GJYt3eq+IGHZukFCKzomvYSv8acuQUZPjUa0PePcTohhzK4jyCdfP/TID0P4cWjEQ8+XyNllsCORWZq09Iiqv8ntwgc9s3nqHwoNP5V8qr8h1bm9nV9ubBsCh2MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 006691BC0;
	Mon,  7 Apr 2025 09:20:12 -0700 (PDT)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68C763F694;
	Mon,  7 Apr 2025 09:20:10 -0700 (PDT)
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
Subject: [PATCH v2 3/6] arm64: uaccess: Add additional userspace GCS accessors
Date: Mon,  7 Apr 2025 11:19:48 -0500
Message-ID: <20250407161951.560865-4-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407161951.560865-1-jeremy.linton@arm.com>
References: <20250407161951.560865-1-jeremy.linton@arm.com>
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
---
 arch/arm64/include/asm/uaccess.h | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 5b91803201ef..34a8b2cc8935 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -20,6 +20,7 @@
 
 #include <asm/asm-extable.h>
 #include <asm/cpufeature.h>
+#include <asm/gcs.h>
 #include <asm/mmu.h>
 #include <asm/mte.h>
 #include <asm/ptrace.h>
@@ -539,6 +540,47 @@ static inline void put_user_gcs(unsigned long val, unsigned long __user *addr,
 	uaccess_ttbr0_disable();
 }
 
+static __always_inline unsigned long __must_check
+copy_from_user(void *to, const void __user *from, unsigned long n);
+
+/*
+ * Unlike put_user_gcs() above, the use of copy_from_user() may provide
+ * an opening for non GCS pages to be used to source data. Therefore this
+ * should only be used in contexts where that is acceptable.
+ */
+static inline u64 load_user_gcs(unsigned long __user *addr, int *err)
+{
+	unsigned long ret;
+	u64 load = 0;
+
+	gcsb_dsync();
+	ret = copy_from_user(&load, addr, sizeof(load));
+	if (ret != 0)
+		*err = ret;
+	return load;
+}
+
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
+static inline u64 pop_user_gcs(int *err)
+{
+	u64 gcspr = read_sysreg_s(SYS_GCSPR_EL0);
+	u64 read_val;
+
+	read_val = load_user_gcs((unsigned long __user *)gcspr, err);
+	if (!*err)
+		write_sysreg_s(gcspr + sizeof(u64), SYS_GCSPR_EL0);
+
+	return read_val;
+}
 
 #endif /* CONFIG_ARM64_GCS */
 
-- 
2.49.0

