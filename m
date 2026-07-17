Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E783FC5A4
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293617; cv=none; b=oSeIEhjwvShAFSgZMXqcpnoD9bgrrbdnSJfXFvQG9WbtCdX2wWHhd81INafeM8JhTS7nc0h5zQHTzzdPPKp280tL6jw1U20ItklGnvKhxuCGZ3o4qoCaFy6RKPB2W1b+FywXEY8H4x/dz9OGD+dtUEzcHpStgxhkrozge50Zgr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293617; c=relaxed/simple;
	bh=mSZSjX34G0DYKny1FJRnV53asv5EFLj78ugJoIQTb8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kq0+BsUcUKOjwVS66zPnDxSKpe6fq/xB9zUsbnbjmR81KaRs7caHpTDHskcIGskiY3LfnT19M7MYKxKXnXake92zmos4wxsXeQH1P8mBIihW4B3SVf5z9fLJS3drzMLFuSTkXFf++0RD673CbzxHALWsuLzRR1nYEbeJS1Pg1Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPkfJx8M; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPkfJx8M"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso6063318a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 06:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784293615; x=1784898415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pe2aLEJuh1t7h3+VwKXqsCr8PrbeTbQwnX+mP9fCQIw=;
        b=SPkfJx8MFuIykPcL/5FcwNzS8Me8HEZ8Xhrn4PnbclqpX6qfkJlEjjwzU5iuLM8IVn
         u/szNJKS8rd3ddwvWrUR8CSgGOw31oVW1/dFXwps7bOmocHIxSRDjjUB1awMZT08MJ7u
         EVACB22NuTCo8oVk8pUBjpgi7/1u5dldj2HdyfOHhRVCMjrJYpTFyy1kXfCWwQ4w6G2z
         T65gC1DlnF3XfHrU12ugXcFswkshdkqxcVxuoEJWOomFMfFCaf83uch89L9t2MiQLO11
         lzCiCSchQzDqvrh60IR6/Jz9CzQGh1Gtt7IyipN9QU9qQjl1JFJYBuPAGurAkL3HH+37
         g5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784293615; x=1784898415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pe2aLEJuh1t7h3+VwKXqsCr8PrbeTbQwnX+mP9fCQIw=;
        b=cPSNLODJPa0WDB8VRaVpE7+qmU9LNk14r7eoVAUtlIM2lDZHkClGOxYHU99T1G7Tjr
         akPHryzCT71o+aRl+YH9o0dcO0gav+A9K924n0H6W/pmILvSYlq+CvdRnu8tlBEvJoIq
         AI1BmwnMDWWQKw1iNsXQleUM98TUnxd3okFXFlJroKo1ag15gkxeLEFTABNnHyjPSA5K
         lZs2iX2ogbC6XGGs/6VMBjppmEVMwrYmUYHy6tyOAXVRnlw72B4YJbV1OY8XMESsr6rE
         Wh9vFlUDwqhefKBx8+Zcu2LimPBc+G2axWetBNFXpOu1yT0wbCMoVVhmLFs2tDE03RsA
         Uzzw==
X-Forwarded-Encrypted: i=1; AHgh+Rq36OgJm5K1jx3YiiyRPEjMIjCv1YkqTZ+PnPNipRJ3SNWZu3FJhpYC7/at9Ycpgn7zJP6tRu7JFUDjBgv+dFcl@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlm5nvMyHoOLEDdZpy1W3UQ6ZmqU3NNXYkxC58iuWULLKY6eCd
	uT42QlgOl9K2P+fIrctJwfgrPdJsNPKfhtAGpEW6anKIDdJxixwvAqIw
