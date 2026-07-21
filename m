Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF76442118
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784675407; cv=none; b=PEPrhxSR8UEPAwGzuO/DwsWP6ySimvu128xFjcvorsAJOVpL6mOkn7bHtu5SmzVo9RvaaJnNsUc+2Tqi98CF5feidBmnxbS7DBIDC4pqFnUQndf8mgqEp6bpJsgP2sEZ7F9ceTWZNYlKg5P1AIZdmvmA2oNx8NZUGBX9CkNbA/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784675407; c=relaxed/simple;
	bh=Rhr9/VWiAOU2ysPViZ6y1/ZtZdHQlWxwu4lXWxiMujo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VwICCiL30BNYRt9TCPJbT+dljmDDcyd6vpagJd3NHgK1x0+IaQW22YogrD4Jr3HslKpbVklXjy+Ie7ZGK6QEaSMYRfTG9XsI7oyhNHSxtAP7Z2Z3taMcGdX81KsE+LnxPp4dcceuHbIcEI/0ELio9ay/r73TxPEZ5KHHhx69kEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CxnRqwZ4; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CxnRqwZ4"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so7338242a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 16:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784675404; x=1785280204; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WPc/SptN9OuaHPCuk46SdIx0RLVLfa1pOthKWdfhXgQ=;
        b=CxnRqwZ4PirDimVTmQYtDk/aQQhhmhAwPB/CL/E0lDnVmGypfOJrlyX8Gq6QySsQh+
         vNZGpVyxh1QEezi0308Ytc8hTRZXTZ0J6UJmEIiv1F8jmRAkC3xmfYMsnRt1IFvlaRnc
         yMhT3td1bOlYNQih9qCDjjquIEyIZxJ8P6oenhP5d/l7k5tQyXyFrslWgeE3Nm+FjpKc
         DmmmFLZRx8jAdtELvoppKvw/6OaO8WZ5Sy7LwbqjgnqD7CfFbe39UCOaGi4tQV9WJBrO
         TiBO57da9gs6RoGXSw7NBegAarJgzNop5j70WV5RZo3DV5Chq0a2oE8x+REt+36JnsQG
         Nkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784675404; x=1785280204;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WPc/SptN9OuaHPCuk46SdIx0RLVLfa1pOthKWdfhXgQ=;
        b=Acp/YF11cXLBBrdQN9wOCJ6jXWMHbNrDJCgLa4MBU17ADU09gH0bJyL/xoCvabLjHi
         PCizQy0Bb9Gvd5fXomBfaNEIRAF5n9L0jtJP60vLHG8l8dJuqQP8vIMecgvs9roLdk4m
         qIdmEzfGzs4KZI1Wh/67uNDnySIktGPMverslrNrkMHFdvfRaW7Dbm2y0tkI/+a0gCVu
         2+LRlv8tDqaXkC57KmE/bvYbu3l6ws+LWUhx4k29UM1mytW3YVaaqJHmCqTwp4EUsO7C
         jMicoHK05MCtMDcF8whc2gxOKWwO2o9odgeR5bqhPSEdRV7ys33xkefTE10MLayDPAeJ
         G2+Q==
X-Forwarded-Encrypted: i=1; AHgh+RoVkL8w/7FKmhxKD41PyAY0u29XDfqCjVPHPy12he+LPxRjFXYz6fhPjGBvBCuqG21e+TohYQ37n9LR9qMPP8Rs@vger.kernel.org
X-Gm-Message-State: AOJu0Yz54bEniFP3nxE8LbvJ7DnUOZbrTrpjmP/WBwxgGzYoKNMO870U
	/kFvM9w6fnZXiPu6RUA43lZGLqAelXd1s7J+9+HOxB2oSdTj4njAgX5dwBC77SMU8Cev+keqzUe
	npTZX01Pi7g==
X-Received: from dldyq18-n1.prod.google.com ([2002:a05:701b:4552:10b0:13b:a0a0:3b98])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7a96:b0:3c3:7cfe:b337
 with SMTP id adf61e73a8af0-3c3ad7ad9e3mr18429814637.30.1784675403821; Tue, 21
 Jul 2026 16:10:03 -0700 (PDT)
Date: Tue, 21 Jul 2026 16:09:52 -0700
In-Reply-To: <20260721230952.267754-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721205746.183206-1-irogers@google.com> <20260721230952.267754-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721230952.267754-5-irogers@google.com>
Subject: [PATCH v6 4/4] perf synthetic-events: Fix bounds and union member
 access in mmap2 build_id synthesis
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com
Content-Type: text/plain; charset="UTF-8"

Modify bounds and union member access in mmap2 build_id synthesis. Bound
max_filename_len against the minimum of filename array capacity and the
outer union stack layout minus sample ID trailers. This prevents both
-E2BIG overruns and _FORTIFY_SOURCE array bounds aborts on strlcpy even
if the enclosing union expands.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 4043d17a6140..704760e1dd5d 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2450,13 +2450,18 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 	size_t filename_len = strlen(filename);
 	size_t ev_len;
 	u64 sample_type = sample->evsel ? sample->evsel->core.attr.sample_type : 0;
-	void *array;
+	void *array = &ev;
 	int ret;
+	size_t max_filename_len;
 
-	if (filename_len >= sizeof(ev.mmap2.filename))
-		return -EINVAL;
+	max_filename_len = min(sizeof(ev.mmap2.filename) - 1,
+			       sizeof(ev) - (MAX_ID_HDR_ENTRIES * sizeof(__u64)) -
+			       offsetof(struct perf_record_mmap2, filename) - 1);
 
-	ev_len = sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + filename_len + 1;
+	if (filename_len > max_filename_len)
+		filename_len = max_filename_len;
+
+	ev_len = offsetof(struct perf_record_mmap2, filename) + filename_len + 1;
 	ev_len = PERF_ALIGN(ev_len, sizeof(u64));
 
 	if (ev_len + MAX_ID_HDR_ENTRIES * sizeof(__u64) > sizeof(ev))
@@ -2476,16 +2481,15 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 
 	ev.mmap2.build_id_size = bid->size;
 	if (ev.mmap2.build_id_size > sizeof(ev.mmap2.build_id))
-		ev.build_id.size = sizeof(ev.mmap2.build_id);
+		ev.mmap2.build_id_size = sizeof(ev.mmap2.build_id);
 	memcpy(ev.mmap2.build_id, bid->data, ev.mmap2.build_id_size);
 
 	ev.mmap2.prot = prot;
 	ev.mmap2.flags = flags;
 
-	memcpy(ev.mmap2.filename, filename, min(strlen(filename), sizeof(ev.mmap.filename)));
+	strlcpy(ev.mmap2.filename, filename, filename_len + 1);
 
-	array = &ev;
-	array += ev.header.size;
+	array = (void *)((char *)&ev + ev.header.size);
 	ret = perf_event__synthesize_id_sample(array, sample_type, sample);
 	if (ret < 0)
 		return ret;
-- 
2.55.0.229.g6434b31f56-goog

