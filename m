Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320AD3019A4
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714723; cv=none; b=Ic/cq2GHeuAS2gjnEa+3Td5USy2wgltCJ8obi5oQZChLx2Cg4C3ujODAXkX0NXbaFaApk9NlLt/Sd64ADLq5BYOYCLuRRcxxr4fcSRJo7cgqNTNLiqCGbvvdIyLC2FTAHj0bpAmak3XnKYaeqjQaiWPYiQmOWRkKPNnmaAv3Wz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714723; c=relaxed/simple;
	bh=6SekrJfJo1dIUGCCsK37DffrryW992IXbdw6n87bUwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5FO2FEq98ird1J6rh/wufNt3x93kuw4WvPtJjJCLVUG0d0LYfC6lir4hMkrzu3v1OtsSRjhJ89U9exCdovPtAR27g4mtBKMXHU7s5bVjxIWYD99PuFsutRNKKTHudc+MvTTOLPJKncZVq8r/8pPKuLEr/sHYC8+eWs1vxy9Usk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luijkG6O; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luijkG6O"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24456ce0b96so10970435ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 04:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758714716; x=1759319516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chAO9GOTMxCV8ZHg6BsIF9VuSBV9TkSRS16Il152ztM=;
        b=luijkG6OkxBdFdQCcaBX7q42Wdus5M63YlT13sDxXcLI/XAaEIs2ARoQ+eZSikmDBb
         Erqc3pRwq83PsjA+Co58bYa4umSKJypAF94IuVb6rzGVplP08VapIWoEOBfWCdxn6THL
         zka6G3Ij8Vd0vMvDeWh2aOealKFDPGzBsLWymNyi71qHp1T0dKZC+/SC86pgWdxKwkqQ
         v28vzEYT1GeSLvRCPlwUhNzpyCOQ6dR1oNHsXyR0ntCNbj/icC3Sz9guQg3EBYzJ6CxJ
         ZoBMRQKS5zXdKdIzqNWm3vfjpyquQfIHOfFBmQB/g/p3DReLav/qwmOTMqQjA00P5YVJ
         i8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714716; x=1759319516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chAO9GOTMxCV8ZHg6BsIF9VuSBV9TkSRS16Il152ztM=;
        b=sBiNtsrGSvUX8HR5HB/UMyQ0USBNj6KgxZtZ0dfxSzrExDtMKL50ogaw+T9TBclCwi
         sBsuBuOoEeV8A2wOiE3QgyQlMZ+w4SYCIT0yNG1ECsbTqPShCfu3gNKxKThjyShhLvhn
         5Gv6f4OULfGxeEDTeu0zotS4xOKMLZ7UIPMQ4kpi1HKP54wes0z6nLXPhFnQ89TmBvsc
         1R4aVR+PUhvo/hmcz1Zpsb6y7hIGdQESF1yQNgIzNDCdi4446xjfuYM7Gc2/y/zGBI7L
         6CTNC4RKnn0KSPLyeE4cyLEZVsGfMGFz50CuZUCvTNbD6EwgkFxOXAjndykzfMg6e5Pv
         1+Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWd1dnYc0zmeTtGD5JT1NEEzj9iZgeFtoYKhG0byS48oY+WsL3rehhUm+/fQzZ4C8o2KwF36JeGtJCn67S9JUj6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8zG4jPAuJ76mWRAnibsxHIKpe/wiFUv5+3Rat/6+eA4sh8T/u
	/O+shSCdjAz+CaF3HdmMgbWYq6PYmpZj5zOu9pGzQeKxsWrH9BJDBVCX
X-Gm-Gg: ASbGnctJ9G1g3GF/aSOy8I7ko+i65cX0u8OIWhDeg5Dhp5EuedSfF0yG07EI3dIPFG5
	G7WuAZF1kt1EppSc5RvnZecsBH7yZyigz2KQCtAAR9JBbVGD2//DnsF5jLuci9zrCN+qPpbfwXb
	P7VQKf8vNLcCGmGSDwBvz0Bw/TAS0unvBNjwLvyOjNEPGqHk8GihVBmvvZZ22jaH+w7q0OgJqyc
	9q9aScmp/BLa3d2io93N+yWuAw9eEEyPkZ03amzcutRihrQfGyJomH2Qs2o2Il0TMssqiNMpenU
	XOM2ibJm/3RvrC57/B2pByrVOKy44TdVZUBaZOcpoxThrGdCSDx+uNATMfh1V8MybTPvNxsNzxW
	QBUFbp3GubfUUkrqz18LB+qxJUQ==
X-Google-Smtp-Source: AGHT+IFFFBAirf0qABtQMOGn8HizILgeTQ+bDMYj/NiaLIThYCj5lgAdNhjPQRMYiuEyFN0bl+W06w==
X-Received: by 2002:a17:903:19ef:b0:27d:6cb6:f7c2 with SMTP id d9443c01a7336-27ec11ff7d5mr23462095ad.17.1758714716359;
        Wed, 24 Sep 2025 04:51:56 -0700 (PDT)
Received: from localhost ([23.142.224.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980179981sm188216855ad.54.2025.09.24.04.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:51:55 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
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
Subject: [PATCH v5 06/23] mm/ksw: add singleton /proc/kstackwatch interface
Date: Wed, 24 Sep 2025 19:50:49 +0800
Message-ID: <20250924115124.194940-7-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924115124.194940-1-wangjinchao600@gmail.com>
References: <20250924115124.194940-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide the /proc/kstackwatch file to read or update the configuration.
Only a single process can open this file at a time, enforced using atomic
config_file_busy, to prevent concurrent access.

ksw_get_config() exposes the configuration pointer as const.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kernel.c      | 77 +++++++++++++++++++++++++++++++++++-
 mm/kstackwatch/kstackwatch.h |  3 ++
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index 3b7009033dd4..4a06ddadd9c7 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -3,11 +3,15 @@
 
 #include <linux/kstrtox.h>
 #include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/string.h>
+#include <linux/uaccess.h>
 
 #include "kstackwatch.h"
 
 static struct ksw_config *ksw_config;
+static atomic_t config_file_busy = ATOMIC_INIT(0);
 
 struct param_map {
 	const char *name;       /* long name */
@@ -74,7 +78,7 @@ static int ksw_parse_param(struct ksw_config *config, const char *key,
  * - sp_offset  |so (u16) : offset from stack pointer at func_offset
  * - watch_len  |wl (u16) : watch length (1,2,4,8)
  */
-static int __maybe_unused ksw_parse_config(char *buf, struct ksw_config *config)
+static int ksw_parse_config(char *buf, struct ksw_config *config)
 {
 	char *part, *key, *val;
 	int ret;
@@ -109,18 +113,89 @@ static int __maybe_unused ksw_parse_config(char *buf, struct ksw_config *config)
 	return 0;
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
+	seq_printf(m, "%s\n", ksw_config->user_input);
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
+	kfree(ksw_config->func_name);
+	kfree(ksw_config->user_input);
 	kfree(ksw_config);
 
 	pr_info("module unloaded\n");
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

