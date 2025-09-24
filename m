Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33643009C1
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714737; cv=none; b=Yx3I1cglnfeTcQ/BH65EDuzmcEW/5yboWePSJD3DaH5z1Rd/0kIYuIcQp7NxN0C+7hmzVxg2Swn/DKJEpkpB+U2myhzuho5ZwZoH6YyM6FQ+kWJfUJr5pJTTNnKFh5o6n2wfAR91MHrL9QDDIwlAhyL+ZIWBOHXe96CG2ky2M/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714737; c=relaxed/simple;
	bh=wmwmRtcPH4ST6Dm0G2/AFHsMnlz3q9k9yRWhyo1wI/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9CauSUZ7Cvgue5K+Db9AgNdxalHafrIgoxSN9l+cLigkbGDgzzDPjSwCBkQTTJPr7tBOdkVhqvvjEpuKrb5C5mtdQ1rrIbzTlnPueLTYzIyZP4+N6R5VdM0lR06juzXQWkS1TltwZ7KMVwR51A78JQvnJIHbhnQocU415HXPdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXCQ7oji; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXCQ7oji"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b55115148b4so4428987a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 04:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758714735; x=1759319535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4BKEfc9ax2ksTKKBAwbjubQHvBiDjA54WMJGQTptLg=;
        b=AXCQ7ojisXReGNvopgPMp8A0RZsJPR7y39gkdB+j20C1Kr39caCOI3U/8aJK0DzUBu
         FSvj5BAqshUcX8sqk5Z+XaCM83/KoVGvmTbVAGZqkbjAgnKvqcFr9Th+rz6QlMKMwNLz
         9ZpVxdrcYdND8pT5D2Ehx5k3nyDS+TMb6BaRPIwh41BsYcQlX4SgmzQ1MspkpBVSe/vE
         z3VsfdNHc+lT4vlYipGxa60SbjmCyRxdSk43cJCCD0t8Xh4qCpV2+SJUHBG7E4gWVKyn
         L3L6eXwieXXVo0BxL818lzuVABikbGk8NrAOi/97+qIeG2ld6Mrd2SRESAay+RCoQRjU
         imKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714735; x=1759319535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4BKEfc9ax2ksTKKBAwbjubQHvBiDjA54WMJGQTptLg=;
        b=CFVW3FYYxKx3ZZNOdM4syD3nuQU9Xu89oUM8v6UWBnv/UJ/eNlXvBkTxx1wphnu08h
         m5Zb1NX2NTCzJgivHnc561D/Bi3dTh3hCGJ++s6t1FwYUeh2NgA8w1vsKbRIxrLgi4FG
         UXen/MV6yi6c3jNiHMKqAP0SUAScADpHqKSeQJWPPJs36SCNEe3PkV+TQPF26kXHhpSc
         d/N/U9f4k018+XhGdp+T8giJ12gF1fNi7cB9yVcsS7Fdh5eUlYbFW0CIZLMyNmfk0Kom
         ttkW0ziA28x/XYfQAmHPSa9h2b0QHNdthXxTGK4Qtjro1C0O2ABdtlux9gK3E0ZAyxQv
         kFVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLzE4/dVdSI8HWV3b1WXkJeG3Cnw43wYur+UY5TpR4yl/Cl40avPR0V29ngLjOrkeSi6DgfLMYlnLReNtNnfNx@vger.kernel.org
X-Gm-Message-State: AOJu0YyZJOSvlyKB4sVQ6Ta+QivbrcxilC5mjjj/beeOtjfAvc0sTBw7
	R+Ly4JN22WJeSu48qXM23PlCCoQfIPYHlmM0IJL2rpH7CaYgYSMKEHd4
X-Gm-Gg: ASbGncsjUT8nLnpFUEp7IJnGGjMe7uwAuLMroDS/VRnO2lUo5MeII/fgnrMMgeiF49a
	tKUFUk2Y4FuaVB+mADPb6LJjAt6+rL6ZBTJwNVYXGH8KXyGqnBCp1JJpEZCMHC4yAmCWaNxreCH
	4afTp1FXQAZ9Y7S/spfRD8ME6wwuFKvaJDidPvsTs8FbCtUmL1o0ZpNGSVfhP38hCd8U6WLxiBR
	w/6UzIs+7J1aRj5d/hHAmZiPzP7KPjNK/rxkzHTgXn9w/3acRAP/J+ZRzBLkjwolAQ+WUiPqStc
	InFFfTPwUFLDabdGPCedEbGTNjBxGsmi37fHnBc7i4DWuSOsJKIFJKcCwTmKN0li6ni+7kZUeZG
	gTX2NYkbk0PUaWnUkkZT6deczTA==
X-Google-Smtp-Source: AGHT+IEIPde70G75F7g+aLuFunwEIX4ciWCOE5JEZlKnHsvKJ7fdAzkwZXDsNRxc7SsbnaPx5zSyIw==
X-Received: by 2002:a17:903:8ce:b0:266:2e6b:f592 with SMTP id d9443c01a7336-27cc325ea9emr75331615ad.25.1758714734961;
        Wed, 24 Sep 2025 04:52:14 -0700 (PDT)
Received: from localhost ([23.142.224.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27cc8b251f7sm49110575ad.8.2025.09.24.04.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:52:14 -0700 (PDT)
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
Subject: [PATCH v5 11/23] sched: add per-task context
Date: Wed, 24 Sep 2025 19:50:54 +0800
Message-ID: <20250924115124.194940-12-wangjinchao600@gmail.com>
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

Introduce struct ksw_ctx to enable lockless per-task state
tracking. This is required because KStackWatch operates in NMI context
(via kprobe handler) where traditional locking is unsafe.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 include/linux/kstackwatch_types.h | 14 ++++++++++++++
 include/linux/sched.h             |  5 +++++
 2 files changed, 19 insertions(+)
 create mode 100644 include/linux/kstackwatch_types.h

diff --git a/include/linux/kstackwatch_types.h b/include/linux/kstackwatch_types.h
new file mode 100644
index 000000000000..2b515c06a918
--- /dev/null
+++ b/include/linux/kstackwatch_types.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_KSTACK_WATCH_TYPES_H
+#define _LINUX_KSTACK_WATCH_TYPES_H
+#include <linux/types.h>
+
+struct ksw_watchpoint;
+struct ksw_ctx {
+	struct ksw_watchpoint *wp;
+	ulong sp;
+	u16 depth;
+	u16 generation;
+};
+
+#endif /* _LINUX_KSTACK_WATCH_TYPES_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f8188b833350..6935ee51f855 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -22,6 +22,7 @@
 #include <linux/sem_types.h>
 #include <linux/shm.h>
 #include <linux/kmsan_types.h>
+#include <linux/kstackwatch_types.h>
 #include <linux/mutex_types.h>
 #include <linux/plist_types.h>
 #include <linux/hrtimer_types.h>
@@ -1481,6 +1482,10 @@ struct task_struct {
 	struct kmsan_ctx		kmsan_ctx;
 #endif
 
+#if IS_ENABLED(CONFIG_KSTACK_WATCH)
+	struct ksw_ctx		ksw_ctx;
+#endif
+
 #if IS_ENABLED(CONFIG_KUNIT)
 	struct kunit			*kunit_test;
 #endif
-- 
2.43.0

