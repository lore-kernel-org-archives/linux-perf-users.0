Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11BD2E7BC0
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671945; cv=none; b=K75QesXEaDtyk3GwCNcLbseCQPnk5+9jzq0mdmOtjoypDtnUoMnBhfYqm5s0O2mGMQypZhUIMTjFnG+pwnN8By00RpVf0ZU0Gw9XeFJ7H2YDe86SC5SDhqbdhmAYOqk+xTAkYxQJB/ntvyO6nq9ZpDWq0jeZvdmbBcr+gIvfaKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671945; c=relaxed/simple;
	bh=xhEgADxCH9HYuhwsYpDsUfcMELRNH4wMvbrMimvNP+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McT6PscNp9K+JTfGpcNhk8ip9vrbEpRdgZVj2weYv5q6VS0bMLA1lv4wUij87YIrn6y67tphBwmqi8yc76fEpP2q4sLr5nM4FmTA0zjYLShXTse6zG+ucoB0eWqAX/jO/PwFeaU7/JTnignl1ieDkfa2n0kyWXb62lQz1BaGOJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c15xj1QS; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c15xj1QS"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7725fb32e1bso1780793b3a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 03:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671942; x=1758276742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWZ0kuFk/JGga2KckHsx8bbCMGd9rBXEdZWbqFyn8fw=;
        b=c15xj1QSKbz4R78VR5Ydnn9qhuKW+VxOvGuRwITXMiYCDEIzarIhBT0b6Qv1LZdLfC
         2A+IYSKSr7ChOY6791wVSjLOJi7C9DuktUcAH/CAbeq10xOg52Drc6z6GmfYoLYKczAZ
         ZHtySvi3DhvAIAU7tp4uI/weAx/4rsfuhPh6PhZg2Ja1dzPQNiWAIvlYJcyl1cTch/0v
         25S3mDAGcJZ3otwywQDssYLnxFQRwCwxuWyyCvNq8b625tDBO+A9X/aWfx+vxXpE7u6r
         u3xmQuntV4qkUjJXnW6rCQgqmN745W9704bskr9MmqYxEBOZ9OKLn3HBkhTRYPzoLl1V
         /SUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671942; x=1758276742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWZ0kuFk/JGga2KckHsx8bbCMGd9rBXEdZWbqFyn8fw=;
        b=XsxuHHXSm9u173IXgQlRRO24OyS5AJiHBEQAnHt/GMFw/CFEPHsCAEw7Shr37ZSj/j
         O1dFT3RuntnTIORaDSupsdpFY95YgLYOw8MdvceD1H9D4ux2X2sa3D2vd97FYt+m1hM/
         +ZqRWN7GJQ9kgZcVF43G9Fh76PVQcb7WegKa9fhwvb7RwScc0RBdmGONF7GGNMMARD51
         K4IlJHPajTjldY8GYkTQj0G9btJ1/QdAJVnUBxntjPbBYjZ+24/JJsg34wJ1ixGnClu1
         x3WQFMdKV2PdRAOMMq/I2ruOg7HDotksNaiz82ixUEsjUtEOfsmRUGQYvhe0w0btwbpQ
         BgSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQDca+7hh+4EVS/YP7QUxcD17eKpeeGlosxCs4JK0PP1zfQuKK4xzOVkBwlNEVdZdPJCyZvnQf9t9DwzNbkG18@vger.kernel.org
X-Gm-Message-State: AOJu0YyTYofdyH4rx995GzcGQToQ1F1UWKyCqVXnykCyqVLRmafC3G8h
	hcI7pV/pN3KgEMcCaRsyWOytbTOs2RdneBpEtwJlBbIfZ+zdBeJJTTaB
X-Gm-Gg: ASbGnct5mjgu8SngY9VWCsIj106pE7eOJDwLhZwxkiLlBOjdYMI53zY7etCJgM4mI1F
	jQPF/4iiQFRBsgz/sx2JTCRQSuxve37sfKaKArMEOQwjHoYS2TCs71B+peP30hdh9wCow0CYBHq
	Ad+SMKyTyCWRT64Vmn3NiOXB/cm6m1L0Annm3GF3P2SVQpfAH9DRdzrghbdD4B8cIVYaqo8Cj8f
	a5ectr9a/JWRQWAykt1rza7RYDPLSK4IYA1QWiqTSQWUo5Q8UbeI8r/PWeGkypWAjgsyMQzFJ+N
	+iCqtrPjRBc5f6XQ9Xq5ZRqHGIavVueQwps9GQ0zTftwFun7JSIEpGlflTXNbz5ETsBcst3xxV6
	18sq0tMm946MBQSGxaOq3pyHkZAfMJvxjmpFTE5P22tB17KUx1w==
X-Google-Smtp-Source: AGHT+IE8+93TdDPnsE4atda/JWPbNWLLDtzQ/rRojiuKNJS4zwHA9ycGi7y7HjIuRi4Y0KG1ZDhRqQ==
X-Received: by 2002:a05:6a00:812:b0:772:5899:eae8 with SMTP id d2e1a72fcca58-77612189a24mr2770987b3a.27.1757671941982;
        Fri, 12 Sep 2025 03:12:21 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a46eedsm4969144b3a.30.2025.09.12.03.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:12:21 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
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
Subject: [PATCH v4 05/21] mm/ksw: add ksw_config struct and parser
Date: Fri, 12 Sep 2025 18:11:15 +0800
Message-ID: <20250912101145.465708-6-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912101145.465708-1-wangjinchao600@gmail.com>
References: <20250912101145.465708-1-wangjinchao600@gmail.com>
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

