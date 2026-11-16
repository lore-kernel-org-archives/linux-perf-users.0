Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794848090;
	b=hAJkUtxWPjSUMmkLdR1f4oAZtq19O2xGu+lZGmvyh492cXJoRPrIqjv1YfPlX1pgnJ3m
	 z8Tl4ZOhBqXUbFA3PV5eCduONePaoVWBbWyXckKg/mT7kCrDXbCu7M0lk2PcdAKzRsi/B
	 n0oArcECXSC7BBGNgQXy+C1PqHSHlbpGaurW8Z1qhDbMJBsRWfuPgXCrShKD2Al1wqSCa
	 V5jh/D8zyIZb98TYW1bKqOsu4I+EnwmlFI6kLs/Fl5t1wFHtCQJKctPUiB++mtLyA2YtT
	 xH22V5EIZtpLxfsPVIEiaH1c5geHdIvkEp7xWGQHz98KL77Ral2/OvM1mEllpto2Png==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848090;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LOAmxS8K+OCoXLzvd37V3GKxqfcndrHUPZEQ9tOoP5o=;
	b=i1evBpqCHke5I7b8mEGg9VTzO7YHtZz1DPoNw5U0mLPB/Mf7a5K9YQUXGohRoTle1wxQ
	 QjQIg/KP9O3h7FOANptobtk+OhPoHtPbeIKladdjoVyXsf4lfj5R85wsnuVV+hJ/DrgcF
	 GIcT0IN0t79hQMHZINWBd1Vd8bQ6UllqRcKsUJ14KIE+XM0qkOrW1frDXPcjmfA98M8zF
	 mM+BV51LIAewNgh1V5OaL988WRsyy6R3T7fz7MPoVA6MBjPeJdtZeAxA5BrKYi3lO6JNO
	 gqahBIqIxAnekNKKCLnaG/M+cIr596V6yAJjsgMlycjmjFFyKIdA3yEorvMRTBvab7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cW3iC+NY;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E974606A33A
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 16:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E974606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cW3iC+NY
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5ecaf4e9771so158728e0c.2
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 08:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794848087; x=1795452887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LOAmxS8K+OCoXLzvd37V3GKxqfcndrHUPZEQ9tOoP5o=;
        b=cW3iC+NYsaVZrmv6RwOCaRUmzw+bozzgbiSVyx7vpGCGQ3wFOqQDU63uEQ0YunYhAo
         K3xICuqLnvMDmTt9wPUVOScVLF3zgpBukiUFVeTojt1MJ86OeGa0sjV8eDHdN8g1IFn+
         AmHjxUBYlQFyoIRW6KvJR0Jb124Y/KX9Qi/RHuYIGNRJuZc8XfNw6hws71rHjRvnnUEF
         6GtZzrP1+IxlHNVaTwwWRnhUiyDH/aj/xrBQPYZxH8X3u5Hj0jcKXRl+1BiieaPBsroH
         +p8dMC503b8i6N3GRXVMjhmxkxEKIkM0qcY6e1FzAfu3jsU4eOWAtpV7l6BQRfI5PPDu
         6uiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794848087; x=1795452887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LOAmxS8K+OCoXLzvd37V3GKxqfcndrHUPZEQ9tOoP5o=;
        b=sOMn0LVtG7ypMUkCGDnTgG+tDUHZus7MGf3SOAgwWnh9nBplThai+I9NiHCI8gnsSY
         2cb0f4QvXB96d9VdQs4gELB3rXhOrBdGLQ4+mxTWnC244Jmv3MU8auE/jbhnbd/jxhv8
         Ih6hRp7mDhKAwAr96z0wZzqHr2uhzrpNrmnMmtzH/ZilhXThGIUVbDc4eGpKpjwKJOda
         mAEeq4tI+gsOE8TTu61wzg5rERe68/bNk23h1ZqXdTPvFzuwVtnkO4az5OBOUlJXyRum
         8CVLCmNTsp4vzZIUB0N9tnmE+IpbR8YFzMOS/22uiM+6Y8HWlUQgrxzMtDx+RMlBWxS5
         O2jw==
X-Forwarded-Encrypted: i=1; AL+hErH+lYHlarMmDBvuQ3/qVfYS5e9Hmk6yaZ2coh6JhuGu6GpXZfyFYly8PPS2zKrspQUQhS0xa0GxqA4/7QPjB5ot@vger.kernel.org
X-Gm-Message-State: APuU4Z9nSqTtCVHG1NzcppEOuLiY7+rkvSDjc+c9VDGN+LtgEBVImelX
	4ULjXgb64u2UaGa1aAGrOACc3kkcwemcG9Qb6Fm54iDxPUkKgIvqVZy8
