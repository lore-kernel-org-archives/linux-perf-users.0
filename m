Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E81C38331F
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791325525; cv=none; b=l+iKhrekTVYE7YNXIn9iVr8Y78KlrzX5uA3IsieT5Palz6+0jMwaCQM+6+FwW3A6yQ2qwXAEUYLMKMM7oDfw8X6M4JlCvpEg7E4ruv1pZ7vndR1tnO+4nqcKCX351506SA2NTQHaOwdeYR7oO+DgMFe6WUB5RV8Nf9Sj39lcrKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791325525; c=relaxed/simple;
	bh=mKKUOWQviWFjUjH3NgXsORBNPllM2iw50/VL+63RLdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=faUjUhn2Ycdd3gNBy5TH4LvGJAlmQOfMk7eVm7h4G6zi3MR9h8dXYbz/XJ8t1Arn93S9xS2mxBSuryeqqa05FR/KCKu4U+uvmnZ1h+q9d1Ivyezk/Sy/956wTSB4x99NE1YSzzt+AammkKpszSsZBLHy6g++VRhEuqRUmDHiMDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=WGIdFtfz; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="WGIdFtfz"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4f6dcc0e8ccso957165b6e.1
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Oct 2026 15:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791325522; x=1791930322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B9bMA/wqgkNIID6ALHrOUYKWHPNnVIAY4hxt8u6miy8=;
        b=WGIdFtfzgEqDwQxp/rYVP88L8dAZQ2/K9OU2AzkY4ouO7R42bf6YzCxKrtJ7b71mT3
         gBfKhrDTDurmBSl4UEN73zZKkkvVtK1nBhlmrnT2imVl3fbaT6W1xJwY35WWoKkemyA8
         lDohzmMUYJQ84ICemFx2lZBAziu0AAQg65ays=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791325522; x=1791930322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B9bMA/wqgkNIID6ALHrOUYKWHPNnVIAY4hxt8u6miy8=;
        b=lpg7fx1EsM9Swo6kyEKLF88376xAu3TYJViYYwa2/2GKfahofxbKOtz8Yq8xTuEfdg
         wJajLeshaEe/Z+tfcS5b0yKnpTwkZcgj6k4OLTZ6eaJPQS/jRYVFeymzupBHPR/quqVf
         XW/6H728sUl4Jcp94+BIxIkQElsoNIBBomlpOBtU6k//5RHW7CPfGdMI0gQ7g9VEJK4k
         JR3db3VfH5D8pjPSoKosp8u3p1BAjzOd3Ga6XfO4Vc/1Jz9DY/TV4tOfSaOdaoIErrug
         4u0m3AGoDUBfXx0Ow7+WtT8dlBx4tLM3Vy28EVh3oAWVO7a/nlWM6uGUrpNte4XeXE7z
         n7aA==
X-Gm-Message-State: AFuF++m2Y1IUAjnCCLzldK/Xt0NTJWBJrMQOaCi7sx1aqXboqMxqo5ji
	Yx+FBYPlrUXZuAEUtWmaCHC8azWHM0fd6kN29g5nv1FZWBNIYhJ46rvplB2zfhlC3qFoYv+MBZd
	bh0GQf+U=
X-Gm-Gg: AYBFou3Y2dcA8W57+So+IOrsbpjWBtRszJmOAMFdaF2r5Zes3FHfQucwyJKAkaPgOEI
	0uHXLERBUnT30HL1FtLWJhEhmelP6y8ajq9qiRsg7wl+CnYaptMW+Zrs3NdEEb0jWj5/TOZ/6sl
	EHsDhXN59cRUy+A/IC2K51uUqBo84Dj9e/OJ7LLO7IBMOBRalGi3Yp8Hn51ohMqkK1zK3+rjkef
	Ltjt+PNXe1cDDKc5JnJtw/ye6f+LCiYITuh9w8uqIniyUTqKEynAwvP3JpvEix7oeU9ASBMz5u6
	SA8CrTRoAV5JDHt+cNCO68Sl2jEgQZ/IsoxBwoqSaDiC8C91QWuIYvzqNk5Wzx5JfHNTVXaeS7/
	msiuqbvzp+vMXEj9u8yk0IyuK2/er+DarDlLWntTky0ae9Cz3p/8Ljj1cZ2NJ+dLlkgbwRE8IVW
	wYFE5UyNaOky1zZbgqx9pgGZtlA/engYY3SmE85uHBi8BMiMIHIiP8TQYwQU9OP1xqDZ+g9raBS
	eVLV/S9P7C669EUiopdE8XFMTjnHS3L8TNDfyHco/2KgJSGnKSFEmeKb5I/IODnYfLebAwqBFwK
	qQeD4UrKhA==
X-Received: by 2002:a05:6808:2387:b0:4d6:9133:cffa with SMTP id 5614622812f47-4fc46c92c2amr471952b6e.33.1791325522192;
        Tue, 06 Oct 2026 15:25:22 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4fc484f7354sm604233b6e.4.2026.10.06.15.25.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 15:25:21 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH] perf/hw_breakpoint: Avoid leaking private x86 breakpoint ranges
