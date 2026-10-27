Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793120681;
	b=JDaEeVwXZHvmPRQSsQ3yKwOzC9jjLrXoLVoIqkdc6atTYh8DN0dy0+a9xt71lK6Jhgci
	 e8m1ADK88+ng7yh18jDw1ldj4AoxoX+evRB/69lR6IYr9URFFhE3tPuZa3oShBichHdZL
	 Oc6d8nME96taaXrwpLaHh9a/0S1V/Wl2xLLTW4IKEH/5mgGxlvPsW9kAUZy7n/ErMf8Av
	 Za293YQclXDTXYHPA/AQDGdx/z+JYgjOYvAgn3Dq8bLRkg4qbXQot4QsZCfnShnKWtuBt
	 HTSSyOtTrQ6iwTQr5/hZBLY+9A73gtcSSWf39eyDoL5Nh/IysA38rI+kMC2s00K0PpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:
	 Content-Type;
	bh=KuPv9dNAeKsP3lHQ5az7k6lXOC/G0/2eCGVI05AUWhM=;
	b=XEkQDmmGM9J4IaHvjPdyKCke3mk4iZpnqjmRmeSFFI+UxdPhZ1WDKKwVe34XIiYbbzx7
	 KJJCGzCymqzJ+P0oYMH9E76eKmVGDRffGmZHf40vm4Mi9pRAaMaFWK7sE/YK3A4TDbX/I
	 k169OzgcY3vAtLxHf/mHHYEHllCbVkWfAoFTX3FJb5ZtZAsBAmxPXfP5uUtuyCsheylyQ
	 f9xsOA2SIN/tP0bc8gcDd1ZEakXcgBJKB4cf88pyQ2rDo6QdtwqKzmN47QPGmaBDXtaqV
	 Ga7p6k0kVxJL5JdI8T+XRVWYbdfPWHawylyp/IXBj4cyJ2z6dIbOMNbkckMP07q9bHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AuSlGwyL;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56A2606A31E
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 17:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A56A2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AuSlGwyL
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1663fb7e005so26466c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 10:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793120680; x=1793725480; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KuPv9dNAeKsP3lHQ5az7k6lXOC/G0/2eCGVI05AUWhM=;
        b=AuSlGwyLvMj50I5lH0VPZECM8TmzzAGBpCmgjTh4rDhbxpMDv1bOwguASPJWiLGL1U
         Y0/rSeY1sHWQpREbVUVHGpKpDZIQDEia9akUS0u7ABwagcB+fKSjO+oZrRqk11Vp5wud
         rTZxx9kVJS2laXDQWQkJk/vdiHDKAdAXeUyX9as0QcPBB04nibVHkBolUHP3WvIgKxzU
         a3qD/xJuYvAhFfZJaSvuFD5VJrHw/TCQa1L9n3nP3e5jJ20iKvimCZWjQk+xoTEi58QJ
         rTGF8RvkYsvoDVcCh3IxuCtBILia/ynU23tejEsZ90QgTr/zQersfIHdK2z+NWgsq7QC
         Z8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793120680; x=1793725480;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KuPv9dNAeKsP3lHQ5az7k6lXOC/G0/2eCGVI05AUWhM=;
        b=IAfs55jDyQE8+kBAONMlvqMGeCc1yH8G0M5YHdAUnr+GUZoEdvkkM7dRT8hRHCtEjI
         VI87ZXxlYNkdTcFsiNmo7EMXDDysbZvH6w9axAcW1/3FQcRYtOouhSavS5DfwQijEjEi
         Too70nW8V3kwfssak1CVPvhXjXoRuRNosR3Gry6XKdfC7yfDEopRT0NuIxwtUhncSjme
         8LH2kxwFpVXks93r7jBD42ivIQNNpY1iFW/s0HwQt42W4ycex4tiqewgA+TfhJ/GuzHK
         XMYDtXEYbnvXrLS4i3EprTA4zpv89bzPHaxlh5Xi6OyIiCRC7XpybUydsONYzrdWsjuI
         VluQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSiST9oIygcCev6lDMnpjva9dLPaaYsMTynRTMdPmSBsSma3W9L2u+K7SADeTdjrs32OZVbt1RjBJHhBQev3A7@vger.kernel.org
X-Gm-Message-State: AFq9FYLQRTGMxY3HyR7n7zNYF97AHwWcmB6DKt8ztV1WmB4CUhnD4Sdu
	XNmGgW1sQUWyX/T7naH4RUh/B5NwYIBYvlyYPV2gQBgWnJIYqnGUUtSrJ7x7AXkeFpHeBYy+t5R
	RM30iqs3yWQ==
X-Received: from dlev28.prod.google.com ([2002:a05:701b:465c:b0:181:c416:735b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:110e:b0:149:1feb:6da4
 with SMTP id a92af1059eb24-199361b5994mr13527117c88.32.1793120679092; Tue, 27
 Oct 2026 10:04:39 -0700 (PDT)
Date: Tue, 27 Oct 2026 10:04:13 -0700
In-Reply-To: <20261027170415.2815859-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027170415.2815859-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261027170415.2815859-2-irogers@google.com>
Subject: [PATCH v1 2/4] perf off-cpu: Write the sample ID for PERF_SAMPLE_ID
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Ankur Arora <ankur.a.arora@oracle.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

OFFCPU_SAMPLE_TYPES allows PERF_SAMPLE_ID, and the sample ID is
computed, but off_cpu_write() only wrote it for PERF_SAMPLE_IDENTIFIER.
When PERF_SAMPLE_ID was set the synthesized samples were one u64 short,
so the remaining fields were misparsed. Write the ID after the time as
the sample format requires.

Fixes: edc41a1099c2 ("perf record: Enable off-cpu analysis with BPF")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_off_cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index ff8935688b43..16948761cc45 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -373,6 +373,8 @@ int off_cpu_write(struct perf_session *session)
 			data.array[n++] = 0;
 		if (sample_type & PERF_SAMPLE_TIME)
 			data.array[n++] = tstamp;
+		if (sample_type & PERF_SAMPLE_ID)
+			data.array[n++] = sid;
 		if (sample_type & PERF_SAMPLE_CPU)
 			data.array[n++] = 0;
 		if (sample_type & PERF_SAMPLE_PERIOD)
-- 
2.56.0.313.g2479322e68-goog

