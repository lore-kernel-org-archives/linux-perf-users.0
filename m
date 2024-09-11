Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CCC1885A8;
	Wed, 11 Sep 2024 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726084656; cv=none; b=V7m8g2ngBJU5+EBM44J6lDXdIgzDAnGzCtBkiGL32cajMkmgKmD3d+wPL2l8SVP55dCDJfx6NsuD6S3BwCYGYwnehR6oh4B+t+xR5dBkmND2GcnUo9d5sFvHdvULNCnNI58kfZO78GnQC3lSOdMEDqwxyU2J6z8a87+aCy3Nrzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726084656; c=relaxed/simple;
	bh=aJUyMsvyZZ05hM8yt6xFU9WboZ6bRU9MA8Jf4EE1a34=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BEV2EOX20RPXEeEVq+J0MG6Ehr2kKoj9c8Z/ozVIRHXR5GpP9xfDNaOWNMjJERZG5D/XlX99rmQynSpJXpMKc3QECDlgl5bx7OZckLiFS0QSerOqVEgCEp7xUVIerjXIflxQK3clczUmdmRF9DR04mEkhzldVU7PAkPG6yqick0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzsRkEIk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzsRkEIk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15FEC4CEC0;
	Wed, 11 Sep 2024 19:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726084655;
	bh=aJUyMsvyZZ05hM8yt6xFU9WboZ6bRU9MA8Jf4EE1a34=;
	h=Date:From:To:Cc:Subject:From;
	b=OzsRkEIkWz5pejC9Fs+QNydjkVQIbBm3dOTULvrwOX/UUUZ8AFAdZLzQ+86s5tepR
	 UAg8sNh567SepvOxOp4aaTf2OCVFpc7BPd9mON4efMtkWFTLCi4Yjppz91PGmHNWmy
	 M0nb4b5bkRIma9FxAlTHpxlrGJPdVUh0+qOsRL0MXD9wNKAQOh8jHOQSTZF7EW3KUA
	 Q6C1joTlM2vXmUtcdpwXRMGLj/B+EApB1V6IQOO4ejjt61ufzmDT90ObAr7cyuLznl
	 6YUhBBRLZ2+20zwTgBz2UHJjzh9t5ojinjhOhjLwpavBgXBdYpvexEpTfmkvoJFHcN
	 dOZi89kE0Mn2A==
Date: Wed, 11 Sep 2024 16:57:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf trace: Mark the 'rseq' arg in the rseq syscall as
 coming from user space
Message-ID: <ZuH2K1LLt1pIDkbd@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With that it uses the generic BTF based pretty printer:

  root@number:~# grep -w rseq /sys/kernel/tracing/events/syscalls/sys_enter_rseq/format
  	field:struct rseq * rseq;	offset:16;	size:8;	signed:0;
  print fmt: "rseq: 0x%08lx, rseq_len: 0x%08lx, flags: 0x%08lx, sig: 0x%08lx", ((unsigned long)(REC->rseq)), ((unsigned long)(REC->rseq_len)), ((unsigned long)(REC->flags)), ((unsigned long)(REC->sig))
  root@number:~#

Before:

  root@number:~# perf trace -e rseq
       0.000 ( 0.017 ms): Isolated Web C/1195452 rseq(rseq: 0x7ff0ecfe6fe0, rseq_len: 32, sig: 1392848979)             = 0
      74.018 ( 0.006 ms): :1195453/1195453 rseq(rseq: 0x7f2af20fffe0, rseq_len: 32, sig: 1392848979)             = 0
    1817.220 ( 0.009 ms): Isolated Web C/1195454 rseq(rseq: 0x7f5c9ec7dfe0, rseq_len: 32, sig: 1392848979)             = 0
    2515.526 ( 0.034 ms): :1195455/1195455 rseq(rseq: 0x7f61503fffe0, rseq_len: 32, sig: 1392848979)             = 0
  ^Croot@number:~#

After:

  root@number:~# perf trace -e rseq
       0.000 ( 0.019 ms): Isolated Web C/1197258 rseq(rseq: (struct rseq){.cpu_id_start = (__u32)4,.cpu_id = (__u32)4,.mm_cid = (__u32)5,}, rseq_len: 32, sig: 1392848979) = 0
    1663.835 ( 0.019 ms): Isolated Web C/1197259 rseq(rseq: (struct rseq){.cpu_id_start = (__u32)24,.cpu_id = (__u32)24,.mm_cid = (__u32)2,}, rseq_len: 32, sig: 1392848979) = 0
    4750.444 ( 0.018 ms): Isolated Web C/1197260 rseq(rseq: (struct rseq){.cpu_id_start = (__u32)8,.cpu_id = (__u32)8,.mm_cid = (__u32)4,}, rseq_len: 32, sig: 1392848979) = 0
    4994.132 ( 0.018 ms): Isolated Web C/1197261 rseq(rseq: (struct rseq){.cpu_id_start = (__u32)10,.cpu_id = (__u32)10,.mm_cid = (__u32)1,}, rseq_len: 32, sig: 1392848979) = 0
    4997.578 ( 0.011 ms): Isolated Web C/1197263 rseq(rseq: (struct rseq){.cpu_id_start = (__u32)16,.cpu_id = (__u32)16,.mm_cid = (__u32)4,}, rseq_len: 32, sig: 1392848979) = 0
    4997.462 ( 0.014 ms): Isolated Web C/1197262 rseq(rseq: (struct rseq){.cpu_id_start = (__u32)17,.cpu_id = (__u32)17,.mm_cid = (__u32)3,}, rseq_len: 32, sig: 1392848979) = 0
  ^Croot@number:~#

