Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917E13D813C
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054009; cv=none; b=DedIePI68CB+gfui1yQACFzS5W0a0DD2owjKWc8UG+Wsiy8PgTPTYB/gqjIgOSGWsPzzG4g+IhMAWLG3wFie3sbaTArhQ0Q4MzGE05VtL1mYnSLM7zeld3cxWXapQa9ET1eNu+UkiFE7i3g8+fwF4rCBkMYx2MdTLNdNa6ooDio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054009; c=relaxed/simple;
	bh=LZkXuS1KQM4u6yZNSGgAkuzTyvZnzYtMW4OZU5Ks2aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEDdLVPKNeNmshuH3nEAw4YUai6DKRF2jh5Ej5pXMUZZ7Sa71zYXE+dwGySsOdJA6MqCSHuocOni/8+mVB8Ab+BSfs4zDSbJOZQRMTgBuq1AQmBDxUShZ4FFRWUSCssP4tQc1BULuvckT/3kHFNFB3V2roHiuWE6eB+Wpj1m5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQc+V4K7; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQc+V4K7"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c2149571dso11018851cf.3
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 11:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784054005; x=1784658805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wwi2vZyFk7t6QSsln2rKKiHEkjJToMmeoCsJaB6hu68=;
        b=nQc+V4K70eQXnzr69GlU0dkZ0AFtoToUnseJ6w8JOpm+2JIa/Mz0Q9gUmrhACHRYy+
         f9wHfMrmFPOHE1Z76dqNElNIYn4Ky3oWsEczFYOjuW56en4Ekt57OFevWeViKZGcrgei
         fm2dApmvN+NbRCEiweDvC2rHAwULF5KdIanRwca+oJIrd+5iH59VRRBk7T4g+IET2fhg
         hqN6oeGySe9V/zNWhc2HTr2vtzLf3maR7W7z74166u0T1wekElL6f4gIy7fipFnU8NiH
         LskLhQxAsYDTsCbtyjSQgsE7btnDC983uPN9LxVl/uGmLWvphjjg7TP4CBhd8DGiy/uj
         XfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784054005; x=1784658805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wwi2vZyFk7t6QSsln2rKKiHEkjJToMmeoCsJaB6hu68=;
        b=URZjOJOByyXsDOnRZPsGYfcXxEAGhh3dTq1LVlRdfWHn+cjCi9rQoI7eEInjh+SqOp
         sh4HpVOI92OKmHLaza/h/tfcIvSTCfEhvY5y7C1i2wNSHD1R9oZ5CpGbS2ei+AHIbqsI
         DdwviUaOKuQi4u1UGXVjLRoOnQ2qkF8mv3eNQrbJHd5B6VnEna2pcFD9npbSh5b3sxKr
         V+u6xnaqOctnPSdm4Khj8UWeQzv17f4eyHR9MXerNcuEJTXkh407oW4+1eBb0kudzvMW
         sWSe2tRYu65T3w2t3MskR6hAjzHV+W2YORDyCcYGqzPdA5QU/HScUZRz6JPgxNUFdiR/
         aBOw==
X-Forwarded-Encrypted: i=1; AHgh+Rq13iB8KEcK+ylqXZFfEU+M8NfFct9CBIy1EqIGmbGy1U4hL72k2ZZIguoJguy9zrGoFeadmrINMsOmEPeXdU8G@vger.kernel.org
X-Gm-Message-State: AOJu0YwObsRonr7+yLTTnoGfRqp9IY6g3b7UKGK8JrhCdrZMBb32zkaF
	HPQqylf1UTfVI2p+DFWFYAbzvbABVFQh5aut1Rz/Mbih+nwt/nVfX2IYZbbj1Q==
