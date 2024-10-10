Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39A718DF9E;
	Thu, 10 Oct 2024 21:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594137; cv=none; b=CQn5E6xuFuS0QuM3/GFiYjMn8seEbfNWjoLfRrxdS93ya/0EmBSfKWIB6LWBjEIueC0jRsAKEZCTIJCq6Glvs+Sbry4UTJTs+NbiBhfr2APLqiL6/eFYQ0w+irVjy7OWRk6wIHtuIrLfyHLa4If8Ucu8qibmxC4oA7x4rG5yFrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594137; c=relaxed/simple;
	bh=+NHzYEkRa0Ks/2w5tly0t67ckyF+u+Rv2DgutwuRGyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXUTfgHI4xD7qF77Bca4AC9XUSOd+lAPbxTbcs1G/ThzkK3XSTOZsqxBH89X1CR1u8JhP+RARhir37CZxRWo3n9wKDEALywJdCAAyxRwwBlLBFv3j9GyG6mzhan2O94O30CXgjrh3QfV9iupNVaENRJkmXRz7EHizbyT788Llrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7fIlqGn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7fIlqGn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1E7C4CEC5;
	Thu, 10 Oct 2024 21:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728594136;
	bh=+NHzYEkRa0Ks/2w5tly0t67ckyF+u+Rv2DgutwuRGyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S7fIlqGnvyu8uQhWa4XufzcQPLLOOWyvW6bw1cRGDyDvBAUtItkbCcBcKcuSqgtEM
	 csW00QaQ6FH5eMJuBp0kPwkD/n7Hmg8AuKz4M2neebfj+NaKqdWHH/O7+AhBh95mSQ
	 GlIPGkv8ON/VirQxVAAJeobWl84IFei3Emrscqh/IBVHz/y9DRw5FySyvjcHnvkxMg
	 i57m5TRAniTz1tueFU6j4WWXd1osF1D8fANjeWrYl8Aon80VImwPX5QUaSW/r22iM5
	 fR1VCAi0LQZTPGInNXoqV5MzcVtsGSTG/f4R8xtDBCe3aeUiIa/cM/kZ+x8Ppta95z
	 gD7BD+yWCwxBA==
Date: Thu, 10 Oct 2024 18:02:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Howard Chu <howardchu95@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH/RFT] Re: [PATCH v5 1/8] perf trace: Fix iteration of
 syscall ids in syscalltbl->entries
Message-ID: <ZwhA1SL706f60ynd@x1>
References: <0f841525-e02a-4e11-b5f8-1acc61979ccf@kernel.org>
 <ZtYJ0z8f-1jwYSbV@x1>
 <c279ad02-2543-4a95-9404-9304e1e704da@kernel.org>
 <ffc2eb09-ac78-4594-a376-3fff9918c2a7@kernel.org>
 <ZwYbQswnGHSstClc@google.com>
 <CAH0uvoi622J7gZ9BoTik7niNH3axVJR0kPNovUQnMjUB6GWLNg@mail.gmail.com>
 <CAH0uvojw5EKqxqETq_H3-5zmjXiK=ew2hBQiPDpCtZmO7=mrKA@mail.gmail.com>
 <3a592835-a14f-40be-8961-c0cee7720a94@kernel.org>
 <ZwgAzde-jVyo4cSu@google.com>
 <ZwgBenahw7EImQLk@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwgBenahw7EImQLk@google.com>

On Thu, Oct 10, 2024 at 09:31:54AM -0700, Namhyung Kim wrote:
> On Thu, Oct 10, 2024 at 09:29:01AM -0700, Namhyung Kim wrote:
> > On Thu, Oct 10, 2024 at 10:22:12AM +0200, Jiri Slaby wrote:
> > > From 3d4f06d79c949a8f155c20652b4f685540899ad4 Mon Sep 17 00:00:00 2001
> > > From: Jiri Slaby <jslaby@suse.cz>
> > > Date: Thu, 10 Oct 2024 09:57:07 +0200
> > > Subject: [PATCH] perf: fix non-listed archs

> > > Suggested-by: Howard Chu <howardchu95@gmail.com>
> > > Signed-off-by: Jiri Slaby <jslaby@suse.cz>

> > Acked-by: Namhyung Kim <namhyung@kernel.org>
 
> Also with,
 
> Fixes: 7a2fb5619cc1fb53 ("perf trace: Fix iteration of syscall ids in syscalltbl->entries")
 
> > Arnaldo, can you please pick this up for v6.12?

Sure, probably the safest bet now, but just in case, Jiri, can you test
the following?

