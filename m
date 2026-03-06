Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19517364EA3
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Mar 2026 11:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772796299; cv=none; b=eZPQtds5EHQE1f4ZNfmwkSzZFw8VbJNCa/TihPlYCUqaN4QoNC+IpG31HeN6XHkYDec0jUGLyHPBq3f3eUx34q1shHmTfgnWXAEYNpni5tjgHUD049J2w/UuJn8JQuSdeiA/wX1XgKqICV8LevP1DoT0QVwDa0jhfwUHxnZOsrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772796299; c=relaxed/simple;
	bh=ww3OxzPKV8PLXfmC3qf4lRlsqiJhH+sh0stYwFTnUVY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PR2331f7VVE6YJjic7pNH4NB8ck+W1DbGJOs8AamfkbjuST/vcFLbcLEMJY8nKkUwbZpG5bTeFpMlHHLI4Rk1tPglnVsp4WUL0xgalqzAY0iqN9zIHZ1/+kYSIh2pKciQLKQs/qqsNp2eE3+SG/sYwIGTrYDQthZur+xGprFYiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mivbp86t; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mivbp86t"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso80263605e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Mar 2026 03:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772796296; x=1773401096; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ABkanZA7mSS4Cmp/AVVTuo11SCyLRUQ6Ylv2Kzgw2mU=;
        b=mivbp86twqKnIs9gPT/RgRu5Yog15CthcPNxQsba9IrnpCUdzoLRJFriQTmMpnjYzl
         PxyP355R/ZAwWWnI5qjvQD88L6aTy1+FVa7DGUbrG1l9RmCMQDNses/AmN44cg6kEnrX
         sTfanAiiEoG8Csq4SIOOQ0+qxuOo6ht8KHF/qubFIHXtiBp39peunL0jH26+vatGZeIw
         hanIKB++CvojoP5ZnwrzF0AXN+PmuYwszimpl1xGf2uDW/f7kguEmfhxZ6ZKKwhAgyot
         hsWIduo5hmgrdvEhr8flKyy41jDPYEoy3sZLIf8kgbCK04UT/Yu8v8nyi9SEsu+pnl45
         FnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772796296; x=1773401096;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABkanZA7mSS4Cmp/AVVTuo11SCyLRUQ6Ylv2Kzgw2mU=;
        b=Ug4VFXWq27wf84rxsbPj9VdfvJJsxjIYTO/T65FDjaerZxXQZhsvE7VmOGqULsPUHR
         S+DuA3jj66A3kNErtq9UsgNi4B7PExh4TfvbJeOYEHcKwhkS+RW3RGp3x6gs3PM7/nMn
         4tKjvH5H1s1ouxaKVzB4ODHrEGMA5AbBf4RggCa1/xIcdSuNyICZDzEyO0tJFop271i4
         lwokUGmVVDu5W1ZHWFCU59Op+N1awFndtIDx5iIFT9jqTV98LnPuvk5RPUP7XhMN/13K
         A79DoVR9d+NIiM3+4QmkaEpP0T0EtI3980WdGai/hIpZbKvXjak6+zOvbgfXuxV2HXuh
         okQg==
X-Forwarded-Encrypted: i=1; AJvYcCU+2Ja9jOoWma7o1Pcs7kCzNDOzR3CUlOavc7NJTIA9MVLr9Ux1WlwdooXcSgJKWrM+BARmzeiV8C2eWwZ6ue6t@vger.kernel.org
X-Gm-Message-State: AOJu0YzsxuAOvW6PMb1kOJQzGShTPNFcNA0X4UCBFzwcWhRYgZZgjiuO
	HUOL1clLX5b312B76fRyU6NDxs49tmsH2Jm2jpTazSkZLWZSAwf+tnXU4crKo4ioL7A=
X-Gm-Gg: ATEYQzxm+JGm5VIEFYutrUHCJAAf0HFNPj2pTDGeX1x7HW3Ilgv2vAqBjIAL2sgX36m
	muOQ4WW6NDnjvAed6w6nPD7wQU+/Yn87m2XfOiQhWETaFYiGq5WKBPXGYUK6+hoD/7dnwj1rK1u
	F8eGkDw5ZmrDW5f3z922bFxyg2xf9+yWHCD4aL7iWBCZTrOt0UYvA5ki93ICxy/C1gjlFayXohO
	MNPV1yZ4Khl2tJzJ/nvuMF0LB9f3Dota4KAU9oVgw0ErMy22fNJhhcg0zsW82t0Bk3NjjdATSHV
	vy7JEVmEP/VEdJr0YicsT6hLvdc1o4vzAj92qqq5ozWs5aE6iX5+2rtTFOxa8rU3df07a8c8IPx
	UiK/R5JFpMFuB1VI0lTZ4vvsBSJ5fwf4HwUlWyaLBVcNQp9b1lCV/Btih07IzSFEAwZvDzUDg3Y
	exeoH/UmEEGeZlMOLXxvAzVlIcv9Hcomvw
X-Received: by 2002:a05:600c:1d1e:b0:483:709e:f239 with SMTP id 5b1f17b1804b1-48526951ca9mr27092225e9.22.1772796296413;
        Fri, 06 Mar 2026 03:24:56 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48527681a3esm66542245e9.4.2026.03.06.03.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 03:24:56 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/2] perf cs-etm: Finish removal of ETM_OPT_*
Date: Fri, 06 Mar 2026 11:24:44 +0000
Message-Id: <20260306-james-perf-remove-etm_opt-v1-0-03c662380361@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHy5qmkC/x3MQQqDMBBG4avIrDsQLaS2V5EiIf7WEWLCJEhBv
 LvB5bd476AMFWT6NAcpdskSt4r20ZBf3PYDy1RNnemseRrLqwvInKAzK0LcwShhjKmwN3i7l+0
 nj55qnxSz/O/38D3PC7VAasFrAAAA
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Finish removal of ETM_OPT_* defines so the coresight-pmu.h header can
by synced from the kernel.

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (2):
      perf cs-etm: Finish removal of ETM_OPT_*
      tools: Sync coresight-pmu.h header

 tools/include/linux/coresight-pmu.h             | 24 -----------------
 tools/perf/arch/arm/util/cs-etm.c               | 14 ----------
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  2 +-
 tools/perf/util/cs-etm.c                        | 36 +++++++++----------------
 tools/perf/util/cs-etm.h                        | 15 +++++++++++
 5 files changed, 28 insertions(+), 63 deletions(-)
---
base-commit: b1718b0367ba31e8db273e3896ebd1707bcbe59e
change-id: 20260306-james-perf-remove-etm_opt-c0e9a768dce8

Best regards,
-- 
James Clark <james.clark@linaro.org>

