Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C879E211A0E
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Feb 2025 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071580; cv=none; b=OjmFf2/FACbke5FNxuqzsavps6xsvl53z8M/axOSLqAdY22ZZebgTf4eXgpnHBqolNZuwrJvWo0ZklDroR3Pw/NBCJodsiD6LnMnOEFRsgL2BBQQKDVk0XY48GbghGBwS4bNL7SP6jikA6RLVRWXIHpBxAytlJA+S9fHsJaE95E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071580; c=relaxed/simple;
	bh=VjEUim42RSKuscI0z8MEmZMo+05s6Eo2c7LkAH8dkhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EmcMETb16R54zlkt3JysGF6kdWXv3LIaEPEylG6R5upymVAJKx4kvuAilXqoENptBS9s7Sxzg1jedX6mn8tUkLVzu0goOO3Xanoj4LT0PsBHxOLpKs7lisP60p4DWhncEH6O5RVBoKHVddCiSIVMiIgEKpLC5ku7olz+uF6eJpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=edQjQSr/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="edQjQSr/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-219f6ca9a81so165525ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Feb 2025 09:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740071578; x=1740676378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KlGSfTFtzcO4Aa2rZfsye6/UvfCZdlGmKuoWZ/5IZs=;
        b=edQjQSr/2QuSetj8LFn/jiq29CEC+88jyfaxrnzgmDUGtVZlFkhwlxomOi06CjtR7l
         CupAhBkyqmIaWiJkLQ633knyPX9Xsyda7+UJsq+QslQm8GX0SwCcGx8/QRKztmUVG9Pq
         9Pstest3rvki+J7MU2Cfr6+J+0n/FCIR4jlGVB1Q1W8BWm2DSj7zvKajDXOCFLj3QtR9
         tvACjDftUF1Rd0RJ9aeyisj9tFgurTfZJYbsyp6ClJLIVR5+kIAQE8RYihMxYpJxNJuX
         xkgJeKZgymhS8LLxH82PDr/YjrkiVlUOPNkJs0JiW8jZ3V3UW5N0ohEbcKu4N2KOwT+R
         maEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740071578; x=1740676378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KlGSfTFtzcO4Aa2rZfsye6/UvfCZdlGmKuoWZ/5IZs=;
        b=WSpvTG5MaQqeep42RfzHfvn5B7RmxC1LDViInBjYiHyyr9i4W9Ai4Wm7szvqrF6uRf
         8OOoR3A6zxr/UWs/huQOlQp2YdIiMpWa92aDo/Y8biqWIhyhSEHwN1G6c17oscgHf58c
         Izi+RsZJ4FXmjAHIx0wAeUy7zd9lDXjbaXm7ZfnhcPumuGuZdnKl0V0R08ct8jCJp4Nj
         vGux9jS8x2U07ahro4JOKzDsZSLs4F0toya3Hksd1GU/Vtj73rXXaK14vQsNqEMAICxe
         dNJxec9DR+np/WzD9Lcms+jOgdT0JO2x8ZaRFm3MRvNTkuKPhhcvPhsEdFrZsgR6bShH
         vgrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU74a7xbIlg5A0dACxYoUcxRSj6Mt8IUC5sA/FNxL8PXtAsJVc+PEcag6MDHh76liSwuXD+zA5uXVr8RCkkFvZf@vger.kernel.org
X-Gm-Message-State: AOJu0YydTr6jFVQrzZGd721+14u2gaLXdYYhWCXp0WYL5oijkweQKEod
	Hud2NNZVktkgS75DV9oUGHVOl+LuCdSU4rLrRxnma+JENoiGeAytMLKz9WsaEaS7QnHgHbQ8R7D
	KLzfCIhXGD6b0p67FX58iRXfm37WFcyU+yT+l
X-Gm-Gg: ASbGncvKhh5Y8T0MUQQ6D94eJYPI1MDY5ijd3QplHy70+yNOR8/VypVETKTIU2S+74P
	kYoxNaFFi88RKxWm1lv/uAdOjb6OOekJjZL6dpa2dq9bwXwNZhG+XzJc37G9cHiQrvZYzdJQMIA
	C5jJb6pD5YQz3QqgLeCLiu5+vf
X-Google-Smtp-Source: AGHT+IEbnyT8CyvE4wQCUwedgMi5/VDT/ZLkqjRx5/WhkkqXWj9ClL8T5083//YuVsgDBobfYp7KJ6NE8jO2P0CMQUE=
X-Received: by 2002:a17:902:e54b:b0:216:6dab:803b with SMTP id
 d9443c01a7336-2218ddbe5admr3333875ad.18.1740071577879; Thu, 20 Feb 2025
 09:12:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z60NFEAf2C8cL8Xh@x1> <Z60Ndm8VVI4Ao31U@x1> <CAP-5=fXw09MM5XyozJMM3FjMANJei1aNVmBghSEQFiCKAtJmXw@mail.gmail.com>
 <CAP-5=fUqcykMdApHVweETg9bp2EVPJhJOj_PR8cByOOA6OyQGw@mail.gmail.com>
 <Z6_CL0RpUUvw0lR7@x1> <Z7TvZGjVix2asYWI@x1> <Z7T1LVSLo8EEMmkM@x1>
 <Z7UDlZKnqXRqNqQa@google.com> <Z7XsltyqUWrdKma0@x1> <Z7XvEFEZtCRZKG7Y@x1> <Z7ZIqpwffQbibwL2@google.com>
