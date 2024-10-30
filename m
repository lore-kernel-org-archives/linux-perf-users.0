Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEA833E7;
	Wed, 30 Oct 2024 05:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730265879; cv=none; b=I05JkZq1HLKQHaxyhnK9Ys4EKcyGY/dALvmcvzLoYf+VZ/Uc4fA13UFdv/cF8gedlUqT63gEnJ4qQ2IoqnWT418dDFm3Shk1i79P5Dl2crwfScSjdhOECJ5voi0RWuh6l2rpAkLNsCwvVEWnMt4vjK49G8OdP+L/9jnUNyJ5A3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730265879; c=relaxed/simple;
	bh=zl08Rhkws58E6okfTzADxN0F1aSVTSjUJGgPx/MA/jA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qd5jnhwT5d2BcIsHZ8zTmKTr8hC53CC/FJFGB/Et+StsbkJ5KFtPLuq9vpaFtn0uf/TbjU12QFZreqDVk6G1WsfzZB43W3Fh52/Hnqn7dULQQH1pjKG9Me9tcel4gheBke4VYpBF0/+RG3H7A1VM45dyU1tm+gd9UKjDycaPZxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeI42bYg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeI42bYg"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cb7139d9dso60243235ad.1;
        Tue, 29 Oct 2024 22:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730265875; x=1730870675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0axlmaqsuJtieWtwnnGeVznQY87VPCmkHxwnI9bHPHE=;
        b=HeI42bYgXAHU6ls1rYSJ508SF1WzPIIqACC+TLbCiqQjziko2HnAp6IFhIyddyRQ9p
         uYbPcGHA8a7j8fMDYaiZ3uZpPo/iRLkx47xIBPAQjrRnbrj0PhdfsTokjznsQrlNNqzS
         3hI8MEwf4kk2Ihzw5Bm6Z6yi08EG9N1Dtj+roxJZ20WS2Cr1Su+W5sU/Rj21qKMLoZf+
         iO/R6FJtdeQw83VmFe8/T964aI+rGARPgdd04VNyMVowm1zvNNaOWFRquIlfyAwP2jvk
         /5UGOP6msjOgI2OjqXTJ/F0myqlYOYad6qntwEUGJmutaOqyIgoM9dt4abU8/FgnjtrA
         /rFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730265875; x=1730870675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0axlmaqsuJtieWtwnnGeVznQY87VPCmkHxwnI9bHPHE=;
        b=EFUVh7C/rQHqp14b91Y/77XEEWDBe28vR8s5sViCF6WKEhJ/MmBvWsxt6/rkZCFith
         9qW472/2Qx8IHs8NjAfjt3d+XYKzEfAAQdvqcfqcS+N4bMQtDf8hS+I5icVBss7wkP9z
         RaLpHExItbjR4nSP942j9CLDj5khwsYthGjqMcd8dIbPXvjUbfUWN91IBld59bsfPWbz
         j9+vYKO7J1F1UIs4jyChkUmE3EmCV34k2965GFGlOUbLE9eOCZMA0W+LFPBQaZ7JfVEc
         zMOcp72jX+y2NFP6CTQsc5ozv6shOnumF6o3lCHiyYnSDzmhDKi5u7fGCEIckYawgY2y
         td0g==
X-Forwarded-Encrypted: i=1; AJvYcCW/xOazT1LuNhULtqtLMEqAYUpqDol92l8uRboTKEVr1Rh4+6nKfkDOfnDmBqeaQiv1GQ3mvCQsx0Bt80M=@vger.kernel.org, AJvYcCW8Rg9GYKJw7x9AOKxGsuFwJbUBcvH2D6JddHaFedR8mmJYqExI2Nyv7aZMCUjgBLhGxlljHCznXayl3zZfCEyGEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YybDJEYEpfgr+hDcqN66rgAKtdSCrSOzZ0y5Dv0KBq82oF6M4Sq
	erRr/ekuhFPp3xpM+jDs0UfPlD4YXdcDeyi1MCNhj7hvOk05aixA
