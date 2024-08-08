Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95899EADA;
	Thu,  8 Aug 2024 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723123948; cv=none; b=flqqGb9FdOyiMCNs0z2M+7G7h2OEmv3YnKJQec2juplixcfRzpCwTkdZAUqXCHh5dsK9vnnQyfM+R4Ieki1O/25OkbCg5k+r7MKdD/FCdYZnNa+NEFXiZbhXEU6QbodV4ry2IIro6RMVmv8DNP8Fx+16WMK4aV2suCwtvrdT05E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723123948; c=relaxed/simple;
	bh=PY69VKc0O3FGKqim7+fFbR195skWqhuZpW3Ef61ULVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LYMGGCMQ8NKzbrFySxwXN+jM+ljTnmY6RWGAIOEidAHRLhElPhsEeQpr1HrJLyy3ji7z1CLw8NzpBX7euZHXW9PGauO3Jxeh88+gFbP0Ml3V8icajq70rVKE+yddFDh6SLjfil6IVj62FzxDtNkVkf3U7i1oyVMKNqtA8xDTYjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlXTUXBb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlXTUXBb"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc49c0aaffso8965785ad.3;
        Thu, 08 Aug 2024 06:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723123946; x=1723728746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fAKXh2R2AFOAbLJH/+A+18aqMNWogzmzZjhkD45bQP0=;
        b=nlXTUXBb8DRVXz9UNIU6jkGNj9OYPn0qYmnNQlnO1MFLtgC/pO+dpw6MAFjUDMFF33
         UYqdTbctsANGAc5jcagl0hN0Jg/BS+Ul5+vT5BeJtSBelDOOGdZjPxiI2nTU4PF6+Dx0
         j5MsfjhMd2LGON8/ePzlDdqE8iilOnJ16aHUYBkNAmgpR/RK0BH4tRIWv0TVdZqX4LCj
         XmsNiFDLfEAm3NU2fadkRDU5dAQ2Vy1npvbWj9Kho3ftonR09wCl20lXsHkj1DY2ftaf
         +T0SgWAQ+p8aF69ZhDxt6p8sds5M+jTyXfBaReXFXwGkKsgQU5iGgv3OA0s0kfSgSIzv
         jz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723123946; x=1723728746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fAKXh2R2AFOAbLJH/+A+18aqMNWogzmzZjhkD45bQP0=;
        b=rKMUZ36WYFOEQMV4yOztbksl7mrcmHjzzPfoYFQ5o4WqK5c5v4dBBR/SGnA9nWs1bZ
         hZuBDUuP45OUv4DMObzSDH/rnZpZlWpb7npBne2YpQRuE5B4wtYV8s5I7eY80etSZEMw
         w0OvooJNl1AO8G2kKCEXRWKB6GAaYTdIP3/ZTgwy6E2Msu+WRvqvFVQlv+BihROTWF+Q
         s7p9hJ56pkDGH5W1by2kO9QB9jJOVyxMea+Q39sNwpWTnjMaL4xoW1/h4zyAAuJxGg2O
         M3Tp9WQ3AiLnc0MglFLNzPUxBVLupK0qVs810vMNXlv7Gq7DIMWIGBA3Y+jBhbnN6ply
         yQXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWfU+7YygeGtVOZKaQIDtDn5M/3wRhlEPQUdkWTI/hO4pLLvrMtckzWmGm5liSaAj5YAzcqlsiIdRGig/WdgXwrhbdc32A/5rq3Huj8F+NTltQAiEA8SCY5JTpmFZ1FkvYBYyzVmxnZzLo5pSViw==
X-Gm-Message-State: AOJu0YzwfQiT84Eging6FDrnytKQFXkh+CTD4Ls5yPMdQvKoaxqrTP0r
	C9HwumDX9p9qrxf2oIqeOFCXzaurt1BpHrOxNanEkQDDaX89fx2V
X-Google-Smtp-Source: AGHT+IG7f6HOQ4hgxFfNXUzJqxHSDJxtwa+R+2ZGiznZtFKXCUtpBKg1LDWxyfy2yRG6NPaUTvWYDw==
X-Received: by 2002:a17:902:ce87:b0:1fd:d6d8:1355 with SMTP id d9443c01a7336-200952487afmr19714395ad.17.1723123945832;
        Thu, 08 Aug 2024 06:32:25 -0700 (PDT)
Received: from alveo.moma (bullfrog.anu.edu.au. [150.203.163.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f6d80csm124458395ad.119.2024.08.08.06.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 06:32:25 -0700 (PDT)
From: Zixian Cai <fzczx123@gmail.com>
To: 
Cc: Zixian Cai <fzczx123@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Paran Lee <p4ranlee@gmail.com>,
	Ben Gainey <ben.gainey@arm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf script python: Add the ins_lat field to event handler
Date: Thu,  8 Aug 2024 13:32:07 +0000
Message-Id: <20240808133208.3577910-1-fzczx123@gmail.com>
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
---
v2) rebase on top of perf-tools-next

 tools/perf/util/scripting-engines/trace-event-python.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index fb00f3ad6815..c9e8dbd6feb5 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -888,6 +888,8 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 	set_sample_read_in_dict(dict_sample, sample, evsel);
 	pydict_set_item_string_decref(dict_sample, "weight",
 			PyLong_FromUnsignedLongLong(sample->weight));
+	pydict_set_item_string_decref(dict_sample, "ins_lat",
+			PyLong_FromUnsignedLongLong(sample->ins_lat));
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
+	tuple_set_s32(t, 27, es->sample->ins_lat);

 	call_object(tables->sample_handler, t, "sample_table");

--
2.25.1

