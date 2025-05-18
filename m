Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEDB524F;
	Sun, 18 May 2025 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747595403; cv=none; b=YEeLYJA+jFFI3M4426kl+9XVGpp2LX2Yvh/AAftPN9CAlfmCjFnqnF99IuW5fpgXB0BhYDmDmHfo2Id6J1o+1iuqgO3kBWzZjTd1S317IAIJ1IJRnuRRJkE29Ox0gK9ABwpHmamd7Mn4ZFsRRYT7S/YiQVPKuh2PgVPGq9hqMTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747595403; c=relaxed/simple;
	bh=GvB/G+i95ZZQteF5FxcXKffT9l5EkWLLG0LHY5VSkYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IoFO5jMMgza5KKTfYTGji63UprT9x9XkNYjgrGidUwblIQ+RO99k4umJ/lQpUbHpK5SrmFAOdZsFt2GMi1zl65Pw7RzWQ2sxY752zDWZXMPDT16TrVjvDLi92CFt0TSRDBvDTcW1N5hqXjj4J7XlHPFrGeTxgyJB+k3/iQiC4uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VT23s9Ls; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VT23s9Ls"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b13e0471a2dso2340838a12.2;
        Sun, 18 May 2025 12:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747595401; x=1748200201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sgGAjU8xGF6/rBCP2bWau8Qhj3P6Vl8Sn6a3+LkDSSE=;
        b=VT23s9LsPBPUrqpNE/6bsqjwIKgJssuaizu4S1k8XwriQxay9lPWkt46cwzEs3VDCQ
         YE/Zuaa3b/Yw5FHrqhRkxsgOqzwqz+Be81fnjvbVlnd+QRTVgiSveiMb6Htbd0yZB3xq
         6vW9fdgMsVmxxBVuyp4m9K88stvnHxPLhYBjKrTJEPOIxxhCuIAZwkiVRxbyXdahsk00
         C7T4kcNib782uzV6xb1Euh4qOhBOd7IkqNfLNQTbXtITrywIFDsY5u05AZzxRfae5vIt
         0UvbpUopkwmXVXmun+Sb3mv+CSyItBtM63gfFPGrZKyOqaK0Ho+0pkm8lB5GJIevjtk8
         fwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747595401; x=1748200201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sgGAjU8xGF6/rBCP2bWau8Qhj3P6Vl8Sn6a3+LkDSSE=;
        b=B5yWEgwI729IXhsWrgTZ6/qSxAk9986CIILL18Chw8niDxAcy2RlIUNuWiLm4X47kD
         UwLhzB/uJhROxsup0tL/N+mTBs5NlEmBDOZGNfw5BFbuz/YEreL30TQcUXY6ex+XI9DX
         B3tQJZuSoZxfg3sZ09DAT6IoqSxOYwyubI9W5aTkqrokMfHvo6kZIiSJOUpjvsLggHD1
         k60ff0UDkWg9J5ygK+a7IWarJiqmKMojcGO7ZQHddG33+uTBrDyoZ7wKj0IWys7xBYtp
         7rUjUp8SDIOVSQZQAptXF1u2UadXhcutfeZHb3y7ak7RvUyYEl4cQzE7jRLcwaGVAsSY
         Y8zg==
X-Forwarded-Encrypted: i=1; AJvYcCW24bLUgzmmzao6Mw6GDAJCGYrTMWvUkeXy9Q8POFzcP+7QWd0S7YhjXXsHZRCi8yqHnyFTpzt7o7yfP5s=@vger.kernel.org, AJvYcCXI/nH0VAJJU4ERu2d2UVtHBwNoG2XpoSEupkpFPsjdIlJitr9HmaRCn5YfdGiVNbHeZCeaRNzxfklFlSPolHyl1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwD6zn0BUNPvSdvZD5LF/k4gpi12uWsLZZcMpBGANGGg/+8zw+2
	eIOq3HqYQ+NmsGwYGLa1PBGdf272SiT9W5OuC43af/ekrgcPIAidGR1I
