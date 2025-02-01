Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6130114AD29
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Feb 2025 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738394126; cv=none; b=gA+MUhZ5hWgbfTwbejXDc0DsmKbWsLgN7vjCUMHv3eNM/vpO4fCH97nED0qSFdd8UhE6hjuqnGHo1D2Pi7LnywuE4DnQVJpZVeeFAEGYX2wGRHMgAamJ+ouVQGA8xN2/D6PxGmMui4b89Kt9H++fJVg9UoWbQe2sser62kbe/Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738394126; c=relaxed/simple;
	bh=Df+4jgYNlZrpFiDfV+Rbyn080VB763baXMaDwlUZzWw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Uyi6UQc410qxuFr6t5GUrl71kKaxNri4kwlreuwS6rA6xATZrv2FzOqnzr5L5IqFeIjBO2pq4+vyol7W5LcCL+dorLcvLjbbZWF93MgJcP7fDtJfWdcMcjZcJPm4YzSPqcdvMBdcjFKbIvdpIU5Ex/vvoeOeTpBpyz6GObsh1Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RCPHdXC0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RCPHdXC0"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f46ad8a390so25340707b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 31 Jan 2025 23:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738394122; x=1738998922; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2p4BgBlwJg7VuXE9RH9vyknGo38+Elq2Bwl6+1TcLc=;
        b=RCPHdXC0a5YpH5YWeK4HMJYdrMe4tiMVI71xt31I5d9KYGyQTiP7gS1BV3TekVav+S
         Rkq0S1WYuh8z9BDqVThaJOXC0Ham2DmYILlIiKMLs9y6qx6NacoDlfImCbJ3URiXJg7w
         Xrzam+vLFNPzdxbHLbyZSUkEQkqLpJLLYAyg8Som2TNdSTF5m0o5Rg4IsFPGbnfr7yE7
         +chOcraCIgh7y0S5ZrNGnlcLDjhpQnArdzONPvRxU6Oi35d+Q8x+uN2NAxk20ZcieRYL
         Ck8tbotNuDwP4g8mLJpeOdcEX+Th+IjqvkGSGXcvkbq8Nh3yfa5yb+0LMHsa6GwYMRFC
         wWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738394122; x=1738998922;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n2p4BgBlwJg7VuXE9RH9vyknGo38+Elq2Bwl6+1TcLc=;
        b=fyciCZFJY60Uh/n96DY2nyvfsxnmX50U4UwK9mamQ2I4ZRCWyj+QfYHGGcC2URaPxe
         GbXKgRNlZfp36fFtCR7N+BVKGpT0MqbAzyV78FXKMUSyHtSZrwcLmZAv8nmDoqi/Z4xE
         1Xx0jaLFQrnyv04aXG6iEIvJHH/C+rwz/xPFv17s3LzVRb3Qg8ci8E46Wzjg7p1k6Ivg
         ZtpfTaFv9njEK4cozASfhNJqz2N9BuTSGsTCV89/kvexJkNMOw6L5cE4KXEiW6fh7Egk
         KQisNPxVSmxPLKHX99dVnX6XLVTYFDXOadTY4HKA5Id00Li8YJW6JzxKlonykSFztiN0
         PUpA==
X-Forwarded-Encrypted: i=1; AJvYcCVQAn/gzpPOfyIqljN+rrdlFwjRg3agn7aviYcD1GHmmoPoJwi1KdNfCGHxfFBj2GHkwai7gJyl4nbh2RTXpfpj@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz1rz4dwJNfiURLP74j1uqcYxDA0D7q1pwa6NnCmMdZ17JIXYR
	Vhk4Lt0pwDLMO+e+Vc+uVqfrZQK3Wo1CN7MNEjn+JOtIX5rtZwx1h/bJ4xpa80ltorJa5tKPeGU
	NkeNXBw==
X-Google-Smtp-Source: AGHT+IEK39TIsn0m3MP/5oNb4U2nd1MWIlCQZVSl/E90OW64f8W0hXi4MQLMdrwvLzordeaL0lFrwurIdZ/O
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:de26:87db:e4d0:62b6])
 (user=irogers job=sendgmr) by 2002:a05:690c:b82:b0:6ef:94b3:730b with SMTP id
 00721157ae682-6f7a845d709mr396727b3.7.1738394122344; Fri, 31 Jan 2025
 23:15:22 -0800 (PST)
