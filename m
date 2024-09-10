Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E7216C684;
	Tue, 10 Sep 2024 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987913; cv=none; b=rYigNxj7JIaF0IKFn8viKzJp0o7+Bvrk4TxDGET9fAVGX9+4UbIUhMc94rrzW5wMxmF8AFM2rINEoikTKabXlgbmHPdfTgIeFVGpDoUCPoxS35JMnmTIuF89C5kV7zwutfKTFv1eM/tobaRJcpg46He4vuTsE3mey16Y3eydfno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987913; c=relaxed/simple;
	bh=uRDLkFFDIUho/LgoMzI7j/gSOXIub9oNK+V6iTGkVXI=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Qtsg+Ik3LamqDgbS/ZxI6tMF3+GmwG9hGmEe3y8l6hdKwUj3/dGr1FasvZoxmA5ig+HlcJ0ZDaQSOUl3LTsg7+dS0cqkaWep72Qb+CavhLjZh6CMog6RDFMqWCCXHNpbalErbDMd49SIgwMbbQViI1HXt/bcGSkfKcT/YBcDyK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPGcw0MA; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPGcw0MA"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7c3e1081804so573306a12.3;
        Tue, 10 Sep 2024 10:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725987911; x=1726592711; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ET6G2wODCglT9r88gN0jOSL74gqMV3Ge/ZWntzZjf9A=;
        b=OPGcw0MA6y1Gs0IXps4IVwHf8aIgO4O1QiCA5bAiUmzKRQc4HXQEDlks8IX0wsj7uW
         M1hWZxZ7aMAGE2i6vxchcDR4yzDD8SF9rolvpHdNotf8AlIapmWeWdzHFam6jgrXSGc7
         xXaxtxzmv0W/3emuv1hxE3kFjUqjM+ppzD3O/dFY07paSahp8yU1pqdKxDwnrN6V/lOQ
         i0KLtBRFK7E4pz82zlUAdoML7Z782flqLkroOA0Ol7JqPE+ykj3WMQ5hfASQKRLAmiYA
         ZnQZI6YRtcy4+2h/8O+Ap9PdI6pMN949pq+mV3R7H8/4Ojg1v6mfJLppPDP3wMRsnYx6
         /0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725987911; x=1726592711;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ET6G2wODCglT9r88gN0jOSL74gqMV3Ge/ZWntzZjf9A=;
        b=R/bfDBcZPBBr3k6JrlMgjeX5QfgpQJ8Q0OjUIilPyuak+RSAAt7B10lmr1wvS4jUpZ
         IQBUHD89nrQxs6u0VDHJSui6d7P9CmNSgjW5/fSu2gM8AJkj7mlbdMtroNpcdqoLTFfE
         lZRe4/FrvqOtx3eSVl17+PiOKIODlZ+HiWDXQa9j46u+Meh7IhKuqzvxr90WwYX/Bljm
         9XEUlubko3wLfBsRwDbdpFPYXIB5JCCLVcf/x+2OS0GTzd+ECqCunUKtTzSH+oIGtnE1
         xdAii86SWBGMSjR7xE0ZluVSuAvPXhtkecOIyM1whDONK0B+LzMp5bISAAbENoJUifOB
         kp0A==
X-Forwarded-Encrypted: i=1; AJvYcCVdLP62ERXcP/DuqHw7Ot8JY4sQZcDkf1ieZfmt727gfLTB4FbakpSBrpvMPzEL88SU1LPvh90A+eVrKns=@vger.kernel.org, AJvYcCXxnwwBEcekrZ9IMlrGVbUZyVRurqhgsXClq1JwjBdHXHg8DpoDb+5kSxHG1+7ZO8UCYQmU9fihQ2fuSmeYny5d5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxX+p2YugIYt6Dvq2gOTkExIOZzIAzpxUcd3EWKjM6UEza1r7y/
	Yo4mgilAsZdiY9l2llvBSG6Oknp1SBW6+T2yjEwt5HNjfMApXWgS
X-Google-Smtp-Source: AGHT+IG1u+veK7HEAcEldDvIEGUqlJc6dHaHNfQsYSeY6jficbJys3YhE8TFpisXTCbvCytEk5E08w==
X-Received: by 2002:a17:902:c403:b0:205:9201:b520 with SMTP id d9443c01a7336-207522154eemr2574695ad.58.1725987910647;
        Tue, 10 Sep 2024 10:05:10 -0700 (PDT)
