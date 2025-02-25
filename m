Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31387DA7F
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Feb 2025 04:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740458453; cv=none; b=Zf5o4LEswIf3cl3XHGypx7dm4pjuk3CCybSU/NIPWJLc6U97ZEqad+kX2sjkMPcMaVe+vYCVHT/dI/Go8Dv9LfIV7JMW5fBHbqVtlcLtAbLefCOyecJPw1qGacZozsqxbPflhwg94bF7Pow2kCOJxdo0lX8fITsXt80/cX8TYCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740458453; c=relaxed/simple;
	bh=jmHpqU8Tw+XjLzSjlPepYMQyciQ3uXFUsvvUzYHSFaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/VfEjTNTTpYrsNZLsaMNeEEo1a3/MJ2cNggCSaUm1Lmawu98Zu4pEgFlpF8RFsuW0BggiehyXuoINVg6DMWxhqkYtMgAIeeG8Ac1/2+9bo4Y8Iss91t+jA3Kdf707+szNobxBQ1GgC2L0X290szMaoQ1t2hiB5IqK6IHG4myyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xoJxJZlB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xoJxJZlB"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2212222d4cdso88165ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Feb 2025 20:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740458450; x=1741063250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1zsdiMTXDV6ZhJHfzsay+wcqTS1rTUPK7gP/JhrUIs=;
        b=xoJxJZlB6SNfwK6xIAs2KmP6zsY+SGKQJ0k1U56J/12Xz7xjGlqzb8ZpWYkstzC1nH
         sNKqDvjcfTbJAEfo7h78POyypIcFunzvQrV7PMz7jQQxOW+JKTSf5Pagxh153P+mmYs6
         kkTSnI9uGMN6fGCoD4Iz0I82ZI/TeykiBMOsoOljZM4Jpr6OLB0WIIBCbHmu7rhy2ky0
         J70ZdBq07oNaX5uxLLaMCTeIHN2c+avUOXeHhajH61HqqDe3J1EguEM7XvDobwbggcxz
         9SX3+NGmYtnvVWNft71VwqNH+2a0bN0endxYpyKrcnbA/0fezPVFDvSR3+wk1fkHEM0o
         ofTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740458450; x=1741063250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1zsdiMTXDV6ZhJHfzsay+wcqTS1rTUPK7gP/JhrUIs=;
        b=m54BGaL5WIPzB78CaZyJuampRUJU9EChAHEiocIwZoY1Rxf0gBx4kynR4Y/PkF2MB+
         kf/BgAGNUqgb+X4lNGb8siudQtZbS0NFYp+sAUbzHOKHEb5ny4gcVP7G7Vc1JJRNqIrs
         Udid5kAisZ8q35OB0TRX059a7ePs2ANhQ3hc851/O/CjPYOB+SLDdIRA0488BvCHtYDF
         Xy9fb5vgYvvdU9b7q6uDMy0r50pWqrBBNumrl3TC3FtuwhpTyVA+KWdQixWQbVjxajcC
         tuSoD6FAL3gbfdwNiZejEcOHqc2VXVplerEOjk3VIWOY+EdXDPCxKbQvNcVV1u5uof7c
         LzsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbgQ/OsKtEDqjNIJDnRPdcQLxAMrAHoqUcxciXes61KmDiuAlZXrG7dJOybN2NfLICtGmOGX14ZcDY7HF2FRar@vger.kernel.org
X-Gm-Message-State: AOJu0YzpzEJA8azaAfxR4x7ogiE/ZFyhcgcOBCeI+Sl/s7mgwElv+zJb
	naGGXTsbPJ691mOaI+nG+tumiD35r/izBMgXlO9yWLiUJou+0IIVvBFVnR1/TAnrnOglLkLVuKV
	JjJXNppRVQlmGHcargrHeB3ASLdoIbD0geVLp
X-Gm-Gg: ASbGnctsZ9fQfwcuZHAYLsu5zWbkRmtUY5alnh2J5MJCefnibVPD8UVKJZjdzWX4bbo
	GPv8opTvp51UhuMBJThHQ1a88YyHoLCVXapjJle6VJ+BeoZoveA1iKpH9UtGUMShn1Oc9QdIPja
	H21tGp7Z7K
