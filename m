Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0295A2E9EDA
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671964; cv=none; b=sVaBllFxbT61cWI1DLxO4UJTqH2W01w2jsiTle9DZzAxZYp9rR/dSU5lRBhM1boXmkrq9ipgRiV4Nehqx5suKbK2gQYEq1PoE3sPhX+jWX+ZdFbHckqEV1cORmy6/+cuFUiA+C6q1G+HZxZnJL8UOau5hAixlvmf6GdS+KYoENE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671964; c=relaxed/simple;
	bh=Un+cr8+CAx8R+jlvlSG9Ydlf8KMHwbHKNBBW5RhycS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMj8V3x/K8sNbzR+pYdH9jAchaN83JkuB5hZZa2KhLlj+2hta7E6pDmT2Hm0Woc0RdOl7II9u6XQ3nsk1we0VceoWoIrBHYr/Vxfd0nGhRruFxXsx6riNu0D6RlgkIBoGmLMezarWMqSmAg2hC2Nf7TsMl2WurvbbNpcX7bzTmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4uZmrmV; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4uZmrmV"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b54b3cafdcaso113599a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 03:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671961; x=1758276761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTRhetdXz/AlDveQ7cC4oIBX48CBF691SylMydPRcTY=;
        b=A4uZmrmVDOMz3gjZm/FgGvhM7+l9CdJvU+O1OUKMIrxovJmb8hl+KCi9/5Q9KmN++z
         dEEd0GGEc4flgqSmMDhj2WdWoAQgE8V+VNsY+8D7RWpIx0YfB3AIz+entQTvIjgAzuqb
         2MDsHsLagwDLvUPEFjpbTmhkksKJLfidSt9Nfviv7Cjp2gfYCg73NnGXZzQLAtZDCUTK
         bwK4tMZfo4GWQprrIxUSjFdnjPcCpa1KUP8dkvrzK9+rlK2Fmc4VnSF6HaVPa4wQUuil
         PJNG3dWTxCwDCDVdKB9MoMXhpPBivv+Yyrfb03GStmbjeGgvNQtdsinEUvxE4dNRaItv
         2T1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671961; x=1758276761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTRhetdXz/AlDveQ7cC4oIBX48CBF691SylMydPRcTY=;
        b=QZrXGm+LeiIdxPHal54/yKoCQGlFDUSqi88makM7I7BEXUXZtGl4WvqWSwExUuLpUD
         8ktSFx6oGpPXri9AOS4RSp1n4xTzFXgJr8NnrQniOLJt+mLadPR1R6QGpDDBlHJ1fLr6
         qV9N3Oq0ZmPmpVC8nm9Kuh+CER1FJCBTBaWrSnJUdvdeLGDkHKQ+4NndKZwsg+nueulv
         xqEeUL/cbJGbm69QPuGydCqR4gTHeDbJ6EVUhGKm6rf0g9F3vMqmiF71C5Ks+E96J2c6
         daY4KJwYbCXF28UCBj990f/2Jr4PxdPmS6GZzwFBB9gf6HpsdgEB1BqmAWd2xHLpPHbP
         7uzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI7oTts61+lDo68KIJBJwmR+oDLOdjcwVGpcVcURsNl4348M/cs/i+dvDX1A1yS9gmtNaRyaWN6QgfQPLyfDi1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Pjdlz6VXjd1QE62nRedNVVXWBIstjCAz+2ZcNIPK7REN03ME
	DNUXZol3/lIJTNzTX5LuQvj8bvhIMg0LQJP7gpqU4EG3Kg3LtUWaySXX
X-Gm-Gg: ASbGncugo9zva+SXJzIkaqSii3f/b4vXiQdv1LGPrApkfkdBSNC3NL+sKf+QczFtxYV
	NL06IXgVnNschheeeqhA/cTfA3CiFDTSsTPj0cJNEQBlYohj5n8qj/fZw8OaT14A11OQHqq79f5
	B1PVKTOQtYU2cUswVRRTp2jX+09oUNMI6zw8AUt8aZEUqSLM0QcKaprXlu7ObsFjArqLcUGc6X4
	WKOrgmpfxgXHCWehZNOrCUeDtck3GBq3TcZTUV92jAjRL0js3fcmj5ZvyFgk4k25LuOaP4hmYvF
	F1E+Z8SnGzt77Q2YS/vX881yoQz/0/VWhPgvYCm4rEj+OuwqLRaOMAYOAMOBxJ5+by1gNgn+V7h
	Tf0fWxp9ue05nDTWTtFR2xtRwsfIvhEUDc89Q6ws2Z2DYPYmYyA==
X-Google-Smtp-Source: AGHT+IGqTkU62M75KR/OKOWzeX1g5EGPCOAXf7ry0VUZE+EZFf5kPwKsv6/nCCnQmnFIPNz9rUR8cw==
X-Received: by 2002:a17:903:3884:b0:24c:d0b3:3b20 with SMTP id d9443c01a7336-25d2675c1fdmr26411195ad.37.1757671960988;
        Fri, 12 Sep 2025 03:12:40 -0700 (PDT)
Received: from localhost ([185.49.34.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a398cfbasm4325375a12.39.2025.09.12.03.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:12:40 -0700 (PDT)
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
Subject: [PATCH v4 09/21] mm/ksw: support CPU hotplug
Date: Fri, 12 Sep 2025 18:11:19 +0800
Message-ID: <20250912101145.465708-10-wangjinchao600@gmail.com>
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

Register CPU online/offline callbacks via cpuhp_setup_state_nocalls()
so stack watches are installed/removed dynamically as CPUs come online
or go offline.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/watch.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
index 14549e02faf1..795e779792da 100644
--- a/mm/kstackwatch/watch.c
+++ b/mm/kstackwatch/watch.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/cpuhotplug.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/irqflags.h>
 #include <linux/perf_event.h>
@@ -61,6 +62,32 @@ static void ksw_watch_on_local_cpu(void *data)
 	}
 }
 
+static int ksw_cpu_online(unsigned int cpu)
+{
+	struct perf_event *bp;
+
+	bp = perf_event_create_kernel_counter(&watch_attr, cpu, NULL,
+					      ksw_watch_handler, NULL);
+	if (IS_ERR(bp)) {
+		pr_err("Failed to create watch on CPU %d: %ld\n", cpu,
+		       PTR_ERR(bp));
+		return PTR_ERR(bp);
+	}
+
+	per_cpu(*watch_events, cpu) = bp;
+	per_cpu(watch_csd, cpu) = CSD_INIT(ksw_watch_on_local_cpu, NULL);
+	return 0;
+}
+
+static int ksw_cpu_offline(unsigned int cpu)
+{
+	struct perf_event *bp = per_cpu(*watch_events, cpu);
+
+	if (bp)
+		unregister_hw_breakpoint(bp);
+	return 0;
+}
+
 static void __ksw_watch_target(ulong addr, u16 len)
 {
 	int cpu;
@@ -117,6 +144,15 @@ int ksw_watch_init(void)
 		return ret;
 	}
 
+	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					"kstackwatch:online", ksw_cpu_online,
+					ksw_cpu_offline);
+	if (ret < 0) {
+		unregister_wide_hw_breakpoint(watch_events);
+		pr_err("Failed to register CPU hotplug notifier\n");
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.43.0

