Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BC62882D3
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762977204; cv=none; b=cx1erN3hiYcaSCtQsLTFW1Aajqv99NYi+TuK2CQmDeu1hF8xdRDdvdneYgE8Gp5ipAVuBJkbZs5jVCal/Ga7DRT7eKZbUtFfcK737qKEQUP2tuhNOysfPcNI8KbXD7l3zCzZA8+dLgKsvYvoc3DeSua6YKqxVUvShHObqE5Zpqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762977204; c=relaxed/simple;
	bh=yYYSEm1+78KFE95YmQCyenLnSRE/5b8iEhqKQfSJY+c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XJXVn4KAU7QcV0/TZ/u8P6KQRM58s5iIIxFnhSnhWMcElj3jGyYiFusCQ+OKStZtoarSb3ErWtL2sZr/A3y25RuanrZ5WqPvmya8L5puJ3LbT6vL8mXpbOzK62+xhslB1vS8D2eVuXT3URAKGxCnEg2bkv1sjOeKkXjcmGH2i+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cyq1n7q4; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cyq1n7q4"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-295595cd102so83215ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 11:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762977201; x=1763582001; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aWhwDpn/WcIzrlLSKPaqF4IGWaujqE9kQM3MysbpHr8=;
        b=Cyq1n7q4v7HbBx38n63bzi+esySXHpGg1yJAu4gbI2SzcjQYlBf3VLkvD8PjGKt8K/
         aPMsUYkEWAyNCH9jquw8N17A75VFhgv4xHC0qwmE0+XnO0NhW8X8Pjg6pqgqlfVObir5
         Jo2bTfMQ9Pjyx6f7Ab/eZps36+H/Y3CrMtoribkH25Rap2lAl8IIrY1TE1i6RSHjStDj
         UPcyG45IViUWo9uAyNIUr1ZUYriy1ZXbCEUdhuXjHiPCsAmZil9pY6xaWSz3uX4RxiMQ
         h9GXCUm5vWOd+fnf47cL4sTfKGB5AFSOT9aKYB3an4FsR7sfd1C0qau52hCByEnkbVTs
         pVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762977201; x=1763582001;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWhwDpn/WcIzrlLSKPaqF4IGWaujqE9kQM3MysbpHr8=;
        b=utiVCsz6KGx4mHPVb4j3wEXigZulbmGAlMV/Ixhqr3/kZ1ijktuZpY2bcQvn4MRN50
         7Ncy+cAaPTW9pGhIhprFir1/Y0fX3nV4nipPeY8Z3tsGrgzsm7WGmotMpUSIv92UCWjZ
         Kzp4D6ozib4yODtqAYhjkIYH2CCVoik+YmFE2IgqbONbIPO68jCgArNhoRohQDrYZ1P7
         2kZjlxU23JnKQ0BcXC0MAbQMCivJHbg4knzPq5kfOrJk2OMiBtDkCkkUCeeGoCWIMS3f
         1Ob9BAwrcYzcQi+7ufSmqvlCRGoKknRmrKONxHVIvLlRINujOqmbXVC1lBMcTBQ8PEaB
         u/4g==
X-Forwarded-Encrypted: i=1; AJvYcCXmsUTkN/57m0OH1d0L5YtuhWYo5wCfrZq0xjpVqf0ZCcTB8Eb88sG1qFkaoL/pdYNKplJ6Ue40FkvMHXTdQZzh@vger.kernel.org
X-Gm-Message-State: AOJu0YzAmVzVCcDXRCxNglrvCXTg0jzWdqJ+rYejrOhKew5mIvoTHGLu
	bNPxGfKgHjibLStMzGaahRJQ5r4mk8LcEnZmiioSgzTAVw5p3YrtYJV+Qj+qQvJyz2i8/aHWWbB
	YmbTe+fTNeA==
X-Google-Smtp-Source: AGHT+IGr8jqCt/mQgH8SPenACb3EoRr0g3D/bK0976Lf844ug4u46eKIIXxBLg83l6XVCi7QbfIWMrTnn91V
X-Received: from dlf13.prod.google.com ([2002:a05:7022:40d:b0:119:49ca:6b85])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e94c:b0:296:5e6b:e1c8
 with SMTP id d9443c01a7336-2984ed92467mr56093505ad.13.1762977201529; Wed, 12
 Nov 2025 11:53:21 -0800 (PST)
Date: Wed, 12 Nov 2025 11:53:09 -0800
In-Reply-To: <20251112195311.1673981-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112195311.1673981-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112195311.1673981-3-irogers@google.com>
Subject: [PATCH v2 2/4] perf parse-events: Add debug logging to perf_event
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If verbose is enabled and parse_event is called, typically by tests,
log failures.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 0c0dc20b1c13..e522082c5a21 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2236,6 +2236,8 @@ int parse_event(struct evlist *evlist, const char *str)
 
 	parse_events_error__init(&err);
 	ret = parse_events(evlist, str, &err);
+	if (ret && verbose > 0)
+		parse_events_error__print(&err, str);
 	parse_events_error__exit(&err);
 	return ret;
 }
-- 
2.51.2.1041.gc1ab5b90ca-goog

