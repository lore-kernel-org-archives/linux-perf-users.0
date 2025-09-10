Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C766B2686A0;
	Wed, 10 Sep 2025 05:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757482423; cv=none; b=dPYYt+Ehgl6BcJqov1bitiSjhV8zrmjJzEiuhGRFINkcuGFrIoaKC14LCFmAF/nWjK4mYGDF0hqq/PbzCsAmfIT9dklYbAMt32qxBwiSKu+CODG2iHc01vGBRBPi3WrTnXzD5ykEJqWexyIx6pNOL6y1aeitK/hbJ4VLoSrzDe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757482423; c=relaxed/simple;
	bh=cxcRZEnHbyyKS+JOg+JcXIo6X+Q6D2ba/2AJLTdVu54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irdQACnTDDDEOaflHANCldTiBIC9yB5OkBvXfZXtZbf1+eonDWu369gdc1diEeO8Y9qpLMHMlc4UnvKU/1hdJ0hRYmjRck0pNQFKtyPqljKTMrm3Hmyv1PlFa+cXy5aPXCqRrRe03r2IN2ABoglown4ymFkBSdmIipG5OPgrNzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Euv660cL; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Euv660cL"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-772301f8a4cso8966634b3a.3;
        Tue, 09 Sep 2025 22:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757482421; x=1758087221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjx9GLpO3aNSMJAiegkOcLHgHnGs8uYVGx2kXqhm4j4=;
        b=Euv660cLMl2I8yqdYM449u5hsB7fg325Lw0FZ0iL13dqSYALBpkxEnhfM7uNDAG/py
         zwqNfDurCoWpdC4NQ/3ibPfkzuUISEoPRzGtw9rjdrFy0Vxo/la+HudQFJ8kKVbahr5i
         D7mcWlhbFRrBCjUlWLM8gNxwmAL/RVHGJlbI5aaP3hpNt3qzSD8LVYqZX0JWHUseJL0u
         9koeufdB5qbzYzt2btZ0TdJELVetUrJlQn5fL+6x/gg6pnl6hE7vOa44FdEyQq5RWxE4
         SyiNfo0kpLfMoeJh5ONcbyZiIpNFVgb4UzInS6DNIyOH4enmEawUvcaWmxl3213B8G2E
         eIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757482421; x=1758087221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjx9GLpO3aNSMJAiegkOcLHgHnGs8uYVGx2kXqhm4j4=;
        b=nkp4MmAq+p3HArmXcyQFP6Uun6HfQHO86mFsvJ9wQsOzQMDgwMPThG1oUI8oVYDla6
         ZjR0/HGXvWAoX2rmZsTIzz7PhKEzWosZh2NxJT5DSTvy+pv/ZTNDqIc3nTTFyoLyw3rM
         kYg0+R8IC1UZjRVoh052F0OpdUFIIkVQJtMOZyB81VVuF9q/06r3RTHTNf9N5Ir7DCMg
         tIHShGhOGRbPGon3cLnp2INNuvi9F4M7le2sDBFHtKsbrSoi0h/ybC+C+P2mgjmZt/o8
         QdNcrcynTtkMhNpsP47LSPSKVWociSaCfQQmlP0X9RQ4YD2N/4rQCaormvOXQAa4aYNU
         2VPg==
X-Forwarded-Encrypted: i=1; AJvYcCUnYo7yuIfSbQnPUSwGWibeqx3gbaU+m/k46axknI1LfrTL/kQXm5JLx7I9Rx3xK4MTj/Pr4P7YaQ6qPYkQabKGXqnN@vger.kernel.org, AJvYcCWjmzb2J4H9koxENfRz/VH+dW63ulEaHdMCpPxhLU17cvp9whxOBmuQkxYM49gdWx5mENlSnibUPjOjlGFEUr8R@vger.kernel.org
X-Gm-Message-State: AOJu0YxYjqKqgurCoUqeKiuDuMw8sxe3/iLGOJVCaH+uP+SFHwreKXYO
	gThwf5eiWwLTAtwwA5sT7N/BAhsZrzyjUupnh0JvJBX0Wc08dg2aODsZ
