Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F98401A3F
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303999; cv=none; b=fVPixV0zM/mqGdWf52r7znvIxAfNuVK1oE3LNL3P+9clOtuCiHs6G+3pcENNh3C8PVcfi8YjjUd8SXn7aVK/r8+6lvBtGwaSg8ra5a97Ujr7h7hIlwTz7PnAHbiFyZXfIH/APr8p/Vjd9UL7fGUI9kMTVjVnSxzdCcikgvqW3q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303999; c=relaxed/simple;
	bh=2M5rXmJ3rg66ZyLEjBuMA3CMdMUC9+DRzQaj4akJ76Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=usGAOOmymvY2+R44k608FvfaIVD6/8xH2nvByB/M5+YcW8fpGVh2TslpcxQUDvlFFkmN7fb9I8IEBh64Uehzgti7lGykrZAPyS5tpp0EJzWj3l8N9RH8aIVNTp7LykhwIqw3S8vDDkzP7U6SzEc4U3sI0kjlBDzeiqdI2weyvSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lTLZX/DX; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lTLZX/DX"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f9f49e4beso2607176b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303997; x=1779908797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x3pEwg+RW1FBx+3GhdoF3AbL/Tg6ZDZTjvlbAIQHLO4=;
        b=lTLZX/DXicbRjDCr2b+IBkmLCpBPhAcB6D1zDk9t9f5I5d3o5nTTfeaVemoAT7dxDs
         XAVd/R8VaSadhShNbStL0lKEp9HIWRk76zAqUo92ozYGLwere3KnM5m8cWo6pypAtLAr
         wbIN1u0h179B3ILbkh821YGH1i2ZsCCms+rTVDSnDThM1DA0EC4SxmkcBkwzCvRcCwJu
         Uh/B+93zR7YMfQnSKLqVaQ488rxSB9vadyNU2MJWU6S1rMw1pgkO89+grVAu9v8DUFoy
         aRNBBU4GHLZruJXVP0EGyeAvLEfGp82ruuniHR8yH21AZnHJIUCoaO5Kec8mwauspYug
         YeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303997; x=1779908797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3pEwg+RW1FBx+3GhdoF3AbL/Tg6ZDZTjvlbAIQHLO4=;
        b=TlVssCSndO5ORoN2pB9XgWAOF2jumYGNWLAIcmSKhKl5PUuM41hyhF16qc6NWYMBuh
         XM1UJrRQI60nKlJefpst5C/s0R48A9gswvV+qN12FHgOvzLp0xW9FTxkR6Jp4KOTvbaY
         30813fQOCgzCzk2vFkSoGHDtP1QIHX3SE+Ac0boaczfqYVlVwW8ciR0MvrKkT6/6FxZM
         CHjT+I2aOTDCWpYhIxWWzFcywrllMOmwzewFzisU5F1ti+CT2DPZO3ihNkl5YLPqUmGT
         JOrdEjrbnVZYGCwQZwKuLhUM1eKajyNK4/M7Y1HMACh9/3qYXzvJV5wy0mq87lUqnaak
         czHw==
X-Forwarded-Encrypted: i=1; AFNElJ9kt7PThnGcQhKRcFZNa5eVaEvyVICEXMeXJst/VFBERVwPeTf8r583291ITmgPYf2AHfV2TXOplpv0328CfwsN@vger.kernel.org
X-Gm-Message-State: AOJu0YzHyQG0+5tBM8CImPXxYmFpnpP5M1Wu3vC3sgXeQNkThetS2wrd
	OniYZGdfvW0c3+BFcemiejQyDYrzq9HiAAm/mALEulS3jPwFaS1jRwJ9+h4Knzv7+H79sx+ZPus
	snmOXVMvr3g==
X-Received: from pfbem13.prod.google.com ([2002:a05:6a00:374d:b0:837:8d8a:cd3e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4094:b0:837:8b75:a5ac
 with SMTP id d2e1a72fcca58-83f33d8860emr25854742b3a.34.1779303997265; Wed, 20
 May 2026 12:06:37 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:32 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-27-irogers@google.com>
Subject: [PATCH v14 26/32] perf synthetic-events: Bound check when
 synthesizing mmap2 and build_id events
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Add robust boundary checks when synthesizing mmap2 and build_id events to
ensure that filename fields do not overflow the fixed-size stack allocations or the
synthesized event structures.

Verify that the filename fits safely within the allocated boundaries of the
mmap2 event structure, and prevent potential heap/stack overflow corruptions
from excessively long or corrupted kernel filenames.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/synthetic-events.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index de812a2befbc..0816f893b916 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2257,14 +2257,20 @@ int perf_event__synthesize_build_id(const struct perf_tool *tool,
 				    const char *filename)
 {
 	union perf_event ev;
-	size_t len;
+	size_t len, filename_len = strlen(filename);
 	u64 sample_type = sample->evsel ? sample->evsel->core.attr.sample_type : 0;
 	void *array = &ev;
 	int ret;
 
-	len = sizeof(ev.build_id) + strlen(filename) + 1;
+	if (filename_len >= PATH_MAX)
+		return -EINVAL;
+
+	len = sizeof(ev.build_id) + filename_len + 1;
 	len = PERF_ALIGN(len, sizeof(u64));
 
+	if (len + MAX_ID_HDR_ENTRIES * sizeof(__u64) > sizeof(ev))
+		return -E2BIG;
+
 	memset(&ev, 0, len);
 
 	ev.build_id.size = bid->size;
@@ -2303,14 +2309,21 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 					  const char *filename)
 {
 	union perf_event ev;
+	size_t filename_len = strlen(filename);
 	size_t ev_len;
 	u64 sample_type = sample->evsel ? sample->evsel->core.attr.sample_type : 0;
 	void *array;
 	int ret;
 
-	ev_len = sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + strlen(filename) + 1;
+	if (filename_len >= sizeof(ev.mmap2.filename))
+		return -EINVAL;
+
+	ev_len = sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + filename_len + 1;
 	ev_len = PERF_ALIGN(ev_len, sizeof(u64));
 
+	if (ev_len + MAX_ID_HDR_ENTRIES * sizeof(__u64) > sizeof(ev))
+		return -E2BIG;
+
 	memset(&ev, 0, ev_len);
 
 	ev.mmap2.header.type = PERF_RECORD_MMAP2;
-- 
2.54.0.746.g67dd491aae-goog

