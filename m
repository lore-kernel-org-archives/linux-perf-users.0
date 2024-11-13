Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B269C13049E;
	Wed, 13 Nov 2024 00:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731457717; cv=none; b=B9YtcAtY3mmD1vCyNl+eQG7GfOdnLnAl9g1kgiFSx30dBVVYzNhvk0SUI2BDtxCj2QUyuVZZwxGQaYFJiarjasyWP9CSCb8aWxhUn/P72VgD4t3BdP+FxpQwWxTzTw9TQjdGkcUhxwcweRfdBd5sK+OtL+msMn4HBYesVpDOpbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731457717; c=relaxed/simple;
	bh=k1Tn5Q4+wHFYp0tK7QptT/pbuAUsO9q/uZ8bPfpXGOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YeoXF7dFRKJ7w8O/hNU0lFN2ggllAX0KmY2W3OMvYtlnD7KAHSelIJmPC39a58s6OKqIpNAlpKXh0rE+enCbtml9c8sq7IJk1Vi+gkAcyy0UBDkYqMMb9D/Sk4WlnSi6V9NSnqyjM+cwVzLq9Hb7t8KQgUwvPEnCKUfqlTf272M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxsjsVlv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxsjsVlv"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cb7139d9dso59578905ad.1;
        Tue, 12 Nov 2024 16:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731457714; x=1732062514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/ufGw+ywqZDjP+CMDcVLPSB5OERM7z6+MoX4VJalRo=;
        b=cxsjsVlv2eoN07FNd8HYDSak4M4LnraNNkS3CNSpFjYsN6o1mFXSXbwsdAz4kYEAiK
         zwJqOydg1Ucw8XmPnLmJ76q2bmQNvUFkxytpO0sS74cz/saps96fU4CVz8oV5iS/HwWh
         8wvhu/qiE7d+0E8gguOBLn7cmlp2vIBEbSkQOjYcoVsZZ4Gjyo7iVxYtfCiy2zoXkQXy
         f8jNlywIFkkmOZf0QkoWVQEHNKJvdnqk+biExxHmyIus+RVDsUJJwzmbN9J8/2TfFI7v
         uRSNaNFNLaZlg9cuwWYn/Vs5s2jT8DFs4YjG92okizN3I8vW4Zb3p45I2QRyxNAjL3u7
         VppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731457714; x=1732062514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/ufGw+ywqZDjP+CMDcVLPSB5OERM7z6+MoX4VJalRo=;
        b=j+N12eQ+DoH8npu7X8AsME3enCDR1A0o0jc3LWmKOLER58njMLN1isAANZbYoPIEKJ
         1RH692r4qiE+h/b+2VspO+QKQ5UgfJMjISvY8TKxeB/3WCHP6qgso6NEgMSJvcKpntHz
         SbzswFfcHaGzx6rHwdao3E4WmvUbrbOGxB30vg41rZX3egGO4b1Pq9IhZhMCssPRB5pZ
         fNNydnyuYP36y5CLFgPdF1mwKHCc9IL7FHv6vBnyp1wsg6TmGKRKMTJAQFeOVjA7I4eI
         WWRIWkqd+/6F5XuUcmdhq/XmFVL1Ii1phjzgY7oMCOD9SmLyUztKTC6/0FMXfKVDaKpk
         fdAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5ZBEGv4c1svMfc2fzRUgZt5kjZ/A4cQ9LFppoDVh3hLO5l8zYoSNCWbWG8J6DD3t8oHwjZujABPaW+4w=@vger.kernel.org, AJvYcCWIWzNdWyeMkoEeLQOpOkDP1SFFKmVIYYPHyysv4R4vWTul+wj6KrQ47I0LUGGdOEswnlGRdNsoWEE22HAcJUXQUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjFCrJ341LNAw4DVdm58XG0qGj9YE1gx1OyraU0cutjv7KJlD/
	R6OqPtuRjNRA5N4G87I5sPNY0NE6lQhvBMqXRnqgP7fm5fzjQ1L4
