Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0F73064BC
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714749; cv=none; b=GYBmovMrswko0DMmtiT1y5zczy3WYLSFGLO/xusGPGihnmBgq23FxveccqC4Iht7NqlSOEL5S2tJ7CDDnpJ6UGWKVTD5Y57FX6kxEIB0I6DjI03HAf4PG5aidCf7OhKCi7lZis+569csSEnX4j+lmGCWq0srjpnQodqzFPYxnB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714749; c=relaxed/simple;
	bh=Sl2YI7Td/C9YkkJpnWkOlkyn4hvpDBvdNr6f7stAoSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYDTfVwipNbQ1mDcsgRg89cVig/kupnkX5xRphfhvseI9/+8QD10WcW9qoyfKK6lurFcV6g+gJILrfmMAq4QvgAnVeNf4Dj1+J8/Yy7/77Sm03R65hST1Kjx3s07JAr3mM/eK9uT1EGLdWQlJ38wjFKdBsNtdpMOFXNLKxBBBEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mj6Q95gj; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mj6Q95gj"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77f2e621ef8so3897275b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 04:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758714743; x=1759319543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sX4DcHmKN6k6jLli4BcDyPNAsEAGb3ORwL+dRbW7euA=;
        b=Mj6Q95gjxAqB/UIvJL2Fz+IYzT43o6YMhcDCVCSbrht7yJjT68f5u3uCByk4A6vFTE
         T2Ko4MZZsVu2RPY367DjLf4llHmY8+W1mvOQdf0d1d3hraa6sbKIS2a4nHdsPxU53pVn
         9R/y3vVIjzAErY2K2ZsUJPnYkPvX0n1bvvBsCuiCVlUANIPmLDupyIjFrnQIeuQxMJIU
         +u1iiO0v6jyZT1gXrsbiU+8mz/oqndHSfhn3BjEMT4YJhBVhem21HdrLIVtJY2cSl3zi
         oTVapqQpwViatAsyYNX0Z0cKLvbu7fBI/R42wcsn+hIWLn0TP0BjraxLqjIRTOucLfdf
         U3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714743; x=1759319543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sX4DcHmKN6k6jLli4BcDyPNAsEAGb3ORwL+dRbW7euA=;
        b=xKfBM+f2Chw9aav0Q/sW7UeukO7uQU4WDxTiHOb4CT/IGnLDBsJAB94iQe9ihY9Mss
         QuJGM80YRL6x/sHqcGM39kYxHU9xqmjsrasMUiXavz6DjJGCj3ra5atX45OgFndbd8Nl
         KSm7+CNtpmiXhrDZN1uGCo+rsLiItPSpInaGmS+EaNXkijzuh2knaqu6c11S4KgyUSCV
         4zq/XTmO6n5Cp8YXtD7KdLKWkERR27MesxoeyVESdJL+siWAfKMjRkoJ1uQ6XpxOo8t5
         PBtGdLzh+1HI3MN/rwj3JGGWfKSWdUI6IjgoVan9gnKdxYHX+NsvxwBiByjxnKTTPcal
         Eg7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHxc4TQYNzmaO1WPd81aof+CjUuGwBUDN/I8Wg/10IRDa2Erq7vMVC5dJ0hBlvL3+nf0Rnns8C8h6g44xmDKJw@vger.kernel.org
X-Gm-Message-State: AOJu0YzWP5z90FR2p6yO4ieVqoMKYb+LgyHKQO2tMzQUZrPWPTEhW/gZ
	MoEt+dGwb4XYP4L+DZoLC36MZoLn8l1f/mc2tOnTRNoj7tV20zWZ6UCg
X-Gm-Gg: ASbGncverix75Sj+vjgk2hNsOBugePc4Lkeg4dQ6Y/iiu38+NNgGhoogOnOhgoHXNAW
	xuabL/p83YGOtU1E/g9wjJTNGH7bEeCPlQFMqnja8qRbEj08KNrEW7SyeLJ8Mkvva7IztmTxbjV
	ib52kjgHKJyyzCS8qbVaeIAfjXozb61m906gWrR98JzWoHMtKKXSV+cHPYE8w5ame08EzG5HWZ3
	pa2PALqHUv9aOrMcEper7bo7l8a6Wzd2+jVQl++bSdloS71H+lh3DFV/MPHAs4V546rKO2pE5/z
	oElRLxpeyCxXDx7RZ2kQt5Xak67honQE9eFjmWjtdEQKZrej1RVxYqJAub9X0lVJ+ph8ktvdLAd
	ynTAdz7NcSV7mIK4ImJWy4mK/xQ==