X-Google-Smtp-Source: AGHT+IFa1AEvP9ljfsJOlRWizCzprUG3Rj1cZgMEJgENmaVXmFGH0wXOZ2oYFLWdEKlcH8lL81dvvUNDkq5kV96FFb4=
X-Received: by 2002:a17:902:d581:b0:220:c905:689f with SMTP id
 d9443c01a7336-22307aab530mr2039075ad.25.1740458449763; Mon, 24 Feb 2025
 20:40:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z6_CL0RpUUvw0lR7@x1> <Z7TvZGjVix2asYWI@x1> <Z7T1LVSLo8EEMmkM@x1>
 <Z7UDlZKnqXRqNqQa@google.com> <Z7XsltyqUWrdKma0@x1> <Z7XvEFEZtCRZKG7Y@x1>
 <Z7ZIqpwffQbibwL2@google.com> <CAP-5=fWZXPjD3Ok5XmMwwaYt+9mL+V8t8fNSUdf-F5PPiEAvrg@mail.gmail.com>
 <Z7gllQZeg6U2OvZE@google.com> <CAP-5=fXEEMFgPF2aZhKsfrY_En+qoqX20dWfuE_ad73Uxf0ZHQ@mail.gmail.com>
 <Z70wHEl6Sp0H0c-3@google.com>
In-Reply-To: <Z70wHEl6Sp0H0c-3@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 24 Feb 2025 20:40:37 -0800
X-Gm-Features: AWEUYZm_oZZtXaDtbiRjDUhef71EJcifF8LJrpDuZ4qdgo0Mm6cgo1e7w7jChXI
Message-ID: <CAP-5=fUosOVUKi5tQ3gVtHhfApk0oH3r2zHDW7-i+_qASKm+Cg@mail.gmail.com>
Subject: Re: [PATCH] perf report: Add 'tgid' sort key
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 6:51=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Feb 24, 2025 at 10:18:37AM -0800, Ian Rogers wrote:
> > On Thu, Feb 20, 2025 at 11:04=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Thu, Feb 20, 2025 at 09:12:46AM -0800, Ian Rogers wrote:
> > > > On Wed, Feb 19, 2025 at 1:10=E2=80=AFPM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > On Wed, Feb 19, 2025 at 03:47:44PM +0100, Arnaldo Carvalho de Mel=
o wrote:
> > > > > > On Wed, Feb 19, 2025 at 03:37:10PM +0100, Arnaldo Carvalho de M=
elo wrote:
> > > > > > > On Tue, Feb 18, 2025 at 02:03:01PM -0800, Namhyung Kim wrote:
> > > > > > > > On Tue, Feb 18, 2025 at 10:01:33PM +0100, Arnaldo Carvalho =
de Melo wrote:
> > > > > > > > > On Tue, Feb 18, 2025 at 09:36:52PM +0100, Arnaldo Carvalh=
o de Melo wrote:
> > > > > > > > > > So the call to maps_fixup_end() will set maps->end_brok=
en to false,
> > > > > > > > > > since it fixed up the map ends, etc, but then we insert=
 more maps with
