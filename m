Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EFE1F78E8
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737563759; cv=none; b=OvDPwECrXTq6zQo79B7M/BJBMAP63c39AYgJdw4Q36c+chZ4yTiQ9To8ASuGiMmy7zZM7vgxz1YR0Er7EBYSlFxwTigqz9OKqB16BICHEH68sctqEWOM5U8Ji6wUzLrNzaQfvPotArdfEYK14WwsboBs6JK5hTHIpMFU5Q0V1Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737563759; c=relaxed/simple;
	bh=A+AvOGO6p7Uovp/kkPHZrjTl02mH4hjt6PciUgGVdQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qcqV8IbooBCv85W6/wJ8hV4pvvd3oT+M32dQuHz3Jxik5H+zumBzTCeLyT7ovThx59TEhWQf2TlCXOpWPv6jnp0CMhTPudkUVpS4Cpw3VCNApkbVGXG/j12ui4WbPfNWrOLc3EbSgTSrFU7JYuh531rs2VUIGpXbsAmbxJrTJ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BBeXmSLH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BBeXmSLH"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso7722905e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 08:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737563756; x=1738168556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ipnamBnA9xnGXJ0eEKVyYuEh0wGSuZn3Ia7iQAJ03U4=;
        b=BBeXmSLHB6sswamOFo+Oec7DmF8hQacOJEqrF3pLKZ6XYDvykDRVWG0InbBBSsUrq9
         5aA3PNzUUvPONruufpGUW6sK3RY7lGK4GIuyR1vBPX5KgSaKNoKPH4iC35O16v7soP4M
         YobYew/nF8UpP4zk2pu2JJxEFWz7TpGyDU89wAlK+xH61to41PcOkc5knNNlly+O443g
         k2YKR2rqOlXIZwsjaK29uUaMzWenMIosRK0bx4H9GamfRoHH5eVpDBH0EbboM2mH62l2
         gKntuVdYWzrLWQfD2Bg+qckaUnsKjChLslbBcofVEj4H+WIBaIgJG1j7BPlz/wULv7L7
         pdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737563756; x=1738168556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipnamBnA9xnGXJ0eEKVyYuEh0wGSuZn3Ia7iQAJ03U4=;
        b=S3MLMgi1XEpKQuL4aLEoMx3f/t3XsANsGNtTyfp1H94WC3TzE2BFRDoAay2VoIVtkR
         P9SxNcpStw6wREV7Cb8m1473JheWtqVKX7UaD86a7JxgoaEvSddf1JVp0wyCMdUz8F3r
         T0kPUvO4gG7oW2su+erZQ7Ldt8sZX79hFD7dHCZA1HvY0huWmAme3qzL0JnFsqDlg+7V
         c73vxjkHIEl+CyC32rA1+xOPSzbRbHuNbICZ74N2O2yJt80nJqfZJ5/4DMfDDJK4+9q8
         gchoE+s8DvpYZQTQ99Ap3McXYlKJmMmYqepGnFz+QYarKyxeEG0Ihvoej1LYF/JmmQkn
         dr6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZ7lEHYbCcZ1hZmWroFFhlFvIacz2GPUfMotNO8C5b5h4bbsO1oEhVBXk7f4yXZyIRROGuGZ7wjOQYyQ4wWW6h@vger.kernel.org
X-Gm-Message-State: AOJu0YyuZ8fBoT2V67EcG25BSoGbZYwV3gCME7czfMz/rVNzsQnfwDde
	0Xk1KGhSfNUTw2RK9HV28uFy6znlh5UIy5nNmGAUPsXca+IbyhW+cCHZF/Ya6hw=
X-Gm-Gg: ASbGncvH4fQJ3MA2dFi+qoHrm9FhqqxRLwbZwHpkk2ayWULm/Fz8ezfZEn0a1NqlchD
	TxNwShVWgbqgaC47CQLnXepAZZctwXRQQZNBXVASH+Q/aMnKVoz/5eJ85LA+ukJcLo1BJ20xBkq
	da9VMn1VHz1ju83MnvZOE2IP+vQpaVa00ZlDPchGAbwiiMfaOxgmLD1tNpdyTdnsAqf+YBAvy1q
	PgKdY8siyX909Bkg6OML2YXB3qDd8lYrd8dipfHIqqMGBrGllsGLQzG9DzFmdey3qYNeA==
