Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657317E918;
	Thu, 12 Dec 2024 02:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733970301; cv=none; b=MkHBhGa1rOX8S5IjuBJxj0X4NtRX76knk6FKcphST+3n1epUiAZ+YDcGKCT0UsfxHDrQ+JKeUVi42+WQeSIEKxFs0LujHL1f1aWJavl27EWcUyZafe+E8rwCku/uzp4nBA3IYz/XcZ/hh2Y5qDAjQ+s/RqHMC1P6lTcGcYrBSmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733970301; c=relaxed/simple;
	bh=jPBZDIKyif/LhOPbutvjTXCG2gTELlQErVsQ7/V8AdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWYuHC0+o6camfJ8mCddYJG+AjDM62HbxMEjUWUUtQIbag9se+j8bwo+cUg2QIhzljKHd+bzEsOIoV4bT9fn+HGn271DtjqorCldZI1krag/dzJB9cyZaOoiy5HoVHJbbrtn7Uoic0nT/O9wYsl9zaPu+RCOeTYnr0tStY5fwcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PElm7Rid; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PElm7Rid"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef6c56032eso53936a91.2;
        Wed, 11 Dec 2024 18:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733970300; x=1734575100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=La5gJeu6ZE78YNZ93RwabxKj07+dQVqjVUHs1YuCsfc=;
        b=PElm7RidlX4pxbZex4SiRzaBgtzDIzRPa0ZDg8EdpN1dh8OTtdDNcreUvZOxrw6ss7
         aLF2rHpwzToDaC+rn4WsYDj3+ee2XmvH3mxvNIi7eHqPIpaSyroGrJMtWfARgWJr37PF
         JSM+ARXhC0zwAI+j7m58aVbgKqALWZvNO0fLuTc5jrEwsMI+35mxyN0IJpwQK2WavJZs
         TPPdzTfxI8hJX4MlxHfei0FlVVjY1Pgrxuon6d7KDS3zbV6zz391hZvl7Qnor33YHEvg
         Zvihu9pOXZ7WbCtM9zFHTknrFYKCZ7ND6P3ZyAUENQD09S0X6Sk2ljsiZtc/NQ1L6cfY
         BeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733970300; x=1734575100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=La5gJeu6ZE78YNZ93RwabxKj07+dQVqjVUHs1YuCsfc=;
        b=aU6Ge77RTBj1Q8F2I6YHO7sZEfO7OkQ503HPmEqNZ9XRpWeYwAOR+YMMHFES5Sf307
         J9FyJGh5vH/qI5aCck5HAu2gzJdIrR3xxncSJw8WULJtoluK1+8L6Z2Rq+CfoMsu4zwx
         3KzIv+Q1uknz5YjwfXNrwHwMVV33Ru6IvNBlTxbIcH06g1Y6bglcNuxliKsjLsUKNcjM
         VnmuwGYk47ugD7XiGWFPRnab9Q4ItjIWl+bJPgFrr6yFRuv64V5vm2owtgjmLk7DA8DP
         KMc8Vhn8NCDaeTmrLgRaWCfuU19rxQbppLZy6CezQv505/Jvevy3hMsrT1K1hMn6+dK8
         eJEw==
X-Forwarded-Encrypted: i=1; AJvYcCVTJsk7KZO8+PYJePucrqv/SQ7W23P7Rt+13g7cPJ+zDDbtL19V2MEC6Vlk72ShJekFUJCc/H+s9Xjr45U=@vger.kernel.org, AJvYcCWL5simJChDdZHbE0nBxJPomnyxrEGqZSb15pB/TpRPxatUMg+eFBFPHr3ZtHrKfstdkmV2wYm1c0vv802U/ZRUAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBW/hN6iOyCtPQ2XoCDaiprhZmriy26p/OwU2CIelaTupKOlej
	EFGIeTHW3DXbE5kn/30+dAeGdL9SO4qAzAuzZnvSbprWmCefa9Sf5uS4b000
