Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E04346E73
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2026 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817359; cv=none; b=AXcyhv5I29qPoZagPdJBSJYLGeUqivKvTGAr0rDVLrWBrrFk5I35fOw+D09GCwpaYFcGL5tMHr98IM0U3JAwsOUpvSL+TOmE5q+WdIzbZpTMa1K996+yvuEMFD7FcR7azNC/1X/o8WliBr5EzB+VOpDbw9Vtx8WNSmgILX0qQEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817359; c=relaxed/simple;
	bh=6OtsfBJe1JSHH8yLATY55PLU/2hL9l3HRbry6j3+/JI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mXWjWWzaLy2uMwDS3XzxBCK8yCtCjSEvNkhuQr5k7Gb+AkHc62vT0+DDSA2wvnRiSqBy538sGQdObj6jRmZSXZ2wVF0yy8uWNVcmyS58ijFGvjSTbFIDtgKa8k5rxnF9Eeoeg4Oc0d2DwN3//8XV+uMP9zYt8prBeId5PDvWHlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X3s3cwtA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X3s3cwtA"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fb03c3cf2so2738695f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2026 02:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768817356; x=1769422156; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=19Tlxmtj1wgd7c/Wqw3aq86mSes++ziMKVUPZDLOdm4=;
        b=X3s3cwtACIhSjfwAvyKmeo6Tg7Fc8qDL/3fiHd/cNjbHh7GtI3+L2pA9sjhgAHKm2n
         TZlbdGzQNY6A4TGxjhHnnTKtyI6GhdUyoBZqkj1wYwIp0ozPW9jCiLZ1sFU/xJIzg2Kc
         YNOV5FdmL6/pEx3vIN8bWBTLVKq7MJQF8IfKhCIjH9ggXIp+WkYlvI8eoMH64evqrC6Q
         AYS84BkqSXvEwNdJC6r86gdy8M4KV/IQOZ6sHOXYtx5tzRFojRb29EuPQ+FnzY4BEUpc
         2V2Yz7LfvYjvEI0YjgR/inxFz8sN5qCe6Q42KBcfkr0+3cX6ZshtLCTMq0V+HitTH89M
         6slg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768817356; x=1769422156;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19Tlxmtj1wgd7c/Wqw3aq86mSes++ziMKVUPZDLOdm4=;
        b=Dw3aUgX/FJOmJhJ0RDlpHpeEaxU2IbQ/cs3pqyhNUR2yutEbM2W4d0pRrPSqamz/aD
         qVi+wwBdKT+cTyXtP//LvqPm8t8dOMRoJ/MdLYl0GpuN8FxcEXetCUF74gPrHWnltWNR
         lTvNWCJIxAQNi6bZ4rohLLFAsaV0EXQlWIzDQhZoER0nGgpAUjwHMgY2Qx2bXITvkm2G
         c0AjTr92yTfvyRPJwylyigNV254Ygdp+Tmf15UNVlWBrgMWbJ5n4S1162cdMrqVLuneA
         x9HQU8TyfW4r980UaoosgyUSxvQaUaK6tVntQBj05dNKfUU5hFp/yZPlZlPwALgGWUYE
         dk5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+Zyb7ZHJ3OtQyxEKB0kkWT3uhmsqLSCRDTKIYcSUtsHPDiuq1k5nVSY1/mfIElAqiUXOcrmYqrk2CpeATXtI5@vger.kernel.org
X-Gm-Message-State: AOJu0YyxK2uNOSoAAbtE5RvDP3yM9shjs9/MvyAP90ChhtLErqRgXnVn
	JcnBR5sJauaGeTAHSyhp3wdHFKbqBfguLeFNLIXkp4PcrpXmc+cUlRZgaL6NrA8//UM=
X-Gm-Gg: AZuq6aKRqQoNVpKERndp49oP7oELM5mYEMfznfH/T7sVYQx2yVSg9MzftLcJsiPp0Up
	NDjESR2Mdf9uD8XpPJnbbH0ZG9gI7FsGgx4MDAGqTv+AHqF2HodUoI8NvT3O0BlPlDixcSYOX5Z
	WMpBirM1utF8XV7DfYR3/mdR325gsPGfRjnnlfDTZaZaDwCVVA/Yf0A00BOWbfMkH1jqyfteLOQ
	rJqBlenm/f7S4PmydcRCo6NnvhR6jUcAxTMOr5tM6Plmd3N7eZQ/EsXF/uI9JZEhhzGXybafF7L
	YvPfdvqM3R1DCbgr8pgYcP+LHhfxDspZPHnLCJuubQfH57zSk03KXnWfGlxcLsVb+gWPXualAmb
	NqhOeYE4EbypdOHe1mm7fTL8fPPCAJPJDbiUJhUxLAxdNA8ENkzMgYr77+75Ti0O6RO9Am5sKip
	0LlX1c2xdlZ0ePaxYyhFLX
X-Received: by 2002:a05:6000:25c7:b0:432:dfa8:e1b6 with SMTP id ffacd0b85a97d-4356a053748mr14605338f8f.39.1768817355664;
        Mon, 19 Jan 2026 02:09:15 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e6cdsm23234802f8f.31.2026.01.19.02.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 02:09:15 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/2] (no cover subject)
Date: Mon, 19 Jan 2026 10:08:15 +0000
Message-Id: <20260119-james-perf-coresight-cpu-map-segfault-v1-0-a9cfd67653ae@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI8CbmkC/x3NwQqDMAyA4VeRnBdoC51jrzJ2CF1aM6aWRGUgv
 rvF43f5/x2MVdjg2e2gvInJPDX4WwdpoKkwyqcZggt3533EL41sWFkzplnZpAwLprriSBWNS6b
 1tyCH6ChHor5/QGtV5Sz/6/N6H8cJgYXI4HcAAAA=
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

