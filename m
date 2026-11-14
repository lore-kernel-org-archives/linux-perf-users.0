Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681091;
	b=m/II8IcohiVUW/8xM7V4pjrOee3SGG2Go0oim8dGUpd7skztgH1k2mbhxzQkV81m6ZkC
	 rxaonavQZ17lWJtZgrm3jO7R2tEuZq30PWmJ9oQQyLqyNf6qsg8E0U9W36tZNZ8iPcaaZ
	 QoHytDhi5nquZi0diOa1xRbsDs54hYub67ZX20F+BXIgLU1O/S8DFSb6GNiIQay9zpYof
	 AYqnq32AqB2kfDzKZA5yQ/usX0dSalnmfJoB150UHy2+KPEXOxippZQs9qIPalqop3av5
	 JfB3JJ2JhTKk0Mre8RLU6uxgFbT/OREFpa3tsf4LhP5O3DwyOdn9e4Vk5yyXy0jcNTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mLtlrhyK/6g0u52Jzk6ZQfKICIxuEk7VcSNcDVEOcMc=;
	b=L6+XSMt0QAPFukydCFTrXkHoogECRp9oGPBjqNR1Rt53dqbBRd5toU3mwKZhTYHC19xE
	 Wtqnw0hYwHN61JV/DxV5ZQdLAmiVb+RGcUxm/jFEm7QtAtQqK1lmCeBfFJJUcX72c2EkT
	 QzVUZ4VfLdAO3MD5v+C/56NS9F7FduHoc0GqZsMkK6Qh1nNb6edYe/AsMDjB7+2TvbIDU
	 0YqJUz+hhsB5H+z7TMSJUE2GxPgaFy46lo06LCYZ8Ix5ywaK5VVMGMaWUgaY0vDUBVUZc
	 wZJCIb7p1h+CPMXfJnmD10sYdiWV+eqTEJwBZ/MgFvvAEQ6sqkSpUpH5zVXd7EWB6tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZZU8Wv8c;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D459606A329
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 18:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D459606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZZU8Wv8c
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-939ed428e11so43065985a.3
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 10:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794681089; x=1795285889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mLtlrhyK/6g0u52Jzk6ZQfKICIxuEk7VcSNcDVEOcMc=;
        b=ZZU8Wv8co+qWSZtx8nc3GIbSAtiq9clqcMpHrBzyvLcZcvMEU6V22rYopnyG4I0Mp7
         nsPDASa5XCjbJ0yKkl/TjS8v7NR2uM1iTYdzlLH95LYIy8lg9s1HwN64p0JKpUk+BPWM
         wHsheBBPOI1NYs9GDJz7t974CN7xgQoZwQMq/OyxY2K1g/vgDK+6NJtmgOBIqh4PM9eD
         QLsr2HGLQceP9rSCESuySRNiMNB8U+egSh4RtO/j0RQFVaCQk1oIR9Ai8GTsnNwCaxgK
         i2PYA3WOTaNxaeeAEGp10UTi585R11cChkruNP43uTQZXJa4cncL1MyBYvV8guCKoe85
         HZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794681089; x=1795285889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mLtlrhyK/6g0u52Jzk6ZQfKICIxuEk7VcSNcDVEOcMc=;
        b=trjdjz9ki610wZyfaYaEgsw6AOfKgp9TyTrg5sd/d76DTeqtlcE/88nZzhjY042pXv
         iO3Napai/uZAXKQPc8DX1oEhHGEyLwSwsu9V32NAshCMwEFfCkfpsTqWD5wSwt/1i27m
         JbVqICXUQIQPsAlAT1iG/O0tUT0/+RKwXDR39s9wMtJwTYmm9M6BpjSk5mhQhcODu5Km
         chNnqa0cP74ThhBwU4v3J/Bg0mFSsJNmI6FysS+NQ79KuGZYrhZRdIOMABhl0kFqO8rN
         5AmYtrEssZFkq3H5gG9RSoikgVO6cP8bdUz4ZE8rVJrk9oo1AhdPa5QjWTvoID64xs8z
         qQjA==
X-Forwarded-Encrypted: i=1; AL+hErHLi0YyxDxx6y7QGLLdXNzKg0uR7B/KXWrp40WvxJnDzD9zEcI5kU/X1eN8CONB5wv7aTLkd3PBPd39rogrMmwH@vger.kernel.org
X-Gm-Message-State: APuU4Z/fB1Qlnx6ujAK5j+G86SVmerxMt7KEhRNOiV6v96huPHiS+Uni
	iGjadsXoJkKHA4UjY5+1uYtkJyy7c28HYOe1MhMsxQBw1G4o57KleNaZ
X-Gm-Gg: AYBFou1hCEiidZj0XAkK7yRIBK4SWYXIhM4btlApN35lbuxdwpWVD02sP/5wukbiCp7
	9JzTWgJRiRa4ms9YqhjJLnmoxFvyacMBq6Nzz1gbVfxddnfrD/nBCjg8pvR5QFNlRoFdou1dTbT
	n81L9un+97B6cJiHJlSMpqfJW+OYm/1XUJp69436tW/4jk+p+ln+IXUSyklj6484i9PaWCdW7ZR
	sWnxpp9JxG5zn+WSWyOBCixQyl9igPuHnAntStnjMmagYmZsgFwBpfEE3TauSOGJveSgF2WWGsx
	qKlUWyfRNlfuNPf0cdJ2T3bgSUyKNw7KprBPwSmOushNzw6etcMFR5rEmqiHNhnEXzFiujLD+T9
	dSsKL5+s7UUOgaMywOKBeRMMwS+IFUcf0bbPF3YHHLUy6RA79aHmYcJFn1O3UQDZ9nk02QvD4p7
	mCgIyNasA4Ihi4XvtsdjJn2feHdE1tiQj8DQbgByRpgOUaIMP/XD/HZJS23aP91BWTu97+KSVEA
	z9WEy/2pZuTrzOCHFl/irlOxWt2uMTCctOGspEjnKq9Nm68FerxOp+oMR79eLg7cHm6i3DQhjF3
	TZ/KR/9ECtLN1FXr3Za97IhWuRCXuOO0rVX6LXjzc+kz/m0APP0laSvFYYeRQbELLVQ=
X-Received: by 2002:a05:620a:8a0d:b0:949:728b:51f with SMTP id af79cd13be357-949728b15edmr90967285a.6.1794681089114;
        Sat, 14 Nov 2026 10:31:29 -0800 (PST)
Received: from yaozhao-prestige14a10sc ([198.58.190.97])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c836f62sm458876785a.23.2026.11.14.10.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 10:31:28 -0800 (PST)
From: Yao <dragonlinux@gmail.com>
To: 
Cc: yao <dragonlinux@gmail.com>,
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
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Jin Yao <yao.jin@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf annotate: fix annotate crash for fused instructions
Date: Sat, 14 Nov 2026 13:31:21 -0500
Message-ID: <20261114183124.685561-1-dragonlinux@gmail.com>
X-Mailer: git-send-email 2.56.1
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

From: yao <dragonlinux@gmail.com>

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

Signed-off-by: yao <dragonlinux@gmail.com>
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

