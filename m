Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5DD23E346
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 02:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200293; cv=none; b=nBdJoyjOLMifkUDuu/dO2UvBOpfuBVCDdO08kkRzFxtzOZIsNoWbLvXt3hUt+s5wWRqhKoAxDHGCRFhutwIURFwvk/vJd6vnn+3/BWEQ6p8cwB0wn2eULRXwF/2Vb95+CjIzKktqpWNH5uHONTiApEx9+y85U3g+Uh0TvR0JIx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200293; c=relaxed/simple;
	bh=NKGG2Deka0iYHCcjeICKwSp0xNn5UzCtr+YC+OdIklo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4RCFU7pBbYotJKkWca45Zzk6c1Gd4+01qQVRMP5RSgZyrBV3lyS5Ukw9vL+s1NmIzhNEVZsEcBytmM4tHIlXdAH+o6pQZpMZx/+DqR34TtxDAwbosCOkZL77BqnwZ8iPXUUzU3m+Z0xrOoDnnRjPvIas0ivEoOkcnYEkb3QnA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJU7h/hq; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJU7h/hq"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33255011eafso5341657a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 19:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759200291; x=1759805091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tH9NPPXYzjzWmBeV5TNMSRB6I94mkI1pmHDAIM87ayY=;
        b=iJU7h/hq+0Zl+S5CJiDaa4ggLdpamAziSTzoQj64IOgBovCo+YDbRLFBTugApzi8Dk
         hkCRsIT8iVELG8JajFpmPm/Nce+mjSnr0ZOZSN09wSO1T/BDahZ3q+C1yx4OsFU8ivs6
         8QxReTYLt950fQKnijDmHD5zK51G20XPoQ9aWfk0Ott1XSwI4u7D1h4JEEJwLi9e1bK1
         ZIHTssvnxpDrxbOu/16G+y+uQHneJyTluqq99xjbiQm5PwNcGF5IF/XiXIdgxeQhIgQa
         vYRLg8bnzzIQqWezNxOsY2SjzrSZ9k0hugo5XnyUB0fEA5d86nk37HACXYKF/kyC09ie
         tj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759200291; x=1759805091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tH9NPPXYzjzWmBeV5TNMSRB6I94mkI1pmHDAIM87ayY=;
        b=Pi7RIYg7FDXxCPwWoHLh8iWeW9XuBs0uZqooAAibXvoYsphluAXcJLcBmio7P0Bm4D
         dpwsdebe9Nf1Ly5vGE/u7BX3qDN0KtUpj96aVwM8f3SUoIG0RJliuqr9hzYSiRUf/iPe
         UvWL0ShxKZDrZd2oheAVZjNWosE0s9FKaZjtgdXN9Xt/hLg+cOSvjtBqJgG2tQHvNCmi
         Fo1cDqRhpzHrViAh3kC5NcljrAPakVtiRie/eiMSn0X186BumdzFGcayd8oD2rLunHJE
         +BQ33EiVBG1NpfSzcD3T/yuBmnv/3Bt9mWX5K6X9keiyZfZ4XV0/ywpelC0oYW546UPj
         mNVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDJrD5e2igi09eDuzySiXMB9FGT+3sm/lS1mFw9OpFyd9RSOvA2nRyYELHEEW+/6YENdwi8riaduLKzJrZ3iGF@vger.kernel.org
X-Gm-Message-State: AOJu0YxgTQ7sLcPF8Tg84UE9YQagPKa28+S8GQG7Y94zNPbI3zccf6bP
	GDmGqH6EB+Jx0OS+keZx8B3QtZSGz9i2n6ALBuumJm+iNooHxaNl6mki
X-Gm-Gg: ASbGncvE1NAgMlA+uK0iqrGe5bGkyJctHBF3k7eWihAP95fSz1Yqutow3l3uPoMqBwv
	fbYusTNcjvsV6u7IhA3zEdI1lltJnpxeXfXGj1gOvKZqYEoBdyn36n59/WRu64I9PMPE5/ZiEhf
	rBHABFH2HClcthj9oMjdp3EQN7tFnJy8298p+Yfyh94NrhZi7pORa2lRvs3BCnJDVceoNFLpm0o
	8+OoKwe6n9YcPtPYFoPMFFzMggfr4h6+tV8f+7kYwTvEeOmM1g96JXgx/ESVGwby0ll6453Th+r
	mQIN2txBfdab3BA5113ujWFZUDmUko3MXibi72xeuQz0PSUeWqVdBfdXRAirLK51OA5NcjWVwXc
	D0RLwCTaYdYQg1OKQSGVPQNXriKaK39EqOCt4kYF0Lqym5S45p0AWw3cBo0q8q/r+Vw0l4gRrxw
	GS
X-Google-Smtp-Source: AGHT+IFVE9O//P1+ssBUOG8eBG1xptc20Z1rkKT0r8Peul+CYAeELZZLuPAbA8MMh6puLAlFfjJIyA==
X-Received: by 2002:a17:90b:3ece:b0:32b:6145:fa63 with SMTP id 98e67ed59e1d1-3342a216f73mr19097573a91.4.1759200290701;
        Mon, 29 Sep 2025 19:44:50 -0700 (PDT)
