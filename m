Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E9984047;
	Wed,  4 Sep 2024 21:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484308; cv=none; b=AwVLfnnuCsOZCeokPhF/ShqE4zdR8/a3kFAY5d2g0KFo+6mv7ZLeVmuiAh97faf/C8dYnOduvV5kanLMX9Td8HLtF0fTJEX8dWtA6Vc2Rlfao85BpXQsp68QnxkhduH+g6vYB6SkI9MehSqyCj4jWeWf6REWNzNBteAvLAnyu/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484308; c=relaxed/simple;
	bh=SH+L3rB/khEoF6XjAAaXUYc53ekBjksTFPF9lDOwH18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGyoxXvrDz9J/syUHvfHCBa4SpUx5PcjEnAbAWPC7zmkVmYGGV3bwqCo0u7Q6kExkPMxzWt/OdznZmTpEIdz+qypgdCR/+Em2ieTZuVQGFfgJtm4l/+Xi5F1nbgyG1sB1k2Llz61g9Heo524rx0pNXMq+OXyOnKLazKxWTCkNqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrNcxayl; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrNcxayl"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6d5a4615a56so12883407b3.0;
        Wed, 04 Sep 2024 14:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725484306; x=1726089106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6F5DN8VG4etoFkTw4aSiBhFWv4u4w1haZzJw1wqLHPw=;
        b=SrNcxayln8X/1oU4va6gV+hbKU2DnRIGeTNRFIVJMMuAYF4aSGXtLIQ7/7VNy3qCLC
         /hIAgSRXznC7sWLa66c7WpjQ2anoBg5K/wgNnnqPI4MesEY4S1A6LOsACdQnTcH2EM9G
         gSsDoOAh5KqCqvMArWOOU9hZl0mt7qGTSUvMHA1gHdSwfANFYncgNO6rBePtGcOrYtqU
         ZC3WSzZoZKomh4CSSBnlCVIWwKUSUJptRFIhoo0PivCThZn5fSdeeXDRDJB0cVFGnFIN
         mCBUfnCrThUPN6BxwPkeNHsEd46PaweXoKOOWXpjyE8L3O2jTj8GWq1KlgV5wiz+uVOQ
         663Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725484306; x=1726089106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6F5DN8VG4etoFkTw4aSiBhFWv4u4w1haZzJw1wqLHPw=;
        b=qeASymz7OQpDBGUYte+Z2GzyMo0OcBytUcPjv1qTW3v0r5rED3yo7GF7Z1ekfdA9c/
         joozZG5xmgHiP6za6TnQbTkhlyqPLQxH3HCWGkwiqwDd/Uuxg2ymWQAo26Jz5qxiEgBI
         KbAdau2lNLWXp0O+IzAISy/y2IeGJBsO/uvNk6u/OPxmtwv0z9fOSBdNxQC0IKjvTzjp
         rYbdXPx9ivi7C/vgRF207LkMzCbSp6xAQShAQHq6D4xhR02rye4DgijTVRIXEvps7Mt0
         t99BUvEHUXrJm80SFgMGimJL8NvYFud1JoNNlwqeweCLK+WDup7aPceG3voxSKyLplJZ
         EZhw==
X-Forwarded-Encrypted: i=1; AJvYcCVfN8M4gLYrZ4hdF37MCBpceDgvelczFlQ5yXS5xKBzXcTe8VD5QywyHHlrxkNzzj9ekBXHEqgO9aMZKVRYWrFJOg==@vger.kernel.org, AJvYcCVfSFre355lwS2Q9PfaIgW4Rsi7McLiGzu824ejKM2hcHwNsuvdLr2jqlgTWaQQJD/TUzZ5GKI0lOSzar0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgy9ZRuScLozyywTZEqEMMgJDPXs+wyHD//xywU9bMJdKhU9iH
	+s7bD+TOIB+pGNg/XU2B44BnPWT8IU6rY0ohtxnI+IUEw0MoalnVPFPLdbnRMmXjwlx6UrReLmV
	yb3W5ZNHA6GRKN7F5tZQiPLtRYhA=