We'll probably need to come up with some way for using the BTF info to
synthesize a test that then gets used and captures the output of the
'perf trace' output to check if the arguments are the ones synthesized,
randomically, for now, lets make do manually:

  root@number:~# cat ~acme/c/rseq.c
  #include <sys/syscall.h>     /* Definition of SYS_* constants */
  #include <linux/rseq.h>
  #include <errno.h>
  #include <string.h>
  #include <unistd.h>
  #include <stdint.h>
  #include <stdio.h>

  /* Provide own rseq stub because glibc doesn't */
  __attribute__((weak))
  int sys_rseq(struct rseq *rseq, __u32 rseq_len, int flags, __u32 sig)
  {
  	return syscall(SYS_rseq, rseq, rseq_len, flags, sig);
  }

  int main(int argc, char *argv[])
  {
  	struct rseq rseq = {
  		.cpu_id_start = 12,
  		.cpu_id = 34,
  		.rseq_cs = 56,
  		.flags = 78,
  		.node_id = 90,
  		.mm_cid = 12,
  	};
  	int err = sys_rseq(&rseq, sizeof(rseq), 98765, 0xdeadbeaf);

  	printf("sys_rseq({ .cpu_id_start = 12, .cpu_id = 34, .rseq_cs = 56, .flags = 78, .node_id = 90, .mm_cid = 12, }, %d, 0) = %d (%s)\n", sizeof(rseq), err, strerror(errno));
  	return err;
  }
  root@number:~# perf trace -e rseq ~acme/c/rseq
  sys_rseq({ .cpu_id_start = 12, .cpu_id = 34, .rseq_cs = 56, .flags = 78, .node_id = 90, .mm_cid = 12, }, 32, 0) = -1 (Invalid argument)
       0.000 ( 0.003 ms): rseq/1200640 rseq(rseq: (struct rseq){}, rseq_len: 32, sig: 1392848979)            =
       0.064 ( 0.001 ms): rseq/1200640 rseq(rseq: (struct rseq){.cpu_id_start = (__u32)12,.cpu_id = (__u32)34,.rseq_cs = (__u64)56,.flags = (__u32)78,.node_id = (__u32)90,.mm_cid = (__u32)12,}, rseq_len: 32, flags: 98765, sig: 3735928495) = -1 EINVAL (Invalid argument)

Interesting, glibc seems to be using rseq here, as in addition to the
totally fake one this test case uses, we have this one, around these
other syscalls:

     0.175 ( 0.001 ms): rseq/1201095 set_tid_address(tidptr: 0x7f6def759a10)                               = 1201095 (rseq)
     0.177 ( 0.001 ms): rseq/1201095 set_robust_list(head: 0x7f6def759a20, len: 24)                        = 0
     0.178 ( 0.001 ms): rseq/1201095 rseq(rseq: (struct rseq){}, rseq_len: 32, sig: 1392848979)            =
     0.231 ( 0.005 ms): rseq/1201095 mprotect(start: 0x7f6def93f000, len: 16384, prot: READ)               = 0
     0.238 ( 0.003 ms): rseq/1201095 mprotect(start: 0x403000, len: 4096, prot: READ)                      = 0
     0.244 ( 0.004 ms): rseq/1201095 mprotect(start: 0x7f6def99c000, len: 8192, prot: READ)

Matches strace (well, not really as the strace in fedora:40 doesn't know
about rseq, printing just integer values in hex):

  set_robust_list(0x7fbc6acc7a20, 24)     = 0
  rseq(0x7fbc6acc8060, 0x20, 0, 0x53053053) = 0
  mprotect(0x7fbc6aead000, 16384, PROT_READ) = 0
  mprotect(0x403000, 4096, PROT_READ)     = 0
  mprotect(0x7fbc6af0a000, 8192, PROT_READ) = 0
  prlimit64(0, RLIMIT_STACK, NULL, {rlim_cur=8192*1024, rlim_max=RLIM64_INFINITY}) = 0
  munmap(0x7fbc6aebd000, 81563)           = 0
  rseq(0x7fff15bb9920, 0x20, 0x181cd, 0xdeadbeaf) = -1 EINVAL (Invalid argument)
  fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(0x88, 0x9), ...}) = 0
  getrandom("\xd0\x34\x97\x17\x61\xc2\x2b\x10", 8, GRND_NONBLOCK) = 8
  brk(NULL)                               = 0x18ff4000
  brk(0x19015000)                         = 0x19015000
  write(1, "sys_rseq({ .cpu_id_start = 12, ."..., 136sys_rseq({ .cpu_id_start = 12, .cpu_id = 34, .rseq_cs = 56, .flags = 78, .node_id = 90, .mm_cid = 12, }, 32, 0) = -1 (Invalid argument)
  ) = 136
  exit_group(-1)                          = ?
  +++ exited with 255 +++
  root@number:~#

And also the focus for the v6.13 should be to have a better, strace
like BTF pretty printer as one of the outputs we can get from the libbpf
BTF dumper.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 3b88ba50bb804408..27084ae38bc480c9 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1327,6 +1327,8 @@ static const struct syscall_fmt syscall_fmts[] = {
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* olddirfd */ },
 		   [2] = { .scnprintf = SCA_FDAT, /* newdirfd */ },
 		   [4] = { .scnprintf = SCA_RENAMEAT2_FLAGS, /* flags */ }, }, },
+	{ .name	    = "rseq",	    .errpid = true,
+	  .arg = { [0] = { .from_user = true /* rseq */, }, }, },
 	{ .name	    = "rt_sigaction",
 	  .arg = { [0] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
 	{ .name	    = "rt_sigprocmask",
-- 
2.46.0

