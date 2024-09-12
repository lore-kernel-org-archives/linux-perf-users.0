Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658482D7BF;
	Thu, 12 Sep 2024 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726104606; cv=none; b=rKSiJTD9fb5iryIvnVjqWz/RuGB4iVrRYpOThXDYe0JE+wHoBxiHPuhED8gsdqMEHIbFoUxL8qcfeK9xF748Jjv5vGF3Sqt8YKhFbui6xXDah+uvLJ0JhNqVo9RCQiHNitKO2GOmq0kZdMeYHKAUKc52EmCMOhpO8iDG2C8QFZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726104606; c=relaxed/simple;
	bh=YnBG6MVQuPnj+84wi6UszEipgdwYiSRRUWpmwlFpoa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWdJCaiqstz4omCbNBDnB7I+byuAjvsg5PY1yolvQZe5xBEG1sfzRc3mO92pFZnvK/pWhTk2iSlBF2CSolcMevA3LM/J5W1zVa2iBDPvLMRc3wWJg11hGKbDOIa69iCauBi+k1NsxCY99TwTNLp0/F1c116/FcYGnvASw5B3Vys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXRl7uD1; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXRl7uD1"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6d5a4615a56so3962247b3.0;
        Wed, 11 Sep 2024 18:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726104604; x=1726709404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oc4A9PUbXEgnIX4R83UKro/vj2MRuKfr14pnn04li2E=;
        b=jXRl7uD1w7STv5GII17vZRkbCc4QVINffhTqlwsOKQv86t+YBKtEQUNDGg6dWO/qLh
         EtMqYlhMo2oqGlfSBvsexNTwtWCtJu3BJzSFgMqu3b4wCHnKXc4eLahnvhCHvI4Xflgw
         Erorwm/3mKxvG1WNHBhUSpUPU86GDZ4JSJ0lUQhnkcFiXFZUGTGAw9qMD9Tk/zSxeIq8
         6o++oAnjVPIQROyRjA8BF7w8G2tOsIQptoMpT/hrRIZ88SX4H1gMImNZVq0Ah7+QUXtV
         1pgp3ypSKsPa5KykcShpuw2W4aYQVSsTH4DaZq61yLxLA4U4mHX35ER3yFA6HOUm96gY
         FfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726104604; x=1726709404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oc4A9PUbXEgnIX4R83UKro/vj2MRuKfr14pnn04li2E=;
        b=UL0YEvkcagCCYwH3G072UNxDK+XFlCuWhInqVhJWEbBbSdbRlSYfehohI1IbrjPeqn
         ZULmHWPijbP42GO8biBczSKIA3+7PqEFibOMscLMSBr3L2i39+oaE/N3OLAwL3QSE4jc
         ywLiMbSGbqTL1nw0LWfQdVH4vh/llRq+Ssk+f3osDgv9mT8pSb7shvWro288VWm/NPzj
         q0GU3I8qqNFA67PD+f6BI+AvcipcJ6UOWgy1o6r2Xmg7mCMxEfUVBD3pkOjmwa7X/OSj
         NUWmcY51AhAVkDHZCw/U8yQ9YiuLtLW9aP02wgA7AUzXiTwFRmtjn9fAr1ChcVSgC04k
         QDuw==
X-Forwarded-Encrypted: i=1; AJvYcCU4UcAEA+yT8hVVyMhyjIOz5XXhzmngxBPGWU+EiK8PH8ovWqSsFXxF5s2suIdqyYmtnY2hp+Flo2u5Lv2J5swYag==@vger.kernel.org, AJvYcCV9T7hfeDEF7wBmRScRJ734yOrZ5kqNvTg/I6ezyTnguPNVjOFIKdm+FFrmorv4asCtb/dbUeMF4T1212g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzMClhfoh/5amVoo0OOBxX1yIw/eo+Mm+yWk+/6jxGuTK/PNtI
	zQgQw4Klb7fXUPDUv0fi8e60ToP1QNLdt24etdvYY5kaM45t334IBByF8AKcb1OOvkV6zrWobeT
	60Cc5yIwgrxZKv0AfnPhAu3869Ug=
X-Google-Smtp-Source: AGHT+IE+H6DHvC/Mz6o8AEsnRfwB7c8j0ptt/UcEiR7jTWtefm/c4gfpAtbee+sa6fjJl3dc9A/cpPflbhKSqZA/0aw=
X-Received: by 2002:a05:690c:2a46:b0:6d1:f545:4ae6 with SMTP id
 00721157ae682-6dbb6b13b7emr12410537b3.16.1726104604212; Wed, 11 Sep 2024
 18:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZuH8qhuZB6mr9JvR@x1>
In-Reply-To: <ZuH8qhuZB6mr9JvR@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 11 Sep 2024 18:29:53 -0700
Message-ID: <CAH0uvog5akiwUp+28w5u7+-j_fYvQLWahJ6YvEzWjdCz3Ky9Wg@mail.gmail.com>
Subject: Re: perf trace: substruct BTF based pretty printing
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Arnaldo,

