Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019392;
	b=YBBPZI/WZMUFoUFmLstfyJhUkykbEQ6Tp7n55vEf0mryWFWqGsd6pGYba9BBoWtxWU9H
	 IUmJ4sXo8wZtqnsOcnD8tANfU7N1AHYlGlflBQ9ZF/GQ0iLdl9dLUgUX2ZTMjiOCZSkz5
	 g+VtmS0EcXEgg3UFhNOFfjjzqQEQ/xyfgozddPhaOHaPP5wheKKEyUWnW+O7reBWDeh5L
	 VbbXa2Gvt/WRzYOltRZVTwalITnW4vOSOndmJtSaxZPHgvzWkHdkThBApv4/vgQkq2lEH
	 QTlU5Yar8zykA+yq/rnCQPkZwbj9F5FK7ytOq0qEf/P7EecVsXyEwYOUKV8GPYFKjWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=wtMhJwiFYRL4oBCDekIESBHFFArV6HDfCX3FWyhzvOs=;
	b=hTGfTGClgPQ3gDwziuFveRMRNeqWlsiSm3Z5JcgN00wyeaoZPzBGYbqmt4CdeqMVE38o
	 DEqxQbk6IqYfI6Gl36VhX/1OQrAoIOCajjDyLU9ppEL2eFCD34zWJPXzA8DnZaq4M402n
	 FPYru2/zHt1o42U8wrUyyjvq16lJ2oIWjEU84DsiIHVyetMxhURSqG2lllfMoA878OBJb
	 b0gtO/kP/Z5DNHrNRs7i6O84ts0IJAKX3+FNNAFZ8QyKdVjbuZZNaRWV7rIy/19FAet2S
	 gwP2sJiw77qie3TqrbSTE12iokndaIanMukq989MAkAr+h020wAho9V9Adk9UsiV61Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="GkZUz/E0";
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD10760A2620
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD10760A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GkZUz/E0
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-492f0a1b685so840391f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019390; x=1795624190; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wtMhJwiFYRL4oBCDekIESBHFFArV6HDfCX3FWyhzvOs=;
        b=GkZUz/E0rfw4x1dR1T8HjsvXLNcQsWb22zSpOEyAxWXOqd+ORu8BrqWUkRxpfawdHH
         Trz//46nEOV0KYF5X8zKR54L6xGsb1CkQ8iL/O1gJqFISPiyKN4oJLc/+Oc6Y3VN43Ru
         UWSCstdL4PFaJHxmtI3YWIN6KwR7wbdopAxfO5BxK4czj+d9cVQXalCYr9ADsTimXt4v
         ljtvr5FqtYDVqnj1bozQwggCaFD+5HaKDCwt9Xz3MFofhMVcdLIQSHusezpbVPB53FpS
         v4KFFASEp5QciM7s3uefV5ljqBjFgkH60c2sW5+IH9kYjQNxRLAilaWEModlNItp0RoF
         asoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019390; x=1795624190;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wtMhJwiFYRL4oBCDekIESBHFFArV6HDfCX3FWyhzvOs=;
        b=ZSxy0B5MF8mEL/xonFDLIjMC68vV6bfFSBE/R81UmyI9eRtYnZ++H+tDFMPNTNYRhr
         2pemRuDq8rO3bC9WRKw+jlsecl3jVnIdMzroQV4i+z+uQc34m4ucY9IvPyzg1YDu2sr4
         ctx7k0cr5d+KLwqVR+X5/CdtFRy+1g2PufSQUvTCKhUV8p3IdOsefmD7/x1qa8sZT3Ha
         vpTDO/iPKF5Por5Fu9TPaopfpvJxjT14XSgeFVH7ZNZxFZoeWbdDF5vJALeDn1hcnonP
         OStYGjYwCmE9tP2QTXz2PlffHHqqgPSwds/1S0/0mQnPgoTuO03fdEdVBTppGsObHPhB
         ks9g==
X-Gm-Message-State: APuU4Z94t9GDbvaPwQGX7503Ll+U54x2nClDlqpFjkqlSvxiXObRu48C
	yKfi8XHhimXqjeJOziz6OnilUinWEROmkIQuv8oQtgcIyp1ZpVgW22GfONnNP/kQSGM=
X-Gm-Gg: AZFdTZcI/UBK5Q1sxSZnekp+l5F7PLOGaMPWbZNHPBw1c4rHPTiXVWVHAx0MXTQvyXX
	rEYdvv1r5C7V2DjSXH0shnFa9L3Kt5ZKaGz79vPlm3eFxqBesfHjL2n3kDcYoCUeX5O34V8IfLP
	IT0MggGOTwdSabjFtKcBeE+1EuZUJXoEVuCLtbKrXPJFkObKqTqjbhxCZjt1OIBAMUaU18PzMTq
	NZPpagrkgw8Bt+AePFXniJsNT9PQeoTS8QdaY5NaFQwBqY7ihjMqAY3nvcaYQ8q54l3w67jlwvX
	4+CSQkHTPx3p7MTUyJBAmPlYL2iokQvhwSQktf6eoxO7uHOwD0EogBvZ9ledbkl7aSivnfcYL93
	JV9YE7LbgCtw7zHrnukNZ7c2SKkjL7Vc9KW4N7dBE2Zb/TtU6n1X0vH/F688scEA0hpWlXLbM0T
	h5Bxg7eSjaFMsQm1iyI/lh0hYv+MQLfxpXPfpueqlUniSQRmIRmc9UzorwG4wf4dl2q9tQVIs+g
	DJUQEuB+122ru/kN/qJYS2ywzQsOdAv/wpFKW+PN4tcwlsPhX/VGzjS3MPJ0GYGthwRD3qcNbhY
	xn4rvXO+YTRuXaD7eE5AIUm+QhIq00TA
X-Received: by 2002:adf:e013:0:20b0:493:f3f2:2241 with SMTP id ffacd0b85a97d-4a63a1e0760mr4855589f8f.23.1795019389980;
        Wed, 18 Nov 2026 08:29:49 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:29:49 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:24 +0000
Subject: [PATCH 02/34] perf jit: Add name of clock in error message
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
Message-Id: <20261118-james-coresight-jit-v1-2-dad4d90747f6@linaro.org>
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

Use the full name in the error message. This is also a valid form of -k
argument and says exactly what clock is needed rather than having to
work out how these numbers map to clock names.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/jitdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 45a05316b3ca..4c1a71702f62 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -220,7 +220,7 @@ jit_open(struct jit_buf_desc *jd, const char *name)
 	 * validate event is using the correct clockid
 	 */
 	if (!jd->use_arch_timestamp && jit_validate_events(jd->session)) {
-		pr_err("error, jitted code must be sampled with perf record -k 1\n");
+		pr_err("error, jitted code must be sampled with perf record -k CLOCK_MONOTONIC\n");
 		goto error;
 	}
 

-- 
2.43.0

