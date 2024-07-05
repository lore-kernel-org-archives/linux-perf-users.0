Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA4C1494BA;
	Fri,  5 Jul 2024 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172604; cv=none; b=VdI8XAbbMJmwqou0ZbmdKl4DqN7H68B2btJVcSkCNF4xl6x92ZU7V9CZP3TBnPwNclU1cp2BxAdVCvACQ3cAHtALO8yAaxOahADQlUfwX663l7AecSA5fZLusxeaWK6K07bys6Jw+chQe9HIVSg4Ix2QeFUK7lFt2UpHaD/8B7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172604; c=relaxed/simple;
	bh=zpCwz5WJUp6bdiwz/dL0kF9VkHkjT2zu8ODJeCDRUY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAXDAba2/jYv9XQg7+TYR3GlPbuShUoSDK7lMji14wv4+hptHbG7MlKcdbCoX5/Q65ZHRfzPHHpmbiQtOHpOdUL5QQw84mus1M5R+Nv+RHjZF0vmPwdll0Xz47sy7mlyc+QJAiCJcmWxckU7WU5BOQfOhQRNLIJOK0BhjyqtTKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQTGHH3U; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQTGHH3U"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c964f5a037so959995a91.0;
        Fri, 05 Jul 2024 02:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720172603; x=1720777403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76lmvuOrrkN7Lw4Dwyrz4F1r/Om3MtfOcN897FaxN6s=;
        b=eQTGHH3UrN/SJBKvzw+twZUz3hWwGhJT2lg7Pn8bk5spzDQq33ZZ5zvBh2DIbsBzFq
         oFeL+GajoYSHv5sl+6DhNfDQ5x0XdNpUF1/0oEsrcaIpatkGzvJBXo5DGua6tCW1Kyh1
         YkkfGERmfQr4jRoPoPll4nWoDcNfbjOn7+lAjOrZGrnN+QrwADtTFzsMWXRGBBoHumeV
         VAqihnhQ/lWoFzvv7zA+vRTG7/MKduo55/Qks9a7i5VTakxo8K1XwXtN3yjNpcGBDXAH
         rHqUbTjLphQAYugfMiGUmvuNQBixCxBs3qiTWPdje9K80cs6O3p6mpMwv9DGGdQjeyXW
         F6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720172603; x=1720777403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76lmvuOrrkN7Lw4Dwyrz4F1r/Om3MtfOcN897FaxN6s=;
        b=E9AN6O/Ujj+3vAj/pDnzSHKleeNddUbEW11gUPRoFU1pJT4bp6BZoK90tzewTp3m5x
         70e4OALbBi4e3u3aw6/u6Wy6II76kM9YrkV2UPtq81oGe7lB+S3dHJesPG8zRSSf35Cc
         UpFHW94Dsf1GMyCwK5GGIAHPKRDAhydECjiAOZtgZHk1u487r0oNOHFJbakGNYG9WzSB
         mQJEf8h5j136LfvkTIBlxAigrTdniuLFDGn42CalWkuiTs2UeYAl7J0/6xAoGKWmFkzO
         UK64alKNzR0vtpIX+7aixbwrm6JBIB8uCTpc5EoBVdYsv9u/4RtuImdZMDqrEBBrJj+5
         pWew==
X-Forwarded-Encrypted: i=1; AJvYcCVynP0XawLB9/mvU05w26EpF0sVuOxNRUJca3YQvSWDUknHbXdU3CzuN2LDuKDEwk64FxkIv2f8ihPDGJlkCLVZXVHfxJBjgDtpV7R79qDFgAmMwbnV8mSwwg/M8lxkswOQICMvIuj5QEAKihpUdA==
X-Gm-Message-State: AOJu0Ywmw0OlxC5B+jCeaZzV03g0JDFCAUdbequllLzDUcD59zkalF5+
	bp0z8V5+5uj61jDKP6ukSzjNsu8GCOnWmFfsvD4zOMvntGvcLQj+