Date: Tue,  6 Oct 2026 15:25:19 -0700
Message-ID: <20261006222519.43193-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An unprivileged caller can open a user breakpoint and submit a rejected
PERF_EVENT_IOC_MODIFY_ATTRIBUTES request that changes exclude_kernel to
zero. The architecture parser runs before the immutable-attribute check,
so an x86 blacklist hit returns EINVAL while an ordinary kernel address
reaches the CAP_SYS_ADMIN check and returns EPERM.

Moving the attribute check alone is insufficient. On CPUs without BPEXT,
an aligned power-of-two data range larger than eight bytes normally
returns EOPNOTSUPP, but overlapping the CPU-entry blacklist returns
EINVAL first. Such requests can keep exclude_kernel set and can also be
made through perf_event_open(). In particular, the __per_cpu_offset
check exposes the relocated kernel image.

Validate immutable attributes before parsing a modify request. Also check
x86 kernel-breakpoint access before consulting either private blacklist,
using the whole requested data range even when its length is unsupported.
Check instruction lengths first so that the sizeof(long) ABI does not
turn a single-address user instruction breakpoint into a kernel range.
Keep the overflow check, the generic post-parse permission check, and all
blacklist restrictions on authorized kernel breakpoints.

Fixes: e5779e8e1229 ("perf/x86/hw_breakpoints: Disallow kernel breakpoints unless kprobe-safe")
Fixes: 26c6ccdf5c06 ("perf/hw_breakpoint: Clean up and consolidate modify_user_hw_breakpoint_check()")
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 arch/x86/kernel/hw_breakpoint.c | 44 ++++++++++++++++++++++-----------
 kernel/events/hw_breakpoint.c   |  8 +++---
 2 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index f846c15f21ca..cf0d09cdf497 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -15,6 +15,7 @@
  * using the CPU's debug registers.
  */
 
+#include <linux/capability.h>
 #include <linux/perf_event.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/irqflags.h>
@@ -332,14 +333,35 @@ static int arch_build_bp_info(struct perf_event *bp,
 		return -EINVAL;
 
 	/*
-	 * Prevent any breakpoint of any type that overlaps the CPU
-	 * entry area and data.  This protects the IST stacks and also
-	 * reduces the chance that we ever find out what happens if
-	 * there's a data breakpoint on the GDT, IDT, or TSS.
+	 * Instruction breakpoints match only the address, but their ABI
+	 * requires a length of sizeof(long). Reject other lengths before
+	 * checking the address range.
 	 */
-	if (within_cpu_entry(attr->bp_addr, bp_end))
+	if (attr->bp_type == HW_BREAKPOINT_X && attr->bp_len != sizeof(long))
 		return -EINVAL;
 
+	/*
+	 * Check permissions before consulting the private kernel address
+	 * ranges below. Otherwise their errors disclose the kernel layout,
+	 * including for unsupported range-breakpoint lengths.
+	 */
+	if (attr->bp_addr >= TASK_SIZE_MAX ||
+	    (attr->bp_type != HW_BREAKPOINT_X && bp_end >= TASK_SIZE_MAX)) {
+		if (attr->exclude_kernel)
+			return -EINVAL;
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+
+		/*
+		 * Prevent any breakpoint of any type that overlaps the CPU
+		 * entry area and data. This protects the IST stacks and also
+		 * reduces the chance that we ever find out what happens if
+		 * there's a data breakpoint on the GDT, IDT, or TSS.
+		 */
+		if (within_cpu_entry(attr->bp_addr, bp_end))
+			return -EINVAL;
+	}
+
 	hw->address = attr->bp_addr;
 	hw->mask = 0;
 
@@ -363,16 +385,8 @@ static int arch_build_bp_info(struct perf_event *bp,
 		}
 
 		hw->type = X86_BREAKPOINT_EXECUTE;
-		/*
-		 * x86 inst breakpoints need to have a specific undefined len.
-		 * But we still need to check userspace is not trying to setup
-		 * an unsupported length, to get a range breakpoint for example.
-		 */
-		if (attr->bp_len == sizeof(long)) {
-			hw->len = X86_BREAKPOINT_LEN_X;
-			return 0;
-		}
-		fallthrough;
+		hw->len = X86_BREAKPOINT_LEN_X;
+		return 0;
 	default:
 		return -EINVAL;
 	}
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 789add0c185a..1f0e7f63ba82 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -765,10 +765,6 @@ modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *a
 	struct arch_hw_breakpoint hw = { };
 	int err;
 
-	err = hw_breakpoint_parse(bp, attr, &hw);
-	if (err)
-		return err;
-
 	if (check) {
 		struct perf_event_attr old_attr;
 
@@ -778,6 +774,10 @@ modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *a
 			return -EINVAL;
 	}
 
+	err = hw_breakpoint_parse(bp, attr, &hw);
+	if (err)
+		return err;
+
 	if (bp->attr.bp_type != attr->bp_type) {
 		err = modify_bp_slot(bp, bp->attr.bp_type, attr->bp_type);
 		if (err)

base-commit: fd179f8a05be3ccae366b9b96e176b51fbe54aab
-- 
2.53.0

