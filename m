Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FF7257844;
	Wed, 10 Sep 2025 05:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757482342; cv=none; b=XcFAuxQMGRP66VZAUOjgJzgBITXD3QmCuArahpLI55jBS2OTIFXNnqL59wgPz1olzqJd6v0n6auaR/opFyQanD8w7aahXnFd2JlDQUYND+MEKBDPqjQibieg7pB4/XG15Sm3TGtLIWq+1KITAEBwnriVxHByVGlroD3Us3JmoAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757482342; c=relaxed/simple;
	bh=6cHWKtFXDEobLmTpiA00q/YbyubIOqsYm4t+n7QmsE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3WYdSFOzBpqQ3I+nHYDtTxmhSbHe+1E5oNEFLsEe1dyJXfj/6lbIYhXiRfm5GIpWVKBANVvThj0phWrhI/428q6NAqkrKl5PdqDioEQBNNo1PcMl/scGQ5Jr4wJG5wIpKLX3gs0gK/yfwOcIbwNB6y+49yC996O8dqIXFVO2xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Saa5KRXN; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Saa5KRXN"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-772481b2329so6681301b3a.2;
        Tue, 09 Sep 2025 22:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757482340; x=1758087140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaYg+/0/ozWnszVW1Vg9icfOKh+UQdPJqj98WeYrJSI=;
        b=Saa5KRXNcJ/Xr6skr0uXpDeZaKq0fS0rL0blyaGLGSODVil0tlAkQtwU+wGhlKF0O1
         bvBjWwyMSTfRXjldU9X3Ew8XhzkWkNnWap9d7nKdOTvNu92G6bZzRef7cmpLwf1DIx2H
         CZI1N2I0hjzXZldo/KOGY0FEVoGinVLnv8fl43MfCEhRCGobm75KuaH6ned0xlC32gf7
         2VPb96h1jdyt7BqnlIPb5AFnLCMCH77LIqd2CbZicVOFE803IePOGwh42HDgDXb7GBVV
         Ug6ogiv+NfSEHt+LjmDmTj3+y62WWi83AKL0Y+QXKUxwmyYIePy2otJ+Hu4+I9LHQM2G
         G4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757482340; x=1758087140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gaYg+/0/ozWnszVW1Vg9icfOKh+UQdPJqj98WeYrJSI=;
        b=NRrC1wT9VFeSfNHDGFjpDyYwmRSZ4DCcZqPnhvb291YDWVkzCXYsh7VFKFG6C6PniY
         rsx1a3SVogZe1QwvpPVuyQi3cQAiFFwW8AEvA+roeu+GWzsAu+i+HFPyFBhV7U8NzwiU
         6k6en0n9wYNMqc/yEEol1HNMoTXO2CwG9tODvgKnIcG7rFYRYqoA4uUFiCUqvPZyZbWt
         AzykZAKUHfglb78MK9pXb7nxkDfqpRQLNxUMDTvgHfPgCnUFc22kXVJyX5EqDrfD94dH
         +6wQZkvZEchcSRx30hjdzCcVCmVegXfQ1zNkv2SAQH6NhpUE04zpJzibIrbTPuKfWUVd
         rhGg==
X-Forwarded-Encrypted: i=1; AJvYcCWn+hnoPzLRD2yjcpAYELa683gYuBsCtf/HRoD2JtCWZPaDY5+GVaqSEn36nivevazV7WDgAFXnGcCQoiiCtmRs37IT@vger.kernel.org, AJvYcCX754kcox63t19qZFOtpmvDU4Zn6jY9fJQsEqr5oboLQO1KcSQj8o3S+SRwluauC/on2gLeBcXwYt7UeeXP1Uqk@vger.kernel.org
X-Gm-Message-State: AOJu0YyN/qkUDNz7SX6SD/4YLlm/Jaj1sUFJ9c/BjVgUYpENeNZEGkI2
	SqkbVekwKAsnitzfEBrrxPXtB0+u0rOt+C7PHutKo2h1SHztLqSjDGt+
X-Gm-Gg: ASbGnctohKv3px7KHUZUjdaTBbpqjbss+ow7ngEAZsEm9NsavV9m0cfCChu9Xa5Vw2a
	3k8d0EwotasVINRQxOVJe8EIWA+AQGd3Y7pBVSNckebFYVkcGGt7b5cD/zH0bRz9e9hUYHE+svx
	GGaqkRUrMGqXH7Q9DwbVrtzOpOvBNeBbj9paXhT4dZmG0hDWmKbt5gLVyVByB/jIVbEGuL+P8Fd
	ugJfuVmTGP6bonQ+SlJKQeR9G112HPJHL9DpkVdru1S3J/fdUgnMvmZhx3B10DyGyr3IFmGSHSs
	70MiuSnUGlxDdDeejNlC0qdmSLa5GJzgAXobgyyKEwv/YAAhCv/hpJ+kMIxhuAJb42nRd15c7+U
	gEp3BGnT2/QSeXUv6+/bQRAbEic3v3RuXar56rgHsg/rSJPRsNA==
