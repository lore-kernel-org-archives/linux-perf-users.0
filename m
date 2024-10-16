Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D891D5AA1
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 23:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729122993; cv=none; b=UaOJhmKt8x9tTD8WpnhO8HNUwiOIix6O8R7HQoc4QTiaXK1a/ArZt+SEZr0GQ5pHk1Nwqp4z0OTYcqz41PvDL1Fls0rn6xuy7agLk7voRyuQp993WnzkAZUyi1inUJtP0pwlnXElwZqpEKrESMv0szNdy+Hue+gixNgzxOc+q4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729122993; c=relaxed/simple;
	bh=q0aVGZHkRF3gGqrnfUfdn795vPhfLHAqdzFkqawlaiI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ozJQta8p2E8SkK3jZyE8prvrct7ay0hdk/vkODa5afKvP92p4ObO7M8chcpf+FdzibXQUfm1cTV5g8MmuhV5gUJ9dqMTg6HFFCDpx3QM3iFMr5Z8fzRFqZcXh73RG4EDn9XtImZafS6UwtA+yNoqjMNHPsTDzxZaWtvxpyXM/Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w7btLC9q; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w7btLC9q"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2904d0cad0so595274276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 16:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729122991; x=1729727791; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LSFHT2nx5Dy93k/WYJeKcczC9L+HDPym6LZPWSj1SxE=;
        b=w7btLC9qL+A7fT2Ox6Brb4QuwKwJVOxyyM1wNsNgxNKDzW7JExPvM4rUB8ouaulhUw
         MLzj/1T6uWsySqMeRFWW7sKlpNADxD5f2tfc+sf0TH14paDvKuW51XQKJZkl/OJ8f007
         5ncSZz6bQnnzl+4g2nwZuYfNC0jtTPeKlbSSPBhmOB3z42Rlb4jJ8WdbFLlIP/GPgbl/
         QY3If2Qp5iuhIgJDIj1pLcbjO8Qcvcwsisx4cmcC/SyGXnh7EEipOzzUBCq/CFqCsx7x
         WSCOP1HoKU12q1hV5BwRbbNIldP/YNO9p3NZqp+TH5xdTvs95rLx4KcVwPzeROVhzIXC
         fpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729122991; x=1729727791;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LSFHT2nx5Dy93k/WYJeKcczC9L+HDPym6LZPWSj1SxE=;
        b=SaZKkQw+v481iMl909odD258sFq+5yINVl95oC7sPSody/XawCmc385DYzHi4YNna3
         pO9wjNqmX+Tmp5GCuXGgPySctgGhrrb1z87/bSbpNdMraZ6YyRBGcynJUQwH6GOa2cnR
         5tJO/vk5usWImdZMZv7vIw+qIR9uhYlqa75SZD5Fl51hg5CB7zqoi54TBn6yH5lNasW0
         9XxSWo0KXRkWhYpM0RJPHUZmffZ7ZdA607cu62RBdZWVJCd+YLLg53tMCFiW+4nyNMLm
         bH+7ZF2z9O4HLkg3Ebj7XEwtgys+NiPzvdscsenqhhhS4ALJFzr4t9IDLVtgyr9jjFZf
         1kuw==
X-Forwarded-Encrypted: i=1; AJvYcCWvMccWsWc8auc/3zHqGG0twvbs9KUVuDoaEX20KTHxUq4UQ6yB9vOS2+uhruEc7mo69QBaagDWXcwqtCpEUywu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1fPT5zZ3yeit/3UUrEvUwhPOtu2yrha981jRjOYvTERjGBlmh
	twdZWY3NTh/fHrlEXeqkebrHCqJsTfdiVU/MhBsXFR8jpxYt6g78YOF1ibfsaW1suDgj/nzMhmU
	DLtv8yg==
X-Google-Smtp-Source: AGHT+IHK2vKtVHqXB+biJn4Sn9ZwQIhFZwk1XPmEiMSuixpaE2V3uVxlb+PavH3nTc4PlRYrlQXQG7ej9nLE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:947:0:b0:e29:76b7:ed37 with SMTP id
 3f1490d57ef6-e2978585cc5mr5263276.9.1729122990853; Wed, 16 Oct 2024 16:56:30
 -0700 (PDT)
Date: Wed, 16 Oct 2024 16:56:21 -0700
In-Reply-To: <20241016235622.52166-1-irogers@google.com>
Message-Id: <20241016235622.52166-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016235622.52166-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v2 1/2] perf disasm: Fix capstone memory leak
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Hemant Kumar <hemant@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The insn argument passed to cs_disasm needs freeing. To support
accurately having count, add an additional free_count variable.

Fixes: c5d60de1813a ("perf annotate: Add support to use libcapstone in powerpc")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index f05ba7739c1e..2c8063660f2e 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1627,12 +1627,12 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 	u64 start = map__rip_2objdump(map, sym->start);
 	u64 len;
 	u64 offset;
-	int i, count;
+	int i, count, free_count;
 	bool is_64bit = false;
 	bool needs_cs_close = false;
 	u8 *buf = NULL;
 	csh handle;
-	cs_insn *insn;
+	cs_insn *insn = NULL;
 	char disasm_buf[512];
 	struct disasm_line *dl;
 
@@ -1664,7 +1664,7 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 
 	needs_cs_close = true;
 
-	count = cs_disasm(handle, buf, len, start, len, &insn);
+	free_count = count = cs_disasm(handle, buf, len, start, len, &insn);
 	for (i = 0, offset = 0; i < count; i++) {
 		int printed;
 
@@ -1702,8 +1702,11 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 	}
 
 out:
-	if (needs_cs_close)
+	if (needs_cs_close) {
 		cs_close(&handle);
+		if (free_count > 0)
+			cs_free(insn, free_count);
+	}
 	free(buf);
 	return count < 0 ? count : 0;
 
-- 
2.47.0.105.g07ac214952-goog

