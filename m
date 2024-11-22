Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B1178CEC;
	Fri, 22 Nov 2024 04:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732250339; cv=none; b=ar/MQv3719WwLcfLk/F5vRUBfEGOsr5dQSBJoWFI1AuOxPu9ySYNSoqLh7wsPuG0TTwWfpuBYVDHLxKueN58lKsdDnkAQ06DrUDcBnj95WXhUPu/7Ms/6o3L/TvJPPkR8VbxvDp8TK2APCsWkrdJ/yT8kWlcom2TwCVB202NXGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732250339; c=relaxed/simple;
	bh=k1Tn5Q4+wHFYp0tK7QptT/pbuAUsO9q/uZ8bPfpXGOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJQIDU5/4PzCTAzcJ66Kk+IR2evQJUHQQbEi+F4WJq6TdxKe1xj4xK60OzgT4otA4YM9pcBo6qSSfJZbAThwrJPflJTA9D9j8P568ZnuWMsx1VVTArTWkhKEXsF9EDRmBBR5NKtjNKar/RoeEGwjj+qo8dKE97/iE96+KURe434=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYJmMZUY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYJmMZUY"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-211fd6a0a9cso13451505ad.3;
        Thu, 21 Nov 2024 20:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732250337; x=1732855137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/ufGw+ywqZDjP+CMDcVLPSB5OERM7z6+MoX4VJalRo=;
        b=PYJmMZUYsyes6Auxu5Spuro8z1E8I0W0VF7wuNBGjgxZhTHFMYjIb0FUpLF0QkYVoP
         yfhs4j/pxursUq7D29chp/SludJE07b8J4Fc29Z4jptbs6RcZhael05lngadjrHv/7rS
         UmtOn5M9tEL4kL5tGko7KRsSxagfl9BHu2vhNwp9jn88zLsUkn6+CcZSK2PZ9SgPGyqn
         3xbcm/nwUK0EKsq1IKBA/omTmSyw5CD9VsZpK7vIMldpvwoGyhzsj5heDjtydFTUgeBq
         hzsY1w1XKVjhO0dJkO5dI4XhmZCvWndOLYLOQJ4peP81qXkP8HoH49qRZYZgf0zha4Hk
         0gqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732250337; x=1732855137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/ufGw+ywqZDjP+CMDcVLPSB5OERM7z6+MoX4VJalRo=;
        b=DsPOHMmMY0VQRO2Efrlo+w3SjrPiQ6NxKjXgIP9tUb0g364K8pWxIm/QnQkI66sQbm
         kQfBxYSP/Z/dFSa2PN9dRqaBtTVxrNSgBc09qUtOAO/VtyJAr5jMT3CUAu1kaiNuKF1W
         dcTTzb37C3cW8NViFv/xpoO3b+4s4fkbN4DDC35gAfqsTRZa9ozl33DSbE0rkmD36L/L
         Jtd8CTlMKtwzNGL14s65t3KKTXPZiXZgxTieTPtsE3ROZu+k91ZtWBtVpwr/a+2G3M2R
         QClmZY8WWUDiJzq2W966WOws/srnJ1qA6Egm+R1t8PgxHCWCguAiJSFw9N1hgVT9U6UH
         QCzA==
X-Forwarded-Encrypted: i=1; AJvYcCVXKnn3/1GReL5mPYZBi5jRb5hsVtcpD0z8aSHC9LYeeu6cZEJSywq3wp7ji2Hmetg8tjfA05zWtfBsAOT3Tsln/w==@vger.kernel.org, AJvYcCVpF7+aiIPpzNRZS7Sba5sJXVlyz/4vCXYhnQs4R2N2+eKDbJ8eVoI7mlCpknn8DjCpAEnZU+gcJloHWC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDvlotvs+cF7e/1j7IhdWwUS+YIBE67bRAEDQZvG12RvzwSMO2
	ApRocjnsYcEPOnYZd8WW2l9kHbBfEssvW1aOZoW0JCsaCBgUvHps
X-Gm-Gg: ASbGncsm85XC+ZL8HmoHRi19bmbnPTWIUUaymgUaRbVsAwc7tSAKm7xt/8lpsj1O/C1
	/D46qLh/Z3hcdX7ZjXPARDX1oVjiODG1CC5vF+F7lWbkv+ylADAydCfNmbKjp5foX8VmwCD3Hr/
	xNUGTyrg7CqwgljQ3h3VfTaTDxEzN8j51Wj9PeP63rqHtTIpRfsXNPYgykctuzSS2ap3W7BwfnF
	Wp86KqOVYDUADe8ahqmcbgUPcQGgx3Ze9GS3cfWewOJjkZlVQwgHv2ReT44S7G7a6wbWgoGN1DD
	f7dhPaQ1BsE=
X-Google-Smtp-Source: AGHT+IG/vsXjfORiqcE/D0/VZ78u8WumP4LMWP2uzjUHQE/j9P8Tj3OU/FsK6IqjwACcLNr82CA3MQ==
X-Received: by 2002:a17:902:f685:b0:20c:9326:559 with SMTP id d9443c01a7336-2129f240de5mr23803355ad.29.1732250337056;
        Thu, 21 Nov 2024 20:38:57 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc1544bsm6638135ad.193.2024.11.21.20.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 20:38:56 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v9 08/10] perf script: Display off-cpu samples correctly
Date: Thu, 21 Nov 2024 20:38:38 -0800
Message-ID: <20241122043840.217453-9-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122043840.217453-1-howardchu95@gmail.com>
References: <20241122043840.217453-1-howardchu95@gmail.com>
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