X-Google-Smtp-Source: AGHT+IFSRkqs99cTSy5BVTAhrbtOjeydCDlV84URRPLEqEjeIp4LZuHKDPKaqaYtY1+GUxUzPx1p4w==
X-Received: by 2002:a17:902:fb85:b0:20d:1866:ed6f with SMTP id d9443c01a7336-210c68786c9mr173770295ad.4.1730265875207;
        Tue, 29 Oct 2024 22:24:35 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf4455dsm74160565ad.60.2024.10.29.22.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 22:24:34 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org,
	peterz@infradead.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	mingo@redhat.com,
	mark.rutland@arm.com,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v2] perf trace: Fix perf trace tracing itself, creating feedback loops
Date: Tue, 29 Oct 2024 22:24:31 -0700
Message-ID: <20241030052431.2220130-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There exists a pids_filtered map in augmented_raw_syscalls.bpf.c that
ceases to provide functionality after the BPF skeleton migration:
commit 5e6da6be3082 ("perf trace: Migrate BPF augmentation to use a skeleton")

Before the migration, pid_filtered map works, courtesy of Arnaldo
Carvalho de Melo <acme@kernel.org>:

⬢ [acme@toolbox perf-tools]$ git log --oneline -5
6f769c3458b6cf2d (HEAD) perf tests trace+probe_vfs_getname.sh: Accept quotes surrounding the filename
7777ac3dfe29f55d perf test trace+probe_vfs_getname.sh: Remove stray \ before /
33d9c5062113a4bd perf script python: Add stub for PMU symbol to the python binding
e59fea47f83e8a9a perf symbols: Fix DSO kernel load and symbol process to correctly map DSO to its long_name, type and adjust_symbols
878460e8d0ff84a0 perf build: Remove -Wno-unused-but-set-variable from the flex flags when building with clang < 13.0.0

root@x1:/home/acme/git/perf-tools# perf trace -e /tmp/augmented_raw_syscalls.o -e write* --max-events=30  &
[1] 180632
root@x1:/home/acme/git/perf-tools#      0.000 ( 0.051 ms): NetworkManager/1127 write(fd: 3, buf: 0x7ffeb508ef70, count: 8)                           = 8
     0.115 ( 0.010 ms): NetworkManager/1127 write(fd: 3, buf: 0x7ffeb508ef70, count: 8)                           = 8
     0.916 ( 0.068 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 246)                         = 246
     1.699 ( 0.047 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 121)                         = 121
     2.167 ( 0.041 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 121)                         = 121
     2.739 ( 0.042 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 121)                         = 121
     3.138 ( 0.027 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 121)                         = 121
     3.477 ( 0.027 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 121)                         = 121
     3.738 ( 0.023 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 121)                         = 121
     3.946 ( 0.024 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 121)                         = 121
     4.195 ( 0.024 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 121)                         = 121
     4.212 ( 0.026 ms): NetworkManager/1127 write(fd: 3, buf: 0x7ffeb508ef70, count: 8)                           = 8
     4.285 ( 0.006 ms): NetworkManager/1127 write(fd: 3, buf: 0x7ffeb508ef70, count: 8)                           = 8
     4.445 ( 0.018 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 260)                         = 260
     4.508 ( 0.009 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 124)                         = 124
     4.592 ( 0.010 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 116)                         = 116
     4.666 ( 0.009 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 130)                         = 130
     4.715 ( 0.010 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 95)                          = 95
     4.765 ( 0.007 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 102)                         = 102
     4.815 ( 0.009 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 79)                          = 79
     4.890 ( 0.008 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 57)                          = 57
     4.937 ( 0.007 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 89)                          = 89
     5.009 ( 0.010 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 112)                         = 112
     5.059 ( 0.010 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 112)                         = 112
     5.116 ( 0.007 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 79)                          = 79
     5.152 ( 0.009 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 33)                          = 33
     5.215 ( 0.008 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 37)                          = 37
     5.293 ( 0.010 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 128)                         = 128
     5.339 ( 0.009 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 89)                          = 89
     5.384 ( 0.008 ms): sudo/156867 write(fd: 8, buf: 0x55cb4cd2f650, count: 100)                         = 100

[1]+  Done                    perf trace -e /tmp/augmented_raw_syscalls.o -e write* --max-events=30
root@x1:/home/acme/git/perf-tools#