- Arnaldo

From a93dff5b66fb319d700c968de1906a0868a505dc Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Thu, 10 Oct 2024 17:52:19 -0300
Subject: [PATCH 1/1] perf tools arm: Generate syscalltbl.c from arm's
 syscall.tbl
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Just like powerpc that in turn used s390 as its starting point.

With it:

  ⬢[acme@toolbox perf-tools-next]$ tools/perf/arch/arm/entry/syscalls/mksyscalltbl tools/perf/arch/arm/entry/syscalls/syscall.tbl > /tmp/syscall.c
  ⬢[acme@toolbox perf-tools-next]$ cd /tmp
  ⬢[acme@toolbox tmp]$ gcc -g -c syscall.c -o syscall.o
  ⬢[acme@toolbox tmp]$ head syscall.c
  static const char *const syscalltbl_arm[] = {
  	[0] = "restart_syscall",
  	[1] = "exit",
  	[2] = "fork",
  	[3] = "read",
  	[4] = "write",
  	[5] = "open",
  	[6] = "close",
  	[8] = "creat",
  	[9] = "link",
  ⬢[acme@toolbox tmp]$ tail syscall.c
  	[455] = "futex_wait",
  	[456] = "futex_requeue",
  	[457] = "statmount",
  	[458] = "listmount",
  	[459] = "lsm_get_self_attr",
  	[460] = "lsm_set_self_attr",
  	[461] = "lsm_list_modules",
  	[462] = "mseal",
  };
  #define SYSCALLTBL_ARM_MAX_ID 462
  ⬢[acme@toolbox tmp]$
  ⬢[acme@toolbox tmp]$ readelf -wi syscall.o
  Contents of the .debug_info section:

    Compilation Unit @ offset 0:
     Length:        0x65 (32-bit)
     Version:       5
     Unit Type:     DW_UT_compile (1)
     Abbrev Offset: 0
     Pointer Size:  8
   <0><c>: Abbrev Number: 3 (DW_TAG_compile_unit)
      <d>   DW_AT_producer    : (indirect string, offset: 0): GNU C17 14.2.1 20240801 (Red Hat 14.2.1-1) -mtune=generic -march=x86-64 -g
      <11>   DW_AT_language    : 29	(C11)
      <12>   DW_AT_name        : (indirect line string, offset: 0): syscall.c
      <16>   DW_AT_comp_dir    : (indirect line string, offset: 0xa): /tmp
      <1a>   DW_AT_stmt_list   : 0
   <1><1e>: Abbrev Number: 4 (DW_TAG_array_type)
      <1f>   DW_AT_type        : <0x41>
      <23>   DW_AT_sibling     : <0x2f>
   <2><27>: Abbrev Number: 5 (DW_TAG_subrange_type)
      <28>   DW_AT_type        : <0x34>
      <2c>   DW_AT_upper_bound : 462
   <2><2e>: Abbrev Number: 0
   <1><2f>: Abbrev Number: 1 (DW_TAG_const_type)
      <30>   DW_AT_type        : <0x1e>
   <1><34>: Abbrev Number: 2 (DW_TAG_base_type)
      <35>   DW_AT_byte_size   : 8
      <36>   DW_AT_encoding    : 7	(unsigned)
      <37>   DW_AT_name        : (indirect string, offset: 0x4b): long unsigned int
   <1><3b>: Abbrev Number: 6 (DW_TAG_pointer_type)
      <3c>   DW_AT_byte_size   : 8
      <3d>   DW_AT_type        : <0x4d>
   <1><41>: Abbrev Number: 1 (DW_TAG_const_type)
      <42>   DW_AT_type        : <0x3b>
   <1><46>: Abbrev Number: 2 (DW_TAG_base_type)
      <47>   DW_AT_byte_size   : 1
      <48>   DW_AT_encoding    : 6	(signed char)
      <49>   DW_AT_name        : (indirect string, offset: 0x6c): char
   <1><4d>: Abbrev Number: 1 (DW_TAG_const_type)
      <4e>   DW_AT_type        : <0x46>
   <1><52>: Abbrev Number: 7 (DW_TAG_variable)
      <53>   DW_AT_name        : (indirect string, offset: 0x5d): syscalltbl_arm
      <57>   DW_AT_decl_file   : 1
      <58>   DW_AT_decl_line   : 1
      <59>   DW_AT_decl_column : 26
      <5a>   DW_AT_type        : <0x2f>
      <5e>   DW_AT_location    : 9 byte block: 3 20 11 0 0 0 0 0 0 	(DW_OP_addr: 1120)
   <1><68>: Abbrev Number: 0

  ⬢[acme@toolbox tmp]$

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/Makefile                  |  21 +
 .../perf/arch/arm/entry/syscalls/mksyscalltbl |  39 ++
 .../perf/arch/arm/entry/syscalls/syscall.tbl  | 479 ++++++++++++++++++
 tools/perf/check-headers.sh                   |   1 +
 tools/perf/util/syscalltbl.c                  |   4 +
 5 files changed, 544 insertions(+)
 create mode 100755 tools/perf/arch/arm/entry/syscalls/mksyscalltbl
 create mode 100644 tools/perf/arch/arm/entry/syscalls/syscall.tbl

