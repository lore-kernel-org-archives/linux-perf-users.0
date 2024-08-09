Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCFAC8D1;
	Fri,  9 Aug 2024 08:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723190522; cv=none; b=cxg7lLO982vU0uUDhEVK8Fsi+scQCK42MfH0bHICP6jULUpgk8aNYW71St51b2b2GMPGdoFZylzaGiilN28crQWi5mbIaHnWBXbRZPYF18GUYUuCwwjpBw6yphw2JUZtmR6Zx2C1W89PXQnAn5VG9nwsaOdN9MAsSGWLmWkJe+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723190522; c=relaxed/simple;
	bh=jQjWmYNbejJ8eAQkjviIwQ3DgSsmbdepFeqkOM1I6eE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aFWA5sua3tHT9fROXk/S2U8gJt8vZtZcaVMz52VLDPYrgVLYhw5zBOT9S2s6sLQQZ4Y1l0iDFjWU2vN3zfiVqPN6nm6KW4wGok/QApnOAt/NV9rL6FJmmI4NH1u5Kl/JAwnR2oIcB+H7H2FVX8hSjNfRzNoF6QFMPZJgkhY+CoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTGNs2Z2; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTGNs2Z2"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cd5d6b2581so1452036a91.2;
        Fri, 09 Aug 2024 01:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723190520; x=1723795320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k1CNYqLAJBSiRCPmzssQ1Zg4wb+jIfTjQrz6LCzlylA=;
        b=QTGNs2Z2Fpaf7EFDq6VxvMCbHEkmjeJ7KHaTiIQ0Fz5tvvP+q8jWMjZXjFlhqEHdDa
         e/Z8hg6hmmoLPM/NyCk2BZdAh8Zn1R8T0G6frfYrf6yEIHAzqCGU6RapX9tes6KFReuZ
         tGLMv3GhRs42EApFetOgkTKDS/rK7vjavkLLrNDXzihTs9zhDHpZxkNSMkHAQx8zAave
         JbvUvZt//80VE70IpprH2M8m1ayyJ8DjugjjBqcvRyDld4qrhHE1R4kOSdhMa4RZTbJE
         P/2svIGnb8vT6Nd167+hm6PjJ2aPJwypdpKtrcv4umJ9YppXLBgTyj1OIRfWqhBXFCWs
         CJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723190520; x=1723795320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k1CNYqLAJBSiRCPmzssQ1Zg4wb+jIfTjQrz6LCzlylA=;
        b=E7XEs2BQ6laUIblnCrAz/ovhyFDYY04S3CCli3TxWlF2K21QsJYg/G4PT7hEHTvJM8
         /bu2QLVBjIvPcst+V+R20Q2Mgi19RWm0wUPMlM+EUXkijcab8oH78tDhdJ7/GjrSWrWC
         eV0wzsHmVkdg/9zXzBpuL2goEjQnwzuvwCwNSbOJ/5BWqfVTNtk7XJUmX6pXpkAao2cS
         gl/gX/CRLfPst7pAntBgV7nqW2xWNLjY3Iucq3AY0zO19a+X+d2SCA3ZP0psxd0vYA2v
         s8ng04xQQNOE0Y3FZGjtVjBiQn6QiKucyHkBOFLOTpI29/Zt1IOkme3+wuqbyjVHi8xR
         1IDw==
X-Forwarded-Encrypted: i=1; AJvYcCUo/ykLoeEHCFQqEnW7XqQZmmS0S4fMG6gr067NozywjIFl9Bpzs/LfhpeQ2kwLV2GVg5mqlgvHzwKPWJLn8ydHnyORXVatkvoks7ioKMHqqzRPVtOYTFHMIMYLnAEGNnpd8tcnpuXwxwyh9jM1Bg==
X-Gm-Message-State: AOJu0YzCORYtLoOM7k4+G0lc12YV9g7wwdfyKtEYJTA4M3F78JFwnuc2
	kQunv/ZCMpn6vk0T1W4WiaPKdlI5Q8MomwJ3kckaun7CZAS/ozSS
X-Google-Smtp-Source: AGHT+IEPSPIVq9WWED3UQMmchGn9WG0dcWWIQ5HvpqN3kBBE5FW5DOwqrrTD5CynQLzz8ScVxMyrlg==
X-Received: by 2002:a17:90b:1806:b0:2cd:b938:770b with SMTP id 98e67ed59e1d1-2d1e7fa9fe6mr672079a91.5.1723190520437;
        Fri, 09 Aug 2024 01:02:00 -0700 (PDT)
Received: from alveo.moma (bullfrog.anu.edu.au. [150.203.163.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3addc29sm4694276a91.29.2024.08.09.01.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 01:01:59 -0700 (PDT)
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
	Ben Gainey <ben.gainey@arm.com>,
	Paran Lee <p4ranlee@gmail.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] perf script python: Add the ins_lat field to event handler
Date: Fri,  9 Aug 2024 08:01:36 +0000
Message-Id: <20240809080137.3590148-1-fzczx123@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For example, when using the Alder Lake PMU memory load event, the
instruction latency is stored in ins_lat, while the cache latency
is stored in weight.

This patch reports the ins_lat field for Python scripting.

Signed-off-by: Zixian Cai <fzczx123@gmail.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
v4) reformat commit message for max line length
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

