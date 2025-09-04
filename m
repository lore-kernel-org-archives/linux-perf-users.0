Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043BC15A85A;
	Thu,  4 Sep 2025 00:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945327; cv=none; b=Q+atom1wMuivk5+flywvTAMPXZZUv2cHEY8BKLzPRTa/MLLZydzL40eUpVh6aLq29Y2/Oschw/celRdB5U8F2V5BI+DWjBfAGM9DT3fNOf1o1LtZAX3X7YsJm5LKQvEjqYct0b/Sk4GAqqiuYBu2eOR4dyyQecfS2sp0mzXcQLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945327; c=relaxed/simple;
	bh=f7oIGMu82h0EUyi+ciPNEzqBC4KP/xyBf4hESY7E3jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLFiTgjOGMs3ex3cFXwha5CM2ArRVFSEafPgJyCfHpOYvxVcVvaJva5g8igX06Snxvt3tjnDNM/P4JwEvP4tr9uBqZ6jInl66K6wji76Fs+s8E5vQrraL39x4bboMjS+dklBY7mkMZ+gG4iIXw3eYKK29GCf6NIKLuQXOMuhRY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKnRodn3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKnRodn3"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7728815e639so322502b3a.1;
        Wed, 03 Sep 2025 17:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756945325; x=1757550125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oy0C0swglM9nhMs2jJeQr2J+ATypwXUQHvq+zmKtZ8o=;
        b=XKnRodn3Inx8Xhhnph1zuOWsE/yd7U6UBOdI/lGMmLtfRH7erYgLHeeGNQgd5DGG1L
         fgBjdDVzL/9I3NzFVFTpkNEhWFHof2kz53YelkFgcx+AZ8BuIzs9xe6zxJ076CxvUYUV
         0VolvCZtvNS7TspdbDF2rYF4ukO1moT1knoKkupCKjYlX1YVTXshvs5ejSoBz9CE0mDp
         BkvT+w22Qa3PbBT2m0WhOUCc5OeWu5fIFDdtlscHRaj/KDH3WoEydJRRT9o3IK3An6uC
         nzZrNai4gV5ZludOPOAhIAJondmZ30n8w8JXg4nQ3fqQQHd4BxrVJoVsF86h7of/jinV
         rTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945325; x=1757550125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oy0C0swglM9nhMs2jJeQr2J+ATypwXUQHvq+zmKtZ8o=;
        b=cwpWnchepOYTYoh6P6cPPv68XBo/NWdxQyZhIoSAJvsz8vSCFD1AqOK8UQ0n87NW9K
         fFYcyWv40YRC+0NxQSEU5M03KCZxAHX4wSnM12jxHzePhzHZ+c0av4yVL0snmHYSKezX
         nJAPh3UfQb5Lsq0A011eCCS5dGUSjyzICCkZFrauIpYz3XaB01d5JwbuZ0GZiwr0WJ1e
         ABlIpqlXS1Tsinlslg4LDPa9jk3ikBqy0GnHAebF8m1/AWi6isVfm8u2LhsXPajlL75K
         woZapPEtBzjs68fosRitKbRsIVeVzTySMPqrC83IRsLEql0mDuOSQM5xomlXTArqAyue
         jo/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgG3amTAGU9x1d7CyUTitGqDplIsJxRU6QvNYvnbL028JsXM/YhXltkqfKLaWGhqgeRbxtHVZJTDCDXl1CYlWDwld9@vger.kernel.org, AJvYcCWuOuTqaEbTCf8ttZRQjW/my2zApS98IyaGyKJLoiKamSIFxd/tDmi4xuQtHGpCrqwhAWeBNajKUKykBRDui3S8@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd7CajxHjqT6JmnW7V22iMgchyrRpJcQsbnQGEKCfB8/fHfIZe
	wHsRUzOJhEj1o9ZLt/wuDwo6VBCsgWYlcyclCbLWib0Dv0TfqBbTOvNx
X-Gm-Gg: ASbGncswigQvUh8mLuP+Ox0LsfOEDY2sVTFr2l4T2E3JpvZ8lk2bduZ32GzG+kiiwIg
	WT42x2kq4X5TKUhxfiWDc5PfUFFpxX/MlVUBGTuFaT02LCOn3c9cQWkALiTZL067GYn7kudMAKA
	2QTrJuUHNWHqs5CZizMNWOKZqKvi0yNPx009FOXgQYB+dcpR1lE4UkYEZleoNVs1bHvQTk3GZHq
	HiYAXt0vzavWVy8CfAlySCj4DskbAVIWUhGYFBvBEiqBHTc6CSfhbHT37bS8lQElDw1/B7UeG4V
	UMn6sPvcpnVaxlOvp76hNPIwzs9dDXcN1cJx0hvEpSnsIDOwq8BZNbcpLv+qRxSioV7jTpkeK1d
	olqxg/jGU/gSwkyM4WJ7GwAVW71dQBNAz9ZAWhXtJI1ZDwOrYpo6km1msw/1bgxk=