X-Gm-Gg: ASbGnctgHRhFyI4sUjWPTOvvfFnzpjlKqnUzEgFtkcmt2IrCnXgIpc0rSFYWkyhEZCR
	6hhEVICYRSuu3fnltLRR8Sgiycoos8v8NhnkSQ1FnUfJx1pmVEnxCuTGCbfadEMzJ8NsSMbzedE
	ZMb4HC0sFT39ZUBsFw0ZbJW2PpYuM2AOoLX08chQCvlQMi5XNxmLO7nl/N857HAx9Gfd0LyiY02
	JJPk7oUvTNrbPh1Oc43Zf86/kJNZ6ERrwHrfLhZ6h3r6UcUVGH8SUJaO/RsoXLIm6vLhodp73C/
	ZN/S/tsm2UsL
X-Google-Smtp-Source: AGHT+IGQHTQxrZi7uklCn2GbWSCeAH7VLJEJVKcf4ZWiCTXklJm6if+7rxocUUYieHi/8Cluwjh78Q==
X-Received: by 2002:a17:90b:2e48:b0:2ee:741c:e9f4 with SMTP id 98e67ed59e1d1-2f1392938a2mr3230366a91.11.1733970299752;
        Wed, 11 Dec 2024 18:24:59 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142daeb5asm112583a91.12.2024.12.11.18.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 18:24:59 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v12 07/10] perf script: Display off-cpu samples correctly
Date: Wed, 11 Dec 2024 18:24:17 -0800
Message-ID: <20241212022420.1035999-8-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212022420.1035999-1-howardchu95@gmail.com>
References: <20241212022420.1035999-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

No PERF_SAMPLE_CALLCHAIN in sample_type, but I need perf script to
display a callchain, have to specify manually.

Also, prefer displaying a callchain:

 gvfs-afc-volume    2267 [001] 3829232.955656: 1001115340 offcpu-time:
            77f05292603f __pselect+0xbf (/usr/lib/x86_64-linux-gnu/libc.so.6)
            77f052a1801c [unknown] (/usr/lib/x86_64-linux-gnu/libusbmuxd-2.0.so.6.0.0)
            77f052a18d45 [unknown] (/usr/lib/x86_64-linux-gnu/libusbmuxd-2.0.so.6.0.0)
            77f05289ca94 start_thread+0x384 (/usr/lib/x86_64-linux-gnu/libc.so.6)
            77f052929c3c clone3+0x2c (/usr/lib/x86_64-linux-gnu/libc.so.6)

to a raw binary BPF output:

BPF output: 0000: dd 08 00 00 db 08 00 00  <DD>...<DB>...
	  0008: cc ce ab 3b 00 00 00 00  <CC>Ϋ;....
	  0010: 06 00 00 00 00 00 00 00  ........
	  0018: 00 fe ff ff ff ff ff ff  .<FE><FF><FF><FF><FF><FF><FF>
	  0020: 3f 60 92 52 f0 77 00 00  ?`.R<F0>w..
	  0028: 1c 80 a1 52 f0 77 00 00  ..<A1>R<F0>w..
	  0030: 45 8d a1 52 f0 77 00 00  E.<A1>R<F0>w..
	  0038: 94 ca 89 52 f0 77 00 00  .<CA>.R<F0>w..
	  0040: 3c 9c 92 52 f0 77 00 00  <..R<F0>w..
	  0048: 00 00 00 00 00 00 00 00  ........
	  0050: 00 00 00 00              ....

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-9-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index aad607b8918f..87b2cedc1cbc 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -662,7 +662,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
 
 		evlist__for_each_entry(session->evlist, evsel) {
 			not_pipe = true;
-			if (evsel__has_callchain(evsel)) {
+			if (evsel__has_callchain(evsel) || evsel__is_offcpu_event(evsel)) {
 				use_callchain = true;
 				break;
 			}
@@ -2358,7 +2358,7 @@ static void process_event(struct perf_script *script,
 	else if (PRINT_FIELD(BRSTACKOFF))
 		perf_sample__fprintf_brstackoff(sample, thread, attr, fp);
 
-	if (evsel__is_bpf_output(evsel) && PRINT_FIELD(BPF_OUTPUT))
+	if (evsel__is_bpf_output(evsel) && !evsel__is_offcpu_event(evsel) && PRINT_FIELD(BPF_OUTPUT))
 		perf_sample__fprintf_bpf_output(sample, fp);
 	perf_sample__fprintf_insn(sample, evsel, attr, thread, machine, fp, al);
 
-- 
2.43.0

