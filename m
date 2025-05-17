Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707D620CCC9;
	Sat, 17 May 2025 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747499561; cv=none; b=SO6JhRML3MlEDo4ic1/jaZE1DY3ZR9zkl0dw48EjqgsavIDlKD/7FmbzqLiiRRaDQX/oRQqpmJlN4TOdC74xz6irqEXoMe4tjKTjr66lEVoq3mOAP865n3h1o+Vqbdu70Z1irofpApRxxWhpPsBR5l4tFxje+FcMbjitYqf3qEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747499561; c=relaxed/simple;
	bh=Uh9Z7wvd+KbCKVhLYcHj1vnjI+C5lpp+HRMDkgEd7/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGZSGSjkPMhAIxhAYhA7gDI52gtdO6YxrNZR08V7Lg4w3CBGsHZLW6Yk+8bDy0tt48/WH7a3hjuVS8AcbKj93SQK8KdO9yo04Om2ov3Iekh8pvGuSKS2DUkSW7Qa1pR1GMFNxsOrDZ8O+w5D4IIFlE970L+y4TE4sSH27hV1b3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MN0ZPWqo; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MN0ZPWqo"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b27015122c4so226719a12.3;
        Sat, 17 May 2025 09:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747499559; x=1748104359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmSSATjp3lH9WYqjUjXBBWOvACi2ZWxGK/PyKr3xEcE=;
        b=MN0ZPWqogFgHtj8/S6nnVSLUUpmGf1OlePKoe5hr+uBokxd/W0mR44up582L0HCMX3
         fL9qSG9uKxlzn+S79sZuCRKiDlZc9xJF1e3Kl20gyUGQ30IA8YpA9UQipohMz9CriGrz
         7cdhw4sIj3p2MQ5j0xRJGMhMcO+fVHyWjTYDx9676QGnl55vyI9hg8ipdcCMTsUs9JIq
         X3Exkopc42CFjWrOFq9aPGLEvu5Qbu557AHjN+vee5161b3eSaP1kj+azRF8/3iQ5bWc
         7MScQd9tvGItQA1T8ZwQghDA9oVzftsV0kaaYuvpLkRCMYsX4VSC96WUC3cTjhX/1l7F
         NqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747499559; x=1748104359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmSSATjp3lH9WYqjUjXBBWOvACi2ZWxGK/PyKr3xEcE=;
        b=FGQmoKIsnO8UCURUO3Q0r0WFyj4l+Dn0CObjJ04LsKiAhtGs0sAljxYST0GfCIguu9
         yTqG8Iz01r3T/EytPknTM/3rZEWlDhRaCN+3gFKgXK4V1lEB1AWvxLiqtkc/3HCJptRp
         SOKyfQejymaAvnFfSaGNs0JdybrJKMXHc0yDEbbWWHTqYUI8QkLfbf0VUN9zoE95eEY2
         WL9lzl9S1miHEmZP+rHK6xGIzbtLtB+nnJJs/n6JYSedH7Q5PU/Hk5gTowW8/QFxOw3v
         zWYuENOOgy6+0/px7oaOcB6CStfrWUdSu0wAX9oFo4PRTALC5xqugsdaXdh2VLfs5lgR
         9wjg==
X-Forwarded-Encrypted: i=1; AJvYcCUXG78dwSzLIvalTYlXPhyUFny9qcSONWmrMJk07BAFc8kkFm/5+5de4BeQdJiny8NxxiA4asgfolP716I=@vger.kernel.org, AJvYcCWBBca8Ys2AXwKKPGw6DXxMidzKZvrSG+YTC/SJ0F7TzibYj7/MtC7wLSAkbqD90dawiL9AM7wblnCPzl3NfSCxIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgnXlQGtqQd5XeSEuzse5fARs6nLMJSuWIsVJZyvlBnoyD4FDJ
	RD94jo1XpcUgex5QmPqu6xk2N1dvXL8ObNogwLtFOkRRL/CqbOQyqfvf
X-Gm-Gg: ASbGncvgxmlT5PlTIMRpEXOF/c6hS235Ah+/5kMPb5BFTYTItsNmrIpHJ5udpCTSMV4
	qHsylCWh3p6fIp4TMjy+Pt3HKhJEpdJxnPKmr6wgAMIxGC0DKPP25Y2vB+0KXO6KqBHGeugnq7/
	J5rgIKTYT9dI7INuM5r8XB15cQs1hwZDXdLr/MM6xM+iRipcjTA7XYPtfA6RpkgJ5erA0xB5nWd
	ZkQ/Qwhzv4Dsks4VcJP3r0sLO8v8hIX31weLl8s+dSS07mqp3sRDC/zB7g/TKtfX9TL1daY/3j6
	NJDI75kJXNpTGmRNnqV89DXHc6btziW1T/vm2kNIwI48090P7FIiA09xAFhScS0Re1MGSvfQt9w
	/tR+si0H01qAf5jN277BR
X-Google-Smtp-Source: AGHT+IFhRVnlYOvCLVuYmMmVRk1oMIWJSwOLRc05ZVgFlRDImlEyIm3RoQBKPQGScw2pjjQchhScew==
X-Received: by 2002:a17:902:ea0a:b0:22c:35c5:e30a with SMTP id d9443c01a7336-231d44d70a9mr98230455ad.16.1747499558577;
        Sat, 17 May 2025 09:32:38 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb085ad4sm3330321a12.59.2025.05.17.09.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 09:32:38 -0700 (PDT)
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
Subject: [PATCH v1 3/5] perf test trace: Stop tracing hrtimer_init event in trace enum test
Date: Sat, 17 May 2025 09:32:28 -0700
Message-ID: <20250517163230.1237469-4-howardchu95@gmail.com>
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
index cd4c8754f5d4..da6903108c8b 100755
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