X-Gm-Gg: ASbGncswEA2zTcQpCAwpfTsItHRHz2llgFNJfdWKy3PH4dMRbGNDiNPk05PaFthYPaS
	94bDNruamia1/RLFsOG9GOq/fM3UeO0qRs5nzf0BKuW7/YoknBMIFTr6+B9XgxUYR1kQE1V5J3Z
	szheYOvwrwexbCp1LJGlxY4AKlvmU0CWzbJxGCUKvk7aTPpoGcd6/xfn1KjVl4+v3Sg95H5otl+
	2U8EPrrusUQ3mnB79YmVmXeAELviSkbpi3lh4VEcqQ4iuywgjMzI8mRFQ9AgSDNbIYfuDHIPLXT
	oyNytbrbgR2Ii52p/DxcC4T718DODx2NpMcNY9JGjXLAxT2qChiZZ9LhxJ+G7C/5/GvI5UttDL0
	997NzW75E/zCSWRwnvsZZ23Ee2eqZadZ0sJuB6ZERon5umuRIpn36Xmyavywj
X-Google-Smtp-Source: AGHT+IEunPsIauBemdf3Vt4yXR6Fs2bGNhkFdCqlEcAShsnuX701aZ0gNgsx62qzOw6WTfagWUVx5Q==
X-Received: by 2002:aa7:8882:0:b0:771:e179:343a with SMTP id d2e1a72fcca58-7742dea0275mr22122301b3a.17.1757482421165;
        Tue, 09 Sep 2025 22:33:41 -0700 (PDT)
Received: from localhost.localdomain ([45.8.220.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7746628ffbesm3870342b3a.66.2025.09.09.22.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:33:40 -0700 (PDT)
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
Subject: [PATCH v3 17/19] mm/ksw: add recursive stack corruption test
Date: Wed, 10 Sep 2025 13:31:15 +0800
Message-ID: <20250910053147.1152253-9-wangjinchao600@gmail.com>
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

Add a test that triggers stack writes across recursive calls,verifying
detection at specific recursion depths.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/test.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/test.c b/mm/kstackwatch/test.c
index b10465381089..6a75cd3e313d 100644
--- a/mm/kstackwatch/test.c
+++ b/mm/kstackwatch/test.c
@@ -147,6 +147,27 @@ static void silent_corruption_test(void)
 		silent_corruption_victim(i);
 }
 
+/*
+ * Test Case 3: Recursive Call Corruption
+ * Test corruption detection at specified recursion depth
+ */
+static void recursive_corruption_test(int depth)
+{
+	u64 buffer[BUFFER_SIZE];
+
+	pr_info("recursive call at depth %d\n", depth);
+	pr_info("buffer 0x%lx\n", (unsigned long)buffer);
+	if (depth <= MAX_DEPTH)
+		recursive_corruption_test(depth + 1);
+
+	buffer[0] = depth;
+
+	/* make sure the compiler do not drop assign action */
+	barrier_data(buffer);
+
+	pr_info("returning from depth %d\n", depth);
+}
+
 static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			       size_t count, loff_t *pos)
 {
@@ -178,6 +199,11 @@ static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			pr_info("triggering silent corruption test\n");
 			silent_corruption_test();
 			break;
+		case 3:
+			pr_info("triggering recursive corruption test\n");
+			/* depth start with 0 */
+			recursive_corruption_test(0);
+			break;
 		default:
 			pr_err("Unknown test number %d\n", test_num);
 			return -EINVAL;
@@ -199,7 +225,8 @@ static ssize_t test_proc_read(struct file *file, char __user *buffer,
 		"Usage:\n"
 		"  echo 'test0' > /proc/kstackwatch_test  - Canary write test\n"
 		"  echo 'test1' > /proc/kstackwatch_test  - Canary overflow test\n"
-		"  echo 'test2' > /proc/kstackwatch_test  - Silent corruption test\n";
+		"  echo 'test2' > /proc/kstackwatch_test  - Silent corruption test\n"
+		"  echo 'test3' > /proc/kstackwatch_test  - Recursive corruption test\n";
 
 	return simple_read_from_buffer(buffer, count, pos, usage,
 				       strlen(usage));
-- 
2.43.0

