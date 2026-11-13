Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606611;
	b=A8XoK8A7d477m2nTX/RWIR6CZNJ7s9d1dEUj4qMt2UGkBJ8t39xtG3VHDKp0Kh3SJcId
	 f5b11/otaeGQXrv29dYjAfDvA7gQc+zDqIFiLJj18QkmlmpN/S8I+c9Alc6/19jO5BdZT
	 fAsYaSOUo/9J3zLya15IMX/lzEO+MStso+cg1oqilJqQ2p4RSjycAd38wcBDS67Ag/yFs
	 xDiilvhnqyZ7TKmbHk5DJEEcMi2Dg9MaQrFxMmmu9zoinjR59HfzFPXvu10LYnSPr3JOh
	 xlLXCNvjn6GrVxrNWmNP+jgGIkLfC9bsTt4jMxqU4FgxM6miRs9QHeNE4hnNIgjy6XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=bXogm2TJduwpsZYvgZveO8MsbB/2neyvTtGG+82aO2o=;
	b=E91HqVzhBVIXQLZjV5YMeMNTmnrljD4KRGqAorXx2cDQfGOORS8pUlxDANXKfTAHwIOc
	 Da+tHoMwZfrcRrz/PYF7LVHspavyqbjUzIR9WaX1OmCEBbm+bod/mr9h9BNj70/7twOCW
	 J6zvtIeF40cR7klUSEVoMtmTRbs29okPuRNJ53R10tHZgFFwDZdyoDC6YQ7pHrhttXLbs
	 5R2q7MDKUfsici7f/lgywF1dE3Z1GUUwfPa+CiTj3Mpx+Dt8YJCinCs4A0O1xEndJLGJ+
	 Mxo6LSF/2ys21kjMcwG0EVJzbKAX9d4/NgSKVEzhLGDuz8OdCN9qTsP0sUDJNYWmooA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hxblArbZ;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F3B60A6F77
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09F3B60A6F77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hxblArbZ
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1b3b63b9665so603639c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794606610; x=1795211410; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bXogm2TJduwpsZYvgZveO8MsbB/2neyvTtGG+82aO2o=;
        b=hxblArbZkamRvUy9Lm9faZJ+YH8WQcW0JyIEbPfjDaTUyWqsflPbGU/vhsVrwhIzjd
         70lwgtDImkCzN4NWOEgjJ+mtGrMR/n1cqYOAnLP0Xc7FOEpmHO6YqILrRV16zHDAj81m
         Avry3cxPDNtBrtgS5kUvGGJ3fa5fyA5RduyOFnAJIj1o9pNOJ4AceYvHT7NA/VmDt3S0
         vL5YHmEEX6LAfzeuzNbMDEdLVZmM7KZHFlDoyBVrrUlHcQWK6To2JzNA7dBxmlW8KxS5
         NoqyldSAuyvesfcrie685lPZ6/LwZgKJB6xF1W5PVd6EPqKvyet2vMghst0yCcim0F7d
         voKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606610; x=1795211410;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bXogm2TJduwpsZYvgZveO8MsbB/2neyvTtGG+82aO2o=;
        b=tIpMGTpA7TITt7y4+YiDG23PGeQqI9oq6dmIt4Z8CLXrt8YotI6FBFVF381ZQOTLb0
         uapcttcu+ldBIr6hDKYT2fSOGKjQaxJrOoRzKlJy6yceeWXcyl2j5KAApEciSK+rckDA
         wBBj0LQUc9i0DyMK48xn/9nnYQRtWMufHRE/wph0nwUCpEfSU85adfHjabYCZgCEyS5s
         JIRKIhk5UZ9AKPmJDBEnYcp9uQeWwJqcGpXcyrsly4+4Y1o66/uUnHC5mwejakQ9mh6r
         AwdwPaSV5h29SSqeWJHdSWOrLPiAuVMJ+2wHyi5mLtr7NlawjaA6tbNZ1OPe10lmB4rv
         sZ5w==
X-Forwarded-Encrypted: i=1; AL+hErEZx8Y/IJi6dC2Y05LV9MctmesGQlZPaoAYMvvXmPIoA/hRPF4r/XtT6ml72LigMh7DjoynpMlm/iVjdEwF4P0N@vger.kernel.org
X-Gm-Message-State: APuU4Z9c83lujbMqhbW7JK/8LVU/pjPMbgHpFZ0sjICk8l+BIuOmrrtE
	ZqLZRpQspg4fKfXnGGK/xa08zBg4R6+orcwrygpJhOtk0X0zDtbfrAFDQey8k7Tv9bOmlygG2b5
	frMfcG/T76A==
X-Received: from dybnj40.prod.google.com ([2002:a05:7300:d0a8:b0:36a:de0:d28a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7a12:b0:36c:dbac:705d
 with SMTP id 5a478bee46e88-37967506a76mr3300984eec.15.1794606609796; Fri, 13
 Nov 2026 13:50:09 -0800 (PST)
Date: Fri, 13 Nov 2026 13:48:46 -0800
In-Reply-To: <20261113214850.3329699-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113214850.3329699-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113214850.3329699-23-irogers@google.com>
Subject: [PATCH v1 22/26] perf annotate-data: Use generic hashmap for
 type_hist samples
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Convert type_hist::samples in util/annotate-data.{c,h} and
ui/browsers/annotate-data.c to
DECLARE_HASHMAP(type_hist_map, int, struct type_hist_entry *).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate-data.c | 10 +++++-----
 tools/perf/util/annotate-data.h |  5 ++++-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 2332d465f975..dabbbb34fcd8 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -2059,12 +2059,12 @@ static int alloc_data_type_histograms(struct annotated_data_type *adt, int nr_en
 static void delete_data_type_histograms(struct annotated_data_type *adt)
 {
 	for (int i = 0; i < adt->nr_histograms; i++) {
-		struct hashmap *map = &adt->histograms[i].samples;
-		struct hashmap_entry *pos, *tmp;
-		size_t bkt;
+		struct type_hist_map *map = &adt->histograms[i].samples;
+		int offset;
+		struct type_hist_entry *entry;
 
-		hashmap__for_each_entry_safe(map, pos, tmp, bkt)
-			free(pos->pvalue);
+		hashmap__for_each_safe(map, offset, entry)
+			free(entry);
 		hashmap__clear(map);
 	}
 
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 184262c73562..b5b780d26004 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -8,6 +8,7 @@
 #include <linux/types.h>
 #include "dwarf-regs.h"
 #include "annotate.h"
+#include "hashmap.h"
 
 #ifdef HAVE_LIBDW_SUPPORT
 #include "debuginfo.h"
@@ -81,6 +82,8 @@ struct type_hist_entry {
 	u64 period;
 };
 
+DECLARE_HASHMAP(type_hist_map, int, struct type_hist_entry *);
+
 /**
  * struct type_hist - Type histogram for each event
  * @nr_samples: Total number of samples in this data type
@@ -90,7 +93,7 @@ struct type_hist_entry {
 struct type_hist {
 	u64			nr_samples;
 	u64			period;
-	struct hashmap		samples;
+	struct type_hist_map	samples;
 };
 
 /**
-- 
2.56.1.703.gf848ed807c-goog

