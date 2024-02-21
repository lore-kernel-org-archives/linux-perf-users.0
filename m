Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641E680C08
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Feb 2024 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535717; cv=none; b=RFewffj0DvfHek9ecwephkbpINx6r6M3QKrkNRslX+iLBPos9B5KQaxwxAand4Mas29WYMYWTGjHu349Cpv88s39ovto1Dd5uKfSN4p+k17karghtXGduo1EjanxF2rjEgsAnZUw7kOwW9H40xfaaB6Cd/wyopUIw6Ts8wAvSPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535717; c=relaxed/simple;
	bh=qXq4PNvjvgDmiLUk6Z6yOmplG+bIyDpiOE76WF7D8xA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p5ToE+G4Fut6m88MBp9oOSFypC9NXLBLkIXLmMrtwCyBos6J6NrsdR5sIRAztWfWM62GT3+3oiELGGKoSuxEiZn4MLV+L5x0k77vkIqjJeF44YoTDIli6fTPr0GWLpIM5ipygCU+w7Fcky96BA2u5ovh0yCpmzpiBYTbl7WcAag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dsDdtEAE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dsDdtEAE"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d5ce88b51cso211715ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Feb 2024 09:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708535716; x=1709140516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNiHa7z7oNCW1wlMmCBMKSFj43BZPUpQvIH/WzAHEv4=;
        b=dsDdtEAEEZf0uu1y0+Vs2hzJpxalpLNgpcHayMQHS4XYbD7ednra5rXtxSLVVKYxMZ
         eiwxrdvBFte9cVJKwmMbUuMq1YgKyniTL+FsaZB78xsLm5Q9hXtfXdktI1rHsFEDcomY
         cYeLgtzyAkyQ7GL0KF7x7m6OsXFPn7hxbqxRqjXg+/ZbuEHsGB2JVRr5bVPMfCJ6a9kB
         iCA6aq0r4wynVwiK5otJS0/twC7OaNRC4ju6xOPoMcKfrq/+xyJzWlJupvN5MmzyMMHC
         no0kTW1P3Xmx8aYBGo27+nlS7jF6X+NSz5Bg21BXhBTAKjgYxiI9i1/NxK91an9CHebB
         +coA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708535716; x=1709140516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNiHa7z7oNCW1wlMmCBMKSFj43BZPUpQvIH/WzAHEv4=;
        b=PwX2Fx8546kkExgdu/5OhGDCERmslGc4g/XHmsXf2SheF3p8f6XyoIzyT5SVwt8Fo3
         KVGGA+vf7kFLY2IzWhV+d/SXXsGtCsdFzfxUpfWw+rgMTom9PEcvjl4FexVKuJXAGR3s
         pW/xhFfw4WbeW1FaNs4ek++XplWYXy+8DjeCQII7zcBtopOEqfa+8iNI0diZuzitG/zv
         /NN4T4pi31bIvFe8ue0ZOHVb3ejgbMK5eIA4Hy+xaoU5lzCBl5FEJeS8TI2ZDWShaYS6
         MfHbJ2RIdVuB579Qh/MXwni87XYUt0vFXa2gfnk5wOt1QfXOAh4ea7QosA4Ltk9k+OwO
         K56g==
X-Forwarded-Encrypted: i=1; AJvYcCWEM/n+jWTxaXan3IFCu8liOl41K77T5ZGsA61EMczEUaTBrIpz6CYcwq3ZB8UdG1UoYxsgQfJW0W7ZlPvqVENzAo97/Lfapl1yzDETkOuzIA==
X-Gm-Message-State: AOJu0YwuXnR6wO/hpmQHGLqOleH7ov3ywYzEiF8OmGmBWem0j5NhL9E2
	z68wqsRXT/+J/Wi4+72H2YI/R9NFGBU28fOCFoYCtK1MAZUzoJ2r3ihY5MwUupc0vHKUfNIPxsr
	wbkM8QXakXr6vjFng+LCOSRO9xLUkFjWyFGSc
X-Google-Smtp-Source: AGHT+IE1P7tr3b4eQAbZabtGunP4Kw4EKYWWmqt+s6jc2OmmCFeDyWG2oAOtj+sfW2JVH/RE42k+P7BU2GmETDX/o+U=
X-Received: by 2002:a17:903:23c4:b0:1d9:a393:4a38 with SMTP id
 o4-20020a17090323c400b001d9a3934a38mr266660plh.26.1708535715372; Wed, 21 Feb
 2024 09:15:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZdYtJs8nWt6ALprh@x1>
