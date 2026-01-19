Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E78A27B336
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2026 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817933; cv=none; b=czF5S+ObznYI5pAFCBLZx9t2zAbG741K6J63nKgmoQT2CNe087Wq8mn8DAAVJNYZbV5PA9BFZ2yxvNbbqSffEw7zJRoi2ZSYg0/N79Kn9pzMINqLKFLytCnO2t99n2JK0fksc7Z6cxyeGy96Gk8V1Cq6+CqpxiB/yhkTPDhVDHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817933; c=relaxed/simple;
	bh=2jXClWYETblrv7/GNCDCHF2VA6IMOI2Zs7BVfmEIGvg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rmXSBX+fXVPj75FQneMMcNeP2Ipt2+/Fls1uh36AW5IrJ8sQaxAs+fVQagDidrtzq0b0k99byHg56jf/euLe88ZMFvek83rVGvxdzSCOprt3+Bh8ZI7Vg3lscm4FifO686F6KH5Gb7wnTnLHraHgMYbbafDqRQuecwCeUpu3j20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DrtU42dY; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DrtU42dY"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-431048c4068so2388177f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2026 02:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768817930; x=1769422730; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MhEi7wyHnyPXObmogB/mGJrCmlxVONKsyXqEGSo+Aug=;
        b=DrtU42dYTR9QorQlwDMBKgLCyAUsiT4zUWaYS67xVemH5NdXXNfUEiM+aopBjdHN8L
         kKq+tdbcyh6QB6g3bwg6vJObguLyDbPzPVdH3wbm8/vwg0e10hc/QmYDTUbW73eD8xcN
         269rn4STRCo5Cj1hShxVR+CIVJXwZenGyPcFLm4XoxZjSIJLD/hxEvSLjcaY4zGEtMSp
         PAZ5QvDa5ZN+kY7YegLqpOzz4lnAvDc3xyK+MW9ttCibIAV0hGvcatbk4Ljj58NB9fEo
         Kf2b+6QlMxn11Iosje0mqtoo6aZMQ4i8O+AqedcqhToMtMj+b1Dces1egFvTuwptS464
         3tjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768817930; x=1769422730;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhEi7wyHnyPXObmogB/mGJrCmlxVONKsyXqEGSo+Aug=;
        b=id6vo8W5NhlUEUZ0ZcNz89FO/5Vr/N7VOYci2VcB5uezXcP9DflwD4LDI2cxL6iFSE
         vfhRNMTrZ/IkdpYUFC+cPd4Tm/0ZWZvkVHNtPcCJsqsG9KyBBovk+7foxFf6Ms3VkylQ
         9wH/QUyqbTXkO87+Z1rKXHB0hnYcuFEEIho1pfydQY0XMq2odpkclQ+oje6VgEQWSWmp
         HbN2e813/sVyi0qDVKL+aYVFxXLI1RDz0AKl2s8rx678MN1iKV7zII9QTtAZY/2p1IoO
         Dk+k4LhnJHsq+szE2fsEu77FwtYYRV9zm1dVF/U4Usgjg4H8aT7olE+QQVe6b/RYQNil
         We1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQZPoiPhlpnpX22Ge97mghC+QJC/5hLOBhMlBFxkrfemSQB16Fo5fyE1dN6dbPFST/P4u5d/nQJArCW1vMnREf@vger.kernel.org
X-Gm-Message-State: AOJu0YwSbdPFes6/jmSxP9plABny0LWB+1Buaq53QqIRQesKzWJ04pd8
	XzJyUQMRvqLVIsrYmvWVxz+uciDTTW6zJdbUSPDrzSBXQKo127tjh0vPAqBsUuzs03I=
X-Gm-Gg: AY/fxX6T66TSobJ/kizzkDSjOcVhmtBFV9d61d77bwTHP9kLK7xv7ip68MA4jq6j6jQ
	bb9rSYwTcBSZOhH4F6UqM8vIfpfz+vvzYzaqSb0ZnQvqZxfdgmVT9WDDCq9XS+WorDSurI943Bb
	9Kwp8lbRNPCGUqLhdOF1H+pknUDOahTFZVtoeyno+fhL3xfCp8Kwq1FCJzaAnmO6DhqGUCMnmCZ
	NyEMI3cqAiCZGQN9oBMl7UJiK9b9hayzAgbiLSdARnE6u428YRJqjSFX0HdjxeAw2WXodbaQcEH
	RbyC1TAo7PwoK76vEai8L9/W4TJuIPDCBa8padqFk3D1wTDyCRwZb92GPmUtzSkCGnJmqBxwVFx
	EYP975xKcnrN8XAL/tCCYvWwOu/p/6tVVW235QQM4OyeWhu2ad5zXKcBBMR3ynxXZSZYt1kCiFO
	9i1rLq2CC3vQwEjvJj+7GO
X-Received: by 2002:a05:6000:2c01:b0:42f:b6ea:5e4 with SMTP id ffacd0b85a97d-434df1164damr19213925f8f.28.1768817930307;
        Mon, 19 Jan 2026 02:18:50 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e6cdsm23286150f8f.31.2026.01.19.02.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 02:18:49 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v2 0/2] perf cs-etm: Fix decoding for sparse CPU maps
Date: Mon, 19 Jan 2026 10:18:34 +0000
Message-Id: <20260119-james-perf-coresight-cpu-map-segfault-v2-0-56b956a629ee@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPoEbmkC/43NQQ6CMBCF4auQrh1TagriynsYFpMyLWOANi0QD
 eHuVhL3Lv+3eN8mEkWmJG7FJiKtnNhPOdSpEKbHyRFwl1soqSpZlhqeOFKCQNGC8ZESu34GExY
 YMUAiZ3EZZiClJVqNWNdXkb9CJMuvw3m0uXtOs4/vg13L7/oTmj+FtQQJ2BjbVXWlL0j3gSeM/
 uyjE+2+7x9z7o902wAAAA==
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Thomas Falcon <thomas.falcon@intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Fix a regression caused by an incorrect assumption about auxtrace
indices. Then add a test that would have caught it.

---
Changes in v2:
- Fix cover letter and subject
- Link to v1: https://lore.kernel.org/r/20260119-james-perf-coresight-cpu-map-segfault-v1-0-a9cfd67653ae@linaro.org

---
James Clark (2):
      perf cs-etm: Fix decoding for sparse CPU maps
      perf cs-etm: Test sparse CPU maps

 tools/perf/tests/shell/test_arm_coresight.sh | 54 ++++++++++++++++++++++++++++
 tools/perf/util/cs-etm.c                     |  3 +-
 2 files changed, 56 insertions(+), 1 deletion(-)
---
base-commit: 571d29baa07e83e637075239f379f91353c24ec9
change-id: 20260115-james-perf-coresight-cpu-map-segfault-e250af5aa778

Best regards,
-- 
James Clark <james.clark@linaro.org>

