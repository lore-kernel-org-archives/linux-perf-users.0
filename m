Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0CD1E572F;
	Thu,  4 Sep 2025 00:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945339; cv=none; b=S48TgCAErWtfawDxaQLj9/epKwURjWWX/pOvl2Mc1ejm/jRDT72epe7K0m0V1wT26pe1XDp1fPaIF8WIRgJz+tOVJ8G+ZqB6rlX6ddEQpHSfDWwyAdXSGjcO4ls7gN2JBJrqgoSS5lS5woV/1tnM0KXNn0sybyeWPn10ypKvt9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945339; c=relaxed/simple;
	bh=riKBu2I/0IniTUQEc51qBXh7Lfn5NQ94RTpD6hcQAWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiyFTfkv+WZ7j91ybQ/PouHGs++StGODxKtDgq2AmKEYkdT3u+d8GVwzO0ESzCMaTF7CI8Yhhl5DxHdbFd5Gw1TJQ9LqJEn/h4N5fWwK9hKuEgvca70CTw6/Uon5hBJEyB/VdF5lg4dQwLBjNra0nQz0gDBN8KjdUGZWf0wQ7gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLcVEcb4; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLcVEcb4"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77238cb3cbbso541029b3a.0;
        Wed, 03 Sep 2025 17:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756945335; x=1757550135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVjzrm6vJvhOYeF4QMjv0eGIgiL9m2bJu49WtrTbuMs=;
        b=fLcVEcb4hmRqAYinYJs00rm4cHOjbmjQHg3XOpEP6YqDNNn68irnZAlkopy/NRat4i
         YiIRwOvzbWjyVcSo3aQSpjNWUveOoQXTnbXhKHjCMzSqOgENKss3l15bt2VGBFtiDiiI
         7R40czyEnIrE64HHLaSS7NKG4P86N7eZq+YV5+TnVMOB/X+4OyKe2mMQmwHwY5MGVND4
         NwAGhJFUVnUxAs8b5Q5fFLQ4E75/+qf9IKaC9XDWoG241A2HiQG4SIj0Y38rBiTB9Woo
         zdwaSHzRjGfkZI5M21WWDJjwbsS89e242Hw5g8mmOrx9dykXnsPGCJYnkABn5nVX/FVm
         ikmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945335; x=1757550135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVjzrm6vJvhOYeF4QMjv0eGIgiL9m2bJu49WtrTbuMs=;
        b=kZJFpNLLtU0dmZ5gAXC1Qhl4bITbXnCx/AcO1B4o0I9zrjONwug+S01C4JYO+/jIJs
         SJuFm9RMNbLPSB4kFtyDSq+fxGytlQ9LLq6br/5X/iS1E115IWosQAbxY7YqiPHIejFk
         pNOkCn5UfJGzZTQKIv3LZ4TF9AVBuVSaSTVcYBwclfHgcBrb8eLTHgFdDJXrc/p4vOOY
         2Ia2ZUUG2E1ssnu5DPwzcLocohXwwlOgwAZUZVwLRbRnVBTjCM4vpNrBgnvMi3x4u+VK
         06Suw8OLBGSUCd0hFu7kaRcu/soPtAzGpS0F43QUt5J9kiiuZI9RkABHPFQkLiC05aLn
         4yyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSu2hIiut4MevFShFxMjjmsLK1yPsMU32plPZUYOs/5pEX8icncryhqt9DVJcpQ6ryl7xGpHNE0pJlBTeyjPUa@vger.kernel.org, AJvYcCWi7HL1rf26SGrOtK4mDoWZFHBDKNJLHVqhiVKZCdC4rdBsryl08mog9vpbHI7J0tGCBaSJwNypn1xZkAAltW80Q9+m@vger.kernel.org
X-Gm-Message-State: AOJu0YwHFjhNnwUbkcVZ4v0MB5LLr2/m2RFvAZw1ekkYA8OIsz4NSsrN
	yWr+HGvz+D0FghAwkXCLDIkLDl5KG3Jsfe0J4Nk1jeqzfeT5jXEnidUz
X-Gm-Gg: ASbGnctPUykwC3zfwTDXuPt025zcMe2akrU7WJnIs6CxCjeGpLv60b+07ZjZ75XegUs
	6c/1koSd3svJGIksAS1il7BSd7STVzG9ODg/4oX9KKNqMcRdq8RHIODbUXMPUnBNe6Q98we8Mml
	NSyB5XM6F3LD88InF+yaqdD1HnCYS1ucqLtdF2sw16tmvFqxqXOIJAoX68g8qdWyp/bfaMXdC3L
	V8AH0zUDRKczVB40RU5Jef6sM+JA2m/NwDnkSg97qn7a8A0OaLWk43B70p1f9lA0GHmyfMZ+pTM
	lCT9nh2/8WKZG+GB2z2N6zIBeh2TOeNUPnKtQRVkl11mLeYI0Usi0AtTkQG6hNZ1HotDC5tym1C
	oXzH9vGU4c90sDr/8tx1ETpVkmOVvZaBuUAZRd0xA6sl9VaIsppZU
X-Google-Smtp-Source: AGHT+IHi/o/IAm0vynFn2e/IsWAicKmyi78tP6aMpCX3iR0UzR1wOUQxX5ciC3ig3wFrcV6Iy1bIqQ==
X-Received: by 2002:a05:6a20:7484:b0:243:9312:4fb4 with SMTP id adf61e73a8af0-243d6f86b99mr26405251637.52.1756945334920;
        Wed, 03 Sep 2025 17:22:14 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bd2aesm17579551b3a.48.2025.09.03.17.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:22:14 -0700 (PDT)
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
Subject: [PATCH v2 03/18] mm/ksw: add /proc/kstackwatch interface
Date: Thu,  4 Sep 2025 08:21:00 +0800
Message-ID: <20250904002126.1514566-4-wangjinchao600@gmail.com>
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

