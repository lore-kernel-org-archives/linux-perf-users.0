Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD58215197
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409092; cv=none; b=H17/ViNgfCE5cyOohiiOSlTxAZvjW9MQZgfDi0h1cdRY/CQGJBeXQl5hd9qo6xOWH13bYpTwi7lzucFJs49MfidPL3a1S0ARaulcJFM0G+W37aPxV7C39ptLPNdAycvgfIxcE9bIa00ZHHWVtXwsS6AmWuq3oMzMosSyYJi/+I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409092; c=relaxed/simple;
	bh=OVkiPVeq19vf+gQt7eOMdpDAMipm8Iy1FMvFsIQOb8A=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=IXthQ9Np04mfDcB6lKclyrCv5Vy2ckpojLlMoxJw/d4K+CS2rRMSuIWhviS8IuSnQNk/6ym689G+J0cwarJsO62YXBogIT2L/OFq+kUyhpCCLHgfL2d9w6hduPDEYvJNHHpdaDUNz9YkhaAwSfuG2Gf1RX1mJtBSfpe4zayrcK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hZuyYA9Y; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hZuyYA9Y"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e549de22484so1512199276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 23:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736409090; x=1737013890; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3BohvaPuKDkwXVxzz1n7YHccBtL3WJrAiu6eK/hMI2w=;
        b=hZuyYA9YCP+s+rdlIYgWiT+TStcyI38PNrsj4cTbplaPmuOivOgqjQq5pXNfI/74um
         Te3sP+dMY7pX/ybGMLpvY7wNOiq0hfCkSGaZHlsckELJ6cl2fO+T7Qwx9D5EmkeS/qYl
         UHGfb9eurWWNQfj6XgELrJrq3yUamJirIFpG3MkcvOIknZu+jNNV/G8T++E4JZwyMjOS
         ISCGYC6nPUdfn3Q8FGLA69ZURgNLeDGic1akXtLXHMN2E3Cpo1Blmj80HlkU8ZaafS6y
         XMVmIZ2IxD2qzbVZUNnf8rmnQp36+N3+vP3El6nLKfxwC9pVAPjt7/UXepXy1cuBDRkV
         R9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736409090; x=1737013890;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3BohvaPuKDkwXVxzz1n7YHccBtL3WJrAiu6eK/hMI2w=;
        b=SXyxsselmb6tej2fYOAox04z0gM3qLRPPkuu2B/23tlZAgQoYxT2alNgppKDGhP/LA
         TfX2Zd5uxWS7xHT9NBEYXQz0fl27w8EDKxcQcsI1v8qT/bAV6YJ+5E8zhxCtJm8incWt
         AnL1dc0nS/nArglHbdQXW+x34iTig4V/2TQDeXSjry2MDF4zMhNn6WHOhc6lKZRB5EQ0
         RPV6qcRIQG5Wqwluue/WoyjMuyUu9QcVANqDDGvbWt1QcvVizblj1n3oApz16R2TdhYW
         LwV0Bfpb4aUVIYNkqBGWBZGWiOrm7++wQjmeTBRIPJp8JT0T7N7Rnu67J8xeCZUSSZhu
         +/kg==
X-Forwarded-Encrypted: i=1; AJvYcCVHdZxJjsD0H1gcA4mELOYwp9ORsQbs/bb1BoCVytblEaRBbD3EDx+3gWKC0gNjXGgYpOXAHdljLQBJF4u0A1Xj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz70y2iBb79/QX8umxMr5tvotSy+wh/4EFI9O9uiReaP4grSash
	a7zxuLLlcvUZUrkTJ1Hys0W78ewGhBW3ERZPG2e13nAh0gL6pOO2bKJKep68wXR2FlxL0TLyEFI
	XstQzFw==
X-Google-Smtp-Source: AGHT+IF7NYtcC8At3h3g7b4Aaith6NaYm8trrPonePKLCnlhWMMWcuNg4VevnL0luzl7avqjuOyrwMXYh0b7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f801:f788:c7e5:c181])
 (user=irogers job=sendgmr) by 2002:a05:6902:124e:b0:e48:6770:76de with SMTP
 id 3f1490d57ef6-e54efe6685dmr17710276.7.1736409090259; Wed, 08 Jan 2025
 23:51:30 -0800 (PST)
Date: Wed,  8 Jan 2025 23:51:03 -0800
In-Reply-To: <20250109075108.7651-1-irogers@google.com>
Message-Id: <20250109075108.7651-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109075108.7651-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 06/11] perf python: Add optional cpus and threads arguments
 to parse_events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Used for the evlist initialization.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 6a7042fd2569..45ee6479e4dd 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1330,12 +1330,18 @@ static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
 	struct evlist evlist = {};
 	struct parse_events_error err;
 	PyObject *result;
+	PyObject *pcpus = NULL, *pthreads = NULL;
+	struct perf_cpu_map *cpus;
+	struct perf_thread_map *threads;
 
-	if (!PyArg_ParseTuple(args, "s", &input))
+	if (!PyArg_ParseTuple(args, "s|OO", &input, &pcpus, &pthreads))
 		return NULL;
 
+	threads = pthreads ? ((struct pyrf_thread_map *)pthreads)->threads : NULL;
+	cpus = pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
+
 	parse_events_error__init(&err);
-	evlist__init(&evlist, NULL, NULL);
+	evlist__init(&evlist, cpus, threads);
 	if (parse_events(&evlist, input, &err)) {
 		parse_events_error__print(&err, input);
 		PyErr_SetFromErrno(PyExc_OSError);
-- 
2.47.1.613.gc27f4b7a9f-goog

