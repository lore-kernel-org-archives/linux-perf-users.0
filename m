Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A056D40DFBD
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410456; cv=none; b=nsgx1l5gOFP7kQW0qv7JNYV0SdX7NqzfNTOcX8EsdNIg3wvnxrpbbbwKMmLfN4sLwg6Ja9g2Oojr7OlVvdOXdg0BYmYqR9WNZcrmHkXCYm6XDM+/R7LEnwEQ2Dj2m3JMg9G28j78HoTRXPehB8hkO40JQJX8siAyQPlsZx7q068=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410456; c=relaxed/simple;
	bh=bBCpsHP6pxxOKGXqUqpPdX+SmhYJI6iRxQWCSYCtC/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i3nOWSCio17QiiBxfrySPPNLyYdFo76+6NACE3nwrj2aW0CzoIma5lQFufL/nwhQZYHdCRG2lCYTAgowLyMzxrgLBipGj2nInjRzYSC/DgiAag//Sv0JZgTzX+ZOTrpwxgiD/WNepgS2mvnRhyOeswgV/aJpJuTmzT82BUZOX3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=me+0wouK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="me+0wouK"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490ac357c55so21213035e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 07:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780410453; x=1781015253; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/tFhBvkW5lHa9f/mqQAj4otAbWa3BZTThp9kdngA0w=;
        b=me+0wouKFJA/aGBgjuNpqYvngSjqAVFsYzuG345fMbJ9tCH9vmiGkb/VnrFI8rTF1P
         aDDHWozLqPYTXNLtj9tAAHWEd1lYz6Jod6l3T+RNq48vAduxJ0Kg5Y4l6hvqwy1qsNbw
         mOe6BvR5YXE41fOYH10B4csT7M+9/exP0ys4G7V88sT9UDyDFU0ARxaPbD1y8OwoCn0r
         nUMvfxtd6KtWRQm8Ps6+NbtRLkeUqkbMu2MqcL8LtYMVUAK0XEobbm7fJ4/GWencmwbA
         zVYIBJL9JZzelT4u8P5B9rOxxMtaPcz+R1wxqZghOpoICiyP2dbQ/VABYTfJmO5l6glj
         UTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780410453; x=1781015253;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t/tFhBvkW5lHa9f/mqQAj4otAbWa3BZTThp9kdngA0w=;
        b=nXz5M2g8XMg4CQLi+Mw7yJFXuSemQ5A5yxVODKB0+j1ZwU2KNw7GJXhwOP0IKjcWtd
         uP8LNk7oSahMKvIHFMu6Roc74gtZ5RgML7CQnZ0YHmV6q1E2TBE4WE8w9p3zn3OTY1Hd
         pNAzUWCelLWCt5txaroLFuq1RRmy6AG/y+/+aYPm77u5H+ARu6djTh2rSklPhO/5jfs4
         yPkYLWgIUqK0r/p3fWaWI/AjCWYZvKjHBe06ojm/+/HdH9aw5nL6nbFbEyDN1L5kojIW
         2J6G1R5FTXSWKI/Uow4SMRxg3Emq04LejT08OhrRUcDoZIq5acMctzMB6seW6J88I0wQ
         CPfQ==
X-Forwarded-Encrypted: i=1; AFNElJ9g1RYqRGXrzPglJkpYuaID0rvIAtFn/lGhTcYs2cVT6kFYM64FnHM/OQHoNtC0DUQKTT2LixAbZcBXMs4/OGLs@vger.kernel.org
X-Gm-Message-State: AOJu0YwN6Q5q5Zn/QX08RiP6lZYsSwlU4YmSM48K7GY4IgwtoBvE0+b5
	FwDr5+5sPiiWqi+5CBxs0fFts1qzzlsLHajUmAla2pd4lTeGg5VePoz551cy04sNLEU=
X-Gm-Gg: Acq92OGB1e9R62x42zUuvq5EMANZcbt8//KVqJxPRW5S75UrBR1d3OKlYrFmYL1OO9+
	wafeAVikdmS2RKvO7/2v3AnlOWNB4tdAoJ3j3rv+m9mvcDUe0G0ggOxaLNupYCKYg8+RgyRFa1+
	v+bf34DE/Aa8r1+aMhIgBk5wHHQbEePjCuDKrhrel4iHL84mnEG7mV50s+XGb6NglI7V+tpiGJj
	zMhXCyDVQ4tzOrr/Ez5S3o0ietlDvZjrI0JhEvC8cRSzD4unG3U7myxsq82qX/AMRumj0mwPHpO
	j55M0dODPvyeUSY+vgpkNIK8c/IvzUnT100aDc8NgRuSVSynVYUfmM5fOD98DJkBT/Y1VZX17Bd
	Aed6FtmQn0MJp6WGtiAnaUgAoL/BpI+YbDG0emfHm0pGkFHRsLabxwn/GpRg4NIUp7oUlkPtEKr
	NbTpi4G4IJ7n1HQCLeds5uIo+jm1cbla0bsL+hlI+6X4M=
X-Received: by 2002:a05:600c:628f:b0:490:b026:971f with SMTP id 5b1f17b1804b1-490b078a6admr85262375e9.16.1780410453092;
        Tue, 02 Jun 2026 07:27:33 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e18e1csm66771965e9.4.2026.06.02.07.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:27:32 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 02 Jun 2026 15:26:54 +0100
Subject: [PATCH v2 12/18] perf test cs-etm: Reduce snapshot size
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-james-cs-context-tracking-fix-v2-12-85b5ce6f55c6@linaro.org>
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

The default buffer size for root is 4MB which is very slow to decode. We
only need a few KB to verify that the dd process is hit so reduce the
size to 128KB.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/test_arm_coresight.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index 8ed2c934c87d..da2f599393e2 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -156,7 +156,7 @@ arm_cs_etm_system_wide_test() {
 
 arm_cs_etm_snapshot_test() {
 	echo "Recording trace with snapshot mode"
-	perf record -o ${perfdata} -e cs_etm// -S \
+	perf record -o ${perfdata} -e cs_etm// -S -m,128K \
 		-- dd if=/dev/zero of=/dev/null > /dev/null 2>&1 &
 	PERFPID=$!
 

-- 
2.34.1