In-Reply-To: <Z7ZIqpwffQbibwL2@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 20 Feb 2025 09:12:46 -0800
X-Gm-Features: AWEUYZlHGhRU4sD-1g0LIaOSDwZHHqpZNdXEVjobFcls9gKqATlprv-r84r9ah4
Message-ID: <CAP-5=fWZXPjD3Ok5XmMwwaYt+9mL+V8t8fNSUdf-F5PPiEAvrg@mail.gmail.com>
Subject: Re: [PATCH] perf report: Add 'tgid' sort key
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 1:10=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Feb 19, 2025 at 03:47:44PM +0100, Arnaldo Carvalho de Melo wrote:
> > On Wed, Feb 19, 2025 at 03:37:10PM +0100, Arnaldo Carvalho de Melo wrot=
e:
> > > On Tue, Feb 18, 2025 at 02:03:01PM -0800, Namhyung Kim wrote:
> > > > On Tue, Feb 18, 2025 at 10:01:33PM +0100, Arnaldo Carvalho de Melo =
wrote:
> > > > > On Tue, Feb 18, 2025 at 09:36:52PM +0100, Arnaldo Carvalho de Mel=
o wrote:
> > > > > > So the call to maps_fixup_end() will set maps->end_broken to fa=
lse,
> > > > > > since it fixed up the map ends, etc, but then we insert more ma=
ps with
> > > > > > broken ends:
> > > > >
> > > > > > #6  0x0000000000633d52 in check_invariants (maps=3D0xf967c0) at=
 util/maps.c:95
