Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC115478D
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782278143; cv=none; b=olKPS+PRbId1jSkKaVzPokCh98kexzpaC2vkjCzShayLEdwFSLIIn4O0h/72FrVBAT06iG+ZIJeFNayLG50eGp3+dRS6e4whULeWB0SW9jNQLd7iIH6jWSOKMPYsCcUBq9lTQjfnZbyPTscmxrAeg5lpHTDMC+qkHwBXWQRZ4lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782278143; c=relaxed/simple;
	bh=f6aRFBSMrUrutxUiu7Qxb6D2ih9vf7jdTX0KENMCEXY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b45q0oZd0zr6cDZAJgh2cGAtCF71uqwxFYWkWJu1yh5T+4uPX+SVA8orkPL93Td6S5TX1grq4SmAK2i5YrHTwnYlkx8UCOFluwrI3kXX+qy4vVJfHxb4K6OBdsOEtAXRhW6UBwJ5rmYrOpjcm7jFc1Du9bsBAvmi5Z0To7tLvYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W70oJ0rj; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W70oJ0rj"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1383723dfddso1389630c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 22:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782278140; x=1782882940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oCx16PzRbxbeQQ/K4lYA9nE8cZ81dunqw+SrPqeUg6c=;
        b=W70oJ0rjUKvQwDJE24hPJf3+D6uXz9v03ox4lnsWHVFGEafjUrh3BaAj+QqDXv63nJ
         sMcr0JvdZ0XrbVTM6CFaf4RstR7B/5CrgPPXBEnTK3JJ6meY0xgmyC6jNi4ewA0QYrlk
         4dcTK+Bs3uCZmeP62wWZaSAUN1DQJDlgtT0MEVSEFb8YVPcGHD3Z0VVJ//uhnxp3gdGA
         zhX1jXANxr0zdCgZuHt1trExVe3WW2t/KFOor+/ouOIWhdzPlORzs1QMdC3+ZRYVVXCv
         TNY6K/A4wF451DOE+qmBRo+rKEUdwTwAjx9TCNGYtTcGKDtu8k6BzX68hXskToWnUWgm
         aCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782278140; x=1782882940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oCx16PzRbxbeQQ/K4lYA9nE8cZ81dunqw+SrPqeUg6c=;
        b=WSbcVRWdpNf1P8RjIxrJVFJrwy/JpWJOtZ4IgkabUOlojVwzthJeOh4EbwHfA2Rgkb
         I/8f48O8FTjZ42nPi2HIa4yowEkQgOeEMfOOngn+clRjvhauzEhP8d4AR2QSYHcKYlxV
         BMx3hdAP7ZnshlglbFH5FRK/Smr2FbfyfZ+Tz0ig47s5AQMQjZhzknoARfosqm9of/Tr
         FIpvU5i+TfNBi3nKtbgm/sqa2lAPJ/gLQQknEalxRLLNtjupMzmwhSmNHzUdQvrURJ2B
         nrFlz1XH/M/lUitkHs+DjBbgNf2S1FDyc8nWgcptVjOGYN10k6iamzA6AsjuTKX0IGt+
         KHYg==
X-Forwarded-Encrypted: i=1; AFNElJ/YqBT5EdVaLKaI08eaOzY8Ccw3bXlg90u9800UJjMqOyzzIkF3ar2s9SeigaJE12inGA116h0hCa7Xff1b3Zqo@vger.kernel.org
X-Gm-Message-State: AOJu0YxFyaFKLcR9bOMHDWrhY3wHyrSk+GBYenHIGGJJbattvXschfsv
	6fASa6rOOTOtvQDfBAO517jKb54oP5HEEYKYSeTyu/9Z625PcaaxrDeja5DcCXbL52ZxoHHzwCn
	pgMXcXNHdvQ==
X-Received: from dlep12.prod.google.com ([2002:a05:701b:458c:b0:139:b637:8de6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:622:b0:136:5c88:d917
 with SMTP id a92af1059eb24-139d0c0a8e2mr1462064c88.2.1782278139951; Tue, 23
 Jun 2026 22:15:39 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:15:17 -0700
In-Reply-To: <20260623053515.2677888-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260624051535.3584977-1-irogers@google.com>
Subject: [PATCH v2 00/16] perf python: Fix python extension bugs from v19 review
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


Ian Rogers (16):
  perf script: Fix metric_evlist leak in script_find_metrics
  perf stat: Fix evsel_list leak in cmd_stat
  perf tools: Fix sb_evlist leaks in top and record
  perf python: Fix memory leak in pyrf_evlist__get_pollfd
  perf synthetic-events: Fix uninitialized pthread_join
  perf data: Fix directory file descriptor leak in perf_data__switch
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
 tools/perf/tests/builtin-test.c    |   5 +-
 tools/perf/util/data.c             |   3 +-
 tools/perf/util/python.c           | 160 ++++++++++++++++++++++++-----
 tools/perf/util/synthetic-events.c |   6 +-
 9 files changed, 153 insertions(+), 40 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog

