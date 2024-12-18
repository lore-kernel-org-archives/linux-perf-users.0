Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530E235956;
	Wed, 18 Dec 2024 05:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734500435; cv=none; b=Wo/Yk9LM6S/4ezu5F6xHxM6ITtzXSHKw2gFDwbNUwCShVNZzKQ1Yigl6e2IMQpr9tQ/v1SpVR+hCfL9dL5J7UF034IajUdzbVwlEdNOTwwZgzjVO5vCbzO7BY08AhXiQrX9GKfBmfrHeWp39L7UlhUOcdfl3CGNp8pSXnj4kmBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734500435; c=relaxed/simple;
	bh=WE8PnnMe9ZkHQ8xghoF+gc6io2sQ0NG3Jc8OlOEXlSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPhfFJF5nP7ATpaRqImQAUtYYqhkmlAN4XlEQiRGtwceWrL0bTYPkSY3OlRBA4JAVTCtQ12pgcF87uf5/Ff4+uE2W98d23bFKTZufHy/rO/kj3e+tqm/ewzHfubYhDS4lNjncnc8Arar39aUUmZWbZYWs7WrMcxnVBudCuQifUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTWKHV2H; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTWKHV2H"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e461015fbd4so3430001276.2;
        Tue, 17 Dec 2024 21:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734500432; x=1735105232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXvQoJP2AX6D5IUQRyqpELOEEFNWjtB+Yptx7bcBJTo=;
        b=CTWKHV2HRUs6GN6WRa8ZOQunpTGdzrw3DLFNBYeMkqg2y4hClYoKBk+bBvLS0d2n6Q
         nvrUILyR0c3Pm1XGg3S/ys39G6HVh3pMzX40fIetGeKlFxGqsh5mxtpZ0Q77dkmcvSX6
         eFGjrIU1clSD5lKiPPAdKsJnLiMSOBFJCXg9bSgSDrFZQ9+nwQZBm+o+HL7MIEli8HqT
         QDvO/RaguRoXoaT3IEoat5i4xEAy+s3t3cSjb9i2UOl8wnI2YJYtDWjonYFwxp6xzPnP
         Y/+upwmBIxrzY4k9JiuniRSHSxln/2nEgoujy4LG48Z5tpOdGMijaZYF94AdhlA3EtNU
         TG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734500432; x=1735105232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXvQoJP2AX6D5IUQRyqpELOEEFNWjtB+Yptx7bcBJTo=;
        b=l5f4j8dyl7uEJyOTFKmL7xsEuOrfHWHvShiehh/XERhys2ytH/eYg5yO/4HTc1d97o
         a3esQvR/1Tij7MzxoSEW98looQPRSu076gDw4MvRsdAzTT++7OZR/yLwwTyV0wXdqEBB
         +V8rQTKeiXNshGgwqtdMI0uw9ZYj9UemnqfMxkSOKy0aoKWp/UcSOZhBTN+Zpc/ks7Vg
         A65y5pD9rFPHxCJgS6I35d5owMp0sDW5H8+w8b9WXY7UcG12UOHatwGy3hntHMMqnEpV
         Woxwy354XgYUueXmzdhTwCUIj4dD3ve785dVSZhZuTijQcoba0e7vXf2uHzcnUYQ4TSj
         hJuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxkgskZyBH+Vjukbi9dV/dPFZXlqFGJtuSIBVKfL5th9wBD5QjCg4THLrEOcTLj0cFlTqWgRj4+b3JzQs=@vger.kernel.org, AJvYcCXr6Vbi40jbXiy4NGut3YG4n/3sIKXm1hUnU6eh4fmKiQLLn5KT6WUjEiDV0WnmlfqvGpUonsS3wBWfLJilSydQlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YykkhHHX9HX2Mwltt6Kta2R/1iiOyDDOywZSDP6ArDxGYE2jtaw
	w7RqF7fXGDC9wJ8G+INJlBsnWiQzwg/FO3vWxcPx2A7k2h9ELWlQfgHgTfzVTpCisOYkvl9DMTq
	7gx/dWlmGhibWT1E8c3Fhp/mqAP0=
X-Gm-Gg: ASbGncsTo1kM0QmID+Pw7WOMNbdihPzMVbo3KiqxRMV+ZZmpgzeMymGniiOFWdyUoA3
	w1x9IZ6+U9z754H05KTXq3ddvqJav313G9fFp
X-Google-Smtp-Source: AGHT+IEjfvaRLvPLCdeUVJ+NGrpYRnR/0HHmXc4jwtWCrFnY27p6q5zsgzctOuvFLht3L466HRhnODYh1NUO73vttNY=
X-Received: by 2002:a05:6902:1028:b0:e49:803b:2293 with SMTP id
 3f1490d57ef6-e53620f3291mr1330992276.10.1734500432103; Tue, 17 Dec 2024
 21:40:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211222110.2430610-1-namhyung@kernel.org>
In-Reply-To: <20241211222110.2430610-1-namhyung@kernel.org>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 17 Dec 2024 21:40:21 -0800
Message-ID: <CAH0uvog3XkndPWvifVjhrV1GoM4O462e_3Xxr_=r9yCWhnKGmg@mail.gmail.com>
Subject: Re: [RFC/PATCH] perf trace: Add --syscall-period option
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

Thanks for the patch.

On Wed, Dec 11, 2024 at 2:21=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> This option is to implement the event sampling for system calls.
> The period is given in msec as it shows the time in msec.
>
>   # perf trace -C 0 --syscall-period 100 sleep 1
>            ? (         ): fleetspeakd/1828559  ... [continued]: futex()) =
                                           =3D -1 ETIMEDOUT (Connection tim=
ed out)
>        0.050 (100.247 ms): gnome-shell/572531 recvmsg(fd: 10<socket:[3355=
761]>, msg: 0x7ffef8b39d20)                =3D 40
>      100.357 (100.149 ms): pipewire-pulse/572245 read(fd: 5<anon_inode:[e=
ventfd]>, buf: 0x7ffc0b9dc8f0, count: 8)      =3D 8
>      200.553 (100.268 ms): NetworkManager/3424 epoll_wait(epfd: 19<anon_i=
node:[eventpoll]>, events: 0x5607b85bb880, maxevents: 6) =3D 0
>      300.876 (         ): mon/4932 poll(ufds: 0x7fa392784df0, nfds: 1, ti=
meout_msecs: 100)            ...
>      400.901 ( 0.025 ms): TaskCon~ller #/620145 futex(uaddr: 0x7f3fc596fa=
00, op: WAKE|PRIVATE_FLAG, val: 1)           =3D 0
>      300.876 (100.123 ms): mon/4932  ... [continued]: poll())            =
                                 =3D 0 (Timeout)
>      500.901 ( 0.012 ms): evdefer/2/2335122 futex(uaddr: 0x5640baac5198, =
op: WAKE|PRIVATE_FLAG, val: 1)           =3D 0
>      602.701 ( 0.017 ms): Compositor/1992200 futex(uaddr: 0x7f1a51dfdd40,=
 op: WAKE|PRIVATE_FLAG, val: 1)           =3D 0
>      705.589 ( 0.017 ms): JS Watchdog/947933 futex(uaddr: 0x7f4cac1d4240,=
 op: WAKE|PRIVATE_FLAG, val: 1)           =3D 0
>      812.667 ( 0.027 ms): fix/1985151 futex(uaddr: 0xc0008f7148, op: WAKE=
|PRIVATE_FLAG, val: 1)             =3D 1
>      912.807 ( 0.017 ms): Xorg/572315 setitimer(value: 0x7ffc375d6ba0)   =
                                   =3D 0