X-Google-Smtp-Source: AGHT+IGM+SSUEheCvBpqRiT5IPf8pd6w/1V9uU9akrVqeZwQfHfW/Wsau+7MUKFJp2qx0kuMemyhSA==
X-Received: by 2002:a17:90a:6007:b0:2c9:98bb:b9fb with SMTP id 98e67ed59e1d1-2c99c5418fbmr2894841a91.10.1720172602711;
        Fri, 05 Jul 2024 02:43:22 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a9cd133sm2958138a91.38.2024.07.05.02.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 02:43:22 -0700 (PDT)
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
Subject: [PATCH v5 7/8] perf trace: Introduce trace__btf_scnprintf()
Date: Fri,  5 Jul 2024 17:42:59 +0800
Message-ID: <20240705094300.585156-8-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705094300.585156-1-howardchu95@gmail.com>
References: <20240705094300.585156-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To have a central place that will look at the BTF type and call the
right scnprintf routine or return zero, meaning BTF pretty printing
isn't available or not implemented for a specific type.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Tested-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240624181345.124764-8-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 49 +++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e664001d5ed7..d9104fc4f61f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -981,18 +981,28 @@ static size_t btf_enum_scnprintf(const struct btf_type *type, struct btf *btf, c
 static size_t trace__btf_enum_scnprintf(struct trace *trace, struct syscall_arg_fmt *arg_fmt, char *bf,
 					size_t size, int val, char *type)
 {
-	if (trace->btf == NULL)
-		return 0;
-
 	if (syscall_arg_fmt__cache_btf_enum(arg_fmt, trace->btf, type) < 0)
 		return 0;
 
 	return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf, size, val);
 }
+
+static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg_fmt *arg_fmt, char *bf,
+				   size_t size, int val, char *type)
+{
+	if (trace->btf == NULL)
+		return 0;
+
+	if (arg_fmt->is_enum)
+		return trace__btf_enum_scnprintf(trace, arg_fmt, bf, size, val, type);
+
+	return 0;
+}
+
 #else // HAVE_LIBBPF_SUPPORT
-static size_t trace__btf_enum_scnprintf(struct trace *trace __maybe_unused, struct syscall_arg_fmt *arg_fmt __maybe_unused,
-					char *bf __maybe_unused, size_t size __maybe_unused, int val __maybe_unused,
-					char *type __maybe_unused)
+static size_t trace__btf_scnprintf(struct trace *trace __maybe_unused, struct syscall_arg_fmt *arg_fmt __maybe_unused,
+				   char *bf __maybe_unused, size_t size __maybe_unused, int val __maybe_unused,
+				   char *type __maybe_unused)
 {
 	return 0;
 }
@@ -2183,7 +2193,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 				      unsigned char *args, void *augmented_args, int augmented_args_size,
 				      struct trace *trace, struct thread *thread)
 {
-	size_t printed = 0;
+	size_t printed = 0, btf_printed;
 	unsigned long val;
 	u8 bit = 1;
 	struct syscall_arg arg = {
@@ -2237,13 +2247,11 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			if (trace->show_arg_names)
 				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
-			if (sc->arg_fmt[arg.idx].is_enum) {
-				size_t p = trace__btf_enum_scnprintf(trace, &sc->arg_fmt[arg.idx], bf + printed,
-								     size - printed, val, field->type);
-				if (p) {
-					printed += p;
-					continue;
-				}
+			btf_printed = trace__btf_scnprintf(trace, &sc->arg_fmt[arg.idx], bf + printed,
+							   size - printed, val, field->type);
+			if (btf_printed) {
+				printed += btf_printed;
+				continue;
 			}
 
 			printed += syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx],
@@ -2892,7 +2900,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 	size_t size = sizeof(bf);
 	struct tep_format_field *field = evsel->tp_format->format.fields;
 	struct syscall_arg_fmt *arg = __evsel__syscall_arg_fmt(evsel);
-	size_t printed = 0;
+	size_t printed = 0, btf_printed;
 	unsigned long val;
 	u8 bit = 1;
 	struct syscall_arg syscall_arg = {
@@ -2942,13 +2950,10 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		if (trace->show_arg_names)
 			printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
-		if (arg->is_enum) {
-			size_t p = trace__btf_enum_scnprintf(trace, arg, bf + printed,
-							     size - printed, val, field->type);
-			if (p) {
-				printed += p;
-				continue;
-			}
+		btf_printed = trace__btf_scnprintf(trace, arg, bf + printed, size - printed, val, field->type);
+		if (btf_printed) {
+			printed += btf_printed;
+			continue;
 		}
 
 		printed += syscall_arg_fmt__scnprintf_val(arg, bf + printed, size - printed, &syscall_arg, val);
-- 
2.45.2

