Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com [209.85.161.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434493793BE
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Apr 2026 22:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775772887; cv=none; b=Jj5aaIUQYgAV3ooYt1ciEtd//mLhCkxy8uErW+EGo/YwbZMQ9xYGloXySOuLREOJFnuxSoMzg6nzx6DdJMcQ4KyEhU/vdTbVYT1bpra86BWUHKJUUwAMRMwBdN3wMBOQVV3eKDNghnZH4VPQm9vrXPAB7uzoZF9uTWvmo2SOb78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775772887; c=relaxed/simple;
	bh=LH71OM2mecZma8HEHsw5YLwqs4IX+ieliIcYvVpyBMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nagNy3rsfyaJS9+hUI0voDtkLkfWmpgf6CVvulyyJlSg07QrjcWn7GnQbkc1HKnxavHQ8OMluBHiCdjdlq0bPKeUCluIVabwrDeIJ7qPmmcK/RUMuITkkbu1HH+INmbqIwxm9zrSLGkQpuvDL3Zrf/0P40icTwy3a3QtZ1G3mvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gyBrg/ML; arc=none smtp.client-ip=209.85.161.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gyBrg/ML"
Received: by mail-oo1-f98.google.com with SMTP id 006d021491bc7-679f6ee3fb0so562157eaf.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Apr 2026 15:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775772885; x=1776377685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HOqEOVa/VITh1xF/avB48BwSmGbagcoSGHiOUBS/gqU=;
        b=jgBQzZFTNt3UTg+H3tuCixFiNNZPNplgPq5pzkd4pfweFRg1Idq80X77BScinld3S9
         FrBGmRqJkfHQMnHlWcyTv8CEKNPPtvOIIWR6D/2X5thZMjdauXxO8+RKfk5s617uMDgF
         Zaqk9c0GB4fBf8UgBf6tQqWLB6msQEoPLqzbAH8gOq4KzLxtFZ7ywd/y3Ic1fVvZ7Ypz
         /MpJkNLj4yXVtj1/22pRx5zvjY9kDk6usZaI9JedBpg67laEX9mpZc+S0PzTdwQyjFe6
         x+2kB6Q6IaPuIlg5OdbTcL5oOe3UIWRJGb6r2ksX9fxrofW40LZY9zZO+EJw0kP5AEV/
         Uxqw==
X-Forwarded-Encrypted: i=1; AJvYcCUD+eaQaWJvGWjSXcnZy3Xab4zHcHNM7CAxztHRRxaJlmfp9V1pkMiBkmK8fT/oD9xo1GwfP/zFQE8uN4PJhlTP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6NvWPFhRHtiZ2KJFCHI4QNkpMKZoT2OEFYBSlrucC825hYUGi
	RkC9uFfpIZ1R3jAPjELqedHBtd9p//MotKJrA/CKa2bbzlgabRxl6cwmUHWFGiyAGtnUkSutA1R
	SJjVFDcey4bamFz8sSehG+JcNRoZBdX1wR/eVFQX0dGZATMQqlTcnixlCGwL5jGC7qBChp8pmzh
	1949MuFnn7eiEf1FuZ5mnblju6oDI8Z8rtHH8bRqTWF6In1OhmY2lQDeYGSDeR9Xl28/0u/rpER
	Gxcx3zv2BhiFl0Dj9j1krMNc40=
X-Gm-Gg: AeBDiev1ZqUfo2L1zymXtIoOfEWq0kqzNTA6Mjh3RQoCf2LQ3UXE3bDGCTp8UP4ZYVu
	5JMdndjQR4qSWn7zBU/+pt+aCOhehNvaTY1aI12cRv8ztXLNMJeoLVIb4udyrHr+1quWPJxrJQx
	KZEfFoVqRoHSLc/F4iuiEawBbUGvqm57+xlLyQRCU9H0nSBjpxosqeCYTkPIaVZJz2Qcp0pC9pC
	JlmPXocGQVwdvvAD/hT9YuI4dRWIdDxOmEmg+ov844v40JSg9W390xxLGwbKbjnFuwFenSfzPbF
	VhtX6PsHJAcwbGYByKq/fzk7+wekG1ACqTRcNT6CBOgle5gTypGdGDoYa1BwIIpFFFAWum3NTXS
	z+IkYrPd0j/8eVWb/I4VzIUvlV+eH3Ur0wI3GolgNLAPuhtox6evhNODsJr0HpGZ4KWn7Bi8Ye7
	VtmKwgtRx81QVhNe/eFKuRKC3GPYaHooPzf0Gh3JJl+oU5sNIy2wUS6SXB
X-Received: by 2002:a05:6820:4b15:b0:684:743e:86a6 with SMTP id 006d021491bc7-68be64302c4mr504397eaf.20.1775772885207;
        Thu, 09 Apr 2026 15:14:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-15.dlp.protect.broadcom.com. [144.49.247.15])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-423dda061f5sm126463fac.10.2026.04.09.15.14.44
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2026 15:14:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8abd6e281c0so27883336d6.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Apr 2026 15:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775772884; x=1776377684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOqEOVa/VITh1xF/avB48BwSmGbagcoSGHiOUBS/gqU=;
        b=gyBrg/MLlmZ0IZND+ZR8KlftCSsopN8HqUmWY8yE2VMN7BAbWZkd2V8p8ihITV0Jek
         +xZpEKscGYFBIQUap8VPQEWel4S9ewCzUhhDBqA5qsXEyqViZPXcs7uz9ybMq1dLUa68
         pGPk5jQl3GhQcdxJ72o4FyHaK0DhXVS5JlL2w=
