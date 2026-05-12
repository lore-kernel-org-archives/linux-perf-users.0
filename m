Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B52F3AF674
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625082; cv=none; b=HRbylltSkmKXFyUGr+N3XBCNCNdUQWK1I+h9M17ivuouzgNZNOFa7ggKjBySSDQZZwtANsnGZ1VgiLzqPKueYeYJhiayy0kgHqM0n6leDIkWavLIyeTxySgovFU+utCnJLC9NOOoTHExDSQ/beBrvnnbY0H3VpF3YpjigiBQpP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625082; c=relaxed/simple;
	bh=cWFkCnwmN47YEO2awp8h2PoR0LtA33YpIQGMtO8FQUc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PQConbApse+4r8946lX9jrOEJBzUzxvh0w3CCs8zdu9K2I9sl1ww2F4+OAcQnESgeb3bIAHDiAfeJDGIrDgDfGcZJElxJGOP2krGqla85CkU8LlcmygRYZfMmgt5IJTIukIZAQ7rIq//h0AbCCUFno6YJIH60k1LhtrL7lHCl6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YfTCRGR4; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YfTCRGR4"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so9816301eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 15:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778625081; x=1779229881; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OZrxfmN+xSdgCg4EqbHGMau9xJX3eFGD2SKGVLG+qw0=;
        b=YfTCRGR44UgePXa3aofb5HBAMw/Odx9XVPEML5AgT2oOOixHYOozw6Wiyu68G8dScv
         6P8YhFuO1VD++t7oOnvGM9IHk3k5xTiEpgtJcwilbf577vjd2N0B1BGwYjv4aJjVFOIk
         8KFkq4gVnB3kvFWmgqxaDUVYT7iS5MBPokhwmm+DX7tdqF8vA2+eiefulncl0Rgu4ANW
         dcQGqNXd3H6sZ8JHD4sui/uZRfNSbzIW4R6qEmlImQrc99SzMkbxBoUVoZAq5WHwyILZ
         3kejBztHrsFmRa759DGRwyTxXx5TX5IqB9xKv7ZcBxRfvqiAFLGTKwEoK1yDIzpIG5dR
         AsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625081; x=1779229881;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZrxfmN+xSdgCg4EqbHGMau9xJX3eFGD2SKGVLG+qw0=;
        b=VjMPi7gVvrDZS0sEivPZNtIAdq0vAUtETZBRcfhwjIhXwjpYr8jKdjynxdzjhYv1sw
         zwgWrtBXxwmX3gK+u/jj1i3Po+uzuVKg+FWWnDY4hFPDlJSTOdbB5tLQKJMhY4s6Uptt
         WUf9C75QFtyZWblLQW8gpII5ExWw6F+fHCa9FYPYUGhmSBcNbyRq4o/S5ajMXpDRSNZf
         ISUYQkoBWyaXkRwb0RZ/AXKdzwMRNNDAP6gfXF/G2caDIQoMYtwITLza0OOBb5a5Bv4f
         WsTEwASBLqWfNZfYEOoBJrv7KA2kmrddgIX875dvzr0t4W61m7cvGk3NsUot21U0PTK9
         NvYw==
X-Forwarded-Encrypted: i=1; AFNElJ+Dmkevh0XBlU6YpgJlkRCOHQIvzd2w+1yV+o1uK4/1vIXM/OZMFC5JXY+2gNrf6k399te5PVgSfqv2K2dqfDDY@vger.kernel.org
X-Gm-Message-State: AOJu0YyX0yjXQnhW0QR41r6EdDtvQtZGjVe2Nao8w5+Yci/x3C25oCbq
	pR5O15TGZEoP/ECz5Qu7nYoHd1yku9Qpy32t1OJppGWeGXgg+XAPxRGXFINYqifjwhh/tPgzuqK
	1n9HKkILLuA==
X-Received: from dlad11.prod.google.com ([2002:a05:701b:220b:b0:132:8d92:4d79])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2527:b0:128:d577:dc21
 with SMTP id a92af1059eb24-1349a80df0bmr174709c88.13.1778625080515; Tue, 12
 May 2026 15:31:20 -0700 (PDT)
Date: Tue, 12 May 2026 15:29:55 -0700
In-Reply-To: <20260512223001.2952848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413041143.1736055-1-irogers@google.com> <20260512223001.2952848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512223001.2952848-27-irogers@google.com>
Subject: [PATCH v13 26/32] perf synthetic-events: Bound check when
 synthesizing mmap2 and build_id events
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	namhyung@kernel.org, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Prompted by Sashiko code review, add bound checks when synthesize
mmap2 and build_id events to make sure the filename doesn't overflow
the event and lead to stack corruption.

Signed-off-by: Ian Rogers <irogers@google.com>
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
2.54.0.563.g4f69b47b94-goog

