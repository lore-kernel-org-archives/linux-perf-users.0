Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B71D31B838
	for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792675; cv=none; b=SyGLOpXtVSHNk6eVUe8Fz47jW/30T6hO0PuXSHz4wxLwxNLGa6i0diJnyZQgYqT2cXGuslmmKtRYh2fyH7P6Zqd9y0VHsaq9RaDMYUxB2sQsZSGAIGa603lyjh0w+/QlQPCu1peXkFUwM/lcIPL2Y4jekY0osgE9zmdc5+qu0zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792675; c=relaxed/simple;
	bh=wQ1McUxBvOQybWZtkihRRIOMW2MyuqP74EGicbjl+yY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t/ybs9snnIJN3kVh1XbR4nPeXsjK9JiQC4mfAgwz9XMEE4ezzg9RAcmC/AQfg0wi/BCRHldU5gGGej2elHKP9JlPuNEdcLU3V/yuQmmImTBW+H4lE8rajVq8Hu/HYEpH6dLxpTOFaO5Gabxyow00N0ChRYghr3fOhgH9GJqf7r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akYXr6hT; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akYXr6hT"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3434700be69so4345181a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 08:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762792673; x=1763397473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z475VFvVTEIt4JwZ3YGODDVB/J4Mi7oiMRjRIDfUacs=;
        b=akYXr6hTTmKYO6bD/KyxeV16JXOYZWQ8DwCYDA0t0jVp3SHPE27q3tvfZErkdMW+lP
         2RSaYGsAM7BXt3NSMeS5cAQRjuQpwMA1lYXTG8f3TGbIxwGNhq9vEREUVVFEbCM5/x2m
         jE+91qFsxS+7OvZ2hTW0lIbLdO1VAcYE0ZVtpQTqaHlTLykJpl/uu5XWg/0LVEeSXk2+
         X7l3snS2OX6ralC067tjX44SbtnYJ77M2S5ykFuDV4JPGuxZ7YXw+WH+AbMxw6YSuoN0
         O5NWHDIWyPS2lY5FBZ+Wy1RAEhJBG69v0RXKnAHaaSLBwzfwkMXLuJFtazFI5aE/WXfR
         wuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792673; x=1763397473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z475VFvVTEIt4JwZ3YGODDVB/J4Mi7oiMRjRIDfUacs=;
        b=EjhBY9EZORnZ7QkRoL7ZhuPa3GRSYv6o4mt4dAX5WiTRGu38LoX2iWSj0lW6MVNk1O
         EpqT3602LQx55Lqk7Yv3/apqT3dL8IH/XkZ6CivhPxImXSkpjvB4IrZ9QUINnoj3keKI
         fB/4opK2JL7p53GP+EYYyTEoR1xaoGh9SCQsmKXN9ZnXSX0oJS2VET090eOnOe6o6Rzl
         3hML4iDUtl6IeZYizxfDrq/+EvWDbffLESvSCSpSTWBRb/DHshNx4vcJfk7MBDGHg9H5
         +/WSxNK9g6d+AXVoqYVf2afaE7rUtjEjW8vsfWz0jUbRt8YnjwxXdxmN9dsWk19N8ORc
         MdPg==
X-Forwarded-Encrypted: i=1; AJvYcCVkpgNuWpcK2f17JgJDqLf0dPk4YMcF9PUAp0GmzT8Tg1s84PhtF74U3sc79DP7B5R6E31z0uTVuXgoRkoiS/OT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9eI/IrUYlbP4+HmZvRTQyRQdF0OgBXJWx+vE1lp6CAHgXtPye
	ALxnjXHX9BTvhsVB3sljnzmLVO6Mn2kjjcfjJdj8Wv/PVPMQMSW8T6+0
X-Gm-Gg: ASbGnctVxpsck2UowhJUc0kEIVkjIxCC7zWThCFeujVxdpM7CwcJAayZF8gZEBpTCNp
	HSUXmQPvZ0YJSJtIDmE1UNmon8uYOzPm4oPscZAuqOZwcJXOi137nP1YuEOaEOasu7Y3qMPryNj
	RacI8kh/2P0Tf0kNTmgxdBqR0AHDGcOigC8+NKy1m4ofeF7Ye+n/ggk6c6wUQ0kjgEmw0fSUCIZ
	TNtxuJFHX8GWQYg9ouJCdSRk8NgpMJtn3WMBro+f4C7YyebsMi3wxE9tCst8x2Xjp+YDMnT/tVW
	egiVMUSKFxI+ruhv7/S6+u6j3FmTvqSjEzpI7OV7ep2CJC40eVrpbe9ZKcgEEbEYpzuDrV5AXIb
	a58cazpONjZAAdK7VzAwJwGqDFuhuRobo/mP4yVPhgQuDXF3QIwQtiPCjzRJK0KFHEGZy9dpmxj
	IdnzoxRiLX0QI=
