Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3F343AD5
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Apr 2024 06:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731359; cv=none; b=Nrlj+t6f6I5fQoh6+PFA5/RGzBIHMbPp5EZOeHJ6fcdNsIC23TKK/8BFU6sUzD9aDBuIl27B0R9xsLpxGIwu+at6jz6/zIbzcg1ToTRYKiTiHSfDlv8PEmS9kOMv2xOI6aSR5ZPCI1BLvKHITVn2bKZxEYhaKX92JB4JrxtmCRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731359; c=relaxed/simple;
	bh=2jzruDa3ldd8qnDLA1rJ2ZswFfOJYSB+fnUOaK4RUOE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Y+iGttYCND26aIHpHCOmZq1arhl5KHrep0gf/iMNvTQqQc+EuxQrl5JMifA/ThfG1pWBg8QY5O0wovp+lQ79wVhCUQaoF8wT6P+FM/4iAb45h07r1Mz2VLf1tUQL0W4DS5CreYwSPt/8UqDkRhMgRUKZGFv11YLmCZLEyco8gs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lgpzw+D6; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lgpzw+D6"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so10753903276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Apr 2024 23:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712731357; x=1713336157; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hvCMnP9B5vVSfhdt4AG7Zd6V/+C/ZwTtaug7JMpiZVI=;
        b=Lgpzw+D67wp5qiq/mrvRPEnmzreoCMUE9HZpAF4W279uWhxKd2wH4Mapx7NGweB9ec
         wlp5wvSWa6GX2Lk2R6Ux5HOIgauaiU5oVulPIHjtchBD5fvV/rKIx+QvW7f5hs/sYvDh
         7g8jf6K9Nirw5UJpqIhWOtLtgUfz3jd7Ke2cSJeyLtFzhHd6vLvBhdmADwDF9bwkOwwA
         U9o9xbkAXhh3eH/vBmlJ/zmTfde1ubO5SF2v+VisiJXdil7UbDHGuj+J9iJqGdFzUZN6
         BgHRZrBF3gm3ZqJrz4LNDs3BzA7Ilu1Wg8xZXgMNWSUpz0vrmq0u065y9sBkqf5QjilG
         Ntyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712731357; x=1713336157;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvCMnP9B5vVSfhdt4AG7Zd6V/+C/ZwTtaug7JMpiZVI=;
        b=IRmyqLSUt666UxEU6+qBcdfbbKxyrYUWJJdNlr6WSpgZKGP0s2Bh1+5XvrrQGOpAjs
         GfNCgeRNlh5pwinS4sDMUjvkRu9EMYji+FAfic51Zfhjo8VpYXqlq7zF7mg2MqtCaG7M
         5W9fMV7LT4yMwUcbf14PzbIMgle21XPqIHl6jGAcfgSVwE9L6xwRTWG76PxHroxpk3xp
         4c0LX69d67nYk4hiCOvynNw+67ud1kDWmP3XAHBM20Al1JdsqUJQuA23VZpqGj4s85EP
         5MsMskpUkK7iRIm4uA4vRWe0HWkPQr5rfEqAlhzg6q6U7i3cMWFz8rauTiLc/U0Yj+D5
         S/4w==
X-Forwarded-Encrypted: i=1; AJvYcCVp7kBNWD49njLFDXWVBM3mzTPVgZn+v2MtlAhglfYvaNomkQdvj3Dxvn4DzxgGXijg2UndC5pTA2jOJSeLm/FUoysb5kyr2oeGdx0GVWrcZw==
X-Gm-Message-State: AOJu0Yy12qjYfcD8+fmY6Oc+s4h/6GZtyqsTD9uunDpiQUXfa9JD+caf
	0sgI9z3NEnascxSyjz2GdaqQA2Y6AmLkWfq6G/tApSrM4vAQBJkepqOW78hYgBgUjxuBEo952HM
	cBpkFww==
X-Google-Smtp-Source: AGHT+IF5Kd4tmO9YCm0rEfF3dJjKkyEjZ0qxpiMG8D20NRtAHiIO/Nib/SOo+kuMrUTiBC4VA5zfMpmYvrDQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:18c5:d9c6:d1d6:a3ec])
 (user=irogers job=sendgmr) by 2002:a25:a407:0:b0:dcc:5a91:aee9 with SMTP id
 f7-20020a25a407000000b00dcc5a91aee9mr514589ybi.7.1712731357347; Tue, 09 Apr
 2024 23:42:37 -0700 (PDT)
Date: Tue,  9 Apr 2024 23:42:09 -0700
In-Reply-To: <20240410064214.2755936-1-irogers@google.com>
Message-Id: <20240410064214.2755936-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240410064214.2755936-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v3 07/12] perf dsos: Remove __dsos__addnew
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Anne Macedo <retpolanne@posteo.net>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Li Dong <lidong@vivo.com>, 
	Paran Lee <p4ranlee@gmail.com>, elfring@users.sourceforge.net, 
	Markus Elfring <Markus.Elfring@web.de>, Yang Jihong <yangjihong1@huawei.com>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Function no longer used so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c | 5 -----
 tools/perf/util/dsos.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index cfc10e1a6802..1495ab1cd7a0 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -341,11 +341,6 @@ static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, struct
 	return dso;
 }
 
-struct dso *__dsos__addnew(struct dsos *dsos, const char *name)
-{
-	return __dsos__addnew_id(dsos, name, NULL);
-}
-
 static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id)
 {
 	struct dso *dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/true);
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index c1b3979ad4bd..d1497b11d64c 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -30,7 +30,6 @@ void dsos__exit(struct dsos *dsos);
 
 int __dsos__add(struct dsos *dsos, struct dso *dso);
 int dsos__add(struct dsos *dsos, struct dso *dso);
-struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
 struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id);
-- 
2.44.0.478.gd926399ef9-goog

