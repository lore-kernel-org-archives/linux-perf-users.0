Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38583783AC
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 01:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772069754; cv=none; b=W1Tj8OzwWOYg3cehtteEIhdxy5QAf1Kkgwe6YOpZKN5pMOHnrGVTTsb+B4afRzKi0u4B7jDdYBwzv47GXQbT3QyxV1ude+mAdnd5FEaccYpi5LGzCZ7e9I2DWSJRR0Ys+IoKUwRF317yTpKH5rWlA02Mw3d9Finqv4RvKuJDLGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772069754; c=relaxed/simple;
	bh=VUaPixiKYJ7ij/ivoa1XUmUMzaq9D4k53FRF1c4oKq8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=g2t4YmicxzZJmSqagQpjnV8PR/c1ES4JMjprQjpBgkLD15AAuvB3mutWoXcu2Rd76NfU/PTpRWJNt9c3rbWSy9uID1GXh5sHGZ1uMZmN0gPRDq5R5upatRc4ibv1s6L4hS9F5LLDS9rbIBzclqWpvtiToS4m/SkTV15l0pDHMJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K/pGZFmt; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K/pGZFmt"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1276e71652fso588765c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Feb 2026 17:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772069750; x=1772674550; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ci9RsZZzUOkXZUiVAS/DAziwtxPXHN+N0KfwxSaTa4=;
        b=K/pGZFmtgQtm01+vcJZmLER3iX9h+N9KPmO1ZrRS3YU7WVUBgNUdhbptwB/U6aOdEI
         yTKYX+cCViPWLbs/V53yJlxS8YB5e4fNiRxkbi7FQVuJICM7Cl43nCB7ouS5PjOVz0fk
         mpZg1HK3JcZU/mTRsYTaTNK+ye2xHbwCO9z75QEpLUlxsI5dIm7Gm41FcpG21rsmGd5J
         1WxSzB8UufURkADWKd8l0e0zLAMfDjBYDHQKMMkizA1zCvjXkKrIb56L3OaImOg/J0oV
         Fum5+A/s3iASBeVT0P2uNvPQBMRAppElhIYfFRD9SOKj2KJ3zFF52Z3U8r0J/BE7Xbn2
         b89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772069750; x=1772674550;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ci9RsZZzUOkXZUiVAS/DAziwtxPXHN+N0KfwxSaTa4=;
        b=CdJvcLEbGBYjau8IbWRZ6yPNgAznwn5uZ8z7pvSiKlpRScXBmkrOf+9sVYY8MsQLO2
         p3XXHU1kZyXQZZyfUF/l0ytvdoBPqz7Hi1boDW3V576DKX+NgyiOH5dApg67r0KbS7S/
         RP5HkSVg1aXlX+hen1G3r9eh5xNWreqhuv7Vk0KNfyQz4c7DSljGEBEQQFqLxCML0nNP
         +bgJBoSqCWKhaTs+ANPwY8TkKjgWWNEl/+bdoY13iKVkrtLk/SJz/P8MjJ1055cuZIuf
         y8WcsLoQkbdSrsy0TYRp7JniMYwv3CBuVuTH0JL3e2VI3X8MqEDhWZ1RrZfQEo5ajkel
         ghmw==
X-Forwarded-Encrypted: i=1; AJvYcCVs7Hv+2vQ9lZtUbdr26Nti1hhcRN2b/Jk3yh2/QyX0XvkCjFz6c27i4GsMammHZ/yp383Lirfdu6epRXm8/07I@vger.kernel.org
X-Gm-Message-State: AOJu0YygQq8vbkcSvUiQerm8fmzxAeFM6WedKq5zyqP2r1TgPcSJPNjw
	naZKiDZBmhPwYJgYOM2IwmLFp9BasAnsZBXsZC/Yr5FBE7+M3NJ+/paVoEwIlJfrTDIoVEnL9MG
	WUlYSqLvvmg==
X-Received: from dll4.prod.google.com ([2002:a05:7022:204:b0:127:3728:b606])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:322:b0:11b:65e:f35
 with SMTP id a92af1059eb24-1278693dd14mr978081c88.7.1772069749820; Wed, 25
 Feb 2026 17:35:49 -0800 (PST)
Date: Wed, 25 Feb 2026 17:35:34 -0800
In-Reply-To: <20260226013534.2028272-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226013534.2028272-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226013534.2028272-6-irogers@google.com>
Subject: [PATCH v1 5/5] perf evsel: Make unknown event names more unique
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Derek Foreman <derek.foreman@collabora.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Chun-Tse Shao <ctshao@google.com>, Hrishikesh Suresh <hrishikesh123s@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In situations like the perf data converter the evsel__name will be
used to create babeltrace events. If the events have the same name
then creation can fail. Avoid these failures by including more
information into the unknown event names.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f59228c1a39e..fdc67df0e739 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -926,7 +926,8 @@ const char *evsel__name(struct evsel *evsel)
 		break;
 
 	case PERF_TYPE_TRACEPOINT:
-		scnprintf(bf, sizeof(bf), "%s", "unknown tracepoint");
+		scnprintf(bf, sizeof(bf), "unknown tracepoint id=%#"PRId64,
+			  evsel->core.attr.config);
 		break;
 
 	case PERF_TYPE_BREAKPOINT:
@@ -938,8 +939,8 @@ const char *evsel__name(struct evsel *evsel)
 		break;
 
 	default:
-		scnprintf(bf, sizeof(bf), "unknown attr type: %d",
-			  evsel->core.attr.type);
+		scnprintf(bf, sizeof(bf), "unknown event PMU=%d config=%#"PRIx64,
+			  evsel->core.attr.type, evsel->core.attr.config);
 		break;
 	}
 
-- 
2.53.0.414.gf7e9f6c205-goog

