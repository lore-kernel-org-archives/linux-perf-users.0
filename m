Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C26416D4F5
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721643195; cv=none; b=m6NcymJ7IRWIZVIuEDqBOGpiI2R8L8yQcKgonAif98lreT91y5R2cxgUdR2ZFge4hOMHvRMP7FqRAmCwWeu4sdfz9Df7TCj33MLRgJ+euL2Q5cL5abh/UYtOcrCi4jEXcvDWonX2k5vkBnV4PHHYkNeOGE+HxB1TCG1LgIVj4QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721643195; c=relaxed/simple;
	bh=wVHh6zOEtD5JgYpRaWP8ByjQrHdnbNe5JxysK+W/6X8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S56ObjiUXNVZw+jra9rXAkvVLWl8s4It9KHMcgWGXSVxVL5jvw3XUmSQEh2ewelkvaE5DTjYuBVJeA5l5j4s1pNBBIyDw+YBhB9h4fkgESM/MmaC+6xuvyQb/Zjh7g6tUHGsirlK6Af0/l56AY5fpBDGZzlU0XebrSyKMd5uUmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wFdzV8iL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wFdzV8iL"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4266fcb311cso30873365e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 03:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721643193; x=1722247993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtaJjK7rrgJVkNfrm1RPI3wUUBorSunZ8bK+jPbC78c=;
        b=wFdzV8iLaDLWXZvF0L2CFYTvhfkZ6kbUNXf7GltKzu+n3n55gHaz+rNpTfEH0PE+ZD
         K5gzH5olc1CTPHoHakwFZ0cmH8HlpLGQAROfHIeHHxpovh9V6dBa8kSalxofDPaIZWPF
         B9m00vZD3scaZlTDi+dTZawWSGks7de6TtrDas8PcKu3VcO+77zpCUuF/0X0hrDD7aHj
         FywkTJf4qfNRESbmfg9ehjli6PxAEwdws2Re6+ijtW4ISxg2Kl3s1WNQgmQWDW+JK1QI
         q/J4I3jQVpvffZJdpTGSrFcatdeAMC9P4dIt4RAXRVBcKUh1y+hf05wC65JGxJynePio
         kWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721643193; x=1722247993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtaJjK7rrgJVkNfrm1RPI3wUUBorSunZ8bK+jPbC78c=;
        b=HdEgnny6aDAlwLqur8CbZmTr/HBR0EYNrPPJivb6EakdjLw3djpRATqLNZJz56ps6C
         /A+nWzMMJAGevQ7rFnoPuoVO5rYhU1dA2LF8y80uIK/04vpVHgmQPHjKiG7CIbUGSnpP
         XRR+8YnUw4s6EFUttmHw2cYK5QA/dqjE6Phg/AsWtcmzV3Uzj+qkCh3UzKQea4i/cjmf
         iwV6VvQbIG59z+x8JSBgCsHJjlHlbmT3zO5CO5/S3RqaGDKsnNUylVy8+f+I9IvVcScw
         0JLv3f076b3ev69FXUiZc2kVnPsoEkJ4Ou9RYn5XmEt3CcKCvGS3Y4iJXrKO+0nyZF5U
         qF+A==
X-Forwarded-Encrypted: i=1; AJvYcCU5P5MMhQg35mTNsZHakBhpFYf7KI/dcuLN4xLFxJ7AmqpZxQE7q0GSrqUveZuEfAaK4V90WrnmNCH0udvNUSy5Qz6e1hyfBiqkOl8GIccFVg==
X-Gm-Message-State: AOJu0YwLSOaEZfXh1oCXzgduXXrGCgo7zSj93rfxHy8cFKVyfVvjuGfM
	QIeUMcXWErmy1KlsnI0XQLawd2H7vz7fjBFQbq+aH4vNUabcVaiPYqLQL17ihJk=
X-Google-Smtp-Source: AGHT+IGdhd7RpxJePLbZIYhR6xs+qj7oZ8Lfr0TNgtXBBhZbnw2zVwMKW7uEaoI3NiSjTwpc8kM/Ag==
X-Received: by 2002:a05:600c:5493:b0:426:6ea2:31af with SMTP id 5b1f17b1804b1-427dc5753a9mr33453755e9.37.1721643192769;
        Mon, 22 Jul 2024 03:13:12 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8e436sm147993865e9.33.2024.07.22.03.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:13:12 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@linux.dev,
	anshuman.khandual@arm.com
Cc: James Clark <james.clark@arm.com>,
	Leo Yan <leo.yan@arm.com>,
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
Subject: [PATCH v6 09/17] coresight: Remove unused ETM Perf stubs
Date: Mon, 22 Jul 2024 11:11:51 +0100
Message-Id: <20240722101202.26915-10-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722101202.26915-1-james.clark@linaro.org>
References: <20240722101202.26915-1-james.clark@linaro.org>
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
Tested-by: Leo Yan <leo.yan@arm.com>
Tested-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
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

