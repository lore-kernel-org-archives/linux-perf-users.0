Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EDF2D249E
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Aug 2025 22:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814722; cv=none; b=sWlhaNkOkS6II6oESnuGS14PpzYhJRaGBHwvu/67Ubz4EsNBMnmnCcZMqsbmwyEKfdLCKr/LILn6t7OnKR2qS3CUbEcbby94Rq3apmxylKIlExkBw49kYVBbWSezfXpnQKtKtT3nNwOY7glu3P0hW5XLpIKtp2yAFy68rr/2M6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814722; c=relaxed/simple;
	bh=K0symyrZuyZvqS1XBD24qplV3mvlV//oYKSTemn9QkM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=rIo3AN/OPVhjGpnOt3PDJKgKx481SdqK8lBRWlvNX77nAqlzuJDPJ8RHlLCFWa9AWPZY5i0bPnfTDCwmxgY9H1Q1F+3O5nl3CJKX0Nz+5/VQij8NvYLRIcv+BPyGVUiK6Jg8dU8WHqgl4qJe/pyJ03e03XE1Ti2+GKlrOG2Bh48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O3dvl0s2; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O3dvl0s2"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2e60221fso3112849b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Aug 2025 15:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755814720; x=1756419520; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cFBRMtm2qDJHWakDl01mNCIUuG7fMg/wQlZbnAFILFc=;
        b=O3dvl0s2TsCFOGpgvcY1+V4HO1GocxiboYbPlB5QFHOkHFamD45dIytRbAk858O++4
         34a+P7VNbPRLm3zB7K9bL7oH8agNzbBzgcYAr4p+NST0bE4WyULomqLa8FDqirbG8/Jj
         aSNFjSmURtaoBBwbaleWu/mNsG9PQUwLe/Kn0HD9LRB3F1GZ4n9BjD5Ue0/8ibsFQVGl
         q9FbBDbXyOKSjora1TpVpx5/A+q0Bd5L2dy9JwiE1ZlZGhJCN8qCx9AK5ipUnnpK6zYd
         uIvpIHzQE+1MRlfxgJ6RcbkguV+C87+O5ftCDzN/8iV+WnPNfbtnEYYchS1JPzcdcx5C
         a4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755814720; x=1756419520;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cFBRMtm2qDJHWakDl01mNCIUuG7fMg/wQlZbnAFILFc=;
        b=sYQdgfCQaa/GZOYpFS48D3JjwLyqt/1HjFO2KpIUXrWHMk8/SlvzU8Ua3QvaphE79P
         qChxkSY8MDoVdsvVMqT4Nc77COwZ03RQwI6DTUWCkJpst45ksGAaRPp4p3HhKx4Us5+h
         1o7Vh+RU2ITTw2ag0OOTeMnvPEjfJYbweWkJ81NHeFYzooR5KOjGvc8BMvO0KbiWFIhW
         525Os97RCAADUdSOt5Av3+JNaIxDqCuPEsA3X1ks/urgRUTL3NR0HST987N7PJWJPX9f
         52RotuuASR0OwQTfDzsVCK+kTjXJEG4suB2HWwAqq0bcdO8rRjUl9SpADj3QIs/OzOy0
         nWVw==
X-Forwarded-Encrypted: i=1; AJvYcCV/aZP3Wlq+pCO73wrq1Oe6HWwfM7cqZNhSW/hH6CM18wSq2OVJ0AGi8wed0m+hik2LWWN0FXv8fKDy8FuXVK5M@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6mNHJQJAcoL3nyOT0ZZlnTbIV5FRSiteZfqh7ptOtTERIK9Vw
	0Lzq1J66CaVQ9g9DPvkmreU/CDwCIl2jzQ4v8aVJiVWyMm5nCFvbCkFtbj9CCi1jKCicyMIqlHB
	Jyn41mcHQ9A==
X-Google-Smtp-Source: AGHT+IEYCOqIVvEgBg5sE0uG0GD/Uwi7bsNao2K16RSgQpglbB8njv7CwRYmCbYulD290cjdmEXQUl3QhEqK
X-Received: from pfbbu4.prod.google.com ([2002:a05:6a00:4104:b0:76e:7b1b:137d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1ca8:b0:76b:dedb:3048
 with SMTP id d2e1a72fcca58-7702fa0a9e3mr1182787b3a.14.1755814720446; Thu, 21
 Aug 2025 15:18:40 -0700 (PDT)
Date: Thu, 21 Aug 2025 15:18:30 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821221834.1312002-1-irogers@google.com>
Subject: [PATCH v1 0/4] Test/uniquification related fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Failures discovered running as non-root and with v6.17-rc1 changes.

Ian Rogers (4):
  perf test shell lbr: Avoid failures with perf event paranoia
  perf test: Don't leak workload gopipe in PERF_RECORD_*
  perf evsel: Fix uniquification when PMU given without suffix
  perf test: Avoid uncore_imc/clockticks in uniquification test

 tools/perf/tests/perf-record.c                |   4 +
 tools/perf/tests/shell/record_lbr.sh          |  26 ++++-
 .../tests/shell/stat+event_uniquifying.sh     | 105 ++++++++----------
 tools/perf/util/evsel.c                       |  28 +++--
 4 files changed, 86 insertions(+), 77 deletions(-)

-- 
2.51.0.rc2.233.g662b1ed5c5-goog

