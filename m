Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD94192D98
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990106; cv=none; b=CbPXROGPv26XRRD8ggRN73coQFGsTP6F2hRp8J3CBgMIk+yApkKQ6cUNScqow51HT4F/Uv6jH71nAgzb3VxHl//uUPkWA84LyIM/IAlscjLVEMWYeabVC/1MxAFc5zVll2XVLK3KedQsNRplnTrZdokIsDFuWy462U70qu1gxQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990106; c=relaxed/simple;
	bh=fAUv7M3pJwZVW1Q8kVS8zK7PUHK0l1kPBi3Cq/kPzuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=naL6YR5e7CGE+emMmeFtpeW8IM3/tgNLDKXZgcLYy2o8tZvn1qJJpohjNAjpYc5hzut1rVnDFiq53lR9MCsahaTcNsXk+zPyqDqrlXlEJvvlhNKYLoMAvJ3EO03tVTcvYOki86slFMhcU3MF0YB8WfwSzi5kHmSoKcBVreoq4Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0pD0tq1L; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0pD0tq1L"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39d3ad05f8eso283125ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 10:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725990103; x=1726594903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYw7Yq3bzNnAatLT1BVowVs3XyP1qscSohILgAm3AAA=;
        b=0pD0tq1LWOx0GwwgVqCf3QQSFuT4DAAtNwxFzFiTX7E9jvkEYzcd45CLLaUX1UpMdO
         gPcVNufuLFcbtdr0xSuCGCnY3+Tf9toS8+YpIOlkUTvQvwgcMiK1WHSYyrx8758QdMvs
         6r2oTvlV2R1pOruTd1z3qHtIlFQS24bmTzZxZ3S3tVsMquL/BJRK0wgZeiAAEumul1c2
         XsDnPmdgGqusGgGZpxQC0PRgYfKP24BNxRRpd8tOj2Rn77ggaZaFLrhyCa4ZKlgr48uM
         yxypkcjDDGvQcoA0qgiVlN2pZCn3L0iZRosGeTLLN/sEhecnsa9wc8RpK+x9CpHA/W7H
         8fNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725990103; x=1726594903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYw7Yq3bzNnAatLT1BVowVs3XyP1qscSohILgAm3AAA=;
        b=UwZz8DpQuHY/f1zyYBXJBoID3fJkcDTOt13IgUVQBJLBYO9Wb8tOpq/KvEfbF77nHr
         /N3QB77jth+N6QIDOawPXhJ9X8vCupghNM6cV0rzpbQ6pxj8dsHQxR6WaV7hBPR75sxe
         LLUQwTk3pjcB7FhALtG8GUmXkAG1dC3R858o1HvvzJK9x4mtY7KpSu9r6dE+tVYqohhP
         5E316m+4ms4CPeR6GSEuyJrP9Agj0XopC1xoeGvmCR+IrdKnnMNxJg3cInEaMHN8hNi+
         0G0zM3OkVpgH+ahCQh2/B+CjxggoM6eXLvAKEztMSYMFW8CJL+mdprKUdGX+5ZQoey4A
         gDSw==
X-Forwarded-Encrypted: i=1; AJvYcCWK/xHmf+befdSHBCVQTGx48ZrNWKfmJ2yKVXFIw5LTz0A84XRDFqwynDHctbAm/vmkkWr6wziUMomqccmT8H1Q@vger.kernel.org
X-Gm-Message-State: AOJu0YyZfJIAm1H3RJcm0JHjvDrewYAeylDMXKV77ISvq9Bzzn+7Hu6I
	hxkR9czeiumLBPZBAqcDbs+1MxjFskx363PugZn43IdV4unzaSuOw5yftJNfanT8JJO5zc+2wta
	/c5QYbbptCKXzwOdJxBnf96hy3PMkyGLw++Bb
X-Google-Smtp-Source: AGHT+IE3Ojd6hPkIRzLEh2MMX2BlT4wzTXRZs5kxZ3gebnmMifTmj+qzAlTv8y7e3vUMMbMuM/eagRff0AZIoeJiHJw=
X-Received: by 2002:a92:c549:0:b0:39f:709d:72b3 with SMTP id
 e9e14a558f8ab-3a07508b96emr100395ab.12.1725990103047; Tue, 10 Sep 2024
 10:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZuB8Q3NQej-gB6Tz@x1>
In-Reply-To: <ZuB8Q3NQej-gB6Tz@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 10 Sep 2024 10:41:31 -0700
Message-ID: <CAP-5=fWnuQrrBoTn6Rrn6vM_xQ2fCoc9i-AitD7abTcNi-4o1Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf trace: If a syscall arg is marked as 'const',
 assume it is coming _from_ userspace
To: arnaldo.melo@gmail.com
Cc: Alan Maguire <alan.maguire@oracle.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Howard Chu <howardchu95@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 10:05=E2=80=AFAM <arnaldo.melo@gmail.com> wrote:
>
> We need to decide where to copy syscall arg contents, if at the
> syscalls:sys_entry hook, meaning is something that is coming from
> user to kernel space, or if it is a response, i.e. if it is something
> the _kernel_ is filling in and thus going to userspace.
>
> Since we have 'const' used in those syscalls, and unsure about this
> being consistent, doing:
>
>   root@number:~# echo $(grep const /sys/kernel/tracing/events/syscalls/sy=
s_enter_*/format  | grep struct | cut -c47- | cut -d'/' -f1)
>   clock_nanosleep clock_settime epoll_pwait2 futex io_pgetevents landlock=
_create_ruleset listmount mq_getsetattr mq_notify mq_timedreceive mq_timeds=
end preadv2 preadv prlimit64 process_madvise process_vm_readv process_vm_re=
adv process_vm_writev process_vm_writev pwritev2 pwritev readv rt_sigaction=
 rt_sigtimedwait semtimedop statmount timerfd_settime timer_settime vmsplic=
