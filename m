Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B108F49;
	Sat, 17 May 2025 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747499556; cv=none; b=H2pUWDx+CLC/mrg+VrFrLOb2wuw95jqxylmZiQLcdR6XiIOuyYxHprAXI7opYzOoYBgTLNqRv19LQs01DiMaJNQTDTlbrf/kiA/fjBDTozrKOxNWhaJXRUcD9ytWJ43WGdYubi+Z4wdx7hyF2S/TbcZn+AH8gUTM1fcT6e7AKPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747499556; c=relaxed/simple;
	bh=6i1OCAQPxR7MAeBC6aAPdEXo9HNFyJCUanMtxIwXJS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CcrxZgtS4e+wwxGywQx4sGySdO7IMgFDxltFy9n6aCvuAG4BL/j6bxpLAOEZsKH0EC//cj36TfT8iR2B0C/JXZV8MHknWuZ68z9bkjWII3NTUnT+HIqV5TMRg5SWimQiWn9JDADam128PACovVWi6qLta3fzk0z6A6rxrGGPaGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/OuWyUr; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/OuWyUr"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7376e311086so3857792b3a.3;
        Sat, 17 May 2025 09:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747499554; x=1748104354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9RMnPB0XazpqRo+cZ1H+WbKvz3PObEBIe7Rys2atvY8=;
        b=K/OuWyUrbBQBfdsLOygs44Cfbo/5HiH53RV9YiP98QEm5Qyzlo+xXA6IPUt+3Oo/yo
         jnIsSYu4+IfIfa2w3eIKRpwa6WS2AAfl0kvtsGmC16molv5UR1OvhGuDtvPA7dlsLeCS
         ssDVCxOJNmFyyU9dIKOCbHEpvK1Y0w4ysIy7yOA1jGEuOGD8hbhzzve81RFLy/OLf39R
         UoFq+SmV7oclNvEsK0O/kzkPMNta0BxzSf7afd11us8CYp38YlU7l17B9xWe3BPxaQ5m
         0DeyQ+meDy8zOIWTTVQskwWdp/ktUjCf+3zPpJgMJpJtLjmcqsdi0bgfXKKYu6t6aM4Y
         Dwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747499554; x=1748104354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RMnPB0XazpqRo+cZ1H+WbKvz3PObEBIe7Rys2atvY8=;
        b=a+XAYizXXGXpIObmXaw473fDZAK8RPYpQR8P/nMZViSigEXBHphiglk4TmdP1mcXBe
         Qj2GBLCiyevXC4tyjcn68B1hAFUfggD292Cwx4xozMg3wQ9Rly/ObVy+fyvMrVeMe4Jm
         RmK5tlC//OusnfivBRXaEicm58Gf4HjfUyFMz9ApwiH5R7Ebn72MX2DCWXkKRL7YXHcz
         40aobOapM/CthNfkrHNXQsePwl5hOPXNqP6b0PFBLHhq2vqRSxSl8svMsoN+1uHRa8s5
         5Gz6kvNAHtl11RTWJvgk0Fx41LzTe0BkU2fwdb7eHsoGyge7oYMsMS0hh57oLvWsuhQO
         tg0g==
X-Forwarded-Encrypted: i=1; AJvYcCUPbfp/NJhbpdJ9yzCXlHHL0QnatL0ThQpYjXCAigM8QGaYw8aBI+bBEsYVo25msdu6AM7nkPxTQamseuI=@vger.kernel.org, AJvYcCUor7U5CDt/HCWp69tZMdbACjnOhtp48msIMPvzjpygXFiOmWbmDv2JIvKrxuD9Cz2G7Sn5K+Okk6pSHSasrcNqxA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw36VEYXe1KPrgBAnkiHkXgBruHsH8k9Id/Yo+5f63FLj4Ge5x6
	8d+uYdD+RH9hVjhFrEaHMzBh1ntSkIBjiqWgIGPPfVZ3nU8V5c2qDFmR
X-Gm-Gg: ASbGncsQaH8TkcY6D6v+7Gzea/liYm16y5rJRK2L71MB1k5dbdzj0hxEA8lYJUmAf7F
	o6aRda9IGHg4WpWY74Qd/fb5+qepOSBd1mpdWPRY5uVVbaQtXl9CKXrf53rG7KCLwMIDlikevGk
	trB/6NvPIhFuwUi8/mUwo2uH2R2Vni/wYXkAsIhG+J/XuAA5xLq4oqrlYFRKs/62aCIOknKMwe8
	pGP/HmWnV4qo2WbJx1LDHgNGcZ2b+D/DeMQgEzmmOh7vfkUbJ4vAVV5NvwikmhLW4uKJ90qZuOW
	uiyzKp8S6O1RwgN2v8iWTVIGVQv8dIEDok0sj6WdDzFCEjYYlN5dm0JQBaMRK0oilRkf+3llVRf
	XeZY4Nr6OJSofNn7XwTwf
X-Google-Smtp-Source: AGHT+IGObEivvPaqJbZDy/HciXiWC+Fz8e5unw5DlECa1JVcbZIhd7wKbJ4Ndjw8U/gLccHNB1JfAQ==
X-Received: by 2002:a05:6a20:12c3:b0:215:efe1:a680 with SMTP id adf61e73a8af0-216218c4103mr10621113637.16.1747499554210;
        Sat, 17 May 2025 09:32:34 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb085ad4sm3330321a12.59.2025.05.17.09.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 09:32:33 -0700 (PDT)
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
Subject: [PATCH v1 0/5] perf test trace: Reduce test failures and make error messages verbose
Date: Sat, 17 May 2025 09:32:25 -0700
Message-ID: <20250517163230.1237469-1-howardchu95@gmail.com>
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

Howard Chu (5):
  perf test trace: Use shell's -f flag to check if vmlinux exists
  perf test trace: Remove set -e and print trace test's error messages
  perf test trace: Stop tracing hrtimer_init event in trace enum test
  perf test trace: Remove set -e for BTF general tests
  perf test trace BTF: Use --sort-events in BTF general tests

 tools/perf/tests/shell/trace_btf_enum.sh    | 17 +++++++++--------
 tools/perf/tests/shell/trace_btf_general.sh | 19 +++++++++----------
 2 files changed, 18 insertions(+), 18 deletions(-)

-- 
2.45.2