Provide the /proc/kstackwatch file to read or update the KSW configuration.
Writing a valid config string starts watching; empty input stops watching.
Invalid input stops watching and reports an error.

Allocate a ksw_config struct on module init and free it on exit.
Manage watching state with ksw_start_watching() and ksw_stop_watching().

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kernel.c | 140 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index 4a6dc49449fe..95ade95abde1 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kstrtox.h>
 #include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/string.h>
+#include <linux/uaccess.h>
 
 #include "kstackwatch.h"
 
@@ -9,6 +12,29 @@ MODULE_AUTHOR("Jinchao Wang");
 MODULE_DESCRIPTION("Kernel Stack Watch");
 MODULE_LICENSE("GPL");
 
+struct ksw_config *ksw_config;
+bool watching_active;
+
+bool panic_on_catch;
+module_param(panic_on_catch, bool, 0644);
+MODULE_PARM_DESC(panic_on_catch,
+		 "Trigger a kernel panic immediately on corruption catch");
+
+static int ksw_start_watching(void)
+{
+	watching_active = true;
+
+	pr_info("KSW: start watching %s\n", ksw_config->config_str);
+	return 0;
+}
+
+static void ksw_stop_watching(void)
+{
+	watching_active = false;
+
+	pr_info("KSW: stop watching %s\n", ksw_config->config_str);
+}
+
 /*
  * Format of the configuration string:
  *    function+ip_offset[+depth] [local_var_offset:local_var_len]
@@ -74,8 +100,114 @@ static int ksw_parse_config(char *buf, struct ksw_config *config)
 	return 0;
 }
 
+/**
+ * kstackwatch_proc_write - Handle writes to the /proc/kstackwatch file
+ * @file: file struct for the proc entry
+ * @buffer: user-space buffer containing the command string
+ * @count: the number of bytes from the user-space buffer
+ * @pos: file offset
+ *
+ * This function processes user input to control the kernel stack watcher
+ * Before attempting to process any new configuration. It handles three
+ * cases based on the input string, In all three cases, the system will
+ * clear its state first, with subsequent actions determined by the input:
+ *
+ * 1. An empty or whitespace-only string
+ *    Return a success code
+ *
+ * 2. An invalid configuration string
+ *    Return a error code
+ *
+ * 3. A valid configuration string
+ *    Start a new stack watch, return a success code
+ *
+ * Return: The number of bytes successfully processed on success,
+ * or a negative error code on failure.
+ */
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
+	if (watching_active)
+		ksw_stop_watching();
+	memset(ksw_config, 0, sizeof(*ksw_config));
+
+	input[count] = '\0';
+	strim(input);
+
+	/* case 1 */
+	if (!strlen(input)) {
+		pr_info("KSW: config cleared\n");
+		return count;
+	}
+
+	ret = ksw_parse_config(input, ksw_config);
+	if (ret) {
+		/* case 2 */
+		pr_err("KSW: Failed to parse config %d\n", ret);
+		return ret;
+	}
+
+	/* case 3 */
+	ret = ksw_start_watching();
+	if (ret) {
+		pr_err("KSW: Failed to start watching with %d\n", ret);
+		return ret;
+	}
+
+	return count;
+}
+
+static int kstackwatch_proc_show(struct seq_file *m, void *v)
+{
+	if (watching_active) {
+		seq_printf(m, "%s\n", ksw_config->config_str);
+	} else {
+		seq_puts(m, "not watching\n");
+		seq_puts(m, "\nusage:\n");
+		seq_puts(
+			m,
+			" echo 'function+ip_offset[+depth] [local_var_offset:local_var_len]' > /proc/kstackwatch\n");
+		seq_puts(m, "  Watch the canary without the local var part.");
+	}
+
+	return 0;
+}
+
+static int kstackwatch_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, kstackwatch_proc_show, NULL);
+}
+
+static const struct proc_ops kstackwatch_proc_ops = {
+	.proc_open = kstackwatch_proc_open,
+	.proc_read = seq_read,
+	.proc_write = kstackwatch_proc_write,
+	.proc_lseek = seq_lseek,
+	.proc_release = single_release,
+};
+
 static int __init kstackwatch_init(void)
 {
+	ksw_config = kmalloc(sizeof(*ksw_config), GFP_KERNEL);
+	if (!ksw_config)
+		return -ENOMEM;
+
+	/* Create proc interface */
+	if (!proc_create("kstackwatch", 0644, NULL, &kstackwatch_proc_ops)) {
+		pr_err("KSW: create proc kstackwatch fail");
+		return -ENOMEM;
+	}
+
 	pr_info("KSW: module loaded\n");
 	pr_info("KSW: usage:\n");
 	pr_info("KSW: echo 'function+ip_offset[+depth] [local_var_offset:local_var_len]' > /proc/kstackwatch\n");
@@ -85,6 +217,14 @@ static int __init kstackwatch_init(void)
 
 static void __exit kstackwatch_exit(void)
 {
+	/* Cleanup active watching */
+	if (watching_active)
+		ksw_stop_watching();
+
+	/* Remove proc interface */
+	remove_proc_entry("kstackwatch", NULL);
+	kfree(ksw_config);
+
 	pr_info("KSW: Module unloaded\n");
 }
 
-- 
2.43.0

