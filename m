Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15698279DCD;
	Wed, 10 Sep 2025 05:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757481912; cv=none; b=Etb9CumE1KiBoVnrvxa8ZRnIckkYmJ/SdQ5KsYfYCBuo9Sf3HV8yKSqkTlSTwuKxfWOfzyCKuxq0a+0Yw0ZhP1wM7LciUygQBYTwqtJhW5jCG+idBR/LvxUcSh3zaDe+rnAWT4IGdiRQCtC3uuspYiBhFLbOWyXmnIo8aSN4M7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757481912; c=relaxed/simple;
	bh=xhEgADxCH9HYuhwsYpDsUfcMELRNH4wMvbrMimvNP+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tc3cWGvUP0cWLu7pYogsAAwmOzuZF43AwtZgF8CCWWn1FtX/Zhvy4doEZ9hoXb2hjs4RLxb/kmcsovq8uee4sAKOS4j5DLwW6IsUvKJGvHD3MU8uW39mV4WNkfg7ZxKk3yEHBVJearwgVz6Hsp7ZDkobNtSfN9YyFnBsSk3ZTcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chFSDshB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chFSDshB"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-25221fa3c9bso2352545ad.0;
        Tue, 09 Sep 2025 22:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757481910; x=1758086710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWZ0kuFk/JGga2KckHsx8bbCMGd9rBXEdZWbqFyn8fw=;
        b=chFSDshBEK1Gma7Eaz3Q5B/DXpx75dOk2ZjQvZkCvZ56j6SB4XGMKmGCn9UzYOx8WM
         a9RurmxkeRteFRUxv+DTX8niqmFtyLPmThb+/JENXa/pbvRvKUvIUo9aY6RUA8eB3tpn
         jnzHySp8I2p4VctQ3Hut0TjPgg0Z4UJC2rD0Rn3y61YWz9ZkwgGSq6LovWW4a6YxsHIs
         mGVSUC7HhFkZrueJB5hPcljqqWzETkkYNbuOddmvJlXlSDim0ax7xdaaFEG+D4TRpxGX
         TmQmuqodjxCLQ8Armx8IcTZ8Qwf3H/CMRb6hvrBLdAXVIMREgJ9rVkR8ljnhG4r9QtPB
         67Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757481910; x=1758086710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWZ0kuFk/JGga2KckHsx8bbCMGd9rBXEdZWbqFyn8fw=;
        b=D2gAcCUGcHvH0GFEBNHuCPpN4YlWfJ1u19DnSW6KID28johUb73IS+WPmtEKfR0tfv
         Jmth6e62BJCxiyNX8ZbCLMy/Xq24nZf7aMA0ED0+qG6mOO1P6jBR1eyF91SSxXJ5axlq
         y7BKVFC9ipGR2WE/Ee8vg60S+PIt7yVHK0rbZHpMg3FlC9/uPdxw58pu4aILh/Jlh3Tq
         nD49wc0vb3S8zhl8VgKyXljxJom3tmWpb1knJ4VPZ8W86MG39TmiraeJy9YeJNyP2gE6
         5CjQ0F5fFIO0/6iPIcWoEvmm570pPP468JGIZRNhkmuKJTZKcng4fTMIhAzAngadmahm
         R3Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUPsNdQZqx1q7ONiYx2WRU6wq7hEeT2h9NHrjpYkFjRZEbyvKKxh+qhZ02JihIIEZ9fuirTtkNyODdO+i9/antv@vger.kernel.org, AJvYcCXrZ0lR5RO3bkwcu2lFFwbkJ9ftlC0EVNte2S+zMz60wdEiej2IgNDcnbckptHWAiUnendxWthk5V1RKKoEQ075vOGz@vger.kernel.org
X-Gm-Message-State: AOJu0YzoFbxQFogbb+RsMDW88QXCh/RP9e5s2q8+vlSfk4lbvNB0LhxA
	4sneHBOSSf6JrjhGQjuLq1NqwqB+fQIeDYQlGn5nShlHNACqa2jGK919
X-Gm-Gg: ASbGncs0MonD9L+vaUYSzR+csjrP8ASqcLNviqJzdkPJseBdWAyWfldxGGl9dtgMIoC
	D7Z2p9iTCNq+YWlcUemtLpURWJS3TSIS2qeaJrzsGiTqFL2SGJ2syR0cYr22x7XY+ctEQzs3GYV
	6PopSkK8FGF6cySJl474M5dPfr7DZhathM5EwI2TAbQV1NXARtZRjYFoJ0Zu3b972pX/OWevZfA
	9O9o61zITpdAYXr+dMb9Ash6UPispXCIMVzq+c9qgGmtSethgAjZhmMJGBpnnVu/jw85Bo9PLww
	JHLonGtna3VNT6KxJFXFXiCuTqQsD1l+BPzkVd12yCsqEnCWYOsfo1dM2vb9HbCF18dB8QjzRDd
	d2o5xZU6pCYhGTStR8skfEpBrVoWNLwEHAw==
