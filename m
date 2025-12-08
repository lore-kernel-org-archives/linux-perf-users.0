Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326BF1DA60D
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Dec 2025 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203801; cv=none; b=cNEKT4725soWlw1L60cFHVGrwMi9ltylyIzQPtgRBn+z01E1kGtLQS300v3QElAlULACcM68mtr4PSsAjbOoiWE5sp088f1nEXLShiBno/SYL2Q/ZNZkfnOGnsIgOk5L59kpQhogO0zfWwdU1SWM/AJ2VfvsknOsQZ8teF0MDAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203801; c=relaxed/simple;
	bh=tboJv0E+aDIT81sR1qNvokg5og8ef/gvDVhgwxvivXQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r+jfnNiEQC1Fr65AGbtHshUFw6iI+dcI8PinzPyQjhJpIHNUS20lIKE1QreX0I195swdGjVB98CsxeUj6uFXZ4egVrO6YeVoLZAD02azcUSvfmVaG9R6B8ubNussWDnk3KYDoKmbLHAgv+dGw3syDcHIMd8do5la6jvtEX5EDKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ef2jBb14; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ef2jBb14"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477a1c28778so58629475e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Dec 2025 06:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765203797; x=1765808597; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hoaFM8gsTHBxZpSQ2rcSy6Ke4PCkz4T2Sf6PrdtW3hc=;
        b=Ef2jBb14J7MD7TKTtn+s3tz5Ij+cB3Ap3auTlgmQhEMVw/SGsGOaCUMFUFYO3W70Hc
         SWCRms10qDD5ldB4RBdh5z99tyq7lqHwEMC8eEWXoeL2rw4vjuI1z+ffC6amKC2Y2TwS
         q/MfrSIKcLdoMTi1AnWMyHhvHJcgbizvuUTCI0JM+jBUeBibi9J0CTjPtWlVMz0pMxcQ
         GHDIj5dhmLUxtdJN/lm8z0cCwWb5/8uNeZf+fJPAsWeEbxqjMDuea6wxNqDkE8cfZ/xH
         oSpgVz5BDu3r/N5at11Tuu6kYYRPiSf5gKCnbmX+Le8hLQ9idatufHCsxyQX5ij2D4Eq
         J9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765203797; x=1765808597;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoaFM8gsTHBxZpSQ2rcSy6Ke4PCkz4T2Sf6PrdtW3hc=;
        b=B2PVUQxqHb2UpxQiCtL8I6K4UF3f5MLc+YaP+7eMZLNUx1XHBoihSH2t0vxcKxtsS7
         PD6RI/KEDcWDNMp2K6BfzJ8uK82bb5yfG0I265BteRAnPBGP1q1NN/nnOTf5c1l2/u7D
         Tuvb/s7zDVhhYJ2tYTo3zJmQ+pX12v3NLDl/DdnOc9cPijaBy6J+5N11DjI2rzA9QJhS
         YE+Z2aGJCFhFG7k7QSns+ydnofUmQtvjjHdC/hI/s3YqnW/VI3NBYzfI24DQO1HtQ5Jz
         cLznU2HS53VUmPCmgNBgeeB5A/EJFbS4ERL7IxAgS4mHN+X9AIRmj35a7jaB+ZKhPD2S
         DHXQ==
X-Gm-Message-State: AOJu0YzkB2IfDNzpqSDwiOJGqCkFZmqDwADtW7UyyYBAEnT1tr5d5Trm
	+N6YIFrxC20bi5WrkPg0/dfJhc6TzwCpReWMIxHbcXnDTwQlCdFkPttfhyPvwSG77Lw=
X-Gm-Gg: ASbGncszBX36I5FdlCZ42uixG7UUeXNyYZVJtItcavTlQl1TJ5MyVJ3GY+ICpzE4erm
	AyDruXFBEaSithcVlycYEA8s1QheXwe921ef7NEm8dBXC1n5MVVkN9nW0njfLMMarbFEXEVINgT
	15y0bpNOxcMfUggQQibW34eiOTGcHvsMwSadOI6hJiv2aFNSCcekx15Z8y2ap8lMRpcU7R74Luo
	N0UDM80N5V2rc9Jqtr3GtkJ2MvwANylo5zfwRZwgGlWdaM9B5KRHbrX4f+7PNAreELIYYbaQfDq
	BZ0q6p52+1OxkQR7CRZtqM97LHVWIJjuiEwnaEg3j2quUYwcpyAp4kAbqPY64uI0STHK4NlNJ3o
	H6hsVSzHxVmCY3kwjAcggL9ZnM72iPN5/s9h4PR+ryTLN7mCr22+WsV0A5FCHgY83Ci09bVaiTP
	7jg47zzfQTzTr7wD480Nr3
