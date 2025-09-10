Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A323ED5E;
	Wed, 10 Sep 2025 05:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757482400; cv=none; b=gzCA9mGs1JMQsQh5ZYd/dBGWeFwqpH6LkxuqUF5b8KXgRvXRm4aQm7SSdJnDPH8neF84ubCvUVLFfiwGiUOTgEXaMMg45yZlQuzUw1UCHQ7ozqYIjT6bfrpBSoaObLFsOBpyTz1SbzT2pPnnQLiZCVhqsOWQxNNDyTNedm2sNFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757482400; c=relaxed/simple;
	bh=0pYLSOeA0PAf1TeSGJQVGULqR9LKSdf8J0mO6JXy6uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJbJZ1QffPWLqxUVlIqfxYNoQ74fTh+R/9P0B07gdk3TSl/TzwWgGGDA4Kc70b1f4278TwxcQJ+tgoWaRdBJ+rMP18G8KKA9tkkzkQHuaP0doDtIgCtXfG00jo1UFXeMoxjpG5/HnXr72IzrfX1gajGgOp29uLoTQFHRPTt4Qwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coXYtJrF; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coXYtJrF"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7722bcb989aso4824221b3a.1;
        Tue, 09 Sep 2025 22:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757482398; x=1758087198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6BBsZfnmfgl1Jgn+pU00vd6g5c1DTmTteWqGp/Sk64=;
        b=coXYtJrFP6WSaOxzC0Ut2KIrv7jcUHalHrBnxyRyKLAqwAOIqxs0ECrXO2DcRPC2S/
         +J2NIRWjuj2bXrQ7S3MfQKh7YM6w+glUd7TSzmWqzMQyRHSOnuX4XNGQbY1slIIq8pfw
         4t11PY+dPQQYV8wN9zrkY45ekaL0Ag4xdmWD2ImqQ2MU/g6jkPIkpp6U0STsFq0uVPcc
         Vlbbdy3NrXtpmmFS5NVPoHoYtEDmIngLmwG8qD0H8uCxS4Pf7waiUHIjRGMVJe5TsvKG
         +S/NPkxZEnrfbCfUuhEDJRmdmlFw6l/mIGbDuG2yLApeTfdWycttZM0uPMqCziwnWfoD
         aaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757482398; x=1758087198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C6BBsZfnmfgl1Jgn+pU00vd6g5c1DTmTteWqGp/Sk64=;
        b=QZOlBuH6Ozq5Jj/vgLSsTX5BCShTh5uWgpD/kJc/UUEZfkLxk2eLPbEDgNcGuVCgH1
         yANzsBM58VZLJ6D+fFlf7kFHAPkfSozrlqCOVWaLiT6AeQzbIUwP8LiKPuWsvQOLY8i8
         /CrdXYrku6Q7bGUmbRznXYd0Z1qSxnI6eKrW/290dNTN4GXM9AwnFqU14gLr9Ld0Kb/G
         MVjjNURYrQp0pCCsRCtDTG2D/68Ypa//7z/2iYKvJeTAu4ohdn2ECHdDL7KmtqxknYCI
         RFlvP1MLHb85jXesfaNAg1pCMsr8CjuZ/zNdbHPeys5A/7r5VVBe8xeS0bvE6m1hkL3f
         HSVw==
X-Forwarded-Encrypted: i=1; AJvYcCX/pjqo/MfuzCbjgor5YvMd2y4/HrT+FHER3p7p8xxvPxTITGoUCQnHRagsFaI3eHPYrar6kAKtxbcU355Cgdy+@vger.kernel.org, AJvYcCXb02HpYteK11cZKyCVtSigUEoSkq4WUM02+jyBpyF2W0wfXsfU4NB8aLYd4nLvLryPzcsJqwrkI1c0LtaWLeMNys4c@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq4xBTnjG52/6wbI8H3Nl/NGP+n3Vr3AL2Z9RsxNcTWJe+W82q
	lx5bqamRLBDgp7AS7KIx52MopGAYOTTnqrBB7js079ByNvkOOUtgOS/n
X-Gm-Gg: ASbGncsq42nFUUHWXOoQVXdmmwK8wSet+oNKkLNvK32D8Xpdhgy7MHL+n6wjEA3L4JD
	6BcbMnPgJeRa+/gEX8nRmsezhN/pbOQYPoIHXEBGk94BmvJcaCEBZUEj6+eIfefcEPoX1+3An1B
	L725rcIuYcnNUPG5w8ozcgeqb5X1cGQQVThhH5w3dUsyQoeFOTkL+D7GaUfkym3zzqbqOwznhp+
	sN40UtFvfQi4WejQAT9a/9wqxGoacOnMAK3odFYDPC7HSB8Rc9ypmlZSImKgFV+dupTpnyW0Afu
	w1PiHTA4alQ8Nn+//kRCIVyzD4KibwFsQq3/mlaNZg+ZV694Db3h7qg8ZL7Rnv8Uo3pr2UXjKrl
	dSNVDdPXAjlLUQkoy78ngEfqESwORMyv5zWJuYvBuh2wfFjy06Q==
X-Google-Smtp-Source: AGHT+IGMlBk1siPf0LdBIVrbWn7aNbl4n5xmBmCjKUDes18u0uAwbv5aGrUaz59gciPqgZoMRDZV0A==
X-Received: by 2002:a05:6300:2189:b0:24e:3b70:978c with SMTP id adf61e73a8af0-2534756f62cmr20233577637.59.1757482398166;
        Tue, 09 Sep 2025 22:33:18 -0700 (PDT)
Received: from localhost.localdomain ([45.8.220.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7746628ffbesm3870342b3a.66.2025.09.09.22.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:33:17 -0700 (PDT)
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
Subject: [PATCH v3 15/19] mm/ksw: add stack overflow test
Date: Wed, 10 Sep 2025 13:31:13 +0800
Message-ID: <20250910053147.1152253-7-wangjinchao600@gmail.com>
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

