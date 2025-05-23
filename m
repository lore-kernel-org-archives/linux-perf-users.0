Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE751220F5A;
	Fri, 23 May 2025 01:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747964387; cv=none; b=tOt+dimpRiPytWr2+fq0UO+Bv7EHEBM5zm2xYOC8f6qqnM17/NCKmRKvng8EbCEKHytYaht2AqTwIQxnVeN97Hx8RE1Unz8X5OEmF9OousCBmxIoXgKtEAFatJc58SDhgiDcNd5It9YtFbhz23G3aUdDD2UZcZuYr3lJg9m7nSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747964387; c=relaxed/simple;
	bh=zQojfjL04RInA4S4Z7cG9koRxYhocMLirllCm7Um5xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQgR66QPd8ht/5KF0Qiu5d9o68Lm3ZgwGBcLAOCqAKbootaufnAynbGhy2M84LOIjcpKve25rjX65Gvjaj8uvwz5AINceuBkC05J3jL3analT4TG5Z4mVpoHBBxaMOFWfeopHQDzNYdOfsQWPV9vQguIsxh/7w1libYRn2d2fis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUjGAKyH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUjGAKyH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA28C4CEE4;
	Fri, 23 May 2025 01:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747964387;
	bh=zQojfjL04RInA4S4Z7cG9koRxYhocMLirllCm7Um5xU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DUjGAKyHlhfsXHbkQi1Ci3rkB6cBnFq+ULgRbAtD5INfN8QafI/sk16JsFh1d//51
	 oE1/KgRXCZvgiU7unnJgs3kk4wPIWKOAyfcoLRKtSjMRbMG/AWnSaJJHltxC8CeLZ+
	 +CJBqPmc/Mm0pxbxa0xf84qGVlD4fuAGwsbNvAFIqsML11rXT4zTQF55G8lBen/bCd
	 qwWJivus3kL2p3Xgw970aqiypjcRbsYRmrz5q8jch8uo5o1nEkaWj1Ku80OSGzMXZN
	 RDnGYFN8o8MpPH2Mn8Mh3G0Hemzy2ZFRs3NRuN4ULLFasbzCqN+DFflSSEOe21y343
	 AatXkxLRGVGMQ==
Date: Thu, 22 May 2025 22:39:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Howard Chu <howardchu95@gmail.com>, mingo@redhat.com,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, peterz@infradead.org,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] perf test trace: Reduce test failures and make
 error messages verbose
Message-ID: <aC_R4Mvwto4Q3-ZH@x1>
References: <20250518190957.58932-1-howardchu95@gmail.com>
 <CAP-5=fUs9ZVa3z54w1GyKrR=D0YF5GmSZEQ4dh=cKehTPD_w1g@mail.gmail.com>
 <CAH0uvog3kt=QR1T6uXMBmecDWsh-8UWKXukJ-rRk3in7fud4Eg@mail.gmail.com>
 <CAP-5=fU_UUKmu0gTmODXCG5JUK6MRFOTFU+LCJTfA5yTP+aomA@mail.gmail.com>
 <CAH0uvogRdA15hhyq=9SmJiHWwoARBEBdAh3PA9pOXVbBBo5ODg@mail.gmail.com>
 <CAP-5=fWX7m-3j31pNAXqkNmtr0i3rxAHPC96h=sQ5q31WyNDLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWX7m-3j31pNAXqkNmtr0i3rxAHPC96h=sQ5q31WyNDLg@mail.gmail.com>

On Mon, May 19, 2025 at 12:58:34PM -0700, Ian Rogers wrote:
> On Mon, May 19, 2025 at 12:28 PM Howard Chu <howardchu95@gmail.com> wrote:
> > On Mon, May 19, 2025 at 10:00 AM Ian Rogers <irogers@google.com> wrote:
> > My bad, I have just realized this is because of the data in the
> > timespec, nothing to do with libbpf... The tv_nsec has a value of 1. I
> > think the 'sleep' on your machine has a different implementation. On
> > my machine, the second member has a value of 0, see below:
> > ~~~
> > $ sudo /tmp/perf/perf trace -e clock_nanosleep -- sleep 1
> >      0.000 (1000.196 ms): sleep/54261 clock_nanosleep(rqtp: { .tv_sec:
> > 1, .tv_nsec: 0 }, rmtp: 0x7ffe13529550) = 0
> >
> > $ strace -e clock_nanosleep -- sleep 1
> > clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=1, tv_nsec=0}, 0x7fff859365a0) = 0
> > +++ exited with 0 +++
> > ~~~