X-Google-Smtp-Source: AGHT+IFC9FBEyB4E58BcbWrE8kJhWa503in7k0Hew0aHWs0f/gFLefKmGDwvp2AnSC2VIjLTXsV+PfV7M9CMpeegz2w=
X-Received: by 2002:a05:690c:6c13:b0:6b0:70fc:f6e4 with SMTP id
 00721157ae682-6db234bf55emr43468167b3.15.1725484305865; Wed, 04 Sep 2024
 14:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824163322.60796-1-howardchu95@gmail.com> <20240824163322.60796-7-howardchu95@gmail.com>
 <Zti6mc3Lt5jC1owY@x1>
In-Reply-To: <Zti6mc3Lt5jC1owY@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 4 Sep 2024 14:11:35 -0700
Message-ID: <CAH0uvojWQz_K5S7nLavGW6K6mU6Y7TKoZAWpcut=AgbXtr6Wng@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] perf trace: Collect augmented data using BPF
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Arnaldo,

On Wed, Sep 4, 2024 at 12:53=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Sun, Aug 25, 2024 at 12:33:20AM +0800, Howard Chu wrote:
> > Include trace_augment.h for TRACE_AUG_MAX_BUF, so that BPF reads
> > TRACE_AUG_MAX_BUF bytes of buffer maximum.
> >
> > Determine what type of argument and how many bytes to read from user sp=
ace, us ing the
> > value in the beauty_map. This is the relation of parameter type and its=
 corres ponding
