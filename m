Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019408;
	b=1GHNIjmzumICkWP/iYFCuc7s+WtLHKZ/H7TIaKVU24wdyyC9MGK8FYPCgNEtot4fo/bc
	 sXGvVrwwb8Is10Kpt0w1CghU5+4lrQVp/c7MF99G5Dsxyz9gwZfuSInj/iVGD+TnDE33q
	 tRdu8OTaQuqW9xorRIkUqE6qjqccUfLnBU7WRUCsGlqYrP1cISVkkk5PAD9xyFtYctwx6
	 rOlKPIIWIHPOwYxowtJyeJle1whO1w9c4fdxK/2acn2yPfRpvl79Pb7r4ETri9yMsem+d
	 qQwvxHqBFs+SrhHc9AnPW/wCR0sYOiaO8Z5j3qFbMol1D8Yj22M7Rjp4YBH0QALfG7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019408;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=koGbjTKVOAqnRDV7YAPg63lp37cXx2HU92d1Gce8qkQ=;
	b=EGCe6fWocHUhFLFAqwJdLl5j886JXHuY8MwpeNPYT/KmR/KW4oRtKfbE7NlFgTdhWqLb
	 D9s6Dl8DG0BbGpJhOJpXN6ivytrkuKZP2n3T9RjmlYQwyk1aOGzyblVGxkfe8a2IEBmJw
	 PQRUfw098SsxgZghqEWTZTQs6o4G6cr8rPPsicz2OokC3fmL6nt865bhf31zL+zBBrHbM
	 K/zGbKyLMwCtu1qEXYxrr5m9IvJW2342vvrTCEcXlEZ5vnxbASyy6BbHeErfsNAfOvBsS
	 Eje+0WRJ5VnZcC7v1xolj8gw+mo3ERQ0mKe0InOyqQ2wX+QKWI1Yzw1+rFMinW8XJaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HkGJTU9i;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A6D60A3804
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2A6D60A3804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HkGJTU9i
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso1038134f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019402; x=1795624202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=koGbjTKVOAqnRDV7YAPg63lp37cXx2HU92d1Gce8qkQ=;
        b=HkGJTU9iAKAjzZPZQm8z5dEIIWZoBeh8XWvjpYiGt7/10fIH813JZjWOKBpT2F94iY
         ++BkYPc6eraoSuH9ILgW9qDhiAxpQCKKX/8QBxvlggjU/AeMqGprhqEHSXBEQFH1jioN
         W8ki2JsypTIQDAteBl3mLYULl3JxaSGFJEjRWv9Qh0WsMUfDlvqBRTss/qeTeGqLXxLE
         vugzhMgKF5c1V4OLeoOsFz+9PPBfCjuZuo+W+7jvY2gmN2owAUIwFVNXV6/vj7eAY38D
         jjkHdfBjXJ/ugacCA8DRsbKOsswM1lWTQ8EGfihme5QIgWT7BtdKefYJlE84FUU0W4AF
         P8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019402; x=1795624202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=koGbjTKVOAqnRDV7YAPg63lp37cXx2HU92d1Gce8qkQ=;
        b=omz4eQRMNbaT8TzEKNBxVx89kf+oY1ujdQO7TBsGQidq8P1HYVb70xYdSCkl+P91wi
         UwdG0FpGB4Bw0ejnE0tmGIwwE11HKhYBVDn+0sJgoXJKOqq1Q6skK6l1aoQ+vHtSY0rL
         w0CPKj2iNE5SomwCdTUaV1WSQrIl/MNiGw/sGqZn6n5t76LrFcVvmCmQktKGso1DyLpW
         t//pp9YHycsuEYNWq7iLRCLpKV3LI3+WJ9TLdweI+y/nQamGcSQlccOwl9fyVC0hCHUg
         +y4jw4LAVtgtjFOEcNxMpioHogmDCIRV64qM675oVNAoC8zX42fNCVmUOwt0XyM9yRl/
         zzQQ==
X-Gm-Message-State: APuU4Z9DeZx41sK9A+sQB7Hm7F1h1kFX/2UlnaYMqBm3aXeXkRSzFHop
	+8MFgzQwYtK3QwJTxBLila3oHk9U+IOViFAmg43YvehU66Grn/Ycxyc56JA1H3lBi24=