> > Can you please run any of the commands above and see what
> > happens(please change the perf executable path)? If you get 'rqtp: {
> > .tv_sec: 1, .tv_nsec: 1 }' then I will just make the regex less
> > strict, because it differs between different 'sleep' implementations
> > instead of having anything to do with perf itself.
 
> Ack. Here is the output:
> ```
> $ sudo /tmp/perf/perf trace -e clock_nanosleep -- sleep 1
>     0.000 (1000.208 ms): sleep/1710732 clock_nanosleep(rqtp: {
> .tv_sec: 1, .tv_nsec: 1 }, rmtp: 0x7ffc091f4090) = 0
> $ strace -e clock_nanosleep -- sleep 1
> clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=1, tv_nsec=1}, 0x7ffe51f3cd00) = 0
> +++ exited with 0 +++
> ```

With what is now in tmp.perf-tools-next:

root@number:~# uname -a
Linux number 6.14.6-300.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Fri May  9 20:11:19 UTC 2025 x86_64 GNU/Linux
root@number:~# rpm -q glibc
glibc-2.41-5.fc42.x86_64
root@number:~# perf trace -e clock_nanosleep -- sleep 1.0000000001
     0.000 (1000.058 ms): sleep/665955 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 1 }, rmtp: 0x7ffcff002730) = 0
root@number:~# perf trace -e clock_nanosleep -- sleep 1.0000000001
     0.000 (1000.070 ms): sleep/665969 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 1 }, rmtp: 0x7fff91df9de0) = 0
root@number:~# perf trace -e clock_nanosleep -- sleep 1.0000000001
     0.000 (1000.068 ms): sleep/665971 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 1 }, rmtp: 0x7fffe593b0e0) = 0
root@number:~# perf trace -e clock_nanosleep -- sleep 1.0000000001
     0.000 (1000.056 ms): sleep/665973 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 1 }, rmtp: 0x7ffdcf948c80) = 0
root@number:~# perf trace -e clock_nanosleep -- sleep 1.0000000001
     0.000 (1000.057 ms): sleep/665978 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 1 }, rmtp: 0x7fff56af7560) = 0
