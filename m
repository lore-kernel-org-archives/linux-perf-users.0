Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442F91EF382;
	Sun, 18 May 2025 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747595405; cv=none; b=ZQDWw1wmul76HvmJimjd5S0LVB/OKWDpcqnE/t/MAUvhVk9p+glOVBTAy7CT5AEGtiXcUBJ2M6q1SWgkiFQRo0T+VoTOy//16iFj4hLTr62kR2krWj9plgtYy8qdWjm1YIAkVeBN7oy5hqHUhOIdFpNtyHOnyCi6KftoMyMA9WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747595405; c=relaxed/simple;
	bh=mVeS1DwLh3YN2Z8nLwdQ0FcDREC0Wysb9FnWiUZNLec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVHD6wu5byGIk6pRybd1AgCcG/866/rJxiuSZAtAgMBVZyyvMAVfqPgbijNSdEx5xPHSGqrtO8LavYjQL2vIXVR7y6kKR8aPKF5IFgsKg7Yq4gugw0H3l6zp7GwpN9UvtSH08gcKWHamgcXUxsIGaRIorpqYt3d58wRxTb/aqrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRjOQgdC; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRjOQgdC"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so1895725a12.0;
        Sun, 18 May 2025 12:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747595403; x=1748200203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NfU6lKh/CqCSh0qCEAauDus8fp/OoFPPrxMtpXJevk=;
        b=RRjOQgdCv9SADVmz6IJJk9EALRgkwsMQHdOKrJATyrORTuVNsW3v1fhcUpNjOgqIpx
         TH6maEm9V6d1Vye/WFvYCj5XQGmdIPwTMYCegmdUN8R9lOtDbR84nDgfo/AffYGuJ54/
         yKdp0dWLxv/pXNHhXLaF8eCVM5sqUzoEhteKyBqIVrvah0PaQQ1DiImIJiJxzS3unidJ
         3oZRN4fjZ1JWFV41dXHEnSQu0JUHeHlUqZaerJGRqavmnhsuOjQKJYvkNShEl9jelQOo
         DR6h/BephjM6bjn/SFTaa+/mBC4pCQCgqhmZK0Mm//bGEq8G0jtivRNELri0Kjmx2aQL
         zyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747595403; x=1748200203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NfU6lKh/CqCSh0qCEAauDus8fp/OoFPPrxMtpXJevk=;
        b=LIxhfqbGx7BVzF0yg/fzaJu/awYwJ6HeSJps9ZVzcO9bo+QEXHB0bX0ajWDN4Dm1H9
         SDBg0cAor03qpAeB/uImKbyA77nvvdU8i9iXNR5pUJfmuQDQc0hHs/Ldnktdtd+ZMF7u
         Ws6oEMmcKNNROW6znliIfKrpssyC4Ax4iUvG13gta24NuWw+CqWQHMXx7Aq84Ghq+aHP
         XDcfPMT4+LIrgmfagdghRECqlk0jek7CNZKJYR4Hq2cDpICgzWPVYdhFROx4vZ6tXiIQ
         wX96vJHa3nR1kbYpiGZkVZcaqlZD2KgxZ/z+o7XIk/Q94zsDMNhEehbpEYDcm0OIOTgn
         PgAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfsJ+LZVN9Ci3zhoNAxOCAUd1eOd/ndJHQ/xSAyO8w9rcu3+H10oGeF5qSGDi/mXCU6tSoDpJaEpwkc5o0MTZtEA==@vger.kernel.org, AJvYcCXlxMlxYRklKXqVIUnUDN1Yd+9vwK4UtlWxjxnjTgmLYuCyLe3ROPryS10Q9ehPUhjYt2FwTjfepQaTVrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5YdOwdrlPIeGxH3WKgdmtLh4FSj55J+6gD9K08z/Re/qCGj31
	kvR1Gw//NZLkAoxrttqgfReYb8SanS7tNM+tND+C4VknvwMjA7Leo5gB
