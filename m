Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF642EBBB7
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671978; cv=none; b=qFsAVRKiwb7cJdBmUZ3Z8q0Y/mdTCQnd0hoyLyuMyWU1LZPDOGrnG3GM5fRF9byMmf3jA3kHidkzgsUzswAN6ybpIsB37BN6rK1o6/jUtwQeBBhQ5q4/tCaHwmUeTzY4M76o3h16jKXc+u2gG2aILnzcUic2eYBld3Y1VeYPkNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671978; c=relaxed/simple;
	bh=6mefF6IMMzyvYBUHPb6m4n0UB5fHQfdxvPTrHUmunyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxcI47Y/yFwl1VcvwFjfjJR8Nok1fOCkMoBVkaQLSOpJLAH6cKucFMKkfRq0ZbuV95uds+A8S6app5kfBMxrDpAzF7Lm320ru3hQM4hNs7it3G7sjYdkteXBLIHfaJEJJ8T/X9lu3qclXKNHZ9c3aIVQtGmfzcDue5cWxLij5+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvO85rwF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvO85rwF"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-244580523a0so17359245ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 03:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671976; x=1758276776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwBrRJrnxCqu1u7UrV9e609up8TstQr3mGzjgxeQ/fA=;
        b=PvO85rwFE+AFthnd22KtiyMXusH738r4OMXw2fZ9VzfnQrqCGup4UKQz5fYhdpFWYd
         Ffd0dZ/n7VafldJrABpQ55J9n+PB1T7eVmgnmHp+KNCkqZ9ZRk8ckq7DotHot6OY+IBg
         pCbpV/T5guQi0IH8QXNdaSt7xTNNuKC3gKJwl/u1fSrhI+6Vihi6STUgmfq0anhSqQAU
         HsqIqc618JiCafF0EgtDPY5F8JRpGqXEjBmSUvK/YPy3k98rXQ9jZ1N6cw4cZSFRlizi
         dXjRgM0HRsZEspTVExv7LgtV/KiSPYTMRt3ILK+wL9LWVLcY7XtBHRfUwdkDyzW3jBHu
         hiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671976; x=1758276776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwBrRJrnxCqu1u7UrV9e609up8TstQr3mGzjgxeQ/fA=;
        b=ePgIesL2N+lM/+lOjIc+dYEWZjUBktpFZf42GxavGnRpDjNc+GoVWh4E0ttHO3dm2T
         CzbiZm58Xwb5PocHH2fZChPiqwwcGQLw+798l5QNAMUszZT+tjUulzoZLaODmqHip0zu
         2kBGNzMt2zCXaZVDXUIws7pF3yRoN+xNVXjSLxjBj4Cv90S/NkdaVGhsOd58ISt2Jp3O
         fL9ndwwVoP2uhaeZ7N0O5qHUquVigdIDlJ5bn+vAObJmZgD/QH8ieGlF+YlsHbqi8wyt
         t686QQ0rriIIrAFeJl/2S4uynUtGwmwpSR0c2P+Mkz4pw2H0HOXH/InfGKSBc6GrCNKf
         JfeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7e59TVsZ7pvKXxaY6TJejLQKmLHx5k9cuqa3fRico7XAq9ROZ1QYPXoal3Xml95mSQyWpM8YmrqHCkKiru5NL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0b8/ZVU9pS5eILZACErb/ZBlNUsUFkM58ltYJePcHtgdJCbI6
	mYlpENf1X9tADByCxQGbWsxto+WYNqJjxBcoR60KUtL2svluSSxJcbPM
X-Gm-Gg: ASbGnctIQV1PnUFHj+UNvu7N8RqX/LAQwq90790R/ImSLXojywQ1YDC/qXI/yJtkJAb
	d7c9VYH0ivCq4iEvj9qG5BHNH5Hf191rN7q/i6u+m5tYiXpflUSvCGC8IGLMqHxd/RGrMwO8+dL
	tMRyu4Qh2yv2tIiLclju9QpYA/+Ne+xAXsHDup+ZmCYYGUcrCMDYAU6HWh1YeiiC8L9w+lytJNc
	DtSJO+X8IhvpyTHB5g6rlRfEBcGBWDK4K0EyWYfpFnvPDo1XF33P5xYHGu1yMQzCLxOz1k6YvJn
	7k1POkZWSh4WYP9ijUB/M5cv/SESvHunjljQqEJu4ew3YdnChIttZoZjoHV0nrDgGLxfZ5t2SLm
	q5/kdX3WSRqmk+MiKLbiciKv9eSbsRw1igXwOdqI=
X-Google-Smtp-Source: AGHT+IHmhDxbrAgWt/ZFf2b2ARujdiSrTzk9h/pJ/Apo0LVYSifl646MIHmgwZB8g3f29HVWj78WGw==
X-Received: by 2002:a17:903:2f0d:b0:248:79d4:93bb with SMTP id d9443c01a7336-25d26e449b9mr26345655ad.31.1757671976359;
        Fri, 12 Sep 2025 03:12:56 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc6af7sm44843015ad.5.2025.09.12.03.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:12:55 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
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
Subject: [PATCH v4 12/21] mm/ksw: resolve stack watch addr and len
Date: Fri, 12 Sep 2025 18:11:22 +0800
Message-ID: <20250912101145.465708-13-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912101145.465708-1-wangjinchao600@gmail.com>
References: <20250912101145.465708-1-wangjinchao600@gmail.com>
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
 mm/kstackwatch/stack.c | 88 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 4 deletions(-)

diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
index ac52a9f81486..65a97309e028 100644
--- a/mm/kstackwatch/stack.c
+++ b/mm/kstackwatch/stack.c
@@ -9,18 +9,98 @@
 
 #include "kstackwatch.h"
 
+#define INVALID_PID -1
+#define MAX_CANARY_SEARCH_STEPS 128
 static struct kprobe entry_probe;
 static struct fprobe exit_probe;
-#define INVALID_PID -1
 static atomic_t ksw_stack_pid = ATOMIC_INIT(INVALID_PID);
 
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

