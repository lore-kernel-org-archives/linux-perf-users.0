Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879130;
	b=ek/c5JEhFRFwACYzQVsshzXsdzUul3JIPhdiIiwTr7TIV3vJYdN70uxixdP9yAePNiof
	 aZ0BoBgTLw+JDwUIyDHtQwEvfObVQ6l7bIdSMQFC+rG5MK5jG2xv6oq19avBiXdWRBJlS
	 Q2XEZwW1Y7PYGYQpBRqe09cwn8tScYGPDMg85bxyWLE7S57XWstfloMAQ3RYxhupLHI3n
	 xjNpcwmQf2fSPfMD7yBGIf0ejKVfzRzyxzmbAO2E3MUI3+xu/CU8jZv1jChwWUrKu869b
	 LpNXD5HuNRpmRMVmkgyYO2+ZjQucDsN+pVZcWLbfumv+TScSvYatQAONRho89Kk1ZnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=hQ2y5T12ktAE5iaKWCwzlas8CkbZmdyxwRbpbd+A6KQ=;
	b=uGRG6oLzYoVhpd+5OCFkKGMU+HljIrmssBJAwGZE49a+MY/mhsc3vExwVIUyChzeoynK
	 L4bGt6a5wBGmgHxtSCUv4ZNYxWstAY7URcVYaI2vlJxm8BU7xfVeWcbxeHo8fr9BarM35
	 cAP/LnYmdeCgig31mCt0tJBD0mUAAy5GW8SnEeodnaRwiB5MRAKdcQG/V8meA/hDFJp28
	 x4874+I/wir7gMRPobV8KelV+beNcZdegeV1xck+6EN+4IdMi3axZWhBBnhYdvgBySHjt
	 +PygikFr7SEhCQYdz8A+M/GVRmUwFBbqdKngfwc7TEXoLy+eqs/55e1uvgKGcn3qLRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=a0iLDWSp;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F39A60A3810
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 11:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F39A60A3810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=a0iLDWSp
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so2947455e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 03:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793879128; x=1794483928; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hQ2y5T12ktAE5iaKWCwzlas8CkbZmdyxwRbpbd+A6KQ=;
        b=a0iLDWSpLDPHcpGFKmm8lzHC0sFutNhJXYUgiG7HVQgwCSFhJlwlsvCW08Oc2ikCUy
         ssDFylEyRiQa4+YyibCAfFvUTDb1nSeFv0gLFV2VBqSO2MQhJT6S4uJDdUu3etiYLAxi
         455GCYHxWCEbRa1jDdMeJcb4EvDX5HjVVWUub7S5JMStHjnEKeUozb2rTORjCnfBC53r
         5pR+lpU2ZkYZBPZBgDJguKY2Xkhyw07H6fJLgYL4GmOJoIaT17MLuC8PbxSPaOB1wGFM
         IT0I0a4AhrH0OtDnyGoSNxeBMN+NO6LuSNEYOS/AV58DP+id57CQYbtT7MBqFKUkDH2C
         vgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793879128; x=1794483928;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hQ2y5T12ktAE5iaKWCwzlas8CkbZmdyxwRbpbd+A6KQ=;
        b=hM7xW13/7SsJ4DJscc8HgzGWUprxLhZZUSQh5lgE2FxxNtDATvoktRlXv7dd+T2PE6
         nHy9yPFbcjk3+MWPqEiqigUt5h4aFoxl1vwMvIxfxjqsQSMAysd19HNO+8i3T/Q9lP0L
         pnXj5kS3Jg9gHczd0Glng3rcdSyKD7yUbo1jyWk8xV8dbR5UC/uPReAnNkA7p4X1E861
         6TYSnJ63tVjIzpcWKNrGK/VZCDGSPSDwx8Ac9ACc4YiKpHsXJAzVi+pb859/9ujAOUpy
         zH86xGXvXvj+c6edxQOriZSvFgvZBFoOcu+BwB2qvjzQ8wAXSq7HjclbyfYJah4YIs+l
         wOCA==
