Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6CC413227
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410457; cv=none; b=a2NhCUcbjSwTStx9q+0YVqevgkWJdFyQjknUWL04eY21y9ZMZj2vDXvI6Qa5dws41235E2lvC6h5LmkqB/foGuoAA7tSwEnHn5Dra3RnLjRI/Dtngk6xZM5EKmdcoMRxI5bl758dxrAQp7S86kFnt5Vhyuw6uxhIYVJEeNw3bk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410457; c=relaxed/simple;
	bh=/bo6v3kFcoolHnOpj+EbZhoQzm7A8RsOcpjrkQcAFBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Shj2CJKoMc5n3MZREwpdwSHg/3PvQeTu+yEDh+Rv0GNbWTLPGxhxbe5hELXisI88bdAPn5SI5V0wrJO3wfF81IyKV0+cDCqVgZlBscfITHyFaL5ahwsqjwEH/WlLm86vIcUpPN6uQNUuINzLFVXA2+y3LfOJXlWNlXaFxZfNMGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JPOQsZQs; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JPOQsZQs"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49041fb8c23so87250895e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 07:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780410454; x=1781015254; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3o0yW6uQ1LnJTQVmIzRpXA5Z0rqK8P+8rneFQb3y1o4=;
        b=JPOQsZQsfIUXYbQPn89gHhysBzQ2N5OF+SvDTucZePHwbPOyvy3LqhPX7KPeM5wv2Q
         e1jEmvqAzFgnOBBy5qEbB+xKehXqr9udaQITBmZhUKMQTmWARBTxhxXybMNsn0bAo/MX
         Cql618RLjOLQHGOn+LLcBCq5mZItwPKhEDNGMaU64zQFYI0d0z6qFETUCRfn6QKmUbLr
         3MEuB6BaMKTBkrcWdfn+o/m8i581dlcbwR46nnO0VB4TaGEAoH5C0yh6hPXIuYeLdAr4
         1W8p5tq/DIgG8VxjG07ywWziywQFLpEgJf2lq02Nbr3QPqhOgBeosEW+AMoMRX7Ixwe1
         W7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410454; x=1781015254;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3o0yW6uQ1LnJTQVmIzRpXA5Z0rqK8P+8rneFQb3y1o4=;
        b=AXzGgW57T9kKLx3sbHfcCJkadxWyzv6iZZEEkTK3Mni10eWGTi1gDJ2DI8lH5iXhus
         FX1h0Egyh2FplzcZv7HjRKUID31yfyP355psPiVFoMblpThFUbjyMk+cz3BWS9OFIePn
         XxPgyjUocwchwNVUWiI7AhlWF3uCwdKtgbAlU81d3TRF55MDXH1+EK7OEHzmBPtJ/tQZ
         WELc3k/BalC1rmLssGVkU5noCrkzmLmgp6t9iORQoqYFxG7jnz2f/eKLvOqI6+y8Da0w
         aXJGXe0TvkAjHjJpKV50TScUVrq+oFFjsmKnWu6nM4mhs93T4f7XrACUNSrfQ3UHfcZI
         wBlA==
X-Forwarded-Encrypted: i=1; AFNElJ8WxCZAD4xAQz3xfOVhB5iBIu7e22jiwMMR87m5hgi7RaYHELHRNkhzlZanYkooD3lOEFKQq1pDUNAipIQ3eluB@vger.kernel.org
X-Gm-Message-State: AOJu0YxN/XBs8xs1obXIZuCbAill//NY5m2+bPGmOv+2S1Exb1WoKto/
	SU00rAzAxN4mKBmesoYCxZD5ilrpfbbAEXs4NPPczDaCeZTF8OdKVYp6OU4gPz8gTME=
