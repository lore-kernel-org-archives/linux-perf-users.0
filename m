Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE2E1C07FA;
	Sun, 15 Dec 2024 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734286369; cv=none; b=ReRnJQQqFaEjVnFaj/PHPkyAoAKqqIBxpN9kXyeNJYxLdeE8VpT4Yowek8T96a5Si3jnh5UZW2UxsWkgsJdPsKBb5yazGEK7IFh+ADt0K1vv3nlvx4S5WgtC1HDv4dpjEyqsh6r0np+p3jW3ZVOnqPKgwTtb4aDfVwXANSR3kQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734286369; c=relaxed/simple;
	bh=jPBZDIKyif/LhOPbutvjTXCG2gTELlQErVsQ7/V8AdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imQbj+aP6Te1eiEXQ71o2Yk9G2ZNKfj/maklh4SB1vb5QHra/MVviKHZm4eBcqYpxEJteBLeFe0GAGYHzorXEl2VI565Xw2vNZ1X8gkTJndQZPDoxQMGSC3ncx8Bb7DcgQruKs5rLJY+OdWocRQguspUCn1Y07cG7SuqGxhGpmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQV+uLwc; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQV+uLwc"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-728f1e66418so2762628b3a.2;
        Sun, 15 Dec 2024 10:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734286367; x=1734891167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=La5gJeu6ZE78YNZ93RwabxKj07+dQVqjVUHs1YuCsfc=;
        b=gQV+uLwcnFPDtcDLfR95sVwAzg2iicHBcq5YEM8eItpY72fuPh1PbqZamYRL92iNOb
         v7Y6RYcvytwEsneWuYBgRZ1TcRNrTuVUDfAdWsGv4BbDqwJa2N+CeytuG84AwDVMtUfl
         GX/oJDa6eTR2KD4Ot6BQlLz7tjf8Q0cIbIDr6DMJJn3DJ3wPPHYYSZaUf/BdAExe/GvE
         uGFvc8nSeMAM2615K2hW7KCkSasLvp4Wb7UjtLRH8U8qUCNFutHYdTMhlvwFXO0j3Fre
         5T3TRV1d2fWO03OdA9nXuI46DN69ViGszL3cQY4+93ljjCzYmcMJtABOpHMYR3T/rPfR
         3MlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734286367; x=1734891167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=La5gJeu6ZE78YNZ93RwabxKj07+dQVqjVUHs1YuCsfc=;
        b=POwEqqhDhO9+YauIyH8v300y/039acsQeyI0P03KI0K1g421PnrcyG7JKTWwBOizZp
         MI58HYmmKnbHUCieWM1H4fXB5BC4FApoEv4XuRAuQPRWs7wltDB/P6U/JUQx2cS2oIZJ
         /2b+kvAAYyDE/nDOX3q3jyQckFBCwj1DUsKPjuMc/D4jdK5Izl8PeQ9BIhaN64h/MthU
         ny81aw5daQpO9qMh51Z6GxwMJm9Nd8pOUsPrJavuX1ZTfki8GJ4lXnvTSC1jhROHTrsY
         AT1ionHZHRdKAN6UPXdWH/A4Qs1oWV4n+KrbRDk+UDknwRBQ08/dhX4u/nTU8IwYPg7R
         C7Ww==
X-Forwarded-Encrypted: i=1; AJvYcCU7L4Uq572KckHNHks9enkqTILOUC77n4Zh6K/BcsDSkqcBBMjWYg9SZCQzquUSXI+lghOOcbFiKaDJd9YGUR9xlQ==@vger.kernel.org, AJvYcCWp81mnqqWz0VTTaKasFaQF9NyVC46X/WscFOvKBe325pTFOrVh0vE97JLbTYdIYy7MJSzy2JgSf9hVIQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJF1oXhdJTRsCnK4WytMa8+3B3VAsOG8W9hHCzukhhTEngqcg9
	bfJ4ryfYyvCEDNbx+2YFEXJkYiZPWWzvfTYivCvwBJTdKI4NWFwh
X-Gm-Gg: ASbGncu+Lxv7k2vaGYV2SyIO5B5l0XbvXcydJ+ZirKxyxfCFbFDC2jj4NMw7oqEdraK
	dAMfuoiLU2dn4AgR+gZJl6BGdpV2F27aTplRKQvSrxGaDikPV4n6FmZXhoyXS2AAmQywRzD+1+C
	puFax/4DZ9z5zNXrZsGMulypAkHPr6aofahG7rbiTdOV4JXhPUvXRHBdWYwJkOYBvPO58/u9SSR
	Orp6Yxu+jNFrfew3dkhjxJmHmk2ez0IHWi2pj+kJu7oDtUUVw9hh8S7pffrKCeL8LgHdP/017zs
	OIg4DjvUM4r6
X-Google-Smtp-Source: AGHT+IGOm/4h49+gzRm6sLRpU7pZjbBTQQhRFxCBqA/vtKYUviMTEGq2+ipHTV184q8arJ21vp9veA==
X-Received: by 2002:a05:6a00:929b:b0:71e:16b3:e5dc with SMTP id d2e1a72fcca58-7290c25b8cdmr14130520b3a.19.1734286367315;
        Sun, 15 Dec 2024 10:12:47 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90ba0sm2808120a12.16.2024.12.15.10.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 10:12:47 -0800 (PST)
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
Subject: [PATCH v14 07/10] perf script: Display off-cpu samples correctly
Date: Sun, 15 Dec 2024 10:12:17 -0800
Message-ID: <20241215181220.754822-8-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215181220.754822-1-howardchu95@gmail.com>
References: <20241215181220.754822-1-howardchu95@gmail.com>
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

