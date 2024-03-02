Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9570AD49
	for <linux-perf-users@vger.kernel.org>; Sat,  2 Mar 2024 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341200; cv=none; b=Jd9Ecc8H35ibKz864JCTmXiW+1ocAGn1HoXGI/PpUNe/at1d/9VmqpQUdI4IC6SMQFzkiG6rl0VFe2xO52VfTl0iosPnYQbBc9e4YZeGkiqhgKNrdczTW2RuIJcF6RC4a1JYu3cY8eimljx6lfLeXu6A694lEJwbUPcgX+N4HwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341200; c=relaxed/simple;
	bh=dM3Ag5y8je1vuduwF1EimvGz+cnswEd1t+PuSA61ShM=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=d00BGf1M2C8t09xS1mk7faghS2jYnbPrucGvTnfuL7hu3qukx0LNEdh1kuCDlnO8AxX02b0K/prfodN2z97ATg0dy2na4qXO8zOR7hy4Xk5FAu4KOfTfHB7RwONqYaoUNod/9SYmzgZpvgnRR1C+ZZOARG6OdSwfu8b4WIrZpF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R+CAmh6g; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R+CAmh6g"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso4708291276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 16:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709341198; x=1709945998; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j4G9FOR5nbZkYqaq4dewtp5LXznD7NrLAFoLOjYCkLY=;
        b=R+CAmh6gesYrwXCwzWNrE5VjqM5ToKzSdf+RtjVrR5OQoRSjrHWSVSGHAZp1O0hio4
         CdCD8p9VnA0l61q4MfX+eKB1iIewxHkW7/tazK5wwHGbvqHdUpVxXixJdY6epuXP3QGy
         47E2oEW98bOG9ZIQz3MV+D8AJ/HbdI9j30hNykvD0o7AdXMeybFVLY2sGxhs8LTDHhxY
         NTOrY4430b+gbdixLBrUqRaBDGHdonvPIeUIW3QmM1+maQ99NahIOCzgo1FljdAWrlTm
         +UOXU7oF5YLuQHxc4LdV0i1AG0WHt7tHbk8zai6OT8onSwbFiNGWqoLvxwubjzYLG/YF
         /Nzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341198; x=1709945998;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j4G9FOR5nbZkYqaq4dewtp5LXznD7NrLAFoLOjYCkLY=;
        b=WLs0prERsHTbs2FwdORnoXPp1F8HtqIkw48Ba3dSYqO6o9r96YVYZwdFC9fPedbXQk
         XQyNyOUYLpNhmDx9UHDKQU8A0YJbpKUsWFLbZuM5HgeaXW8oksBOmDf5lMVmAn2/IKzO
         7zUr03tQgkOsfFZNefVyABnmoSt6nnVlgoXLHARM7aobXMXKxBuuJtj2p9PWk/w7MP1o
         Ifvuv9X+8osLwfw90IUPo0gWdEhdWfhp2lsTtMPxhCNTRqVVhSTsdhZLrcT8zAUqKSyI
         gCGL5xSX7w8FxlxVMzWalO4MGgs2jPWh1VUvqTRDCR6Z5GnDe43w59JWONO2f+e3jcRd
         02aw==
X-Forwarded-Encrypted: i=1; AJvYcCVRa7OMQVepVMXUjbHXlEXXxl9GctaeOMc0cvpDEhCvy4v2dhQwyZ5nr8k6EnJ90lzj8oUkgYwLE7qm+kaCAhjYv7fMAw3bivIwiylEyDCU1w==
X-Gm-Message-State: AOJu0YwnfjPoQnHVmELj0KxLSyySU9S3sy++YZjU8EjJHptzZbZsX9LH
	CY2ndPzdlgsUsgAdthuaHIdSonpspDQRilObS3uChgDV9P+wNuY+7ZYffjTxKMK7ST5M8xrWXFU
	s33vywQ==
X-Google-Smtp-Source: AGHT+IFGtI8mI+6WnpJiE0oUqp0/9/mqYd9m4o9lxj10uVFie/ybfRNZD7jc4ad0HnjcIsE3sXC85e/rUjyV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aba7:66c5:3365:7114])
 (user=irogers job=sendgmr) by 2002:a05:6902:72c:b0:dbe:a0c2:df25 with SMTP id
 l12-20020a056902072c00b00dbea0c2df25mr113432ybt.8.1709341197908; Fri, 01 Mar
 2024 16:59:57 -0800 (PST)
Date: Fri,  1 Mar 2024 16:59:38 -0800
Message-Id: <20240302005950.2847058-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 00/12] Foundations for metric generation with Python
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Metrics in the perf tool come in via json. Json doesn't allow
comments, line breaks, etc. making it an inconvenient way to write
metrics. Further, it is useful to detect when writing a metric that
the event specified is supported within the event json for a model.

These patches introduce infrastructure and fixes for the addition of
metrics written in python for Arm64, AMD Zen and Intel CPUs. Later
patches will introduce the metrics split apart by the vendor.

v2. Fixes two type issues in the python code but no functional or
    output changes.

Ian Rogers (12):
  perf jevents: Allow multiple metricgroups.json files
  perf jevents: Update metric constraint support
  perf jevents: Add descriptions to metricgroup abstraction
  perf jevents: Allow metric groups not to be named
  perf jevents: Support parsing negative exponents
  perf jevents: Term list fix in event parsing
  perf jevents: Add threshold expressions to Metric
  perf jevents: Move json encoding to its own functions
  perf jevents: Drop duplicate pending metrics
  perf jevents: Skip optional metrics in metric group list
  perf jevents: Build support for generating metrics from python
  perf jevents: Add load event json to verify and allow fallbacks

 tools/perf/.gitignore                  |   2 +
 tools/perf/Makefile.perf               |  17 ++-
 tools/perf/pmu-events/Build            |  60 ++++++++-
 tools/perf/pmu-events/amd_metrics.py   |  22 ++++
 tools/perf/pmu-events/arm64_metrics.py |  23 ++++
 tools/perf/pmu-events/intel_metrics.py |  22 ++++
 tools/perf/pmu-events/jevents.py       |   6 +-
 tools/perf/pmu-events/metric.py        | 162 +++++++++++++++++++++----
 tools/perf/pmu-events/metric_test.py   |   4 +
 9 files changed, 282 insertions(+), 36 deletions(-)
 create mode 100755 tools/perf/pmu-events/amd_metrics.py
 create mode 100755 tools/perf/pmu-events/arm64_metrics.py
 create mode 100755 tools/perf/pmu-events/intel_metrics.py

-- 
2.44.0.278.ge034bb2e1d-goog