X-Gm-Gg: AZFdTZe0zKFC4MZld9mxQiyqoeIt0LBg6FyH6trDACm9t5R9t/x8rFABx2k3UCijy0O
	/ZAYG5wWUhVy1szLoYh+hy8u1RfGso1+am0uQoal0SIrqq0I76L92RVUfS7hw8p0SdXQSdQ8qVv
	7wpWp//yhaVO3PN67h9p/+9abHa458Gl04sCFUEaPH0F2nUSr+bGZCOj1cKehNlLIAMaIZXE+Oo
	ejaJhtjAmIXtqfvQuJdTonHm9utGdVvrWbruc9v8pLjMuQfrVCQ9lf540rXfmUGS83JCybdLurp
	HGJD609zsOWpdYEWgso9f2wQ+Iw//28wLC6TrZ6iz3sQ0duaNOByI3V9AuSnGRjYBHfHG7uxU/J
	HayZK/BMEfhDccoJWjjJLvznN4V+9HkXpv8SYgkgT8VWYw8hQ/WHJTXqOZPQ2dZN3FGsDvflfhD
	wqP/a0WYUWEKQrfg1WbG3lc0qmUD0uR35vj/7aEHPAvqmSn/nNxIPn9mDmvrVjCJGLrW/iJROYB
	H3dORNa2eT/osna9/JMVkDnGBU4vGXdRMAtHedhyPF6G/AQVm9R6MnMhZPEq3TGUFdV8MiYeWjI
	F9bN16aPF+lZqoxHvBUKpufCLBIYsC8T
X-Received: by 2002:a05:6000:2608:b0:4a6:8012:198 with SMTP id ffacd0b85a97d-4a6801202dbmr5316972f8f.31.1795019402218;
        Wed, 18 Nov 2026 08:30:02 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:30:01 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:35 +0000
Subject: [PATCH 13/34] perf cs-etm: Handle PERF_RECORD_SWITCH events
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
Message-Id: <20261118-james-coresight-jit-v1-13-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
In-Reply-To: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
 Leo Yan <leo.yan@arm.com>, Amir Ayupov <aaupov@fb.com>, 
 Suyash Mahar <smahar@meta.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Task bound events use PERF_RECORD_SWITCH events instead so handle these
too. Furthermore associate the current PID and TID on
PERF_RECORD_SWITCH_CPU_WIDE events as this is just as useful as the next
PID and TID.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 1e1ff6cc8a5e..4252d25c991d 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -3016,12 +3016,25 @@ static int cs_etm__process_itrace_start(struct cs_etm_auxtrace *etm,
 }
 
 static int cs_etm__process_switch_cpu_wide(struct cs_etm_auxtrace *etm,
-					   union perf_event *event)
+					   union perf_event *event,
+					   struct perf_sample *sample)
 {
+	int ret;
+
+	ret = cs_etm__associate_tid(etm, sample->pid, sample->tid);
+	if (ret)
+		return ret;
+
 	return cs_etm__associate_tid(etm, event->context_switch.next_prev_pid,
 				     event->context_switch.next_prev_tid);
 }
 
+static int cs_etm__process_switch(struct cs_etm_auxtrace *etm,
+				  struct perf_sample *sample)
+{
+	return cs_etm__associate_tid(etm, sample->pid, sample->tid);
+}
+
 static int cs_etm__process_event(struct perf_session *session,
 				 union perf_event *event,
 				 struct perf_sample *sample,
@@ -3058,7 +3071,10 @@ static int cs_etm__process_event(struct perf_session *session,
 		return cs_etm__process_itrace_start(etm, event);
 
 	case PERF_RECORD_SWITCH_CPU_WIDE:
-		return cs_etm__process_switch_cpu_wide(etm, event);
+		return cs_etm__process_switch_cpu_wide(etm, event, sample);
+
+	case PERF_RECORD_SWITCH:
+		return cs_etm__process_switch(etm, sample);
 
 	case PERF_RECORD_AUX:
 		/*

-- 
2.43.0

