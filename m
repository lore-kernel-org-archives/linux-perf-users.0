Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F13D3A9D8D
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786259705; cv=none; b=suJ7Cos+Tgx09KJcIjbPJTjZ7CeXzBeggmCMx+Yq4FKDfpYBMBRu+XjKzETkvntWx0l2P25mgOac34MXk5OuEYJ3kMARgIUpZ5xwznwVaoJEkCEmC0f8ZiXcofjgYkM1lEKDApOK/QqJI2zOMFsQJ0uipuAtRcEUQHLMNvmfyhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786259705; c=relaxed/simple;
	bh=swqe8rCmgyTTC1cul5wJBq0EXi2zou1rcBquvupBwAo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sla1KTFVzKH77czwnHNlqgmmacBaJkmKV+ivom9O3Z6K6nVNy+COYEgWWFtpVYac1hD//m1LgbSmaECMVwEcU9xMsxpRz6+kxQbIf9Lr/mmGp25NeAEavZc8+08B0KxYvTHfMY9BSMfIhcsDhboOUIovey7/5V+imUxpnvs2TgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R7/8LQ1c; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R7/8LQ1c"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84859a64079so1804581b3a.3
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Aug 2026 00:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786259703; x=1786864503; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iuGvE3ZxnM2BRo1Oz8nRCxJni0A7gLi7C7uZxWU3wdE=;
        b=R7/8LQ1c5UH9gXI798vMzhNRpFzlyLv21b7mGIdpug5sknWul7+EvJ7LZXFo8MIO3O
         uI33qKpgh8/HZvYXxUzlwIbNB7PvTEdh95YS+kMdEdS747tYdA5Y79S3zeKze6bApiNQ
         G9wCEftqheRJU7ELVuhzkvlxJWS6RFFm8tQRVYRqP42KNcCuAGpNjPb4e8SFcEvycWBL
         IvcLF7xlvV+JufEd8/FWIBoq2bXqu5XljFt5gBIu0LoPCC66EbMX+TOitXej+cJpq9hb
         ti9WJtsjOoY0Ty7b4avj9IEbDy1STsFoq5xPtFRmKRrDQ3LED4CWXX/jlAaa338g+W3d
         5YMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786259703; x=1786864503;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iuGvE3ZxnM2BRo1Oz8nRCxJni0A7gLi7C7uZxWU3wdE=;
        b=FP+QJLgymvjCak+rmXxNY7iYLbyy3wojLD3Z5nm6haeG/IKp/lycznCTKTMIPM9jB4
         d460FX9oBGC5yWNtp100Gs293r4tneHMdqSpRsolzMN76zUUNAEU1Jt0Y1ipKIJryUxH
         wRHdSBWfXZYNZ/Y3JCJFlkMzBf+aYKafiAdrR+FvShPfBAC/Z81UuuJubpIr1OzKhs+X
         nm63Aik0FOaVy0b/LVpPfHyFTGGExqFpBiHKEj2QlMqLfd98Tl5MM30UrphZWp9xW651
         7UjhHePFCv8bR5OhLlb1dvILjQoCAic5RIHrezM+LOCzkhkUJCeVjLuJwE16mhnBpJAo
         JyEA==
X-Forwarded-Encrypted: i=1; AHgh+RrTWw+siqvkYpxfovIJvs1p+pxjtPGpcFmZkC0xvWlp8hOspnhwSIh/A5ctHXsORDJB1BZT3XmMwFRHEIcNAuhl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/yb38yLoq4rN6TJRUJcX/7zoibGcecU2qdlM8dhR5RWy56VUy
	hmEhioEs1KgNfU8FJ37IlyVw8z/kl9ow3yAZ+v43s0IVmGMj9YVXS9AXRQC5BJToPTIILBVKlv3
	PMssWFXHvyA==
