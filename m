Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3C916EB65
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Aug 2024 07:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725087873; cv=none; b=HkEt0pJ9tEm18Uj0xlToxzE/JC8132bWLGzHGuEcjo4Waj04DVR2qNLFDZaL+fT35RbtNlGP8yFCpqIevAYvwVhdub8lxjttolJ63S+l+/Xs/7321mmRfTt9TeOl2XKuUNIHbnuYncBtBGjUvWskgOqFzMG7PxcMTo9HNW7D9gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725087873; c=relaxed/simple;
	bh=QDLVJmTj2vf/hVHdQ6L7zR2dfVNf7BD0kyHNVViDvMk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=o7OBsIXm8ui02IQKNy5aR74LP/45iDpSNeCFGW5mbmK64eoydodUbRzv/dlt4PnlXrhG0XE5mzRrWzCT92FpUhTt9UF46VwigHM12mZx5W3OJUoDLedkKzOXvJ0Z8n5qd3LalThj7gV28J9W+47IDB/HSLRxu3qQFLbJwiFJ9hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JXNSD1do; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JXNSD1do"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d3aa5a6715so34151657b3.2
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Aug 2024 00:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725087871; x=1725692671; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xXQyzsuqXOgxY2EbjHgMehvTpafBAnrj6hlvtmn8jRc=;
        b=JXNSD1dopHI4p5aDw/kHAi7TmVzq1hYeETV2LLQTWUm3K8p8glR7NHCfaqEySAlMYE
         TNxtKFAAn169PGi+Xp8Gy0uAnvMxYDRWeWxmGA77raHh/gjA8w4nX8x+0e9r5ix4K2OY
         vQSB4fRRWkVAtS2+jU4xhsoUJZM8++PdOBXiYVUis8Ay2XDMdYjBqsnUocXoVXDaPxRJ
         e8O/cKhrPPoeEGVmu66SBUPRqAwug/Nxreh0gnRKi+t7cXa2MX/QOzwLFaNnYvsarCwi
         Tu6JnMjvDNEaZ8vC8aZK7/kRDYuWHascjiZGHFv5/I8RSck5izIYQDVONLvwhWTIMlUE
         gAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725087871; x=1725692671;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXQyzsuqXOgxY2EbjHgMehvTpafBAnrj6hlvtmn8jRc=;
        b=EwRcNNzA2mSeMHbYFMnO60xKNG2txzqMof3CHjKuwAgIt91OGjnPL5Ehz0ztryckPO
         LzbDpZXgfnU0AOVqLkUTdkkx2y2tQLhY/CEWKmYXPgHR8STaRinTxnOdrQVNuv/AHi/h
         WLeQ9GfF2SIvcGHYnMfpBTUc3C9JAsgIj6c9k4jkATHa6sDUHO0qBJmLDXAIPQ+4fg7q
         xIhaRT+SaO0agBZ9u/1RuJWjXTW26+uLFSdzec1y2dyuaObnzW6mGgD1ANN1QEdecgo1
         zNPqsi45t3Fo9bo5j38gsQHAFgvNjHbrSP5Rj6ABGJOPRjLP6k+wMmqqixjuLwMnCE0U
         a3Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUP5Uyf0nH25pCPx0pF4Lk/FYECMNzihc1iXafSvA5FQIvzjIlp1FFmlk3OfWwsXwqjfNANnsDryEQphV1Rlh/o@vger.kernel.org
X-Gm-Message-State: AOJu0YwuQ0FNJQxHFEon52OsEXuFB5CEEv3xmbNDLbGrx4yUSZfgrg7B
	zRdaeV6zbT08dKaJt768GToDSzP5VlrkY46wkcYpcppqx4BJNs/BvWet9AtJLU6QSqH9SAfmTWn
	CcyrugQ==
X-Google-Smtp-Source: AGHT+IH/XwkINJDTLYatGH3+bylUfIVzyT/ephgeuedK4Ucm3QSS0qZ7j1RoXIYjjyGAVuio2MJSg+p7XQQa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4974:82ff:2f9:edb6])
 (user=irogers job=sendgmr) by 2002:a05:690c:6d8b:b0:6be:9d4a:f097 with SMTP
 id 00721157ae682-6d40fc1ee69mr1994767b3.7.1725087870719; Sat, 31 Aug 2024
 00:04:30 -0700 (PDT)
Date: Sat, 31 Aug 2024 00:04:11 -0700
In-Reply-To: <20240831070415.506194-1-irogers@google.com>
Message-Id: <20240831070415.506194-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240831070415.506194-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 2/6] perf time-utils: Fix 32-bit nsec parsing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Junhao He <hejunhao3@huawei.com>, 
	David Ahern <dsa@cumulusnetworks.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The "time utils" test fails in 32-bit builds:
```
...
parse_nsec_time("18446744073.709551615")
Failed. ptime 4294967295709551615 expected 18446744073709551615
...
```

Switch strtoul to strtoull as an unsigned long in 32-bit build isn't
64-bits.

Fixes: c284d669a20d ("perf tools: Move parse_nsec_time to time-utils.c")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/time-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 302443921681..1b91ccd4d523 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -20,7 +20,7 @@ int parse_nsec_time(const char *str, u64 *ptime)
 	u64 time_sec, time_nsec;
 	char *end;
 
-	time_sec = strtoul(str, &end, 10);
+	time_sec = strtoull(str, &end, 10);
 	if (*end != '.' && *end != '\0')
 		return -1;
 
@@ -38,7 +38,7 @@ int parse_nsec_time(const char *str, u64 *ptime)
 		for (i = strlen(nsec_buf); i < 9; i++)
 			nsec_buf[i] = '0';
 
-		time_nsec = strtoul(nsec_buf, &end, 10);
+		time_nsec = strtoull(nsec_buf, &end, 10);
 		if (*end != '\0')
 			return -1;
 	} else
-- 
2.46.0.469.g59c65b2a67-goog