X-Google-Smtp-Source: AGHT+IFMkp6mzspl/QeVRsUZzdmIZ1SaB55q2G1mEh95QyGe2qx8u+PVoYkCuCMgJ33eu6H6IlXxoQ==
X-Received: by 2002:a17:90b:2d0d:b0:341:d326:7354 with SMTP id 98e67ed59e1d1-3436cbda0e8mr11097915a91.37.1762792672604;
        Mon, 10 Nov 2025 08:37:52 -0800 (PST)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68ad143sm18023453a91.3.2025.11.10.08.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:37:51 -0800 (PST)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ben Segall <bsegall@google.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	David Kaplan <david.kaplan@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Justin Stitt <justinstitt@google.com>,
	kasan-dev@googlegroups.com,
	Kees Cook <kees@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Liang Kan" <kan.liang@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Rong Xu <xur@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	workflows@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v8 16/27] mm/ksw: manage probe and HWBP lifecycle via procfs
Date: Tue, 11 Nov 2025 00:36:11 +0800
Message-ID: <20251110163634.3686676-17-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110163634.3686676-1-wangjinchao600@gmail.com>
References: <20251110163634.3686676-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow dynamic enabling/disabling of KStackWatch through user input of proc.
With this patch, the entire system becomes functional.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kernel.c | 60 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index 87fef139f494..a0e676e60692 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -14,6 +14,43 @@ static struct ksw_config *ksw_config;
 static struct dentry *dbgfs_config;
 static struct dentry *dbgfs_dir;
 
+static bool watching_active;
+
+static int ksw_start_watching(void)
+{
+	int ret;
+
+	/*
+	 * Watch init will preallocate the HWBP,
+	 * so it must happen before stack init
+	 */
+	ret = ksw_watch_init();
+	if (ret) {
+		pr_err("ksw_watch_init ret: %d\n", ret);
+		return ret;
+	}
+
+	ret = ksw_stack_init();
+	if (ret) {
+		pr_err("ksw_stack_init ret: %d\n", ret);
+		ksw_watch_exit();
+		return ret;
+	}
+	watching_active = true;
+
+	pr_info("start watching: %s\n", ksw_config->user_input);
+	return 0;
+}
+
+static void ksw_stop_watching(void)
+{
+	ksw_stack_exit();
+	ksw_watch_exit();
+	watching_active = false;
+
+	pr_info("stop watching: %s\n", ksw_config->user_input);
+}
+
 struct param_map {
 	const char *name;       /* long name */
 	const char *short_name; /* short name (2 letters) */
@@ -119,8 +156,18 @@ static int ksw_parse_config(char *buf, struct ksw_config *config)
 static ssize_t ksw_dbgfs_read(struct file *file, char __user *buf, size_t count,
 			      loff_t *ppos)
 {
-	return simple_read_from_buffer(buf, count, ppos, ksw_config->user_input,
-		ksw_config->user_input ? strlen(ksw_config->user_input) : 0);
+	const char *out;
+	size_t len;
+
+	if (watching_active && ksw_config->user_input) {
+		out = ksw_config->user_input;
+		len = strlen(out);
+	} else {
+		out = "not watching\n";
+		len = strlen(out);
+	}
+
+	return simple_read_from_buffer(buf, count, ppos, out, len);
 }
 
 static ssize_t ksw_dbgfs_write(struct file *file, const char __user *buffer,
@@ -135,6 +182,9 @@ static ssize_t ksw_dbgfs_write(struct file *file, const char __user *buffer,
 	if (copy_from_user(input, buffer, count))
 		return -EFAULT;
 
+	if (watching_active)
+		ksw_stop_watching();
+
 	input[count] = '\0';
 	strim(input);
 
@@ -149,6 +199,12 @@ static ssize_t ksw_dbgfs_write(struct file *file, const char __user *buffer,
 		return ret;
 	}
 
+	ret = ksw_start_watching();
+	if (ret) {
+		pr_err("Failed to start watching with %d\n", ret);
+		return ret;
+	}
+
 	return count;
 }
 
-- 
2.43.0

