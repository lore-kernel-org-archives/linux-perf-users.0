Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F3346EC76
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305856; cv=none; b=Z3aiBHvJq9CuhUgqV3dQnaDBInFVk6Cml2dXb5cymTdVTAMfzaCb62kpx8R5hcaLuep7uhX5WwP7YlB4BcHHejh4TD1OIliZncsvQGDArv74tdxRVs0TzkYXS1w+t/SIPm0xnUdJYiyBkuAeDryKiwU9Wh0fAPOD0+aOc/2Uzos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305856; c=relaxed/simple;
	bh=oJvsHqKtmERgG+BHDRgpYd3Hg+5b3dI0zORQ85m27Cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q/bgoF1RYOTnls9hTanGOGQqBK5oQ6RjQpWS+vBaaBm3hr2/ZRZ2TRDhyoArg+WCvgcJReOr/AHLEiqxBC3g29RAWTgsmKHk0+g3sNjvo4kQrfGn67+0r11/ybEQ1mzyuDJx7G1cHOYMhe/pzcT21AhvRTbfgP5A7OPRkHtWmEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=butVKHZP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="butVKHZP"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso399442f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 02:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787305847; x=1787910647; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PiWS5xibm4AuM2M11jS2y7wQ/FmG+Wf2gKfhaKMAwvk=;
        b=butVKHZPQaVpIGhlFFoOzSZKjRGwbl9ZwdI/WPv5FD6Sx0umJmraplKKwWVpHtp7rQ
         RMQ8Z9BUGmvDu5kMmtH2mt4nVPCLnC0P38prRRGnJN9ylSUwqkFDzmL9QZsoABkZW3bk
         oKoy7XzKk5WEC5cVqCn7rnOgWLCTJQeSKahPDP9A5XKzKadGoi7eDh9ToXC/QBvM/JDB
         WCERwG7XJaS8c9hNE+vWu2UoYxxMbNKbUXld31sJzp2x5lTcNyeE7iXKVFFUxiXMnEjn
         JWPkdD99ZtIAIUr4bFRwv9RlrjYx+zbbH7q4EVXuHpyg9h2M7ZeR9aYcCdpyRWy5roV9
         NvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787305847; x=1787910647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PiWS5xibm4AuM2M11jS2y7wQ/FmG+Wf2gKfhaKMAwvk=;
        b=jJUI5IBV4Gw9gIRhPVRluNd8gSP1+4F/QPNtIqoTovnaR3fdjUk5UQJhbejpIdREsz
         VECtpkPfS3hyoHdGr1HOIL4IYnIgdywA7uLKRtdtqwp2z1mMmJmXGVJhoZ+uWDov7DGr
         qYATBAHjPQEzyHpUP3lpw5uTkiT+xTnc09wy1a5A/RZdDRJ7KBpt7SEkga+48xkUyHIC
         cRaSrCzMwi7J7g0Z6jEsJjH0HZt3ALFG/yxsBKHAsRew0e9DRvd08GKDIAHJPE4rGIxp
         LOG2V2+HF1LGRgi3SpG4X9QqrMuLIBBVfSmxBEDu9FxiDomyZYPOwnrwRJ1tgTlUaN7A
         5WeA==
X-Forwarded-Encrypted: i=1; AHgh+RpOdbBlcB1XgKA3mLMpueT61m1VKeQPdAA1eXYAj90DKHEiEo2RcUmQVZp0sc0HaQ9c+GO5vQh+sgN/Eh9tuZp3@vger.kernel.org
X-Gm-Message-State: AFuF++nIPq6+F/3yRztzj6l/92g+/Kbgwst7nNbyHqz4Wgf1oGlvmjok
	nbMkL5cOETCAW3VFXQJurmRiaY0zIROHCqtkHIW33HVmxZNcR4uz85L3f6yOEKYcqXc=
X-Gm-Gg: AR+sD10ReGL61Pje5+sW/o6phjucK5pdGHFtISZz7/cFaSmIHNEprXAENNh2agrDQZC
	X5v0dOUzhgn97IB2iCWYgGYkMPtFmvpH3UDhjR/zGLfsWnNapNjXDEsVeSP8/uKPMrWQclKDWZS
	gEFTOz2vZIHxb2f6p2Zl4vH3JPG9dv7h4zlOzS1ITdLoRNP9SG8VIBA2Uqemy+i4/Zf6oCkU4xJ
	4LbLM6Nu+BjC11AIAf6faZOwUgpXXjeljZcql4ZyagaddoeFohDX/GqbGW7emRCKLSa+gDam5XI
	fWfam6Cw7u0PyvRJG90Tq1kEaDm/naCTbZhX7Hq1lDFjBnENyVeI7xAn4wgQDCU7uDW5BTt1Hnn
	ImWZU9WulbiND6GMk+pD2mzvg7enFfBIin8Nz3p9u6jsyKlG9wyQUQ4EfPah2c+NQBU6dPE+1YN
	No02D3A2meOlCQVNeCCIQLFUvyafOFZ2w8yOM9bQPgUV03nP2UNLMVLD4XmbaZtlSN
X-Received: by 2002:a05:6000:2907:b0:481:5167:abda with SMTP id ffacd0b85a97d-482c0b4c908mr6700276f8f.9.1787305847538;
        Fri, 21 Aug 2026 02:50:47 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c3775sm14474284f8f.26.2026.08.21.02.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:50:47 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 21 Aug 2026 10:50:33 +0100
Subject: [PATCH 5/6] perf/core: Return errors from
 perf_report_aux_output_id()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-james-cs-hw_id-output-failure-v1-5-9d532ddabcc3@linaro.org>
References: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
In-Reply-To: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

It's useful to know if this failed or not so a retry can be attempted
later. Return the error code or success.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 include/linux/perf_event.h | 2 +-
 kernel/events/core.c       | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 48d851fbd8ea..01d318a4de50 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1896,7 +1896,7 @@ static inline struct fasync_struct **perf_event_fasync(struct perf_event *event)
 }
 
 extern void perf_event_addr_filters_sync(struct perf_event *event);
-extern void perf_report_aux_output_id(struct perf_event *event, u64 hw_id);
+extern int perf_report_aux_output_id(struct perf_event *event, u64 hw_id);
 
 extern int perf_output_begin(struct perf_output_handle *handle,
 			     struct perf_sample_data *data,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index ba5bd6a78fe7..bcdc9e7d2637 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10565,7 +10565,7 @@ static void perf_log_itrace_start(struct perf_event *event)
 	perf_output_end(&handle);
 }
 
-void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
+int perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
 {
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
@@ -10587,12 +10587,14 @@ void perf_report_aux_output_id(struct perf_event *event, u64 hw_id)
 	ret = perf_output_begin(&handle, &sample, event, rec.header.size);
 
 	if (ret)
-		return;
+		return ret;
 
 	perf_output_put(&handle, rec);
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(perf_report_aux_output_id);
 

-- 
2.43.0