No events for the 'perf trace' (pid 180632), i.e. no feedback loop.

If we leave it running:

root@x1:/home/acme/git/perf-tools# perf trace -e /tmp/augmented_raw_syscalls.o -e landlock_add_rule &
[1] 181068
root@x1:/home/acme/git/perf-tools#

And then look at what maps it sets up:

root@x1:/home/acme/git/perf-tools# bpftool map | grep pids_filtered -A3
1190: hash  name pids_filtered  flags 0x0
        key 4B  value 1B  max_entries 64  memlock 7264B
        btf_id 1613
        pids perf(181068)
root@x1:/home/acme/git/perf-tools#

And ask for dumping its contents:

We see that we are _also_ setting it to filter those:

root@x1:/home/acme/git/perf-tools# bpftool map dump id 1190
[{
        "key": 181068,
        "value": 1
    },{
        "key": 156801,
        "value": 1
    }
]

Now testing the migration commit:

perf $ git log
commit 5e6da6be3082f77be06894a1a94d52a90b4007dc (HEAD)
Author: Ian Rogers <irogers@google.com>
Date:   Thu Aug 10 11:48:51 2023 -0700

    perf trace: Migrate BPF augmentation to use a skeleton

perf $ ./perf trace -e write --max-events=10 & echo #!
[1] 1808653

perf $      0.000 ( 0.010 ms): :1808671/1808671 write(fd: 1, buf: 0x6003f5b26fc0, count: 11)                          = 11
     0.162 (         ): perf/1808653 write(fd: 2, buf: 0x7fffc2174e50, count: 11)                       ...
     0.174 (         ): perf/1808653 write(fd: 2, buf: 0x74ce21804563, count: 1)                        ...
     0.184 (         ): perf/1808653 write(fd: 2, buf: 0x57b936589052, count: 5)

The feedback loop is there.

Keep it running, look into the bpf map:

perf $ bpftool map | grep pids_filtered
10675: hash  name pids_filtered  flags 0x0

sberf $ bpftool map dump id 10675
[]

The map is empty.

Now, this commit:
commit 64917f4df048 ("perf trace: Use heuristic when deciding if a syscall tracepoint "const char *" field is really a string")

Temporarily fixed the feedback loop for perf trace -e write, that's
because before using the heuristic, write is hooked to sys_enter_openat:

perf $ git log
commit 83a0943b1870944612a8aa0049f910826ebfd4f7 (HEAD)
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Thu Aug 17 12:11:51 2023 -0300

    perf trace: Use the augmented_raw_syscall BPF skel only for tracing syscalls

perf $ ./perf trace -e write --max-events=10 -v 2>&1 | grep Reusing
Reusing "openat" BPF sys_enter augmenter for "write"

And after the heuristic fix, it's unaugmented:

perf $ git log
commit 64917f4df048a0649ea7901c2321f020e71e6f24 (HEAD)
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Thu Aug 17 15:14:21 2023 -0300

    perf trace: Use heuristic when deciding if a syscall tracepoint "const char *" field is really a string

perf $ ./perf trace -e write --max-events=10 -v 2>&1 | grep Reusing
perf $

After using the heuristic, write is hooked to syscall_unaugmented, which
returns 1.

SEC("tp/raw_syscalls/sys_enter")
int syscall_unaugmented(struct syscall_enter_args *args)
{
	return 1;
}

If the BPF program returns 1, the tracepoint filter will filter it
(since the tracepoint filter for perf is correctly set), but before the
heuristic, when it was hooked to a sys_enter_openat(), which is a BPF
program that calls bpf_perf_event_output() and writes to the buffer, it
didn't get filtered, thus creating feedback loop. So switching write to
unaugmented accidentally fixed the problem.

But some syscalls are not so lucky, for example newfstatat:
perf $ ./perf trace -e newfstatat --max-events=100 & echo #!
[1] 2166948

   457.718 (         ): perf/2166948 newfstatat(dfd: CWD, filename: "/proc/self/ns/mnt", statbuf: 0x7fff0132a9f0) ...
   457.749 (         ): perf/2166948 newfstatat(dfd: CWD, filename: "/proc/2166950/ns/mnt", statbuf: 0x7fff0132aa80) ...
   457.962 (         ): perf/2166948 newfstatat(dfd: CWD, filename: "/proc/self/ns/mnt", statbuf: 0x7fff0132a9f0) ...

