Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958D4336896
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481861; cv=none; b=RBaUrJ8QQnjCHu+imVPFYYg+xJl/yDDynA6gIKzq1y+rzEDx/gcKhK+2hmul1mWSyxqTUvw3BM6CIPCIrqWmbhsX8/YuxKSqwecg7ot72uHMcIyaV9kFe2uO6u0bKBFnef0khJTSAmZjnfqPkweEc+UZ4YtHljif+L80YKjCR+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481861; c=relaxed/simple;
	bh=T/G2GHn/7fUMe7/PnmdOHhquh1KwWwdOujJXllzzUEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UQqIlNRlagIFYz4FDTpzUauzpns6XDG6WpvyEOIbGqJYzZu6f96zoPKaE+fZzo78TGwXrxSfLd2ynqkD4bbcG/XH5zm7jExSTVrYjclV860pf3rrLU+3GVyxhELlbIqKuKPLfVgtRPe4B+O00zMQTlY5mmv0jlGCDRJhwCYGILU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OcZLfZdW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OcZLfZdW"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490a76757e5so27429645e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 03:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780481855; x=1781086655; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CWgAW+orRpeoFszPA6ybNAPpRullqPhLMJ72GoaGas4=;
        b=OcZLfZdW3Dkmb4vic1r5a18+QzSWtcl9J9p8eSinsktFZivX2elXBDwUyatrz+eQxD
         mBwalMpNowGsOTK6jHNDDVkrre42fK4vXHFhoWouuTY5vsl68jbP1J5N3fWm/dKE+YJm
         aEs7Z3zCbgZayxVCM2TlNNw69qAvJe/ywLqq4f7+z8bj9qxINFQnbIVzUEjMlr2yDk0X
         GfyeU6aXXENjpatNF+R+CagHCM8DZIqSm2K+UlQg5+C5iCBmkxTokrDXOf1Bvba3vTCF
         O1YLEt5+RvqkR+srxyOSHGb8LNpBDaVDXJc9HMPCkgN4roeDWV9PEas+GIV8yDQt56XC
         DuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481855; x=1781086655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CWgAW+orRpeoFszPA6ybNAPpRullqPhLMJ72GoaGas4=;
        b=ELQlAAJIfqyLXd1E9aEKRCQGn/tMvZzpV/M+Q05BiI0gXCzYvmg3e2Fl1j8mC796V1
         T0HUoWHXomP/nGgVt3FhjkD8NVCJcQPC1lGthOjCRa2UfjOuVRh4XBgTzxKo1qJeOJ29
         SfSltUI7t5NzR5uNIbktAEanfre7ban3Tk9gVkI6waHCLydTxhnC/j+qDroAEWsBC0gG
         aWpRO26i+BK3hUGYAHyISPENarhAG5JDG1WdlsAeb1RPfBt1QSA4tYT3YcKzDGvPeHrn
         kEgIx8jwuOf9dFfrIjDF/73evpxfVm6YlGcHpfoZ4nU84X77a/iI6ZCPGWUlONkzoC2v
         SQ8A==
X-Forwarded-Encrypted: i=1; AFNElJ++XDLDiM1CdkKT0erESoY0Dds4DFtBwNzVYPbumONl40sx/k+hI16lfCu5+rNDBiVhK2o+eAS9wM8dy/di/ALz@vger.kernel.org
X-Gm-Message-State: AOJu0YzqTI5YpqYIXq0CYo/cPjExMaBGMx3379Og8hOd19USIbPar0mg
	JWwwcT61s4w4CaW8BenpHQOzkaLO7b7iMJU3y031sSH8URZBZuWJFANMZZbOlZ1R4Yw=
X-Gm-Gg: Acq92OGO7mbojbrKTYkCp8CC/m3fXIYLNmzgliD3YORiiHrxYk34oAf8oD9jCqJJXol
	/dsl4aZ/f07o3yVv/aX1+IjadBBS7eF8yJ+T1SL27V07nIKaL+u37qHmKUrJPASzdoy8nohGNDu
	WUsx/qKJdhLnGKXDqrYUAkTD2zkROG93WKTQetN5tmO5IkcI+jy8g58p9wMf7ofw4ktgVVI5liF
	l3ABKmjycGNJXgX9qd600bz3c+PdSWgtD6azrKPb1XDgmr1HAPaj0GX1EalvIUgDWOF5C1CiN+4
	mqjcB1CAfpHsO/y2Qku8Ajdp5zLc58gPBt1Fge3lHBTM4KZDDWk9qKFMAlq+g7fyljZ1+oM7rsQ
	WINdItxF9Bpsv3ABE2t+s+vsxZezvOwPLHGZWl3zUisV7djna5FXouWuBOimznD6b+FBgFH836N
	lLivHrAWrygbp+qmTTn0afmKg06s21+YtU+benwbV02sc=
X-Received: by 2002:a05:600c:1551:b0:490:5466:8576 with SMTP id 5b1f17b1804b1-490b5e9fca9mr46134395e9.1.1780481855020;
        Wed, 03 Jun 2026 03:17:35 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63d8205sm38681875e9.11.2026.06.03.03.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:17:34 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 03 Jun 2026 11:17:16 +0100
Subject: [PATCH v3 12/19] perf test cs-etm: Skip if not root
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-james-cs-context-tracking-fix-v3-12-c392945d9ed5@linaro.org>
References: <20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org>
In-Reply-To: <20260603-james-cs-context-tracking-fix-v3-0-c392945d9ed5@linaro.org>
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

Use the common idiom for skipping tests if not running as root, which is
required for this test.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/test_arm_coresight.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index 39553702c1f3..8ed2c934c87d 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -20,6 +20,12 @@ skip_if_no_cs_etm_event() {
 
 skip_if_no_cs_etm_event || exit 2
 
+if [ "$(id -u)" != 0 ]; then
+	# Requires root for -C and system wide tests
+	echo "[Skip] No root permission"
+	exit 2
+fi
+
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 file=$(mktemp /tmp/temporary_file.XXXXX)
 

-- 
2.34.1

