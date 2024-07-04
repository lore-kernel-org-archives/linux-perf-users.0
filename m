Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C391AED27;
	Thu,  4 Jul 2024 12:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097068; cv=none; b=Gm/s7kCcfjZAL0s9D3SR37CZkcCnrMnSbntvR4FQIhw6/CwOEnFDecQWKwQgnfikQ+CxrLLe+t+aShHeHxkAdfYMmMwhJkq4oCotsFWynGenMnPc5KN9tkg4uhj5mv+Mg2jy+TwScstLqGbmqzjvuHBmXZhhtARQGgeC8OJw03o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097068; c=relaxed/simple;
	bh=/EDhtoZGuMjUrPv+ooBwV8B0wduikxo/o9z3vV4TzHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SK0CNSOytjfonWWxM0F+2UymNLHtypmuxL1gtM0rUZd0PG0FoG9107+/9f20Yvud0KbylgKdm57ns8ZsqzVVFWY+fJSXrGfbpfy/rPj9PZo8j/EqbS2dhntP4Nxw2m/g2nMUoEm4inblk8y5/lqR9k6XS7ubOZqSh/CdH1sdd74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+EYktf/; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+EYktf/"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-71871d5e087so363863a12.1;
        Thu, 04 Jul 2024 05:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720097065; x=1720701865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLeFXsSxx3g+J1fD+mwT7HmIZf3vVjDYwcLJ5dlu1g4=;
        b=P+EYktf/dAA/KsRstci9D8Pk1jM6+tzWNEUNmqaxjFE3WL3kDsZ3WnTgE2WG/LRJzG
         uZfcjnqExOT8dYH3WdoqYLADVEXg/chvJPp2Ak6ZbyLQzTN9bUIJBdQf2PSKb2vwH5iT
         yL8pco1JlsjgSlxTqpuD6DeIFIrr3mdUyYNRm0MU3A/ofYpByn0KcMbcjG6J1b86Vn+9
         f7L8IfdY3C/I8bIIdvXHb5KAY2EZMjYHVbByviMde3e3xT9MlEpw4tlvmRfyfYjQ5Bzm
         U/miNPLUkuVKjQ67zHaZF1fs42aPoe89NeSdA79TfRShSoHVeL4ZsBOuKbthwz3bdKKc
         dyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720097065; x=1720701865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLeFXsSxx3g+J1fD+mwT7HmIZf3vVjDYwcLJ5dlu1g4=;
        b=SQf5CZg1eXGLfquZDCrst9zs92WJvW3CylRXanIjxYku2/YMscg5/IJHopET4r1RX2
         qdptN/YAA56AeivQcFQqedsN3VtdEYe6SDz7mLO4JwRWpGhwZshy99CV3MthGqrucp47
         LsiQoNS3Paw83D30IJOknbVhQcdm78Vv1gmgF8tSn+Vto8WDEuDhca3i7m7VL1QghfCR
         QhdEF1bifqQQuMPzn8H4p1e1OyDDIbF18+R2jFv8hLtKp/5NtXiM78BxLwJD/0ZYy7HT
         v6T4Ts890GDqWCGhdpogIZXwTTicXU19vUcJ2pFYKGeQMeMDZrp1yzeqmDVNNVBoL80F
         Q1/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+rcIidPJQm0bEK44A3udR3B7J5sfiUNbOI66f12DQ/ZjsBAu+yq3sRDUwyD4Nbh2hACXtXgON1tCdUJgbeigdy4siiXRaQZrLRUE9ytsoJLzPzyDvaIX8MEtoI4xV0Bl2724xzyXAF90op4lw3w==
X-Gm-Message-State: AOJu0YwXwoP349NwFu55Fc3mFeEngHpKZbCRvHPb0QCTeA1bEgh1IGl9
	9HQda1UBOfIkhH/vk3R3fMo/9tZK7zo/+a7bGDAmMaNN4r9ggdq2
X-Google-Smtp-Source: AGHT+IF1wQK+EIYXuJjTq6zI2ckz5T4RsUsZRVQG8MhPcu8EHiz3RNjJnmIeWWDdnuLtvz4+KK5Bow==
X-Received: by 2002:a05:6a20:9189:b0:1be:4c54:b891 with SMTP id adf61e73a8af0-1c0cc8ba7d8mr1327606637.47.1720097064869;
        Thu, 04 Jul 2024 05:44:24 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1598d35sm121578245ad.285.2024.07.04.05.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 05:44:24 -0700 (PDT)
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
Subject: [PATCH v4 7/8] perf trace: Introduce trace__btf_scnprintf()
Date: Thu,  4 Jul 2024 20:43:53 +0800
Message-ID: <20240704124354.904540-8-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704124354.904540-1-howardchu95@gmail.com>
References: <20240704124354.904540-1-howardchu95@gmail.com>
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

