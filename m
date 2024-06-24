Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EAA1A0B0B;
	Mon, 24 Jun 2024 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252750; cv=none; b=EqQHS330ko06Bltsg3s1ux+I1wKUpyBvDJlpL/5dOfANo+eCbf7LvK6PkRKodUnaGP5bneY9UhG3uiaR3xIzre0tNST4pPbzIHLmMg6mLsmS1RAE9w/oLSO3uMNhMdVwd6HQN/w7wUrtqmER4nRaNsW7gA37Nl8TXdeqWak/wG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252750; c=relaxed/simple;
	bh=6SvLqQ8BVTrymv0byu609zcNrlDV5T3Dd4CiIEbFlKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbEdBmaVXiB0IC8Amy96ru527+bDxeIFDMLIgpDl/iOudqMeTYEVpjLGCHd04E3+cZWbXASAHgNgFBb5k/GeLD2wmRJsEUscxhsWHMcJ8tpctP9hFRdRq3vuinNpo0BAyN7iaZWwaPNQZOpnJQD/iCJdnImYkZ7lHcDVi4zI3dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4DFyIr+; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4DFyIr+"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7066c9741fbso2103641b3a.2;
        Mon, 24 Jun 2024 11:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719252748; x=1719857548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBlEtFWNbneWkV72zI7ZiSnn9Yk8ev161SjlFI7hFnw=;
        b=m4DFyIr+dmuZaB6WCnWrI9OKfbVMYRm2nB+EMkQUmEjohq7rjtJrA+5+xMHP9OoXCD
         snSWNmEV6PW5S7Y0NtUqg96PoszlZpHS0QzhOQ7A8tVijmt9bZ7Qup+2AribqVVO9Tqj
         WVFhn24nlnXslTBnF3IACsNaJ7pEpylhenoPWSzeGjFcRsyUUlNw7Ckq3Bo88Dhn/zLu
         OxzS52tjf5O9YMrzHPnp5PZY3lHzxsWz2+Bj/CbW5lQjUGqJkJLXhOHEOFARuQUqTLfu
         tALb+rB2vT8UqERHWmPFsOtbngyiRrrgmjJpFiKUejT2OQz9teQKl3roTDkkPqGK6ZLo
         wUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719252748; x=1719857548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBlEtFWNbneWkV72zI7ZiSnn9Yk8ev161SjlFI7hFnw=;
        b=ZMt9jyHbnuoL26YR36zUtH7uPSzNDVQSBULUTPjPm47v4HqXOnYjUEcgYFE9wEdq+H
         DIS25bAO43xKQHLHqH7XzhkfVseyo1NszeDyIZ336SQu2tz3ywRpc5Zo7vAeHTCvJE2s
         4g+YXiW6Yd3rCFwG+sQn6qP5CQMluJZzABtZX55XZYUl9Y+7Ywx29DGfUvGBCmg+joE5
         dW3QFuZGjmc0P4uOqve9qOtCk1YVz0o1ZTJbzxkAVeS9FU72vR7T6pHT4A8itftrOoB3
         FEOL+VlGJvoQO2oU84Pc2aQdHDIXdpVJln5S08VXJgL1Xvo+Ec9O5sPqgA9yIo9Yz8gg
         qK6g==
X-Forwarded-Encrypted: i=1; AJvYcCUiuXj/LP3YaP4Wr2G81mdosfCXuFgVsOixTnUQsiha/BAt6uyuY1IiAbWNWQVsqwbySi8z0jfRspEWTEE6qd+7HtayH99MSxtXstWWJfjTycjrzyX0ilKbssvccZytpERqXjsohbpmD2uSqB4tRQ==
X-Gm-Message-State: AOJu0YwX5iisc2IdYDiAcnkmWd0QFpnl8PywNrJtkFjxBgy8RzwJ/xCd
	gu5fB5tJbyOll1hrlAeq5lju/qBWRf4d3p3lq5dqnCdIdJIncws+
X-Google-Smtp-Source: AGHT+IE7aO+UNyRQ8Mlmr1H89eHe3Fxo/iVlosUglKc48zwcmGJsyaTzmDafFXrk6scO1J6jJRhxjA==
X-Received: by 2002:a05:6a20:a502:b0:1bd:d53:5feb with SMTP id adf61e73a8af0-1bd0d5361e7mr2486902637.46.1719252748524;
        Mon, 24 Jun 2024 11:12:28 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651290157sm6525157b3a.150.2024.06.24.11.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 11:12:28 -0700 (PDT)
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
Subject: [PATCH v3 7/8] perf trace: Introduce trace__btf_scnprintf()
Date: Tue, 25 Jun 2024 02:13:44 +0800
Message-ID: <20240624181345.124764-8-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624181345.124764-1-howardchu95@gmail.com>
References: <20240624181345.124764-1-howardchu95@gmail.com>
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

Tested-by: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c | 49 +++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 774bb3534df4..1dd8b839e502 100644
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