X-Gm-Gg: ASbGncuiC3UHedLIrWBii+fnChMLhrIRWG7hEdnrVgMVYOJl4IHh449nF82kvpuMqJJ
	kGnnUi97q1xWLRCNCaueL4t4186ucEDYjwGscpaQF3nLig4JW1FxZ6yJxoO1Nzm4AABNbaCSeCX
	3UWtwR+51VDA8sakwwt7+AsLBprLO4f1qDYbeu/Tquxnpu4QEh58TKVFeiMxqywm3f62SakUcGp
	w7tzWs2ark0Jotr/aYgLuBve0juTpT1EfmH7SVZJxPUJJdldcW3GjNYU51gic3wb7SLBlS+sqhW
	dgn4L9FOnzFAsuo1uakC3RUlY8deL1oug4hSqD+Z9e9QIngzedVEaccWuivkR3uyhcmQ4sE4/yB
	AQ1MqwFqVvAacvZilHgSX
X-Google-Smtp-Source: AGHT+IEKMZJ0YvL4SM//gxtxMZQSKwUVudvCUhfcos3ksHyibDxnj2ZuVJs4tggRfGzKgq8eQvaYLQ==
X-Received: by 2002:a17:902:ea12:b0:231:c6d0:f784 with SMTP id d9443c01a7336-231de37623amr155259115ad.28.1747595403383;
        Sun, 18 May 2025 12:10:03 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4adafedsm46022135ad.56.2025.05.18.12.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 12:10:03 -0700 (PDT)
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
Subject: [PATCH v2 2/5] perf test trace: Remove set -e and print trace test's error messages
Date: Sun, 18 May 2025 12:09:54 -0700
Message-ID: <20250518190957.58932-3-howardchu95@gmail.com>
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

Currently perf test utilizes the set -e option in shell that exit
immediately if a command exits with a non-zero status, this prevents
further error handling and introduces ambiguity. This patch removes set
-e and prints the error message after invoking perf trace during perf
tests.

In my case, the command that exits with a non-zero status is perf
trace instead of grep, because it can't find the 'timer:hrtimer_setup'
tracepoint, see below.

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

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/shell/trace_btf_enum.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
index b3775209a0b1..f59ba34fac4c 100755
--- a/tools/perf/tests/shell/trace_btf_enum.sh
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -3,7 +3,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 err=0
-set -e
 
 syscall="landlock_add_rule"
 non_syscall="timer:hrtimer_setup,timer:hrtimer_start"
@@ -34,22 +33,24 @@ trace_landlock() {
     return
   fi
 
-  if perf trace -e $syscall $TESTPROG 2>&1 | \
-     grep -q -E ".*landlock_add_rule\(ruleset_fd: 11, rule_type: (LANDLOCK_RULE_PATH_BENEATH|LANDLOCK_RULE_NET_PORT), rule_attr: 0x[a-f0-9]+, flags: 45\) = -1.*"
+  output="$(perf trace -e $syscall $TESTPROG 2>&1)"
+  if echo "$output" | grep -q -E ".*landlock_add_rule\(ruleset_fd: 11, rule_type: (LANDLOCK_RULE_PATH_BENEATH|LANDLOCK_RULE_NET_PORT), rule_attr: 0x[a-f0-9]+, flags: 45\) = -1.*"
   then
     err=0
   else
+	printf "[syscall failure] Failed to trace syscall $syscall, output:\n$output\n"
     err=1
   fi
 }
 
 trace_non_syscall() {
-  echo "Tracing non-syscall tracepoint ${non-syscall}"
-  if perf trace -e $non_syscall --max-events=1 2>&1 | \
-     grep -q -E '.*timer:hrtimer_.*\(.*mode: HRTIMER_MODE_.*\)$'
+  echo "Tracing non-syscall tracepoint ${non_syscall}"
+  output="$(perf trace -e $non_syscall --max-events=1 2>&1)"
+  if echo "$output" | grep -q -E '.*timer:hrtimer_.*\(.*mode: HRTIMER_MODE_.*\)$'
   then
     err=0
   else
+	printf "[tracepoint failure] Failed to trace tracepoint $non_syscall, output:\n$output\n"
     err=1
   fi
 }
-- 
2.45.2