Received: from localhost ([45.142.167.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be38382sm18526671a91.25.2025.09.29.19.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:44:50 -0700 (PDT)
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
Subject: [PATCH v6 06/23] mm/ksw: add singleton debugfs interface
Date: Tue, 30 Sep 2025 10:43:27 +0800
Message-ID: <20250930024402.1043776-7-wangjinchao600@gmail.com>
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

Provide the debugfs config file to read or update the configuration.
Only a single process can open this file at a time, enforced using atomic
config_file_busy, to prevent concurrent access.

ksw_get_config() exposes the configuration pointer as const.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kernel.c      | 104 +++++++++++++++++++++++++++++++++--
 mm/kstackwatch/kstackwatch.h |   3 +
 2 files changed, 103 insertions(+), 4 deletions(-)

diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index 3b7009033dd4..898ebb2966fe 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -1,13 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/debugfs.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/string.h>
+#include <linux/uaccess.h>
 
 #include "kstackwatch.h"
 
+static atomic_t dbgfs_config_busy = ATOMIC_INIT(0);
 static struct ksw_config *ksw_config;
+static struct dentry *dbgfs_config;
+static struct dentry *dbgfs_dir;
 
 struct param_map {
 	const char *name;       /* long name */
@@ -74,7 +79,7 @@ static int ksw_parse_param(struct ksw_config *config, const char *key,
  * - sp_offset  |so (u16) : offset from stack pointer at func_offset
  * - watch_len  |wl (u16) : watch length (1,2,4,8)
  */
-static int __maybe_unused ksw_parse_config(char *buf, struct ksw_config *config)
+static int ksw_parse_config(char *buf, struct ksw_config *config)
 {
 	char *part, *key, *val;
 	int ret;
@@ -109,20 +114,111 @@ static int __maybe_unused ksw_parse_config(char *buf, struct ksw_config *config)
 	return 0;
 }
 
+static ssize_t ksw_dbgfs_read(struct file *file, char __user *buf, size_t count,
+			      loff_t *ppos)
+{
+	return simple_read_from_buffer(buf, count, ppos, ksw_config->user_input,
+		ksw_config->user_input ? strlen(ksw_config->user_input) : 0);
+}
+
+static ssize_t ksw_dbgfs_write(struct file *file, const char __user *buffer,
+			       size_t count, loff_t *ppos)
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
+static int ksw_dbgfs_open(struct inode *inode, struct file *file)
+{
+	if (atomic_cmpxchg(&dbgfs_config_busy, 0, 1))
+		return -EBUSY;
+	return 0;
+}
+
+static int ksw_dbgfs_release(struct inode *inode, struct file *file)
+{
+	atomic_set(&dbgfs_config_busy, 0);
+	return 0;
+}
+
+static const struct file_operations kstackwatch_fops = {
+	.owner = THIS_MODULE,
+	.open = ksw_dbgfs_open,
+	.read = ksw_dbgfs_read,
+	.write = ksw_dbgfs_write,
+	.release = ksw_dbgfs_release,
+	.llseek = default_llseek,
+};
+
+const struct ksw_config *ksw_get_config(void)
+{
+	return ksw_config;
+}
+
 static int __init kstackwatch_init(void)
 {
+	int ret = 0;
+
 	ksw_config = kzalloc(sizeof(*ksw_config), GFP_KERNEL);
-	if (!ksw_config)
-		return -ENOMEM;
+	if (!ksw_config) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
+
+	dbgfs_dir = debugfs_create_dir("kstackwatch", NULL);
+	if (!dbgfs_dir) {
+		ret = -ENOMEM;
+		goto err_dir;
+	}
+
+	dbgfs_config = debugfs_create_file("config", 0600, dbgfs_dir, NULL,
+				       &kstackwatch_fops);
+	if (!dbgfs_config) {
+		ret = -ENOMEM;
+		goto err_file;
+	}
 
 	pr_info("module loaded\n");
 	return 0;
+
+err_file:
+	debugfs_remove_recursive(dbgfs_dir);
+	dbgfs_dir = NULL;
+err_dir:
+	kfree(ksw_config);
+	ksw_config = NULL;
+err_alloc:
+	return ret;
 }
 
 static void __exit kstackwatch_exit(void)
 {
+	debugfs_remove_recursive(dbgfs_dir);
+	kfree(ksw_config->func_name);
+	kfree(ksw_config->user_input);
 	kfree(ksw_config);
-
 	pr_info("module unloaded\n");
 }
 
diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index a7bad207f863..983125d5cf18 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -29,4 +29,7 @@ struct ksw_config {
 	char *user_input;
 };
 
+// singleton, only modified in kernel.c
+const struct ksw_config *ksw_get_config(void);
+
 #endif /* _KSTACKWATCH_H */
-- 
2.43.0

