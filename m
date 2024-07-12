Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1A816F0C1
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779773; cv=none; b=tbzNJbgwYLmcdA4XYZn68efaQlox9/7kndiiKeGjVC3EYztr99FOtqA+78CTHAjABAvHULzyOyRwLY4c1dSNuya/Kz9Gx3ZoFxSfk5C+GbZojxkvXqdeay46LprEuw1iZ0x0vtsejofgukVCqgWJtk7Q6ANuLeq8YIpLLuL4tcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779773; c=relaxed/simple;
	bh=je3qaF22RL4HfX3R67/ksTiT9VwR2BesGe7+YwV5wI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jg6TIosy9uHc0YOTG6UJ6ryQNjnBB7SJXOjDN1YyYSQqTcESGxsfoHBWu99cvajT3tyxyuTDe8hmBURiLMEpxGDr5CsMwf5TZ4gXyktTbQeg9VC2ovq0I/lx2T2+Lw81eoPhqN3wuYRKgAliTN1VtglimemMWgdUDRCf9DxbQqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B5VyvNr1; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B5VyvNr1"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so25263851fa.2
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 03:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720779770; x=1721384570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwI9jTEsVvDswQgvITJiqUvAl80XwA5xHpIDYVZZf9Y=;
        b=B5VyvNr14ybv/4C9zLT4ojRrRK6R6H3pgMfctrnQWNhU/KMYIQPI5GzE3849IAX/Qi
         HYsSBu7BkaHbinHMxWf4r2SKx99RCsunQ+akgbvisf797L1+mTpB28LTeF6V8sV95YGf
         WtUyxHVvjwkMQzvy/tDhSISlCBT/YqX76Rr6YEurhv8MhenqklegKDVmUZhVyAMLjsiF
         /Dcq6bfvy5U/U3NJOByMPwU+x4rStmN4HyaI+kFTAH+oHSjVvsA8YaEDLv0levqDt+gl
         lcmOoTLHQt5XtJqHYEiJRrmd1kzi+d1DLnFH321tAzvdO3i26efkScpF3PJ0PnDQ3K97
         JIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720779770; x=1721384570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwI9jTEsVvDswQgvITJiqUvAl80XwA5xHpIDYVZZf9Y=;
        b=YhcYVprt2t1vDaffeL6osEb9jdzmu/Wmn2gpkyyp9I5sw1sxlzpL07EXG59lBRTX9Z
         lC+7JzzfTuxibKmt83GXT/55REjFTb/VT+RBAL2wcX5TZOqZBQPBYNk7p11iosg1x94A
         Ltg6Dl+Qw7uaIrPLuNRMeqv/1MjMwKr34VPPowoeyEjby3fKPkl+KheTS1yKywW/asLO
         CLjVH7Zi27d8OxdD+g6adICh9iEnyU78P6YT6WdLQKK40bJLAwqFqoA9dvbONpbjeGX2
         DRqprmscYS5MIGD6O5qaALNx/5pQcfAr53A6irZel5Av1GZFGGRIOX/Af68DB33AJIG2
         0h5w==
X-Forwarded-Encrypted: i=1; AJvYcCUzhxz+PMZV/vjecP2Yzd5W3Le6sWb7JBXcqGdaws/qisMYmlaAYUQNd8ZcERlKejbw/zIe3eteS/SlVtRHohEGHe9cOWGRXJWBJsf+yR1L4w==
X-Gm-Message-State: AOJu0YyyyiktuKewyxmK8RHoe0//ibte9OoAshv9ircEpfSXAeybHt31
	PozETj0MFocSIyE4NUvAtPJJFieqBhjkwmkkkFTijT6hGwsPFD8jCIFQn/kbg6s=
X-Google-Smtp-Source: AGHT+IHb1uo/ezehFmvJBG3pixDiP0iKwZcCOyic9lYbULsOd868Wy8XD42z86zOXyTa11uw8ecUbw==
X-Received: by 2002:a2e:3315:0:b0:2ec:565f:ef56 with SMTP id 38308e7fff4ca-2eeb30b4d38mr72972731fa.7.1720779770420;
        Fri, 12 Jul 2024 03:22:50 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89164sm9911058f8f.63.2024.07.12.03.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:22:50 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com
Cc: James Clark <james.clark@arm.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v5 09/17] coresight: Remove unused ETM Perf stubs
Date: Fri, 12 Jul 2024 11:20:18 +0100
Message-Id: <20240712102029.3697965-10-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240712102029.3697965-1-james.clark@linaro.org>
References: <20240712102029.3697965-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

This file is never included anywhere if CONFIG_CORESIGHT is not set so
they are unused and aren't currently compile tested with any config so
remove them.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../hwtracing/coresight/coresight-etm-perf.h   | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index bebbadee2ceb..744531158d6b 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -62,7 +62,6 @@ struct etm_event_data {
 	struct list_head * __percpu *path;
 };
 
-#if IS_ENABLED(CONFIG_CORESIGHT)
 int etm_perf_symlink(struct coresight_device *csdev, bool link);
 int etm_perf_add_symlink_sink(struct coresight_device *csdev);
 void etm_perf_del_symlink_sink(struct coresight_device *csdev);
@@ -77,23 +76,6 @@ static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
 int etm_perf_add_symlink_cscfg(struct device *dev,
 			       struct cscfg_config_desc *config_desc);
 void etm_perf_del_symlink_cscfg(struct cscfg_config_desc *config_desc);
-#else
-static inline int etm_perf_symlink(struct coresight_device *csdev, bool link)
-{ return -EINVAL; }
-int etm_perf_add_symlink_sink(struct coresight_device *csdev)
-{ return -EINVAL; }
-void etm_perf_del_symlink_sink(struct coresight_device *csdev) {}
-static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
-{
-	return NULL;
-}
-int etm_perf_add_symlink_cscfg(struct device *dev,
-			       struct cscfg_config_desc *config_desc)
-{ return -EINVAL; }
-void etm_perf_del_symlink_cscfg(struct cscfg_config_desc *config_desc) {}
-
-#endif /* CONFIG_CORESIGHT */
-
 int __init etm_perf_init(void);
 void etm_perf_exit(void);
 
-- 
2.34.1