Currently, write is augmented by the new BTF general augmenter (which
calls bpf_perf_event_output()). The problem, which luckily got fixed,
resurfaced, and that’s how it was discovered.

v1:

Currently when tracing system-wide, perf trace will trace itself,
creating feedback loops. This patch fixes this problem by setting the
correct BPF map for filtering pids.

Before:

here perf/2807067 is the tracing process itself):

perf $ ./perf trace -e write --max-events=10
     0.000 ( 0.007 ms): tmux: server/2299109 write(fd: 4, buf: \17, count: 1)                                      = 1 (systemd)
     0.060 (         ): perf/2807067 write(fd: 2, buf:      0.000 , count: 11)                          ...
     0.072 (         ): perf/2807067 write(fd: 2, buf: (, count: 1)                                     ...
     0.085 (         ): perf/2807067 write(fd: 2, buf:  0.007 ms, count: 9)                             ...
     0.089 (         ): perf/2807067 write(fd: 2, buf: ): , count: 3)                                   ...
     0.094 (         ): perf/2807067 write(fd: 2, buf: tmux: server/, count: 13)                        ...
     0.099 (         ): perf/2807067 write(fd: 2, buf: 2299109 , count: 8)                              ...
     0.103 (         ): perf/2807067 write(fd: 2, buf: write(fd: 4, buf: \17, count: 1, count: 31)      ...
     0.108 (         ): perf/2807067 write(fd: 2, buf: )                               , count: 41)     ...
     0.113 (         ): perf/2807067 write(fd: 2, buf: 1, count: 1)                                     ...

After:

perf $ ./perf trace -e write --max-events=10
     0.000 ( 0.030 ms): sshd/2725386 write(fd: 4, buf: r\148\133\163\17\167\194\172bF\231\192\227\194\215\251kBLE\167(\10WY\22\138^\233\28\248\249, count: 36) = 36 (idle_inject/3)
     0.622 ( 0.019 ms): sshd/2725386 write(fd: 4, buf: \177"\251\159\244)F5\224\250\135Y\1865/\30\191\171\140Q\213\182\133\145\224\148\190L\210{\143D, count: 228) =
     9.510 ( 0.014 ms): dirname/2805386 write(fd: 1, buf: /root/.tmux/plugins/tmux-continu, count: 43)        = 43 (kauditd)
     9.788 ( 0.007 ms): bash/2805385 write(fd: 1, buf: /root/.tmux/plugins/tmux-continu, count: 43)        = 43 (kauditd)
    13.865 ( 0.020 ms): :2805390/2805390 write(fd: 1, buf: 1.9\10, count: 4)                                   = 4 (kworker/R-rcu_g)
    15.183 ( 0.015 ms): tr/2805391 write(fd: 1, buf: 19, count: 2)                                       = 2 (kthreadd)
    15.715 ( 0.009 ms): bash/2805388 write(fd: 1, buf: 19\10, count: 3)                                    = 3 (pool_workqueue_)
    18.755 ( 0.014 ms): tmux/2805393 write(fd: 1, buf: tmux 3.4\10, count: 9)                              = 9 (kworker/0:0H-ev)
    19.737 ( 0.044 ms): sshd/2725386 write(fd: 4, buf: \188\197;\82d.1k\197\30\165[L@\153\139\192\173\247k\179kT.m\150\223\216\31\251\255, count: 316) =
    20.173 ( 0.008 ms): bash/2805396 write(fd: 1, buf: tmux 3.4\10, count: 9)                              = 9 (kworker/0:0H-ev)

Fixes: 5e6da6be3082 ("perf trace: Migrate BPF augmentation to use a skeleton")
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 748b061f8678..5d83da62275c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4326,6 +4326,8 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 					sizeof(__u32), BPF_ANY);
 		}
 	}
+
+	trace->filter_pids.map = trace->skel->maps.pids_filtered;
 #endif
 	err = trace__set_filter_pids(trace);
 	if (err < 0)
-- 
2.43.0

