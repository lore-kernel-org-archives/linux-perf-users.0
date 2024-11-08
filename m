Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238C81F4268;
	Fri,  8 Nov 2024 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098518; cv=none; b=XQja5elqcwd1KBF1v33nq/yQisszeEBapwbWLYOPWxCOAPvZbb3gsxweG5E6P6bgyzLJWHitxqNIP7aajD5KsJLqAUUR85y7ZL+bAWIB2AljCu6P/mLEMx5qjHejNZRyUwGUz5mlply7VTIZbDxxsQ/5L1lgekCrIXgvNFykaJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098518; c=relaxed/simple;
	bh=12+uD049fjwkxVoV4WCg1PeWhTB94q+vKcGdt8+toqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVzVRtEw7M0R0iJhLyoP8Oy18NPZetimH2PmQW6Joy4kpbzyW/ivgpbTJuG05BCx7o3tjaw94ks3GSjXaBIFc4ftZzZ+TNDS/cFxi7jCpY/UFJiivW9iX2Lu0LsSVJtTSsVRnfSj3pYUGCPkKSMNOArQ6X85HYkHz8rPQmn0Cwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzAUxCUj; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzAUxCUj"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71ec997ad06so2175155b3a.3;
        Fri, 08 Nov 2024 12:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731098516; x=1731703316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOpZE2LcrB80WvS5jTyTSJQgcV7CMCHPdi15yTc4/HU=;
        b=VzAUxCUj+5b8Il+aaNiaJvrOjlhPHrX4pAVpSPttCnE3oVwJ6GZvyKWcZJGXHOeM5e
         u7byNqr88VpcXEQIjHROxxyYpN3CMv3LaY+1VkaOm2HPvN0SwHyL2XyxdHTntnMG46t7
         De7j8wvF7BIIKNErCKoP3zm2YQJwH+ni6LyrJfZd+ouUc/pbiUOSYORcRbnl6PsgDx2P
         cW4KyZqA7kQNe3XdBH6rEBcclPCBnOk3NCWhiDGcqoB7mjpi+GPRzK/eTeep5wbyu1pN
         bRv7Y/GmT5oDpXywOph17gCpQey1tNwEyq6nTMZWihnGBzoxajubkbTsZ3KYO5BMRNrX
         CSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731098516; x=1731703316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOpZE2LcrB80WvS5jTyTSJQgcV7CMCHPdi15yTc4/HU=;
        b=nVrdIM9bwHcPJihbfK7ip9eOHsAqNxNbsry5TSh4XkuuUvnLLZL2IgT60Xy3bO8DZ1
         6R7czxugGn9IXlFZK1ELlMwiyD/z96db+80LEt2HxmE9A1nMP8NguI7qp9zrpYOtehs7
         rq50wFrwOQlsJV812KPJaMkF3x+hC9H7aa+x6AFKVx4sIOqHWCVqswxX3UR8G1HZrMCm
         rSYTtkXoJOqLuKbY9T8MHRgBVe824J8vksz55VP9ywXinN0oVs4NkhahGa5kEt23XSBm
         6OO+MLk6YEUt0z5NgdT18FxoruAoM0apkzD/D25BvxxMlGvBFGgHCXcq4ZbR95JmzLJh
         G03g==
X-Forwarded-Encrypted: i=1; AJvYcCUGqRjROYav1aAhzr60BlfaNeYBledEwcv2K3vFEsimv5HXn7hCscWPpHFUqgYdq9JlT5oicA3fFeNGqSN3jKV2ig==@vger.kernel.org, AJvYcCWOErrvb8PScNPQE5u55FU1R4mMtazfLo3UoEVu4aFiOlPa03OK/x9y0Y41bBRaWJVvqzFpL7NScpX0p/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDbQgqwAlKBaU/VBhFhhevTpn6somEnNTzhroD/7jcZ2hY7ETq
	EYfQZX/iawtbxU1Mfd/2VXy7hCgULUV8jp4DZJIj5lzZGHm9iX3K
X-Google-Smtp-Source: AGHT+IFyI4Nd9VSOBU81IqsVewbp5rZ0ZfhujkSQoBbxhadYaZ+78gPGZ+gEZ8z5c7yIg8YifZLL4g==
X-Received: by 2002:a05:6a20:12d2:b0:1d9:386d:9441 with SMTP id adf61e73a8af0-1dc2292f447mr5839965637.10.1731098516228;
        Fri, 08 Nov 2024 12:41:56 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffe3sm4221945b3a.2.2024.11.08.12.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 12:41:55 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org,
	peterz@infradead.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mingo@redhat.com,
	mark.rutland@arm.com,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v7 08/10] perf script: Display off-cpu samples correctly
Date: Fri,  8 Nov 2024 12:41:35 -0800
Message-ID: <20241108204137.2444151-9-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108204137.2444151-1-howardchu95@gmail.com>
References: <20241108204137.2444151-1-howardchu95@gmail.com>
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

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-script.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 6b6d4472db6e..1893d2117aab 100644
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

