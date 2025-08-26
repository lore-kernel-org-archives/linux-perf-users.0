Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF52E2F3C35;
	Tue, 26 Aug 2025 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756195702; cv=none; b=bTVrejok8/J2/vkSJU7FT2EpT5qtHw/2kYop3rxFgcVmIGPXMk5t6V3cC+t87ALnxTeaxWo3osLQzKNhUmOJQ1BrN9ql3t9osdvXnjSAHulgLm8qFJpT4jeo9EnY3KY32fA5B1FpsmCj4mC6m5n+TP8jlTO8kQKWdZRtm5eE2Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756195702; c=relaxed/simple;
	bh=7+5r1zYFOphbK0Dba01TqfpC9JdzjFYrrWWFnT6mSGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P9Trnf/C8/9a7CZJoeufjovKgE0+7oKCgPzo85L/lSWXpOMLz18Y364RNcYJZm8UjHqwjmWLSvTiniIS6irFVWa9ieWBddZXUONYbgswDs74wlvk+CvbQyWfXWdSvHftYk0f5SUZ8Nnrx6Stz7UWPTPwLRf+V5fjl0RX1EhgkvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYY9lPiT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYY9lPiT"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a286135c8so31610585e9.0;
        Tue, 26 Aug 2025 01:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756195699; x=1756800499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x+cliAhH1nZQCponEjjB0FBBU7QtumwgLuFSUngTqvc=;
        b=UYY9lPiTma23r6sEpvktDI10r4OlevCya9uTLWzopSZL08i4Js8hD+m9M67IaRIKjz
         j5+7ZusRfaSWUL5EHHENGvgejhrzox+x7rYELUHcabU1LkyludkWcOhbmH5gc3kegCsp
         awDbY2TcwmoToyHNx0zCJK9oy97jkdUJ7lyto7OskxaKtK8qQIXglt5e+srYm/lhhZjV
         I49knzWURfKbJlZAh58L5Z7Uw4QHd/i8ztjFe0D/go5m/zI78NQzgzs4uYM+j9sYxYi4
         1OJ9Hw9lXPSllVuU4yOS1LxOyvHDPxHqXon+CVuUGCLfzKwTKQ7wRSy3XoDfhxT/AjBU
         w7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756195699; x=1756800499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+cliAhH1nZQCponEjjB0FBBU7QtumwgLuFSUngTqvc=;
        b=lv24ZOB7bomcmR7/zbF1tXRcRuzOabECP6rNr88OtZIMqTAerp0tjrNpFWAykduVVE
         AQaOtSw38OBaisqgbGkFVNgkfsQXLqI0FL7hGzL3BuYpiAEn+6d7NEsdF5w55Wo9Ce+c
         bcH/lDo53yUm9pKqLCXZXqIophrCd/4WoSjVVJFgCht3JFuzkJJr6TDelszIPaWTUQ5h
         jhGycGGco6+L0INgUzQZwtZjSi/5TASt8uxq5XQ7fCflSJOAmxhjPembtpmPhuyecSW9
         QZzWdzsFy0lpxrLhev3yw/BDIk2u3eUTYDiJElF4mwrgefiNkl4ojyQ/U3coVR0GoLfk
         kwEg==
X-Forwarded-Encrypted: i=1; AJvYcCXkqKwBQbLZiI1Gd3WQ7NfwD1V9kR0dn4mUWTr56Io7xeenDl85f/rQPtMujG3OY0sOpmYtQHC2ttO+3qU=@vger.kernel.org
X-Gm-Message-State: AOJu0YydKwX5cnhDhQuLN0sj53+ZxKoYo8LqfoD/gJfgvDnAdf8pUfup
	/2FD3/C9xOjB7ccmMw51aRHj9sF+xlAw0uWR+5+N9qrtwTSbsOlPrEbx
X-Gm-Gg: ASbGncubSIb0FS73qGFzmEoaLIzFZRE/50XZaMhK0sloRsj49ncbDvKiMGWldtGAd3+
	4m38u6DjNrgyzmdWW6ssYA/X1WshysS1RuwqjpDjeUjQ1UuQEfcJIh8pljFZFGUvZpnKKbUltnI
	YQpe12prWir9COOoHgdkq49GqWxF6b2lIImLc6GUWJTR6kihGQMBlQcCKOf48IiCfHf63yjyjbC
	oPlmlPkdGlSQUs0T2ARp6IcZqk5fpmp7frcCESFCIkWJ51zswmTeva+CJvBxfpzgnk/kT8re4GC
	6ViGDEffe8g1voeHL+XNg/gWdwAOTd76SgEu8lzpCyjeVVuApqVlBwtbfGAHSvTwPi07Por0pqj
	pCFvsTzWmAkkTiivG53tskJ5h6wb4EctxV3gGLmXP0po=
X-Google-Smtp-Source: AGHT+IGsMNs0mTJBoU7Sof2X26cuy4xcAwnxlGxjKnf+0KhijelhrT/mE+bhJrgXkTLmY4Z+P3SL8Q==
X-Received: by 2002:a05:600c:c09c:b0:459:dd1d:2ee0 with SMTP id 5b1f17b1804b1-45b68d29f47mr2521465e9.0.1756195699054;
        Tue, 26 Aug 2025 01:08:19 -0700 (PDT)
Received: from acer-Nitro-AN515-58.. ([156.210.11.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b575928b0sm138595665e9.24.2025.08.26.01.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 01:08:18 -0700 (PDT)
From: Ahmed Atef El-Emary <ahmed.software.engineer1@gmail.com>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	ahmed.software.engineer1@gmail.com
Subject: [PATCH] perf trace: Use consistent print_opts formatting in trace__fprintf_callchain()
Date: Tue, 26 Aug 2025 11:08:11 +0300
Message-ID: <20250826080811.27650-1-ahmed.software.engineer1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trace__fprintf_callchain() previously omitted IP and symoffset from its
print_opts, unlike other callchain printers in perf. This resulted in
less detailed and inconsistent callchain output.

Add EVSEL__PRINT_IP and EVSEL__PRINT_SYMOFFSET to make the output more
consistent and informative. The callchain output now includes IP, symbol
offset, DSO, and falls back to the raw address when no symbol is found,
matching the detail level of other perf callchain outputs.

Signed-off-by: Ahmed Atef El-Emary <ahmed.software.engineer1@gmail.com>
---
 tools/perf/builtin-trace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index fe737b3ac6e6..20f3488d4a21 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2892,8 +2892,10 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
 {
 	/* TODO: user-configurable print_opts */
 	const unsigned int print_opts = EVSEL__PRINT_SYM |
-				        EVSEL__PRINT_DSO |
-				        EVSEL__PRINT_UNKNOWN_AS_ADDR;
+				EVSEL__PRINT_DSO |
+				EVSEL__PRINT_UNKNOWN_AS_ADDR |
+				EVSEL__PRINT_IP |
+				EVSEL__PRINT_SYMOFFSET;
 
 	return sample__fprintf_callchain(sample, 38, print_opts, get_tls_callchain_cursor(), symbol_conf.bt_stop_list, trace->output);
 }
-- 
2.43.0
