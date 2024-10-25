Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E5C1D363D
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729847019; cv=none; b=kuC4Rz1X/plAFdxAba0oUWK8eKqeMlNNma15AiqoqdpDrk1aH9qKkV+YW8tlsOihjuyyKTj1GWstIo3IktiX2wpg7/sohFTkde0tt1eWDMLSViSV5h5Sgehom8LSmzVaRk2iUfIpfmfHpFxbNQtdm5Sn0RT5sFoThVCDa8TDzKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729847019; c=relaxed/simple;
	bh=3i65461D+4XoZPw2Lwafzn0QzXalFUSDFfgTKdG3+Og=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O+ww3iCn7WF86Ng7r0J9tEfRY36AbPrJwjc4LZ0Dhf3b5gASvRvIpIbxhjdX9qgTHT3dUHy2o6GZ5Wu6JCbF7PucwiOa2QVcnFSdRVuBIcyfvgZHsR/xv6qpS4THuHE1ebUtBU34+eRCcAHNQSgCXQx6eHig/rthfoB6TG1if84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mv/RIVjg; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mv/RIVjg"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539fbbadf83so2440913e87.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 02:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729847015; x=1730451815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iWvkJJy1mehlDHyb9ikHdYWAO1HcKU43x1P4tAcYbLo=;
        b=Mv/RIVjgc4yGsirx7T66WsFwPJltiDbm517QGQTtCF2GUdZ+GeP1gmEUCrM4b9iucU
         1gfdnZT8OCi84Lfb04c/ZQHpU3/tgeg2N9qLIwWTTqWmXia8Bzvc5cNOWt8e2qx03lUl
         9NvY2yWg78311RibtRqcRse3BhZcNH1QSFBxzju65TLEO9SkE37h+hRTnYHL2ApzzHdG
         gvOMVbHmJfGSam6Pn35AP6p70XdcqOmYtOGIK72y2FcfiYHUHt00GGvrY71HdfblfgmN
         WdOzqdWpOE+vfc1PPiiUub9w2cG01GR+RuYNQHliSxyOf9aBXFM/S4dJHfKpetw26UcK
         whVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729847015; x=1730451815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iWvkJJy1mehlDHyb9ikHdYWAO1HcKU43x1P4tAcYbLo=;
        b=Q823djPP0Qn25gBusgT1O55G03IWsuDcqYL6GR+2MC8fwKiav12K1VgDog/f1ajXVG
         bAPoN/IU6dtCjoHBaG9R5Bz51sZmE87PW6Bvi/1/xUwc9sX0vd498RbsRn/i19l9wJeK
         RB08RqHUZo+HVKWUq9iIniR6m6uJow0caE8v+AWTpAER3s+/Sjo/QbA+Z5dB8GUweGiD
         BvsLSc+oxaWHwmX5XRpT4wueaGRCvu+xFe26LKV+o4amZaSHOvBxnR8Yuee+/9tjNNN5
         jrw+VwwoP8tQBCoC40k3g5/yj0HMczZEMZ7ERhtmSVHe+5bL17d9GZVyNrjLIlLJq4kB
         67Zg==
X-Gm-Message-State: AOJu0YyE9wZdUvKHiFvKQTCBTAF2AQMl+5kTgIIKr3+WnLyt8ssrflMY
	cgspjYFulatQNiWjf0FzR+A04Yai38iIm5LXVTUZqzcBrMNFOIFJk6C8gdQKUC4hI3Qy8X33m2p
	Gyuw=
X-Google-Smtp-Source: AGHT+IFn6MK5AhFx/uFQRxnLybRiy2rqn/lh1YAPpdvwpcC86UlBSya7gDvIKw312BamyODsOQ2tTA==
X-Received: by 2002:a05:6512:33cf:b0:539:dc87:fd3a with SMTP id 2adb3069b0e04-53b1a2fad1fmr5420922e87.6.1729847014945;
        Fri, 25 Oct 2024 02:03:34 -0700 (PDT)
Received: from pop-os.. ([145.224.65.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70c73sm988689f8f.72.2024.10.25.02.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:03:34 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	tim.c.chen@linux.intel.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] perf stat: Fix trailing comma when there is no metric unit
Date: Fri, 25 Oct 2024 10:03:03 +0100
Message-Id: <20241025090307.59127-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first commit is failing on Arm and I think the fix should stop more
trailing comma issues which keep happening.

The second one I just noticed when looking at it. I don't feel strongly
about it so not sure if we should do it or not, but seems like the
empty metric exclusion from the JSON should be consistent if we're going
to have it at all.

James Clark (2):
  perf stat: Fix trailing comma when there is no metric unit
  perf stat: Also hide metric from JSON if units are an empty string

 .../tests/shell/lib/perf_json_output_lint.py  |  14 +-
 tools/perf/util/stat-display.c                | 179 ++++++++++--------
 2 files changed, 105 insertions(+), 88 deletions(-)

-- 
2.34.1

