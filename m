Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92AB155C83;
	Thu, 27 Mar 2025 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743088040; cv=none; b=c4HUW9VbOT5aJ0LacaoT2KICSCtiw7OH3jZcX9uaqvYbE/cxzaKCpDKRBSkYzqu6H+4hquxSYtv6InPlgCVH5WfyqnsWSco+apVTRoBsH5k7J+Z6BisYrSN30FXfkW0HZZQTWy8ziVTll0GCavjVz2/n7tJwrwo7JGK865y9Hk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743088040; c=relaxed/simple;
	bh=IGOlgbMnyFjkmCr7mrACZlNpeHBjA6HM1S444NLVEa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FUxsTIWgHcA+97W/msfKRGAHdHs9qrinLt9qI+BWDdAsp7M42c90aw6TK62DILjnmTiBD4uGrR+Hv9Cx4v5IIbHDWDqBg2M5idcqiXb3+ld2d97La6OS+QVUjfgMn2OPXwL7Ae/67A81qbTZ+sQ481PiDKT1WffSy58eiFlktGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntCX2k47; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntCX2k47"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22401f4d35aso26633015ad.2;
        Thu, 27 Mar 2025 08:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743088038; x=1743692838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QSnBFPCz6EJRCbgAs1hUwvMtKdYF2dHvHQTAU0FhBus=;
        b=ntCX2k476oVP0dkVEFl6ftmw6mEnHZudai6WekoJOUtZvNRLVUUHXwEApHKiyIwMLi
         OAmHjRvJA07jHpQdoxWq0ApOex1+QM2JT0Rd4Y2hMpz338hVPeGr2dLG5qRBGK1b0RQ7
         8Hgi/cZl3/DKUaI/ToAGBZ7g79wLO3y7U+svgH9tHFXGHF0phfOALdetaMXeNhix7J5z
         Jti4gAaIu92GkQy0xH4H64xa4KazgbNCP+p1Y+dKMiCETMHLBR1GXEWv0LCgEvXnzSnJ
         w+5INFCKLYSAeZ7a7UvlHMZF947vUtSKYcD8InZdYhdLfYhGErqOjJGIZVz1ZKM/pb1s
         hS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743088038; x=1743692838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSnBFPCz6EJRCbgAs1hUwvMtKdYF2dHvHQTAU0FhBus=;
        b=JWnQXcUvSgPHKQdXyg68NGGRNEgeOPBRJAVTJFluQn5ahLuc/DsMVIyMFvUKtdif0d
         LmOyLXCuJWCvpHc/v+i5uPD6kAL+xC+NZkHJ4Q0jw2EfizcRQumtWzOD0j3OJYB/slq3
         hh8S2JpGBI1gu2HQ0zYIYLVJpZvQ1fsaOjxrYe3f/oGVS+3w6MVU+OAUltEEUQiI6Ghf
         yh6HFzL3kgsosC2J6PV+4RSvsYoHl02h+TL6hb4/JU+spd9HhdSVkfz8Pj/Rs/5iQ1Rr
         eRNIN7PQ7qkKl8szbPl1zfDOanTRHv/x1dDmTZqR2tF/ov8Cd5nfzDPap/opqGLc+Gl9
         MWSA==
X-Forwarded-Encrypted: i=1; AJvYcCX41kzbJQ1uDwOK2wS1dvTFERn/KCxi/QKOShWHXhJA3lBfxlfj1gFY0FnCpDzSf2Ekl87O7UyWT1eWuCYChYeyXQ==@vger.kernel.org, AJvYcCXoc3z3kzcPQkqI+Jr/qVrQYTtztZMlc1dTBHXrQDlcJstjma8j+vFCQJZtoObTRFg9ijjKwUaqOqFUeOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRV+GrghVGZxuytiXOyBrlmXm20+1dJAdRPfAdwPTtabfKjwEJ
	bgm2m+tQItiCqGYS0E79nuTQS5zHrt7GWR3Q8rUvQUs0kBt8FxGp
