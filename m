Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D11E258ED1
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 02:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200336; cv=none; b=dptQ9bo8HPFiEr6pnuZl6JT4a+IaZ33ZdXy/510yUBfAH+L0ho8vWJy2PNIroSWHE++WKV2pfyvf7TxzkYGmHJIyUltXcsZf7ki0mnTqOz/fz4BDIXCPtcr9TaURRGLKmKnEDk+kC9cWxkICors3A3hUaSFgnZxMJHB3lqNnEuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200336; c=relaxed/simple;
	bh=ye1IFedT6QyfAsl7NnFp/ScKqi80nwnk9udpC+1GQaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUD3Jo/iRO4fEA/LFrgxVawWShGW9/ER5ijpATHlHGEqbrAQ+S+RIyhWRJhpS28EXtIQ7pmfK3IfiRSW/YV3n75dDQ+CyRo2hJcuRdyAp7f9j5VYY9IKhHtvA46GN/u/4febES/qFh5mCeFERJwlOaOm56mXTqkeYUy+osFUoNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jha/9BeC; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jha/9BeC"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4737706b3a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 19:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759200333; x=1759805133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RtyZdLa/V9peD4vyIt7vF3g+yVd+tHG9wNYuCcZNH8=;
        b=Jha/9BeCuaRtE0JfPKt3h9P0e7AHRjWzzXJ2XqL365I45C8+45IfFKvWrjyZA8GECL
         JFOFuxqDhAla9JTIKjfLW561RXAL3wPtz1g3UrXL22umArjaXaOGOLGIX/nksv1fa786
         FTlmUTwlyFV/hV0kmwr7t4nvvo7WV2bbIuavbBa4uCNjVJ3Lq81HBtu/oUpYrlYZuFlg
         k8MvVu3ertyf2KcFfL3/slcQAcf7CTQzsv/dlxMPjgbKKuWslzvbPyibXyTo3z8cmraS
         Qdm4ZnSKQ6OmEb1xVmwu11spf+1JfEuOf8Oirbr06Aodsd/uc1Ft9e4muhpcLlXUkMPN
         b6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759200333; x=1759805133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RtyZdLa/V9peD4vyIt7vF3g+yVd+tHG9wNYuCcZNH8=;
        b=GqIFVlkbywp4EWMZkdl3beQui+D0S6QsqZ+KNzEuS9zB9xZAGU0rNKi3J5O4MMk/CY
         fbFKdVVHXOsNfGn80d8Q6zFZGxFzwi+sXnV2/k1wMicDaWRx0KJvLh9BFawL8A7LAqaw
         I3KoVPewElloVBrisXWl+M/52kR8K2/AJcuag9OWbkdPcLDob/i/N4qdYGNXYhRXwPnk
         ureJuraXVdmZMtayMGty+ZW4Yii02zjStIBIPGbm0EwHAMKvZwuOGAkLZeEjT2+wkPGg
         uDLpVtKmPnvKwgn83hqQwEB2zHSLBMFi51BtG4BwMj3VzD+lCwdIvNWrpJ3ibRR0RZZQ
         biuw==
X-Forwarded-Encrypted: i=1; AJvYcCUVPd8FJ1cG8hqnrJ10iDH0dSOJVwe5PUjhZT1NEsrJx+I2sSVgyHlKHPMbzK+bQ+MPebC4KuASUu6v0ejcJTuI@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+wjr2ntzFRMBUrOAbO/XGk93gMfRa0xTFxs7P7jUlSQDH22+6
	L81xPXuMV+XVTmOcjVTNvLph7fa5BxRtqPKUci4qBaWg71F1Gq8xhk+N
X-Gm-Gg: ASbGncuEPTaouQwLmIQiwRYkm87KytT33JFvAbBmKH0gZgg2KAmAXYk3VwzZ+R4xI7p
	GhjzZmuOn41aEFfULSOOC3C1QzAXlhwMsAHiXA5IrPEj220wglFaAxz5f8xzx9TSorgsFJwxeKK
	sCjb7DGyqP+FPOGvFbS1pyZiaqTA1PTIaw1/BKNziaMsMRfBc9Zu7918ssP+eXMpBPbzKujqMVj
	a0QJCSyrfgcpVsFHRufwyJRLb2oc5L28U4uxiGXt6CBthUI8nKfpwwMRMZVc8kwfyHlERAYrSc9
	AJgIhY++Delqjq8loKGGOcgLeeZFUzLHE/XJ86X6AjMHHBjSKLk7+3EHS3N2EY3u5+UWtxgjgGQ
	9UDAkPUDO5C9RHAUuv11E1U53k6STzbLuh4tmx/ALuhhEC74DPBOdrkiGKzP/4S9OraRNCTlbKe
	84
X-Google-Smtp-Source: AGHT+IEsif2bxHXvYWWChBgM/szcD1tJlw9HGin9oZWPM2Y8lHrYniUGiEidosj0MGkcbXMNhwhy+Q==
X-Received: by 2002:a05:6a20:9c8c:b0:248:ef8:66df with SMTP id adf61e73a8af0-317732b6b3cmr3072325637.30.1759200333340;
        Mon, 29 Sep 2025 19:45:33 -0700 (PDT)
Received: from localhost ([45.142.167.196])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53bb255sm12683002a12.5.2025.09.29.19.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:45:32 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
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
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <kees@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Rong Xu <xur@google.com>,
	Naveen N Rao <naveen@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Nam Cao <namcao@linutronix.de>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com,
	"David S. Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH v6 14/23] mm/ksw: resolve stack watch addr and len
Date: Tue, 30 Sep 2025 10:43:35 +0800
Message-ID: <20250930024402.1043776-15-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250930024402.1043776-1-wangjinchao600@gmail.com>
References: <20250930024402.1043776-1-wangjinchao600@gmail.com>
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
 mm/kstackwatch/stack.c | 77 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 3 deletions(-)

diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
index e596ef97222d..3c4cb6d5b58a 100644
--- a/mm/kstackwatch/stack.c
+++ b/mm/kstackwatch/stack.c
@@ -9,6 +9,7 @@
 
 #include "kstackwatch.h"
 
+#define MAX_CANARY_SEARCH_STEPS 128
 static struct kprobe entry_probe;
 static struct fprobe exit_probe;
 
@@ -59,13 +60,83 @@ static bool ksw_stack_check_ctx(bool entry)
 		return false;
 }
 
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
+
 static int ksw_stack_prepare_watch(struct pt_regs *regs,
 				   const struct ksw_config *config,
 				   ulong *watch_addr, u16 *watch_len)
 {
-	/* implement logic will be added in following patches */
-	*watch_addr = 0;
-	*watch_len = 0;
+	ulong addr;
+	u16 len;
+
+	// default is to watch the canary
+	if (!ksw_get_config()->watch_len) {
+		addr = ksw_find_stack_canary_addr(regs);
+		len = sizeof(ulong);
+	} else {
+		addr = kernel_stack_pointer(regs) + ksw_get_config()->sp_offset;
+		len = ksw_get_config()->watch_len;
+	}
+
+	if (ksw_stack_validate_addr(addr, len)) {
+		pr_err("invalid stack addr:0x%lx len :%u\n", addr, len);
+		return -EINVAL;
+	}
+
+	*watch_addr = addr;
+	*watch_len = len;
 	return 0;
 }
 
-- 
2.43.0