root@number:~# perf test "perf trace"
108: perf trace enum augmentation tests                              : FAILED!
109: perf trace BTF general tests                                    : Ok
110: perf trace exit race                                            : Ok
111: perf trace record and replay                                    : Ok
137: Check open filename arg using perf trace + vfs_getname          : Ok
138: perf trace summary                                              : Ok
root@number:~# perf test -S "perf trace"
108: perf trace enum augmentation tests                              : FAILED!
109: perf trace BTF general tests                                    : Ok
110: perf trace exit race                                            : Ok
111: perf trace record and replay                                    : Ok
137: Check open filename arg using perf trace + vfs_getname          : FAILED!
138: perf trace summary                                              : Ok
root@number:~# perf test 108
108: perf trace enum augmentation tests                              : FAILED!
root@number:~# perf test -v 108
--- start ---
test child forked, pid 666496
Checking if vmlinux exists
Tracing syscall landlock_add_rule
Tracing non-syscall tracepoint syscall
---- end(-1) ----
108: perf trace enum augmentation tests                              : FAILED!
root@number:~# perf test -vv 108
108: perf trace enum augmentation tests:
--- start ---
test child forked, pid 666512
Checking if vmlinux exists
Tracing syscall landlock_add_rule
Tracing non-syscall tracepoint syscall
---- end(-1) ----
108: perf trace enum augmentation tests                              : FAILED!
root@number:~# perf test -vvv 108
108: perf trace enum augmentation tests:
--- start ---
test child forked, pid 666544
Checking if vmlinux exists
Tracing syscall landlock_add_rule
Tracing non-syscall tracepoint syscall
---- end(-1) ----
108: perf trace enum augmentation tests                              : FAILED!
root@number:~# strace -e landlock_add_rule perf test -vvv 108
108: perf trace enum augmentation tests:
108: perf trace enum augmentation tests                              : Running (1 active)
--- start ---
test child forked, pid 666623
Checking if vmlinux exists
Tracing syscall landlock_add_rule
Tracing non-syscall tracepoint syscall
---- end(-1) ----
108: perf trace enum augmentation tests                              : FAILED!
+++ exited with 0 +++
root@number:~# strace -f -e landlock_add_rule perf test -vvv 108
strace: Process 666728 attached
108: perf trace enum augmentation tests:
108: perf trace enum augmentation tests                              : Running (1 active)
strace: Process 666729 attached
strace: Process 666730 attached
[pid 666730] +++ exited with 0 +++
[pid 666729] --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=666730, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
strace: Process 666731 attached
strace: Process 666732 attached
[pid 666731] +++ exited with 129 +++
[pid 666732] +++ exited with 1 +++
[pid 666729] --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=666731, si_uid=0, si_status=129, si_utime=0, si_stime=0} ---
strace: Process 666733 attached
[pid 666733] +++ exited with 0 +++
[pid 666729] --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=666733, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
strace: Process 666734 attached
[pid 666734] +++ exited with 0 +++
[pid 666729] --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=666734, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
strace: Process 666735 attached
strace: Process 666736 attached
strace: Process 666749 attached
[pid 666749] landlock_add_rule(11, LANDLOCK_RULE_PATH_BENEATH, {allowed_access=LANDLOCK_ACCESS_FS_READ_FILE, parent_fd=14}, 0x2d) = -1 EINVAL (Invalid argument)
[pid 666749] landlock_add_rule(11, LANDLOCK_RULE_NET_PORT, {allowed_access=LANDLOCK_ACCESS_NET_CONNECT_TCP, port=19}, 0x2d) = -1 EINVAL (Invalid argument)
[pid 666749] +++ exited with 0 +++
[pid 666735] --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=666749, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
[pid 666736] +++ exited with 0 +++
[pid 666735] --- SIGPIPE {si_signo=SIGPIPE, si_code=SI_USER, si_pid=666735, si_uid=0} ---
[pid 666735] +++ killed by SIGPIPE +++
[pid 666729] --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=666736, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
strace: Process 666750 attached
strace: Process 666751 attached
strace: Process 666753 attached
[pid 666753] landlock_add_rule(11, LANDLOCK_RULE_PATH_BENEATH, {allowed_access=LANDLOCK_ACCESS_FS_READ_FILE, parent_fd=14}, 0x2d) = -1 EINVAL (Invalid argument)
[pid 666753] landlock_add_rule(11, LANDLOCK_RULE_NET_PORT, {allowed_access=LANDLOCK_ACCESS_NET_CONNECT_TCP, port=19}, 0x2d) = -1 EINVAL (Invalid argument)
[pid 666753] +++ exited with 0 +++
[pid 666750] --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=666753, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
[pid 666751] +++ exited with 0 +++
[pid 666750] +++ exited with 0 +++
[pid 666729] --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=666751, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
strace: Process 666754 attached
strace: Process 666755 attached
[pid 666754] +++ exited with 129 +++
[pid 666755] +++ exited with 1 +++
[pid 666729] --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=666754, si_uid=0, si_status=129, si_utime=0, si_stime=0} ---
[pid 666729] +++ exited with 1 +++
[pid 666728] --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=666729, si_uid=0, si_status=1, si_utime=0, si_stime=0} ---
[pid 666728] +++ exited with 1 +++
--- start ---
test child forked, pid 666728
Checking if vmlinux exists
Tracing syscall landlock_add_rule
Tracing non-syscall tracepoint syscall
---- end(-1) ----
108: perf trace enum augmentation tests                              : FAILED!
+++ exited with 0 +++
root@number:~# 


root@number:~# strace -e clock_nanosleep -- sleep 1
clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=1, tv_nsec=0}, 0x7ffda83143a0) = 0
+++ exited with 0 +++
root@number:~# strace -e clock_nanosleep -- sleep 1
clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=1, tv_nsec=0}, 0x7ffecc3098e0) = 0
+++ exited with 0 +++
root@number:~#

- Arnaldo
