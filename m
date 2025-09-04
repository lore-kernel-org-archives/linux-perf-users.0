Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B0A1DDC1D;
	Thu,  4 Sep 2025 00:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945392; cv=none; b=kKFnuHp+zx74WyGfl7wTZF799JlN3tm0iQBhvP37OiUY+WIe9c0aImO+g7ghUPNefAVvSP6geACbSYHrONznxKzIVblfUFb4syTJmZg/g+G9x1kL+0t+ViIDIqm4QzMRRMVs4G4gk+usogVY/UNyMP7YGtK19MJyVak21ynrr7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945392; c=relaxed/simple;
	bh=CBD5TyJIG48zunzijV26LZ21NLQJuMz4rIJCSEL3zs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URn19UmLVOoeGSkKR6R4ASqNiWKl3ErlavLfodjZD+WwiSVEHXnV0dYgKnUvshQ91r/ANDMj4D5JPMV6lPIrlZM9Q1dqvTspUAgJKdgWMZcyk/Ka16ze8i8VDGqirBqzOe5drqHiqOnaAwsRQkFRYgfFSP5RdUNGW5gDjaVL0EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXThaLu5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXThaLu5"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so540682b3a.0;
        Wed, 03 Sep 2025 17:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756945390; x=1757550190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZFeltWH3JIFgXl4IiDP3gNU26ULKF6mUGhK5pmKxrA=;
        b=KXThaLu5PQ1QRAbehqvPYIm2+EaeyOggCXGVOIk+u0cdCmG9D6PasfoxLgIiIGHlXd
         ooMwCjXZ+7P1efI6DcSr0aMuQhc4+WAKRAYMtqUYMCK39MtJ0NAjnPbucxGE3vQLDQv7
         5DO+cW0jKpE6+qpyZau6s4+xoIcRa4GidV1QNw6PSiK/3mBWDP8KeYmajjxlJtoPz0id
         i2NTQNdKthZTTOPA/kSKatA1gA5uN1HQ3g1u04DN+gZaTiofi8wJ3EPlnytPiruABUu+
         iBr1kUTncYWrO8H9E0wS4ffM7YFw1GxfLn3T6pnQTw2234ssAFqqFUm6PgHo4ho+rF4M
         +dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945390; x=1757550190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZFeltWH3JIFgXl4IiDP3gNU26ULKF6mUGhK5pmKxrA=;
        b=AbOYEulfYOQ+RamgE1o7ZKJV4Jh0Gtvu+KO9eQswUH5joXhXNGaTey3M2D8EzW7OiY
         tFiUwXT8arYKbVj8Pn3g0OrbkeCrJjM20vqHwwZ/NPlBVKIeB5jGLPeiTsvx7/BmAPp6
         8upcf030SiL8hctrqwZDG02ZMzBpbn5xBwyAcV/Vx9TGtaIfGcjoAlYqT6BCyFoNcFf7
         k8hxrUQiQxiOQKdq22KhmonKJJ37EDPVkp7rRmNE7jWtdPTY16VHcrko3tHbNKsWw0LF
         /EGQyiftzwHM5iJUjLiiMIwFNFXawflNcy+k6rmqrlN9FLyoBw0E46hd8tZE3izlAeHd
         5ICQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXmOkPN+lJ26dkO2oiVcmUuiPOVXE7M5Oe39WmDEYgp2Kh96Uko9KBK3lkSC6S3W/mmbZF89XryUzCT8zT6tkUmjOR@vger.kernel.org, AJvYcCVF+lsJ11adNjnaK4xxrNUYwUIPEt+5jOqX1GHKvNHnqXcodNifjPRr+Y+5rEgSrEYCPS1lU/XA9VdketBtqEsi@vger.kernel.org
X-Gm-Message-State: AOJu0YztThtnrbg0hQhfZEI7dtlZMOtNKkVbsdfOYsei678WqeWAjDpt
	dYjFijQrkNbWThPEBiWzj3OYzaI1m4yaoP/YTl7Q2HFmuZWa3WKjnJ/c
X-Gm-Gg: ASbGncuX2xO1dR47CyzfjP0+0Nx8KQWKtQQh2GO6xSvektMYuSortYfu/02lZsljNKy
	ou1l8VubKHevUmf3PaQbaCZOL7IuDjHxX2c1JKIdNwQlk/6ebi/JRZgvlfSsVAD0uZixuNcjWta
	g8S0+ojsmhbXDva7DL3dcSuEraaMC0wIAv9TII+4CHK4KVnMCSM/dialpdMuDFtvlYuqLYvbe4B
	DfI94GIaM/1kCYqVpnQ5F+xb3DbQ8YlKQO87BH0w3Tv1eLi9A+weW1sBA+BDB4Ak5RYa/nkets+
	N9Jo0LCxDPuOuduNtpqjjN/fzJsFG951N8qPmaaYgVXCETcbMrLwu4R/uKEsgWATB4fh/7MFsYG
	vkdFod2m0AT3YDW7J8Ma6nsYUq0u9+Gu18me3eRijJVkFv02NNlaliL7NeMD5pvjpQCMXZrekiA
	==