X-Gm-Gg: ASbGncuppzc5in7hY/FKr3ZAh1kZ461Cy2X/I1ai9CKlufSQWLa5wFPON4AjvaTcBDh
	mMoLP0xc0/HLK6NN6ptVASXWosnBnbGJ8EpyRKJkf6f36cy9qbfVJ2W60+ZROTbQlSVM1Ulyhfl
	+KEy7zQLk6Ry7p2O6TZpFGJFsOPFo6eRRPfOk3n8bH65qdjgjmeTYL/TR/tpMV5X54Ir+EBx5B4
	pgwRHUQIgyXD4Vk6ntDxCM0FJZrGQC4UCcUAIIQELOhcLIBgNP34ShfBfdwoN2ZAZfSmAXMHsSz
	E8buL1/TD+YZNKb+Vqv9yqf30bEpruFgSYyWWMKy1Gv19nf8P7RLOV5VV/P+37/WHkVzXuKICyf
	K/JLF
X-Google-Smtp-Source: AGHT+IHQoplcEatDuFtcOhE2bWxxvWKhWtII0JknPc4UIIl7hdymWZ+PnM1/9vGYGnqb7EbmmsAikg==
X-Received: by 2002:a17:903:1988:b0:223:325c:89f6 with SMTP id d9443c01a7336-2280488be77mr58686565ad.10.1743088037862;
        Thu, 27 Mar 2025 08:07:17 -0700 (PDT)
Received: from howard.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eedea0asm670635ad.73.2025.03.27.08.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 08:07:17 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v4] perf trace: Fix possible insufficient allocation of argument formats
Date: Thu, 27 Mar 2025 08:07:12 -0700
Message-ID: <20250327150712.1966188-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In my previous fix of runtime error(Link:
https://lore.kernel.org/linux-perf-users/20250122025519.361873-1-howardchu95@gmail.com/),
I made a mistake of decrementing one unconditionally, regardless of
whether an extra 'syscall_nr' or 'nr' field was present in
libtraceevent's tp_format. This may cause perf trace to allocate one
fewer arg_fmt entry than needed for the accurate representation of syscall
arguments.

This patch corrects the mistake by checking the presence of'syscall_nr' or
'nr', and adjusting the length of arg_fmt[] accordingly.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Fixes: c7b87ce0dd10 ("perf trace: Fix runtime error of index out of bounds")

Changes in v4:
- Make the patch apply

Changes in v3:
- Add 'Fixes:' tag

Changes in v2:
- Simplify the code (written by Namhyung)

 tools/perf/builtin-trace.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a102748bd0c9..439e152186da 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2022,9 +2022,6 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 {
 	int idx;
 
-	if (nr_args == RAW_SYSCALL_ARGS_NUM && sc->fmt && sc->fmt->nr_args != 0)
-		nr_args = sc->fmt->nr_args;
-
 	sc->arg_fmt = calloc(nr_args, sizeof(*sc->arg_fmt));
 	if (sc->arg_fmt == NULL)
 		return -1;
@@ -2034,7 +2031,6 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 			sc->arg_fmt[idx] = sc->fmt->arg[idx];
 	}
 
-	sc->nr_args = nr_args;
 	return 0;
 }
 
@@ -2176,14 +2172,9 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
 		return err;
 	}
 
-	/*
-	 * The tracepoint format contains __syscall_nr field, so it's one more
-	 * than the actual number of syscall arguments.
-	 */
-	if (syscall__alloc_arg_fmts(sc, sc->tp_format->format.nr_fields - 1))
-		return -ENOMEM;
-
 	sc->args = sc->tp_format->format.fields;
+	sc->nr_args = sc->tp_format->format.nr_fields;
+
 	/*
 	 * We need to check and discard the first variable '__syscall_nr'
 	 * or 'nr' that mean the syscall number. It is needless here.
@@ -2194,6 +2185,9 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
 		--sc->nr_args;
 	}
 
+	if (syscall__alloc_arg_fmts(sc, sc->nr_args))
+		return -ENOMEM;
+
 	sc->is_exit = !strcmp(name, "exit_group") || !strcmp(name, "exit");
 	sc->is_open = !strcmp(name, "open") || !strcmp(name, "openat");
 
-- 
2.45.2