On Wed, Sep 11, 2024 at 1:25=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Hi Howard,
>
>         Not really a requirement on you to do work, just a some notes to
> add to our discussion/experiment on using BTF to pretty print syscall
> (and tracepoints/whatever) arguments:
>
> root@number:~# perf trace -e setitimer -p 5444 |& head -5
>      0.000 ( 0.017 ms): Xwayland/5444 setitimer(value: (struct __kernel_o=
ld_itimerval){})                   =3D 0
>      0.050 ( 0.004 ms): Xwayland/5444 setitimer(value: (struct __kernel_o=
ld_itimerval){})                   =3D 0
>      0.142 ( 0.005 ms): Xwayland/5444 setitimer(value: (struct __kernel_o=
ld_itimerval){})                   =3D 0
>      0.174 ( 0.004 ms): Xwayland/5444 setitimer(value: (struct __kernel_o=
ld_itimerval){})                   =3D 0
>      0.293 ( 0.004 ms): Xwayland/5444 setitimer(value: (struct __kernel_o=
ld_itimerval){})                   =3D 0

First glance, yes this is a substruct, but we should be able to
collect those substruct data in BPF, since it is substruct, not
substruct pointer. It seems to be the same -p problem we discussed
here:

Before:
```
perf $ perf trace -e open -p 3792392
         ? (         ):  ... [continued]: open())
                       =3D -1 ENOENT (No such file or directory)
         ? (         ):  ... [continued]: open())
                       =3D -1 ENOENT (No such file or directory)
```

We can see there's no output.

After:
```
perf $ perf trace -e open -p 3792392
     0.000 ( 0.123 ms): a.out/3792392 open(filename: "DINGZHEN",
flags: WRONLY)                             =3D -1 ENOENT (No such file
or directory)
  1000.398 ( 0.116 ms): a.out/3792392 open(filename: "DINGZHEN",
flags: WRONLY)                             =3D -1 ENOENT (No such file
or directory)
```

I will test and fix it later.

Thanks,
Howard

> root@number:~# strace -e setitimer -p 5444 |& head -5
> strace: Process 5444 attached
> setitimer(ITIMER_REAL, {it_interval=3D{tv_sec=3D0, tv_usec=3D5000}, it_va=
lue=3D{tv_sec=3D0, tv_usec=3D5000}}, NULL) =3D 0
> setitimer(ITIMER_REAL, {it_interval=3D{tv_sec=3D0, tv_usec=3D0}, it_value=
=3D{tv_sec=3D0, tv_usec=3D0}}, NULL) =3D 0
> setitimer(ITIMER_REAL, {it_interval=3D{tv_sec=3D0, tv_usec=3D5000}, it_va=
lue=3D{tv_sec=3D0, tv_usec=3D5000}}, NULL) =3D 0
> setitimer(ITIMER_REAL, {it_interval=3D{tv_sec=3D0, tv_usec=3D0}, it_value=
=3D{tv_sec=3D0, tv_usec=3D0}}, NULL) =3D 0
> root@number:~#
> root@number:~#
> root@number:~# grep -w value /sys/kernel/tracing/events/syscalls/sys_ente=
r_rseq/format
> root@number:~# grep -w value /sys/kernel/tracing/events/syscalls/sys_ente=
r_setitimer/format
>         field:struct __kernel_old_itimerval * value;    offset:24;      s=
ize:8; signed:0;
> print fmt: "which: 0x%08lx, value: 0x%08lx, ovalue: 0x%08lx", ((unsigned =
long)(REC->which)), ((unsigned long)(REC->value)), ((unsigned long)(REC->ov=
alue))
> root@number:~# pahole __kernel_old_itimerval
> struct __kernel_old_itimerval {
>         struct __kernel_old_timeval it_interval;         /*     0    16 *=
/
>         struct __kernel_old_timeval it_value;            /*    16    16 *=
/
>
>         /* size: 32, cachelines: 1, members: 2 */
>         /* last cacheline: 32 bytes */
> };
>
> root@number:~# pahole -E __kernel_old_itimerval
> struct __kernel_old_itimerval {
>         struct __kernel_old_timeval {
>                 /* typedef __kernel_long_t */ long int           tv_sec; =
                /*     0     8 */
>                 /* typedef __kernel_long_t */ long int           tv_usec;=
                /*     8     8 */
>         } it_interval; /*     0    16 */
>         struct __kernel_old_timeval {
>                 /* typedef __kernel_long_t */ long int           tv_sec; =
                /*    16     8 */
>                 /* typedef __kernel_long_t */ long int           tv_usec;=
                /*    24     8 */
>         } it_value; /*    16    16 */
>
>         /* size: 32, cachelines: 1, members: 2 */
>         /* last cacheline: 32 bytes */
> };
>
> root@number:~#
