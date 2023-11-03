Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44DF250F1
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Nov 2023 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMIAUpo0"
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D90FD44;
	Fri,  3 Nov 2023 16:50:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4084095722aso19114325e9.1;
        Fri, 03 Nov 2023 16:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699055434; x=1699660234; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sACPr0rKi8cX3KlKRVHiT5WKzJVsmN4Phr38A3lXp/c=;
        b=AMIAUpo0R5sa1oZlvUZMRjAl/GjX5nEppcH1B671I03X2TGPsMHzdiJ06v/JlGA3/4
         CQ2cmwDv1dPxuOzuMK3J8q3bNvernmkB6f8tucwP0MzQWlxcBP6H0vTerlxMEDZV5bX8
         xPVd2Zp6dtmZK2dNg/yhc+gIXL8GRnWsoKabz4ES2Avk08F5ZOylJ32Ucwao9ga9JE8G
         g1sswnOdiPy7N6C2CGscYyRV4jt9OIdg7DDYFf82ALOPF+lbZXGC9lu5NjUKT9WgTU+k
         uJaQaTgO7VKWbzWJcnSvcnXgxYqWoLugJpP8ayA4n15Fh0SOhTzq+C0OYc6++oZHVxAX
         Tbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699055434; x=1699660234;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sACPr0rKi8cX3KlKRVHiT5WKzJVsmN4Phr38A3lXp/c=;
        b=ZMzHnqOWQBhBY7dsPGT/yVZ+0K9hTnCbStcczLRnSPTpYxhjK62Sfkp4SE2FXtEIlG
         yeiaUfbRyZOS2mue1ZB6UDjg1JsHQIefqc9u58wMNMMnwHvjaBNFHq7fx6LlNUQmDjs1
         InVOkJu+QMDX8KesIscwkIM1tECnq5hImnjpfx375hVawWjfRhDEl2PvVRrmhvEq1xGI
         YcldMqpUfSW+DLKWamkIqJxCTpeRfAwTh62OZoNOxAvgmffMDKbk+zTbNH9oU98JYQTI
         zhXay6rcx/cGkb9l3inTiuxvPKqSHKUO3togIGM4NMnlDsDZYgsetiWNUWcdIQeDXZWr
         WmJQ==
X-Gm-Message-State: AOJu0YwRLfd4BE/I+0Z9wAiTrQXZc8vVBjvYBZoRQqdp2R47VdlZxPU7
	ej1ubAm3t47yWachtNJqWQ==
X-Google-Smtp-Source: AGHT+IEWWMG1J4JfSIlgllBm7mvq8Movg0NCBRyRh8TmsSN+k2vGJ/Di1X7yLXiLZLHwYVZsXDttBQ==
X-Received: by 2002:a05:600c:4707:b0:408:5919:5f97 with SMTP id v7-20020a05600c470700b0040859195f97mr20266318wmo.25.1699055433652;
        Fri, 03 Nov 2023 16:50:33 -0700 (PDT)
Received: from octinomon (202.51.199.146.dyn.plus.net. [146.199.51.202])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b004094d4292aesm3916805wmo.18.2023.11.03.16.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 16:50:33 -0700 (PDT)
Date: Fri, 3 Nov 2023 23:50:31 +0000
From: Jules Irenge <jbi.octave@gmail.com>
To: mark.rutland@arm.com
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	namhyung@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, adrian.hunter@intel.com
Subject: [PATCH 1/3] perf tool x86: Remove unnecessary  conversion to bool
Message-ID: <ZUWHRwR-n5y9vE9o@octinomon>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

coccinelle reports a warning at x86__is_amd_cpu()

WARNING: conversion to bool not needed here

To fix this, the unnecessary bool conversion is removed here

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 tools/perf/arch/x86/util/env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/env.c b/tools/perf/arch/x86/util/env.c
index 3e537ffb1353..5b0db77f8e0f 100644
--- a/tools/perf/arch/x86/util/env.c
+++ b/tools/perf/arch/x86/util/env.c
@@ -15,5 +15,5 @@ bool x86__is_amd_cpu(void)
 	is_amd = env.cpuid && strstarts(env.cpuid, "AuthenticAMD") ? 1 : -1;
 	perf_env__exit(&env);
 ret:
-	return is_amd >= 1 ? true : false;
+	return is_amd >= 1;
 }
-- 
2.41.0