diff --git a/tools/perf/arch/arm/Makefile b/tools/perf/arch/arm/Makefile
index 1d88fdab13bf8f68..7821584340ed48ce 100644
--- a/tools/perf/arch/arm/Makefile
+++ b/tools/perf/arch/arm/Makefile
@@ -3,3 +3,24 @@ ifndef NO_DWARF
 PERF_HAVE_DWARF_REGS := 1
 endif
 PERF_HAVE_JITDUMP := 1
+
+#
+# Syscall table generation for perf
+#
+
+out    := $(OUTPUT)arch/arm/include/generated/asm
+header32 := $(out)/syscalls_32.c
+sysprf := $(srctree)/tools/perf/arch/arm/entry/syscalls
+sysdef := $(sysprf)/syscall.tbl
+systbl := $(sysprf)/mksyscalltbl
+
+# Create output directory if not already present
+$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
+
+$(header32): $(sysdef) $(systbl)
+	$(Q)$(SHELL) '$(systbl)' $(sysdef) > $@
+
+clean::
+	$(call QUIET_CLEAN, arm) $(RM) $(header32)
+
+archheaders: $(header32)
diff --git a/tools/perf/arch/arm/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm/entry/syscalls/mksyscalltbl
new file mode 100755
index 0000000000000000..4489343df0d4d065
--- /dev/null
+++ b/tools/perf/arch/arm/entry/syscalls/mksyscalltbl
@@ -0,0 +1,39 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Generate syscall table for perf for arm 32-bit, derived from:
+#
+# Generate system call table for perf. Derived from
+# s390 script.
+#
+# Copyright IBM Corp. 2017
+# Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
+# Changed by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
+
+SYSCALL_TBL=$1
+
+if ! test -r $SYSCALL_TBL; then
+	echo "Could not read input file" >&2
+	exit 1
+fi
+
+create_table()
+{
+	local max_nr nr abi sc discard
+	max_nr=-1
+	nr=0
+
+	echo "static const char *const syscalltbl_arm[] = {"
+	while read nr abi sc discard; do
+		if [ "$max_nr" -lt "$nr" ]; then
+			printf '\t[%d] = "%s",\n' $nr $sc
+			max_nr=$nr
+		fi
+	done
+	echo '};'
+	echo "#define SYSCALLTBL_ARM_MAX_ID $max_nr"
+}
+
+grep -E "^[[:digit:]]+[[:space:]]+(common|spu|nospu)" $SYSCALL_TBL \
+	|sort -k1 -n                                                           \
+	|create_table
diff --git a/tools/perf/arch/arm/entry/syscalls/syscall.tbl b/tools/perf/arch/arm/entry/syscalls/syscall.tbl
new file mode 100644
index 0000000000000000..23c98203c40fe6b7
--- /dev/null
+++ b/tools/perf/arch/arm/entry/syscalls/syscall.tbl
@@ -0,0 +1,479 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# Linux system call numbers and entry vectors
+#
+# The format is:
+# <num>	<abi>	<name>			[<entry point>			[<oabi compat entry point>]]
+#
+# Where abi is:
+#  common - for system calls shared between oabi and eabi (may have compat)
+#  oabi   - for oabi-only system calls (may have compat)
+#  eabi   - for eabi-only system calls
+#
+# For each syscall number, "common" is mutually exclusive with oabi and eabi
+#
+0	common	restart_syscall		sys_restart_syscall
+1	common	exit			sys_exit
+2	common	fork			sys_fork
+3	common	read			sys_read
+4	common	write			sys_write
+5	common	open			sys_open
+6	common	close			sys_close
+# 7 was sys_waitpid
+8	common	creat			sys_creat
+9	common	link			sys_link
+10	common	unlink			sys_unlink
+11	common	execve			sys_execve
+12	common	chdir			sys_chdir
+13	oabi	time			sys_time32
+14	common	mknod			sys_mknod
+15	common	chmod			sys_chmod
+16	common	lchown			sys_lchown16
+# 17 was sys_break
+# 18 was sys_stat
+19	common	lseek			sys_lseek
+20	common	getpid			sys_getpid
+21	common	mount			sys_mount
+22	oabi	umount			sys_oldumount
+23	common	setuid			sys_setuid16
+24	common	getuid			sys_getuid16
+25	oabi	stime			sys_stime32
+26	common	ptrace			sys_ptrace
+27	oabi	alarm			sys_alarm
+# 28 was sys_fstat
+29	common	pause			sys_pause
+30	oabi	utime			sys_utime32
+# 31 was sys_stty
+# 32 was sys_gtty
+33	common	access			sys_access
+34	common	nice			sys_nice
+# 35 was sys_ftime
+36	common	sync			sys_sync
+37	common	kill			sys_kill
+38	common	rename			sys_rename
+39	common	mkdir			sys_mkdir
+40	common	rmdir			sys_rmdir
+41	common	dup			sys_dup
+42	common	pipe			sys_pipe
+43	common	times			sys_times
+# 44 was sys_prof
+45	common	brk			sys_brk
+46	common	setgid			sys_setgid16
+47	common	getgid			sys_getgid16
+# 48 was sys_signal
+49	common	geteuid			sys_geteuid16
+50	common	getegid			sys_getegid16
+51	common	acct			sys_acct
+52	common	umount2			sys_umount
+# 53 was sys_lock
+54	common	ioctl			sys_ioctl
+55	common	fcntl			sys_fcntl
+# 56 was sys_mpx
+57	common	setpgid			sys_setpgid
+# 58 was sys_ulimit
+# 59 was sys_olduname
+60	common	umask			sys_umask
+61	common	chroot			sys_chroot
+62	common	ustat			sys_ustat
+63	common	dup2			sys_dup2
+64	common	getppid			sys_getppid
+65	common	getpgrp			sys_getpgrp
+66	common	setsid			sys_setsid
+67	common	sigaction		sys_sigaction
+# 68 was sys_sgetmask
+# 69 was sys_ssetmask
+70	common	setreuid		sys_setreuid16
+71	common	setregid		sys_setregid16
+72	common	sigsuspend		sys_sigsuspend
+73	common	sigpending		sys_sigpending
+74	common	sethostname		sys_sethostname
+75	common	setrlimit		sys_setrlimit
+# Back compat 2GB limited rlimit
+76	oabi	getrlimit		sys_old_getrlimit
+77	common	getrusage		sys_getrusage
+78	common	gettimeofday		sys_gettimeofday
+79	common	settimeofday		sys_settimeofday
+80	common	getgroups		sys_getgroups16
+81	common	setgroups		sys_setgroups16
+82	oabi	select			sys_old_select
+83	common	symlink			sys_symlink
+# 84 was sys_lstat
+85	common	readlink		sys_readlink
+86	common	uselib			sys_uselib
+87	common	swapon			sys_swapon
+88	common	reboot			sys_reboot
+89	oabi	readdir			sys_old_readdir
+90	oabi	mmap			sys_old_mmap
+91	common	munmap			sys_munmap
+92	common	truncate		sys_truncate
+93	common	ftruncate		sys_ftruncate
+94	common	fchmod			sys_fchmod
+95	common	fchown			sys_fchown16
+96	common	getpriority		sys_getpriority
+97	common	setpriority		sys_setpriority
+# 98 was sys_profil
+99	common	statfs			sys_statfs
+100	common	fstatfs			sys_fstatfs
+# 101 was sys_ioperm
+102	oabi	socketcall		sys_socketcall		sys_oabi_socketcall
+103	common	syslog			sys_syslog
+104	common	setitimer		sys_setitimer
+105	common	getitimer		sys_getitimer
+106	common	stat			sys_newstat
+107	common	lstat			sys_newlstat
+108	common	fstat			sys_newfstat
+# 109 was sys_uname
+# 110 was sys_iopl
+111	common	vhangup			sys_vhangup
+# 112 was sys_idle
+# syscall to call a syscall!
+113	oabi	syscall			sys_syscall
+114	common	wait4			sys_wait4
+115	common	swapoff			sys_swapoff
+116	common	sysinfo			sys_sysinfo
+117	oabi	ipc			sys_ipc			sys_oabi_ipc
+118	common	fsync			sys_fsync
+119	common	sigreturn		sys_sigreturn_wrapper
+120	common	clone			sys_clone
+121	common	setdomainname		sys_setdomainname
+122	common	uname			sys_newuname
+# 123 was sys_modify_ldt
+124	common	adjtimex		sys_adjtimex_time32
+125	common	mprotect		sys_mprotect
+126	common	sigprocmask		sys_sigprocmask
+# 127 was sys_create_module
+128	common	init_module		sys_init_module
+129	common	delete_module		sys_delete_module
+# 130 was sys_get_kernel_syms
+131	common	quotactl		sys_quotactl
+132	common	getpgid			sys_getpgid
+133	common	fchdir			sys_fchdir
+134	common	bdflush			sys_ni_syscall
+135	common	sysfs			sys_sysfs
+136	common	personality		sys_personality
+# 137 was sys_afs_syscall
+138	common	setfsuid		sys_setfsuid16
+139	common	setfsgid		sys_setfsgid16
+140	common	_llseek			sys_llseek
+141	common	getdents		sys_getdents
+142	common	_newselect		sys_select
+143	common	flock			sys_flock
+144	common	msync			sys_msync
+145	common	readv			sys_readv
+146	common	writev			sys_writev
+147	common	getsid			sys_getsid
+148	common	fdatasync		sys_fdatasync
+149	common	_sysctl			sys_ni_syscall
+150	common	mlock			sys_mlock
+151	common	munlock			sys_munlock
+152	common	mlockall		sys_mlockall
+153	common	munlockall		sys_munlockall
+154	common	sched_setparam		sys_sched_setparam
+155	common	sched_getparam		sys_sched_getparam
+156	common	sched_setscheduler	sys_sched_setscheduler
+157	common	sched_getscheduler	sys_sched_getscheduler
+158	common	sched_yield		sys_sched_yield
+159	common	sched_get_priority_max	sys_sched_get_priority_max
+160	common	sched_get_priority_min	sys_sched_get_priority_min
+161	common	sched_rr_get_interval	sys_sched_rr_get_interval_time32
+162	common	nanosleep		sys_nanosleep_time32
+163	common	mremap			sys_mremap
+164	common	setresuid		sys_setresuid16
+165	common	getresuid		sys_getresuid16
+# 166 was sys_vm86
+# 167 was sys_query_module
+168	common	poll			sys_poll
+169	common	nfsservctl
+170	common	setresgid		sys_setresgid16
+171	common	getresgid		sys_getresgid16
+172	common	prctl			sys_prctl
+173	common	rt_sigreturn		sys_rt_sigreturn_wrapper
+174	common	rt_sigaction		sys_rt_sigaction
+175	common	rt_sigprocmask		sys_rt_sigprocmask
+176	common	rt_sigpending		sys_rt_sigpending
+177	common	rt_sigtimedwait		sys_rt_sigtimedwait_time32
+178	common	rt_sigqueueinfo		sys_rt_sigqueueinfo
+179	common	rt_sigsuspend		sys_rt_sigsuspend
+180	common	pread64			sys_pread64		sys_oabi_pread64
+181	common	pwrite64		sys_pwrite64		sys_oabi_pwrite64
+182	common	chown			sys_chown16
+183	common	getcwd			sys_getcwd
+184	common	capget			sys_capget
+185	common	capset			sys_capset
+186	common	sigaltstack		sys_sigaltstack
+187	common	sendfile		sys_sendfile
+# 188 reserved
+# 189 reserved
+190	common	vfork			sys_vfork
+# SuS compliant getrlimit
+191	common	ugetrlimit		sys_getrlimit
+192	common	mmap2			sys_mmap2
+193	common	truncate64		sys_truncate64		sys_oabi_truncate64
+194	common	ftruncate64		sys_ftruncate64		sys_oabi_ftruncate64
+195	common	stat64			sys_stat64		sys_oabi_stat64
+196	common	lstat64			sys_lstat64		sys_oabi_lstat64
+197	common	fstat64			sys_fstat64		sys_oabi_fstat64
+198	common	lchown32		sys_lchown
+199	common	getuid32		sys_getuid
+200	common	getgid32		sys_getgid
+201	common	geteuid32		sys_geteuid
+202	common	getegid32		sys_getegid
+203	common	setreuid32		sys_setreuid
+204	common	setregid32		sys_setregid
+205	common	getgroups32		sys_getgroups
+206	common	setgroups32		sys_setgroups
+207	common	fchown32		sys_fchown
+208	common	setresuid32		sys_setresuid
+209	common	getresuid32		sys_getresuid
+210	common	setresgid32		sys_setresgid
+211	common	getresgid32		sys_getresgid
+212	common	chown32			sys_chown
+213	common	setuid32		sys_setuid
+214	common	setgid32		sys_setgid
+215	common	setfsuid32		sys_setfsuid
+216	common	setfsgid32		sys_setfsgid
+217	common	getdents64		sys_getdents64
+218	common	pivot_root		sys_pivot_root
+219	common	mincore			sys_mincore
+220	common	madvise			sys_madvise
+221	common	fcntl64			sys_fcntl64		sys_oabi_fcntl64
+# 222 for tux
+# 223 is unused
+224	common	gettid			sys_gettid
+225	common	readahead		sys_readahead		sys_oabi_readahead
+226	common	setxattr		sys_setxattr
+227	common	lsetxattr		sys_lsetxattr
+228	common	fsetxattr		sys_fsetxattr
+229	common	getxattr		sys_getxattr
+230	common	lgetxattr		sys_lgetxattr
+231	common	fgetxattr		sys_fgetxattr
+232	common	listxattr		sys_listxattr
+233	common	llistxattr		sys_llistxattr
+234	common	flistxattr		sys_flistxattr
+235	common	removexattr		sys_removexattr
+236	common	lremovexattr		sys_lremovexattr
+237	common	fremovexattr		sys_fremovexattr
+238	common	tkill			sys_tkill
+239	common	sendfile64		sys_sendfile64
+240	common	futex			sys_futex_time32
+241	common	sched_setaffinity	sys_sched_setaffinity
+242	common	sched_getaffinity	sys_sched_getaffinity
+243	common	io_setup		sys_io_setup
+244	common	io_destroy		sys_io_destroy
+245	common	io_getevents		sys_io_getevents_time32
+246	common	io_submit		sys_io_submit
+247	common	io_cancel		sys_io_cancel
+248	common	exit_group		sys_exit_group
+249	common	lookup_dcookie		sys_ni_syscall
+250	common	epoll_create		sys_epoll_create
+251	common	epoll_ctl		sys_epoll_ctl		sys_oabi_epoll_ctl
+252	common	epoll_wait		sys_epoll_wait
+253	common	remap_file_pages	sys_remap_file_pages
+# 254 for set_thread_area
+# 255 for get_thread_area
+256	common	set_tid_address		sys_set_tid_address
+257	common	timer_create		sys_timer_create
+258	common	timer_settime		sys_timer_settime32
+259	common	timer_gettime		sys_timer_gettime32
+260	common	timer_getoverrun	sys_timer_getoverrun
+261	common	timer_delete		sys_timer_delete
+262	common	clock_settime		sys_clock_settime32
+263	common	clock_gettime		sys_clock_gettime32
+264	common	clock_getres		sys_clock_getres_time32
+265	common	clock_nanosleep		sys_clock_nanosleep_time32
+266	common	statfs64		sys_statfs64_wrapper
+267	common	fstatfs64		sys_fstatfs64_wrapper
+268	common	tgkill			sys_tgkill
+269	common	utimes			sys_utimes_time32
+270	common	arm_fadvise64_64	sys_arm_fadvise64_64
+271	common	pciconfig_iobase	sys_pciconfig_iobase
+272	common	pciconfig_read		sys_pciconfig_read
+273	common	pciconfig_write		sys_pciconfig_write
+274	common	mq_open			sys_mq_open
+275	common	mq_unlink		sys_mq_unlink
+276	common	mq_timedsend		sys_mq_timedsend_time32
+277	common	mq_timedreceive		sys_mq_timedreceive_time32
+278	common	mq_notify		sys_mq_notify
+279	common	mq_getsetattr		sys_mq_getsetattr
+280	common	waitid			sys_waitid
+281	common	socket			sys_socket
+282	common	bind			sys_bind		sys_oabi_bind
+283	common	connect			sys_connect		sys_oabi_connect
+284	common	listen			sys_listen
+285	common	accept			sys_accept
+286	common	getsockname		sys_getsockname
+287	common	getpeername		sys_getpeername
+288	common	socketpair		sys_socketpair
+289	common	send			sys_send
+290	common	sendto			sys_sendto		sys_oabi_sendto
+291	common	recv			sys_recv
+292	common	recvfrom		sys_recvfrom
+293	common	shutdown		sys_shutdown
+294	common	setsockopt		sys_setsockopt
+295	common	getsockopt		sys_getsockopt
+296	common	sendmsg			sys_sendmsg		sys_oabi_sendmsg
+297	common	recvmsg			sys_recvmsg
+298	common	semop			sys_semop		sys_oabi_semop
+299	common	semget			sys_semget
+300	common	semctl			sys_old_semctl
+301	common	msgsnd			sys_msgsnd
+302	common	msgrcv			sys_msgrcv
+303	common	msgget			sys_msgget
+304	common	msgctl			sys_old_msgctl
+305	common	shmat			sys_shmat
+306	common	shmdt			sys_shmdt
+307	common	shmget			sys_shmget
+308	common	shmctl			sys_old_shmctl
+309	common	add_key			sys_add_key
+310	common	request_key		sys_request_key
+311	common	keyctl			sys_keyctl
+312	common	semtimedop		sys_semtimedop_time32	sys_oabi_semtimedop
+313	common	vserver
+314	common	ioprio_set		sys_ioprio_set
+315	common	ioprio_get		sys_ioprio_get
+316	common	inotify_init		sys_inotify_init
+317	common	inotify_add_watch	sys_inotify_add_watch
+318	common	inotify_rm_watch	sys_inotify_rm_watch
+319	common	mbind			sys_mbind
+320	common	get_mempolicy		sys_get_mempolicy
+321	common	set_mempolicy		sys_set_mempolicy
+322	common	openat			sys_openat
+323	common	mkdirat			sys_mkdirat
+324	common	mknodat			sys_mknodat
+325	common	fchownat		sys_fchownat
+326	common	futimesat		sys_futimesat_time32
+327	common	fstatat64		sys_fstatat64		sys_oabi_fstatat64
+328	common	unlinkat		sys_unlinkat
+329	common	renameat		sys_renameat
+330	common	linkat			sys_linkat
+331	common	symlinkat		sys_symlinkat
+332	common	readlinkat		sys_readlinkat
+333	common	fchmodat		sys_fchmodat
+334	common	faccessat		sys_faccessat
+335	common	pselect6		sys_pselect6_time32
+336	common	ppoll			sys_ppoll_time32
+337	common	unshare			sys_unshare
+338	common	set_robust_list		sys_set_robust_list
+339	common	get_robust_list		sys_get_robust_list
+340	common	splice			sys_splice
+341	common	arm_sync_file_range	sys_sync_file_range2
+342	common	tee			sys_tee
+343	common	vmsplice		sys_vmsplice
+344	common	move_pages		sys_move_pages
+345	common	getcpu			sys_getcpu
+346	common	epoll_pwait		sys_epoll_pwait
+347	common	kexec_load		sys_kexec_load
+348	common	utimensat		sys_utimensat_time32
+349	common	signalfd		sys_signalfd
+350	common	timerfd_create		sys_timerfd_create
+351	common	eventfd			sys_eventfd
+352	common	fallocate		sys_fallocate
+353	common	timerfd_settime		sys_timerfd_settime32
+354	common	timerfd_gettime		sys_timerfd_gettime32
+355	common	signalfd4		sys_signalfd4
+356	common	eventfd2		sys_eventfd2
+357	common	epoll_create1		sys_epoll_create1
+358	common	dup3			sys_dup3
+359	common	pipe2			sys_pipe2
+360	common	inotify_init1		sys_inotify_init1
+361	common	preadv			sys_preadv
+362	common	pwritev			sys_pwritev
+363	common	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo
+364	common	perf_event_open		sys_perf_event_open
+365	common	recvmmsg		sys_recvmmsg_time32
+366	common	accept4			sys_accept4
+367	common	fanotify_init		sys_fanotify_init
+368	common	fanotify_mark		sys_fanotify_mark
+369	common	prlimit64		sys_prlimit64
+370	common	name_to_handle_at	sys_name_to_handle_at
+371	common	open_by_handle_at	sys_open_by_handle_at
+372	common	clock_adjtime		sys_clock_adjtime32
+373	common	syncfs			sys_syncfs
+374	common	sendmmsg		sys_sendmmsg
+375	common	setns			sys_setns
+376	common	process_vm_readv	sys_process_vm_readv
+377	common	process_vm_writev	sys_process_vm_writev
+378	common	kcmp			sys_kcmp
+379	common	finit_module		sys_finit_module
+380	common	sched_setattr		sys_sched_setattr
+381	common	sched_getattr		sys_sched_getattr
+382	common	renameat2		sys_renameat2
+383	common	seccomp			sys_seccomp
+384	common	getrandom		sys_getrandom
+385	common	memfd_create		sys_memfd_create
+386	common	bpf			sys_bpf
+387	common	execveat		sys_execveat
+388	common	userfaultfd		sys_userfaultfd
+389	common	membarrier		sys_membarrier
+390	common	mlock2			sys_mlock2
+391	common	copy_file_range		sys_copy_file_range
+392	common	preadv2			sys_preadv2
+393	common	pwritev2		sys_pwritev2
+394	common	pkey_mprotect		sys_pkey_mprotect
+395	common	pkey_alloc		sys_pkey_alloc
+396	common	pkey_free		sys_pkey_free
+397	common	statx			sys_statx
+398	common	rseq			sys_rseq
+399	common	io_pgetevents		sys_io_pgetevents_time32
+400	common	migrate_pages		sys_migrate_pages
+401	common	kexec_file_load		sys_kexec_file_load
+# 402 is unused
+403	common	clock_gettime64			sys_clock_gettime
+404	common	clock_settime64			sys_clock_settime
+405	common	clock_adjtime64			sys_clock_adjtime
+406	common	clock_getres_time64		sys_clock_getres
+407	common	clock_nanosleep_time64		sys_clock_nanosleep
+408	common	timer_gettime64			sys_timer_gettime
+409	common	timer_settime64			sys_timer_settime
+410	common	timerfd_gettime64		sys_timerfd_gettime
+411	common	timerfd_settime64		sys_timerfd_settime
+412	common	utimensat_time64		sys_utimensat
+413	common	pselect6_time64			sys_pselect6
+414	common	ppoll_time64			sys_ppoll
+416	common	io_pgetevents_time64		sys_io_pgetevents
+417	common	recvmmsg_time64			sys_recvmmsg
+418	common	mq_timedsend_time64		sys_mq_timedsend
+419	common	mq_timedreceive_time64		sys_mq_timedreceive
+420	common	semtimedop_time64		sys_semtimedop
+421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
+422	common	futex_time64			sys_futex
+423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
+428	common	open_tree			sys_open_tree
+429	common	move_mount			sys_move_mount
+430	common	fsopen				sys_fsopen
+431	common	fsconfig			sys_fsconfig
+432	common	fsmount				sys_fsmount
+433	common	fspick				sys_fspick
+434	common	pidfd_open			sys_pidfd_open
+435	common	clone3				sys_clone3
+436	common	close_range			sys_close_range
+437	common	openat2				sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	faccessat2			sys_faccessat2
+440	common	process_madvise			sys_process_madvise
+441	common	epoll_pwait2			sys_epoll_pwait2
+442	common	mount_setattr			sys_mount_setattr
+443	common	quotactl_fd			sys_quotactl_fd
+444	common	landlock_create_ruleset		sys_landlock_create_ruleset
+445	common	landlock_add_rule		sys_landlock_add_rule
+446	common	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	common	process_mrelease		sys_process_mrelease
+449	common	futex_waitv			sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
+452	common	fchmodat2			sys_fchmodat2
+453	common	map_shadow_stack		sys_map_shadow_stack
+454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
+457	common	statmount			sys_statmount
+458	common	listmount			sys_listmount
+459	common	lsm_get_self_attr		sys_lsm_get_self_attr
+460	common	lsm_set_self_attr		sys_lsm_set_self_attr
+461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal				sys_mseal
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 714c78e5da07c163..d894f4389a8fc697 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -172,6 +172,7 @@ check lib/ctype.c		      '-I "^EXPORT_SYMBOL" -I "^#include <linux/export.h>" -B
 check lib/list_sort.c		      '-I "^#include <linux/bug.h>"'
 
 # diff non-symmetric files
+check_2 tools/perf/arch/arm/entry/syscalls/syscall.tbl arch/arm/tools/syscall.tbl
 check_2 tools/perf/arch/x86/entry/syscalls/syscall_32.tbl arch/x86/entry/syscalls/syscall_32.tbl
 check_2 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
 check_2 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 7c15dec6900d8aaa..737544525c47b894 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -38,6 +38,10 @@ static const char *const *syscalltbl_native = syscalltbl_powerpc_32;
 #include <asm/syscalls.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_ARM64_MAX_ID;
 static const char *const *syscalltbl_native = syscalltbl_arm64;
+#elif defined(__arm__)
+#include <asm/syscalls.c>
+const int syscalltbl_native_max_id = SYSCALLTBL_ARM_MAX_ID;
+static const char *const *syscalltbl_native = syscalltbl_arm;
 #elif defined(__mips__)
 #include <asm/syscalls_n64.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_MIPS_N64_MAX_ID;
-- 
2.46.0

