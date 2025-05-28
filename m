Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181851F461A;
	Wed, 28 May 2025 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748459513; cv=none; b=ewGL7uCgQEJaKcoIzJuZ6mVPMjH3LFy/NQR9++DTd16K3vnAWZ6xkolHpg1OP4M+8PasLn+v4F0iig7DIHUNow+htjrlLgf17s4v92ZKrWMOe6O9Q9YvxOJyq6YXun3pDLakibpH+Fe9JHbYRuTOTg2Hpnn2wXeFBL4shrYBDPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748459513; c=relaxed/simple;
	bh=TbbOwOyTLvnjiLUiP2a5L1aiKcMFagc68WIo8GOC4Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DplbXyUeRwzeFYYt9COvV/QGyn9erfalkkH2X88kXKMlRyErL1wM8m+q1PObv3BuiLFpeUmMGQGtXGzOGliS41xwgfpc/vBTBHEVx1bRyBUHXvwRQwS87JRQXgKbkeLEyJgldvWZDQ6YprxY7StN7o88/Ch8hmRY13FVF2mpWcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4IqCViL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4IqCViL"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2301ac32320so2574885ad.1;
        Wed, 28 May 2025 12:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748459511; x=1749064311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MKcf3onY2C3NvmcuCul2AtL+hbcvuimxqtJWlircx9U=;
        b=C4IqCViLiX3/0h6H6aJtrk50AdJaaIuGik38hXI0YxJvc67XZBNKoXpLUkQc7qa3OB
         qcZgoNojJLGocqMZSMy92zBJGBXiwGZjgDypIV/AQw+1WJehsTYa6R4dRue2qrXY/9oR
         a3+IWcSrjNh6/8PnhMawkQH70FtPFfEybLSWlnSzqF8c4l7nHbOhewhKX4C+Te4k8pU0
         OBfSZIJ0R/Gs7i+qllHIfqA6ycwgzgk4YNCwPZlTuyedCQ0WQMmsONBG/Avxxo3nYN/8
         Z6nRBt+6L631bz7BYHQB5S36nHZwbYExEMJEMJQgvY8hEoIsGUVSIICXO7cZIxCQ1R6F
         DtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748459511; x=1749064311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MKcf3onY2C3NvmcuCul2AtL+hbcvuimxqtJWlircx9U=;
        b=L317GJmTZOLhSTzKWdyx68mQ1HaEhAU/tL9EKXU1Yx+6xpAaNSzDJYuAfskBvSVqFW
         M7nyCZxno6LbMdG+luZ8Ogk/1f19elFmWjNilsFI76NW3T9ZtsmO0Hi5nA/Gw5LyLaSM
         GH3KBkhfesr8FvBe1SzadS9cL0JLPeYdHGWO6dfjn8nciLyEj1bhST/1c4NszYM/v3qY
         /AYehbB1K0rlex0To7oqby5611uKaBR9QGAM3qWmDGCXsoSenouio/hefSKBZZr8QeEl
         +RonuSF+kmxH4aQYTHn8HYAtiwmUFh08FkNq4UbfgZr/V1/OF5FoohBJ+kKcI01F9f3U
         ZjZA==
X-Forwarded-Encrypted: i=1; AJvYcCUTXuEC3oc65DvvGn+J6iIAJSJZQKIS7kpkdxiJgu1gjti56XtEdQkh3CoEkB/Xl4GDMPiFazhs/TWiBmpQz8FT8Q==@vger.kernel.org, AJvYcCWDVvrfc7zs40Zog/7XhzUHLZSDISOnTlDLaG5BqF5/jTLX0oLaokcIgrXgEpLUl0JLeDFJIwdrXc9lTL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye2Khqc5qL+jyj4u4PeZq1ZSYjEuxxcrnboVJ8BOvevI2jwHnA
	EPRZr3QR97GGFK9RNbtQsbBSlGcjvRe2rPEnOYiyS3XqCrSEPm3s9E1U
X-Gm-Gg: ASbGnctL07vnZogH9liDP31mMsWnTEjcijPLK4LdDZ0djiYc+nY6otENq1/WbqYk640
	6f3doXw0+4lQM2rN7e2zM+S8W5J4EDIxpIAwkDh97UMqnUAVptLmzQTuWtDTodqwurL2G1LTi2X
	bVvG9brn8axFXZJlOnTRzrQO1Bf7Pr9x8uWOu/e2ZVybt/u32aXuxZmfgbPsEOxhqAssQdXzgpR
	8MO3b6wdlTsX1bHUn5lvTwMm62Ib46APAcqoKRqzpR0dkwGmFT2rxEtWT6h65SarkmI1Uro3pbW
	cOw/dIua8pDVIF2pDYtd8HU60O9JY5p96ufBEvqA2c8+bgINhx+BqgI3wZFhFAD9ZqnCo+Tzp5O
	nMClMqvzGL+k=
X-Google-Smtp-Source: AGHT+IEDAH2hcvJgHqxnxod5aMklVwtobKgPFOhNRDYsLXv9/T6isq21HLtCvhSvYTU3jY1Wzq7o4g==
X-Received: by 2002:a17:902:f705:b0:234:e7bb:9640 with SMTP id d9443c01a7336-234e7bb9888mr32546865ad.44.1748459511129;
        Wed, 28 May 2025 12:11:51 -0700 (PDT)
Received: from howard.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm15172215ad.169.2025.05.28.12.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 12:11:50 -0700 (PDT)
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
Subject: [PATCH v3 0/6] perf test trace: Reduce test failures and make error messages verbose
Date: Wed, 28 May 2025 12:11:42 -0700
Message-ID: <20250528191148.89118-1-howardchu95@gmail.com>
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

Changes in v3:
- Change the regex pattern in struct augmentation (Ian)

Changes in v2:
- Add an extra newline after error messages
- Rename the title of patch 3 to 'Stop tracing hrtimer_setup...'
- Take the debug diff for explanation out of patch 5 to make it apply
  normally
- Add base-commit in this cover letter

Howard Chu (6):
  perf test trace: Use shell's -f flag to check if vmlinux exists
  perf test trace: Remove set -e and print trace test's error messages
  perf test trace: Stop tracing hrtimer_setup event in trace enum test
  perf test trace: Remove set -e for BTF general tests
  perf test trace BTF: Use --sort-events in BTF general tests
  perf test trace BTF: Change the regex pattern in the struct test

 tools/perf/tests/shell/trace_btf_enum.sh    | 17 +++++++++--------
 tools/perf/tests/shell/trace_btf_general.sh | 19 +++++++++----------
 2 files changed, 18 insertions(+), 18 deletions(-)


base-commit: 628e124404b3db5e10e17228e680a2999018ab33
-- 
2.45.2

