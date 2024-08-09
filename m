Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A689125BA;
	Fri,  9 Aug 2024 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723169610; cv=none; b=gunvFd2OSU5cq4MR0DfxrI6hgKaWjoTRYMNpXEKxfUC3M6DzK7uTkg7EVDtDBq2TZ7eXFZ6jMco5PHbYC0j5pHEIpUOv94z2rBOnBZnreks1lTYMBq5+a6fY+ci1trcCu9L2YoFYwDFB2vAMyn0wl0/DQJZKq0FBnF3ijmBFIoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723169610; c=relaxed/simple;
	bh=L1/CcMYUzQeVnLRp78/rIjUOoeqbhFGwSPM8rjg5hx4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jg1ZdGqeVpND+oLt/5o5GgOwc59T/5VD7zoqat1NHOEDF6sBR3bT+Jp5bmLrQX5lApL+PhSkEm4K+3dwh/cWEQMGIIFgFN/ZsHagvNR/v1hmjHZ3gk5sTd81MwrNS3o9XD3l1e3fnthhVHDu6tFOf6/POm1ZRwKl3wJIMCWWryo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6GvOHE0; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6GvOHE0"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db145c8010so1049883b6e.3;
        Thu, 08 Aug 2024 19:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723169608; x=1723774408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BdW+1nqJBOxtiQ6fYCIsjQK51/2EuX+sDY4oLYzGYyc=;
        b=K6GvOHE07z/JOabIGJokA6uQD+Qzxetw2IoFViMiJuY+VCLoAQsNtQNbK2ZEE0Y8YC
         +FuzC6wlDLbUnuldXeVsn4ZqfYlk4XKggof2CNMeXfHwrDuMfNWLFhBHWxeVIDQvaB9K
         7VA+VxLrbfJZm0NaNnxOZvvJQO2D5Xc0Y86htldY2fiJF3XEOQK2NfFQZwytNE9qmC/v
         mrD5ZNh6VAo5TBb0Ca6w6GSqFExhGI3qN/FpmwhgYesgAYP8Xy6F8/iCwKMVXq527xWh
         KWosBU5N34ZX9uVjtGvcbDL63y4wFmZ1E6Xo3ns64Y5GII23QeLyXI6a1kWZJnEI2gPF
         EDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723169608; x=1723774408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdW+1nqJBOxtiQ6fYCIsjQK51/2EuX+sDY4oLYzGYyc=;
        b=WxsTH1B34tEYDT3yO/nj2oZZiU4rYMitfDqjOzsVMS9sez7BUZKzINxYGbEN1RzMAF
         M5zoJNey/2k03/6gq214xFYgItRRS2J8yX2noSqs+y2NxLrCbV8BHXCzYgFXrThwSFGR
         yRuq6udT/LslMjkYgv77yNMuAPWVaneqqZSgQoM3OzSPa5ZCb5HfPix0ErlqrIVZZGsS
         RLicpnhS/sPyrIGeuAem18ke4wdQxzjICRW3s4bWBJ1wfVcCMmPwltIMsSItdhbPYEMS
         kl6l9jpLe/jtFQ59QsvZ8pfYYSXk0Qy9sih7DMQM0uvr0oXjzrp5H4IwMJv5dIwTNvu9
         AsqA==
X-Forwarded-Encrypted: i=1; AJvYcCUonlCVAVeqmjjW2dl5AHzsq5r+PrW+mOwiE+a6ZJUTqFeUXhVj8OlcVBwJzyn8W2CvghS72ll2+Jez26HRwSDBZ95tTDOw907GMpTYGyA+y+So2OcA3XIvHYJmz+SopYxEsHjRYic/aMyCykxu8g==
X-Gm-Message-State: AOJu0Yx9qeVC/TBXHqIaqnpeUOChJJLA50wGGfbguWN4Okp/m9kYG/tY
	HTFY2ukIq/NxEC3+6L0MZ20YLNytH2ceVJCjp3o1jBeel4tCI1E5
X-Google-Smtp-Source: AGHT+IHnhWnUUBli5mBqNdf8e/EIV0hXQceHou5qePtZyAU6MS9FCH0gUlCg4nGFv4ILJnezAaRfyQ==
X-Received: by 2002:a05:6808:3c8b:b0:3da:a032:24c5 with SMTP id 5614622812f47-3dc416838e7mr43428b6e.22.1723169608431;
        Thu, 08 Aug 2024 19:13:28 -0700 (PDT)
Received: from alveo.moma (bullfrog.anu.edu.au. [150.203.163.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b76346c2c9sm10464551a12.20.2024.08.08.19.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 19:13:28 -0700 (PDT)
From: Zixian Cai <fzczx123@gmail.com>
To: 
Cc: Zixian Cai <fzczx123@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Ben Gainey <ben.gainey@arm.com>,
	Paran Lee <p4ranlee@gmail.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] perf script python: Add the ins_lat field to event handler
Date: Fri,  9 Aug 2024 02:12:30 +0000
Message-Id: <20240809021231.3587558-1-fzczx123@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For example, when using the Alder Lake PMU memory load event, the instruction latency is stored in ins_lat, while the cache latency is stored in weight.

This patch reports the ins_lat field for Python scripting.

Signed-off-by: Zixian Cai <fzczx123@gmail.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
v3) address review comments
v2) rebase on top of perf-tools-next

 tools/perf/util/scripting-engines/trace-event-python.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index fb00f3ad6815..6971dd6c231f 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -888,6 +888,8 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 	set_sample_read_in_dict(dict_sample, sample, evsel);
 	pydict_set_item_string_decref(dict_sample, "weight",
 			PyLong_FromUnsignedLongLong(sample->weight));
+	pydict_set_item_string_decref(dict_sample, "ins_lat",
+			PyLong_FromUnsignedLong(sample->ins_lat));
 	pydict_set_item_string_decref(dict_sample, "transaction",
 			PyLong_FromUnsignedLongLong(sample->transaction));
 	set_sample_datasrc_in_dict(dict_sample, sample);
@@ -1317,7 +1319,7 @@ static void python_export_sample_table(struct db_export *dbe,
 	struct tables *tables = container_of(dbe, struct tables, dbe);
 	PyObject *t;

-	t = tuple_new(27);
+	t = tuple_new(28);

 	tuple_set_d64(t, 0, es->db_id);
 	tuple_set_d64(t, 1, es->evsel->db_id);
@@ -1346,6 +1348,7 @@ static void python_export_sample_table(struct db_export *dbe,
 	tuple_set_s32(t, 24, es->sample->flags);
 	tuple_set_d64(t, 25, es->sample->id);
 	tuple_set_d64(t, 26, es->sample->stream_id);
+	tuple_set_u32(t, 27, es->sample->ins_lat);

 	call_object(tables->sample_handler, t, "sample_table");

--
2.25.1

