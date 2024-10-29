Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08E020F5BB
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241919; cv=none; b=jm0KBvqXUNxvFFhlSNlKhDLU/jWhYGYNL1i25Dca4dPzw+3UVx/J4f+uYJPjRuw6OBIuSLFoNa8Zx9dvtkqxPl1i1+CpLq18SDmgwzqgcSlwbhCAPDX8ghXL11jgILDxbjblAfc1Y6lVAXJ7JY7P1MrSk8Iglyf5Uhuyl1YOuco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241919; c=relaxed/simple;
	bh=8nfaXceOAmgiqk2t3wMeEWNA4KSjqafBiascjUECmpw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=MRGDWV7ktLD8++q/GlZ8Tdus1lfFjBkqg3T7lfQfqCsSuTQZ8bZFip6qVh4/WebZSQyMGdc1jpElNuyg4G1efSIEciYVzGNPK9+XlRxhJfFyK4GGvnVJTlMEXy11IYp1/UKfMN6PiGKydxFR0R1osxLV4smFgh8yUnbzPGlFTVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JMtZx3By; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JMtZx3By"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3d660a1afso106107237b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 15:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730241917; x=1730846717; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dis7RmFKQzQzt6CCLpk0OQW/Lncdns24hHlJR2bLa6w=;
        b=JMtZx3ByDfCcrjnRCuT0Ed/BoikpbyYICxgdUDfgxnoTzZ2DOBWObv6XlPNpORrhIC
         8/UAWwwmemBFJsz7j9jG2pKUadBhbpkpKTYWA9/cn6T8WfjEcgQETwkyycs7xT66Xb2+
         EDVk+fd/sPA56hc7qFXyKDq+bNoPwr0cdLMUopeYfef1c2DIn5VpUYM6h55ExPDXvYo2
         qMg4UM/OD+cFSwx8pxnRDrKYLJCQl0luZCtCtAuf5blahFwAei9QZpR5+SsT9ELljzZ9
         hBx4sgUqaaWOtTxF+JfjJnJnE/Uz73NTS2o9Wegc2eBcFcLdya+TrOyL8nbzoGigOFH8
         c7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730241917; x=1730846717;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dis7RmFKQzQzt6CCLpk0OQW/Lncdns24hHlJR2bLa6w=;
        b=lPmrKK0uZIzqRkP6BgWOYiTwwaz/ACVD9GZdFDsdDUTPMcdbfXWNg5gSv1B+nNzqsC
         /3a/lMEmPHt2labZHYDB1Nl+wU0io94DJuuez8PqApUd+BptUNjSdcVWXsPfnyCwbK9s
         JbDIM66dTOzgXDjNBGKrw+KI3wPOjwF8eQZoEuYfUWiHQwLoctBOM3BTOOrTWaAy9Q+6
         EPsiaCmJvR1wfrufOJLpUSc2GiNxxOX5GC5h4+vdCY3U8tDPf3Qdx9/ST4+TK3p12dBG
         t8ymrBIt+XFbml6LoTmiHPeuoy7EFSHUjTpQ1H0Y+b/63maA65HZAW8//vls9nfi6Rvw
         yIRg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ41eBEJHdE3Zx87lZRy1IWR8u/b4lWZN3UAm55gqtfHm7KxOyX7Ppz8domJ9rgW+0SvS/S9/aAlzR26f+DkiR@vger.kernel.org
X-Gm-Message-State: AOJu0YziywT1+BCTEuIDKZRLZGRFh1+uoU16scZjHFpvPEqYzt0BY/v5
	bVHLzCDx63ZEdigIxnTpmNVy47LVUN45w2xig/KTt/6VL7QOW+jES7lUc3z/uMgCTqye2p1cY67
	+C6zpdw==
X-Google-Smtp-Source: AGHT+IGYQb3NSPl3DR97IU9T7cti91p37aPy5/ZWo/WZtAv7Pe5mvapiQjRvDTW00VykvHHfDTyVqK+CdDi+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8991:d3fd:38a7:c282])
 (user=irogers job=sendgmr) by 2002:a05:690c:7092:b0:6ea:1f5b:1f54 with SMTP
 id 00721157ae682-6ea1f5b2d06mr3253077b3.0.1730241916675; Tue, 29 Oct 2024
 15:45:16 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:44:29 -0700
In-Reply-To: <20241029224431.167623-1-irogers@google.com>
Message-Id: <20241029224431.167623-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029224431.167623-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 17/19] perf python: Add __str__ and __repr__ functions to evlist
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This allows the values in the evlist to be shown in the REPL like:
```
Python 3.11.9 (main, Jun 19 2024, 00:38:48) [GCC 13.2.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import sys
>>> sys.path.insert(0,'/tmp/perf/python')
>>> import perf
>>> perf.parse_events('cycles,data_read')
evlist([cycles,uncore_imc_free_running_0/data_read/,uncore_imc_free_running_1/data_read/])
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 1a53a97c513d..a71bad3418da 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1069,6 +1069,30 @@ static PyObject *pyrf_evlist__item(PyObject *obj, Py_ssize_t i)
 	return Py_BuildValue("O", container_of(pos, struct pyrf_evsel, evsel));
 }
 
+static PyObject *pyrf_evlist__str(PyObject *self)
+{
+	struct pyrf_evlist *pevlist = (void *)self;
+	struct evsel *pos;
+	struct strbuf sb = STRBUF_INIT;
+	bool first = true;
+	PyObject *result;
+
+	strbuf_addstr(&sb, "evlist([");
+	evlist__for_each_entry(&pevlist->evlist, pos) {
+		if (!first)
+			strbuf_addch(&sb, ',');
+		if (!pos->pmu)
+			strbuf_addstr(&sb, evsel__name(pos));
+		else
+			strbuf_addf(&sb, "%s/%s/", pos->pmu->name, evsel__name(pos));
+		first = false;
+	}
+	strbuf_addstr(&sb, "])");
+	result = PyUnicode_FromString(sb.buf);
+	strbuf_release(&sb);
+	return result;
+}
+
 static PySequenceMethods pyrf_evlist__sequence_methods = {
 	.sq_length = pyrf_evlist__length,
 	.sq_item   = pyrf_evlist__item,
@@ -1086,6 +1110,8 @@ static PyTypeObject pyrf_evlist__type = {
 	.tp_doc		= pyrf_evlist__doc,
 	.tp_methods	= pyrf_evlist__methods,
 	.tp_init	= (initproc)pyrf_evlist__init,
+	.tp_repr        = pyrf_evlist__str,
+	.tp_str         = pyrf_evlist__str,
 };
 
 static int pyrf_evlist__setup_types(void)
-- 
2.47.0.163.g1226f6d8fa-goog

