Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB9E21B182;
	Wed, 28 May 2025 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748459516; cv=none; b=MjrrgNp1eIZWck4sTiGRbHukqV5N9vAxNAeY8K/RE8EayI2/g6LKQjiTNIqwjP/5X4X0D0B/iq+qYBv8c1D8H46SwE8S9llQ1MA1f4CLlBiZtcMvUOJ5vpExnFxKVLnsluktNf+MbdA+hmC19M/BNzOPestZFdDgCcvQdRGbsaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748459516; c=relaxed/simple;
	bh=mVeS1DwLh3YN2Z8nLwdQ0FcDREC0Wysb9FnWiUZNLec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ihy7+UfkP+YQizIzcRyF35RstQQpamUZhHLmTPtM35H/Ypd/Y0mZWv5vMMAyJ9n6o4hoY9NunSB4tEFI7iJhu8WFSqYJHM2/AOqusE5uJPlB+QLoK4ItZsoVda9epLzYTmwJX0gnFDyeizWYvcKv09MAd5kWUCGpMS74RZdbXtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMqNTmYp; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMqNTmYp"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234bfe37cccso3086645ad.0;
        Wed, 28 May 2025 12:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748459514; x=1749064314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NfU6lKh/CqCSh0qCEAauDus8fp/OoFPPrxMtpXJevk=;
        b=mMqNTmYpEWplNs8Bysy02dkiKeECEpL/H6dnEd9tM6T3qXEWixSNppficXD/0Sc7ao
         bDP6ttKS+Uhn6m/ruKtl61sqqeg1GpLAISkErQ/3cY9MwQvvPyJCOcsyt16nL84bUf4K
         lPqNAFICMakLZ5DYKR/OAMDazIIKxW2XXu02Ozvpw1RrRc6ey86mXLRAcrdrPRzoSi92
         MkDEFKrs2GzXv5C+eo0kiuc+RGacMVfiPpMuc/JrM5s43a/7+TTHAP4WR8OyO5O2JJlc
         JmctScaEsGNF3aNRTPO3ecePoMoCnVryXXApfC6qxIM+1vsbUVokZHNfk9oJREDOfB1e
         tQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748459514; x=1749064314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NfU6lKh/CqCSh0qCEAauDus8fp/OoFPPrxMtpXJevk=;
        b=kl2w4QZt/f6NJz07QVDXVeFUrfksqaLiU6p9NjYXpgdrjcWVzNOW8ZlJRWweIV51Tx
         a+GKY7KqBT1AMDDHNKnDHMS5Vmx9nPNijURYX+Gc5eU3b1hR/yzdHpjf48IhU7S6Gynt
         tXOdvWxSs20KUJmaOO1o5MWYUtH2Z8dJPzjfGDedndVLTRae7VYrqruPpEar1IqjDKiJ
         +wO/DxNTIAdV7NRcayHSGUXE/+Mm/3bGmZr4jJvy4vj1oDrHWquteJnuDPZYxngGvLix
         95z56G3+12H+un25E5QauzzNRELE7zgIrb6CGPhpB4KO4d/ljq5Zgor9RBPYe9O1TkN3
         PlCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlgUTaDhpw95iEU16TZOuJcqi7pOwfNreCEc4H7LhzDlFoBBcbjzvTcxkAhPHVcOJhWvTsZXJQUDQ9B4imp9Up5A==@vger.kernel.org, AJvYcCXUFxGbai6naFdhtC4sAz3xvnsnQ6I2t/7r1/DuZFGZqqCxhFzz7WeleoeUX9je4Y2voxcfPuJ9IrY5qzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLySBxlKnWw//O+q0feu2FcqrqtUiiaIo3sysCgF2l9aiWuFtH
	KPDmq6d0TycmeDCIAgFXJTbBSNe5KsIN+UKq2xNg9Ur8Rt2Zxmfdpga0
X-Gm-Gg: ASbGncskdYT3s8BaQJKNP2b5rwl5FcSv6DefSYTZ6NujlCYDHVm5wiCfMC5l2fN2hie
	gyC8Y/2FG4KqqfKzLN9lK6c1uWh4D2CrZ+e+SZGqUYBtnJyAPRwG1FW1uoCboTwnpYSwih/24WP
	78xwYpUk1FQUNRMmBOBydvFYl+mTjAgYwSWzcgOc9pw8YniYjfkIjmEUP/yX0T/DRFJWDNAU1eQ
	0uFY53cAk/dXOpqBpqjGCxMwElJob/aBAwCzhvNX15Ph2e1n0Ho20FhcXDTjEBjxOqGH4DfqfhX
	zinygknSyOx/5gK0hJqj2csRIMS7T/uaKhYW9wyuqmEMrR1mcneWyfVNX+J9oM0EHH6cgbR6kTH
	InNNUkhTj3ak=
X-Google-Smtp-Source: AGHT+IHyuSj3krDp+IbqWrLbMenuFyc8aPXLf+QPP3IwG1yAbhPpKo2qi5/KmvAj5wUbOYDkY26Agg==
X-Received: by 2002:a17:903:187:b0:234:d41e:f0e6 with SMTP id d9443c01a7336-234d41ef29cmr60260685ad.34.1748459514153;
        Wed, 28 May 2025 12:11:54 -0700 (PDT)
Received: from howard.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm15172215ad.169.2025.05.28.12.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 12:11:53 -0700 (PDT)
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
Subject: [PATCH v3 2/6] perf test trace: Remove set -e and print trace test's error messages
Date: Wed, 28 May 2025 12:11:44 -0700
Message-ID: <20250528191148.89118-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250528191148.89118-1-howardchu95@gmail.com>
References: <20250528191148.89118-1-howardchu95@gmail.com>
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

