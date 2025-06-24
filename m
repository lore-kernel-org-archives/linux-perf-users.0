Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160AD1C84D6
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750791812; cv=none; b=RZYg2QvgAPwhjQwRJ5SAXD1HohTVe6ctVJ95vrRFDOB0G+Q3j+i3x7aebprBcElbIKJ+NkCl+eLAR342BduG/bGGFZ6zE6N0Ipg8vSScsmhTnTZgGeM/9ncipYVRvDj52RuL2MSqItpK5+b6l2wqbRvdzt2sU+5gx9ZxKjTd/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750791812; c=relaxed/simple;
	bh=EW0xPWjuMvCS93oxJalyE9u8qUrwacrh1msaGtQ0pQc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=hEdc7sZ+xtUoSv9JbQ6QwaJ/5TC1QiI7b4FnlYo0Q/3AjjkmRxtaxI6D982TUKe2ZRDfAXxthCXNPbLPEyJ3WqElSjrX33twfppHFoITbKsP0U0+3oNMILcwDwcLONXBp3fhvGkSZXgZe3KTEQnNvjkCtZxGWRP22A1XXYcFJs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=atQ51aGD; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="atQ51aGD"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-23689228a7fso11968585ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 12:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750791810; x=1751396610; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mue4OatHqKQgcnJuH11t4Xo+RNvOkSJfMi17AAIhEug=;
        b=atQ51aGDXSCoDgB3667njA67rCSRnpwqJEmtJ93QSwFs66ycnokTCZL3TTrklp3sa5
         Ad8hgEEQLBvpwNAs7noaiGXFSosTwbQ0IXOgDLTKwzUsj88vKORSzLHgdrS0xecYB+TL
         0/07go64zSZ3AzJFAGQkM8Tm4XBHj9TdT88XtQxe214vf+1yvlW7Bhm50SCWlliAqVQN
         BUAjKCNZ3G7B14ONCKiFiM5gX2zssSqkeS+MSr53GQqnikyPHeMMeKSEIhgd9u+2CWua
         wiVyeZtV8XHvRSHsxOheg/NbFccuea4uxg52rqcSR7VQ188NBVWaoTj5JmWXcDjxrLbB
         nG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750791810; x=1751396610;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mue4OatHqKQgcnJuH11t4Xo+RNvOkSJfMi17AAIhEug=;
        b=Bg75Aiu5KgLO98tRIJVp4prUIfx8h0e37o03DWRYeic0b1qukF5gvGo2e2q+qggaNB
         K38+haOr3JI/+7cGXaIecXQWdLHq/NXCm6VWMmQuCsAhgX1QQ+N5nKAWaNEI2QAwQdeg
         71HWJ0SokkXv2F85Sr8B3q8y52ez4edL8ZoIowbppVHD34bhLQJLL68f/KaEPkT4ctzg
         0bZZ+I6Xm7uDR580Np5Z7RZ4FPyOMfmOwtXjaoGCoobdYrz2FzqbNB5iMPi9T1oScYB8
         dTZLLnG7lCvuhm5VUkGtlqosMFf+/QBrLPKO7C7d44+po723oykjXBpfD9i9lBMYnBoU
         NAJA==
X-Forwarded-Encrypted: i=1; AJvYcCVj94XWZgq+L14rDpehMx0xzVapQP26AjhfDaINeO4MBTIIkG/LGR21LewCc1mUGBt6D0X5pnK2oRqk1s3kys8s@vger.kernel.org
X-Gm-Message-State: AOJu0YwHsvjS8Nlwi+ASI7r9rOjSI0IT6gHXRxTr0UEmejTVQjBtdvwh
	8OcbnDkzMIqJhlHS3qcGo2AcTgwi++ORAKHIihRDtqx0/inWfsYJLc0wdzVQEdPGuFx1iEexE19
	cwuU6zGIwPg==
X-Google-Smtp-Source: AGHT+IHoUFBbRYTquRk0WPMcZ4uILJkDxh4x7sG+l81HGpvgVH/BdM5ulwNwPspJWXq1m+PZtX7Aa2KJGOCn
X-Received: from pgbdp11.prod.google.com ([2002:a05:6a02:f0b:b0:b2f:6641:f70f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94f:b0:235:c9ef:c9e1
 with SMTP id d9443c01a7336-23823f6d39bmr7301675ad.5.1750791810303; Tue, 24
 Jun 2025 12:03:30 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:03:20 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250624190326.2038704-1-irogers@google.com>
Subject: [PATCH v1 0/5] perf test: Sanity check file descriptors are cleaned up
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Some recent patches showed we were leaking file descriptors:
https://lore.kernel.org/lkml/20250617223356.2752099-2-irogers@google.com/

When a test is forked the file descriptors >3 can be closed and then
any file descriptors >3 left after the test are leaks. Add this
checking to the forked test code. Prior to that clean up some file
descriptor usage so we can assert that only file descriptors are
cleaned up. Sometimes the file descriptor being held open is the
result of a memory leak, so fix those.

Ian Rogers (5):
  perf dso: Add missed dso__put to dso__load_kcore
  perf test code-reading: Avoid a leak of cpus and threads
  perf hwmon_pmu: Hold path rather than fd
  perf dso: With ref count checking, avoid dso_data holding dso live
  perf test: In forked mode add check that fds aren't leaked

 tools/perf/tests/builtin-test.c | 69 +++++++++++++++++++++++++++++++++
 tools/perf/tests/code-reading.c |  7 ----
 tools/perf/tests/hwmon_pmu.c    | 11 +++---
 tools/perf/util/dso.c           |  4 ++
 tools/perf/util/hwmon_pmu.c     | 38 +++++++++++++-----
 tools/perf/util/hwmon_pmu.h     |  4 +-
 tools/perf/util/pmus.c          |  2 +-
 tools/perf/util/pmus.h          |  2 +-
 tools/perf/util/symbol.c        |  1 +
 9 files changed, 112 insertions(+), 26 deletions(-)

-- 
2.50.0.714.g196bf9f422-goog