> > > > > > > > > > broken ends:
> > > > > > > > >
> > > > > > > > > > #6  0x0000000000633d52 in check_invariants (maps=3D0xf9=
67c0) at util/maps.c:95
> > > > > > > > > > 95                                            assert(ma=
p__end(prev) <=3D map__end(map));
> > > > > > > > > > (gdb) p prev->dso->name
> > > > > > > > > > $1 =3D 0xfc47ab "bpf_trampoline_6442522522"
> > > > > > > > >
> > > > > > > > > So the above map is created overlapping a previously exis=
ting map:
> > > > > > > > >
> > > > > > > > > root@number:~# perf probe -l
> > > > > > > > >   probe_perf:maps_fixup_end (on maps__fixup_end:1@util/ma=
ps.c in /home/acme/bin/perf with maps)
> > > > > > > > >   probe_perf:maps_insert (on maps__insert:1@util/maps.c i=
n /home/acme/bin/perf with maps name start end)
> > > > > > > > > root@number:~#
> > > > > > > > >
> > > > > > > > > root@number:~# perf trace --lib -e probe_perf:maps* perf =
record sleep
> > > > > > > > > <SNIP>
> > > > > > > > >    319.791 perf/1732173 probe_perf:maps_insert((634e5e) m=
aps=3D0x2d9715d0 name=3D"bpf_prog_6deef7357e7b4530_sd_fw_egress" start=3D0x=
ffffffffc0160788 end=3D0xffffffffc01607c8)
> > > > > > > > >    319.810 perf/1732173 probe_perf:maps_insert((634e5e) m=
aps=3D0x2d9715d0 name=3D"bpf_prog_6deef7357e7b4530_sd_fw_ingress" start=3D0=
xffffffffc01647b8 end=3D0xffffffffc01647f8)
> > > > > > > > >    319.822 perf/1732173 probe_perf:maps_insert((634e5e) m=
aps=3D0x2d9715d0 name=3D"bpf_prog_6deef7357e7b4530_sd_fw_egress" start=3D0x=
ffffffffc016482c end=3D0xffffffffc016486c)
> > > > > > > > >    319.834 perf/1732173 probe_perf:maps_insert((634e5e) m=
aps=3D0x2d9715d0 name=3D"bpf_prog_6deef7357e7b4530_sd_fw_ingress" start=3D0=
xffffffffc01648ac end=3D0xffffffffc01648ec)
> > > > > > > > >    319.845 perf/1732173 probe_perf:maps_insert((634e5e) m=
aps=3D0x2d9715d0 name=3D"bpf_prog_be31ae23198a0378_sd_devices" start=3D0xff=
ffffffc0186388 end=3D0xffffffffc01864b2)
> > > > > > > > >    319.857 perf/1732173 probe_perf:maps_insert((634e5e) m=
aps=3D0x2d9715d0 name=3D"bpf_trampoline_6442522522" start=3D0xffffffffc0147=
640 end=3D0xffffffffc0148640)
> > > > > > > > > [ perf record: Captured and wrote 0.035 MB perf.data (7 s=
amples) ]
> > > > > > > > > perf: util/maps.c:95: check_invariants: Assertion `map__e=
nd(prev) <=3D map__end(map)' failed.
> > > > > > > > > root@number:~#
> > > > > > > > >
> > > > > > > > > So a PERF_RECORD_KSYMBOL processing will add a map for
> > > > > > > > > "bpf_trampoline_6442522522" that has its start after befo=
re the
> > > > > > > > > "bpf_prog_40ddf486530245f5_sd_devices" start, ok, but end=
s after
> > > > > > > > > "bpf_prog_40ddf486530245f5_sd_devices", overlapping it.
> > > > > > > > >
> > > > > > > > > machine__process_ksymbol_register() does:
> > > > > > > > >
> > > > > > > > > 713                     map__set_start(map, event->ksymbo=
l.addr);
> > > > > > > > > 714                     map__set_end(map, map__start(map)=
 + event->ksymbol.len);
> > > > > > > > > 715                     err =3D maps__insert(machine__ker=
nel_maps(machine), map);
> > > > > > > > >
> > > > > > > > > And:
> > > > > > > > >
> > > > > > > > > (gdb) p /x event->ksymbol.addr
> > > > > > > > > $2 =3D 0xffffffffc0147a2c
> > > > > > > > > (gdb) p event->ksymbol.len
> > > > > > > > > $3 =3D 306
> > > > > > > >
> > > > > > > > Hmm.. so I think the situation is like below.
> > > > > > > >
> > > > > > > >              (bpf_trampoline_6442522522)
> > > > > > > >       +---------------------------------------+
> > > > > > > >       |                                       |
> > > > > > > >       |       +------------------------+      |
> > > > > > > >       |       | (bpf_prog_40ddf486...) | <----+----  adding=
 this
> > > > > > > >       |       |                        |      |
> > > > > > > >       |       |                        |      |
> > > > > > > >       |   c0147a2c                            |
> > > > > > > >       |                                       |
> > > > > > > >   c0147640                                 c0148640
> > > > > > > >
> > > > > > > > And it failed to add bpf_prog_40ddf486... in check_invarian=
ts() because
> > > > > > > > the end address is smaller than the previous map.
> > > > > > >
> > > > > > > No, it didn't fail to add, it managed to do it which left the=
 kernel
> > > > > > > maps in a broken state, with overlappings while it had a clea=
red
> > > > > > > ends_broken, then, later, when the checks_invariant is finall=
y called at
> > > > > > > perf record exit time:
> > > > > >
> > > > > > Nope, __maps__insert() should notice that the ends are broken a=
nd set
> > > > > > it:
> > > > > >
> > > > > >         if (nr_maps =3D=3D 1) {
> > > > > >                 /* If there's just 1 entry then maps are sorted=
. */
> > > > > >                 maps__set_maps_by_address_sorted(maps, true);
> > > > > >                 maps__set_maps_by_name_sorted(maps, maps_by_nam=
e !=3D NULL);
> > > > > >         } else {
> > > > > >                 /* Sorted if maps were already sorted and this =
map starts after the last one. */
> > > > > >                 maps__set_maps_by_address_sorted(maps,
> > > > > >                         maps__maps_by_address_sorted(maps) &&
> > > > > >                         map__end(maps_by_address[nr_maps - 2]) =
<=3D map__start(new));
> > > > > >                 maps__set_maps_by_name_sorted(maps, false);
> > > > > >         }
> > > > > >         if (map__end(new) < map__start(new))
> > > > > >                 RC_CHK_ACCESS(maps)->ends_broken =3D true;
> > > > > >
> > > > > >
> > > > > > humm, RC_CHK_ACCESS(maps)->ends_broken should be set for the ca=
se we
> > > > > > have and I think it isn't being... Then the bpf trampoline map =
that is
> > > > > > the last entry to be added is before the last entry and thus
> > > > > > maps_by_address_sorted is set to false, ends_broken continues f=
alse and
> > > > > > at the end maps_by_address_sorted is set to true and the last
> > > > > > check_invariants triggerrs the asserts...
> > > > >
> > > > > Right, probably it needs to set the ends_broken when the end addr=
ess of
> > > > > the new map is smaller than the previous (but the start address i=
s
> > > > > bigger) and fixup the end address when it sorts the maps by addre=
ss.
> > > >
> > > > Ugh, I get git blamed for ends_broken and I was wondering what the =
heck it is:
> > > > https://lore.kernel.org/all/20240210031746.4057262-2-irogers@google=
.com/
> > > > My memory is that when the rb-tree was built the maps put in it cou=
ld
> > > > be broken and ends_broken was to capture we were in this state as t=
he
> > > > sorting would get broken, invariants be off, etc.. The rb-tree
> > > > constructing code would then call maps__fixup_end. Having the calle=
r
> > > > call maps__fixup_end seems error prone, as does the whole
> > > > "ends_broken" thing - remember I was in the code to fix memory leak=
s
> > > > so modifying the maps API wasn't front of mind. I added ends_broken=
,
> > > > the original rb-tree had no notion of it, because I was trying to g=
et
> > > > the invariants right for the testing I could do and ends_broken was
> > > > the pragmatic thing to do for odd cases like kernel modules before
> > > > maps__fixup_end is called.
> > > >
> > > > The maps API has evolved and we have a pretty robust, but possibly =
not
> > > > fast, maps__fixup_overlap_and_insert:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/maps.h?h=3Dperf-tools-next#n69
> > > > I think ideally we'd make maps__insert uphold the invariants and no=
t
> > > > have ends_broken. I'm worried that making ends_broken more load
> > > > bearing isn't the right thing to do, we may even be able to not hav=
e
> > > > the variable for the "ifndef NDEBUG" case, which making it load
> > > > bearing would completely defeat.
> > > >
> > > > So I think the fix here should be to understand the maps constructi=
on
> > > > code for the modules, try to work out why maps__fixup_end wasn't
> > > > called, perhaps migrate the code to maps__fixup_overlap_and_insert =
or
> > > > add a missed maps__fixup_end call.
> > >
> > > IIUC module size in /proc/modules are wrong due to the reason in the
> > > commit 876e80cf83d10585 ("perf tools: Fixup end address of modules") =
and
> > > it called maps__fixup_end() for that.
> > >
> > > But the problem is some BPF maps processed at real-time during the
> > > build-id processing at the end of perf record.  One map is inside of
> > > another and check_invariants() didn't expect such maps and crashed.
> >
> > I thought the real-time processing had to use
> > maps__fixup_overlap_and_insert (rather than maps__insert) as mmap
> > events only give us VMA data and two mmaps may have been merged.
> > Shouldn't doing this change be the simplest fix?
>
> Make sense.  How about this?

Lgtm, I have no way to test the issue. Why does maps__fixup_end need
to get pushed later?

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> ---8<---
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 316f0879e5e08d66..d80b34717090db44 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -717,7 +717,7 @@ static int machine__process_ksymbol_register(struct m=
achine *machine,
>
>                 map__set_start(map, event->ksymbol.addr);
>                 map__set_end(map, map__start(map) + event->ksymbol.len);
> -               err =3D maps__insert(machine__kernel_maps(machine), map);
> +               err =3D maps__fixup_overlap_and_insert(machine__kernel_ma=
ps(machine), map);
>                 if (err) {
>                         err =3D -ENOMEM;
>                         goto out;
> @@ -1459,8 +1459,6 @@ static int machine__create_modules(struct machine *=
machine)
>         if (modules__parse(modules, machine, machine__create_module))
>                 return -1;
>
> -       maps__fixup_end(machine__kernel_maps(machine));
> -
>         if (!machine__set_modules_path(machine))
>                 return 0;
>
> @@ -1554,6 +1552,8 @@ int machine__create_kernel_maps(struct machine *mac=
hine)
>                 }
>         }
>
> +       maps__fixup_end(machine__kernel_maps(machine));
> +
>  out_put:
>         dso__put(kernel);
>         return ret;