X-Gm-Gg: AfdE7clQ5vEW5Hb2jHa7ST3X+7Y/KhfK29kqUUZk5vamOjSBEfl7HtRj1ywXiK0dE87
	I8HXGw/j+UCumyvoNY3dSJQE4X3gTbU6XGUh+Tq69bj+g6EkFWwdA+qi12DalfYFLnN6INZsEmW
	ncInDoBoP3G212kdVd1PCIt1NKlYHjolcLAnBiibmZ7ych48s8yllY+3xEx0ND6TAO/D2uR5yog
	HXB/qPWsPUvGeVO9cwlE88fADaAJmEVzfmEgXFQwlAMdHOPYbSY5PeXrVOcya3bMsmONeYmAwYB
	35XCOqnowzQQmZZ32iBlFo+LhhzYW/RYahDp61XBOokjRRy9Sla0Ee37x8vpBOon+/iazIJXm0s
	yIyS4yQH06ktyl2PUeAwwJVTDtLqT3TWyHHzKR3pzVrWXMORYO9yOnS3cYGNz6MvuNGVt8osd+D
	z4jA==
X-Received: by 2002:a17:90b:2dc1:b0:37f:fdc8:71b4 with SMTP id 98e67ed59e1d1-38e4b3e1424mr2506032a91.2.1784293614807;
        Fri, 17 Jul 2026 06:06:54 -0700 (PDT)
Received: from localhost ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bbda9sm6885623eec.19.2026.07.17.06.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:06:53 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH v2 11/13] mm/kwatch: add debugfs control plane
Date: Fri, 17 Jul 2026 09:06:37 -0400
Message-ID: <20260717130637.1903667-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717125023.1895892-1-wangjinchao600@gmail.com>
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wire the pieces together behind a single debugfs file,
/sys/kernel/debug/kwatch/config. Writing a key=value configuration
string stops any active session and starts a new one; reading shows
the active configuration and the nmi_rejected counter. An open-count
guard keeps the file single-open and a mutex serializes
start/stop/auto-stop against each other.

Add the Kconfig entry and hook mm/kwatch into the mm build. KWatch
can be built in or as a module; symbol-name watch expressions need
the built-in flavour (kallsyms_lookup_name is not exported).

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 MAINTAINERS        |   8 ++
 mm/Kconfig         |   1 +
 mm/Makefile        |   1 +
 mm/kwatch/Kconfig  |  16 +++
 mm/kwatch/Makefile |   2 +-
 mm/kwatch/core.c   | 324 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 351 insertions(+), 1 deletion(-)
 create mode 100644 mm/kwatch/Kconfig
 create mode 100644 mm/kwatch/core.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7cc4bca5a2c5..b6371f92fe5c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14578,6 +14578,14 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
 F:	arch/x86/kvm/xen.*
 
+KWATCH
+M:	Jinchao Wang <wangjinchao600@gmail.com>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	Documentation/dev-tools/kwatch.rst
+F:	include/trace/events/kwatch.h
+F:	mm/kwatch/
+
 L3MDEV
 M:	David Ahern <dsahern@kernel.org>
 L:	netdev@vger.kernel.org
diff --git a/mm/Kconfig b/mm/Kconfig
index 9e0ca4824905..cac75a46e21a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1510,5 +1510,6 @@ config LAZY_MMU_MODE_KUNIT_TEST
 	  If unsure, say N.
 
 source "mm/damon/Kconfig"
+source "mm/kwatch/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index eff9f9e7e061..80c688330358 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_PAGE_POISONING) += page_poison.o
 obj-$(CONFIG_KASAN)	+= kasan/
 obj-$(CONFIG_KFENCE) += kfence/
 obj-$(CONFIG_KMSAN)	+= kmsan/
+obj-$(CONFIG_KWATCH) += kwatch/
 obj-$(CONFIG_FAILSLAB) += failslab.o
 obj-$(CONFIG_FAIL_PAGE_ALLOC) += fail_page_alloc.o
 obj-$(CONFIG_MEMTEST)		+= memtest.o