X-Forwarded-Encrypted: i=1; AJvYcCWYabZtTdgu8NodEOD5zYmU8Ke8a/JbXZR9mQUyFjCG9q4p3ko/wV1y8LewgJe4H2F9N4H5Psuq2uelTDoVhWVT@vger.kernel.org
X-Received: by 2002:ad4:5749:0:b0:8a5:fb34:c9fd with SMTP id 6a1803df08f44-8ac8628aa69mr10315486d6.25.1775772884164;
        Thu, 09 Apr 2026 15:14:44 -0700 (PDT)
X-Received: by 2002:ad4:5749:0:b0:8a5:fb34:c9fd with SMTP id 6a1803df08f44-8ac8628aa69mr10314836d6.25.1775772883540;
        Thu, 09 Apr 2026 15:14:43 -0700 (PDT)
Received: from lbrmn-mmayer.ric.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a4355esm7228076d6.19.2026.04.09.15.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 15:14:42 -0700 (PDT)
Received: by lbrmn-mmayer.ric.broadcom.net (Postfix, from userid 1000)
	id 7E946D8A; Thu,  9 Apr 2026 15:14:41 -0700 (PDT)
From: Markus Mayer <mmayer@broadcom.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Cc: Markus Mayer <mmayer@broadcom.com>,
	Perf Mailing List <linux-perf-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf build: fix "argument list too long" in second location
Date: Thu,  9 Apr 2026 15:14:17 -0700
Message-ID: <20260409221418.185343-2-mmayer@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409221418.185343-1-mmayer@broadcom.com>
References: <20260409221418.185343-1-mmayer@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Turns out that displaying "RM $^" via quiet_cmd_rm can also upset the
shell and cause it to display "argument list too long".

Trying to quote $^ doesn't help.

In the end, *not* displaying the (potentially long) list of files is
probably the right thing to do for a "quiet" message, anyway. Instead,
let's display a count of how many files were removed. There is always
V=1 if more detail is required.

  TEST    linux/tools/perf/pmu-events/metric_test.log
  RM      ...634 orphan file(s)...
  LD      linux/tools/perf/util/perf-util-in.o

Also move the comment regarding xargs before the rule, so it doesn't
show up in the build output.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 tools/perf/pmu-events/Build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index dc5f94862a3b..dc1df2d57ddc 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -211,10 +211,10 @@ ifneq ($(strip $(ORPHAN_FILES)),)
 
 # Message for $(call echo-cmd,rm). Generally cleaning files isn't part
 # of a build step.
-quiet_cmd_rm  = RM      $^
+quiet_cmd_rm = RM      ...$(words $^) orphan file(s)...
 
+# The list of files can be long. Use xargs to prevent issues.
 prune_orphans: $(ORPHAN_FILES)
-	# The list of files can be long. Use xargs to prevent issues.
 	$(Q)$(call echo-cmd,rm)echo "$^" | xargs rm -f
 
 JEVENTS_DEPS += prune_orphans
-- 
2.53.0