X-Google-Smtp-Source: AGHT+IG95EjfmArTGKA4Yy6wwIVaXBUIZfTy9kHKEqCt/V+MK+/id9OZOKBsB4fgqQKzyzs2zL/CxQ==
X-Received: by 2002:a17:902:f78f:b0:24c:e9de:ee11 with SMTP id d9443c01a7336-251788fcff7mr180480145ad.17.1757481910286;
        Tue, 09 Sep 2025 22:25:10 -0700 (PDT)
Received: from localhost.localdomain ([2403:2c80:17::10:4007])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a27422ebcsm14815125ad.29.2025.09.09.22.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 22:25:09 -0700 (PDT)
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
Subject: [PATCH v3 04/19] mm/ksw: add ksw_config struct and parser
Date: Wed, 10 Sep 2025 13:23:13 +0800
Message-ID: <20250910052335.1151048-5-wangjinchao600@gmail.com>
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

Add struct ksw_config and ksw_parse_config() to parse user string.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kernel.c      | 91 ++++++++++++++++++++++++++++++++++++
 mm/kstackwatch/kstackwatch.h | 33 +++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index 40aa7e9ff513..1502795e02af 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -1,20 +1,111 @@
 // SPDX-License-Identifier: GPL-2.0
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/kstrtox.h>
 #include <linux/module.h>
+#include <linux/string.h>
+
+#include "kstackwatch.h"
 
 MODULE_AUTHOR("Jinchao Wang");
 MODULE_DESCRIPTION("Kernel Stack Watch");
 MODULE_LICENSE("GPL");
 
+static struct ksw_config *ksw_config;
+
+/*
+ * Format of the configuration string:
+ *    function+ip_offset[+depth] [local_var_offset:local_var_len]
+ *
+ * - function         : name of the target function
+ * - ip_offset        : instruction pointer offset within the function
+ * - depth            : recursion depth to watch
+ * - local_var_offset : offset from the stack pointer at function+ip_offset
+ * - local_var_len    : length of the local variable(1,2,4,8)
+ */
+static int __maybe_unused ksw_parse_config(char *buf, struct ksw_config *config)
+{
+	char *func_part, *local_var_part = NULL;
+	char *token;
+	u16 local_var_len;
+
+	memset(ksw_config, 0, sizeof(*ksw_config));
+
+	/* set the watch type to the default canary-based watching */
+	config->type = WATCH_CANARY;
+
+	func_part = strim(buf);
+	strscpy(config->config_str, func_part, MAX_CONFIG_STR_LEN);
+
+	local_var_part = strchr(func_part, ' ');
+	if (local_var_part) {
+		*local_var_part = '\0'; // terminate the function part
+		local_var_part = strim(local_var_part + 1);
+	}
+
+	/* parse the function part: function+ip_offset[+depth] */
+	token = strsep(&func_part, "+");
+	if (!token)
+		goto fail;
+
+	strscpy(config->function, token, MAX_FUNC_NAME_LEN - 1);
+
+	token = strsep(&func_part, "+");
+	if (!token || kstrtou16(token, 0, &config->ip_offset)) {
+		pr_err("failed to parse instruction offset\n");
+		goto fail;
+	}
+
+	token = strsep(&func_part, "+");
+	if (token && kstrtou16(token, 0, &config->depth)) {
+		pr_err("failed to parse depth\n");
+		goto fail;
+	}
+	if (!local_var_part || !(*local_var_part))
+		return 0;
+
+	/* parse the optional local var offset:len */
+	config->type = WATCH_LOCAL_VAR;
+	token = strsep(&local_var_part, ":");
+	if (!token || kstrtou16(token, 0, &config->local_var_offset)) {
+		pr_err("failed to parse local var offset\n");
+		goto fail;
+	}
+
+	if (!local_var_part || kstrtou16(local_var_part, 0, &local_var_len)) {
+		pr_err("failed to parse local var len\n");
+		goto fail;
+	}
+
+	if (local_var_len != 1 && local_var_len != 2 &&
+	    local_var_len != 4 && local_var_len != 8) {
+		pr_err("invalid local var len %u (must be 1,2,4,8)\n",
+		       local_var_len);
+		goto fail;
+	}
+	config->local_var_len = local_var_len;
+
+	return 0;
+fail:
+	pr_err("invalid input: %s\n", config->config_str);
+	config->config_str[0] = '\0';
+	return -EINVAL;
+}
+
 static int __init kstackwatch_init(void)
 {
+	ksw_config = kzalloc(sizeof(*ksw_config), GFP_KERNEL);
+	if (!ksw_config)
+		return -ENOMEM;
+
 	pr_info("module loaded\n");
 	return 0;
 }
 
 static void __exit kstackwatch_exit(void)
 {
+	kfree(ksw_config);
+
 	pr_info("module unloaded\n");
 }
 
diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
index 0273ef478a26..7c595c5c24d1 100644
--- a/mm/kstackwatch/kstackwatch.h
+++ b/mm/kstackwatch/kstackwatch.h
@@ -2,4 +2,37 @@
 #ifndef _KSTACKWATCH_H
 #define _KSTACKWATCH_H
 
+#include <linux/types.h>
+
+#define MAX_FUNC_NAME_LEN 64
+#define MAX_CONFIG_STR_LEN 128
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