X-Google-Smtp-Source: AGHT+IHuUHMUgi5NSwlSeu8nV+hOLxDbRn5Z00T38ZbQ9cPN7nadv+zQOWHqDyDiQunbFQJUcaGXvQ==
X-Received: by 2002:a05:6a00:1a8f:b0:772:2850:783d with SMTP id d2e1a72fcca58-7742dedf06emr18816777b3a.22.1757482339803;
        Tue, 09 Sep 2025 22:32:19 -0700 (PDT)
Received: from localhost.localdomain ([45.8.220.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7746628ffbesm3870342b3a.66.2025.09.09.22.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:32:19 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	"David S. Miller" <davem@davemloft.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v3 10/19] mm/ksw: resolve stack watch addr and len
Date: Wed, 10 Sep 2025 13:31:08 +0800
Message-ID: <20250910053147.1152253-2-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910053147.1152253-1-wangjinchao600@gmail.com>
References: <20250910052335.1151048-1-wangjinchao600@gmail.com>
 <20250910053147.1152253-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helpers to find the stack canary or a local variable addr and len
for the probed function based on ksw_get_config(). For canary search,
limits search to a fixed number of steps to avoid scanning the entire
stack. Validates that the computed address and length are within the
kernel stack.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/stack.c | 86 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
index 72409156458f..3ea0f9de698e 100644
--- a/mm/kstackwatch/stack.c
+++ b/mm/kstackwatch/stack.c
@@ -13,14 +13,94 @@ static struct kprobe entry_probe;
 static struct fprobe exit_probe;
 #define INVALID_PID -1
 static atomic_t ksw_stack_pid = ATOMIC_INIT(INVALID_PID);
+#define MAX_CANARY_SEARCH_STEPS 128
+
+static unsigned long ksw_find_stack_canary_addr(struct pt_regs *regs)
+{
+	unsigned long *stack_ptr, *stack_end, *stack_base;
+	unsigned long expected_canary;
+	unsigned int i;
+
+	stack_ptr = (unsigned long *)kernel_stack_pointer(regs);
+
+	stack_base = (unsigned long *)(current->stack);
+
+	// TODO: limit it to the current frame
+	stack_end = (unsigned long *)((char *)current->stack + THREAD_SIZE);
+
+	expected_canary = current->stack_canary;
+
+	if (stack_ptr < stack_base || stack_ptr >= stack_end) {
+		pr_err("Stack pointer 0x%lx out of bounds [0x%lx, 0x%lx)\n",
+		       (unsigned long)stack_ptr, (unsigned long)stack_base,
+		       (unsigned long)stack_end);
+		return 0;
+	}
+
+	for (i = 0; i < MAX_CANARY_SEARCH_STEPS; i++) {
+		if (&stack_ptr[i] >= stack_end)
+			break;
+
+		if (stack_ptr[i] == expected_canary) {
+			pr_debug("canary found i:%d 0x%lx\n", i,
+				 (unsigned long)&stack_ptr[i]);
+			return (unsigned long)&stack_ptr[i];
+		}
+	}
+
+	pr_debug("canary not found in first %d steps\n",
+		 MAX_CANARY_SEARCH_STEPS);
+	return 0;
+}
+
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
+	if (addr < stack_start || (addr + size) > stack_end)
+		return -ERANGE;
+
+	return 0;
+}
 
 static int ksw_stack_prepare_watch(struct pt_regs *regs,
 				   const struct ksw_config *config,
 				   u64 *watch_addr, u64 *watch_len)
 {
-	/* implement logic will be added in following patches */
-	*watch_addr = 0;
-	*watch_len = 0;
+	u64 addr;
+	u64 len;
+
+	/* Resolve addresses for all active watches */
+	switch (ksw_get_config()->type) {
+	case WATCH_CANARY:
+		addr = ksw_find_stack_canary_addr(regs);
+		len = sizeof(unsigned long);
+		break;
+
+	case WATCH_LOCAL_VAR:
+		addr = kernel_stack_pointer(regs) +
+		       ksw_get_config()->local_var_offset;
+		len = ksw_get_config()->local_var_len;
+		break;
+
+	default:
+		pr_err("Unknown watch type %d\n", ksw_get_config()->type);
+		return -EINVAL;
+	}
+
+	if (ksw_stack_validate_addr(addr, len)) {
+		pr_err("invalid stack addr:0x%llx len :%llu\n", addr, len);
+		return -EINVAL;
+	}
+
+	*watch_addr = addr;
+	*watch_len = len;
 	return 0;
 }
 
-- 
2.43.0