Received: from localhost ([138.0.199.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e19716sm50809775ad.38.2024.09.10.10.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 10:05:10 -0700 (PDT)
From: arnaldo.melo@gmail.com
Date: Tue, 10 Sep 2024 14:05:07 -0300
To: Ian Rogers <irogers@google.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Howard Chu <howardchu95@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf trace: If a syscall arg is marked as 'const',
 assume it is coming _from_ userspace
Message-ID: <ZuB8Q3NQej-gB6Tz@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We need to decide where to copy syscall arg contents, if at the
syscalls:sys_entry hook, meaning is something that is coming from
user to kernel space, or if it is a response, i.e. if it is something
the _kernel_ is filling in and thus going to userspace.

Since we have 'const' used in those syscalls, and unsure about this
being consistent, doing:

  root@number:~# echo $(grep const /sys/kernel/tracing/events/syscalls/sys_enter_*/format  | grep struct | cut -c47- | cut -d'/' -f1)
  clock_nanosleep clock_settime epoll_pwait2 futex io_pgetevents landlock_create_ruleset listmount mq_getsetattr mq_notify mq_timedreceive mq_timedsend preadv2 preadv prlimit64 process_madvise process_vm_readv process_vm_readv process_vm_writev process_vm_writev pwritev2 pwritev readv rt_sigaction rt_sigtimedwait semtimedop statmount timerfd_settime timer_settime vmsplice writev
  root@number:~#

Seems to indicate that we can use that for the ones that have the
'const' to mark it as coming from user space, do it.

Most notable/frequent syscall that now gets BTF pretty printed in a
system wide 'perf trace' session is:

  root@number:~# perf trace
     21.160 (         ): MediaSu~isor #/1028597 futex(uaddr: 0x7f49e1dfe964, op: WAIT_BITSET|PRIVATE_FLAG, utime: (struct __kernel_timespec){.tv_sec = (__kernel_time64_t)50290,.tv_nsec = (long long int)810362837,}, val3: MATCH_ANY) ...
      21.166 ( 0.000 ms): RemVidChild/6995 futex(uaddr: 0x7f49fcc7fa00, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
      21.169 ( 0.001 ms): RemVidChild/6995 sendmsg(fd: 25<socket:[78915]>, msg: 0x7f49e9af9da0, flags: DONTWAIT) = 280
      21.172 ( 0.289 ms): RemVidChild/6995 futex(uaddr: 0x7f49fcc7fa58, op: WAIT_BITSET|PRIVATE_FLAG|CLOCK_REALTIME, val3: MATCH_ANY) = 0
      21.463 ( 0.000 ms): RemVidChild/6995 futex(uaddr: 0x7f49fcc7fa00, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
      21.467 ( 0.001 ms): RemVidChild/6995 futex(uaddr: 0x7f49e28bb964, op: WAKE|PRIVATE_FLAG, val: 1)           = 1
      21.160 ( 0.314 ms): MediaSu~isor #/1028597  ... [continued]: futex())                                            = 0
      21.469 (         ): RemVidChild/6995 futex(uaddr: 0x7f49fcc7fa5c, op: WAIT_BITSET|PRIVATE_FLAG|CLOCK_REALTIME, val3: MATCH_ANY) ...
      21.475 ( 0.000 ms): MediaSu~isor #/1028597 futex(uaddr: 0x7f49d0223040, op: WAKE|PRIVATE_FLAG, val: 1)           = 0
      21.478 ( 0.001 ms): MediaSu~isor #/1028597 futex(uaddr: 0x7f49e26ac964, op: WAKE|PRIVATE_FLAG, val: 1)           = 1
  ^Croot@number:~#
  root@number:~# cat /sys/kernel/tracing/events/syscalls/sys_enter_futex/format
  name: sys_enter_futex
  ID: 454
  format:
  	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
  	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
  	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
  	field:int common_pid;	offset:4;	size:4;	signed:1;

  	field:int __syscall_nr;	offset:8;	size:4;	signed:1;
  	field:u32 * uaddr;	offset:16;	size:8;	signed:0;
  	field:int op;	offset:24;	size:8;	signed:0;
  	field:u32 val;	offset:32;	size:8;	signed:0;
  	field:const struct __kernel_timespec * utime;	offset:40;	size:8;	signed:0;
  	field:u32 * uaddr2;	offset:48;	size:8;	signed:0;
  	field:u32 val3;	offset:56;	size:8;	signed:0;

  print fmt: "uaddr: 0x%08lx, op: 0x%08lx, val: 0x%08lx, utime: 0x%08lx, uaddr2: 0x%08lx, val3: 0x%08lx", ((unsigned long)(REC->uaddr)), ((unsigned long)(REC->op)), ((unsigned long)(REC->val)), ((unsigned long)(REC->utime)), ((unsigned long)(REC->uaddr2)), ((unsigned long)(REC->val3))
  root@number:~#

Suggested-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 83eb15b72333edd9..e26baf1256d5bb56 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2001,11 +2001,14 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 
 		len = strlen(field->name);
 
+		// As far as heuristics (or intention) goes this seems to hold true, and makes sense!
+		if ((field->flags & TEP_FIELD_IS_POINTER) && strstarts(field->type, "const "))
+			arg->from_user = true;
+
 		if (strcmp(field->type, "const char *") == 0 &&
 		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
 		     strstr(field->name, "path") != NULL)) {
 			arg->scnprintf = SCA_FILENAME;
-			arg->from_user = true;
 		} else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr"))
 			arg->scnprintf = SCA_PTR;
 		else if (strcmp(field->type, "pid_t") == 0)
-- 
2.46.0

