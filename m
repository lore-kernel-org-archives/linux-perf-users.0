Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9971DFE04;
	Thu, 12 Dec 2024 23:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046054; cv=none; b=lu6ZfQ667/saZ953uCtyFAxwdtE1xMwgxrQfFbA5cYNZt6boWLCDIZEzyXsMYdnnkmr3ZQ6iMbzDd7sj2c5sgVH051Pik+uawWcgzdXAcjDSF8VWZ20H2t0nQBbF2wBpdUnXAEnQ2InPixucATwHjwpGm1wjYpXDmeq939ATZ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046054; c=relaxed/simple;
	bh=jPBZDIKyif/LhOPbutvjTXCG2gTELlQErVsQ7/V8AdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hO27eKKSFTEaSgGzqltjN/L1R3hpWpha8rDRbe40Dmn+5WzpHguwTr61zAFUK4/CQBhknO2O4279PwHd4t+Y2bdMM/YtXJDbv6ddM30q7jpoATsbbMdSLRh5XLARbilVNwlsd/42SZGQPzxYJENXGEF8Y5y710VEplm4qgKKplA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkE+2F3a; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkE+2F3a"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-725dac69699so1062619b3a.0;
        Thu, 12 Dec 2024 15:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734046052; x=1734650852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=La5gJeu6ZE78YNZ93RwabxKj07+dQVqjVUHs1YuCsfc=;
        b=SkE+2F3aiUHks4TfDlY6VEMcjYa5rCUOLmzEeOqa9YSjQroA/Bpll5pNUC31jv7dFX
         hoLbgEfzUesf58sqPXj7QWrNSWJdaHAFx/ph7jvHBA2J3Aa/fHK5smiy0+M2wy5kX2Tz
         ouT672QjoivQ6aKQERNhTpJJfgY089CHhMmBvRYBCmxcPMox9NRdpkkPkbTiu3rW0QJB
         //s7woEQW/9BZovy/ZncWFMEhLSgruifzzIJB2G3Tb5r0enYhHRwXjOCUcw6Jm6ZT1Xi
         B5mWAvUBjGzldk4HmBXuAcxB9RtFnBU3gdo6tRcqn0nvPFhZ5KvqkX8u3FGkLK3xzZ00
         Xn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734046052; x=1734650852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=La5gJeu6ZE78YNZ93RwabxKj07+dQVqjVUHs1YuCsfc=;
        b=ZxbwNU5w+EjhgU6qcs09PnQmK3baOCDE93Bemb02PxfJGhdMrFpdMJ6YuQdVHxxbto
         bR1w0iwiOx7i6U3j+E+zykIbALqPGzdf/hOFQazEiJkpUWWFaJ98F/J2/E514Otq6Ae6
         F95tkeUHf9g3g1Rfw90lB/udP3ol8E8vlNrNh9CfEoXQD6i/q/hva/f3LXY5ec+9jP4i
         zbKz8wqR5xn8NkccyUgIMWG+JVNrC4YvNGtlJYlzv9V1ulERnCyPMvZ11XlgIqnDqwsU
         SKh9RGQFV1+vwq2+FXK0kXqWaHi76BNjkwobUzFv2pv/ogWXhpxbhQNH9yJBSJqPpZSM
         ajmg==
X-Forwarded-Encrypted: i=1; AJvYcCW/A7RkDOxbzR+Rx2PK5Np7OZzLl+uTfRm8LO/bzlCJHH0evdeGU7r6o8GoPORaZGDCNU3J1grZ54fv0XGV9RRd7g==@vger.kernel.org, AJvYcCWsPJuzsg+0RXqvQxnIXxjdPYJav4WhEjmF+lY5USK0zy4XwyKf3JDDZyWsXFEf4iFDrD6fxaBRYFl4it0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZMsETm3xqLCpLElofRwtM0Z0wX9T71Q5eMtXYiPbO+K8ednU6
	rQou5MKRvSCe0+Qjt2mxb5YnzuBIgKT3nTKUG9pE8G7OwQqo0/Tb
X-Gm-Gg: ASbGncvykOOsal+uBoOeXnIdnjq/4Jyt8p3Ygr3LULgCE+dX1poIAYWmPpLcrw2Z55x
	uHs/AC6mg4E4WloAyjyianwbP58YzkHSZUnwdANzaRT5vzOnBoZjsCMsSUMWONW0vHbXCJjIuQL
	Y3+sJgyCuRdeetZNmRadVILo38KLsghJWZyUEpWRKkQ57Y132lF85rTEFmmfnQZK+OtyDQOSzNz
	j9sUax4JurULvnjCfQYoA6004WXl3/WZlHm81HN4suayntpZhoy678wIONxNUc8hQslgNutq3QE
	ba2Zu/i45cjD
X-Google-Smtp-Source: AGHT+IHz62lVCjXkqrysoOggnv6NrxcmBoTtdbWrAKGPr4umM9wk2u4CpD88nO6+UdLIDikgufY4XQ==
X-Received: by 2002:a05:6a00:c8d:b0:724:e80a:33a with SMTP id d2e1a72fcca58-7290c270211mr651883b3a.23.1734046052330;
        Thu, 12 Dec 2024 15:27:32 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4e202e9asm7324674a12.72.2024.12.12.15.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 15:27:32 -0800 (PST)
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
Subject: [PATCH v13 07/10] perf script: Display off-cpu samples correctly
Date: Thu, 12 Dec 2024 15:27:14 -0800
Message-ID: <20241212232717.232507-8-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212232717.232507-1-howardchu95@gmail.com>
References: <20241212232717.232507-1-howardchu95@gmail.com>
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

