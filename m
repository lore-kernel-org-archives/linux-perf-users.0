Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D443E2F0676
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672001; cv=none; b=KT5v/z4ajzgOZemFSObr1sCxe6UdHbYACWiDooEZkfFikmUux53i0z+iS9h/ThU1anh7ZWm+G0EnOcoraJ36cOAt1RkbjSPjn447LHt3hxVW4XumWdyXASWXEb4LtvwcT/5Civ/qUfbETt++UGMutNTmKx/sq1XbYg4LWpxzjsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672001; c=relaxed/simple;
	bh=0pYLSOeA0PAf1TeSGJQVGULqR9LKSdf8J0mO6JXy6uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPpEcMrmXq6W4otyvqnDYcGGVk/CDN0bEJfw988DYou77stMfH2CFiFme7K7239X0jlHy4TH8LJG42P58xFdUmdipXcIElKr+EbxRvqEUCsJYw9ErXTgurAThEQV/GYRJ2GiVtbQUrSsQW2N2X7OSZxCJpVjGJqE9GYf9xfYeoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Db3HAijE; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db3HAijE"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7761a8a1dbcso175543b3a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 03:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671998; x=1758276798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6BBsZfnmfgl1Jgn+pU00vd6g5c1DTmTteWqGp/Sk64=;
        b=Db3HAijEZOAxxCS4azI+v3897g+Px4fNXXX8O1J57b5GaVlBDxGdpcMW/NK0oxC1Hy
         AKBZdwFXD5RI0k3g1X5Bfm08BtJSpjbZaoolfuK/xgPDTaJFTaC5lT+EsN44WYulgcDT
         IqJIbHCL5SSWb8q04xRt917RijNp4uyDzvxLhNHfRFEeBqkViPBjVsQdLA/i27Ihqjob
         roogCkLcI1JphxyRD5NCgMQyvGy/eWVkyVB0ImXaKoJaNa58cWmIGxJvPfi1k8SEdR2c
         bEX3rP1mEkvfaZkzQoTHkYLy8pZhZDLUkhjYyumlvg4kspuTDl9j/kF5qzM8Iw0zcCxF
         nQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671998; x=1758276798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6BBsZfnmfgl1Jgn+pU00vd6g5c1DTmTteWqGp/Sk64=;
        b=XvCWdWrXvmR5DTg1o9e2Prfq0CaBBZkx1yUTzg4N5FX5fzqgETnQRgPTruzmiTJTZr
         JfFRlWpehggEifgBdMlQ79aoUNRlA9cgq2A7pf7xY8WzvRkRzZpZenDwm53ASMQbCfvw
         sEpIBLmhWYoFLH8PfD+VuFkYhWrRavJ80AwSr58zs1HP8NVBzktuwZpLF9ULi/sWER4v
         PxuSV4Rl+A+EQz7TDwaiVYbU0hqJ77Ct+QoQCj2UhOvuOuvbRTM9wLgkjuJGQ6kuc2cC
         Xr5ewZIuIx4S2V5/1/bNXEYx7rg+K8puBdNONb3FTyDn206R5OxR26l+VaEdjLXp6H1d
         p6qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNyFyYmWCLQQJz1A3bdxLpTZhqi2Ao2yuKH+YAt8W1I+8VwoM/bBi14XYc2bOH8ALxR9h1mH39q2FDCfBR6Jm0@vger.kernel.org
X-Gm-Message-State: AOJu0YwkEbRdusqeVfR5cQeAOc5IiBdTP0yiw/H3Y5i+MY/1MlZs9di9
	wX6XKobw51uKxlQlPV6K8UX3FVRtvPNZPzkZi1YBDwQHnw/6uM28kjGV