X-Received: from dldoa7.prod.google.com ([2002:a05:701a:ca87:b0:13d:2447:768c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a04:b0:3bf:9aa9:b2a4
 with SMTP id adf61e73a8af0-3cb85ef91f7mr42698122637.20.1786259703153; Sun, 09
 Aug 2026 00:15:03 -0700 (PDT)
Date: Sun,  9 Aug 2026 00:14:39 -0700
In-Reply-To: <20260624051535.3584977-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260624051535.3584977-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260809071455.1221514-1-irogers@google.com>
Subject: [PATCH v3 00/15] perf python: Fix python extension bugs from v19 review
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Phase 1 of splitting the v19 review patches into smaller fixes.
These patches address issues identified in the python extension during
the review of the v19 script porting series, as well as fixing several
pre-existing bugs and leaks.

v3:
- Addressed review feedback from Namhyung Kim and Sashiko AI:
  - Dropped "perf data: Fix directory file descriptor leak in perf_data__switch"
    to avoid Use-After-Free during directory mode file rotation.
  - Added list == NULL check in pyrf_counts_values_set_values to safely
    handle attribute deletion (del obj.values).
  - Preserved errno before calling intlist__delete(skiplist) in cmd_test
    error path to prevent clobbering the return error code.
  - Added CHECK_INITIALIZED to pyrf_pmu__repr to prevent NULL pointer
    dereferences on uninitialized PMU objects.
  - Fixed duplicate patch title from v2.

v2:
- Addressed sashiko review feedback:
  - Fixed 64-bit casting for counts_values by using T_ULONGLONG and PyLong_FromUnsignedLongLong.
  - Replaced strict Py_TYPE checks with PyObject_TypeCheck for thread/cpu maps.
  - Fixed a missing CHECK_INITIALIZED for pyrf_thread__get_cpu, pyrf_pmu__name, pyrf_pmu__events.
  - Included <string.h> where memset was used.
- Fixed line splitting formatting on PyObject_New in pyrf_evsel__read.
- Added fixes for memory leaks and issues discovered during review:
  - Fix memory leak of key and value in pyrf__metrics_cb
  - Fix count_values memory leak in pyrf_evsel__read
  - Fix sb_evlist leaks in both top and record paths.
  - Fix potential divide by zero in perf_event__synthesize_threads

v1:
- Decomposed the single large "Fix python extension bugs" patch into 13 individual fixes.
- Added Fixes: tags for issues that date back to earlier commits.
- Addressed checkpatch warnings (line lengths, Signed-off-by, etc).

Ian Rogers (15):
  perf script: Fix metric_evlist leak in script_find_metrics
  perf stat: Fix evsel_list leak in cmd_stat
  perf tools: Fix sb_evlist leaks in top and record
  perf python: Fix memory leak in pyrf_evlist__get_pollfd
  perf synthetic-events: Fix uninitialized pthread_join
  perf test: Fix skiplist leak in cmd_test
  perf python: Check counts_values size in set_values
  perf python: Validate CPU and thread maps in pyrf_evsel__open
  perf python: Validate attribute setters in pyrf_evsel
  perf python: Zero initialize perf_data in pyrf_data__init
  perf python: Add thread and PMU uninitialized checks
  perf python: Fix MetricGroup return type in perf.pyi
  perf python: Fix count_values memory leak in pyrf_evsel__read
  perf python: Fix memory leak in pyrf__metrics_cb
  perf synthetic-events: Fix divide by zero in
    perf_event__synthesize_threads

 tools/perf/builtin-record.c        |   2 +
 tools/perf/builtin-script.c        |   2 +-
 tools/perf/builtin-stat.c          |   9 +-
 tools/perf/builtin-top.c           |   2 +
 tools/perf/python/perf.pyi         |   4 +-
 tools/perf/tests/builtin-test.c    |   9 +-
 tools/perf/util/python.c           | 166 ++++++++++++++++++++++++-----
 tools/perf/util/synthetic-events.c |   6 +-
 8 files changed, 161 insertions(+), 39 deletions(-)

-- 
2.55.0.679.g6767b8d81c-goog

