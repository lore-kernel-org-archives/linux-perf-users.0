Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF5F213E94;
	Tue, 18 Mar 2025 20:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742330939; cv=none; b=uqF08VB84KQLyZjZmmt1iwpsUbLyf0uThCdCPDmZmE4vNd3nHQihUnpUYNnK1CJbskuICm69BdmF6Svr3tIbY3LLQ/Qs9yLcM11XS+7uqu6uEdcL5Gg5yQaUYOGX/pifa82Xbq4s+aaKetRWhxTJSWEvKVlsyi8FMhRFEonevBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742330939; c=relaxed/simple;
	bh=7ehPZLOngjd8ImMbsLIXTpmyAaWwJQcZfzQqjt5eY5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XK9AmptzRek2E1YHF5kJVh38wi/fbtj4ChRp0ivVfhuaznOxdl4X5loWsVRqy4DaVhXNhnAzdE3nogxiOgUNynaPApn0bn/0Igj2xMDNEiz1fasUmtnwTqnaJK46G4qcJWK9WZGLOX79JAVA8M6XZ4OzxkT76hkMPHhKJRtrZ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C2331BF7;
	Tue, 18 Mar 2025 13:49:05 -0700 (PDT)
Received: from u200865.usa.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E1F13F694;
	Tue, 18 Mar 2025 13:48:56 -0700 (PDT)
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
	Jeremy Linton <jeremy.linton@arm.com>,
	Steve Capper <steve.capper@arm.com>
Subject: [PATCH 5/7] arm64: uprobes: Add GCS support to uretprobes
Date: Tue, 18 Mar 2025 15:48:39 -0500
Message-ID: <20250318204841.373116-6-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318204841.373116-1-jeremy.linton@arm.com>
References: <20250318204841.373116-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ret probes work by changing the value in the link register at
the probe location to return to the probe rather than the calling
routine. Thus the GCS needs to be updated with this address as well.

Since its possible to insert probes at locations where the
current value of the LR doesn't match the GCS state this needs
to be detected and handled in order to maintain the existing
no-fault behavior.

Co-developed-by: Steve Capper <steve.capper@arm.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
(updated to use new gcs accessors, and handle LR/GCS mismatches)
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/probes/uprobes.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index cb3d05af36e3..5e72409a255a 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -159,11 +159,41 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
 				  struct pt_regs *regs)
 {
 	unsigned long orig_ret_vaddr;
+	unsigned long gcs_ret_vaddr;
+	int err = 0;
+	u64 gcspr;
 
 	orig_ret_vaddr = procedure_link_pointer(regs);
+
+	if (task_gcs_el0_enabled(current)) {
+		gcspr = read_sysreg_s(SYS_GCSPR_EL0);
+		gcs_ret_vaddr = load_user_gcs((unsigned long __user *)gcspr, &err);
+		if (err) {
+			force_sig(SIGSEGV);
+			goto out;
+		}
+		/*
+		 * If the LR and GCS entry don't match, then some kind of PAC/control
+		 * flow happened. Likely because the user is attempting to retprobe
+		 * on something that isn't a function boundary or inside a leaf
+		 * function. Explicitly abort this retprobe because it will generate
+		 * a GCS exception.
+		 */
+		if (gcs_ret_vaddr != orig_ret_vaddr)	{
+			orig_ret_vaddr = -1;
+			goto out;
+		}
+		put_user_gcs(trampoline_vaddr, (unsigned long __user *) gcspr, &err);
+		if (err) {
+			force_sig(SIGSEGV);
+			goto out;
+		}
+	}
+
 	/* Replace the return addr with trampoline addr */
 	procedure_link_pointer_set(regs, trampoline_vaddr);
 
+out:
 	return orig_ret_vaddr;
 }
 
-- 
2.48.1