X-Google-Smtp-Source: AGHT+IFgl+sw+tmEYUJ4upz5Un2DxoHCv2E7JtarNm7ur8WtEKTrx96zo+yDn11a5xFBTb7wAEqpBg==
X-Received: by 2002:a05:6a00:180a:b0:772:ce8:d894 with SMTP id d2e1a72fcca58-7723e3e3aeamr22624402b3a.29.1756945389846;
        Wed, 03 Sep 2025 17:23:09 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bd2aesm17579551b3a.48.2025.09.03.17.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:23:09 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v2 09/18] mm/ksw: implement stack canary and local var resolution logic
Date: Thu,  4 Sep 2025 08:21:06 +0800
Message-ID: <20250904002126.1514566-10-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250904002126.1514566-1-wangjinchao600@gmail.com>
References: <20250904002126.1514566-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement logic to resolve stack watch target for kstackwatch:
 - Locate the stack canary within the current frame
 - Resolve local variable offsets relative to the stack pointer
 - Validate addresses against current task's stack bounds

This logic prepares watch addr and len for use in kprobe/fprobe handlers,
enabling dynamic stack monitoring.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/stack.c | 99 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 96 insertions(+), 3 deletions(-)

diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
index 3b72177315cc..00cb38085a9f 100644
--- a/mm/kstackwatch/stack.c
+++ b/mm/kstackwatch/stack.c
@@ -1,22 +1,115 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/fprobe.h>
+#include <linux/interrupt.h>
 #include <linux/kprobes.h>
+#include <linux/percpu.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <linux/stackprotector.h>
 
 #include "kstackwatch.h"
 
 struct ksw_config *probe_config;
 
+/* Find canary address in current stack frame */
+static unsigned long ksw_stack_find_canary(struct pt_regs *regs)
+{
+	unsigned long *stack_ptr, *stack_end;
+	unsigned long expected_canary;
+	unsigned int i;
+
+	stack_ptr = (unsigned long *)kernel_stack_pointer(regs);
+	stack_end =
+		(unsigned long *)current->stack + THREAD_SIZE / sizeof(long);
+	expected_canary = current->stack_canary;
+
+	for (i = 0; i < MAX_FRAME_SEARCH && &stack_ptr[i] < stack_end; i++) {
+		if (stack_ptr[i] == expected_canary) {
+			pr_info("KSW: canary found i:%d 0x%px\n", i,
+				&stack_ptr[i]);
+			return (unsigned long)&stack_ptr[i];
+		}
+	}
+
+	return 0;
+}
+
+/* Resolve stack offset to actual address */
+static unsigned long ksw_stack_resolve_offset(struct pt_regs *regs,
+					      s64 local_var_offset)
+{
+	unsigned long stack_base;
+	unsigned long target_addr;
+
+	if (!regs)
+		return 0;
+
+	/* Use stack pointer as base for offset calculation */
+	stack_base = kernel_stack_pointer(regs);
+	target_addr = stack_base + local_var_offset;
+
+	pr_debug("KSW: stack resolve offset target: 0x%lx\n", target_addr);
+
+	return target_addr;
+}
+
+/* Validate that address is within current stack bounds */
+static int ksw_stack_validate_addr(unsigned long addr, size_t size)
+{
+	unsigned long stack_start, stack_end;
+
+	if (!addr || !size)
+		return -EINVAL;
+
+	stack_start = (unsigned long)current->stack;
+	stack_end = stack_start + THREAD_SIZE;
+
+	if (addr < stack_start || (addr + size) > stack_end) {
+		pr_warn("KSW: address 0x%lx (size %zu) outside stack bounds [0x%lx-0x%lx]\n",
+			addr, size, stack_start, stack_end);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
 /* prepare watch_addr and watch_len for watch */
 static int ksw_stack_prepare_watch(struct pt_regs *regs,
 				   struct ksw_config *config, u64 *watch_addr,
 				   u64 *watch_len)
 {
-	/* TODO: implement logic */
-	*watch_addr = 0;
-	*watch_len = 0;
+	u64 addr;
+	u64 len;
+
+	/* Resolve addresses for all active watches */
+	switch (config->type) {
+	case WATCH_CANARY:
+		addr = ksw_stack_find_canary(regs);
+		len = 8;
+		break;
+
+	case WATCH_LOCAL_VAR:
+		addr = ksw_stack_resolve_offset(regs, config->local_var_offset);
+		if (!addr) {
+			pr_err("KSW: invalid stack var offset %u\n",
+			       config->local_var_offset);
+			return -EINVAL;
+		}
+		if (ksw_stack_validate_addr(addr, config->local_var_len)) {
+			pr_err("KSW: invalid stack var len %u\n",
+			       config->local_var_len);
+		}
+		len = config->local_var_len;
+		break;
+
+	default:
+		pr_warn("KSW: Unknown watch type %d\n", config->type);
+		return -EINVAL;
+	}
+
+	*watch_addr = addr;
+	*watch_len = len;
 	return 0;
 }
 
-- 
2.43.0