X-Google-Smtp-Source: AGHT+IEjsJ3miTtjbqVNbItDAuSuPcc9ffd9sOK73oYVQvHYD9lipqEM4HVnFQKkdvuYoIbVxN0pnw==
X-Received: by 2002:a05:600c:3b83:b0:434:e69c:d338 with SMTP id 5b1f17b1804b1-438918c5e28mr171505425e9.5.1737563755801;
        Wed, 22 Jan 2025 08:35:55 -0800 (PST)
Received: from pop-os.. ([212.105.145.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf321508esm16983562f8f.10.2025.01.22.08.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 08:35:55 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org,
	namhyung@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	Akio Kakuno <fj3333bs@aa.jp.fujitsu.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] perf vendor events arm64: Add N3 events/metrics
Date: Wed, 22 Jan 2025 16:35:01 +0000
Message-Id: <20250122163504.2061472-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since V1:
  * The generator script wasn't adding new common events properly and
    also wasn't generating groups for N3 and V3. I've fixed up the
    script and regenerated.

James Clark (2):
  perf vendor events arm64: Add N3 events/metrics
  perf vendor events arm64: Add V3 events/metrics

 .../arch/arm64/arm/neoverse-n3/bus.json       |  18 +
 .../arch/arm64/arm/neoverse-n3/exception.json |  62 +++
 .../arm64/arm/neoverse-n3/fp_operation.json   |  22 +
 .../arch/arm64/arm/neoverse-n3/general.json   |  10 +
 .../arch/arm64/arm/neoverse-n3/l1d_cache.json |  50 ++
 .../arch/arm64/arm/neoverse-n3/l1i_cache.json |  14 +
 .../arch/arm64/arm/neoverse-n3/l2_cache.json  |  78 +++
 .../arch/arm64/arm/neoverse-n3/l3_cache.json  |  26 +
 .../arch/arm64/arm/neoverse-n3/ll_cache.json  |  22 +
 .../arch/arm64/arm/neoverse-n3/memory.json    |  54 +++
 .../arch/arm64/arm/neoverse-n3/metrics.json   | 457 ++++++++++++++++++
 .../arch/arm64/arm/neoverse-n3/retired.json   |  90 ++++
 .../arch/arm64/arm/neoverse-n3/spe.json       |  42 ++
 .../arm64/arm/neoverse-n3/spec_operation.json |  90 ++++
 .../arch/arm64/arm/neoverse-n3/stall.json     |  86 ++++
 .../arch/arm64/arm/neoverse-n3/sve.json       |  50 ++
 .../arch/arm64/arm/neoverse-n3/tlb.json       |  74 +++
 .../arch/arm64/arm/neoverse-n3/trace.json     |  42 ++
 .../arch/arm64/arm/neoverse-v3/brbe.json      |   6 +
 .../arch/arm64/arm/neoverse-v3/bus.json       |  18 +
 .../arch/arm64/arm/neoverse-v3/exception.json |  62 +++
 .../arm64/arm/neoverse-v3/fp_operation.json   |  22 +
 .../arch/arm64/arm/neoverse-v3/general.json   |  40 ++
 .../arch/arm64/arm/neoverse-v3/l1d_cache.json |  74 +++
 .../arch/arm64/arm/neoverse-v3/l1i_cache.json |  62 +++
 .../arch/arm64/arm/neoverse-v3/l2_cache.json  |  78 +++
 .../arch/arm64/arm/neoverse-v3/ll_cache.json  |  10 +
 .../arch/arm64/arm/neoverse-v3/memory.json    |  58 +++
 .../arch/arm64/arm/neoverse-v3/metrics.json   | 457 ++++++++++++++++++
 .../arch/arm64/arm/neoverse-v3/retired.json   |  98 ++++
 .../arch/arm64/arm/neoverse-v3/spe.json       |  42 ++
 .../arm64/arm/neoverse-v3/spec_operation.json | 126 +++++
 .../arch/arm64/arm/neoverse-v3/stall.json     | 124 +++++
 .../arch/arm64/arm/neoverse-v3/sve.json       |  50 ++
 .../arch/arm64/arm/neoverse-v3/tlb.json       | 138 ++++++
 .../arch/arm64/common-and-microarch.json      | 310 ++++++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   2 +
 37 files changed, 3064 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/fp_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/general.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/l1d_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/l1i_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/l2_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/l3_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/ll_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/retired.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/spe.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/spec_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/stall.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/sve.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/tlb.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/trace.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/brbe.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/fp_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/general.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/l1d_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/l1i_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/l2_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/ll_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/retired.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/spe.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/spec_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/stall.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/sve.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/tlb.json

-- 
2.34.1

