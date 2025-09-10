Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE60270542;
	Wed, 10 Sep 2025 05:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757481925; cv=none; b=qicjec6BHaVcM8aOpiU54A1D0Rhqv2t2bwCw8yBYwReKokCTk/5gKbMf0d9gO7ezfrXCjvEtxZnJdlHS3InXEjSpJoInrRodTtrMzfCqpxi0XiomrE5+7b2kF42PpGLsBd4VasON0d14e3tZ5NsXRurEaTZw2Rd0vr3vK8kZ5oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757481925; c=relaxed/simple;
	bh=gEMdQGW4Pz7EO5aXZcIsTtMlvVMleKD80hf3hxFHZqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2Hylj+z7nW+cC0U3+cCCpYylOOZClATX69OHabFIjtaWtZGH0BhTNL+ocgDhH78pwZtmWEIo5F2eB0k4oJWa51FYAfd/ecZG1oDM3DLjle/O5vHhsPjU/JfUvZF5V7zHQFTZlDHrpE2zunBB8+X5usLCVrpLMz5ev545TkKUXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loUUBci2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loUUBci2"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-244582738b5so54214235ad.3;
        Tue, 09 Sep 2025 22:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757481921; x=1758086721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iH0uUA/mqRHCjkyWem4sk7YGmV7N6yemXibteoDcT8=;
        b=loUUBci2IcoMtAag2afG8HnKXzZa6CkWFdzv/5Psols9198KPqGBuzUFfGIGqMG1m5
         53CBmPbKYwm26NJaJix7qWktz2VcfUZDooUW5N+qeuCSK9vwkqOHJDM8nMU4to0rE8X+
         8yAa+ZEyCjXEGNIghS7JapAvIsQPEk6hTTrGwApAkI041oae5gbsBX7BtLCk0V7g5xUI
         9u0OAzJYxlfzdaJH1D2O51w6bq14GCn2BL/oMiP9KMrSaIgelGU8CoqehAQF6wv6m+X8
         4up1N2YjgQK5iJ9JJpmHhnA1SGJ6ghx6OJlYMG/yFIV0W5XnpQ6awYf8lBENoIBrb9J0
         hvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757481921; x=1758086721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iH0uUA/mqRHCjkyWem4sk7YGmV7N6yemXibteoDcT8=;
        b=ZCJDggfr+tiJszqNiQ9/npywddKASpERbckrvUnb0k83hXkMwz0svl9CFp22aHb5Yr
         HEAfuxOPX4BMPxH/4qjkhUDfArI5RY+7Mfmtxm6JEIo3NY0EM2CDgSDMfOXrvPcQKbGT
         7UYpBGFHIQLA+yqY7JUapXL3lZci3Y6y8XT6yrouze70Cw5isFQALViZ655V2ZvMFbj5
         j+mckvCKvRyz9Xs7+OVHaT8/Uw1Gjauzv/OCdY8nBU3IufGAskEDpS/TTe+aWfCJL2M3
         CatghSaGc018HxzaNfY5OqpegwYHAL6FONOcMCb8sY68soTPjwzcF/Co23bi2aBiuelZ
         +YFw==
X-Forwarded-Encrypted: i=1; AJvYcCX/Y1YRw4seIlnQE2We7mLC80aa/7046DPmBniT/fkiiuJvFj4pu4c6xSMqkJUfiFtoQOQ7DpwaDG8fmhsrP81J@vger.kernel.org, AJvYcCXDk1WB/GnX4CNr6xFXQIOWZde+swHXpdrsvWAV2HxTuBobBGQO2Okx6DgA9WJpjzBo5TNv+VU6swJ5Um8ZfMD1LkrM@vger.kernel.org
X-Gm-Message-State: AOJu0YzPNDgo9AlALAGhzrW7tH+pS3T4ENN4I1hMG/g9VgEEt68UB01i
	A0W/O4nXkywzZf7UTuhsMFqjVXQh+RWg86bnxMNQ12Meccg4nomoJ/gO
X-Gm-Gg: ASbGncvfcuZ4MZ/Gfjrr5/YKRJCvIgA+wfkErv7dE8/P3ZJa2RuhKIbp9tzqGJlanHG
	cut9fKBPhrGdssmkQ41Eownl9i0MJOWVd3UtgQLBKFHzl9lpziawYcg8Bby2RNPyaT7j8qQjNTh
	5QkwbVfdlwc10U3OXx1MEf2c5K1GfxtFN97QktVwWS/tzNfwkRdLEk4M010px7icgnAhXCQy/gm
	TQ9XFv+U4rObdDOcsaPICObsHz7xKuj+R2guN4JD9HKcZooAG//mySlwZtWC5SOSwX4Sk7/s9xb
	8YLebiQvviQTU6aCN5ax9s8gQvROY4Gcl8Kqa5rCIlMYMN9eYjrz6nGWYjSGppvkk51Wf1z7MQl
	5L2k/WW2gOYmB5IOB/ggiqVh/EbNxcO1bkA==
