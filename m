Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBCC22FAE1;
	Thu,  1 May 2025 02:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746066507; cv=none; b=X02UsXpjj1ZajyvNx1rH+28vUOtWAxzXrPgRmz4ZteYbrSEEwU4T4uqbLmL37+lZf+8j6WSVMAfHBKeXjMtg6UVnyaB2MGh89M5RXRHwXiQV8/+o0I8Qv2MLAyYBMiB+Z3Nt6zTJgFOUX+yhwTFweHXcMTD7m1+BTfKk1W6xc1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746066507; c=relaxed/simple;
	bh=fkqYzF36h6AgRaLeSgkPKbTgXMvVxYruaKPs0gzkDHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Chne+xTB/nqZSKAK6Z5aLZvXWccg2cn4J+Df3Wi8obBDK+U+0wwVHxZGRpBNvyvmw6ykiufGh994HvMA65aCywIBb/ondceq9AN0um6kKUx6f0RXTLfjUMpFWxkbTT28AzC9bFrTJNwfMuLXbDxn+5D1QIbrLXKYyVBL5m0o5go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikL+KCkv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikL+KCkv"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736c3e7b390so547489b3a.2;
        Wed, 30 Apr 2025 19:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746066505; x=1746671305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTjiJWBJ0ei7byXhRRPp/TXdgUBSDbCjGFLqGPTVJoA=;
        b=ikL+KCkvbJRMynXiq60RK0Q/zfmxJ9uO2rIVKz8W9Tz/CtbHO6WPKtsG1DjuwAKfAc
         RPlif/xtfFYyoP2kt9YLMz0JZ40JOghCk6x6pUAjxzoJ9uDChLGAuywCtliYlu4+iqux
         p/M/S1n491j4x49FOqy2lWFA5RvG4YPESFtE7gZeQOHaG4wHhIZ9q2HbA12uJqw9kyg9
         unHsAN8GpqTHn2vRj0L2xbuIQDyOLHqtB0cUVVyzY0FW5YbqdEFvY1Rzqix6rTmC56wv
         fhHcapav6RgXinSyYH9qFzq9LQO62A3nkMhgjzptlIVztmV5f8T2eImEkI+KVgSuxCda
         3e4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746066505; x=1746671305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTjiJWBJ0ei7byXhRRPp/TXdgUBSDbCjGFLqGPTVJoA=;
        b=t0ddHu4iyiDK3JKlhSfObB9ESZ7JakL+RBczVk8+mKDp7pjRZ/v16Mj6bvBwE+F0ZD
         XIrHz/z7thJZIQk/fO2q0Cjk3Nu/7CNqrAXc8Fta4UYY1E2X0bqvHFOj4QG92b+l8Qzq
         wqzWCjVhAbgG1brzOW61aG72jTJ9cTcYRF2Bh6dtV+zVqUjGQr2qW8bDnyK4Sp0W/0Ma
         hdy6a5zUta/aza7wKgGpee0CCIOvMB2vKoxi2qWi3llFpjp+psxwrcBK1J5LWnwI9JGh
         SUO91+nBuC0RXZGTDbn5xBsOCAjIicAt26ATlSHmH2hlRgDiw5QNkc8ZyZ3I6Jd4I3sK
         0R6A==
X-Forwarded-Encrypted: i=1; AJvYcCUEWTJNYKtRVC9kIGkxzwp2iHR/8ISZliaZ88HS/ZP5sCWtQLtXekOmqk7iAyKJuTr4QC1cI5YaReRcUF2RJvhanQ==@vger.kernel.org, AJvYcCVBrrlrBZJQJiWgxVeeufWyuXU6zemzm4YPP6Dwp2ViRsBYq0cEbZ7r5AogXgmiWsyX+apQQ1cWrarc3ec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy48+O02hSfx/wmrjKmy5Z5pKUDiDA1tD6T4TDYhiu4QsSic0W7
	MKLijh3Ahy0yYxCgGQhgDtvcbHfLCcs/IkvEj1NXjVJKcNT1gwFL
X-Gm-Gg: ASbGncs9Vb2G3PuAbVbUOst/+i/Giso9RCoqCsho4Zw+89HpcCpi9LcmtXVxeNNUOVh
	5y9bNzQlcpn6cTdgcu6g+CJ/oxh/iNGQnSxD6CVuDVIdKtzTWbiaeAi94kYMQlcaPnka2ToxgQP
	xeAxFZcAPeiZF4PKADM9UmItO027OBYjrDFOi53acd8UaN2iscHLAr/6jfKPuBQ6DDF2sAdboRn
	Ix3zFoy80G7j59sZSZxqOy5uzcCypwl6b9+mtQXHVNcmTAa+cK6rj/YzWissaeqicfxpUqMS2HQ
	JHBUXgNwOmR7LnC22pwp3XlVbOYGJbzHnh1gNnfG/O4AmKMsAf2u89Q8DBh3fDnFiPnwDBZMQPR
	0GXgdQFT1VA==
X-Google-Smtp-Source: AGHT+IGXNTTLCqWQqzs3MU3R+DswRoGpbzJFNCcnJdqEEJJ1A4VgFf3QRRQJFdqonQq9NkCkyHDktw==
X-Received: by 2002:a05:6a21:1585:b0:1f5:889c:3cdb with SMTP id adf61e73a8af0-20bd65580a0mr1249766637.8.1746066504677;
        Wed, 30 Apr 2025 19:28:24 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a8fbe7sm2459599b3a.160.2025.04.30.19.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 19:28:24 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gautam@linux.ibm.com,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v16 07/10] perf script: Display off-cpu samples correctly
Date: Wed, 30 Apr 2025 19:28:05 -0700
Message-ID: <20250501022809.449767-8-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250501022809.449767-1-howardchu95@gmail.com>
References: <20250501022809.449767-1-howardchu95@gmail.com>
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

Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
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
index 9b16df881af8..6c3bf74dd78c 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -680,7 +680,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
 
 		evlist__for_each_entry(session->evlist, evsel) {
 			not_pipe = true;
-			if (evsel__has_callchain(evsel)) {
+			if (evsel__has_callchain(evsel) || evsel__is_offcpu_event(evsel)) {
 				use_callchain = true;
 				break;
 			}
@@ -2295,7 +2295,7 @@ static void process_event(struct perf_script *script,
 	else if (PRINT_FIELD(BRSTACKOFF))
 		perf_sample__fprintf_brstackoff(sample, thread, evsel, fp);
 
-	if (evsel__is_bpf_output(evsel) && PRINT_FIELD(BPF_OUTPUT))
+	if (evsel__is_bpf_output(evsel) && !evsel__is_offcpu_event(evsel) && PRINT_FIELD(BPF_OUTPUT))
 		perf_sample__fprintf_bpf_output(sample, fp);
 	perf_sample__fprintf_insn(sample, evsel, attr, thread, machine, fp, al);
 
-- 
2.45.2