In-Reply-To: <ZdYtJs8nWt6ALprh@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 Feb 2024 09:15:01 -0800
Message-ID: <CAP-5=fXQPEe4KSQHs421kiUa7Ttr-WqtPtcdju2WRi6rdKy4rw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf trace: Collect sys_nanosleep first argument
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 9:04=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> That is a 'struct timespec' passed from userspace to the kernel as we
> can see with a system wide syscall tracing:
>
>   root@number:~# perf trace -e nanosleep
>        0.000 (10.102 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_n=
sec: 10000000 })                   =3D 0
>       38.924 (10.077 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .t=
v_nsec: 10000000 })                   =3D 0
>      100.177 (10.107 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_n=
sec: 10000000 })                   =3D 0
>      139.171 (10.063 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .t=
v_nsec: 10000000 })                   =3D 0
>      200.603 (10.105 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_n=
sec: 10000000 })                   =3D 0
>      239.399 (10.064 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .t=
v_nsec: 10000000 })                   =3D 0
>      300.994 (10.096 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_n=
sec: 10000000 })                   =3D 0
>      339.584 (10.067 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .t=
v_nsec: 10000000 })                   =3D 0
>      401.335 (10.057 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_n=
sec: 10000000 })                   =3D 0
>      439.758 (10.166 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .t=
v_nsec: 10000000 })                   =3D 0
>      501.814 (10.110 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_n=
sec: 10000000 })                   =3D 0
>      539.983 (10.227 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .t=
v_nsec: 10000000 })                   =3D 0
>      602.284 (10.199 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_n=
sec: 10000000 })                   =3D 0
>      640.208 (10.105 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .t=
v_nsec: 10000000 })                   =3D 0
>      702.662 (10.163 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_n=
sec: 10000000 })                   =3D 0
>      740.440 (10.107 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .t=
v_nsec: 10000000 })                   =3D 0
>      802.993 (10.159 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_n=
sec: 10000000 })                   =3D 0
>   ^Croot@number:~# strace -p 9150 -e nanosleep
>
> If we then use the ptrace method to look at that podman process:
>
>   root@number:~# strace -p 9150 -e nanosleep
>   strace: Process 9150 attached
>   nanosleep({tv_sec=3D0, tv_nsec=3D10000000}, NULL) =3D 0
>   nanosleep({tv_sec=3D0, tv_nsec=3D10000000}, NULL) =3D 0
>   nanosleep({tv_sec=3D0, tv_nsec=3D10000000}, NULL) =3D 0
>   nanosleep({tv_sec=3D0, tv_nsec=3D10000000}, NULL) =3D 0
>   nanosleep({tv_sec=3D0, tv_nsec=3D10000000}, NULL) =3D 0
>   nanosleep({tv_sec=3D0, tv_nsec=3D10000000}, NULL) =3D 0
>   nanosleep({tv_sec=3D0, tv_nsec=3D10000000}, NULL) =3D 0
>   ^Cstrace: Process 9150 detached
>   root@number:~#
>
> With some changes we can get something closer to the strace output,
> still in system wide mode:
>
>   root@number:~# perf config trace.show_arg_names=3Dfalse
>   root@number:~# perf config trace.show_duration=3Dfalse
>   root@number:~# perf config trace.show_timestamp=3Dfalse
>   root@number:~# perf config trace.show_zeros=3Dtrue
>   root@number:~# perf config trace.args_alignment=3D0
>   root@number:~# perf trace -e nanosleep --max-events=3D10
>   podman/2195174 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) =3D =
0
>   podman/9150 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) =3D 0
>   podman/2195174 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) =3D =
0
>   podman/9150 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) =3D 0
>   podman/2195174 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) =3D =
0
>   podman/9150 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) =3D 0
>   podman/2195174 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) =3D =
0
>   podman/9150 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) =3D 0
>   podman/2195174 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) =3D =
0
>   podman/9150 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) =3D 0
>   root@number:~#
>   root@number:~# perf config
>   trace.show_arg_names=3Dfalse
>   trace.show_duration=3Dfalse
>   trace.show_timestamp=3Dfalse
>   trace.show_zeros=3Dtrue
>   trace.args_alignment=3D0
>   root@number:~# cat ~/.perfconfig
>   # this file is auto-generated.
>   [trace]
>         show_arg_names =3D false
>         show_duration =3D false
>         show_timestamp =3D false
>         show_zeros =3D true
>         args_alignment =3D 0
>   root@number:~#
>
> This will not get reused by any other syscall as nanosleep is the only
> one to have as its first argument a 'struct timespec" pointer argument
> passed from userspace to the kernel:
>
>   root@number:~# grep timespec /sys/kernel/tracing/events/syscalls/sys_en=
ter_*/format | grep offset:16
>   /sys/kernel/tracing/events/syscalls/sys_enter_nanosleep/format:       f=
ield:struct __kernel_timespec * rqtp;  offset:16;      size:8; signed:0;
>   root@number:~#
>
> BTF based pretty printing will simplify all this, but then lets just get
> the low hanging fruits first.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

v2? https://lore.kernel.org/lkml/Zbq72dJRpOlfRWnf@kernel.org/

Thanks,
Ian