X-Gm-Gg: AfdE7ckt71Xap0XKI3NoOJ1ZHwtu9ru/tpdjZ3dX4SikAeqkkRDm5VpqWkjFGfi9NNs
	a1ICjfqInwc7MElHwGvLGYJ4UH7Brquw1POyBa8ElxZloT2NsAw2qCMPoArG+qIIwGpdBteH/ak
	y9Oo/R65J95N6MqpUWSN5OO86Gs75HeDGkBERZ2kGY9/QtMvrb05naU4pcW8MPRlb2HDORe10Cd
	RAJcOG+5vbXgfh3080rvVm1CzjVfikaX3FW1KGmLTpjW5bR6GlG/yt42sNDrkf1v9OwUTB0/PpD
	KUGJ1xKdvSl6gsyO1v6baFOzdhypveu4+LnZYx0vjbKAdOEsSXjEuqs3elBdjPkh/Rd7yLShhQt
	lAUpnDarxCUOCzP44bvgmQP2nUafZiYWyOj533ZOesbS62a+quqfMHhP6idd3y60PdadkP3yHqX
	JceoT9CoKFXg/EaDnI10epC7QhGxeGS79+etpFJrV2Ib+9jN3egxE=
X-Received: by 2002:a05:622a:53c7:b0:51c:7b12:120b with SMTP id d75a77b69052e-51cbf2ff3f6mr153433161cf.73.1784054005304;
        Tue, 14 Jul 2026 11:33:25 -0700 (PDT)
Received: from localhost ([48.45.163.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-903083910d1sm144098546d6.12.2026.07.14.11.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:33:24 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 11/13] mm/kwatch: add debugfs control plane
Date: Wed, 15 Jul 2026 02:33:16 +0800
Message-ID: <20260714183316.12964-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714182243.10687-1-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
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
 mm/kwatch/Kconfig  |  17 +++
 mm/kwatch/Makefile |   2 +-
 mm/kwatch/core.c   | 325 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 353 insertions(+), 1 deletion(-)
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
index 000000000000..b1c37a829dd5
--- /dev/null
+++ b/mm/kwatch/Kconfig
@@ -0,0 +1,17 @@
+config KWATCH
+	tristate "Kernel Watch Framework"
+	depends on PERF_EVENTS && HAVE_HW_BREAKPOINT && DEBUG_FS
+	depends on HAVE_REINSTALL_HW_BREAKPOINT
+	select KPROBES
+	select KRETPROBES
+	select STACKTRACE
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
index 000000000000..548d0cdd0812
--- /dev/null
+++ b/mm/kwatch/core.c
@@ -0,0 +1,325 @@
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
+	if (kwatch_config.access_type > 3) {
+		pr_err("Invalid access_type (must be 0-3)\n");
+		return -EINVAL;
+	}
+
+	ret = kwatch_hwbp_prealloc(kwatch_config.max_watch,
+				   kwatch_config.access_type);
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
+	cfg->access_type = 0;
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
+		} else if (!strcmp(key, "access_type")) {
+			ret = kstrtouint(val, 0, &cfg->access_type);
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
+	if (watching_active) {
+		len += scnprintf(out_buf + len, MAX_CONFIG_STR_LEN - len,
+				 "func_name=%s\n"
+				 "func_offset=%u\n"
+				 "depth=%u\n"
+				 "duration=%u\n"
+				 "max_concurrency=%u\n"
+				 "max_watch=%u\n"
+				 "access_type=%u\n"
+				 "watch_len=%u\n",
+				 kwatch_config.func_name,
+				 kwatch_config.func_offset, kwatch_config.depth,
+				 kwatch_config.duration,
+				 kwatch_config.max_concurrency,
+				 kwatch_config.max_watch,
+				 kwatch_config.access_type,
+				 kwatch_config.watch_len);
+
+		if (kwatch_config.base == KWATCH_BASE_GLOBAL_SYM) {
+			len += scnprintf(out_buf + len, MAX_CONFIG_STR_LEN - len,
+					 "sym_addr=0x%lx\n", kwatch_config.sym_addr);
+		}
+
+		len += scnprintf(out_buf + len, MAX_CONFIG_STR_LEN - len,
+				 "watch_expr=%s\n"
+				 "nmi_rejected=%lu\n",
+				 kwatch_config.watch_expr,
+				 kwatch_probe_nmi_rejected());
+	} else {
+		len = scnprintf(out_buf, MAX_CONFIG_STR_LEN, "not watching\n");
+	}
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

