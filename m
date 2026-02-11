Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD922C11CD
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Feb 2026 01:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770774772; cv=none; b=tPvB5DcoV+oXZCa83S47IYcjsc5nW+2f3r0zkBls3bxLQ9RX8P5vKt+5PPzzzoU6JdeakXsVOMzrCJGqgSLkhXCIcWoT7iTRnx8E3XHxjuSaD4QRWtHLRukxaUPhrGEeMlGx2udyppbgRx9J6n0/4WXkIurkmxIax+BPQdAqVeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770774772; c=relaxed/simple;
	bh=uNTfHUocnOftuWBq+9ueR5iUH5fQ6qeUFnzVqSchyQ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HqqXiK/08T5/i6nybLp/bLTgkuN+MLUupa0CWSvPMzRenwN5mtGf8Re5aPNVQ7Hy7Di++fiXo19urz38teedSAWPRFtyhHegdXin2BOhI7y0YAydTzlq14heNaoVj3+S/KOWQtleRX/bWJb6e/OEqAfH0E+R0X8b/Af6SqPCT5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1oHHICut; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1oHHICut"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b7a28264c1so4383805eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 17:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770774771; x=1771379571; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uakCkLkxLsaDSQ+N9t+mbyUNrdUax4weIJC3dBUXFoo=;
        b=1oHHICutUtiMru0r/vmHdhqSUGK6qM3lOXvuKYODq4JWnPawsRRzoBWeIkkomEldJ3
         5xyvFUVd7OH4HgA4X9nIxDrRFghUXJ43oGDcC8+QNGPJVxOS5R1HUPGnBVgMyl0rDvHp
         TOIcXXzGZAdu7208SSk1nyOMuM9AxmWj3uvldsZAd/W9swvH1ec14AcyxOLbd8IX6QGh
         dL4IhWZGE8N0oh73NYK6frgaJj1HfG37qw3j3JcR/nMYzKiF1qcIAPTTGFoB38oDzw//
         MO/VcYNlPW7l1ApIxyrHGQXqA9x7aUEvLgFU8o0harUdk4l2DgavhpjSFsXEJL7QwFeY
         3vwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770774771; x=1771379571;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uakCkLkxLsaDSQ+N9t+mbyUNrdUax4weIJC3dBUXFoo=;
        b=Hq7trsXJlbhF5fu6uBf7qsRwWdbajh2njgpZqv/QcJwyFdrh6ouOW1HOA9HOWbZ4Xe
         BBfy9I3tL89qnf9+pRM3VryMceKWUoXOszpKHnCuDNvEUoEoGw3PZ3SilJQuXHtkw05N
         TSrb3DeEzwzpAKX64hNMBEn9M9gfMMGVdQOXIKmayt2bxOySemezF2JhM0S2rcI9MobK
         EG4TqiZ3SglE06ror167KFTAVCagzirz2ZNNSItOjSVkh3vSgGSQ96DADeZaGyKVQpun
         FkNqovWcOVUQYvjPPUV4j4L/hojzXjyhE6YX/266LBHtnYlefCQVgAQyY8iKm/xMTjx8
         Mh7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlBpV7o4TMfpUfbd6tIWpC2zpA4hVIrmZ4o3gjkbi6wKuU0miRrvZOJmMhFKSLlh+9m3s1wJOxCjr+Zl2oZDdp@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp7fCVbg3d2OFyCBQzSuEaD38X6fZ6R6HpnaNNUnoviFRGDVkQ
	7XiV7bQtuPgLSVmL11E/z1hDGSAhSZ9TXHDKz0yiW5GhrnZIvrLzcGvldtx6cNcG6c3/pKaoIk+
	c6EN5gwJWJg==
X-Received: from dlbdt17.prod.google.com ([2002:a05:7022:2591:b0:124:9fac:9425])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ba9:b0:11a:c8f4:3216
 with SMTP id a92af1059eb24-127298460d0mr342243c88.15.1770774770658; Tue, 10
 Feb 2026 17:52:50 -0800 (PST)
Date: Tue, 10 Feb 2026 17:52:38 -0800
In-Reply-To: <20260211015242.2700218-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260211015242.2700218-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260211015242.2700218-2-irogers@google.com>
Subject: [PATCH v1 1/5] perf check: Add libbabeltrace to the listed features
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Derek Foreman <derek.foreman@collabora.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This enables scripts to more easily determine if `perf data --to-ctf`
is supported.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 27a41beeaddf..3641d263b345 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -43,6 +43,7 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("dwarf_getlocations", HAVE_LIBDW_SUPPORT),
 	FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
 	FEATURE_STATUS_TIP("libbfd", HAVE_LIBBFD_SUPPORT, "Deprecated, license incompatibility, use BUILD_NONDISTRO=1 and install binutils-dev[el]"),
+	FEATURE_STATUS("libbabeltrace", HAVE_LIBBABELTRACE_SUPPORT),
 	FEATURE_STATUS("libbpf-strings", HAVE_LIBBPF_STRINGS_SUPPORT),
 	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
 	FEATURE_STATUS("libdw-dwarf-unwind", HAVE_LIBDW_SUPPORT),
-- 
2.53.0.239.g8d8fc8a987-goog