X-Google-Smtp-Source: AGHT+IHM4OGfhR5oYYdpAC3Dd6EW1w7h66PDSvRIMWNc5YTjulef4dYL+e/NY4vhVJcodihdgSSIbA==
X-Received: by 2002:a05:6a20:e292:b0:247:65a0:822 with SMTP id adf61e73a8af0-2cff1c61c0amr8760157637.40.1758714742579;
        Wed, 24 Sep 2025 04:52:22 -0700 (PDT)
Received: from localhost ([23.142.224.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b551518480asm14947563a12.28.2025.09.24.04.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:52:21 -0700 (PDT)
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
Subject: [PATCH v5 13/23] mm/ksw: add per-task ctx tracking
Date: Wed, 24 Sep 2025 19:50:56 +0800
Message-ID: <20250924115124.194940-14-wangjinchao600@gmail.com>
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

Each task tracks its depth, stack pointer, and generation. A watchpoint is
enabled only when the configured depth is reached, and disabled on function
exit.

The context is reset when probes are disabled, generation changes, or exit
depth becomes inconsistent.

Duplicate arming on the same frame is skipped.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/stack.c | 67 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
index 9f59f41d954c..e596ef97222d 100644
--- a/mm/kstackwatch/stack.c
+++ b/mm/kstackwatch/stack.c
@@ -12,6 +12,53 @@
 static struct kprobe entry_probe;
 static struct fprobe exit_probe;
 
+static bool probe_enable;
+static u16 probe_generation;
+
+static void ksw_reset_ctx(void)
+{
+	struct ksw_ctx *ctx = &current->ksw_ctx;
+
+	if (ctx->wp)
+		ksw_watch_off(ctx->wp);
+
+	ctx->wp = NULL;
+	ctx->sp = 0;
+	ctx->depth = 0;
+	ctx->generation = READ_ONCE(probe_generation);
+}
+
+static bool ksw_stack_check_ctx(bool entry)
+{
+	struct ksw_ctx *ctx = &current->ksw_ctx;
+	u16 cur_enable = READ_ONCE(probe_enable);
+	u16 cur_generation = READ_ONCE(probe_generation);
+	u16 cur_depth, target_depth = ksw_get_config()->depth;
+
+	if (!cur_enable) {
+		ksw_reset_ctx();
+		return false;
+	}
+
+	if (ctx->generation != cur_generation)
+		ksw_reset_ctx();
+
+	if (!entry && !ctx->depth) {
+		ksw_reset_ctx();
+		return false;
+	}
+
+	if (entry)
+		cur_depth = ctx->depth++;
+	else
+		cur_depth = --ctx->depth;
+
+	if (cur_depth == target_depth)
+		return true;
+	else
+		return false;
+}
+
 static int ksw_stack_prepare_watch(struct pt_regs *regs,
 				   const struct ksw_config *config,
 				   ulong *watch_addr, u16 *watch_len)
@@ -26,10 +73,22 @@ static void ksw_stack_entry_handler(struct kprobe *p, struct pt_regs *regs,
 				    unsigned long flags)
 {
 	struct ksw_ctx *ctx = &current->ksw_ctx;
+	ulong stack_pointer;
 	ulong watch_addr;
 	u16 watch_len;
 	int ret;
 
+	stack_pointer = kernel_stack_pointer(regs);
+
+	/*
+	 * triggered more than once, may be in a loop
+	 */
+	if (ctx->wp && ctx->sp == stack_pointer)
+		return;
+
+	if (!ksw_stack_check_ctx(true))
+		return;
+
 	ret = ksw_watch_get(&ctx->wp);
 	if (ret)
 		return;
@@ -50,6 +109,7 @@ static void ksw_stack_entry_handler(struct kprobe *p, struct pt_regs *regs,
 		return;
 	}
 
+	ctx->sp = stack_pointer;
 }
 
 static void ksw_stack_exit_handler(struct fprobe *fp, unsigned long ip,
@@ -58,6 +118,8 @@ static void ksw_stack_exit_handler(struct fprobe *fp, unsigned long ip,
 {
 	struct ksw_ctx *ctx = &current->ksw_ctx;
 
+	if (!ksw_stack_check_ctx(false))
+		return;
 
 	if (ctx->wp) {
 		ksw_watch_off(ctx->wp);
@@ -92,11 +154,16 @@ int ksw_stack_init(void)
 		return ret;
 	}
 
+	WRITE_ONCE(probe_generation, READ_ONCE(probe_generation) + 1);
+	WRITE_ONCE(probe_enable, true);
+
 	return 0;
 }
 
 void ksw_stack_exit(void)
 {
+	WRITE_ONCE(probe_enable, false);
+	WRITE_ONCE(probe_generation, READ_ONCE(probe_generation) + 1);
 	unregister_fprobe(&exit_probe);
 	unregister_kprobe(&entry_probe);
 }
-- 
2.43.0

