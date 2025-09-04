Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2593F1D63C2
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007876; cv=none; b=T/71m7VX7kBHTvS9oOyynlaU6potbE83C5LtsRYgbMnDmpUujBvxdG4JLRfZqBB9ikfxDP6zMqLTcjNrApwSw05+OA2G8O85L8UQy7WGXnz+W8WneAZd04MdwYctxBQZv/3PFP89Oblt+jTAt+QzfKReLsgDWINldB8Mh/c1Cos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007876; c=relaxed/simple;
	bh=ZKzsIufUEOLeYnMN7PYlDNwg4uU1BvyvUUSfm9lDFjU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=fq/DaiV66q0pyTEw/M/TlEWk06OkaVu+x03l0GBZrSJlvk2hcFFrYEZcPrrOIRpgmt6mlu71uzurWJcKxVuQl/qMLbKDjMIuNj6ydemM2aZWwtJDXE9t+QH/25z5E3EWeF/o4uj90K9zvaKH05eqZVhZlu5CaEnlxl/bEYXk3WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S0rytNIE; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S0rytNIE"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24458345f5dso16642935ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Sep 2025 10:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757007874; x=1757612674; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SOoQFcA4C0PZlP5Wo7OwHrsZwmtLMnPursiG/Sfczk4=;
        b=S0rytNIEyhOkJoZsS/0i5XJMmj5Mab9T31BPVIYDjN5YnynbQRj3CFKknOaxVecj39
         vXY/kOh+oH98KScsn+BNPzqSvpFbqhlOQLtpWASNd9udZ9PbFiQJuM230/bZEgmsp6oD
         C0qkwUZrE7P1ijte28e74/SinrwXrOh0NfDHA2XsALKzRoH1UqIoEWMq+M15z2zcV31j
         6WY59dtv1FviAA13u5rjw/bg+Ws+J/qQVoRQKvYZyzbGtDveaY6M0tMBahFqoA7VCp+h
         HHkUTvVyp1wQVAk40rnf6V9Nu/z6iEbQo4euOngCREhHQjlt78IdXrzJ1e1LKrt14K2G
         fP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757007874; x=1757612674;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SOoQFcA4C0PZlP5Wo7OwHrsZwmtLMnPursiG/Sfczk4=;
        b=oImhlXVrwU5TzvpG/+OdymFLqBaqaKCHMSQIx4VeYdKikUkTbuwygWkydher8fBzRn
         JeeqZjWM0aCTDemrFcRebEaKfSeEn8JZIu/k3I1l/HT3sslNSHhFas02Yt61tVUgQMGF
         kljJR3PyGJzbQYBjcxjICsVxCybuzkc8kVTZzG5hDk7+JkY5sceavcjrTK/YuL0tzDF6
         lM8k3DvMR9b8oGXyLmmQYB1X9j0OxVE//UClQG574YELRBKBuq6ICN2NynRZnMzqMJch
         ahyzFIaME3ELpVSm2D8kBOEfMbwv7CHSmM4ViRaY24M/Q/H6sSOy2kKrXfaxuTYbw8Rw
         Gtug==
X-Forwarded-Encrypted: i=1; AJvYcCUAIXor0tMgFE1bKtKrkxygX5y5i3aubhqxTVsYrXGz5PniWi5Oe53wHlvHG5WB/XHDyQ1gq6lUXgng3OGZTeEh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Dczw26+C5N72omZhaAReiiUsbCOe37gadD/iZCeOp5hfh7YN
	4she+gp5802CoM/MkqvyJTQnNNLOuuTqjd6MIaL135YEwNYdyFXsh0uyTadh9dZchBz+hTKC499
	vqAsqAmdXrA==
X-Google-Smtp-Source: AGHT+IFBb2psCKNN3slDyaKnws/ctZgf2KF+t0qeMf9cQfM42rspz0lcgrWIBbhcy6T/3Y7uhLSj3aTC2/8J
X-Received: from plsu2.prod.google.com ([2002:a17:902:bf42:b0:246:39b5:1d8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c407:b0:24c:7b94:2f53
 with SMTP id d9443c01a7336-24c7b9432d6mr117093795ad.6.1757007874447; Thu, 04
 Sep 2025 10:44:34 -0700 (PDT)
Date: Thu,  4 Sep 2025 10:44:30 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250904174430.1414548-1-irogers@google.com>
Subject: [PATCH v1] perf build: Revert "enable -fno-strict-aliasing"
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"

This reverts commit 55a18d2f3ff7 ("perf build: enable
-fno-strict-aliasing"). With (get|put)_unaligned_* using memcpy
-fno-strict-aliasing is no longer necessary as memcpys are assumed to
possibly alias.

Signed-off-by: Ian Rogers <irogers@google.com>
---
This patch needs:
https://lore.kernel.org/lkml/20250722215754.672330-1-irogers@google.com/
which have been merged into the tip timers/vdso branch.
---
 tools/perf/Makefile.config | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5a5832ee7b53..306b8334b788 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -19,10 +19,6 @@ detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
 CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 
-# This is required because the kernel is built with this and some of the code
-# borrowed from kernel headers depends on it, e.g. put_unaligned_*().
-CFLAGS += -fno-strict-aliasing
-
 # Enabled Wthread-safety analysis for clang builds.
 ifeq ($(CC_NO_CLANG), 0)
   CFLAGS += -Wthread-safety
-- 
2.51.0.355.g5224444f11-goog

