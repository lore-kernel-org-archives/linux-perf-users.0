Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03BC391E4E
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489272; cv=none; b=WY8UMp3QcfHFSnqeBkeQ5BnCIomzd5O9NdDBVXCb+0rEEhoBKhF/sfFQb9lUssBFtY+I24BeKpwUYEbi4QQQUINY29g3s05X/yC4B8xMQzwvXKNngIzVLGvHcHN7ZCxZVKFOxVzQ2Mjz8AtCCz9q2vRN2fbjTRd31hKAxlQqmnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489272; c=relaxed/simple;
	bh=3S4dxZh/zV71iVJjK0YAfP3cyGCMxAVA2lJp1eqBEGM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MpZufxhelPj5F2c+uwt8ZJcLm5WGSGz/psanvbpDQjKLLoeH/CaYcrpYhislqWGwV3FGwaBZ78pMKkEuyU/OepGhlr2D9uKinPI6xc/ODuk01A4iCjDCPd7U+RXvT+0h2FWfOv0Sav2ZIGsv5dDAJGUGpDZyBdb6+yAC9BqSS98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PVhvp0cQ; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PVhvp0cQ"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1353ac304f3so11878195c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779489268; x=1780094068; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l2kO28M+YZNuE0ghx64qUE2dfp0eRAhsXViTCXkqCe0=;
        b=PVhvp0cQb9ixvVOQNPBNPgx9i4O6zW1bSw+epvv4TT979IaZXsVJk+gMLzP+6hYxs4
         9p4H30uEo6PUjtiFek7v4vkNTmXw9WmVpm24zWlHQaZGMlXQWD/SvvB4544pAFGstTQI
         MYmWGEW3bdiUfbeWSLjLy/gCWz/8r5Zvm44ITJJxbunCE/Zf70kUjka1WfwotHVmeuyP
         mMw24OSmai8qIGFWEmkL4R5u/iEbtkD6ErDUxZgVtf+8WEh6kBJab/tddapqPnToEc4a
         QTa7/TvGlwgv7hxg18VUUhpjGhVT3Nt6dR7A++KPm8CXlF6b61cSrjXCT5R6WPxon6Me
         Ml0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779489268; x=1780094068;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l2kO28M+YZNuE0ghx64qUE2dfp0eRAhsXViTCXkqCe0=;
        b=NvfIXH4e8w+looq3JrP2ymiWo5TYLe8cPKDJYL/1zSDPcXoWu9q0UIaReWk8bdQv36
         Lzlpyc+Gpp+BpPBB6Wu8efY9STAJUB9ee5eZpeMjj+pEacx+7G6X5tVK327PAKgngWKP
         ho+VAhaAaW1gATvoxv++xC7XSGTf8yCaLPur1vs9bV3eA7qdwk40b2S6Sv09ZBkmCVd8
         acAyrFGxceFmSyXJd/jLau0wxDn4+eM6o4/S87cTlyvwYY74ruZuZoRHiLfWMph/a62F
         SrPas9GCWTBBBzyMiiVg16ZOPU7jVRDiQ/tUH3ilAYpTO2JyJXOLx7QWVV73t+/3Ikuu
         IuXw==
X-Forwarded-Encrypted: i=1; AFNElJ9iS4F+f37Wz7gRbyLs+j5Q1hlKm33L5JdE8qkBZ/Ge9oEaVqq+vxYahJRGALFMp3oVImSxI0plQQ8OKAkuUvwJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0DU2Z1epANPVFh6SfOTw4VMhFsEkSp7xc5gbsqJl8CxNPe3XE
	qlEAE/ZDdGFGH7KDzm9XSNVFJ47vtm0XXoqSVU+IQFBqu9oFp6eYEdPfw1ssGSFrWZXEtgCHPUN
	hZCS1g0rkcA==
X-Received: from dlbef14.prod.google.com ([2002:a05:7022:f4e:b0:135:cc8b:4336])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ef01:b0:12d:d972:b969
 with SMTP id a92af1059eb24-1365fa45b6dmr1897947c88.24.1779489267423; Fri, 22
 May 2026 15:34:27 -0700 (PDT)
Date: Fri, 22 May 2026 15:33:40 -0700
In-Reply-To: <20260522223342.2393553-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522223342.2393553-13-irogers@google.com>
Subject: [RFC PATCH v1 12/14] perf stat: Extend JSON output linter to test
 advanced PMU and metric-only checks
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+json_output.sh to run
the advanced hardware PMU, topology-aware aggregation, and metric-only
JSON checks a second time under the --new print flag:

  - check_per_cache_instance
  - check_per_cluster
  - check_metric_only

This guarantees that JSON outputs produced by the decoupled streaming printing callbacks
are verified and structurally valid under advanced topology-aware modes and metric-only
JSON row-column layouts.

Signed-off-by: Ian Rogers <irogers@google.com>

TAG=agy
CONV=7c33d6a0-70a2-454a-82f7-4de2101a5b9c
---
 tools/perf/tests/shell/stat+json_output.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
index d35098aae093..3d513de0e6e7 100755
--- a/tools/perf/tests/shell/stat+json_output.sh
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -248,6 +248,12 @@ then
 	check_per_die
 	check_per_socket
 fi
+if [ $skip_test -ne 1 ]
+then
+	check_per_cache_instance
+	check_per_cluster
+fi
+check_metric_only
 
 cleanup
 exit 0
-- 
2.54.0.794.g4f17f83d09-goog