> > value in the beauty map, and how many bytes we read eventually:
> >
> > string: 1                          -> size of string (till null)
> > struct: size of struct             -> size of struct
> > buffer: -1 * (index of paired len) -> value of paired len (maximum: TRA=
CE_AUG_ MAX_BUF)
> >
> > After reading from user space, we output the augmented data using
> > bpf_perf_event_output().
> >
> > If the struct augmenter, augment_sys_enter() failed, we fall back to
> > using bpf_tail_call().
> >
> > I have to make the payload 6 times the size of augmented_arg, to pass t=
he
> > BPF verifier.
> >
> > Committer notes:
> >
> > It works, but we need to wire it up to the userspace specialized pretty
> > printer, otherwise we get things like:
> >
> >   root@number:~# perf trace -e connect ssh localhost
> >        0.000 ( 0.010 ms): :784442/784442 connect(fd: 3, uservaddr: {2,}=
, addrlen: 16)                          =3D 0
> >        0.016 ( 0.006 ms): :784442/784442 connect(fd: 3, uservaddr: {10,=
}, addrlen: 28)                         =3D 0
> >        0.033 ( 0.096 ms): :784442/784442 connect(fd: 3, uservaddr: {10,=
}, addrlen: 28)                         =3D 0
> >   root@localhost's password:     71.292 ( 0.037 ms): ssh/784442 connect=
(fd: 4, uservaddr: {1,{['/','v','a','r','/','r','u','n','/','.','h','e','i'=
,'m',],},}, addrlen: 110) =3D 0
> >       72.087 ( 0.013 ms): ssh/784442 connect(fd: 4, uservaddr: {1,{['/'=
,'v','a','r','/','r','u','n','/','.','h','e','i','m',],},}, addrlen: 110) =
=3D 0
> >
> >   root@number:~#
> >
> > When we used to have:
> >
> >   root@number:~# perf trace -e connect ssh localhost
> >        0.000 ( 0.011 ms): ssh/786564 connect(fd: 3, uservaddr: { .famil=
y: INET, port: 22, addr: 127.0.0.1 }, addrlen: 16) =3D 0
> >        0.017 ( 0.006 ms): ssh/786564 connect(fd: 3, uservaddr: { .famil=
y: INET6, port: 22, addr: ::1 }, addrlen: 28) =3D 0
> >        0.263 ( 0.043 ms): ssh/786564 connect(fd: 3, uservaddr: { .famil=
y: INET6, port: 22, addr: ::1 }, addrlen: 28) =3D 0
> >       63.770 ( 0.044 ms): ssh/786564 connect(fd: 4, uservaddr: { .famil=
y: LOCAL, path: /var/run/.heim_org.h5l.kcm-socket }, addrlen: 110) =3D 0
> >       65.467 ( 0.042 ms): ssh/786564 connect(fd: 4, uservaddr: { .famil=
y: LOCAL, path: /var/run/.heim_org.h5l.kcm-socket }, addrlen: 110) =3D 0
> >   root@localhost's password:
> >
> > That is closer to what strace produces:
> >
> >   root@number:~# strace -e connect ssh localhost
> >   connect(3, {sa_family=3DAF_INET, sin_port=3Dhtons(22), sin_addr=3Dine=
t_addr("127.0.0.1")}, 16) =3D 0
> >   connect(3, {sa_family=3DAF_INET6, sin6_port=3Dhtons(22), sin6_flowinf=
o=3Dhtonl(0), inet_pton(AF_INET6, "::1", &sin6_addr), sin6_scope_id=3D0}, 2=
8) =3D 0
> >   connect(3, {sa_family=3DAF_INET6, sin6_port=3Dhtons(22), sin6_flowinf=
o=3Dhtonl(0), inet_pton(AF_INET6, "::1", &sin6_addr), sin6_scope_id=3D0}, 2=
8) =3D 0
> >   connect(4, {sa_family=3DAF_UNIX, sun_path=3D"/var/run/.heim_org.h5l.k=
cm-socket"}, 110) =3D 0
> >   connect(4, {sa_family=3DAF_UNIX, sun_path=3D"/var/run/.heim_org.h5l.k=
cm-socket"}, 110) =3D 0
> >   root@localhost's password:
> >
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Link: https://lore.kernel.org/r/20240815013626.935097-10-howardchu95@gm=
ail.com
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 114 +++++++++++++++++-
> >  1 file changed, 113 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/to=
ols/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > index 0acbd74e8c76..f29a8dfca044 100644
> > --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > @@ -7,6 +7,8 @@
> >   */
> >
> >  #include "vmlinux.h"
> > +#include "../trace_augment.h"
> > +
> >  #include <bpf/bpf_helpers.h>
> >  #include <linux/limits.h>
> >
> > @@ -124,6 +126,25 @@ struct augmented_args_tmp {
> >       __uint(max_entries, 1);
> >  } augmented_args_tmp SEC(".maps");
> >
> > +struct beauty_payload_enter {
> > +     struct syscall_enter_args args;
> > +     struct augmented_arg aug_args[6];
> > +};
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ pahole -C augmented_arg /tmp/bui=
ld/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o
> struct augmented_arg {
>         unsigned int               size;                 /*     0     4 *=
/
>         int                        err;                  /*     4     4 *=
/
>         char                       value[4096];          /*     8  4096 *=
/
>
>         /* size: 4104, cachelines: 65, members: 3 */
>         /* last cacheline: 8 bytes */
> };
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ pahole -C syscall_enter_args /tm=
p/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o
> struct syscall_enter_args {
>         unsigned long long         common_tp_fields;     /*     0     8 *=
/
>         long                       syscall_nr;           /*     8     8 *=
/
>         unsigned long              args[6];              /*    16    48 *=
/
>
>         /* size: 64, cachelines: 1, members: 3 */
> };
>
> So the entry has the theoretical max limit for the augmented payload
> which would be 6 * sizeof(struct augmented_arg) + the common header for
> tracepoints (unaugmented), a lot of space, but...

Yes, if I don't use this much space, and try to do a flexible payload
length, I won't be able to pass the BPF verifier. I will try to fix
this wasting problem.

>
> > +static int augment_sys_enter(void *ctx, struct syscall_enter_args *arg=
s)
> > +{
> > +     bool augmented, do_output =3D false;
> > +     int zero =3D 0, size, aug_size, index, output =3D 0,
> > +         value_size =3D sizeof(struct augmented_arg) - offsetof(struct=
 augmented_arg, value);
> > +     unsigned int nr, *beauty_map;
> > +     struct beauty_payload_enter *payload;
> > +     void *arg, *payload_offset;
> > +
> > +     /* fall back to do predefined tail call */
> > +     if (args =3D=3D NULL)
> > +             return 1;
> > +
> > +     /* use syscall number to get beauty_map entry */
> > +     nr             =3D (__u32)args->syscall_nr;
> > +     beauty_map     =3D bpf_map_lookup_elem(&beauty_map_enter, &nr);
>
> If we don't set up the entry for this syscall, then there are no
> pointers to collect, we return early and the tracepoint will not filter
> it and there it goes, up unmodified, if not already filtered by a
> tracepoint filter, ok, I'll add these comments here.

Thank you.

>
> > +     /* set up payload for output */
> > +     payload        =3D bpf_map_lookup_elem(&beauty_payload_enter_map,=
 &zero);
> > +     payload_offset =3D (void *)&payload->aug_args;
> > > +   if (beauty_map =3D=3D NULL || payload =3D=3D NULL)
> > +             return 1;
>
> We can save the lookup for payload if the one for beauty_map returned
> NULL, I'll do this fixup.

Thanks that makes sense.

>
> > +     /* copy the sys_enter header, which has the syscall_nr */
> > +     __builtin_memcpy(&payload->args, args, sizeof(struct syscall_ente=
r_args));
>
>
> > +     /*
> > +      * Determine what type of argument and how many bytes to read fro=
m user space, using the
> > +      * value in the beauty_map. This is the relation of parameter typ=
e and its corresponding
> > +      * value in the beauty map, and how many bytes we read eventually=
:
> > +      *
> > +      * string: 1                          -> size of string
> > +      * struct: size of struct             -> size of struct
> > +      * buffer: -1 * (index of paired len) -> value of paired len (max=
imum: TRACE_AUG_MAX_BUF)
>
> 'paired_len'? Ok, 1, size of string or struct

I mean the buffer always comes with a size indicator. For instance
read syscall's 'buf' and 'count', in this case 'count' will pair with
'buf'. Sorry for the confusion. See below:

read: (unsigned int fd, char *buf, size_t count)

>
>
> Will continue the detailed analysis later, as I need to change the
> existing BPF collector, before applying this, to match the protocol here
> (that will always have the size of each argument encoded in the ring
> buffer, easier, but uses more space).

Thank you for adding the protocol data size fix.

>
> - Arnaldo
>
> > +      */
> > +     for (int i =3D 0; i < 6; i++) {
> > +             arg =3D (void *)args->args[i];
> > +             augmented =3D false;
> > +             size =3D beauty_map[i];
> > +             aug_size =3D size; /* size of the augmented data read fro=
m user space */
> > +
> > +             if (size =3D=3D 0 || arg =3D=3D NULL)
> > +                     continue;
> > +
> > +             if (size =3D=3D 1) { /* string */
> > +                     aug_size =3D bpf_probe_read_user_str(((struct aug=
mented_arg *)payload_offset)->value, value_size, arg);
> > +                     /* minimum of 0 to pass the verifier */
> > +                     if (aug_size < 0)
> > +                             aug_size =3D 0;
> > +
> > +                     augmented =3D true;
> > +             } else if (size > 0 && size <=3D value_size) { /* struct =
*/
> > +                     if (!bpf_probe_read_user(((struct augmented_arg *=
)payload_offset)->value, size, arg))
> > +                             augmented =3D true;
> > +             } else if (size < 0 && size >=3D -6) { /* buffer */
> > +                     index =3D -(size + 1);
> > +                     aug_size =3D args->args[index];
> > +
> > +                     if (aug_size > TRACE_AUG_MAX_BUF)
> > +                             aug_size =3D TRACE_AUG_MAX_BUF;
> > +
> > +                     if (aug_size > 0) {
> > +                             if (!bpf_probe_read_user(((struct augment=
ed_arg *)payload_offset)->value, aug_size, arg))
> > +                                     augmented =3D true;
> > +                     }
> > +             }
> > +
> > +             /* write data to payload */
> > +             if (augmented) {
> > +                     int written =3D offsetof(struct augmented_arg, va=
lue) + aug_size;
> > +
> > +                     ((struct augmented_arg *)payload_offset)->size =
=3D aug_size;
> > +                     output +=3D written;
> > +                     payload_offset +=3D written;
> > +                     do_output =3D true;
> > +             }
> > +     }
> > +
> > +     if (!do_output)
> > +             return 1;
> > +
> > +     return augmented__beauty_output(ctx, payload, sizeof(struct sysca=
ll_enter_args) + output);
>
> We end up pushing up to the ring buffer all the way to

Thanks,
Howard