X-Google-Smtp-Source: AGHT+IE9rhRej//kC4pX2pcD6Wh7QLUH124VswuZxJIVkoa1ynZqEutl03UpSHBBUBETFJBYImcUnA==
X-Received: by 2002:a17:902:c411:b0:20c:9d79:cf85 with SMTP id d9443c01a7336-21183e5ee46mr223905605ad.54.1731457713752;
        Tue, 12 Nov 2024 16:28:33 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e458bdsm100158425ad.133.2024.11.12.16.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 16:28:33 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org,
	peterz@infradead.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mingo@redhat.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v8 08/10] perf script: Display off-cpu samples correctly
Date: Tue, 12 Nov 2024 16:28:16 -0800
Message-ID: <20241113002818.3578645-9-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241113002818.3578645-1-howardchu95@gmail.com>
References: <20241113002818.3578645-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

No PERF_SAMPLE_CALLCHAIN in sample_type, but I need perf script to
display a callchain, have to specify manually.

Also, prefer displaying a callchain:

 gvfs-afc-volume    2267 [001] 3829232.955656: 1001115340 offcpu-time:
            77f05292603f __pselect+0xbf (/usr/lib/x86_64-linux-gnu/libc.so.6)
            77f052a1801c [unknown] (/usr/lib/x86_64-linux-gnu/libusbmuxd-2.0.so.6.0.0)
            77f052a18d45 [unknown] (/usr/lib/x86_64-linux-gnu/libusbmuxd-2.0.so.6.0.0)
            77f05289ca94 start_thread+0x384 (/usr/lib/x86_64-linux-gnu/libc.so.6)
            77f052929c3c clone3+0x2c (/usr/lib/x86_64-linux-gnu/libc.so.6)

to a raw binary BPF output:

BPF output: 0000: dd 08 00 00 db 08 00 00  <DD>...<DB>...
	  0008: cc ce ab 3b 00 00 00 00  <CC>Ϋ;....
	  0010: 06 00 00 00 00 00 00 00  ........
	  0018: 00 fe ff ff ff ff ff ff  .<FE><FF><FF><FF><FF><FF><FF>
	  0020: 3f 60 92 52 f0 77 00 00  ?`.R<F0>w..
	  0028: 1c 80 a1 52 f0 77 00 00  ..<A1>R<F0>w..
	  0030: 45 8d a1 52 f0 77 00 00  E.<A1>R<F0>w..
	  0038: 94 ca 89 52 f0 77 00 00  .<CA>.R<F0>w..
	  0040: 3c 9c 92 52 f0 77 00 00  <..R<F0>w..
	  0048: 00 00 00 00 00 00 00 00  ........
	  0050: 00 00 00 00              ....

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-9-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 9e47905f75a6..dd0f95c51571 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -662,7 +662,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
 
 		evlist__for_each_entry(session->evlist, evsel) {
 			not_pipe = true;
-			if (evsel__has_callchain(evsel)) {
+			if (evsel__has_callchain(evsel) || evsel__is_offcpu_event(evsel)) {
 				use_callchain = true;
 				break;
 			}
@@ -2353,7 +2353,7 @@ static void process_event(struct perf_script *script,
 	else if (PRINT_FIELD(BRSTACKOFF))
 		perf_sample__fprintf_brstackoff(sample, thread, attr, fp);
 
-	if (evsel__is_bpf_output(evsel) && PRINT_FIELD(BPF_OUTPUT))
+	if (evsel__is_bpf_output(evsel) && !evsel__is_offcpu_event(evsel) && PRINT_FIELD(BPF_OUTPUT))
 		perf_sample__fprintf_bpf_output(sample, fp);
 	perf_sample__fprintf_insn(sample, evsel, attr, thread, machine, fp, al);
 
-- 
2.43.0