X-Google-Smtp-Source: AGHT+IE/cC+g7PtcpgB5/C4izQvgvOAmYHfqEb5ZHOwtqieQOr+FW/7g/kT51096WpKbc0yjg3TInw==
X-Received: by 2002:a05:600c:4e14:b0:475:e067:f23d with SMTP id 5b1f17b1804b1-47939e2b900mr76844035e9.25.1765203797445;
        Mon, 08 Dec 2025 06:23:17 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930920e0dsm248561065e9.2.2025.12.08.06.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 06:23:17 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v2 00/12] perf cs-etm/arm-spe: Remove hard coded config
 fields
Date: Mon, 08 Dec 2025 14:22:03 +0000
Message-Id: <20251208-james-perf-config-bits-v2-0-4ac0281993b0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAvfNmkC/3WNQQrCMBBFr1KydmQmoBVX3kO6aOKkHdGkTEpQS
 u9urGuX78F/fzGZVTibc7MY5SJZUqxgd43xYx8HBrlVNhbtgYgs3PsnZ5hYA/gUgwzgZM7gmFv
 CY8CAaOp4Ug7y2sLXrvIoeU763n4Kfe0vaZH+JQsBgrXsnQsnxNZfHhJ7Tfukg+nWdf0A2rJ3/
 L0AAAA=
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, leo.yan@arm.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

The specific config field that an event format attribute is in is
consistently hard coded, even though the API is supposed to be that the
driver publishes the config field name. To stop this pattern from being
copy pasted and causing problems in the future, replace them all with
calls to a new helper that returns the value that a user set.

This reveals some issues in evsel__set_config_if_unset(). It doesn't
work with sparse bitfields, which are an unused but documented feature.
And it also only writes to the attr.config field. To fix it we need to
start tracking user changes for all config fields and then use existing
helper functions that support sparse bitfields. Some other refactoring
was also required and a test was added.

Signed-off-by: James Clark <james.clark@linaro.org>
---
Changes in v2:
- Remove macros in get_config_chgs() and some other refactoring.
- Support sparse bitfields in evsel__set_config_if_unset().
- Always track user changes instead of only when
  'pmu->perf_event_attr_init_default' is set.
- Add a test.
- Don't bail out in cs-etm.c if any format fields are missing (Leo).
- Rename 'guess' to 'synth' (Mike).
- Link to v1: https://lore.kernel.org/r/20251201-james-perf-config-bits-v1-0-22ecbbf8007c@linaro.org

---
James Clark (12):
      perf parse-events: Refactor get_config_terms() to remove macros
      perf evsel: Support sparse fields in evsel__set_config_if_unset()
      perf parse-events: Track all user changed config bits
      perf evsel: apply evsel__set_config_if_unset() to all config fields
      perf evsel: Add a helper to get the value of a config field
      perf parse-events: Always track user config changes
      perf tests: Test evsel__set_config_if_unset() and config change tracking
      perf cs-etm: Make a helper to find the Coresight evsel
      perf cs-etm: Don't use hard coded config bits when setting up ETMCR
      perf cs-etm: Don't use hard coded config bits when setting up TRCCONFIGR
      perf cs-etm: Don't hard code config attribute when configuring the event
      perf arm-spe: Don't hard code config attribute

 tools/perf/arch/arm/util/cs-etm.c    | 193 +++++++++++++++------------
 tools/perf/arch/arm64/util/arm-spe.c |  15 ++-
 tools/perf/tests/pmu.c               |  90 +++++++++++++
 tools/perf/util/evsel.c              |   6 +-
 tools/perf/util/evsel.h              |   2 +
 tools/perf/util/evsel_config.h       |   7 +-
 tools/perf/util/parse-events.c       | 248 ++++++++++++++++++++---------------
 tools/perf/util/pmu.c                | 112 ++++++++++++++--
 8 files changed, 459 insertions(+), 214 deletions(-)
---
base-commit: 2eeb09fe1c5173b659929f92fee4461796ca8c14
change-id: 20251112-james-perf-config-bits-bee7106f0f00

Best regards,
-- 
James Clark <james.clark@linaro.org>