> > > > > > 95                                            assert(map__end(p=
rev) <=3D map__end(map));
> > > > > > (gdb) p prev->dso->name
> > > > > > $1 =3D 0xfc47ab "bpf_trampoline_6442522522"
> > > > >
> > > > > So the above map is created overlapping a previously existing map=
:
> > > > >
> > > > > root@number:~# perf probe -l
> > > > >   probe_perf:maps_fixup_end (on maps__fixup_end:1@util/maps.c in =
/home/acme/bin/perf with maps)
> > > > >   probe_perf:maps_insert (on maps__insert:1@util/maps.c in /home/=
acme/bin/perf with maps name start end)
> > > > > root@number:~#
> > > > >
> > > > > root@number:~# perf trace --lib -e probe_perf:maps* perf record s=
leep
> > > > > <SNIP>
> > > > >    319.791 perf/1732173 probe_perf:maps_insert((634e5e) maps=3D0x=
2d9715d0 name=3D"bpf_prog_6deef7357e7b4530_sd_fw_egress" start=3D0xffffffff=
c0160788 end=3D0xffffffffc01607c8)
> > > > >    319.810 perf/1732173 probe_perf:maps_insert((634e5e) maps=3D0x=
2d9715d0 name=3D"bpf_prog_6deef7357e7b4530_sd_fw_ingress" start=3D0xfffffff=
fc01647b8 end=3D0xffffffffc01647f8)
> > > > >    319.822 perf/1732173 probe_perf:maps_insert((634e5e) maps=3D0x=
2d9715d0 name=3D"bpf_prog_6deef7357e7b4530_sd_fw_egress" start=3D0xffffffff=
c016482c end=3D0xffffffffc016486c)
> > > > >    319.834 perf/1732173 probe_perf:maps_insert((634e5e) maps=3D0x=
2d9715d0 name=3D"bpf_prog_6deef7357e7b4530_sd_fw_ingress" start=3D0xfffffff=
fc01648ac end=3D0xffffffffc01648ec)
> > > > >    319.845 perf/1732173 probe_perf:maps_insert((634e5e) maps=3D0x=
2d9715d0 name=3D"bpf_prog_be31ae23198a0378_sd_devices" start=3D0xffffffffc0=
186388 end=3D0xffffffffc01864b2)
> > > > >    319.857 perf/1732173 probe_perf:maps_insert((634e5e) maps=3D0x=
2d9715d0 name=3D"bpf_trampoline_6442522522" start=3D0xffffffffc0147640 end=
=3D0xffffffffc0148640)
> > > > > [ perf record: Captured and wrote 0.035 MB perf.data (7 samples) =
]
> > > > > perf: util/maps.c:95: check_invariants: Assertion `map__end(prev)=
 <=3D map__end(map)' failed.
> > > > > root@number:~#
> > > > >
> > > > > So a PERF_RECORD_KSYMBOL processing will add a map for
> > > > > "bpf_trampoline_6442522522" that has its start after before the
> > > > > "bpf_prog_40ddf486530245f5_sd_devices" start, ok, but ends after
> > > > > "bpf_prog_40ddf486530245f5_sd_devices", overlapping it.
> > > > >
> > > > > machine__process_ksymbol_register() does:
> > > > >
> > > > > 713                     map__set_start(map, event->ksymbol.addr);
> > > > > 714                     map__set_end(map, map__start(map) + event=
->ksymbol.len);
> > > > > 715                     err =3D maps__insert(machine__kernel_maps=
(machine), map);
> > > > >
> > > > > And:
> > > > >
> > > > > (gdb) p /x event->ksymbol.addr
> > > > > $2 =3D 0xffffffffc0147a2c
> > > > > (gdb) p event->ksymbol.len
> > > > > $3 =3D 306
> > > >
> > > > Hmm.. so I think the situation is like below.
> > > >
> > > >                    (bpf_trampoline_6442522522)
> > > >             +---------------------------------------+
> > > >       |                                       |
> > > >       |       +------------------------+      |
> > > >       |       | (bpf_prog_40ddf486...) | <----+----  adding this
> > > >       |       |                        |      |
> > > >       |       |                        |      |
> > > >       |   c0147a2c                            |
> > > >       |                                       |
> > > >         c0147640                                 c0148640
> > > >
> > > > And it failed to add bpf_prog_40ddf486... in check_invariants() bec=
ause
> > > > the end address is smaller than the previous map.
> > >
> > > No, it didn't fail to add, it managed to do it which left the kernel
> > > maps in a broken state, with overlappings while it had a cleared
> > > ends_broken, then, later, when the checks_invariant is finally called=
 at
> > > perf record exit time:
> >
> > Nope, __maps__insert() should notice that the ends are broken and set
> > it:
> >
> >         if (nr_maps =3D=3D 1) {
> >                 /* If there's just 1 entry then maps are sorted. */
> >                 maps__set_maps_by_address_sorted(maps, true);
> >                 maps__set_maps_by_name_sorted(maps, maps_by_name !=3D N=
ULL);
> >         } else {
> >                 /* Sorted if maps were already sorted and this map star=
ts after the last one. */
> >                 maps__set_maps_by_address_sorted(maps,
> >                         maps__maps_by_address_sorted(maps) &&
> >                         map__end(maps_by_address[nr_maps - 2]) <=3D map=
__start(new));
> >                 maps__set_maps_by_name_sorted(maps, false);
> >         }
> >         if (map__end(new) < map__start(new))
> >                 RC_CHK_ACCESS(maps)->ends_broken =3D true;
> >
> >
> > humm, RC_CHK_ACCESS(maps)->ends_broken should be set for the case we
> > have and I think it isn't being... Then the bpf trampoline map that is
> > the last entry to be added is before the last entry and thus
> > maps_by_address_sorted is set to false, ends_broken continues false and
> > at the end maps_by_address_sorted is set to true and the last
> > check_invariants triggerrs the asserts...
>
> Right, probably it needs to set the ends_broken when the end address of
> the new map is smaller than the previous (but the start address is
> bigger) and fixup the end address when it sorts the maps by address.

Ugh, I get git blamed for ends_broken and I was wondering what the heck it =
is:
https://lore.kernel.org/all/20240210031746.4057262-2-irogers@google.com/
My memory is that when the rb-tree was built the maps put in it could
be broken and ends_broken was to capture we were in this state as the
sorting would get broken, invariants be off, etc.. The rb-tree
constructing code would then call maps__fixup_end. Having the caller
call maps__fixup_end seems error prone, as does the whole
"ends_broken" thing - remember I was in the code to fix memory leaks
so modifying the maps API wasn't front of mind. I added ends_broken,
the original rb-tree had no notion of it, because I was trying to get
the invariants right for the testing I could do and ends_broken was
the pragmatic thing to do for odd cases like kernel modules before
maps__fixup_end is called.

The maps API has evolved and we have a pretty robust, but possibly not
fast, maps__fixup_overlap_and_insert:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/maps.h?h=3Dperf-tools-next#n69
I think ideally we'd make maps__insert uphold the invariants and not
have ends_broken. I'm worried that making ends_broken more load
bearing isn't the right thing to do, we may even be able to not have
the variable for the "ifndef NDEBUG" case, which making it load
bearing would completely defeat.

So I think the fix here should be to understand the maps construction
code for the modules, try to work out why maps__fixup_end wasn't
called, perhaps migrate the code to maps__fixup_overlap_and_insert or
add a missed maps__fixup_end call.

Given the blame I kind of feel responsible for this, but the real
issue is adding the invariant checks has caught a latent bug that the
rb-tree code would have just ignored and possibly been broken as a
consequence. I lack bandwidth and a reproduction so thank you for
digging into this.

Thanks,
Ian