X-Forwarded-Encrypted: i=1; AKwUvBw1WQmTwWdlQ17KAiaBLQE5H4g9YcXIgb5nsvwcLHb3oWSSvinemPOB4sTDTHxsDbInaQ23OISBsR76jPSdlLwH@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ajw2iU79U37ioaxsAyeVEJaESjPrqAKgBbz57JzHlhhND/8QX
	6qSrjKRU/GFeiulOCdSZPwJSFsy/CQ4vUJovzhtQI9XoNdJjIFWQQHTeXv8NVkAHQi8=
X-Gm-Gg: AYBFou1YMBnBZj55jcOjmM0PboGV+Mr7g9cVsGM3u/272IQGEm91E632lsbSfxQ7nR6
	PgDl26jYNS41tZ11/wdH1IQq8reKbBm2nASq2g/GJsho7t6Y951AbnfCA5szecq9yZeBXhfmdUk
	Lr/VRhdLugxY9rVCAdFYTeXFhH0kByISEBQ1+eHcjSsznoNIyIPChBbJexNEnJWwhZB70qtFODR
	TnDrYMetFgzrJoellBhufJid01oxlTo7rvVnicrjFkd6igd+aCe1JUlyUqs+Ckdc+v0GOIYEobl
	lECE6ywq6HCFyLC8X/v+9sOxMX4WMzUeyBOVQUmVj6DTRS1JqNRouPpjVINXdCov/ofg46CZLyP
	6aW2qGS3iwkK/TQZJA7sMcqVIKjtqDu1UVfBFkBLAxFueiLJZUFT5Z3EIjHxQwjjhgWc3RpP5aC
	0+DmSaaxX3e98WzzdhM75jwCgNj19Ed1EgZaL9r/KO2L4vbDQMahMct+GlSrzpAuKmZLbd+pHvH
	XAHzlcPgFZY9qeCCMwHXeId+dZIRdbM6HBVl/waYssI9sMUG6sRCMSg7xBGOiNoCE+muX6NHH7E
	B6AlUwPieDrIp2wp3pDMlmoKZtzeN19x
X-Received: by 2002:a05:600c:3e8c:b0:4a2:180a:3417 with SMTP id 5b1f17b1804b1-4b55c8743a7mr39562485e9.1.1793879128464;
        Thu, 05 Nov 2026 03:45:28 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b571f46538sm56679525e9.5.2026.11.05.03.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:45:28 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Thu, 05 Nov 2026 11:44:55 +0000
Subject: [PATCH v4 07/19] perf python: Expose sample instruction length
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-james-cs-unformatted-per-thread-fix-v4-7-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
To: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, John Garry <john.garry@linux.dev>
X-Mailer: b4 0.15.2

Expose perf_sample::insn_len as a read-only insn_len attribute.

Trace decoders supply instruction lengths on synthesized samples to
indicate whether an instruction was executed or not during a call or
exception. Let scripts read this value directly.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/python/perf.pyi | 1 +
 tools/perf/util/python.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
index 087da00728fd..525d34ed08dc 100644
--- a/tools/perf/python/perf.pyi
+++ b/tools/perf/python/perf.pyi
@@ -215,6 +215,7 @@ class sample_event(_sample_members):
     sample_data_src: int
     sample_insn_count: int
     sample_cyc_count: int
+    insn_len: int
     type: int
     raw_buf: bytes
     dso: Optional[str]
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 42c587cd54a5..a4f1e316e5b8 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1380,6 +1380,7 @@ static PyGetSetDef pyrf_sample_event__getset[] = {
 	sample_member_def(sample_data_src, data_src, T_ULONGLONG, "event data source"),
 	sample_member_def(sample_insn_count, insn_cnt, T_ULONGLONG, "event instruction count"),
 	sample_member_def(sample_cyc_count, cyc_cnt, T_ULONGLONG, "event cycle count"),
+	sample_member_def(insn_len, insn_len, T_USHORT, "event instruction length"),
 	sample_member_def(flags, flags, T_UINT, "event flags"),
 	member_def(perf_event_header, type, T_UINT, "event type"),
 	{

-- 
2.43.0

