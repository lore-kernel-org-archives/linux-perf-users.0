Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806E821B9D8;
	Wed, 28 May 2025 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748459518; cv=none; b=XRNa05FX2QsRRKXDbBbhUKbVrFYlTkDcSflly5zKbCDHKE+Nnzwdb2RsWjAzqQNCWUZH0Ex7ufsbfic5gMVklo/5oav2MM94brhRZImVsonHD0l/S1Z5coZPTx/hjSgzzruT8iLL80iD1Nm1zr6Tti22XFw0ohIWMmBXRrxygjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748459518; c=relaxed/simple;
	bh=HG/dOz1lUTBRbsbrIN5BoAJntNUMI8JcyM3yL1TC0mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCD5amBvRcX5E3sud28Xo8vYP/tAWvMh7Ovo6j89iw4Ffdx/s0h+avKhWxMIkJ+6jJu9SO9S1Tq1xSjWe8xThAwJrNQ03u3o45pHzbONMOlDnHRmYU3bza+0irmMBj21gh0k796C0G0Fx1Vk6zAgBCbq4D74YUFosBLGSEWA+G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2FJsASX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2FJsASX"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2345c60507bso1754615ad.0;
        Wed, 28 May 2025 12:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748459516; x=1749064316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twBj1QB2d3zPEN2bcWML/rrXbWI+c5IxpKvrPzrniRQ=;
        b=X2FJsASX4G6r97j3Yoq9aBXkI5CNKE8KemHjAABzGLLhJslmdM6gveoHR9tsFxp78e
         /krgHyWT6Ua6l8+hSV9vkaCzB7q+AOEI7O53IhZ3mn8LbCGJLswScEiqOnvM6f4ee/zr
         PUkE7WrYlhWzDN+hYt/0MyVBcCYLYUFQhxhYdQYn6pZvPhZv6kmxuo/Oa72cIW84Qvoo
         WuRXanZDVks/jns0bK+Ibs4HFoptcQjHBtumUDqURJ0Di25o83p2bExAoDJVaNU84EX1
         Nvl/QtowOr2z9Z6R0SbYbUPlU5ZPyHFdkx6MemK95u1ppAOyBC6soh4RX1hE7Kef9eCi
         2JVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748459516; x=1749064316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twBj1QB2d3zPEN2bcWML/rrXbWI+c5IxpKvrPzrniRQ=;
        b=ZEkwuZ7oiwQ4ghU5p/t7Fn9eOuWxmiKQkOXVK34FaOajvrXdZe/C/Vry10rehTWLIJ
         0TDMW9t+gVs62ZcUvAV0rAhUl6PN608akkEuLc51LKrLhnip0+UixsaWBEz7t5ajWPGq
         Hlu3SZnsEbqPwdxMABGBPXgQEn28pJsiXMtkN5bIey8oH0HEVKb9flHNuOujiCwDIwJa
         jBArXHeWWdQIF+RuR5uDyTphoLzEutUMqDZygdb8EQda3aIZP95qTI/1JPewsU68DnrJ
         ziwzW0+wGYoNsxRWGODFW5PkBrVGd2GGdodILxP2sQthipGBv6a68YyGCqV8ZQZ/3s4b
         bTqw==
X-Forwarded-Encrypted: i=1; AJvYcCX/BsDevVugyQmve2OCyFa02rbwMiqvkadBEVA9rFq3oyvI05+7C0i2FI04fmoNNxqr8Mx+U9crdF7EGmM=@vger.kernel.org, AJvYcCXCk1Tk36KnafeimZQ3cZcDD9blqtP+QhhyqnMGcpRcgsOQVNQoQphcieux/HulucS3GA5kVkaav/Fd8ZeFe5gvOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqEruH+T158XNTWv1ya5UR8o+VAXruIlZuPVHd01RQoDUPlq5E
	0GqSVWZRWkSDOp3XftbGUjV9HtdcHAQsUINyZC/8Lkrvf0sxV1Q4u3zF
X-Gm-Gg: ASbGncsdiC3KneRTI/rdUgpksB5PAwwK8gLG/71DnfmbQ5YSR0mGWRJG1RR7m43In6V
	0/6ZQQVq6qSGaBuEUfVdDnAlRLf7uLVXebP/vtYoowfqqsHyUKcpm8kxQr2ujdqxWg1OqYiAaLI
	amZeFw3KwxiPvTac5EdyIJdS46bS1OefzGWPtx6ApJRYPJ+t+ODzKLuT2IX8FNrqSL0m7VT342W
	g7Xb38LhrkbLcS0gZvLy79xh2kdSucPgI1on4RxhVKaWOXiWJGJH7XlNDrr7UqpUvkfCZPl3EMj
	FliJ6kzwejcuWq4RXQFZgYEON/dhLvPHFv4zqzWm0/R/RgOCon9xvGZ1L6Q1ska7rGCajBw02Cs
	3IBiu93+9JDY=
X-Google-Smtp-Source: AGHT+IFSKJqYrzDEq0yFr0vnEyb3QGCo+SFpMf5205tduRWVj66BoOL2uuFmly9WlBuzA4C4GQzVhA==
X-Received: by 2002:a17:903:19f0:b0:22d:b243:2fee with SMTP id d9443c01a7336-23414f5a9e6mr258801175ad.13.1748459515593;
        Wed, 28 May 2025 12:11:55 -0700 (PDT)
Received: from howard.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm15172215ad.169.2025.05.28.12.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 12:11:55 -0700 (PDT)
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
Subject: [PATCH v3 3/6] perf test trace: Stop tracing hrtimer_setup event in trace enum test
Date: Wed, 28 May 2025 12:11:45 -0700
Message-ID: <20250528191148.89118-4-howardchu95@gmail.com>
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