diff --git a/mm/kwatch/Kconfig b/mm/kwatch/Kconfig
new file mode 100644
index 000000000000..9daf6d4463ef
--- /dev/null
+++ b/mm/kwatch/Kconfig
@@ -0,0 +1,16 @@
+config KWATCH
+	tristate "Kernel Watch Framework"
+	depends on PERF_EVENTS && HAVE_HW_BREAKPOINT && DEBUG_FS
+	depends on HAVE_REINSTALL_HW_BREAKPOINT
+	depends on KPROBES && KRETPROBES
+	depends on STACKTRACE
+	help
+	  A generalized hardware-assisted memory monitor utility.
+	  It provides a low-overhead, real-time trigger mechanism to monitor
+	  kernel memory safely in atomic contexts using hardware breakpoints.
+
+	  KWatch is designed to catch silent memory corruptions, stack
+	  overwrites, and complex Heisenbugs by synchronously trapping the
+	  exact instruction causing the illegal access.
+
+	  If unsure, say N.
diff --git a/mm/kwatch/Makefile b/mm/kwatch/Makefile
index b196c794619a..02d7917602f1 100644
--- a/mm/kwatch/Makefile
+++ b/mm/kwatch/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_KWATCH) += kwatch.o
 
-kwatch-y := deref.o task_ctx.o hwbp.o probe.o anchor.o
+kwatch-y := core.o deref.o task_ctx.o hwbp.o probe.o anchor.o
diff --git a/mm/kwatch/core.c b/mm/kwatch/core.c
new file mode 100644
index 000000000000..d8526d5aae5c
--- /dev/null
+++ b/mm/kwatch/core.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kstrtox.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/atomic.h>
+#include <linux/debugfs.h>
+#include <linux/mutex.h>
+#include "kwatch.h"
+
+static struct kwatch_config kwatch_config;
+static bool watching_active;
+
+static struct dentry *dbgfs_dir;
+static struct dentry *dbgfs_config;
+static DEFINE_MUTEX(kwatch_dbgfs_mutex);
+static atomic_t dbgfs_config_busy = ATOMIC_INIT(0);
+
+static int kwatch_start_watching(void)
+{
+	int ret;
+
+	if (!strlen(kwatch_config.func_name)) {
+		if (kwatch_config.duration > 0) {
+			strscpy(kwatch_config.func_name, "kwatch_global_anchor",
+				sizeof(kwatch_config.func_name));
+		} else {
+			pr_err("func_name or duration is required\n");
+			return -EINVAL;
+		}
+	} else if (kwatch_config.duration > 0 &&
+		   strcmp(kwatch_config.func_name, "kwatch_global_anchor")) {
+		pr_warn("duration is ignored when watching a specific function\n");
+	}
+
+	ret = kwatch_hwbp_prealloc(kwatch_config.max_watch);
+	if (ret) {
+		pr_err("kwatch_hwbp_prealloc ret: %d\n", ret);
+		return ret;
+	}
+
+	ret = kwatch_tsk_ctx_prealloc(kwatch_config.max_concurrency);
+	if (ret) {
+		kwatch_hwbp_free();
+		return ret;
+	}
+
+	ret = kwatch_probe_start(&kwatch_config);
+	if (ret) {
+		pr_err("kwatch_probe_start ret: %d\n", ret);
+		kwatch_tsk_ctx_free();
+		kwatch_hwbp_free();
+		return ret;
+	}
+
+	if (!strcmp(kwatch_config.func_name, "kwatch_global_anchor")) {
+		ret = kwatch_anchor_start(kwatch_config.duration);
+		if (ret) {
+			kwatch_probe_stop();
+			synchronize_rcu();
+			kwatch_tsk_ctx_release_wps();
+			kwatch_hwbp_free();
+			kwatch_tsk_ctx_free();
+			return ret;
+		}
+	}
+
+	watching_active = true;
+	return 0;
+}
+
+static void kwatch_stop_watching(void)
+{
+	watching_active = false;
+
+	kwatch_anchor_stop();
+	/* after kthread_stop: the dead thread cannot re-mark expiry */
+	kwatch_anchor_clear_expired();
+
+	kwatch_probe_stop();
+	synchronize_rcu();
+	kwatch_tsk_ctx_release_wps();
+	/*
+	 * Waits for disarm IPIs and unregisters breakpoints: no #DB can
+	 * reach the ctx pool once this returns.
+	 */
+	kwatch_hwbp_free();
+	kwatch_tsk_ctx_free();
+}
+
+void kwatch_auto_stop(void)
+{
+	mutex_lock(&kwatch_dbgfs_mutex);
+	/* the expired check neutralizes work items from torn-down sessions */
+	if (watching_active && kwatch_anchor_has_expired()) {
+		kwatch_stop_watching();
+		pr_info("watch duration expired, stopped watching\n");
+	}
+	mutex_unlock(&kwatch_dbgfs_mutex);
+}
+
+static int kwatch_config_parse(char *buf, struct kwatch_config *cfg)
+{
+	char *token, *key, *val;
+	int ret = 0;
+
+	memset(cfg, 0, sizeof(*cfg));
+	cfg->max_concurrency = 256;
+	cfg->max_watch = 4;
+	cfg->watch_len = 8;
+
+	while ((token = strsep(&buf, " \t\n")) != NULL) {
+		if (!*token)
+			continue;
+		key = strsep(&token, "=");
+		val = token;
+		if (!key || !val)
+			return -EINVAL;
+
+		if (!strcmp(key, "func_name")) {
+			strscpy(cfg->func_name, val, sizeof(cfg->func_name));
+		} else if (!strcmp(key, "func_offset")) {
+			ret = kstrtou16(val, 0, &cfg->func_offset);
+		} else if (!strcmp(key, "depth")) {
+			ret = kstrtou16(val, 0, &cfg->depth);
+		} else if (!strcmp(key, "max_concurrency")) {
+			ret = kstrtou16(val, 0, &cfg->max_concurrency);
+		} else if (!strcmp(key, "max_watch")) {
+			ret = kstrtou16(val, 0, &cfg->max_watch);
+		} else if (!strcmp(key, "watch_len")) {
+			ret = kstrtou16(val, 0, &cfg->watch_len);
+			if (!ret && cfg->watch_len != 1 &&
+			    cfg->watch_len != 2 && cfg->watch_len != 4 &&
+			    cfg->watch_len != 8)
+				ret = -EINVAL;
+		} else if (!strcmp(key, "duration")) {
+			ret = kstrtou16(val, 0, &cfg->duration);
+		} else if (!strcmp(key, "watch_expr")) {
+			strscpy(cfg->watch_expr, val, sizeof(cfg->watch_expr));
+			ret = kwatch_deref_parse(cfg, val);
+		}
+
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int kwatch_dbgfs_open(struct inode *inode, struct file *file)
+{
+	if (atomic_cmpxchg(&dbgfs_config_busy, 0, 1))
+		return -EBUSY;
+	return 0;
+}
+
+static int kwatch_dbgfs_release(struct inode *inode, struct file *file)
+{
+	atomic_set(&dbgfs_config_busy, 0);
+	return 0;
+}
+
+static ssize_t kwatch_dbgfs_read(struct file *file, char __user *user_buf,
+				 size_t count, loff_t *ppos)
+{
+	char *out_buf;
+	size_t len = 0;
+	ssize_t ret;
+
+	out_buf = kzalloc(MAX_CONFIG_STR_LEN, GFP_KERNEL);
+	if (!out_buf)
+		return -ENOMEM;
+
+	/*
+	 * Serialize against the write path and the auto-stop work item so the
+	 * config snapshot cannot tear or race a session teardown.
+	 */
+	mutex_lock(&kwatch_dbgfs_mutex);
+
+	if (watching_active) {
+		len += scnprintf(out_buf + len, MAX_CONFIG_STR_LEN - len,
+				 "func_name=%s\n"
+				 "func_offset=%u\n"
+				 "depth=%u\n"
+				 "duration=%u\n"
+				 "max_concurrency=%u\n"
+				 "max_watch=%u\n"
+				 "watch_len=%u\n",
+				 kwatch_config.func_name,
+				 kwatch_config.func_offset, kwatch_config.depth,
+				 kwatch_config.duration,
+				 kwatch_config.max_concurrency,
+				 kwatch_config.max_watch,
+				 kwatch_config.watch_len);
+
+		if (kwatch_config.base == KWATCH_BASE_GLOBAL_SYM) {
+			len += scnprintf(out_buf + len, MAX_CONFIG_STR_LEN - len,
+					 "sym_addr=0x%lx\n", kwatch_config.sym_addr);
+		}
+
+		len += scnprintf(out_buf + len, MAX_CONFIG_STR_LEN - len,
+				 "watch_expr=%s\n"
+				 "nmi_rejected=%lu\n"
+				 "arm_ipi_suppressed=%lu\n",
+				 kwatch_config.watch_expr,
+				 kwatch_probe_nmi_rejected(),
+				 kwatch_hwbp_arm_ipi_suppressed());
+	} else {
+		len = scnprintf(out_buf, MAX_CONFIG_STR_LEN, "not watching\n");
+	}
+
+	mutex_unlock(&kwatch_dbgfs_mutex);
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, out_buf, len);
+	kfree(out_buf);
+	return ret;
+}
+
+static ssize_t kwatch_dbgfs_write(struct file *file, const char __user *buffer,
+				  size_t count, loff_t *ppos)
+{
+	char *input_alloc;
+	char *parse_str;
+	int ret;
+
+	if (count == 0 || count >= MAX_CONFIG_STR_LEN)
+		return -EINVAL;
+
+	input_alloc = memdup_user_nul(buffer, count);
+	if (IS_ERR(input_alloc))
+		return PTR_ERR(input_alloc);
+
+	mutex_lock(&kwatch_dbgfs_mutex);
+
+	if (watching_active)
+		kwatch_stop_watching();
+
+	parse_str = strim(input_alloc);
+
+	if (!strlen(parse_str)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = kwatch_config_parse(parse_str, &kwatch_config);
+	if (ret) {
+		pr_err("Failed to parse config %d\n", ret);
+		goto out;
+	}
+
+	ret = kwatch_start_watching();
+	if (ret) {
+		pr_err("Failed to start watching with %d\n", ret);
+		goto out;
+	}
+
+	ret = count;
+
+out:
+	mutex_unlock(&kwatch_dbgfs_mutex);
+	kfree(input_alloc);
+	return ret;
+}
+
+static const struct file_operations kwatch_fops = {
+	.owner = THIS_MODULE,
+	.open = kwatch_dbgfs_open,
+	.release = kwatch_dbgfs_release,
+	.read = kwatch_dbgfs_read,
+	.write = kwatch_dbgfs_write,
+};
+
+static int __init kwatch_init(void)
+{
+	int ret = 0;
+
+	memset(&kwatch_config, 0, sizeof(kwatch_config));
+
+	dbgfs_dir = debugfs_create_dir("kwatch", NULL);
+	if (IS_ERR(dbgfs_dir)) {
+		ret = PTR_ERR(dbgfs_dir);
+		goto err_dir;
+	}
+
+	dbgfs_config = debugfs_create_file("config", 0600, dbgfs_dir, NULL,
+					   &kwatch_fops);
+	if (IS_ERR(dbgfs_config)) {
+		ret = PTR_ERR(dbgfs_config);
+		goto err_file;
+	}
+
+	pr_info("module loaded\n");
+	return 0;
+
+err_file:
+	debugfs_remove_recursive(dbgfs_dir);
+	dbgfs_dir = NULL;
+err_dir:
+	return ret;
+}
+module_init(kwatch_init);
+
+static void __exit kwatch_exit(void)
+{
+	mutex_lock(&kwatch_dbgfs_mutex);
+	if (watching_active)
+		kwatch_stop_watching();
+	mutex_unlock(&kwatch_dbgfs_mutex);
+
+	/* the anchor thread is dead: nothing can schedule new work now */
+	kwatch_anchor_cancel_work();
+
+	debugfs_remove_recursive(dbgfs_dir);
+	dbgfs_dir = NULL;
+
+	pr_info("kwatch unloaded\n");
+}
+module_exit(kwatch_exit);
+
+MODULE_AUTHOR("Jinchao Wang <wangjinchao600@gmail.com>");
+MODULE_DESCRIPTION("Kernel watchpoint");
+MODULE_LICENSE("GPL");
-- 
2.53.0