X-Google-Smtp-Source: AGHT+IFybxLzi3RhG8G6E0XW25a7NBfoJQUABi3RBwpHwqaPA2H33RcEs3ZAByeGLnEmBrGiX7iCMw==
X-Received: by 2002:a05:6a20:4c8f:b0:244:58:c147 with SMTP id adf61e73a8af0-2440058c3f7mr9480142637.21.1756945325307;
        Wed, 03 Sep 2025 17:22:05 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bd2aesm17579551b3a.48.2025.09.03.17.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:22:04 -0700 (PDT)
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
Subject: [PATCH v2 02/18] mm/ksw: add ksw_config struct and parser
Date: Thu,  4 Sep 2025 08:20:59 +0800
Message-ID: <20250904002126.1514566-3-wangjinchao600@gmail.com>
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

Add struct ksw_config and ksw_parse_config() to parse user string.

Update `Makefile` to pass compilation.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/Makefile      |  2 ++
 mm/kstackwatch/kernel.c      | 70 +++++++++++++++++++++++++++++++++++-
 mm/kstackwatch/kstackwatch.h | 34 ++++++++++++++++++
 3 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/Makefile b/mm/kstackwatch/Makefile
index 84a46cb9a766..d422f0e114dd 100644
--- a/mm/kstackwatch/Makefile
+++ b/mm/kstackwatch/Makefile
@@ -1,2 +1,4 @@
 obj-$(CONFIG_KSTACK_WATCH)	+= kstackwatch.o
 kstackwatch-y := kernel.o stack.o watch.o
+
+CFLAGS_kernel.o := -Wno-error=unused-function
diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index 93379a0a0f7e..4a6dc49449fe 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -1,11 +1,79 @@
 // SPDX-License-Identifier: GPL-2.0
-
+#include <linux/kstrtox.h>
 #include <linux/module.h>
+#include <linux/string.h>
+
+#include "kstackwatch.h"
 
 MODULE_AUTHOR("Jinchao Wang");
 MODULE_DESCRIPTION("Kernel Stack Watch");
 MODULE_LICENSE("GPL");
 
+/*
+ * Format of the configuration string:
+ *    function+ip_offset[+depth] [local_var_offset:local_var_len]
+ *
+ * - function         : name of the target function
+ * - ip_offset        : instruction pointer offset within the function
+ * - depth            : recursion depth to watch
+ * - local_var_offset : offset from the stack pointer at function+ip_offset
+ * - local_var_len    : length of the local variable
+ */
+static int ksw_parse_config(char *buf, struct ksw_config *config)
+{
+	char *func_part, *local_var_part = NULL;
+	char *token;
+
+	/* Set the watch type to the default canary-based monitoring */
+	config->type = WATCH_CANARY;
+
+	func_part = strim(buf);
+	strscpy(config->config_str, func_part, MAX_CONFIG_STR_LEN);
+
+	local_var_part = strchr(func_part, ' ');
+	if (local_var_part) {
+		*local_var_part = '\0'; // Terminate the function part
+		local_var_part = strim(local_var_part + 1);
+	}
+
+	/* 1. Parse the function part: function+ip_offset[+depth] */
+	token = strsep(&func_part, "+");
+	if (!token)
+		return -EINVAL;
+
+	strscpy(config->function, token, MAX_FUNC_NAME_LEN - 1);
+
+	token = strsep(&func_part, "+");
+	if (!token || kstrtou16(token, 0, &config->ip_offset)) {
+		pr_err("KSW: failed to parse instruction offset\n");
+		return -EINVAL;
+	}
+
+	token = strsep(&func_part, "+");
+	if (token && kstrtou16(token, 0, &config->depth)) {
+		pr_err("KSW: failed to parse depth\n");
+		return -EINVAL;
+	}
+	if (!local_var_part || !(*local_var_part))
+		return 0;
+
+	/* 2. Parse the optional local var: offset:len */
+	config->type = WATCH_LOCAL_VAR;
+	token = strsep(&local_var_part, ":");
+	if (!token || kstrtou16(token, 0, &config->local_var_offset)) {
+		pr_err("KSW: failed to parse stack variable offset\n");
+		return -EINVAL;
+	}
+
+	if (!local_var_part ||
+	    kstrtou16(local_var_part, 0, &config->local_var_len)) {
+		pr_err("KSW: failed to parse stack variable length\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int __init kstackwatch_init(void)
 {
 	pr_info("KSW: module loaded\n");
diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 0273ef478a26..b5f1835586c1 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -2,4 +2,38 @@
 #ifndef _KSTACKWATCH_H
 #define _KSTACKWATCH_H
 
+#include <linux/types.h>
+
+#define MAX_FUNC_NAME_LEN 64
+#define MAX_CONFIG_STR_LEN 128
+#define MAX_FRAME_SEARCH 128
+
+enum watch_type {
+	WATCH_CANARY = 0,
+	WATCH_LOCAL_VAR,
+};
+
+struct ksw_config {
+	/* function part */
+	char function[MAX_FUNC_NAME_LEN];
+	u16 ip_offset;
+	u16 depth;
+
+	/* local var, useless for canary watch */
+	/* offset from rsp at function+ip_offset */
+	u16 local_var_offset;
+
+	/*
+	 * local var size (1,2,4,8 bytes)
+	 * it will be the watching len
+	 */
+	u16 local_var_len;
+
+	/* easy for understand*/
+	enum watch_type type;
+
+	/* save to show */
+	char config_str[MAX_CONFIG_STR_LEN];
+};
+
 #endif /* _KSTACKWATCH_H */
-- 
2.43.0