Date: Fri, 31 Jan 2025 23:14:54 -0800
In-Reply-To: <20250201071455.718247-1-irogers@google.com>
Message-Id: <20250201071455.718247-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201071455.718247-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Subject: [PATCH v1 6/7] perf syscalltbl: Use lookup table containing multiple architectures
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@rivosinc.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Switch to use the lookup table containing all architectures rather
than tables matching the perf binary.

This fixes perf trace when executed on a 32-bit i386 binary on an
x86-64 machine. Note in the following the system call names of the
32-bit i386 binary as seen by an x86-64 perf.

Before:
```
         ? (         ): a.out/447296  ... [continued]: munmap())           =
                                =3D 0
     0.024 ( 0.001 ms): a.out/447296 recvfrom(ubuf: 0x2, size: 4160585708, =
flags: DONTROUTE|CTRUNC|TRUNC|DONTWAIT|EOR|WAITALL|FIN|SYN|CONFIRM|RST|ERRQ=
UEUE|NOSIGNAL|WAITFORONE|BATCH|SOCK_DEVMEM|ZEROCOPY|FASTOPEN|CMSG_CLOEXEC|0=
x91f80000, addr: 0xe30, addr_len: 0xffce438c) =3D 1475198976
     0.042 ( 0.003 ms): a.out/447296 lgetxattr(name: "", value: 0x3, size: =
34)                             =3D 4160344064
     0.054 ( 0.003 ms): a.out/447296 dup2(oldfd: -134422744, newfd: 4)     =
                                =3D -1 ENOENT (No such file or directory)
     0.060 ( 0.009 ms): a.out/447296 preadv(fd: 4294967196, vec: (struct io=
vec){.iov_base =3D (void *)0x2e646c2f6374652f,.iov_len =3D (__kernel_size_t=
)7307199665335594867,}, vlen: 557056, pos_h: 4160585708) =3D 3
     0.074 ( 0.004 ms): a.out/447296 lgetxattr(name: "", value: 0x1, size: =
2)                              =3D 4160237568
     0.080 ( 0.001 ms): a.out/447296 lstat(filename: "", statbuf: 0x193f6) =
                                =3D 0
     0.089 ( 0.007 ms): a.out/447296 preadv(fd: 4294967196, vec: (struct io=
vec){.iov_base =3D (void *)0x3833692f62696c2f,.iov_len =3D (__kernel_size_t=
)3276497845987585334,}, vlen: 557056, pos_h: 4160585708) =3D 3
     0.097 ( 0.002 ms): a.out/447296 close(fd: 3</proc/447296/status>)     =
                                =3D 512
     0.103 ( 0.002 ms): a.out/447296 lgetxattr(name: "", value: 0x1, size: =
2050)                           =3D 4157935616
     0.107 ( 0.007 ms): a.out/447296 lgetxattr(pathname: "", name: "", valu=
e: 0x5, size: 2066)             =3D 4158078976
     0.116 ( 0.003 ms): a.out/447296 lgetxattr(pathname: "", name: "", valu=
e: 0x1, size: 2066)             =3D 4159639552
     0.121 ( 0.003 ms): a.out/447296 lgetxattr(pathname: "", name: "", valu=
e: 0x3, size: 2066)             =3D 4160184320
     0.129 ( 0.002 ms): a.out/447296 lgetxattr(pathname: "", name: "", valu=
e: 0x3, size: 50)               =3D 4160196608
     0.138 ( 0.001 ms): a.out/447296 lstat(filename: "")                   =
                                =3D 0
     0.145 ( 0.002 ms): a.out/447296 mq_timedreceive(mqdes: 4291706800, u_m=
sg_ptr: 0xf7f9ea48, msg_len: 134616640, u_msg_prio: 0xf7fd7fec, u_abs_timeo=
ut: (struct __kernel_timespec){.tv_sec =3D (__kernel_time64_t)-578174027777=
317696,.tv_nsec =3D (long long int)4160349376,}) =3D 0
     0.148 ( 0.001 ms): a.out/447296 mkdirat(dfd: -134617816, pathname: " =
=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD=E2=96=92=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=E2=96=92=EF=BF=BD=EF=BF=BD=EF=BF=BD", mode: IFREG|ISUID|=
IRUSR|IWGRP|0xf7fd0000) =3D 447296
     0.150 ( 0.001 ms): a.out/447296 process_vm_writev(pid: -134617812, lve=
c: (struct iovec){.iov_base =3D (void *)0xf7f9e9c8f7f9e4c0,.iov_len =3D (__=
kernel_size_t)4160349376,}, liovcnt: 4160588048, rvec: (struct iovec){}, ri=
ovcnt: 4160585708, flags: 4291707352) =3D 0
     0.197 ( 0.004 ms): a.out/447296 capget(header: 4160184320, dataptr: 81=
92)                             =3D 0
     0.202 ( 0.002 ms): a.out/447296 capget(header: 1448669184, dataptr: 40=
96)                             =3D 0
     0.208 ( 0.002 ms): a.out/447296 capget(header: 4160577536, dataptr: 81=
92)                             =3D 0
     0.220 ( 0.001 ms): a.out/447296 getxattr(pathname: "", name: "c=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD", value: 0xf7f77e34, size:=
 1)  =3D 0
     0.228 ( 0.005 ms): a.out/447296 fchmod(fd: -134729728, mode: IRUGO|IWU=
GO|IFREG|IFIFO|ISVTX|IXUSR|0x10000) =3D 0
     0.240 ( 0.009 ms): a.out/447296 preadv(fd: 4294967196, vec: 0x5658e008=
, pos_h: 4160192052)            =3D 3
     0.250 ( 0.008 ms): a.out/447296 close(fd: 3</proc/447296/status>)     =
                                =3D 1436
     0.260 ( 0.018 ms): a.out/447296 stat(filename: "", statbuf: 0xffce32ac=
)                               =3D 1436
     0.288 (1000.213 ms): a.out/447296 readlinkat(buf: 0xffce31d4, bufsiz: =
4291703244)                       =3D 0
```