X-Gm-Gg: ASbGncvb9Js4yf8o60YyomBwf4WUX7PovVj3sj/XlyvzHZ0xS6+qcuWarUFiW5O0Z+R
	cdugwVf+YrMidokzj4ETvoaHf0J69FewgYrMlGDTPOnoxekGmgLnyfGkWlrCzjay8iS8hYE9Mq6
	N9mvJ3oUQTNX89FkPQ76QKum3mUq4eeBuQ2r6p6tdYZ5x1SxDjFnnJbJTUtzXdepHyoFfE2E+NV
	a/kgJXWurTuqGwxkgq9TEpi2wUBi+dd9aXpeGl26O+2gQh9AFoRvic3XFCmBdBCY2YEMaWlf3Df
	KTuS+WStEG0Y45fZXqW+Aealb71Z5QuVWuk0REdMrFAN03K+zz1PMUBkHelmRw+9Or67GFqtOpc
	W3q5VTM0ZtRdz8EpNl28h8OZGQna/u0Swxquw5JZ5waFvLA==
X-Google-Smtp-Source: AGHT+IFP0Z697TA4h3v44yo8u1mt3XK26j9kYKC9Oe9buFWhspRDiIMhNWMUBIxM8GwcPJ0/MCOUpw==
X-Received: by 2002:a05:6a21:33a6:b0:246:3a6:3e41 with SMTP id adf61e73a8af0-2602a5937a8mr3020791637.6.1757671998049;
        Fri, 12 Sep 2025 03:13:18 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98b43a7sm5206301a91.13.2025.09.12.03.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:13:17 -0700 (PDT)
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
Subject: [PATCH v4 16/21] mm/ksw: add stack overflow test
Date: Fri, 12 Sep 2025 18:11:26 +0800
Message-ID: <20250912101145.465708-17-wangjinchao600@gmail.com>
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

Extend the test module with a new test case (test1) that intentionally
overflows a local u64 buffer to corrupt the stack canary. This helps
validate detection of stack corruption under overflow conditions.

The proc interface is updated to document the new test:

 - test1: stack canary overflow test

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/test.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/test.c b/mm/kstackwatch/test.c
index 76dbfb042067..ab1a3f92b5e8 100644
--- a/mm/kstackwatch/test.c
+++ b/mm/kstackwatch/test.c
@@ -40,6 +40,27 @@ static void canary_test_write(void)
 	pr_info("canary write test completed\n");
 }
 
+/*
+ * Test Case 1: Stack Overflow (Canary Test)
+ * This function uses a u64 buffer 64-bit write
+ * to corrupt the stack canary with a single operation
+ */
+static void canary_test_overflow(void)
+{
+	u64 buffer[BUFFER_SIZE];
+
+	pr_info("starting %s\n", __func__);
+	pr_info("buffer 0x%lx\n", (unsigned long)buffer);
+
+	/* intentionally overflow the u64 buffer. */
+	((u64 *)buffer + BUFFER_SIZE)[0] = 0xdeadbeefdeadbeef;
+
+	/* make sure the compiler do not drop assign action */
+	barrier_data(buffer);
+
+	pr_info("canary overflow test completed\n");
+}
+
 static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			       size_t count, loff_t *pos)
 {
@@ -63,6 +84,10 @@ static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			pr_info("triggering canary write test\n");
 			canary_test_write();
 			break;
+		case 1:
+			pr_info("triggering canary overflow test\n");
+			canary_test_overflow();
+			break;
 		default:
 			pr_err("Unknown test number %d\n", test_num);
 			return -EINVAL;
@@ -82,7 +107,8 @@ static ssize_t test_proc_read(struct file *file, char __user *buffer,
 		"KStackWatch Simplified Test Module\n"
 		"==================================\n"
 		"Usage:\n"
-		"  echo 'test0' > /proc/kstackwatch_test  - Canary write test\n";
+		"  echo 'test0' > /proc/kstackwatch_test  - Canary write test\n"
+		"  echo 'test1' > /proc/kstackwatch_test  - Canary overflow test\n";
 
 	return simple_read_from_buffer(buffer, count, pos, usage,
 				       strlen(usage));
-- 
2.43.0

