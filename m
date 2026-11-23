Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795418372;
	b=BgOHbCV0AtFxAk7wWh/3e7zMvxTWWDs+TUq23oSMEbDujSAVeCBw76TGzwfqsBaNsW7u
	 c799cU7sMp+nlp9tAy0xe0cVDm8xIaOuQZt/vAuadGPWSYbeTvpCCdTGcK5T57Eepli89
	 Mp8lIWLGQYH1k+xO6oXZAwAwJ7neO9+94HlJClqMtRL997U681NLb06GdwjdbFl9AtIyT
	 RJQOmZgX6ler79KwfRZWasTwdYs99cp0auJ7r5846qaSJo4oWbNueFHD7880HNDF7piCC
	 sEYDPF8Nf07dlH0V6bWy9nh+T97enF8kk1zaRx/ntSljDUfivHpqBKD8mQHX1289AdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795418372;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=qPfESMdrKb/MeidmJhok80X0fJ4udHOxnwEwH0xvgI8=;
	b=Jtdh560zFzeYDV5tTiabodRFTR6IRqSzWhf7UFYYEZkVIOf2Qq9BUV2Urgic6B3Mv1Vg
	 yRN7G8506u9f4J65GzaO9867FEF4Se8j5d8QDG0JfBdgDPZmBIiElWnoSpO6vHNzKysf+
	 mrmklx++NYfoPasX21bU9tlk7fz2K42jdwYLTe+wh42pwGDdwgo4FwJ9jkum585+86Les
	 1ELq7Ee94tWQJtcoTNfLYfbas1eyOjfsfI7kYPstZ67tLt2VtKIBwQFwvWMkwOhV/Msyw
	 VaU6zKins/KjPAqZM36T6qOKdreVuo9S8hVfqQcfljzRbwS2tIvgFDnSmYmOwNPwllw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ceGSKPT6;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37BB606A31F
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 07:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A37BB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ceGSKPT6
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-375bac6bd21so3438235eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 23:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795418371; x=1796023171; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qPfESMdrKb/MeidmJhok80X0fJ4udHOxnwEwH0xvgI8=;
        b=ceGSKPT6Ue64iZGfrcLoQAQP9W9jwLkrL8EjeWSuWGCZ4pdN5LJPLjWF5o7BqzLPjc
         WQftEtSuUhXBZuseZ1rRJgozYSSWVIFf2uUBU2C9O2QCSquu6RzForlIZCV6lTGfMerY
         qEE736z0hQTTCkXE7VHHQWLP7qVTrpy4U0BisfiB5DyIRYOnGdhHUVZ2+AI8Y8QwVfQx
         xRR9sXkN3FV5euFUnliXFOk25Am7Y6FgbPCPjgjXcgU/cIW+nDJFM4M9mc4BQTyN8bVX
         pJf1UkQMbq0l0k9pWEc3hRqM4nCm6QnDgVHpUXg9cHzVwcIeyDIOZGQk8HWOZc/4gE/U
         y1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795418371; x=1796023171;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qPfESMdrKb/MeidmJhok80X0fJ4udHOxnwEwH0xvgI8=;
        b=kSN6aj8iQFN+w04E7Ku8nslvX8FJkVZjkQt2qP7Lzp93NyJsDq8RYJTBIVfuVOqa4t
         BNjFRxOAzRV3sYHP/4t6lWsnZjcpmQLGSAkvccL8ejj/lD2o4DbGeanwtaHY5XbCUcVF
         KTEVoRLVxXD1bPwb32CrszLNrUOs8HcR1MbqRZxMGfklpmdaVHwKF+4ZqxVx1zzNZLuU
         GYn/OffxRbmejjpPEwMHxKJnPFBidnM54lAGoF3cHxkNYd7l7sv8yir3LHtsIofg9yaw
         zPUmE93JSMO6UN1khiu3u0BNZL5pNl+DitR0Xnfod7A4ZfXcXhVZ4Q/UgTXohiIveqsv
         OhrQ==
X-Forwarded-Encrypted: i=1; AL+hErHZOZDRre9va+dSH2Gt5wySCOPm/xTOK1t3xrs7jEQgRXJ4VQ524bvfghzhHR7w+FLmTHnzxfsMbW/RA80BsTHR@vger.kernel.org
X-Gm-Message-State: APuU4Z/oChCU2l3zSU39iXL2eygaQx6w8rv4IjhygdPpZeY0g6WgZeIL
	sY5C2ZWVcwj6G93xnyuyxnEl/+E1GEFAIl120VBKJMgUTw4iT9Lye7pZXPUucjF+wwDGGmY27jj
	aFQElR3RkJw==
X-Received: from dyls11.prod.google.com ([2002:a05:7300:6a8b:b0:386:af9c:96b6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:51f8:b0:375:85ac:d14f
 with SMTP id 5a478bee46e88-384b3e786bdmr14639447eec.14.1795418370446; Sun, 22
 Nov 2026 23:19:30 -0800 (PST)
Date: Sun, 22 Nov 2026 23:19:02 -0800
In-Reply-To: <20261123071913.653315-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261123071913.653315-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123071913.653315-3-irogers@google.com>
Subject: [PATCH v1 02/13] perf off-cpu: Fix swapped PID and TID in direct
 off_cpu_dump() samples
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Song Liu <songliubraving@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

__set_offcpu_sample() unpacks the first u64 of an off-cpu raw sample as
p32[0] = data->pid (process TGID) and p32[1] = data->tid (thread PID),
matching off_cpu_write() which packs (u64)key.pid << 32 | key.tgid on
little-endian hosts (and kernel BPF matches host endianness). However,
off_cpu_dump() packed (u64)key->tgid << 32 | key->pid, swapping PID and
TID for multi-threaded direct off-cpu samples exceeding the threshold.
Pack (u64)key->pid << 32 | key->tgid to match off_cpu_write() and
__set_offcpu_sample().

Fixes: d6948f2af24e ("perf record --off-cpu: Dump off-cpu samples in BPF")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index 72763bb8d1de..eeb2cb8ac0d8 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -236,7 +236,7 @@ static int off_cpu_dump(void *ctx, struct offcpu_data *data, struct offcpu_key *
 {
 	int n = 0, len = 0;
 
-	data->array[n++] = (u64)key->tgid << 32 | key->pid;
+	data->array[n++] = (u64)key->pid << 32 | key->tgid;
 	data->array[n++] = delta;
 
 	/* data->array[n] is callchain->nr (updated later) */
-- 
2.56.1.750.gf70dc682cf-goog

