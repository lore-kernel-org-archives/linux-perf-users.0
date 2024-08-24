Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBE517B51D;
	Sat, 24 Aug 2024 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724517210; cv=none; b=nNYab0uNEbFX4XM3VankYTwm9ZFrkQcRz/LgfzVtWas6sicLzR3NROPlpzttwn8LstrNTVYTb2lNrZfZdGTSzrMu3F96JtFcPopsjhbooosqLFX6ZOk4pzludbCJkuIZZkq7oI0gkTtS7PnII+zQkajmq5XnZMOj1+yuOv+8ErA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724517210; c=relaxed/simple;
	bh=vfIbeHWg9LvSoCfaF62tZn/mEA/ztgIgvgTP3b0RYnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4KTWpIVuaBB5YcL2NukAZk/SBwkVbKNnbHb3AH/BPz6gkiz7X5rw4DkwNDTtvgC4z14wBp3utYM7AVR2WMRjFPXFfYWfs0f2DS3H9bUBcwuxpEZ6KWE+Fph5kwZGUHIY4zndCt9TSo97B396ligDUIhxxGXqXLgUDmckGwJw78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQ2PpgEC; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQ2PpgEC"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d3d58d6e08so2259714a91.3;
        Sat, 24 Aug 2024 09:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724517208; x=1725122008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuI8fTyx4ROJVsLT0k9C5F+jin8bf5xIeZC53S2elNw=;
        b=jQ2PpgECciSesOfoWAApH7tzzDy3FAvfmoNXHO9l3fZFUv/d0WIU0DmYoDkv2YPENJ
         70jaso4uaqhNsEDkWO6ndcDb9eceUl+OrYRBeW6gu409P2KkhGFgmpoENn01jYWZG5U2
         btjVUs2gSn2p0pKBfD515jdAtcXvo09czlByKj/dActJSQEDhMS9U1iXU+2tXkqTYpq4
         fKq3YF4COSj3AkVriiTn/nBHyVVfMy4gKkIWySxlvZSfpqwaNZ+dX3vaE7BpGH50WmQO
         K9v0a81VL0av+9udyAsNZTr0aqrU08dadjNuE+CmxtXezNhbGzRZgGp7Zti42ESRY83c
         xHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724517208; x=1725122008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuI8fTyx4ROJVsLT0k9C5F+jin8bf5xIeZC53S2elNw=;
        b=Df+omNocmWJmQisqdd2037wPJj2enZryF9zmgxdi79Fm0NUNGFaGzjTPncWQL5/w6K
         awSA7BxOswaYpR1bqMpClU+fqSgOCSc+CT1dB7PzPcMRrPGnixSohwCCp6X4GkF7Nwn3
         HvWdcVO3L3LVG2BJX3r5i/Vnoe9P7eNXj8EbjukEmP1KPePt87nCCT3rEfJzpQedK5xF
         zxyGAvyOY8UMmJgpq5PN2tmzj3nimVclTedOQSadLSuYwTCme4UOMfWROyhyOl038K9k
         UQIhT3IzD6ofFUc3iY5yNpznvcgJBc6rxgm4sBgD9082OTZDX2HEftLfKMdcLDCNSzUu
         ZTCA==
X-Forwarded-Encrypted: i=1; AJvYcCV5uqYgL7ZCBxLMQgwZs88CV0025wgwMCPjQKJSu4DYY9xNTElYGH+fNrLq2DqnDo2KTnQzZGEDmLSisrJe4sUeqQ==@vger.kernel.org, AJvYcCVf8z07ARkVdkLQvdQGVsMqnxoQUt5AbG2ay6CoDNIsxNB98o/vTSll7MIqoFy84WAX0zfDWfdlIAo5Rdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLUsCJ7Y+mJCslXAcvXiwH0CzEQQk70iK3laXK3RWKbwdo7Trr
	DNmOhOI/tLOyvYuNsCBAxDMm5zxLzrtSiM/vtOl44PsWrIpM2J+0OO+k0qHe
X-Google-Smtp-Source: AGHT+IHykCcgK4aJNNKNvdAFv1h9ABJXIoFYs3GKThGyLFnKO4iF6iu/5Jamog06OJrlLDTnBeykOA==
X-Received: by 2002:a17:90a:fe94:b0:2d3:b9bb:5575 with SMTP id 98e67ed59e1d1-2d646d30147mr5997946a91.29.1724517207694;
        Sat, 24 Aug 2024 09:33:27 -0700 (PDT)
Received: from localhost.localdomain (104-58-203-241.lightspeed.sntcca.sbcglobal.net. [104.58.203.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613941ee7sm6376216a91.24.2024.08.24.09.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 09:33:27 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 3/8] perf trace: Pass the richer 'struct syscall_arg' pointer to trace__btf_scnprintf()
Date: Sun, 25 Aug 2024 00:33:17 +0800
Message-ID: <20240824163322.60796-4-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240824163322.60796-1-howardchu95@gmail.com>
References: <20240824163322.60796-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since we'll need it later in the current patch series and we can get the
syscall_arg_fmt from syscall_arg->fmt.

Based-on-a-patch-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/Zsd8vqCrTh5h69rp@x1
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c26eab196623..43b1f63415b4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -990,9 +990,11 @@ static size_t btf_enum_scnprintf(const struct btf_type *type, struct btf *btf, c
 	return 0;
 }
 
-static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg_fmt *arg_fmt, char *bf,
+static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg *arg, char *bf,
 				   size_t size, int val, char *type)
 {
+	struct syscall_arg_fmt *arg_fmt = arg->fmt;
+
 	if (trace->btf == NULL)
 		return 0;
 
@@ -1012,7 +1014,7 @@ static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg_fmt *
 }
 
 #else // HAVE_LIBBPF_SUPPORT
-static size_t trace__btf_scnprintf(struct trace *trace __maybe_unused, struct syscall_arg_fmt *arg_fmt __maybe_unused,
+static size_t trace__btf_scnprintf(struct trace *trace __maybe_unused, struct syscall_arg *arg __maybe_unused,
 				   char *bf __maybe_unused, size_t size __maybe_unused, int val __maybe_unused,
 				   char *type __maybe_unused)
 {
@@ -2261,7 +2263,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			if (trace->show_arg_names)
 				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
-			btf_printed = trace__btf_scnprintf(trace, &sc->arg_fmt[arg.idx], bf + printed,
+			btf_printed = trace__btf_scnprintf(trace, &arg, bf + printed,
 							   size - printed, val, field->type);
 			if (btf_printed) {
 				printed += btf_printed;
@@ -2964,7 +2966,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		if (trace->show_arg_names)
 			printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
-		btf_printed = trace__btf_scnprintf(trace, arg, bf + printed, size - printed, val, field->type);
+		btf_printed = trace__btf_scnprintf(trace, &syscall_arg, bf + printed, size - printed, val, field->type);
 		if (btf_printed) {
 			printed += btf_printed;
 			continue;
-- 
2.45.2