>
> The timestamp is kept in a per-cpu array and the allowed task is saved
> in a hash map.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-trace.txt       |  6 ++
>  tools/perf/builtin-trace.c                    |  5 ++
>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 67 ++++++++++++++++++-
>  3 files changed, 76 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documen=
tation/perf-trace.txt
> index 6e0cc50bbc13fc7f..9f338a8c5357a67e 100644
> --- a/tools/perf/Documentation/perf-trace.txt
> +++ b/tools/perf/Documentation/perf-trace.txt
> @@ -241,6 +241,12 @@ the thread executes on the designated CPUs. Default =
is to monitor all CPUs.
>         printing using the existing 'perf trace' syscall arg beautifiers =
to map integer
>         arguments to strings (pid to comm, syscall id to syscall name, et=
c).
>
> +--syscall-period::
> +       Trace a system call in the given period (in msec).  This implemen=
ts
> +       sampling for syscalls in order to reduce the monitoring overhead.
> +       For example, setting the sysall period to 100 (msec) means it wil=
l
> +       sample a syscall and next one after 100 msec.
> +
>
>  PAGEFAULTS
>  ----------
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 3c46de1a8d79bfe6..789eb0ffd5f90b61 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -185,6 +185,7 @@ struct trace {
>         } stats;
>         unsigned int            max_stack;
>         unsigned int            min_stack;
> +       unsigned long           sample_period_ms;
>         int                     raw_augmented_syscalls_args_size;
>         bool                    raw_augmented_syscalls;
>         bool                    fd_path_disabled;
> @@ -5219,6 +5220,7 @@ int cmd_trace(int argc, const char **argv)
>                      "start"),
>         OPT_BOOLEAN(0, "force-btf", &trace.force_btf, "Prefer btf_dump ge=
neral pretty printer"
>                        "to customized ones"),
> +       OPT_ULONG(0, "syscall-period", &trace.sample_period_ms, "syscall =
sampling period in ms"),
>         OPTS_EVSWITCH(&trace.evswitch),
>         OPT_END()
>         };
> @@ -5326,6 +5328,9 @@ int cmd_trace(int argc, const char **argv)
>                                 bpf_program__set_autoattach(prog, /*autoa=
ttach=3D*/false);
>                 }
>
> +               if (trace.sample_period_ms)
> +                       trace.skel->rodata->sample_period =3D trace.sampl=
e_period_ms * NSEC_PER_MSEC;
> +
>                 err =3D augmented_raw_syscalls_bpf__load(trace.skel);
>
>                 if (err < 0) {
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tool=
s/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index 4a62ed593e84edf8..12272620dcd73700 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -113,6 +113,22 @@ struct pids_filtered {
>         __uint(max_entries, 64);
>  } pids_filtered SEC(".maps");
>
> +struct sample_timestamp {
> +       __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +       __type(key, int);
> +       __type(value, __u64);
> +       __uint(max_entries, 1);
> +} sample_timestamp SEC(".maps");
> +
> +struct sample_filtered {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __type(key, pid_t);
> +       __type(value, bool);
> +       __uint(max_entries, MAX_CPUS);
> +} sample_filtered SEC(".maps");

Do you think MAX_CPUS provides enough entries? If there are MAX_CPUS
syscalls that have entered but haven't exited, new syscalls cannot
write to the map, which results in the new syscall's sys_exit not
being collected. This can lead to trace logs like the following:

210.947 (         ): tmux: server/4399 poll(ufds: 0x579c819eac40,
nfds: 51, timeout_msecs: 9)

which doesn't have a duration, because perf trace doesn't know when it
exits. For example, a poll system call can take a long time to exit,
if there are MAX_CPUS number of polls, they will occupy all the space
in the sample_filtered map.

> +       if (prev_ts) {
> +               if ((*prev_ts + sample_period) > timestamp)
> +                       return false;
> +               *prev_ts =3D timestamp;
> +       } else {
> +               bpf_map_update_elem(&sample_timestamp, &idx, &timestamp, =
BPF_ANY);
> +       }
> +
> +       bpf_map_update_elem(&sample_filtered, &pid, &ok, BPF_ANY);

and during polling, when a new syscall enters, this
bpf_map_update_elem() will return an error and fail to insert, and in
sys_exit(), this:

> +       if (!bpf_map_lookup_elem(&sample_filtered, &pid))
> +               return false;

returns false, and creates a sample with no duration.

In order to eliminate samples with no duration, there should be no
more than MAX_CPUS simultaneous syscalls, but I haven't yet created a
scenario where there are MAX_CPUS polls at the same time. (such
creation needs some tricks, because --syscall-period=3D1 allows maximum
<number-of-cpus> number of syscalls every millisecond)

That said, I agree that MAX_CPUS (4096) is generally sufficient for
the sample_filtered map in most situations.

Aside from this edge case, this patch looks good to me, I tested it with:

perf trace --syscall-period=3D500

   544.863 ( 0.008 ms): sshd/869528 rt_sigprocmask(how: UNBLOCK, nset:
0x7fffef5f71f0, oset: 0x7fffef5f7270, sigsetsize: 8) =3D 0
   545.034 ( 0.007 ms): tmux: server/4399 ioctl(fd: 54</dev/ptmx>,
cmd: FIONREAD, arg: 0x7ffe020ec758)          =3D 0
   593.054 (100.214 ms): gnome-shell/2419 poll(ufds: 0x6236d31eb850,
nfds: 15, timeout_msecs: 100)              =3D 0 (Timeout)
  1073.251 ( 0.059 ms): gmain/38955 inotify_add_watch(fd:
4<anon_inode:inotify>, pathname:
"/var/lib/fwupd/metadata/lvfs-testing", mask: 16789454) =3D -1 ENOENT
(No such file or directory)
  1073.641 ( 0.014 ms): tmux: server/4399 ioctl(fd: 54</dev/ptmx>,
cmd: FIONREAD, arg: 0x7ffe020ec758)          =3D 0
  1074.588 ( 0.013 ms): sshd/869528 rt_sigprocmask(how: UNBLOCK, nset:
0x7fffef5f71f0, oset: 0x7fffef5f7270, sigsetsize: 8) =3D 0
  1094.651 (100.370 ms): gnome-shell/2419 poll(ufds: 0x6236d31eb850,
nfds: 15, timeout_msecs: 100)              =3D 0 (Timeout)
  1596.817 (100.363 ms): gnome-shell/2419 poll(ufds: 0x6236d31eb850,
nfds: 15, timeout_msecs: 100)

The timestamp makes sense for the 500 ms period.

Thanks,
Howard
