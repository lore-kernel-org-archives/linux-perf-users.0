Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7DD14AD02;
	Fri,  5 Jul 2024 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720185669; cv=none; b=PFpoRv1nNuzQBS3zNE0O5nXS0TnHglXYlpjkuzNbTfe2k+lwpN4WwpVYewFmJVbDLax5P6LSDacwhXE/Wsg94K2MPv97HdK5n0YLvsnM38Lbp8v1/LpeAJKIq15AqLqbe5TwfXlqoKNC6h2CYf6OHiZE8yIcB7I0OVf4lLwM/Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720185669; c=relaxed/simple;
	bh=zpCwz5WJUp6bdiwz/dL0kF9VkHkjT2zu8ODJeCDRUY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIvSFHS7Pakz+erpCyJNanwRxKoPqyVoanilT73LsQ/M1X6zKakHadoPNLH7s6VcWrxcDNl5wmF4aZ/ltHXrZzUcTC3a7Mg6ftHbpWaRgM6CLomPyiSFFv/M1tfnY5vGh4eX127/hgQ6Ev8UMv/NbrWui17ZB2C//OFCwAKbO3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwWumbAH; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwWumbAH"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70af81e8439so1311380b3a.0;
        Fri, 05 Jul 2024 06:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720185667; x=1720790467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76lmvuOrrkN7Lw4Dwyrz4F1r/Om3MtfOcN897FaxN6s=;
        b=dwWumbAHIyXCXnVSk33efi8Qd0vtaKfxLjkwu4BwZpe6b1QYd+rJDVcncmNiysDxcA
         lkKscxGQWjpYjhgZfVwApamksG7POb+lP4qznV8nOISstKi1dbPpi+915FFJXqU4Rupv
         ckoPLZvVhwAvYyOsSi6tK9HOOvhUYntTfl1POuIQlHIInDYJfq0S/wLv2MklWEdMGNWB
         2pfEzk/kLtEPHheUohz23jYv1jgACOZUnWM0j5IxQBaCjRGUFBUngkTR9l0SM3GQwiRH
         a2rCRbJwWof7lj/0xnWi6cP/iheK6sTbtmDplr+MAmwU/kaq7JUfyMkucyDBbfjjBEL7
         /sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720185667; x=1720790467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76lmvuOrrkN7Lw4Dwyrz4F1r/Om3MtfOcN897FaxN6s=;
        b=KEKk1tY0NHy3KRDkwnm+Ch+VVGrDOu+fsKR0EM9345CDJuPVpJQQAH7dPB8BsrHnlM
         oomgalMnPcZnKnkbW139hUb4atWljgV0Pq2ofEdggcHPQ6+fXYqvmwnXx/br3KWbJaDW
         0UMZVip2A1nNcp65kEmHg1JCCaUAzDn+oZmtuToMEhiiQQWJFimz3RqFKEWuiWH4LSiM
         9Ld51sWnjsdDoF6o0DwbaBFaAsGJY0Cno7WxmMS/GPrkknzG5CGYWM17PGQsjBabIrlj
         eBqtS/FY4AcJ6bL522PKokoSl9RirG5P4muKvpqm2RHJDRVLip7NG0EgGi3qEFIKST3D
         nCxw==
X-Forwarded-Encrypted: i=1; AJvYcCWTBnYgnM9k2tNKL8bXhGOSyYtOND+OYjGBu8gDE20a8gLVPBDeXnMmPPcJLG0q9wHimWUHuwqo36ZWjDlDzYxpFHD4IMdZeR/N3gHBI0O35itrhwJJpukB62VOyYgaERY35S/KmUSM2wmAJjaZfg==
X-Gm-Message-State: AOJu0YwdzPiRv9MJ3ccGSFasqQ6DQt60FEG8icJvSG8J+w1Kx7R51iHL
	myO84zAsEGRQVzgOxxQ0VqCVf9RjN3iz40E9GFW1J32Ad9wRJWdP
X-Google-Smtp-Source: AGHT+IEB6MiJIWg/3vtnd3mzfEGIIo3aQFfdb4zuRiYUlsPJi1TzicVIl2F06wIj+9Vtq+gqplsKXA==
X-Received: by 2002:a05:6a20:2d10:b0:1be:c057:ea12 with SMTP id adf61e73a8af0-1c0cc73de03mr5236512637.14.1720185667372;
        Fri, 05 Jul 2024 06:21:07 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a956260sm3328974a91.19.2024.07.05.06.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 06:21:07 -0700 (PDT)
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
Date: Fri,  5 Jul 2024 21:20:57 +0800
Message-ID: <20240705132059.853205-8-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705132059.853205-1-howardchu95@gmail.com>
References: <20240705132059.853205-1-howardchu95@gmail.com>
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

