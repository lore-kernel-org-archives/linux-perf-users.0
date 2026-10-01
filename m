Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2E7515985
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790864497; cv=none; b=TJEtpjbWuB9pKdLN9LrT4IUYVSWg9D5wkuZS75TIJzZz0JaMz1qjtKQIXFp7NtxmbFiSYHLndcGV4WTG48qemhpZ8W/u3cTevBsjGfa8IMprQzJ9Z1KhAfY6w11MaFp2FhH/twQ/Npb1sxaSKk9RvG2FlTim7K/kQ9t2tD17rKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790864497; c=relaxed/simple;
	bh=znDGNmYS3o91MES6yjKJMlSzUYv2kb9QpctdsCLHqro=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ofdG3qF2/Lp9olgFNBSfp9XTnBDuIj6sdizrf2xFEpnZDlCFGD+5TRJONx1y0uQPjzmCgb1eYs8R854tk/PgD0MSf4iWF6eIevL2VN5dNUyZEKqrn0QbIukJY5eP0Ifor3I4d8NpblL88J1xifCmpAgM92QV4hX3bLOSh6/KmRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RkF0jvUn; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RkF0jvUn"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48af9f88c95so927908f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Oct 2026 07:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790864494; x=1791469294; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S33UzsYXrhxOtgRyb+fkmOHpk0z2PGLJbFC6/Ufui6U=;
        b=RkF0jvUnfJXJR1wS0WVIgd+BHZURzY7Iul4vjDM15yDHerquxmdUKecx7gSi1GxAmr
         FhVcsXLGVob1pfyc+yr5z2C93HEVyx15ELuxdAKNK200FxslowGSjCxX0f1vwxi9/J/k
         VX+bQ4yk9cXShdiMiJQDKnR7+54WROvfryTWxtv2F2LLm8a+hwWj8z1x/fk4GJbeF6wo
         gk35oUGSuZRfo2xy3qwHfqqD9VXQiIS6Lj5iP20tx3en0UqVy26JAIFMR9LD9d3K9fg/
         t+3UlOFgt1fOVT4pQavsKCX8BeLcIQ/xEDz80tz4q76Xwjkmj2uBBQ85cIECfY2PyZxO
         8Kjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790864494; x=1791469294;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S33UzsYXrhxOtgRyb+fkmOHpk0z2PGLJbFC6/Ufui6U=;
        b=waSptfpy8Gb+e9+qI1QCIbqp79/YO0w8rw8lpC0MJS/zlV10axH76HZ08agQMYC61I
         aQGgq9rGcW62V093FPPLgtbKW49lnKci2eUrbQMKOSORK9/8+E4QwzN1ZpcwXU7iNZ5O
         ljbG+um79ZkukFEuMR57NhsYkXCoGhJ9dcctfJXvzy0xWwb8gdx2CzssZacTjkbOFvYd
         Nnip7E/kO/RU2j8PtghMX6i7zTrzZnK0pi72XtBy0iikmn4eriopYUeCLeXA3No12pXb
         KIzlcn2bXVMzbpZeZYywQF0r4yzEVqk8CguJhcyi6VJAKwmrzNi/mNk2VXm/FOnVWmv1
         QyaQ==
X-Gm-Message-State: AFuF++mZrTs83qSCNExGj3VrBZf8oOrd+TBXjwHhpIJYOaLMxzaGKvYm
	npKI9AQHUFc1Re9BcFH0qHWt6efXV/r6Q4K9OY17uGkOGUwfNQTlhjARGTru4g/yeBo=
X-Gm-Gg: AYBFou3iE85fV9ecYQFWFH63VEuR09ZBLjyHxMPt5gH05njXo5KrMRJXUDQm3pciQhf
	AAYDXDlxhEyJ2fPw3sQuhHkzwDLeYUgN3/n+ph0hU6TQ2fmkXBryk58vD9beXkWZ9QB50cL1oak
	BtWaRxVPzPyqZbhPEIuJXw1ZwTQI0XVgG5HCvI4eKkJZureFiYBB1xLq6Bhap/j0V/pyLeiJQfS
	iP54EwWyIP2r71IXXVUXfKECZGbOIH9hT1FESvb4QFfbakbqUfv6XwA2qDHNanIwKDL2k33vH2q
	F71xOtYVwC9R3t4UUI1DIUjoIqQa8KkwXf3wks7yFjbk43S8+dbuh1s70ZkBZ+yvOhxs++rZ1rb
	F7x+PN/1qrINz1GRDVucwi4nlRWml4D+UvPkj3ejBtGlSsOFN6XSDw6IcpVlpY6S8kAetfnng53
	2vyp8Y/G2eCiowdAkl2kb+YbrIf2yfzSnCPzwUiY/qKQuiqdvMLof1xf2E/9ICouSL0a20yBVrz
	MY+UgKGOP8NPQ==
X-Received: by 2002:a05:600c:a107:b0:4a0:1ef1:b62b with SMTP id 5b1f17b1804b1-4a01ef1b7ebmr38500685e9.10.1790864493549;
        Thu, 01 Oct 2026 07:21:33 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a020f7f1c2sm34783975e9.2.2026.10.01.07.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:21:32 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/2] coresight: Retry failed HW_ID writes
Date: Thu, 01 Oct 2026 15:21:14 +0100
Message-Id: <20261001-james-cs-retry-hw_id-v1-0-4d45ab46cde7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFpsvmoC/yXMWwrCQAxG4a2UPBuYmYKIWxGRNvOPTcEqSb1Ru
 ndHffwezlnIYQqnfbOQ4aGu16kibhqSoZvOYM3VlELaxhAij90FzuJsmO3Nw/OkmXclQlopKfc
 t1fRmKPr6bQ/Hv/3ej5D5+6J1/QAt3Ef0eAAAAA==
X-Change-ID: 20261001-james-cs-retry-hw_id-8f1ec3cf2db3
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
 Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Extracted from the last two commits from [1] as they were only
conceptually related to that patchset, not functionally. This can be
safely applied to the driver separately.

[1] https://lore.kernel.org/linux-perf-users/20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org/

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (2):
      perf/core: Return errors from perf_report_aux_output_id()
      coresight: Retry failed HW_ID writes

 drivers/hwtracing/coresight/coresight-etm-perf.c | 50 +++++++++++++++---------
 include/linux/perf_event.h                       |  2 +-
 kernel/events/core.c                             |  6 ++-
 3 files changed, 36 insertions(+), 22 deletions(-)
---
base-commit: 75ba5c486ea071d44d3f61318c88a7793bc768d4
change-id: 20261001-james-cs-retry-hw_id-8f1ec3cf2db3

Best regards,
--  
James Clark <james.clark@linaro.org>

