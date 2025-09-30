Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567A8227BA4
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 02:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200333; cv=none; b=d9va8sv8MzZMn04yiLg5mC7veRU2zNMOU+13qJqLuKlJxHm0OSIwwQz/FuI0VKJbn5MvDqSb3cep6QsMBvW30jN4iyd8AtiazDmVSGQ3jj1C735/Aj2ENvcYwc5Nbt+VyAkczm1IXc2B751c+dpnI2tE2PY3zyQvOGCVetO5yQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200333; c=relaxed/simple;
	bh=Sl2YI7Td/C9YkkJpnWkOlkyn4hvpDBvdNr6f7stAoSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q77kRRpDztspSukNureC0ip/Knp5owAmLnZZZ3+ky6ZvZySJIjVQJHIyMRk1GsH+TFYSzYrBSBuFMY4S4ySsqivyAwqQBnJVwxP14wVBNvoQMsxYdeTJ7afF+c2ZoxVNc3DMhdoI+bLHVbYDZGJLA6hKyZhmobjZY9sPqydmviI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiyBF/wn; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiyBF/wn"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7811a02316bso2897085b3a.3
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Sep 2025 19:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759200329; x=1759805129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sX4DcHmKN6k6jLli4BcDyPNAsEAGb3ORwL+dRbW7euA=;
        b=aiyBF/wnrDTAEUGQ3gs3hkoDo6ov65uut92C3I+ngMReOiufaQ1vmTFIu1XnSWaGGh
         khX0pjDWJadRCDMCM3CMXPMKCKltjKWNUtc51qshE5kXFvc287XTIF8QXgev3XVGSn9y
         05DxNPfZbgEUDZkoFxdl+YdQopelHsQzG3KhzdyKhxkrnE1Hv/+FHU7/2n9zyeLmIYVz
         uTo47nYJvcaZwtoT0ajVuJE7PlG/Oh+U/sm85SO4tUaIx1F5/CrTTe7S+qGifdVeBf89
         wV/OxahguZKjvN/XTCzxgnwE0taEPgzJ1LSh95A9Ols1FTzW4QPkrMnIoSn1CJaDFPvk
         oNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759200329; x=1759805129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sX4DcHmKN6k6jLli4BcDyPNAsEAGb3ORwL+dRbW7euA=;
        b=IkVyG9t+D1+0oodHgio8tdD+8e26ykcI/1z8gP9QEf6jDhAIygXuf7Hw+lR0xDt0pE
         AzffXMZIrIpQBEtQAl33lLoebCkIdjPezZDc8i6xIhk1br9BjZt9gSErPbKQmhOt+B3I
         Rfz2l2pBV8kkm7aAQJBTql+3BuRMNqGpuLhgItWSGtu6xr87EwEYbBjlz8ZKYzMopB65
         il5NFgPSq8jHZKEG3N51Z7w2Dcy7cudI/r2E7Z2IOxf6ksAqdINaZWzsz/iC7/L2FrpK
         Qj2Hshl9XjQdjtCRBHKPl/ns6LFPXPDhYWxfqcp9+VTCXiPu3bPFnLYr5IUXLwP5qNSO
         HifQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxNgQ52Lu3A5wDVd0DO1TQ6L4McHIxc/03lhsgSGdd8zYWZsoRpfyjwQXu1MFVbbOnIHvby41tCBofkw3GjWOa@vger.kernel.org
X-Gm-Message-State: AOJu0YyNwXHGTswD//qePicaDS9ouUblrrTF55mJsrORYm8DsuTI6tmJ
	YXTpNaB1XRFdGdeMJDgItcOwiNJtiAJiG7+J02VSLczfSmY+PGAojBLa
X-Gm-Gg: ASbGncu2s/uckTn8U7+dzZIGatyKaIbAurEfnyPg8Oovla2ejkD6YG72VACyVPmE00f
	UbFUHJER1bWHeUGn3TQkqBvdtETzxRSAVwGetcUmje64wNPqL/NfVePrTpdFMtFIxZ7DGtcWwX/
	4N7/g6k0ivdrZtSbQJ3WTrSfodIYp12ojVv1A3QtEWfUB0V553Z6zxoOnOU6g3vXwcbxJwYACL0
	ahZuwdl3TYBAPyzGlxL7XaknAumb4O9PcuF7LxZRixkKkw8abbaJq3sWErhinjNVnpMwDqC2pRE
	WQFdxe62Bp5VGOM9SH4giVwH4AyIgVsp9gOOAHQOpfBcmT4XGVQKD9p6CvNhHrR9XEz1ADOGZoH
	iTeRruQop5BwlthOvFZ7HudCc5lOBZpJc8mAKWwVHb4Lkoti+PFIkK/1O7XhwoT3BZjnosX/fXi
	BUGQM6aEXxMvc=
X-Google-Smtp-Source: AGHT+IGTqTwXopd2ojQqxBEBkqI1vY+O5jS9ODQlBJjx1qTPcUYlj9RqM72R3p1od6/UyekDO+cXWA==
X-Received: by 2002:a05:6a00:b53:b0:76e:885a:c332 with SMTP id d2e1a72fcca58-780fcf080d2mr23371738b3a.32.1759200329155;
        Mon, 29 Sep 2025 19:45:29 -0700 (PDT)
Received: from localhost ([45.142.167.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-782e36c803fsm5830819b3a.38.2025.09.29.19.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:45:28 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>,
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
Subject: [PATCH v6 13/23] mm/ksw: add per-task ctx tracking
Date: Tue, 30 Sep 2025 10:43:34 +0800
Message-ID: <20250930024402.1043776-14-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250930024402.1043776-1-wangjinchao600@gmail.com>
References: <20250930024402.1043776-1-wangjinchao600@gmail.com>
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