e writev
>   root@number:~#
>
> Seems to indicate that we can use that for the ones that have the
> 'const' to mark it as coming from user space, do it.
>
> Most notable/frequent syscall that now gets BTF pretty printed in a
> system wide 'perf trace' session is:
>
>   root@number:~# perf trace
>      21.160 (         ): MediaSu~isor #/1028597 futex(uaddr: 0x7f49e1dfe9=
64, op: WAIT_BITSET|PRIVATE_FLAG, utime: (struct __kernel_timespec){.tv_sec=
 =3D (__kernel_time64_t)50290,.tv_nsec =3D (long long int)810362837,}, val3=
: MATCH_ANY) ...
>       21.166 ( 0.000 ms): RemVidChild/6995 futex(uaddr: 0x7f49fcc7fa00, o=
p: WAKE|PRIVATE_FLAG, val: 1)           =3D 0
>       21.169 ( 0.001 ms): RemVidChild/6995 sendmsg(fd: 25<socket:[78915]>=
, msg: 0x7f49e9af9da0, flags: DONTWAIT) =3D 280
>       21.172 ( 0.289 ms): RemVidChild/6995 futex(uaddr: 0x7f49fcc7fa58, o=
p: WAIT_BITSET|PRIVATE_FLAG|CLOCK_REALTIME, val3: MATCH_ANY) =3D 0
>       21.463 ( 0.000 ms): RemVidChild/6995 futex(uaddr: 0x7f49fcc7fa00, o=
p: WAKE|PRIVATE_FLAG, val: 1)           =3D 0
>       21.467 ( 0.001 ms): RemVidChild/6995 futex(uaddr: 0x7f49e28bb964, o=
p: WAKE|PRIVATE_FLAG, val: 1)           =3D 1
>       21.160 ( 0.314 ms): MediaSu~isor #/1028597  ... [continued]: futex(=
))                                            =3D 0
>       21.469 (         ): RemVidChild/6995 futex(uaddr: 0x7f49fcc7fa5c, o=
p: WAIT_BITSET|PRIVATE_FLAG|CLOCK_REALTIME, val3: MATCH_ANY) ...
>       21.475 ( 0.000 ms): MediaSu~isor #/1028597 futex(uaddr: 0x7f49d0223=
040, op: WAKE|PRIVATE_FLAG, val: 1)           =3D 0
>       21.478 ( 0.001 ms): MediaSu~isor #/1028597 futex(uaddr: 0x7f49e26ac=
964, op: WAKE|PRIVATE_FLAG, val: 1)           =3D 1
>   ^Croot@number:~#
>   root@number:~# cat /sys/kernel/tracing/events/syscalls/sys_enter_futex/=
format
>   name: sys_enter_futex
>   ID: 454
>   format:
>         field:unsigned short common_type;       offset:0;       size:2; s=
igned:0;
>         field:unsigned char common_flags;       offset:2;       size:1; s=
igned:0;
>         field:unsigned char common_preempt_count;       offset:3;       s=
ize:1; signed:0;
>         field:int common_pid;   offset:4;       size:4; signed:1;
>
>         field:int __syscall_nr; offset:8;       size:4; signed:1;
>         field:u32 * uaddr;      offset:16;      size:8; signed:0;
>         field:int op;   offset:24;      size:8; signed:0;
>         field:u32 val;  offset:32;      size:8; signed:0;
>         field:const struct __kernel_timespec * utime;   offset:40;      s=
ize:8; signed:0;
>         field:u32 * uaddr2;     offset:48;      size:8; signed:0;
>         field:u32 val3; offset:56;      size:8; signed:0;
>
>   print fmt: "uaddr: 0x%08lx, op: 0x%08lx, val: 0x%08lx, utime: 0x%08lx, =
uaddr2: 0x%08lx, val3: 0x%08lx", ((unsigned long)(REC->uaddr)), ((unsigned =
long)(REC->op)), ((unsigned long)(REC->val)), ((unsigned long)(REC->utime))=
, ((unsigned long)(REC->uaddr2)), ((unsigned long)(REC->val3))
>   root@number:~#
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Howard Chu <howardchu95@gmail.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-trace.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 83eb15b72333edd9..e26baf1256d5bb56 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2001,11 +2001,14 @@ syscall_arg_fmt__init_array(struct syscall_arg_fm=
t *arg, struct tep_format_field
>
>                 len =3D strlen(field->name);
>
> +               // As far as heuristics (or intention) goes this seems to=
 hold true, and makes sense!
> +               if ((field->flags & TEP_FIELD_IS_POINTER) && strstarts(fi=
eld->type, "const "))
> +                       arg->from_user =3D true;
> +
>                 if (strcmp(field->type, "const char *") =3D=3D 0 &&
>                     ((len >=3D 4 && strcmp(field->name + len - 4, "name")=
 =3D=3D 0) ||
>                      strstr(field->name, "path") !=3D NULL)) {
>                         arg->scnprintf =3D SCA_FILENAME;
> -                       arg->from_user =3D true;
>                 } else if ((field->flags & TEP_FIELD_IS_POINTER) || strst=
r(field->name, "addr"))
>                         arg->scnprintf =3D SCA_PTR;
>                 else if (strcmp(field->type, "pid_t") =3D=3D 0)
> --
> 2.46.0
>
