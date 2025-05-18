Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED5A1E5B82;
	Sun, 18 May 2025 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747595407; cv=none; b=bvxT259RHwM4L4DTmZ0RUJg1yCUf1l07MyE1MKT4P1INrJvkwbR3Rj7iBiqmGI7efiPvW6k/rF+hx/rpQqzf4KbkB/StnR6D0KdPxGGZmBvLWc2mJH2Iii3WVYJjLXVWD+lW1ixM/4qwjFNaNpGUfrh04jsvDvmb3tY0lrXsz0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747595407; c=relaxed/simple;
	bh=HG/dOz1lUTBRbsbrIN5BoAJntNUMI8JcyM3yL1TC0mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cq+ZdQHuRnpM+A4i2CXE+6X5a5/WGhnN+RsFvWZyI3PXXia0bRzz3CQx3hKv9tzDsQqwEgbOUhBGfCSURB1paCK06T3s1scpNYA+AuwEYM+Z2aWWOtlxLPpwPv0QnL+nc0rL1QYbsiz1quKaRFw+dWtRWuvRXHC8B4DmfHPCA7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBfQlw0R; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBfQlw0R"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23211e62204so5503875ad.3;
        Sun, 18 May 2025 12:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747595405; x=1748200205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twBj1QB2d3zPEN2bcWML/rrXbWI+c5IxpKvrPzrniRQ=;
        b=PBfQlw0RgIDLK04n/tWTimkZ5ClyM7V0iC5DWAdvOI5k3H1sYZOwUF9gdpFzWSTqds
         wQ9Hpw50PPb4ALJBEXxe12tnH9tFmptdZlB4CYzIAzZoMRPcB3AVoiJSmaIKX18jJq1f
         c4PyupAeEdZLLxcIlFVGzM0YJBxKq6wfR0cwI9mI48NIFmtYVm6qz5pFTOsNkXu4Oiag
         99gHRI8MFxIIbwcYIiAWEWva+HqRRifgNOFQtfRhpYU+vfb65JXWGn4yHTE4KBSTJJk7
         mEZj45VhG9HoNRj33gOZwoihCmS4e5jC/RxLxsHEsWeAukA1klJFCIH5gnXGshSX9js0
         NYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747595405; x=1748200205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twBj1QB2d3zPEN2bcWML/rrXbWI+c5IxpKvrPzrniRQ=;
        b=N2uBp7f3+CzgsY8mQCoieAaIbLMWZCnV06mKJvO/N+8Tg70au68ndwmjbSRR3Ypqgs
         0eRqXOT4quxTVOv9l+apE1LnyrQwJ0x9iXOQCsE3pbn0Z0eTLco1Xi9yiDVxJ7yiZ6GG
         bVV3+IeWSo8ITib3B5+CyF349YBhHwM58/usMTMONrSD4lBkQdmXKtHe7LID2ZWyAkcb
         UB0KaNAYjPLRk0ciIqPRUCZj0aLWE3ZpWMsVEnDArMcnaGmyvxVCgf+urUQxYBuxNOY2
         3G1VZAmGVlcnv9FtuuybnzfDeAQVXk1X2WVcM9emXV/non4tU87Xgq/ary6xq/Wk6eU6
         5ZBA==
X-Forwarded-Encrypted: i=1; AJvYcCWCVpXUgfZWZJfQ/zLFIRIoilWvWtY/9SzkgxKVw1u14tY+kF9Qg1CVrjfc7eHgtyqcDjl3Z+9QJi8lYKUOS3zlSA==@vger.kernel.org, AJvYcCWyf/YCo3LFFFRvR/D+naVjGryoSqNwvJgqlcFVGLnidx4rjO+pwiLWwf+5lae49PEmuo5BwKmFf/MfZGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdyiDYipt+galgSGgUtCFm6GgqYWaI6q3a28mWZ62qIMteVoMe
	tX5TGDkqVO0J/wOpjk59G3eiQtIGHEjcO3W1n5RoB6OVMzdXRpr9Eq7/
