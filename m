Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440F4188CD8;
	Thu,  8 Aug 2024 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723104063; cv=none; b=hAoELl7ejYqiHHo0RyQ0Y4jnEIzmN2yGSGeGJPtGaMiiNTbXvApuC8EGFetJ/weL3BYh9IZdNK+rtbf8RtESv99ZwjymvknXTPIkx/05T+f93Gl0FtFsV+J7hwMaXr1gHExw5bu9DgTfhFCORsmSh02eKIwhv8n1PzJvfjKverA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723104063; c=relaxed/simple;
	bh=d107dxSOJy/IsdkIlMvwvuyrtRAfJyvlUkR1dmmmQiw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r08B+2BYhWK0TtqbUPCqy2Hc22IBqft4vHxCgyzs2oFUwpn90RhFBQWjDdCxIcoz9yhj+wOWOFkk5rGwaI43xk5EthRrQmYDWDUMb3mOeYS+lE0raPsrxsfI4IuMjP5jVsAXQSNHAhDmuPVcWXh4ZD0/E5UyolyZhR3ggWQ5wys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arZPw9gk; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arZPw9gk"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cb566d528aso612199a91.1;
        Thu, 08 Aug 2024 01:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723104061; x=1723708861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wqs6KdMLbgfGmk1QaXPQfVur5UUnGXn6qzNoZ4u3hZE=;
        b=arZPw9gk2JYPNVgvLUiBS2BOQkxSN82dRaC8ec2xGegE/0bSNdWXmW2jFEs04VhTIe
         VgEM0EQt2IBB6G/KBSZtyj9FPKrIFGx93dK+FYE40kL2wvHdV6kx4AhbH90ZwbbmLgr4
         yaoc1vhAlBpspk5DeIUmAPb+aBvKtKoFPJk6oDjrq/YUcTRTExLAwCyVvN3F97MIZ3GN
         FjbMLSy8N+isujJhTimXeowb1vi2h7hCapiwuZ5qlRCdMilTn5geEfyB393T3jUHDVxq
         yTwJHdvvY4Xtp4d+v/sZ6sACaSX36yZW8DKSwSu7F78VibY9NQL4Dpq65MosnjvjeEkY
         fqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723104061; x=1723708861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wqs6KdMLbgfGmk1QaXPQfVur5UUnGXn6qzNoZ4u3hZE=;
        b=BhP7wZdTfvoaMZSWsmSU1SUUEtqeKz/YH8oIR0hUrBPidffqjC8E2bnM1zh0Psd0l/
         geIrBZZVDuPOvA8OnxcDmBbCTurCooZtdk00BCCEytzojWbU8ZJgV4A9NCB3xJpGs1do
         5If44yDyBujAPCEozlvMRXLqzN2/9I51MMJuCq2aGQi/HsFCjGrA0YAI1lKzumk08RgP
         kROGchdWog9JT5CS4G+ISur+X67ablrheKbdHf3gMp9MGbhVwvja53FPYH2ekmn/qJaD
         MEjwKIyD7fb74YTFV4fODWSeiUat8wN4TPWNr6PLyzKbAxX1VZ9Y9nuyLCjlcuYkjtoF
         hFsg==
X-Forwarded-Encrypted: i=1; AJvYcCWTZfN0z2n+bFbC2UC+lzy/jHmXTWuv7LZEDJCXBIlBHujxFjQ6R0jGhrjOyecOmTovxPcRzfLbv1191FR0ld0+12gGEfabqlz7+RuPpIq7P39wwKmj61fWgitVEnhHXR8qla3FNULRY03RQ5AZcQ==
X-Gm-Message-State: AOJu0YzUFB3t7hM9E8RVwgU8+QKtfvfDTua7a0wy0BkFv9UByRcE+pYS
	Dr94ajYLtSuxwW57Mo7j9GPEWXwbfK+mG3UkdzmHLuiPpjYTxv6/
X-Google-Smtp-Source: AGHT+IEKKxAsa5qR0ckGD76B5i/PDlzs6pb8uGNHqjubWiSAL350IWQX1YGY4rvg1lwMLmPMuINM9A==
X-Received: by 2002:a17:90a:de83:b0:2cb:3748:f5ce with SMTP id 98e67ed59e1d1-2d1c339f4d4mr1392884a91.10.1723104061381;
        Thu, 08 Aug 2024 01:01:01 -0700 (PDT)
Received: from alveo.moma (bullfrog.anu.edu.au. [150.203.163.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9c9cd66sm511366a91.24.2024.08.08.01.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 01:01:01 -0700 (PDT)
From: Zixian Cai <fzczx123@gmail.com>
To: 
Cc: fzczx123@gmail.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf script python: Add the ins_lat field to event handler
Date: Thu,  8 Aug 2024 08:00:26 +0000
Message-Id: <20240808080027.3559776-1-fzczx123@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For example, when using the Alder Lake PMU memory load event, the
instruction latency is stored in ins_lat, while the cache latency is
stored in weight.

This patch reports the ins_lat field for Python scripting.

Signed-off-by: Zixian Cai <fzczx123@gmail.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 41d4f9e6a..68eb0586c 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -861,6 +861,8 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 	set_sample_read_in_dict(dict_sample, sample, evsel);
 	pydict_set_item_string_decref(dict_sample, "weight",
 			PyLong_FromUnsignedLongLong(sample->weight));
+	pydict_set_item_string_decref(dict_sample, "ins_lat",
+			PyLong_FromUnsignedLongLong(sample->ins_lat));
 	pydict_set_item_string_decref(dict_sample, "transaction",
 			PyLong_FromUnsignedLongLong(sample->transaction));
 	set_sample_datasrc_in_dict(dict_sample, sample);
@@ -1286,7 +1288,7 @@ static void python_export_sample_table(struct db_export *dbe,
 	struct tables *tables = container_of(dbe, struct tables, dbe);
 	PyObject *t;

-	t = tuple_new(25);
+	t = tuple_new(26);

 	tuple_set_d64(t, 0, es->db_id);
 	tuple_set_d64(t, 1, es->evsel->db_id);
@@ -1313,6 +1315,7 @@ static void python_export_sample_table(struct db_export *dbe,
 	tuple_set_d64(t, 22, es->sample->insn_cnt);
 	tuple_set_d64(t, 23, es->sample->cyc_cnt);
 	tuple_set_s32(t, 24, es->sample->flags);
+	tuple_set_s32(t, 25, es->sample->ins_lat);

 	call_object(tables->sample_handler, t, "sample_table");

--
2.25.1

