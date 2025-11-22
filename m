Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A214221FBF
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 08:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763799577; cv=none; b=TevjMb1kOkv3ITEe+9OZEx24S/rW3XXh/Q9iNdt1SKmTujGjr0qjGyo094Iwx/5udBo+Wve76m5lOVq4rX9phZx/21RSvOlzev0Icvf6J5b9uCOOSBtpg0nQsQpydvsOtXOu7qRfz1OfznjW3P9egTNfD9gm26ZZKAJPKi+MTcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763799577; c=relaxed/simple;
	bh=HcBOiZAfszGrwpJ6oGMUFTsPwyb1ZvVxScJkvfp4HQs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=cBO8uFD3DkJqO7BEtlwxYbUnl0s3qzzoUeZ5UYLxqzRWEIn9xBWfWFrVkqbK+dWvXEoPAfF7Rb7hZ3ooq6EZHXr1BBbkRgCZav8GzVcgQAEvuYr2NA/02Iuzj2/1OovQr/dmwfQqnx1yIGWO7rHzyadXdxe4qmYnhGzetJEVyKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lvqHihGL; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lvqHihGL"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-340c261fb38so5428403a91.0
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 00:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763799575; x=1764404375; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GM80xqNnqKDmBWRP4MpjKcacHL6rSES/RecPK9JDnao=;
        b=lvqHihGLHkzTZCvnDIhKxR6lcQHLpqAKosfMN75xH7w3V5pIv3h/e5fZACt7l7Sdpi
         CXKUeV9vVJJoVulCA8SUTUG408jNxCux9rbgy8sGvb+rnrJD1b8A+Dy8PuVyBuXxc0TE
         RZoWAxVtzNtL0fzWZL7iDxv/bRNt6DiNSWDXsnm7yFI7NN0MZIj1BWsVG2YK3lA3f5ZZ
         Ae/weiLwLwrPqzosTwHghB9HW7ktrO2wbxOV0vo2jM+3kNWFDgpk36x12xo7C9dKDrC+
         8kT9ndVnstX2GEJ0+/uNqsxPlSlv54pjq9nNdVZ2P7xtr6/WhYZ7yHLHXba3jZXvijw+
         GuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763799575; x=1764404375;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GM80xqNnqKDmBWRP4MpjKcacHL6rSES/RecPK9JDnao=;
        b=H/O5pwcTCatoHBsy/ku+fwLBR2TlN96bKQlCwy4m3FWL87uljwzJUGQ4ko4OadTiyZ
         eZpnMDzTcrE9QG/4k/m04yZX4fiYyv+60P03d0Kf/RaW/cFTclGQTFTz83Bt0zjrkEjo
         sBqKYwiqdZZMl4uzXd54nC+QmtfIbw0h+5I8V3+TTp3gjhDLM5n1E9kJIOj0EoDhGFcj
         SvvdYdFeqI41BYn5IBjTzrXQoCyiR/KtHADlFrye/7PmG+CBsetJkU19iR2goXSbGr8/
         CJj+GU8CdCIpgasM6Sk1XgSqkGJCgKQpEBTiZn6sN3vQfxRXxUQnVBMtHGEdqrUJ7f5c
         uHQA==
X-Forwarded-Encrypted: i=1; AJvYcCWdfdI/Em3h7+yafdB44+Y5dJwzgT26tzaTT/8e8521MNj6hhOwWp9GnoS3i30D7euwTRYsm++kPQRsEazf6dfE@vger.kernel.org
X-Gm-Message-State: AOJu0YyeyFZZ0LdG6TmE1VJHnz3nlhOH/ec5nSa3V/wi0PCY8kl83/eP
	FVjXldmnPDEDNOewDebYF5a5y0ITsdyVFmpKWwtfHCNT34hmLAQlchEcOCCqDVjKG3T764KXUUc
	e7zKXFapFwA==
X-Google-Smtp-Source: AGHT+IGEdfcf1vcuaCJvoYdYJ3BAVMzz3FXV9FLVs9dvggYArZkYTZ9cwp52m0tLcY0WKDDcvBh2FsVu/nE+
X-Received: from dlbcq18.prod.google.com ([2002:a05:7022:2492:b0:119:78ff:fe0f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4424:b0:11b:9386:a3cc
 with SMTP id a92af1059eb24-11c9d872af1mr2180162c88.45.1763799575160; Sat, 22
 Nov 2025 00:19:35 -0800 (PST)
Date: Sat, 22 Nov 2025 00:19:12 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251122081929.7588-1-irogers@google.com>
Subject: [PATCH v1 00/17] perf: Small fixes and new tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Pushing for additional test coverage exposed minor fixes, a missing
timechart option, and a number of reference counting issues. Fix the
issues then add the new tests. The new tests cover c2c, additional
build-id tests, perf top, timechart, kallsyms, perf script with
 --dlfilter, evlist and kvm.

Ian Rogers (17):
  perf kvm: Fix debug assertion
  perf timechart: Add record support for output perf.data path
  perf symbol-elf: Add missing puts on error path
  perf symbol: Add missed dso__put
  perf probe-event: Ensure probe event nsinfo is always cleared
  perf hist: In init, ensure mem_info is put on error paths
  perf mem-events: Don't leak online CPU map
  perf jitdump: Fix missed dso__put
  perf c2c: Clean up some defensive gets and make asan clean
  perf tests c2c: Add a basic c2c
  perf tests buildid: Add purge and remove testing
  perf tests top: Add basic perf top coverage test
  perf tests timechart: Add a perf timechart test
  perf tests kallsyms: Add basic kallsyms test
  perf tests script dlfilter: Add a dlfilter test
  perf tests evlist: Add basic evlist test
  perf test kvm: Add some basic perf kvm test coverage

 tools/perf/builtin-c2c.c                  |  36 ++--
 tools/perf/builtin-kvm.c                  |   2 +-
 tools/perf/builtin-timechart.c            |  15 +-
 tools/perf/tests/shell/buildid.sh         | 203 +++++++++++++++++++---
 tools/perf/tests/shell/c2c.sh             |  62 +++++++
 tools/perf/tests/shell/evlist.sh          |  79 +++++++++
 tools/perf/tests/shell/kallsyms.sh        |  56 ++++++
 tools/perf/tests/shell/kvm.sh             | 154 ++++++++++++++++
 tools/perf/tests/shell/script_dlfilter.sh | 107 ++++++++++++
 tools/perf/tests/shell/timechart.sh       |  67 +++++++
 tools/perf/tests/shell/top.sh             |  74 ++++++++
 tools/perf/util/hist.c                    |   6 +-
 tools/perf/util/jitdump.c                 |   2 +
 tools/perf/util/mem-events.c              |   5 +-
 tools/perf/util/probe-event.c             |  12 +-
 tools/perf/util/symbol-elf.c              |   5 +-
 tools/perf/util/symbol.c                  |   1 +
 17 files changed, 819 insertions(+), 67 deletions(-)
 create mode 100755 tools/perf/tests/shell/c2c.sh
 create mode 100755 tools/perf/tests/shell/evlist.sh
 create mode 100755 tools/perf/tests/shell/kallsyms.sh
 create mode 100755 tools/perf/tests/shell/kvm.sh
 create mode 100755 tools/perf/tests/shell/script_dlfilter.sh
 create mode 100755 tools/perf/tests/shell/timechart.sh
 create mode 100755 tools/perf/tests/shell/top.sh

-- 
2.52.0.rc2.455.g230fcf2819-goog

