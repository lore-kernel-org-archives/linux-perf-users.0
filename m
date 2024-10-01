Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBA21BC9E9
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 05:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727760224; cv=none; b=sG+3o7LZh97Gkw5sCs3eFNtx4HxkIQk88GhAOez6eJYQc0tB3g7zTFcXcXGUzW0QhQFNEQ8SuHxyJK+0lU/dVOTf83yBXGuIZx9to6euOrYhnhu/hdKYmSxj2s0XlSjlWmEkCI69XGyGz1aCgUtTklhCXUfxtveXVeH4Makwt5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727760224; c=relaxed/simple;
	bh=HlaJPf1DpkhIcVfUnD58FBwEx20zYRsFkrETe/cFLkU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=uePK62omdFfQKf+k3up/KoZnn3uQpxpn3HhVq89akNOyELasIWtb4sdSv5+bt67mEQlKmua3oqo9LNclhzqmmOzJQ5Z35uoNpr8Xm8AmCS0UA2gSG+LNOoHDebR328Kz1o+q4b2N8IuxL7SS2YBB98ploYaNNOooAtfCwEAWW04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=juoDUpam; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="juoDUpam"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e25b39871fso43913657b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Sep 2024 22:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727760222; x=1728365022; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FSpyv/AFjmfCtapMZ23chCRHMXjbu/7COuZjKrd4Qfk=;
        b=juoDUpamF7UF6rFT9yyark8XE+ageMESuAvoescAbFB2MNgcBEPj0ZBf4MZsbLgxaj
         IHR/IHrmCtYsAhT1xtzVZv9I+T4nitjiLsaOeBZPXc87vdNL8nv4aLppobokcqGCIANI
         c1nNnIOKZb+jiUwOxVOarYsBWp7yNpCW4og864bwsd4QzOrMlqspMe9x8+JuC8QV7oXp
         35naNd0a47FgkZNq15jxTjr+3uEPeVAujIIvPw+zcfz9lLP9R6JQaJcbW2f1NoJVXHN4
         bq5je00m5VZ2pmGiSBjxFsCLbBUngGIPlifZX1UMSS/Uyb6x8dKQzK8THhAIV/jrzSqM
         lyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727760222; x=1728365022;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSpyv/AFjmfCtapMZ23chCRHMXjbu/7COuZjKrd4Qfk=;
        b=ZVnq0FAJ3AhYE1wAGtKR1AsI9qw0sPlo480gN6HMaSyj6eRW3frKL+XAxJV+/NQIlN
         yJlT+vmfHaEHfvuJLG+Idsyz77vLs24yysaHjNEaSMNU759C43JUkB/R9Rbu0P2oRB2l
         FG2oJ82N68xAc5d6WC/J5beO16NkFX5vnYnb8rLtbnJ0nDU+EOA269tdwtfeXMcaNzwS
         dq2hripskBEnIwbJwkdc5cHvTa3FId6taxpIi85mDk3IObZlfrPlClkdVUZjjlwfmeWH
         /CX3GK0ZE8/4ZB/d6Xu0xzAL2eBlcnRdHNutLe1jsBP+/o8eXcrfemTHkx7zfi+WubJP
         3k0g==
X-Forwarded-Encrypted: i=1; AJvYcCXn+YX8CLnRFKpFbf7q54oyIWqXLmmWp+25K1WC1gMhi8hKrmsKIoHBfESexEdVmG5qexWf2jhIAIb/RxqOpBNo@vger.kernel.org
X-Gm-Message-State: AOJu0YzzagbqxunbJrLeC0jbrnuxenkF7QhvG62E5rFniQocvHOX1Wl1
	UTcP5nTVCm6WjoWhKBndWav154ZUBjKtJr6E4zQj9+R/3GKEbkYrf/sRoDrYVKk/hiSlMLV8f1Y
	1BdPPJw==
X-Google-Smtp-Source: AGHT+IHVW0m7mS9IM+OEPcKA7PRFyrcmcKWvkbN5Gk4Zr0KfEbqS7bbdaJzOmzXtgquqf7+Qzi0FPyxKe+AE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f420:67c7:1eea:bb12])
 (user=irogers job=sendgmr) by 2002:a05:690c:3005:b0:6e2:120b:be57 with SMTP
 id 00721157ae682-6e247604e65mr2217147b3.5.1727760222250; Mon, 30 Sep 2024
 22:23:42 -0700 (PDT)
Date: Mon, 30 Sep 2024 22:23:27 -0700
In-Reply-To: <20241001052327.7052-1-irogers@google.com>
Message-Id: <20241001052327.7052-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241001052327.7052-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v2 4/4] perf test: Skip not fail syscall tp fields test when
 insufficient permissions
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Clean up return value to be TEST_* rather than unspecific integer. Add
test case skip reason. Skip test if EACCES comes back from
evsel__newtp.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/openat-syscall-tp-fields.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 888df8eca981..3943da441979 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -40,7 +40,7 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
 	int flags = O_RDONLY | O_DIRECTORY;
 	struct evlist *evlist = evlist__new();
 	struct evsel *evsel;
-	int err = -1, i, nr_events = 0, nr_polls = 0;
+	int ret = TEST_FAIL, err, i, nr_events = 0, nr_polls = 0;
 	char sbuf[STRERR_BUFSIZE];
 
 	if (evlist == NULL) {
@@ -51,6 +51,7 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
 	evsel = evsel__newtp("syscalls", "sys_enter_openat");
 	if (IS_ERR(evsel)) {
 		pr_debug("%s: evsel__newtp\n", __func__);
+		ret = PTR_ERR(evsel) == -EACCES ? TEST_SKIP : TEST_FAIL;
 		goto out_delete_evlist;
 	}
 
@@ -138,11 +139,21 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
 		}
 	}
 out_ok:
-	err = 0;
+	ret = TEST_OK;
 out_delete_evlist:
 	evlist__delete(evlist);
 out:
-	return err;
+	return ret;
 }
 
-DEFINE_SUITE("syscalls:sys_enter_openat event fields", syscall_openat_tp_fields);
+static struct test_case tests__syscall_openat_tp_fields[] = {
+	TEST_CASE_REASON("syscalls:sys_enter_openat event fields",
+			 syscall_openat_tp_fields,
+			 "permissions"),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__syscall_openat_tp_fields = {
+	.desc = "syscalls:sys_enter_openat event fields",
+	.test_cases = tests__syscall_openat_tp_fields,
+};
-- 
2.46.1.824.gd892dcdcdd-goog

