Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6651E2614;
	Thu,  4 Sep 2025 00:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945410; cv=none; b=jMI1dhUHAFRJ8vgWEgUDgGI/HXO3yJa1i8JdM0iM+s7cn1eWjeaKyDb31k88TaQTIAZEZmxDuYQVH0zgY0zC3ogmmPCeU8BokPZ6dFmtHH+ZjbOfksTRd5IfrwV06/IbckER8XI8aDLP/jZy+0G8XY0DZBy85f1PmJ5M8XI1fZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945410; c=relaxed/simple;
	bh=IGZGRl7SPv8QYEkfF81MfJQSk3f6SOpoIfAg9jVan/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmZZWzMLYJd+4gyKI7wKJXEsLaoc2vMM6NXypMJKwiZ1HZAFlT/D6+k/SsRiO/nzlHmMJU1pXUIeXHUAMH2fnH7NzeqK95elgxz1JENHE5bqxDJVdvwTLXH3r+aTwzeN2IQi1qPiDKYHQkhZKcx8g5KRVkQrekmFWWs2yRG8vGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVgZJlqA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVgZJlqA"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so408335b3a.2;
        Wed, 03 Sep 2025 17:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756945408; x=1757550208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7709ieFUlS+2MrC1zNfTfKDbThJkcQv3sQ/PEEU3R8=;
        b=IVgZJlqAKY5X+VEgxEIMICMjvAxkG10uzdijXFUPdCGT/JQQF5OxYyOXbqGGBAgYyi
         4ICdEe0+QGksRpsLXqvxooeDPZAFBoJtoDx8bkeovx8/UsttDQiRncNGAhiPCnNJAMVt
         Kdy/7R29yYWhFA2DYsMvYOvqIfg+zhT8yJsGtOGS8PRXInv+i5TDRyQHuw8/SifCFK+W
         MclI2bL01D4MeCO27QikT1DAuhMU3sfkp+hM9vA0w5lgt6ZvSMoea+Wisqn/z0zLoLvV
         G77JqYQ0K2I29XkMbhdnO2ZyW6197Lpf0Nb0eGKRB1/aLlWWIe5JkTPfN8MUqr0/5gFX
         DSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945408; x=1757550208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7709ieFUlS+2MrC1zNfTfKDbThJkcQv3sQ/PEEU3R8=;
        b=qY0jbsy7xXVnKKng2T8beVFiPmQXecrC/B+NaNmhFFSXW3JPLway0SDYttKlZynP2W
         ZfJtZfaK9hJ95HZ5DEE8dDgqulsQ2vpH7LbMvFrhAlCNmMqSTgK5ZRNIro8Ajs/OkxP3
         VD1Rsy8UkFrfZnddxtvTeE7oDMOr0WVpoTla60dMPPYwWvP2nnF3K4DTwvDnPTr12tUf
         uDd+b1ARj6CigZCtK0V+9k40MO74xq4rQaOr/UsJ6sq6rTy6UptMKz9ZtKHuWWQ0tbdp
         LKsLwe4V8PHFBHKGy9YlrRguukKkGax9U3tlAAZlAtDns8lIJGHZ1TssFT2a55cM1fuq
         yO6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpYyqOro/axT0oY3ei61JUx9pkAPVfimW7tqSyn1urBEK8iNCZT+ktJKxiD33966mgrIh2Vdofo0dHey57Yf/Y3kwc@vger.kernel.org, AJvYcCVU+Sd/VZVh/eE+CNcW4cfgJ0qb4G96AQkeH0oJtZUPOTCAFGM0UaKQNxwEUDfNf6lschEd/RAOclQn8KbdVl6z@vger.kernel.org
X-Gm-Message-State: AOJu0YwJGwQlhflyZHD+fT7W3lur92+ETUWdTNm8/XY8rS9qs8Tb4XQ7
	YeymTcPVOOn6HUzgI2cmoVd6wn97Zj2CuSLibRjZhoz/n/0LGrf2bypm
X-Gm-Gg: ASbGncvXjfCeJ68LWCsRNZ+c1sW2+xh17YqWFgPxNmnJZ0biWSfx4IebUfiGWCt2txs
	S91/DMjOT6Jld4oOyebq9Lbmh8t1UKCXUiuseuizdwQrvfVMQNrPjN/NPSpM5YPS0Dr6SY/hNt1
	yScdzZAWYWiDwlbYtdRIdKMfXCWSwT9qVIwGPs7M/uPkB7c3crTng+gfSYGsxKzLGv47VS+V1/0
	CIFWj9NfAfpB18n7AXPL1W3G00CZzbkuLdKXKl/nVakJkrtaR9mZeZicwM1SdR1tBNaltvGrwMy
	NOWRy4VYs6bPFowvmq6vKi0G7DsgzsXWvw1xvVKOnhZvUb5cXHmwemM94ca9jHGAziTEPl3vfGo
	OXA4x+S3HXte4BPY8fkkNHenYGlIQJ/CyNKZXvV4xTBnuVhMfHclQ
X-Google-Smtp-Source: AGHT+IHhppPhCunvFzVZDYZ67D6HMJaD+bYACrgmc8Txd1zbRbMjBjJcCjKS/dJR/OMmvBRDlXJzhw==
X-Received: by 2002:a05:6a21:6daa:b0:243:d5ab:d1fc with SMTP id adf61e73a8af0-243d6dd7a45mr24329846637.7.1756945407888;
        Wed, 03 Sep 2025 17:23:27 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bd2aesm17579551b3a.48.2025.09.03.17.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:23:27 -0700 (PDT)
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
Subject: [PATCH v2 11/18] mm/ksw: coordinate watch and stack for full functionality
Date: Thu,  4 Sep 2025 08:21:08 +0800
Message-ID: <20250904002126.1514566-12-wangjinchao600@gmail.com>
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

This patch connects the watch and stack so that all components function
together.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kernel.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
index 95ade95abde1..4c5fbcaddab0 100644
--- a/mm/kstackwatch/kernel.c
+++ b/mm/kstackwatch/kernel.c
@@ -1,10 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/kern_levels.h>
+#include <linux/kernel.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
+#include <linux/utsname.h>
 
 #include "kstackwatch.h"
 
@@ -22,6 +25,29 @@ MODULE_PARM_DESC(panic_on_catch,
 
 static int ksw_start_watching(void)
 {
+	int ret;
+
+	if (strlen(ksw_config->function) == 0) {
+		pr_err("KSW: no target function specified\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Watch init will preallocate the HWBP,
+	 * so it must happen before stack init
+	 */
+	ret = ksw_watch_init(ksw_config);
+	if (ret) {
+		pr_err("KSW: ksw_watch_init ret: %d\n", ret);
+		return ret;
+	}
+
+	ret = ksw_stack_init(ksw_config);
+	if (ret) {
+		pr_err("KSW: ksw_stack_init_fprobe ret: %d\n", ret);
+		ksw_watch_exit();
+		return ret;
+	}
 	watching_active = true;
 
 	pr_info("KSW: start watching %s\n", ksw_config->config_str);
@@ -30,6 +56,8 @@ static int ksw_start_watching(void)
 
 static void ksw_stop_watching(void)
 {
+	ksw_stack_exit();
+	ksw_watch_exit();
 	watching_active = false;
 
 	pr_info("KSW: stop watching %s\n", ksw_config->config_str);
-- 
2.43.0