X-Gm-Gg: ASbGncsbJDDz+EvYmA0UsVn4s3mLSQ1hPNIOJbFdwPZqwclI7QOYOD/3r6hnKMG8j2O
	cQqaXPe292bfn/Ha6iOhNMvdlTmZz/ocPrCxDKu4NagXnDFBCExICWG+6IQrb0p5jjPdg1fncRN
	q7Fmpsep6yNFA8Qu5DpWCpBFm9by+/4YFGH85l6ESjO/GnANz9tbPcrtQToj0zEAe5GlyTIxvXD
	V1QLsIXdPHCyuZmeCidKA0l9ZRMYX4rZEazGXSQ0RlxIzrEyEAE+yxvVWw0NpFdoje6STPs0Bih
	g/MOFBn9m+cc3XzJRSRPFw/u3/2roBYbA9moOb5rrT5nRL1SGx5+PG4I2WE6NuqK7VToj6azbgW
	FjCJIJbo4mV0u7dHNL3nZ
X-Google-Smtp-Source: AGHT+IG6YMgBJWT7eCqVBTsf5BlvqHMqPwdt1koNjI1X6M4Dcceg6Pch6tS96IZ0QPE7mYlgcnVBAg==
X-Received: by 2002:a17:903:234f:b0:231:b37e:4da8 with SMTP id d9443c01a7336-231d459a604mr174360575ad.41.1747595404723;
        Sun, 18 May 2025 12:10:04 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4adafedsm46022135ad.56.2025.05.18.12.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 12:10:04 -0700 (PDT)
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
Subject: [PATCH v2 3/5] perf test trace: Stop tracing hrtimer_setup event in trace enum test
Date: Sun, 18 May 2025 12:09:55 -0700
Message-ID: <20250518190957.58932-4-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250518190957.58932-1-howardchu95@gmail.com>
References: <20250518190957.58932-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The event 'timer:hrtimer_setup' is relatively new, for older kernels,
perf trace enum tests won't run as the event 'timer:hrtimer_setup'
cannot be found.

It was originally called 'timer:hrtimer_init', before being renamed in:

commit 244132c4e577 ("tracing/timers: Rename the hrtimer_init event to hrtimer_setup")

Using timer:hrtimer_start should be enough for current testing, and
hopefully 'start' won't be renamed in the future.

Before:
    $ sudo /tmp/perf test enum -vv
    107: perf trace enum augmentation tests:
    107: perf trace enum augmentation tests                              : Running
    --- start ---
    test child forked, pid 786187
    Checking if vmlinux exists
    Tracing syscall landlock_add_rule
    Tracing non-syscall tracepoint timer:hrtimer_setup,timer:hrtimer_start
    [tracepoint failure] Failed to trace timer:hrtimer_setup,timer:hrtimer_start tracepoint, output:
    event syntax error: 'timer:hrtimer_setup,timer:hrtimer_start'
			 \___ unknown tracepoint

    Error:  File /sys/kernel/tracing//events/timer/hrtimer_setup not found.
    Hint:   Perhaps this kernel misses some CONFIG_ setting to enable this feature?.

    Run 'perf list' for a list of valid events

     Usage: perf trace [<options>] [<command>]
	or: perf trace [<options>] -- <command> [<options>]
	or: perf trace record [<options>] [<command>]
	or: perf trace record [<options>] -- <command> [<options>]

	-e, --event <event>   event/syscall selector. use 'perf list' to list available events
    ---- end(-1) ----
    107: perf trace enum augmentation tests                              : FAILED!

After:
    $ sudo /tmp/perf test enum -vv
    107: perf trace enum augmentation tests:
    107: perf trace enum augmentation tests                              : Running
    --- start ---
    test child forked, pid 808547
    Checking if vmlinux exists
    Tracing syscall landlock_add_rule
    Tracing non-syscall tracepoint timer:hrtimer_start
    ---- end(0) ----
    107: perf trace enum augmentation tests                              : Ok

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/shell/trace_btf_enum.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
index f59ba34fac4c..c37017bfeb5e 100755
--- a/tools/perf/tests/shell/trace_btf_enum.sh
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -5,7 +5,7 @@
 err=0
 
 syscall="landlock_add_rule"
-non_syscall="timer:hrtimer_setup,timer:hrtimer_start"
+non_syscall="timer:hrtimer_start"
 
 TESTPROG="perf test -w landlock"
 
-- 
2.45.2