X-Gm-Gg: Acq92OGAH3Nl4zqOSvRFLWVmebphbwWA/kygy6tKqZB0NT67bxa3ogFsDKqYsp+YrG6
	C5bb9XZT3szRjcemRKNmet8fTVlTMbx7RfA7tj0BTYpYbmfw+LoVrwRpa/6h+t+3uhN6LSJZg/3
	siPbK/7ZZ/FVPH/7KO1GXUs+0FqOfuQ5639b7xWdPbHUv8WCdpXLkl5P/4CokyaVnGcBBKhCiaT
	79B/PmWZM6+kUsYw+ZKwSdB+Pfq4a7e+K1xSZa7f7tYEbU21/1Qe1n6TBbzxcfx9cXLr4EZ6oC7
	zGkFXIuaGUf8GHhR/CEKulUtvT7+nuIM1XIp3Z79ZaZYe9i8E79/6seJnD4BeHsem29Z+BgmtGU
	7obFi0mAEIilW/wBxD9Jie0uSQ9CddWKpY98kmbRA6NVKGc8W3f7MNFbjByx2znVmgmupjwx5Li
	PuZ/z8BNlrG7eN6WPTPtU76S+sl9LNfGOc54Z8i+Gr/bA=
X-Received: by 2002:a05:600c:2242:b0:490:5321:2466 with SMTP id 5b1f17b1804b1-490a2941ea3mr195165935e9.20.1780410454099;
        Tue, 02 Jun 2026 07:27:34 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e18e1csm66771965e9.4.2026.06.02.07.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:27:33 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 02 Jun 2026 15:26:55 +0100
Subject: [PATCH v2 13/18] perf test cs-etm: Speed up basic test
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-james-cs-context-tracking-fix-v2-13-85b5ce6f55c6@linaro.org>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Paschalis Mpeis <Paschalis.Mpeis@arm.com>
Cc: coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Like the name says, this should be the most basic test possible. Kernel
recording is slow and already has coverage on the systemwide test. Perf
report output also has coverage elsewhere. 'ls' also produces more trace
than 'true'.

We only want to test if the combination of recording options works at
all, so fix all of these things to make it as fast as possible.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/test_arm_coresight.sh | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index da2f599393e2..83295a8fe179 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -179,10 +179,9 @@ arm_cs_etm_snapshot_test() {
 
 arm_cs_etm_basic_test() {
 	echo "Recording trace with '$*'"
-	perf record -o ${perfdata} "$@" -m,8M -- ls > /dev/null 2>&1
+	perf record -o ${perfdata} "$@" -- true > /dev/null 2>&1
 
-	perf_script_branch_samples ls &&
-	perf_report_instruction_samples ls
+	perf_script_branch_samples true
 
 	err=$?
 	arm_cs_report "CoreSight basic testing with '$*'" $err
@@ -246,12 +245,12 @@ arm_cs_etm_snapshot_test
 
 # Test all combinations of per-thread, system-wide and normal mode with
 # and without timestamps
-arm_cs_etm_basic_test -e cs_etm/timestamp=0/ --per-thread
-arm_cs_etm_basic_test -e cs_etm/timestamp=1/ --per-thread
-arm_cs_etm_basic_test -e cs_etm/timestamp=0/ -a
-arm_cs_etm_basic_test -e cs_etm/timestamp=1/ -a
-arm_cs_etm_basic_test -e cs_etm/timestamp=0/
-arm_cs_etm_basic_test -e cs_etm/timestamp=1/
+arm_cs_etm_basic_test -e cs_etm/timestamp=0/u --per-thread
+arm_cs_etm_basic_test -e cs_etm/timestamp=1/u --per-thread
+arm_cs_etm_basic_test -e cs_etm/timestamp=0/u -a
+arm_cs_etm_basic_test -e cs_etm/timestamp=1/u -a
+arm_cs_etm_basic_test -e cs_etm/timestamp=0/u
+arm_cs_etm_basic_test -e cs_etm/timestamp=1/u
 
 arm_cs_etm_sparse_cpus_test
 

-- 
2.34.1

