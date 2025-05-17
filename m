Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09F820B80C;
	Sat, 17 May 2025 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747499559; cv=none; b=D31u+x+tz6M7qi6HeAySzFIknj9QppdO7MLRIJKwg/BWkhuZnXPwkqmg5FD1I5MQurjO+7J8HeiY3q0TGWjNek9M5dgjwn08AFjzcLfgoZOcQ8hMIVMPTiblLEUdye8PWpAadKKJ1/2S7AAUywERW2oqpBdRjrMiQrJzFrhbxrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747499559; c=relaxed/simple;
	bh=JpitFxDZDkuLTGhIYbm2ECfB2WguZ4Bf2Hed/FiGZI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ce9lmXPOsWvTDwyWDvda1JRYy5+lqfEHN+ECADJ9ENwMNz2efpA+LAtsbZ5We+yqkWwAz6w/S7VJE8XNAqLYTJqYvmZYFAK0+/psaUv0kScr45mBuu2txqd6YokPCbgS5d3qpOpflakGJeR+Oh3P8IlxDiowsybfch60LVfsqbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niNioji2; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niNioji2"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74237a74f15so4324248b3a.0;
        Sat, 17 May 2025 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747499557; x=1748104357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfoZKaGdxA/TqDgfmwlz1BlHb88Ak1UL58E9cYAzYtw=;
        b=niNioji2TPrPyL0uZ6eR8qJREI8YhMz4H3+7TCmx+uFq2QAMM4iZ8NlgZN8gt079j5
         T4xVc3eWZcE6PEilQWpiYuJxQIZOjXR11vTkhQdq/RCrtck+HeQHs6Hw5tC1GaI79fjv
         1JVU+9fSXatMRlGyeGXGCYSQSRBMoxp0w0eXUm8dstXX/miqvEVin1kQuiJ3WadbFq8S
         2cm8NAk/1M6SsPoHaQXSDC3sKeQk6WqcKI813QH5xdJsotzHasz5Vq5H++Ii7ux2tQso
         o4QNEurl7rHmn81K+4+r3wd3HC+HdOnQAEUzQ5nfVxmdyl9lHSjwAEVdt6nbpu9NWMMo
         S03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747499557; x=1748104357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfoZKaGdxA/TqDgfmwlz1BlHb88Ak1UL58E9cYAzYtw=;
        b=ThnylkbYwGCy+I6BSXYMx+qKRGt0hAAULQI+jaI4NcAfe47RCN67hoc7VdXD+mfEGW
         3X273zL+/LyLokXUMdiPorbPvd9iJbeGWkOeCcqh4mD5WJJupE+y5l4i3r/N3BlcunwS
         VBOX8BUv13rAmFL2f5pvM6sOSo/ycozYX25IigUZdDRXd71GHgMU5ZnJvE2gHLtoJdpM
         WtyKa4nzkJ9nu2wxn3Mha0YHXqZC/frpbXdzlOrAJo6y1QCk4nhulVigfvVQgwzDaBxf
         a1Y5D0bL1Otg8MQFroxxMbQJ7aVZigLCyNpUQTKFsb4ExNDgEmnCsa8YN43f+tRtIFpe
         ZDDg==
X-Forwarded-Encrypted: i=1; AJvYcCXEzLC2Nv7h21SotfkZJ1UBKJsDC2cYeh5Ea6pUAVwsHxSpYjF19HbKXcRq6grOY371feCMkKdIqnBNx6Y=@vger.kernel.org, AJvYcCXmdOIBOrBGCBwhzWNR9RQacruBuCRe5wXcYFm9prKxtYYe6I+OJLfRJVTVvs2gZfNSDp0sAI/mwjAfOhP96EwQBA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyctrao7/bPrM3z4ABXgpUZz8SCOwV+DnIyfhuhydsIdfDK0/BA
	fVPUnhDBgg2VZ8DwXNJYwd8R4wfNXIkgqKRuE2dEDQw5G/WGw3PXmJDL
X-Gm-Gg: ASbGncuPDrZIVf4MdvZrvN7srXFDEtQ6bRyuqGkCe+rxUa7dSCvKaJOGHBHrurJcyKZ
	6YCuM9byJplT4OkWR53oMrkSHSqZ2wL468ipBgRlTBhpM8l184mKcTUy2Xadc65KDXD9Ruq09yu
	LRhrXy1GrWJnaBklnGcVzs8W49cvnKa8csaRTPF53LH7t9DUOvgJUB3aLT7OdUbFQ/mXJYA8Wpd
	Zaqc5KLPXqGJTYw0nt9MviheWeKrxyQmQsOFiShCdOl0QxzYJKAn9hRbuBALYnt05QaeAmSSreJ
	0Dwqz+Rdla73VE9Or+o58v7foZ5dJ7O9gYjhVXZggFgMfI2dpU6w6Xa2A9A0E3FfLE+3iYy43Zc
	J/p70luruwH0tfA8LZRmS
X-Google-Smtp-Source: AGHT+IEG/SV69zB8iNq1UYH7j0kXtoztTzF1FmciK2mZMnfBxL46epRnuerfKd/ZJfUxmrph+Nk5MQ==
X-Received: by 2002:a05:6a20:3d83:b0:20d:d31c:cd28 with SMTP id adf61e73a8af0-21621876c6cmr12180463637.7.1747499557100;
        Sat, 17 May 2025 09:32:37 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb085ad4sm3330321a12.59.2025.05.17.09.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 09:32:36 -0700 (PDT)
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
Subject: [PATCH v1 2/5] perf test trace: Remove set -e and print trace test's error messages
Date: Sat, 17 May 2025 09:32:27 -0700
Message-ID: <20250517163230.1237469-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250517163230.1237469-1-howardchu95@gmail.com>
References: <20250517163230.1237469-1-howardchu95@gmail.com>
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
index b3775209a0b1..cd4c8754f5d4 100755
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
+	printf "[syscall failure] Failed to trace syscall $syscall, output:\n$output"
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
+	printf "[tracepoint failure] Failed to trace tracepoint $non_syscall, output:\n$output"
     err=1
   fi
 }
-- 
2.45.2