X-Gm-Gg: ASbGncvEVSL5bYgaEgK66NvNeF8ScPFK2+UaS1PcaUXhWKwVXYqZOWkycDGaYvsKMKL
	7BwYX+C/3W1cyk+Fhw7Ucj4cL+fGXZuTb94H+5bK9o7B1zHZcs6MANrpFq9v+j7S63HytrOGVS/
	B2qQ3vOfRaCzBIWjJp0rY+1t9F7un4RXz4+Zovp2FaBpHuYVrLBwwhouvN7/IgMatHWd+zbTKKZ
	kZNkYDPJUCS2em+yt79En6NoCWupnmwSEkNj4kUyjLVzwIkTqUr23EZKc/X/f2J6AdpMH3bqH6w
	+64LmolCukvzwrIB7sgfjoM6EsCj4p2/Wybol2jUW3qlqQp0AxC+hSmBcOqJSSnm47iX0x6NuKW
	nl8CJR1kZtTI9Ls9bMHuy
X-Google-Smtp-Source: AGHT+IFh1C8bUWbaOcnJ6lHFiK7+ODqcwhqf9WtPrehxz4NC0FUULCzq1xlaQiZZzFCexfC8U3VUOA==
X-Received: by 2002:a17:903:32ce:b0:21f:6fb9:9299 with SMTP id d9443c01a7336-231de375e8cmr115798125ad.27.1747595400673;
        Sun, 18 May 2025 12:10:00 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4adafedsm46022135ad.56.2025.05.18.12.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 12:10:00 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v2 0/5] perf test trace: Reduce test failures and make error messages verbose
Date: Sun, 18 May 2025 12:09:52 -0700
Message-ID: <20250518190957.58932-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, BTF tests fail constantly, this series fixes two major reasons
why they fail, and makes the error messages acquired when using '-vv'
more verbose, so when they fail, one can easily diagnose the problem.

Before:
    $ sudo /tmp/perf test enum -vv
    107: perf trace enum augmentation tests:
    107: perf trace enum augmentation tests                              : Running
    --- start ---
    test child forked, pid 783533
    Checking if vmlinux exists
    Tracing syscall landlock_add_rule
    Tracing non-syscall tracepoint syscall
    ---- end(-1) ----
    107: perf trace enum augmentation tests                              : FAILED!

After:
    $ sudo /tmp/perf test enum -vv
    107: perf trace enum augmentation tests:
    107: perf trace enum augmentation tests                              : Running
    --- start ---
    test child forked, pid 851658
    Checking if vmlinux exists
    Tracing syscall landlock_add_rule
    Tracing non-syscall tracepoint timer:hrtimer_setup,timer:hrtimer_start
    [tracepoint failure] Failed to trace tracepoint timer:hrtimer_setup,timer:hrtimer_start, output:
    event syntax error: 'timer:hrtimer_setup,timer:hrtimer_start'
			 \___ unknown tracepoint

    Error:  File /sys/kernel/tracing//events/timer/hrtimer_setup not found.
    Hint:   Perhaps this kernel misses some CONFIG_ setting to enable this feature?.

    Run 'perf list' for a list of valid events

     Usage: perf trace [<options>] [<command>]
	or: perf trace [<options>] -- <command> [<options>]
	or: perf trace record [<options>] [<command>]
	or: perf trace record [<options>] -- <command> [<options>]

	-e, --event <event>   event/syscall selector. use 'perf list' to list available events---- end(-1) ----
    107: perf trace enum augmentation tests                              : FAILED!

Changes in v2:
- Add an extra newline after error messages
- Rename the title of patch 3 to 'Stop tracing hrtimer_setup...'
- Take the debug diff for explanation out of patch 5 to make it apply
  normally
- Add base-commit in this cover letter

Howard Chu (5):
  perf test trace: Use shell's -f flag to check if vmlinux exists
  perf test trace: Remove set -e and print trace test's error messages
  perf test trace: Stop tracing hrtimer_setup event in trace enum test
  perf test trace: Remove set -e for BTF general tests
  perf test trace BTF: Use --sort-events in BTF general tests

 tools/perf/tests/shell/trace_btf_enum.sh    | 17 +++++++++--------
 tools/perf/tests/shell/trace_btf_general.sh | 19 +++++++++----------
 2 files changed, 18 insertions(+), 18 deletions(-)


base-commit: f3061d526714ac6cc936c48e76a6eb0512c69b1a
-- 
2.45.2

