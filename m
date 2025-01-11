Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1461B85F8
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 20:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736627337; cv=none; b=Fa2O9b8ymfWdbUNKVyVb8Da6NEqYZ8/ODJd0Hii1VCF4LWl1enielJabGDncCCwW1spoZ8LFshHO54iABUZkLV3ylS6v8X/3qC3vpNAV4c3ng8JepF12kncSKdiYqmHxDld/z+X6TMJPTsbcBD4SkPh/jjo4LICRXTmmq8vRPXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736627337; c=relaxed/simple;
	bh=DsOdeCeb0rw/bP+NcrZWlhKmoLtwqT32GOYhX8Gu+S0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=eSaMHjdClB7zlxl3isEPi7M9/qD4A8sbVn9Y99OwlbRZgskjI+rqVWDhYTxarkJgwRk1Jao9MBxvGcZFCKEcs61OCFlIn5qKQLkaFvNpJf2x2kQ9i66vrUpLiEFeKQ7EN7+6A4toP+UMZPPLjfPRMJ7d29rT1FlHBlppPAlmsTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h3iXxifu; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h3iXxifu"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3a1bc0c876so6667120276.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Jan 2025 12:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736627334; x=1737232134; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=su7sEZs6sK9K+9hHJb7zVZvpVw3fB02+nwGgI8BSZN4=;
        b=h3iXxifuHcxwy57XDd8SNlqX5010En5vjR/c2QPpgMeYG/kgMTHEpq2pcHrR2qtUGY
         ViiQUObdppB69F8kHgQUSjkxCAQ6nEI5Wmm92ARQUWBiA5NkrreqJLYytmsvs/G8BNBG
         gwSPm6KQQ+7/lQqLlqsHI1T706S+W33Dx5DpwxXS79cPwOTfuRlh6jf0FMoz4/uGoiM+
         c/WnYx5WoPIAEmR7NzBddUJjVlcFcbMmauYcp4T/jc6hjmguVzvJHmkGpVnEANEWlPZr
         q0dRslYQ3u0Qsd5TJfufD6IVvPZnjBCl2ke6XJZ8tVhux9pMU089yA0+CC76zYRE2nWW
         A8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736627334; x=1737232134;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=su7sEZs6sK9K+9hHJb7zVZvpVw3fB02+nwGgI8BSZN4=;
        b=oVZXbi3yvmObRa0oSXRsAacK2+AcAORPnflMmoEmxK5Aa8jQ7VXnlnHwa+nLHjQX06
         /um2Gl4MD5PnwXwWxD7PG2ZwX4WKums8P87F0upw7HyV6rVM0KF0caAswqyHjUnbCmhg
         sooXgVC6++DpqCApYUUEjBm2YNTQAC0JOaY3SvqwqhrehrLKbmlWw3DKUD6qeiF3d96E
         rxufQV8T5tbmPhAnY8jMoTNGd0hkePWC5S6hTyTg4YdNhz2VKEfE9674GE5U6Q2rSeDh
         gN69vmiiQG6KAIWty/3lOnIFKedWF+srmem7cqHR45EJZ53WqsKJkW/jtZU+vObe+lBI
         q+Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXOeRfNblJb0IM8Pr3ZCrCJ+A1pJHwT9fSt1qqlsrppanFbVmhGIE4kI4GfyFDjNFFv2m0olzXi7hpz1+W2wmC+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/hlSdAlulmYrrbK0p558XyO7RG3FDo7MFqJJwKoc22P+ZhrWW
	nP8ph+DWGo70Hu8HLyZ9ILYtMmpa/U0v/C7ggv9UXlwjEgIGrxClpzX7S3der0GE1JuLwKkc5+g
	/YmxoBQ==
X-Google-Smtp-Source: AGHT+IH1/aE6G+u0DsJsYlLN4153L+o9XiJB0ZkaVr0GPPmiVVDH32HwfXYOBkEs5gHx139r+z7Mno/lfroX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8807:d7c5:bb27:35fc])
 (user=irogers job=sendgmr) by 2002:a25:a4c9:0:b0:e39:6fdc:556d with SMTP id
 3f1490d57ef6-e54efbe6474mr33317276.0.1736627334602; Sat, 11 Jan 2025 12:28:54
 -0800 (PST)
Date: Sat, 11 Jan 2025 12:28:48 -0800
Message-Id: <20250111202851.1075338-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 0/3] Remove BUILD_NONDISTRO
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	James Clark <james.clark@linaro.org>, "Steinar H. Gunderson" <sesse@google.com>, 
	Changbin Du <changbin.du@huawei.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

BUILD_NONDISTRO is used to build perf against the license incompatible
libbfd and libiberty libraries. As this has been opt-in for nearly 2
years, commit dd317df07207 ("perf build: Make binutil libraries opt
in"), remove the code to simplify the code base.

Ian Rogers (3):
  perf build: Remove libbfd support
  perf build: Remove libiberty support
  perf build: Remove unused defines

 tools/perf/Documentation/perf-check.txt |   1 -
 tools/perf/Makefile.config              |  63 +-----
 tools/perf/Makefile.perf                |  11 +-
 tools/perf/builtin-check.c              |   1 -
 tools/perf/tests/Build                  |   1 -
 tools/perf/tests/builtin-test.c         |   1 -
 tools/perf/tests/make                   |   2 -
 tools/perf/tests/pe-file-parsing.c      | 101 ----------
 tools/perf/tests/tests.h                |   1 -
 tools/perf/util/demangle-cxx.cpp        |  22 +--
 tools/perf/util/disasm_bpf.c            | 166 ----------------
 tools/perf/util/srcline.c               | 244 +-----------------------
 tools/perf/util/symbol-elf.c            |  95 ---------
 tools/perf/util/symbol.c                | 135 -------------
 tools/perf/util/symbol.h                |   4 -
 15 files changed, 9 insertions(+), 839 deletions(-)
 delete mode 100644 tools/perf/tests/pe-file-parsing.c

-- 
2.47.1.613.gc27f4b7a9f-goog

