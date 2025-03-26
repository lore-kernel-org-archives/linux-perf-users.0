Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE71CD1F;
	Wed, 26 Mar 2025 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019545; cv=none; b=MLxLRuGYxeAHYEK/6xuguq9RfL1NJNjVibgUEatU/+bEA+ZUyT7XKGWeG+RVSHY9rmUUceFccW1mqPcyHHSDpgqt95djNSuBcymXeq2TmtVo2DQWwt7TAZh0Vp7g7sGwFCF4n3YtJKIzxupjSfT1VCNDh8dBnR8+krHjjkVoBG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019545; c=relaxed/simple;
	bh=Tp8TYn0mV7M/QWlVU95VVsFS3f7UNapeMbx15BnhD9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mnjH8qI2BkaN6VdRKekOEr07bjNFfSlXxSgUT++DH3pOo1aR/jHV0zz06ZV+Opgh+qv4kd1yBBN6cDNXZfIN9PuSlPrz1lidRTJs33DUkurn7l5jv/XwwoWH7dVrWX3ri6HVS4xSN67//9knOZfm3MR80Ui/6L8CQvck8OOJPeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYFEsLGZ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYFEsLGZ"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-301a4d5156aso301951a91.1;
        Wed, 26 Mar 2025 13:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743019543; x=1743624343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wekaFXozH/xTjkxbxya4R1dR1xNm9i58joPEnBeQtZo=;
        b=ZYFEsLGZI0O840PvhxbVan7mQ+WATqbxXvawdC1SLvHa9bzou053YxSiFPP3iZ5+E6
         SJrs9+0PiJx++Mzm842FeU9Tx1JrrD/RoJ76KNheN3scd6u0qgAvgFE0w9FujBfPBZjT
         GxYhs2C4NfjBjml+N55OU4gN8125DRLNm+dGWxDYv5U9qgs6BI+U4Q78PKujexKhe0oZ
         Qcp+H3p02E1JBg+QqD2pw0KOohv5+6g/oHOxcetIraYYD1pLlSwsi6V5osFs5nRmDvqu
         WkcwQDBaQ5gcoiS39SxRcnWC9fpyUFNwMD+bdNmb8KJGBIbFJqKqK/ZFMphg48OInCt8
         6Hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743019543; x=1743624343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wekaFXozH/xTjkxbxya4R1dR1xNm9i58joPEnBeQtZo=;
        b=Nlhe2J77mrNRS3P0n2pbDlj3rOhAtUux581oK7AmyDNAfZR4E24jPirua1oOhorLXp
         optdoghNnp+SSsWf0BSGl8r4kAWOqn1Z8u9c3pf5ALxyCC8yo0ZCW3M15+5ZASHi0uk2
         vN442HwRd8xXIPaPOovxsO1Toqmk+vE3LL3w/h2dcDV/fFvEEY22iAz0nNmyQwDIpo8y
         LNw3X5WWXFqpFwCrcxLu7T9027DdQh6xM+ue7uzitdQSDd61t6LDgmtV/5sbOmLD5ELX
         43sDf57hUvGl98Gu+JPjBbO9Yx/GgQndXvxNlbTm/19Ra5EQiQ4KH08GAGvFcuwA70Y8
         ZdCA==
X-Forwarded-Encrypted: i=1; AJvYcCURwaARrilCWKUwIlSwJ4ETRx42vj+aSaqX4k3eIwmRKOt9+lnxfCBjd4KrMH0L5RRcg6ngmd2oW3U/Bho=@vger.kernel.org, AJvYcCVxQiHmPvfrNAErv/a1IPN84dr7IMcelym7bPLpHYKJmhif4KYSAlC1D0HaRusqcyg84z9q4fHFKKi6WvA36Ja1Qg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDGpbwrDrNKNuztKJuCX2XgX8Zek5aCPXkADqYVPAr2b4y83Ba
	hBhHCEiz6wnG1vGAHFneRd+OM58uPa8ExSfMJc+dBfa1TNZL/S09
X-Gm-Gg: ASbGncsiRA2rM4UAaXUyPgDbmo4S3eB6QYCTjA2nNRgmfcZkCgsK1BMB/JQcpvizQe+
	Hg12l2B00d0UlyszKqOiftc4BWUnF42+IXDRpCqwQdxewRvP0U+o9l3Q+kBH9NElEYHYluEyLPM
	upvxP8EauDbBV/Caxptfnrb8xSnlGlVKIDjGrhbbQPVubmYrGbU6QrOKrrbRo+gSdbKjB/r56ky
	QWLDUnjTd2bOdkiTTwD0bsAJvxWrTMKuiMekz9oyR/XEOaYZ48t/9tmjhgjOWSXKJUrcuKePfqx
	DS/ktlpotpdqI5Omt81W0fGBIkKwLwnC062d7Iasg8q2i7as3Egstb+f5cY/4FyDsrPXXjM80Jm
	B9x4nAL3PSbmeJqo=
X-Google-Smtp-Source: AGHT+IFnvmU7SfmhfjxId0+ilwna5QvKEeejGBCf9J1FZR4W7CIoU467YXfRK1Zqx4BwyXYqUKDdMw==
X-Received: by 2002:a17:90b:1b03:b0:2ff:6608:78e2 with SMTP id 98e67ed59e1d1-303a7f69751mr1407909a91.16.1743019543350;
        Wed, 26 Mar 2025 13:05:43 -0700 (PDT)
Received: from howard.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811baee4sm113997925ad.135.2025.03.26.13.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 13:05:43 -0700 (PDT)
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
Subject: [PATCH v2] perf trace: Fix possible insufficient allocation of argument formats
Date: Wed, 26 Mar 2025 13:05:40 -0700
Message-ID: <20250326200540.1843856-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
* Simplify the code (written by Namhyung)

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
---
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

