Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EB932AAB3
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278178; cv=none; b=f3LpiecMPOo2bQbEdfkCliMWNpLAFnjEujs3beWhr7D/O9Y+zPC9G2RUt35OiIhYcJ91Uvo1Ndnngq6zFYLKbV96E1IO7QLjiIAcSFiNe3TCTcxua55JAdo8HrktAwmwUNky6+Tpzdk6T0vKywq8J1d6IYt211o8kmgP+W+0vkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278178; c=relaxed/simple;
	bh=b5k+12ydZydmSEoTx7Hyrz94FdjDLf1ZNQRKPQFf3BI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MCcsdr/fg+zY+5i0r3qwua1CIYtWnhUJ1HVh/OyVL7SklkB7Im5YOrQ5uhgzSidkI3pveb7tVlLDNGs237Pgai6J6XG86zytdK8G9Zw3D9U9ROjkCZ4Cp2DsTqfB0xPQL/NTKMSHAQe21JkItIr6/8jMl7WUOlwtRan1d+o/eXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OguxhP6e; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OguxhP6e"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-139b62317d0so2509357c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782278177; x=1782882977; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wseDAZWczAXZWe3UvxXm/7D9UuQcZSG+ubke9vSHWRA=;
        b=OguxhP6eixTcSLcL+HU00rNO7UFHu8/ZpfSzABKFfpbNnuQ0mrAyfkvr4BNelftiXU
         MXIFb6a58R/M0rZ0L4GqIEVYy1MKec554MXYeMUizmvhjpydekidcPMmE7BHhWZthaaX
         i6ScJke9jcZG9vF2rMsnHx03Wzk6Fg5aTsgH2lAP8qlJQ7TI/xKNTsUV2nJVqNEWQRLj
         B3Lw6lCXZG4+hEehty7BXfxESoi2o8yL/OI4pHiodBuGgT20QgbhuDmMDTHZ4rT2Np2t
         tZ6nut6aY5LG4oMCnlCWmebSrw5mr858y1VECBtPk2TWZNDSTRhtF6igAhKWqwhI9f3Z
         EVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782278177; x=1782882977;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wseDAZWczAXZWe3UvxXm/7D9UuQcZSG+ubke9vSHWRA=;
        b=IoDCpYq6G4QEBZXLq+pTs+nEzEj5HCcy7CwhQSwFG3l4qS8PJg1qoCvzomuPj/arki
         Ur2foKXRp4Eaub/s3oyp4iLt2jzXRuDIpCozHYaZSm/5njyRlABl0oVunVxyG/uxDYT6
         ZR+S0tFBQkVRoLjJrr+z7muMOg3u63BiSt78QE8QthUBoLQClZ0axmmnDe2s7LRCGfgc
         VNh30czlaNm/8H+XlRs0xgWO+C423etNxNhrJT+zvjDur1n4ouuyTO6n4wdYCLOFSQDr
         YTli4G5xDUrIfKCYh116TFeXsbZlqc/KnmrFTlRsTP4ZbnYNFpcAvHXm42vL7y95bQFT
         onJg==
X-Forwarded-Encrypted: i=1; AFNElJ+vSkMSpEyL7AzkDvZ4RVom6L7fzgyYYTbGmRInexMDzkv+25N2lXsUNcm58ieikUCq4hVXiRUXS6Rd0oHX74dA@vger.kernel.org
X-Gm-Message-State: AOJu0YwPcALPRjcSIQzHUlVl7fFWQZwZvGfRMFPGFoygcV7vzapOwwOK
	XPKLhLEPv/mhcsNlOkI6ddkUb+41LZ6yo29aAWkoZ8viSn2zhe6wNF16lsJ0TAT13K4AXoI2E+h
	9arzjCMEt0Q==
X-Received: from dloo19.prod.google.com ([2002:a05:7023:a53:b0:139:c655:b2de])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6296:b0:130:6936:dcde
 with SMTP id a92af1059eb24-139d0c172d6mr1481217c88.14.1782278176287; Tue, 23
 Jun 2026 22:16:16 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:15:33 -0700
In-Reply-To: <20260624051535.3584977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com> <20260624051535.3584977-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624051535.3584977-17-irogers@google.com>
Subject: [PATCH v2 15/16] perf python: Fix memory leak in pyrf__metrics_cb
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

In pyrf__metrics_cb, PyDict_SetItem does not steal the reference of the
key and value, so they need to be decref'ed after successful insertion
to avoid memory leaks.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index e76a407cb2bb..5471037d04c5 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -3567,6 +3567,8 @@ static int pyrf__metrics_cb(const struct pmu_metric *pm,
 		Py_XDECREF(dict);
 		return -ENOMEM;
 	}
+	Py_DECREF(key);
+	Py_DECREF(value);
 
 	if (!add_to_dict(dict, "MetricName", pm->metric_name) ||
 	    !add_to_dict(dict, "PMU", pm->pmu) ||
-- 
2.55.0.rc0.799.gd6f94ed593-goog