After:
```
         ? (         ): a.out/442930  ... [continued]: execve())           =
                                =3D 0
     0.023 ( 0.002 ms): a.out/442930 brk()                                 =
                                =3D 0x57760000
     0.052 ( 0.003 ms): a.out/442930 access(filename: 0xf7f5af28, mode: R) =
                                =3D -1 ENOENT (No such file or directory)
     0.059 ( 0.009 ms): a.out/442930 openat(dfd: CWD, filename: "/etc/ld.so=
.cache", flags: RDONLY|CLOEXEC|LARGEFILE) =3D 3
     0.078 ( 0.001 ms): a.out/442930 close(fd: 3</proc/442930/status>)     =
                                =3D 0
     0.087 ( 0.007 ms): a.out/442930 openat(dfd: CWD, filename: "/lib/i386-=
linux-", flags: RDONLY|CLOEXEC|LARGEFILE) =3D 3
     0.095 ( 0.002 ms): a.out/442930 read(fd: 3</proc/442930/status>, buf: =
0xffbdbb70, count: 512)         =3D 512
     0.135 ( 0.001 ms): a.out/442930 close(fd: 3</proc/442930/status>)     =
                                =3D 0
     0.148 ( 0.001 ms): a.out/442930 set_tid_address(tidptr: 0xf7f2b528)   =
                                =3D 442930 (a.out)
     0.150 ( 0.001 ms): a.out/442930 set_robust_list(head: 0xf7f2b52c, len:=
 12)                            =3D
     0.196 ( 0.004 ms): a.out/442930 mprotect(start: 0xf7f03000, len: 8192,=
 prot: READ)                    =3D 0
     0.202 ( 0.002 ms): a.out/442930 mprotect(start: 0x5658e000, len: 4096,=
 prot: READ)                    =3D 0
     0.207 ( 0.002 ms): a.out/442930 mprotect(start: 0xf7f63000, len: 8192,=
 prot: READ)                    =3D 0
     0.230 ( 0.005 ms): a.out/442930 munmap(addr: 0xf7f10000, len: 103414) =
                                =3D 0
     0.244 ( 0.010 ms): a.out/442930 openat(dfd: CWD, filename: 0x5658d008)=
                                =3D 3
     0.255 ( 0.007 ms): a.out/442930 read(fd: 3</proc/442930/status>, buf: =
0xffbdb67c, count: 4096)        =3D 1436
     0.264 ( 0.018 ms): a.out/442930 write(fd: 1</dev/pts/4>, buf: , count:=
 1436)                          =3D 1436
     0.292 (1000.173 ms): a.out/442930 clock_nanosleep(rqtp: { .tv_sec: 178=
66546940376776704, .tv_nsec: 4159878336 }, rmtp: 0xffbdb59c) =3D 0
  1000.478 (         ): a.out/442930 exit_group()                          =
                                =3D ?
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/syscalltbl.c | 89 ++++++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 760ac4d0869f..572083ba1efe 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -15,16 +15,39 @@
 #include <string.h>
 #include "string2.h"
=20
-#if __BITS_PER_LONG =3D=3D 64
-  #include <asm/syscalls_64.h>
-#else
-  #include <asm/syscalls_32.h>
-#endif
+#include "trace/beauty/generated/syscalltbl.c"
=20
-const char *syscalltbl__name(int e_machine __maybe_unused, int id)
+static const struct syscalltbl *find_table(int e_machine)
 {
-	if (id >=3D 0 && id <=3D (int)ARRAY_SIZE(syscall_num_to_name))
-		return syscall_num_to_name[id];
+	static const struct syscalltbl *last_table;
+	static int last_table_machine =3D EM_NONE;
+
+	/* Tables only exist for EM_SPARC. */
+	if (e_machine =3D=3D EM_SPARCV9)
+		e_machine =3D EM_SPARC;
+
+	if (last_table_machine =3D=3D e_machine && e_machine !=3D EM_NONE)
+		return last_table;
+
+	for (size_t i =3D 0; i < ARRAY_SIZE(syscalltbls); i++) {
+		const struct syscalltbl *entry =3D &syscalltbls[i];
+
+		if (entry->e_machine !=3D e_machine && entry->e_machine !=3D EM_NONE)
+			continue;
+
+		last_table =3D entry;
+		last_table_machine =3D e_machine;
+		return entry;
+	}
+	return NULL;
+}
+
+const char *syscalltbl__name(int e_machine, int id)
+{
+	const struct syscalltbl *table =3D find_table(e_machine);
+
+	if (table && id >=3D 0 && id < table->num_to_name_len)
+		return table->num_to_name[id];
 	return NULL;
 }
=20
@@ -41,38 +64,54 @@ static int syscallcmpname(const void *vkey, const void =
*ventry)
 	return strcmp(key->name, key->tbl[*entry]);
 }
=20
-int syscalltbl__id(int e_machine __maybe_unused, const char *name)
+int syscalltbl__id(int e_machine, const char *name)
 {
-	struct syscall_cmp_key key =3D {
-		.name =3D name,
-		.tbl =3D syscall_num_to_name,
-	};
-	const int *id =3D bsearch(&key, syscall_sorted_names,
-				ARRAY_SIZE(syscall_sorted_names),
-				sizeof(syscall_sorted_names[0]),
-				syscallcmpname);
+	const struct syscalltbl *table =3D find_table(e_machine);
+	struct syscall_cmp_key key;
+	const int *id;
+
+	if (!table)
+		return -1;
+
+	key.name =3D name;
+	key.tbl =3D table->num_to_name;
+	id =3D bsearch(&key, table->sorted_names, table->sorted_names_len,
+		     sizeof(table->sorted_names[0]), syscallcmpname);
=20
 	return id ? *id : -1;
 }
=20
-int syscalltbl__num_idx(int e_machine __maybe_unused)
+int syscalltbl__num_idx(int e_machine)
 {
-	return ARRAY_SIZE(syscall_sorted_names);
+	const struct syscalltbl *table =3D find_table(e_machine);
+
+	if (!table)
+		return 0;
+
+	return table->sorted_names_len;
 }
=20
-int syscalltbl__id_at_idx(int e_machine __maybe_unused, int idx)
+int syscalltbl__id_at_idx(int e_machine, int idx)
 {
-	return syscall_sorted_names[idx];
+	const struct syscalltbl *table =3D find_table(e_machine);
+
+	if (!table)
+		return -1;
+
+	assert(idx >=3D 0 && idx < table->sorted_names_len);
+	return table->sorted_names[idx];
 }
=20
-int syscalltbl__strglobmatch_next(int e_machine __maybe_unused, const char=
 *syscall_glob, int *idx)
+int syscalltbl__strglobmatch_next(int e_machine, const char *syscall_glob,=
 int *idx)
 {
-	for (int i =3D *idx + 1; i < (int)ARRAY_SIZE(syscall_sorted_names); ++i) =
{
-		const char *name =3D syscall_num_to_name[syscall_sorted_names[i]];
+	const struct syscalltbl *table =3D find_table(e_machine);
+
+	for (int i =3D *idx + 1; table && i < table->sorted_names_len; ++i) {
+		const char *name =3D table->num_to_name[table->sorted_names[i]];
=20
 		if (strglobmatch(name, syscall_glob)) {
 			*idx =3D i;
-			return syscall_sorted_names[i];
+			return table->sorted_names[i];
 		}
 	}
=20
--=20
2.48.1.362.g079036d154-goog