X-Google-Smtp-Source: AGHT+IHyIbPI5OFJBCaoz7jKF8b2NXtZuc8li31LzuXXg8oHgdT4/pVFw9hECNltJyQIAJVvWWbD5g==
X-Received: by 2002:a17:902:ce12:b0:248:79d4:93c0 with SMTP id d9443c01a7336-25175f75c60mr198301765ad.56.1757481921566;
        Tue, 09 Sep 2025 22:25:21 -0700 (PDT)
Received: from localhost.localdomain ([2403:2c80:17::10:4007])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a27422ebcsm14815125ad.29.2025.09.09.22.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:25:21 -0700 (PDT)
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
Subject: [PATCH v3 05/19] mm/ksw: add /proc/kstackwatch interface
Date: Wed, 10 Sep 2025 13:23:14 +0800
Message-ID: <20250910052335.1151048-6-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910052335.1151048-1-wangjinchao600@gmail.com>
References: <20250910052335.1151048-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide the /proc/kstackwatch file to read or update the configuration.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kernel.c      | 75 +++++++++++++++++++++++++++++++++++-
 mm/kstackwatch/kstackwatch.h |  3 ++
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index 1502795e02af..8e1dca45003e 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -3,7 +3,10 @@
 
 #include <linux/kstrtox.h>
 #include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/string.h>
+#include <linux/uaccess.h>
 
 #include "kstackwatch.h"
 
@@ -12,6 +15,7 @@ MODULE_DESCRIPTION("Kernel Stack Watch");
 MODULE_LICENSE("GPL");
 
 static struct ksw_config *ksw_config;
+static atomic_t config_file_busy = ATOMIC_INIT(0);
 
 /*
  * Format of the configuration string:
@@ -23,7 +27,7 @@ static struct ksw_config *ksw_config;
  * - local_var_offset : offset from the stack pointer at function+ip_offset
  * - local_var_len    : length of the local variable(1,2,4,8)
  */
-static int __maybe_unused ksw_parse_config(char *buf, struct ksw_config *config)
+static int ksw_parse_config(char *buf, struct ksw_config *config)
 {
 	char *func_part, *local_var_part = NULL;
 	char *token;
@@ -92,18 +96,87 @@ static int __maybe_unused ksw_parse_config(char *buf, struct ksw_config *config)
 	return -EINVAL;
 }
 
+static ssize_t kstackwatch_proc_write(struct file *file,
+				      const char __user *buffer, size_t count,
+				      loff_t *pos)
+{
+	char input[MAX_CONFIG_STR_LEN];
+	int ret;
+
+	if (count == 0 || count >= sizeof(input))
+		return -EINVAL;
+
+	if (copy_from_user(input, buffer, count))
+		return -EFAULT;
+
+	input[count] = '\0';
+	strim(input);
+
+	if (!strlen(input)) {
+		pr_info("config cleared\n");
+		return count;
+	}
+
+	ret = ksw_parse_config(input, ksw_config);
+	if (ret) {
+		pr_err("Failed to parse config %d\n", ret);
+		return ret;
+	}
+
+	return count;
+}
+
+static int kstackwatch_proc_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%s\n", ksw_config->config_str);
+	return 0;
+}
+
+static int kstackwatch_proc_open(struct inode *inode, struct file *file)
+{
+	if (atomic_cmpxchg(&config_file_busy, 0, 1))
+		return -EBUSY;
+
+	return single_open(file, kstackwatch_proc_show, NULL);
+}
+
+static int kstackwatch_proc_release(struct inode *inode, struct file *file)
+{
+	atomic_set(&config_file_busy, 0);
+	return single_release(inode, file);
+}
+
+static const struct proc_ops kstackwatch_proc_ops = {
+	.proc_open = kstackwatch_proc_open,
+	.proc_read = seq_read,
+	.proc_write = kstackwatch_proc_write,
+	.proc_lseek = seq_lseek,
+	.proc_release = kstackwatch_proc_release,
+};
+
+const struct ksw_config *ksw_get_config(void)
+{
+	return ksw_config;
+}
 static int __init kstackwatch_init(void)
 {
 	ksw_config = kzalloc(sizeof(*ksw_config), GFP_KERNEL);
 	if (!ksw_config)
 		return -ENOMEM;
 
+	if (!proc_create("kstackwatch", 0600, NULL, &kstackwatch_proc_ops)) {
+		pr_err("create proc kstackwatch fail");
+		kfree(ksw_config);
+		return -ENOMEM;
+	}
+
 	pr_info("module loaded\n");
 	return 0;
 }
 
 static void __exit kstackwatch_exit(void)
 {
+	remove_proc_entry("kstackwatch", NULL);
 	kfree(ksw_config);
 
 	pr_info("module unloaded\n");
diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 7c595c5c24d1..277b192f80fa 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -35,4 +35,7 @@ struct ksw_config {
 	char config_str[MAX_CONFIG_STR_LEN];
 };
 
+// singleton, only modified in kernel.c
+const struct ksw_config *ksw_get_config(void);
+
 #endif /* _KSTACKWATCH_H */
-- 
2.43.0

