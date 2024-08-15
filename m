Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222D33A1CD;
	Thu, 15 Aug 2024 01:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723685822; cv=none; b=e0IhZ/ez3PiLUt7KjejSNnhaG3pSvzSkJF0EzFvK2u8hn1nPUtpGAiLH41R9VzYT0hLMvWAKuVHVk+TgQStbPFqVxHBpn/kgRwAAYDB30zJvwtRONCNk24vnCXT5/rj1VZJDHeWZmnb3BHuOzZ/GVDvHLYrFdPFrodoAIs2D++4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723685822; c=relaxed/simple;
	bh=spdqRIpnQvBqr8T0nyAuAU0TLakdE/R7ILit/w+FSb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKBqb3sf4ceZir8hyhxnd1WdxhgPaf9oYb3WTdPNtOjcvjp32dEQ4m2Npg68FnW7EZLuVWt2h7UWF6VRSiwqV4McP8fKquIB9P2+qbGcqaEEB0KUudOqA9aAdSVPFqSAwmo1luWU1o0b7IA2s+Wgi945sAfFYuwWGszS5LjEflc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWXNV3QR; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWXNV3QR"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3db16a98d16so270651b6e.0;
        Wed, 14 Aug 2024 18:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723685820; x=1724290620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhld+BZizC8iaT2hIGG5ij4d1wS1wRfTndkD3JiwI/U=;
        b=UWXNV3QRwm8xrJ2FXWkL6hJx1uYdvW044gXNeuUuJ0l7YLOEBegGUNSVCyXJ0ajqnI
         Cem7LvrGI3t9zoks5ZWGvP/93yVqdJ33ZwDEQUFsBQaIw0WqoHQzTXIkUH8T/uT/vFmr
         161ZPH4gBJukwNSU4Jhe8xHw/IaIKR5LNESc92MJsuYr7EJmncg8fr2Qdpn9GfNpelfA
         jHDczumAQZ2NkOXYZD+JxWHL2bg1anfsvzPECXHt83Mru1Qz67dl0TG10LQ7q7AiU9QJ
         qzQ2OTp4RypdtsDfRcXT2sZe4mgoQDs5K0aWtIunKDYpd5IOSX2ohk6yW3Jv4wDVt1dO
         2RFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723685820; x=1724290620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhld+BZizC8iaT2hIGG5ij4d1wS1wRfTndkD3JiwI/U=;
        b=tBDCxFsLRAK0S9xCsdkINfJV2+eURqbHwajnCPMsRgsoY1MksNZYPdEHPgONbwToUc
         e2ks1Rfwf4YDgQyZC2g29wAnWCeEZCR1YndU8z1U5ROrnLqnxvYxkuX2hbV2t1rpBa0O
         hnLwMh1TUC1X8T2sKCo+ZDNWCLV0sNFqUItATUaLfAVjniQeAH4Ey25roFUqnGJt+qQc
         59DPcN3SHJMfCtN9uRkSCOPbItifrJaq3tmlXcBtDrSv441F/5B2fVXCgNwiPfw14+Po
         saBtPSAuXn9FM6RWdzgdM3eEcxjuwaUElmc7kpaCVy7750AmYUa+Lu+M1lPXDUezr/DZ
         qtNA==
X-Forwarded-Encrypted: i=1; AJvYcCXen/iI1qJa0scHklHqjfX1nLXWko6OjfCqtqbM9r/GkkF+HHvYNcLYj6JbH4tF0CIMpKr1/XsgQHzLrAv2uHS2K1qxjlQZ5EI0onA4STdn/+KsWlpE2vtbBSLHJymE9CXt1uLrSvqcA7KaHCRVMw==
X-Gm-Message-State: AOJu0YwQK1IuXU7AcoaBIWrIDcDmkpWewm3wgCUo3wEscQMSmT3D4BTP
	YPK609Nw/6TWjVo5gsh5DU1liuZaUqHVyMEodHk9IeZ2dOVsUMLQ
X-Google-Smtp-Source: AGHT+IEwMGq9EUkK5CrfBgpPAYU8se8hsLGns+yy5RhuGitVONPoXvgHMMMhf35YHS8RT+kPwizvXQ==
X-Received: by 2002:a05:6808:3845:b0:3dd:34d3:7108 with SMTP id 5614622812f47-3dd34d38344mr247931b6e.1.1723685820122;
        Wed, 14 Aug 2024 18:37:00 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef412bsm196842b3a.123.2024.08.14.18.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 18:36:59 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] perf trace: Pretty print struct data
Date: Thu, 15 Aug 2024 09:36:22 +0800
Message-ID: <20240815013626.935097-7-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240815013626.935097-1-howardchu95@gmail.com>
References: <20240815013626.935097-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use btf_dump API to pretty print augmented struct pointer.

set compact = true and skip_names = true, so that no newline character
and argument name are printed.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c | 51 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4bde40f91531..e7421128f589 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1006,6 +1006,55 @@ static size_t btf_enum_scnprintf(const struct btf_type *type, struct btf *btf, c
 	return 0;
 }
 
+#define DUMPSIZ 1024
+
+static void btf_dump_snprintf(void *ctx, const char *fmt, va_list args)
+{
+	char *str = ctx, new[DUMPSIZ];
+
+	vscnprintf(new, DUMPSIZ, fmt, args);
+
+	if (strlen(str) + strlen(new) < DUMPSIZ)
+		strncat(str, new, DUMPSIZ - strlen(str) - 1);
+}
+
+static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf, char *bf, size_t size, struct syscall_arg *arg, int type_id)
+{
+	char str[DUMPSIZ];
+	int dump_size;
+	int consumed;
+	struct btf_dump *btf_dump;
+	struct augmented_arg *augmented_arg = arg->augmented.args;
+
+	LIBBPF_OPTS(btf_dump_opts, dump_opts);
+	LIBBPF_OPTS(btf_dump_type_data_opts, dump_data_opts);
+
+	if (arg == NULL || arg->augmented.args == NULL)
+		return 0;
+
+	memset(str, 0, sizeof(str));
+
+	dump_data_opts.compact     = true;
+	dump_data_opts.skip_names  = true;
+
+	btf_dump = btf_dump__new(btf, btf_dump_snprintf, str, &dump_opts);
+	if (btf_dump == NULL)
+		return 0;
+
+	/* pretty print the struct data here */
+	dump_size = btf_dump__dump_type_data(btf_dump, type_id, arg->augmented.args->value, type->size, &dump_data_opts);
+	if (dump_size == 0)
+		return 0;
+
+	consumed = sizeof(*augmented_arg) + augmented_arg->size;
+	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
+	arg->augmented.size -= consumed;
+
+	btf_dump__free(btf_dump);
+
+	return scnprintf(bf, size, "%s", str);
+}
+
 static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg_fmt *arg_fmt, char *bf,
 				   size_t size, int val, struct syscall_arg *arg, char *type)
 {
@@ -1023,6 +1072,8 @@ static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg_fmt *
 
 	if (btf_is_enum(arg_fmt->type))
 		return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf, size, val);
+	else if (btf_is_struct(arg_fmt->type))
+		return btf_struct_scnprintf(arg_fmt->type, trace->btf, bf, size, arg, arg_fmt->type_id);
 
 	return 0;
 }
-- 
2.45.2

