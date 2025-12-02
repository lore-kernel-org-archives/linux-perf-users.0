Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEC82BEC32
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764694459; cv=none; b=rZQg3o1XVW7cQCwICFAwObC1aZCZq4w0XnCWarXtH+ZkcBHd0LJ5ctbyBxsc1O+8jBApvV0MV50O9pUMT2VchDkFTv8CRVFa6s1KD4S1MizEoJ5lxXD6mjyzfAofMfCmULx8NVhVCaXWHm6i6ZPQDz3rSc0OCZC22QNfBW1Npgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764694459; c=relaxed/simple;
	bh=VI0GyMMxy3O+yJq3v1uLzntMjHgy0SJw5oOUn61I5oA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oV+ejz2HpOz3YTJMdObHNj1XYmnb3sEjOQVKcq5eM9T767UT+xmwZVjKvRT/dTuSw8GE2G2U3V2BGuk3/rqDeOIrSORYtr8czydFPzrrApPACP7l5hZgjUFUrFVGfhLiCs2BghF3abQNhEinVeQ0oR0WOadVduoZO2q+5UA0K/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ua/JBmMl; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ua/JBmMl"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7a998ab7f87so7230405b3a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 08:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764694457; x=1765299257; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//zG+uyduWbKze2xSYMEcHXG7k+w6DsLU62rH0LbWTc=;
        b=ua/JBmMly+dc0TXOBnLZFBTa24iCTAdJCPX2O7DGFZnmsAx97yKk518LT0zOQ8yjZd
         xxnCelnRYukriaDhnj7klDJcv4YEaEBWYbYnXS5NlW740lx1cb4Zf7X4VHzyHkf8/qAF
         jB0Ls1n2nfOgyB/eoSpQwsVpmHbsSzi7NMj8eqcSKNsLcyZTCptIgRG2G+8mxH2li6OK
         0sdoT7ebMp5F+DSuF9she5svdg6xLF0A50k3uzQdT2gTEbGYdFHd/mvBD2fMKETFaipy
         qBsX4oGB3xPhyr0bES689oT9wFpAn2BXjxQMOLgIV3QL+2VjJHIao+kXVoDWJEwYTTCD
         hHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764694457; x=1765299257;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=//zG+uyduWbKze2xSYMEcHXG7k+w6DsLU62rH0LbWTc=;
        b=FV0l31Lm2KoWwMXlXLfMOZoGJsAFf3Ot+ZBsE5HR4Ps2Brt4Ozy24AC5y4Ttiiv2hm
         oHboEEVEYLsZixsYNW0s9YUMSy2nVA0/erJJ/NTWbXc3/Te5R2aPHdiVO0i7yJKCW1cN
         ZoqWYSoSDQVBtBsfjFUeXuC08+tXRNBNR5sRwPegfzFn0y0MYFxKCf6VNZJWdWC65Z4m
         LyPXtnIxUsIg+teIC0Q7/82ocafdnjTv7rgnl8yIZD0OKWcYvze8mCaFsFhwvwtpgmSG
         K2g9hPwtGocPLObaRXhlN4vkvtxAJqHhrNjp/Xsj5M2kvs42AP40a8yeCCYbA0KAANgu
         qiPg==
X-Forwarded-Encrypted: i=1; AJvYcCVpTuvg/tR4gM5FVgoUR1LEeB1NHpcXAUpQMVVskNsSLywxYxsts2TIfs1uWgw5TCKIIfpUKA1e6KQzCQN4up6M@vger.kernel.org
X-Gm-Message-State: AOJu0YwiodVnKtDyJ204TVTkcqEG9CXBeidfz7zpJ3nakfp9D2HZEahc
	Zs7A+jkO8d1DZCu5qhAT7d07EEq2Xph7e5V2H09yZaLj1Qu2vpILq1M6mOENxkBUcAp14K5ffDM
	IVNqCySdfOQ==
X-Google-Smtp-Source: AGHT+IE59R0z3aFxdmOz0hOZsQmPYUqXD9eggtC02wC7FKLUptV7HqpPCrBW88y1M5jwCvYoua6QMQC8KnIK
X-Received: from pglq7.prod.google.com ([2002:a63:5047:0:b0:bc2:ca9e:4d40])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3396:b0:253:1e04:4e8
 with SMTP id adf61e73a8af0-3614ee77995mr45689047637.56.1764694456928; Tue, 02
 Dec 2025 08:54:16 -0800 (PST)
Date: Tue,  2 Dec 2025 08:53:36 -0800
In-Reply-To: <20251202165340.555375-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202165340.555375-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202165340.555375-6-irogers@google.com>
Subject: [PATCH v1 5/9] perf vendor events intel: Update icelakex events from
 1.28 to 1.30
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The updated events were published in:
https://github.com/intel/perfmon/commit/dc6ffee20c74bfd21d7a7e338345578d4b7=
ca9ca

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json | 4 ++--
 tools/perf/pmu-events/arch/x86/mapfile.csv                | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json b/to=
ols/perf/pmu-events/arch/x86/icelakex/uncore-cache.json
index 6f84ad47276d..1c225192ba34 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json
@@ -6050,7 +6050,7 @@
         "EventName": "UNC_CHA_SNOOP_RESP.RSPIFWD",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts when a a transaction with the opcode =
type RspIFwd Snoop Response was received which indicates a remote caching a=
gent forwarded the data and the requesting agent is able to acquire the dat=
a in E (Exclusive) or M (modified) states.  This is commonly returned with =
RFO (the Read for Ownership issued before a write) transactions.  The snoop=
 could have either been to a cacheline in the M,E,F (Modified, Exclusive or=
 Forward)  states.",
+        "PublicDescription": "Counts when a transaction with the opcode ty=
pe RspIFwd Snoop Response was received which indicates a remote caching age=
nt forwarded the data and the requesting agent is able to acquire the data =
in E (Exclusive) or M (modified) states.  This is commonly returned with RF=
O (the Read for Ownership issued before a write) transactions.  The snoop c=
ould have either been to a cacheline in the M,E,F (Modified, Exclusive or F=
orward)  states.",
         "UMask": "0x4",
         "Unit": "CHA"
     },
@@ -6072,7 +6072,7 @@
         "EventName": "UNC_CHA_SNOOP_RESP.RSPSFWD",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "Counts when a a transaction with the opcode =
type RspSFwd Snoop Response was received which indicates a remote caching a=
gent forwarded the data but held on to its current copy.  This is common fo=
r data and code reads that hit in a remote socket in E (Exclusive) or F (Fo=
rward) state.",
+        "PublicDescription": "Counts when a transaction with the opcode ty=
pe RspSFwd Snoop Response was received which indicates a remote caching age=
nt forwarded the data but held on to its current copy.  This is common for =
data and code reads that hit in a remote socket in E (Exclusive) or F (Forw=
ard) state.",
         "UMask": "0x8",
         "Unit": "CHA"
     },
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 521718b0d4e0..946471c4d4b7 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -17,7 +17,7 @@ GenuineIntel-6-A[DE],v1.16,graniterapids,core
 GenuineIntel-6-(3C|45|46),v36,haswell,core
 GenuineIntel-6-3F,v29,haswellx,core
 GenuineIntel-6-7[DE],v1.24,icelake,core
-GenuineIntel-6-6[AC],v1.28,icelakex,core
+GenuineIntel-6-6[AC],v1.30,icelakex,core
 GenuineIntel-6-3A,v24,ivybridge,core
 GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
--=20
2.52.0.158.g65b55ccf14-goog