X-Gm-Gg: AYBFou0oKpeEWXjQXDECjjYVvwskTWVN4PPGBwB1gUqf5bEVluBVzqMO6GTu2kfbZuP
	DK/JNIz07XVz1WR/vPNkBKwoEt7Utz4ccvKRjO33Wev+yAPCZkjvV/uUtedYhXzK2XhRoR+EiY6
	YbrPIVCrkAhxIIoe5PnTQ97/tdNbuRBxN8E+MV3V+AiPyUiaOyjKCRvhLLi7CryTwyHwVBokS3a
	y6K33kQQ/Z5gO65nWTQzFUZXg5xdTvhHhd9NajNoaeQh0vqo/ixivOF21vC8meJwdYZarCaJ7EU
	NK44/5xxer62Yf5kJxvyOcq8MDogvCJPuAlah3A93AF3Xq0+GLCUx+Y20jag+IHF81lpmbjjIUK
	kT3+rWDdnKC1klZQgVHVGJXjgAGUNJWcXDS+7wZhQa2Vez4SmE2uuS2gJOFFA9mPPbIRi1cQIf3
	rALRzKyZS9l4MR5X4l56ZML7NfPn6WJtLicFL2e4GxSDI7cI9BuI9zp1k/4Y+AK0Kc3KVV7YVo7
	etuYX3Dv3UfBfaq8CDbuEi74LuVCdtSTVLyHpGFSEg2JYU0WtPel86Y9cnlhiZIXksUT9G8gnaT
	Q8s1IFhEGEYixaxVSyGtehN/aaTC4yk0fzwRl7rIGLIV4A==
X-Received: by 2002:a05:6122:5119:10b0:5ce:bde0:9b53 with SMTP id 71dfb90a1353d-5ee34a46459mr4050755e0c.3.1794848087387;
        Mon, 16 Nov 2026 08:54:47 -0800 (PST)
Received: from yaozhao-prestige14a10sc ([198.58.190.97])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e9516dsm6958158e0c.12.2026.11.16.08.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 08:54:46 -0800 (PST)
From: Yao Zhao <dragonlinux@gmail.com>
To: 
Cc: Yao Zhao <dragonlinux@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Jin Yao <yao.jin@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND] perf annotate: fix annotate crash for fused instructions
Date: Mon, 16 Nov 2026 11:54:36 -0500
Message-ID: <20261116165438.694835-1-dragonlinux@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <sashiko-outbox-214904@kernel.org>
References: <sashiko-outbox-214904@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Function is_fused tries to find the previous fused instruction with the
current conditional jump instruction in the annotate_line list.
disasm_line is the container of annotate_line.
The annotate_line list uses list_head and the head is in annotated_source:
notes->src which is not an annotate_line, so it couldn't walk without
checking the list_head. If so it will read annoted_source neighbour memory
mistakenly and most likely cause crash.

Fix the case where current instruction is a conditional jump and it is
the first instruction in the disassembled list, the original code will
walk to the head and treats it as disasm_line which is not.

    -------- backtrace --------
    #0 0x564dd8d5d5cd in ui__signal_backtrace setup.c:0
    #1 0x7f1737e3e6f0 libc.so.6[3e6f0]
    #2 0x7f1737ec10b1 strstr-sse2-unaligned.S:41
    #3 0x564dd8d625ef in intel__ins_is_fused annotate-x86.c:0
    #4 0x564dd8d4bcde in annotate_browser__refresh annotate.c:0
    #5 0x564dd8d49bd6 in __ui_browser__refresh.isra.0 browser.c:0
    #6 0x564dd8d4a960 in ui_browser__run ??:0
    #7 0x564dd8d4cbcf in __hist_entry__tui_annotate ??:0
    #8 0x564dd8d50a91 in do_annotate hists.c:0
    #9 0x564dd8d58bb1 in evsel__hists_browse hists.c:0
    #10 0x564dd8d5a7fa in evlist__tui_browse_hists ??:0
    #11 0x564dd8bf7a98 in cmd_report help.c:109
    #12 0x564dd8c713e4 in handle_internal_command help.c:109
    #13 0x564dd8bd6ac2 in main ??:0
    #14 0x7f1737e27781 libc_start_call_main.h:83
    #15 0x7f1737e278b9 in __libc_start_main libc-start.c:127
    #16 0x564dd8bd7095 in _start help.c:109

Fixes: 7efbcc8c075c ("perf annotate: Fix fused instr logic for assembly functions")

Signed-off-by: Yao Zhao <dragonlinux@gmail.com>
---
v2 RESEND: fix the author and sign-off name; no code change

v2:
 - add Fixes: tag
 - add crash backtrace
---
 tools/perf/ui/browsers/annotate.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index cf36b5347f72..07449944fa2e 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -155,17 +155,26 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 
 static int is_fused(struct annotate_browser *ab, struct disasm_line *cursor)
 {
-	struct disasm_line *pos = list_prev_entry(cursor, al.node);
+	struct annotation *notes = browser__annotation(&ab->b);
+	struct list_head *node = cursor->al.node.prev;
+	struct disasm_line *pos;
 	const char *name;
 	int diff = 1;
 
-	while (pos && pos->al.offset == -1) {
-		pos = list_prev_entry(pos, al.node);
+	/*
+	 * backwalk to the nearest neighbour instruction till the list head
+	 * instructions/non-insn are ordered from head to tail
+	 * head is not a annotate_line/disasm_line
+	 */
+	for (; node != &notes->src->source; node = node->prev) {
+		pos = list_entry(node, struct disasm_line, al.node);
+		if (pos->al.offset != -1)
+			break;
 		if (!annotate_opts.hide_src_code)
 			diff++;
 	}
 
-	if (!pos)
+	if (node == &notes->src->source)
 		return 0;
 
 	if (ins__is_lock(&pos->ins))
-- 
2.56.1

