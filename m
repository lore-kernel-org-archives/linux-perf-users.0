Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C51406800
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537907; cv=pass; b=CRTPuk7CFeWK0PIfy4v1KW7aNkzhIpBIN5hzA3UoyAoGhH5XN8MQ87F7GGGkXA2GHIglFCJV/Ra/zMao3n0ggGvhS/CVY+0zldMEzVt5D8pp1Hg2iQuUS6Ux00BV769Iep18Yh0diiPEHIqol2BgGcW8vMPjeJImR5dDP869ES8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537907; c=relaxed/simple;
	bh=l+xPp7FywKFPWb2AQvUcAguGOY2SNpBoOoRy8jsaV/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HU5nIyG50PhDunJmRgfDwMVb5VORhvz3z6Fc+/YsvGxYInvwCI1rGRV+fRnGeCyAeHD8n4Zn8eBGUvDkmMIfG20MJrN+bIqsW+Lr1zxAhojJ3xiPwDUE5dT5wm9l2rci210ufR2MQaeP/pFkjEBhbMmSdgGLYitupDUteRlloEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KU2urHat; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KU2urHat"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0b1a48855so180575ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 08:38:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781537904; cv=none;
        d=google.com; s=arc-20240605;
        b=jV2fRVN2Zn+1ADZLZqCS/pTLOfV2yPUqsXm/ir6vfW8H3+RjtO3UKg3+3UX3KawRxA
         QT6Fr1Lls8xK/e/nEQhjo8GsmtoHNh3+NPvwvAsmxoypdkbfmQmh0QrSfXCs2+YqgXBa
         VWCASkf6gUyEB9Y+W/wgciDmzts0eGideihbctoLZJDWq5fmHEE+RUAJISbLkWFWDSiZ
         EmAXwoD727AlM5y+GDf2Vvn4PWiaci8kDD8mlSjw02TA1g0G7gN7uO+7MiVIO6Pka+uV
         6FkPNMnClFBcUKRFS0VZok/oGJq9MYLI7EK7il8045fy/DWdA9LXTIquzFwBRzmydmEe
         5/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KHKnDbsXcRPZyZ38OH7igxkl1b+DrVQqhYa9UckD9Fk=;
        fh=iFrA9iElnkc0BT/p445Hqf9Z9CQeNKFv5GAP4pGOZpA=;
        b=Jn0WOYB9WAaM0Zs6cEyiQgKIVrgYYj2VNP8k7E/s7u+KcXkDYiq8R+294HUgPAOyBy
         1FE/BvoXznI0+PvMFfscuhOyUsPUTB0ixn+gxRbljMtISK0VUNrTN3xVJD0M+285u5PT
         FCnUJib4ryhcPPioJGxSvGt5RxDpUcqQnO+NYMdGXUhJ2SN8VQeH3i4ipgOxu4QCJQ4U
         4QVOWX3Is7Mo0mQ9SiJqohmRxXDZYq32MU4SIRuyjErcyB9jFVuHWUg6MTKSmTqYDyfl
         fVVh8YTQAt+2YXbOgcF3quk89wahipblL8HCJMWgK2H4CV0xIM3S9ynfvwCXICQwF4kf
         GKGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781537904; x=1782142704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHKnDbsXcRPZyZ38OH7igxkl1b+DrVQqhYa9UckD9Fk=;
        b=KU2urHat40VUZG4T5mCdK8Ux/Shb8J3KjtoVIEOOCNWEFX29vAr0miHROg784I4Mjx
         3tZHUCYj+uuuJqzPp/FaAX0G66UJyOrW3R/64v9lOzebTXK+DUqtPjjyEp93T5XgbM2m
         oK5wAML5ED6yMNBUgEOSnYq0nOrZrTzW+zXieI/HtFXo+/4Gm0NqupHjBEEcsY8mgG7r
         sbZw0rYFx7aSgPBAk1vGgphQ3Zlk6PXbC5wvZqgnXpl12gFQX0/XXm1MLIZFisBCkcPx
         ITF/XvLWhgq+USa0j2MQwNFSKEj4AHpJPSmuS6Lcw3u/tc7rhv/BhN0ARYDnOpI8MCpQ
         dRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781537904; x=1782142704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KHKnDbsXcRPZyZ38OH7igxkl1b+DrVQqhYa9UckD9Fk=;
        b=cWJPsqf6OJZZGx/tcPf/AvSQwACgELtvRuE2mf0GUTiQFMff8ko48UXyp1QyFsU056
         BbgVEGvSOKAn1+6cEHmXQZWxmRiI3mLgxhTa0b5fgdrBJdV1rfVcFYLHJmG9qRi1MyN5
         ndNxII/+3+1D70PEK8Sf5vekLod5pQzWwa3hPlHT9J2xRNKSvAWYXep3iTevk4kpa7HC
         mAPKMAHKEWC/C6iX9RHvIJtOKEefgo1ZcBeROzwfuLu+eviwHyYSRQAC681kbzzs/KVE
         QJlWe+1dZmrs2kauwBhekFPuzmDPfAS6bsFSHsikANRHENiO+eQ1/Bgic9Reg6+ccPPR
         4kKA==
X-Forwarded-Encrypted: i=1; AFNElJ/e4OIRCoQK8DgJ/3L9uPaynVikxVARGdXJD6N8T7Ke9dWkUvhf5UzCJSu6IDWhfEurAyWCojlZK6bkNIhtCbS6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+yJ9gLhvIn9vwcDReNZ+vb29f3AijuaiWrFH3gKJEEbvx5UNJ
	JLcKcUa5IONDa4GCWkqb+ZTMIDN00/u0qu8zqll9LpyV4pSzgiWfA+qVNhPBXMVJOqbHFnKY5v5
	IJ/YvLmCCZlqUhD1862s9ZLBed6o91AXrbGRLLYMA
X-Gm-Gg: Acq92OF6UNHr1ETpu/NSN9iaqK/Mq/VZKq9mWymJHVBQqZxEjons3L7DuYFkBJYtK5n
	jLFlQcvUSbdxy+MzPED5J8aW93z1NERmPmrFZ63iGFE+1kxQkA8ZwJi/9s5ajstZg0+PeYcwJMg
	LjzGo1EQK7URTw8/6rgw6mcZ1H2MNKC4kHrFCLE9TotVtAlU7NSpEtV9DhCZIvdZZXlpLiC8S2E
	eS8//DDPT0c3qDX5F6cy6ce5MfOn7XfOF/KEfGw40TYYav4VJoVHCschnKYkHNNdYayBaA00MKs
	G9ArineUprVnSuEwWf+Wo4kYU+bTRnVFmFaQdw==
X-Received: by 2002:a17:903:2290:b0:2c0:c877:8095 with SMTP id
 d9443c01a7336-2c69680ad63mr625445ad.2.1781537903223; Mon, 15 Jun 2026
 08:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608054841.3856224-1-irogers@google.com> <20260611164122.3974068-1-irogers@google.com>
 <20260611164122.3974068-4-irogers@google.com> <ai_sesDicE7R7fm5@x1>
In-Reply-To: <ai_sesDicE7R7fm5@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jun 2026 08:38:11 -0700
X-Gm-Features: AVVi8CdjgLzvc27LqkT2h2HwvRLhZArsIM7v8UTlzUkmupMmWFGO-kBPNEARdy8
Message-ID: <CAP-5=fX_A=kKiRW6dfja50G4khWEeB-tpdepZN1qW7Lx1NahWg@mail.gmail.com>
Subject: Re: [PATCH v20 3/5] perf inject/aslr: Implement sample address remapping
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: james.clark@linaro.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	gmx@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 5:13=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Jun 11, 2026 at 09:41:20AM -0700, Ian Rogers wrote:
> > Add the sample address remapping logic to the ASLR tool. This patch
> > implements aslr_tool__process_sample, which parses sample events,
> > remaps IPs, ADDRs, callchains, and branch stacks using the mappings
> > collected from metadata events, and drops potentially leaking raw,
> > register, stack, physical address, and aux samples.
> >
> > Also adds the aslr_tool__remap_address helper function.
> >
> > Note on cross-endian compatibility:
> > 'perf inject' functions as an endianness converter. Input files are rea=
d,
> > and their events are byte-swapped to host endianness in memory. When th=
e
> > tool emits its output, it writes a host-endian PERF_MAGIC in the file
> > header, thereby marking the output file as host-endian natively.
> >
> > Because the output file is always written in host endianness, events an=
d
> > payloads must be constructed entirely using host-endian layouts. For th=
is
> > reason, this patch explicitly un-packs and repacks PERF_SAMPLE_TID (and
> > PERF_SAMPLE_CPU) using unions to ensure that the sequential 32-bit layo=
ut
> > is correctly aligned in host endianness. Similarly, branch stack flags
> > (which are modified in-place to host-endian bitfields by the parser) ar=
e
> > copied directly to the newly synthesized event. When re-parsing the new=
ly
> > synthesized event, 'needs_swap=3Dfalse' is explicitly used to prevent d=
ouble
> > swapping the already host-endian fields.
> >
> > Co-developed-by: Gabriel Marin <gmx@google.com>
> > Signed-off-by: Gabriel Marin <gmx@google.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Assisted-by: Antigravity:gemini-3.1-pro
> > ---
> >  tools/perf/util/aslr.c  | 465 +++++++++++++++++++++++++++++++++++++++-
> >  tools/perf/util/evsel.c |   6 +-
> >  tools/perf/util/evsel.h |  10 +-
> >  3 files changed, 472 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> > index 56fc444fbf54..c4602a43e04f 100644
> > --- a/tools/perf/util/aslr.c
> > +++ b/tools/perf/util/aslr.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/zalloc.h>
> >  #include <inttypes.h>
> >  #include <unistd.h>
> > +#include <byteswap.h>
> >
> >  /**
> >   * struct remap_addresses_key - Key for mapping original addresses to =
remapped ones.
> > @@ -112,6 +113,60 @@ static u64 round_up_to_page_size(u64 addr)
> >       return (addr + page_size - 1) & ~((u64)page_size - 1);
> >  }
> >
> > +static u64 aslr_tool__remap_address(struct aslr_tool *aslr,
> > +                                 struct thread *aslr_thread,
> > +                                 u8 cpumode,
> > +                                 u64 addr)
> > +{
> > +     struct addr_location al;
> > +     struct remap_addresses_key key;
> > +     u64 *remapped_invariant_ptr =3D NULL;
> > +     u64 remap_addr =3D 0;
> > +     u8 effective_cpumode =3D cpumode;
> > +
> > +     if (!aslr_thread)
> > +             return 0; /* No thread. */
> > +
> > +     addr_location__init(&al);
> > +     if (!thread__find_map(aslr_thread, cpumode, addr, &al)) {
> > +             /*
> > +              * If lookup fails with specified cpumode, try fallback t=
o the other space
> > +              * to be robust against bad cpumode in samples.
> > +              */
> > +             if (cpumode =3D=3D PERF_RECORD_MISC_KERNEL)
> > +                     effective_cpumode =3D PERF_RECORD_MISC_USER;
> > +             else if (cpumode =3D=3D PERF_RECORD_MISC_USER)
> > +                     effective_cpumode =3D PERF_RECORD_MISC_KERNEL;
> > +             else if (cpumode =3D=3D PERF_RECORD_MISC_GUEST_KERNEL)
> > +                     effective_cpumode =3D PERF_RECORD_MISC_GUEST_USER=
;
> > +             else if (cpumode =3D=3D PERF_RECORD_MISC_GUEST_USER)
> > +                     effective_cpumode =3D PERF_RECORD_MISC_GUEST_KERN=
EL;
> > +
> > +             if (!thread__find_map(aslr_thread, effective_cpumode, add=
r, &al)) {
> > +                     addr_location__exit(&al);
> > +                     return 0; /* No mmap. */
> > +             }
> > +     }
> > +
> > +     key.machine =3D maps__machine(thread__maps(aslr_thread));
> > +     key.dso =3D map__dso(al.map);
> > +     key.invariant =3D map__start(al.map) - map__pgoff(al.map);
> > +     key.pid =3D (effective_cpumode =3D=3D PERF_RECORD_MISC_KERNEL ||
> > +                effective_cpumode =3D=3D PERF_RECORD_MISC_GUEST_KERNEL=
) ?
> > +               kernel_pid : thread__pid(aslr_thread);
> > +
> > +     if (hashmap__find(&aslr->remap_addresses, &key, &remapped_invaria=
nt_ptr)) {
> > +             remap_addr =3D *remapped_invariant_ptr + map__pgoff(al.ma=
p) +
> > +                          (addr - map__start(al.map));
> > +     } else {
> > +             pr_debug("Cannot find a remapped entry for address %lx in=
 mapping %lx(%lx) for pid=3D%d\n",
> > +                      addr, map__start(al.map), map__size(al.map), key=
.pid);
> > +     }
> > +
> > +     addr_location__exit(&al);
> > +     return remap_addr;
> > +}
> > +
> >  struct aslr_machine_priv {
> >       bool kernel_maps_loaded;
> >  };
> > @@ -616,13 +671,415 @@ static int aslr_tool__process_sample(const struc=
t perf_tool *tool,
> >                                    struct perf_sample *sample,
> >                                    struct machine *machine)
> >  {
> > -     struct delegate_tool *del_tool =3D container_of(tool, struct dele=
gate_tool, tool);
> > -     struct aslr_tool *aslr =3D container_of(del_tool, struct aslr_too=
l, tool);
> > -     struct perf_tool *delegate =3D aslr->tool.delegate;
> > +     struct evsel *evsel =3D sample->evsel;
> > +     struct delegate_tool *del_tool;
> > +     struct aslr_tool *aslr;
> > +     struct perf_tool *delegate;
> > +     int ret;
> > +     u64 sample_type;
> > +     struct thread *thread;
> > +     struct machine *aslr_machine;
> > +     __u64 max_i;
> > +     __u64 max_j;
> > +     union perf_event *new_event;
> > +     struct perf_sample new_sample;
> > +     __u64 *in_array, *out_array;
> > +     u8 cpumode;
> > +     u64 addr;
> > +     size_t i;
> > +     size_t j;
>
> The following 4 variables are not used in this patch, so the build at
> this point fails:
>
> > +     struct aslr_evsel_priv *priv =3D NULL;
> > +     u64 orig_sample_type;
> > +     u64 orig_regs_user;
> > +     u64 orig_regs_intr;
>
>
> With:
>
>   CC      /tmp/build/perf-tools-next/util/bpf_lock_contention.o
> util/aslr.c: In function =E2=80=98aslr_tool__process_sample=E2=80=99:
> util/aslr.c:694:13: error: unused variable =E2=80=98orig_regs_intr=E2=80=
=99 [-Werror=3Dunused-variable]
>   694 |         u64 orig_regs_intr;
>       |             ^~~~~~~~~~~~~~
> util/aslr.c:693:13: error: unused variable =E2=80=98orig_regs_user=E2=80=
=99 [-Werror=3Dunused-variable]
>   693 |         u64 orig_regs_user;
>       |             ^~~~~~~~~~~~~~
> util/aslr.c:692:13: error: unused variable =E2=80=98orig_sample_type=E2=
=80=99 [-Werror=3Dunused-variable]
>   692 |         u64 orig_sample_type;
>       |             ^~~~~~~~~~~~~~~~
> util/aslr.c:691:33: error: unused variable =E2=80=98priv=E2=80=99 [-Werro=
r=3Dunused-variable]
>   691 |         struct aslr_evsel_priv *priv =3D NULL;
>       |                                 ^~~~
> cc1: all warnings being treated as errors
> make[4]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:9=
5: /tmp/build/perf-tools-next/util/aslr.o] Error 1
>
> So I moved it to the next patch, where they start to be used.
>
> > +     del_tool =3D container_of(tool, struct delegate_tool, tool);
> > +     aslr =3D container_of(del_tool, struct aslr_tool, tool);
> > +     delegate =3D aslr->tool.delegate;
> > +
>
> I also removed these extra blank lines and collected James Tested-by.
>
> Thanks, applied to perf-tools-next, for v7.2.

Thanks for merging and for the fixes!
Ian

> - Arnaldo
>
> > +
> > +
> > +     if (evsel__is_dummy_event(evsel))
> > +             return delegate->sample(delegate, event, sample, machine)=
;
> > +
> > +     ret =3D -EFAULT;
> > +     sample_type =3D evsel->core.attr.sample_type;
> > +     max_i =3D (event->header.size - sizeof(struct perf_event_header))=
 / sizeof(__u64);
> > +     max_j =3D (PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_event_header=
)) / sizeof(__u64);
> > +     new_event =3D (union perf_event *)aslr->event_copy;
> > +     cpumode =3D sample->cpumode;
> > +     i =3D 0;
> > +     j =3D 0;
> > +
> > +     aslr_machine =3D machines__findnew(&aslr->machines, machine->pid)=
;
> > +     if (!aslr_machine)
> > +             return -ENOMEM;
> > +     if (aslr_tool__preload_kernel_maps(aslr_machine) < 0)
> > +             return -ENOMEM;
> > +
> > +     thread =3D machine__findnew_thread(aslr_machine, sample->pid, sam=
ple->tid);
> > +
> > +     if (!thread)
> > +             return -ENOMEM;
> > +
> > +     if (max_i > PERF_SAMPLE_MAX_SIZE / sizeof(u64))
> > +             goto out_put;
> > +
> > +     new_event->sample.header =3D event->sample.header;
> > +
> > +     in_array =3D &event->sample.array[0];
> > +     out_array =3D &new_event->sample.array[0];
> > +
> > +#define CHECK_BOUNDS(required_i, required_j) \
> > +     (i + (required_i) > max_i || j + (required_j) > max_j)
> > +
> > +#define COPY_U64() \
> > +     do { \
> > +             if (CHECK_BOUNDS(1, 1)) { \
> > +                     ret =3D -EFAULT; \
> > +                     goto out_put; \
> > +             } \
> > +             out_array[j++] =3D in_array[i++]; \
> > +     } while (0)
> > +
> > +#define REMAP_U64(addr_field) \
> > +     do { \
> > +             u64 remapped; \
> > +             if (CHECK_BOUNDS(1, 1)) { \
> > +                     ret =3D -EFAULT; \
> > +                     goto out_put; \
> > +             } \
> > +             remapped =3D aslr_tool__remap_address(aslr, thread, cpumo=
de, addr_field); \
> > +             out_array[j++] =3D remapped; \
> > +             i++; \
> > +     } while (0)
> > +
> > +     if (sample_type & PERF_SAMPLE_IDENTIFIER)
> > +             COPY_U64(); /* id */
> > +     if (sample_type & PERF_SAMPLE_IP)
> > +             REMAP_U64(sample->ip);
> > +     if (sample_type & PERF_SAMPLE_TID) {
> > +             union {
> > +                     u64 val64;
> > +                     u32 val32[2];
> > +             } u;
> > +
> > +             if (CHECK_BOUNDS(1, 1)) {
> > +                     ret =3D -EFAULT;
> > +                     goto out_put;
> > +             }
> > +             u.val32[0] =3D sample->pid;
> > +             u.val32[1] =3D sample->tid;
> > +             out_array[j++] =3D u.val64;
> > +             i++;
> > +     }
> > +     if (sample_type & PERF_SAMPLE_TIME)
> > +             COPY_U64(); /* time */
> > +     if (sample_type & PERF_SAMPLE_ADDR)
> > +             REMAP_U64(sample->addr);
> > +     if (sample_type & PERF_SAMPLE_ID)
> > +             COPY_U64(); /* id */
> > +     if (sample_type & PERF_SAMPLE_STREAM_ID)
> > +             COPY_U64(); /* stream_id */
> > +     if (sample_type & PERF_SAMPLE_CPU)
> > +             COPY_U64(); /* cpu, res */
> > +     if (sample_type & PERF_SAMPLE_PERIOD)
> > +             COPY_U64(); /* period */
> > +     if (sample_type & PERF_SAMPLE_READ) {
> > +             if ((evsel->core.attr.read_format & PERF_FORMAT_GROUP) =
=3D=3D 0) {
> > +                     COPY_U64(); /* value */
> > +                     if (evsel->core.attr.read_format & PERF_FORMAT_TO=
TAL_TIME_ENABLED)
> > +                             COPY_U64(); /* time_enabled */
> > +                     if (evsel->core.attr.read_format & PERF_FORMAT_TO=
TAL_TIME_RUNNING)
> > +                             COPY_U64(); /* time_running */
> > +                     if (evsel->core.attr.read_format & PERF_FORMAT_ID=
)
> > +                             COPY_U64(); /* id */
> > +                     if (evsel->core.attr.read_format & PERF_FORMAT_LO=
ST)
> > +                             COPY_U64(); /* lost */
> > +             } else {
> > +                     u64 nr;
> > +
> > +                     if (CHECK_BOUNDS(1, 1)) {
> > +                             ret =3D -EFAULT;
> > +                             goto out_put;
> > +                     }
> > +                     nr =3D in_array[i];
> > +                     COPY_U64();
> > +                     if (evsel->core.attr.read_format & PERF_FORMAT_TO=
TAL_TIME_ENABLED)
> > +                             COPY_U64(); /* time_enabled */
> > +                     if (evsel->core.attr.read_format & PERF_FORMAT_TO=
TAL_TIME_RUNNING)
> > +                             COPY_U64(); /* time_running */
> > +                     for (u64 cntr =3D 0; cntr < nr; cntr++) {
> > +                             COPY_U64(); /* value */
> > +                             if (evsel->core.attr.read_format & PERF_F=
ORMAT_ID)
> > +                                     COPY_U64(); /* id */
> > +                             if (evsel->core.attr.read_format & PERF_F=
ORMAT_LOST)
> > +                                     COPY_U64(); /* lost */
> > +                     }
> > +             }
> > +     }
> > +     if (sample_type & PERF_SAMPLE_CALLCHAIN) {
> > +             u64 nr;
> > +
> > +             if (CHECK_BOUNDS(1, 1)) {
> > +                     ret =3D -EFAULT;
> > +                     goto out_put;
> > +             }
> > +             nr =3D in_array[i];
> > +             COPY_U64();
> > +
> > +             for (u64 cntr =3D 0; cntr < nr; cntr++) {
> > +                     if (CHECK_BOUNDS(1, 1)) {
> > +                             ret =3D -EFAULT;
> > +                             goto out_put;
> > +                     }
> > +                     addr =3D in_array[i++];
> > +                     if (addr >=3D PERF_CONTEXT_MAX) {
> > +                             out_array[j++] =3D addr;
> > +                             switch (addr) {
> > +                             case PERF_CONTEXT_HV:
> > +                                     cpumode =3D PERF_RECORD_MISC_HYPE=
RVISOR;
> > +                                     break;
> > +                             case PERF_CONTEXT_KERNEL:
> > +                                     cpumode =3D PERF_RECORD_MISC_KERN=
EL;
> > +                                     break;
> > +                             case PERF_CONTEXT_USER:
> > +                                     cpumode =3D PERF_RECORD_MISC_USER=
;
> > +                                     break;
> > +                             case PERF_CONTEXT_GUEST:
> > +                                     cpumode =3D PERF_RECORD_MISC_GUES=
T_KERNEL;
> > +                                     break;
> > +                             case PERF_CONTEXT_GUEST_KERNEL:
> > +                                     cpumode =3D PERF_RECORD_MISC_GUES=
T_KERNEL;
> > +                                     break;
> > +                             case PERF_CONTEXT_GUEST_USER:
> > +                                     cpumode =3D PERF_RECORD_MISC_GUES=
T_USER;
> > +                                     break;
> > +                             case PERF_CONTEXT_USER_DEFERRED:
> > +                                     if (cntr + 1 >=3D nr) {
> > +                                             pr_debug("Truncated callc=
hain deferred cookie context\n");
> > +                                             ret =3D 0;
> > +                                             goto out_put;
> > +                                     }
> > +                                     /*
> > +                                      * Immediately followed by a 64-b=
it
> > +                                      * stitching cookie. Skip/Copy it=
!
> > +                                      */
> > +                                     if (CHECK_BOUNDS(1, 1)) {
> > +                                             ret =3D -EFAULT;
> > +                                             goto out_put;
> > +                                     }
> > +                                     out_array[j++] =3D in_array[i++];
> > +                                     cntr++;
> > +                                     cpumode =3D PERF_RECORD_MISC_USER=
;
> > +                                     break;
> > +                             default:
> > +                                     pr_debug("invalid callchain conte=
xt: %"PRIx64"\n", addr);
> > +                                     ret =3D 0;
> > +                                     goto out_put;
> > +                             }
> > +                             continue;
> > +                     }
> > +                     addr =3D aslr_tool__remap_address(aslr, thread, c=
pumode, addr);
> > +                     out_array[j++] =3D addr;
> > +             }
> > +     }
> > +     if (sample_type & PERF_SAMPLE_RAW) {
> > +             size_t bytes =3D sizeof(u32) + sample->raw_size;
> > +             size_t u64_words =3D (bytes + 7) / 8;
> > +
> > +             if (i + u64_words > max_i || j + u64_words > max_j) {
> > +                     ret =3D -EFAULT;
> > +                     goto out_put;
> > +             }
> > +             memcpy(&out_array[j], &in_array[i], bytes);
> > +             i +=3D u64_words;
> > +             j +=3D u64_words;
> > +             /*
> > +              * TODO: certain raw samples can be remapped, such as
> > +              * tracepoints by examining their fields.
> > +              */
> > +             pr_debug("Dropping raw samples as possible ASLR leak\n");
> > +             ret =3D 0;
> > +             goto out_put;
> > +     }
> > +     if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
> > +             u64 nr;
> > +
> > +             if (CHECK_BOUNDS(1, 1)) {
> > +                     ret =3D -EFAULT;
> > +                     goto out_put;
> > +             }
> > +             nr =3D in_array[i];
> > +             COPY_U64();
> > +
> > +             if (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRA=
NCH_HW_INDEX)
> > +                     COPY_U64(); /* hw_idx */
> > +
> > +             if (nr > (ULLONG_MAX / 3)) {
> > +                     ret =3D -EFAULT;
> > +                     goto out_put;
> > +             }
> > +             if (nr * 3 > max_i - i || nr * 3 > max_j - j) {
> > +                     ret =3D -EFAULT;
> > +                     goto out_put;
> > +             }
> > +             for (u64 cntr =3D 0; cntr < nr; cntr++) {
> > +                     u64 from =3D in_array[i++];
> > +                     u64 to =3D in_array[i++];
> > +
> > +                     from =3D aslr_tool__remap_address(aslr, thread, s=
ample->cpumode, from);
> > +                     to =3D aslr_tool__remap_address(aslr, thread, sam=
ple->cpumode, to);
> > +
> > +                     out_array[j++] =3D from;
> > +                     out_array[j++] =3D to;
> > +                     out_array[j++] =3D in_array[i++]; /* flags */
> > +             }
> > +             if (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRA=
NCH_COUNTERS) {
> > +                     if (nr > max_i - i || nr > max_j - j) {
> > +                             ret =3D -EFAULT;
> > +                             goto out_put;
> > +                     }
> > +                     for (u64 cntr =3D 0; cntr < nr; cntr++)
> > +                             COPY_U64();
> > +             }
> > +     }
> > +     if (sample_type & PERF_SAMPLE_REGS_USER) {
> > +             if (CHECK_BOUNDS(1, 0)) {
> > +                     ret =3D -EFAULT;
> > +                     goto out_put;
> > +             }
> > +             /* abi */
> > +             COPY_U64();
> > +             /* TODO: can this be less conservative? */
> > +             pr_debug("Dropping regs user sample as possible ASLR leak=
\n");
> > +             ret =3D 0;
> > +             goto out_put;
> > +     }
> > +     if (sample_type & PERF_SAMPLE_STACK_USER) {
> > +             u64 size;
> >
> > -     return delegate->sample(delegate, event, sample, machine);
> > +             if (CHECK_BOUNDS(1, 1)) {
> > +                     ret =3D -EFAULT;
> > +                     goto out_put;
> > +             }
> > +             size =3D in_array[i];
> > +             COPY_U64();
> > +             if (size > 0) {
> > +                     size_t u64_words =3D size / 8 + (size % 8 ? 1 : 0=
);
> > +
> > +                     if (u64_words > max_i - i || u64_words > max_j - =
j) {
> > +                             ret =3D -EFAULT;
> > +                             goto out_put;
> > +                     }
> > +                     memcpy(&out_array[j], &in_array[i], size);
> > +                     if (size % 8) {
> > +                             size_t pad =3D 8 - (size % 8);
> > +
> > +                             memset(((char *)&out_array[j]) + size, 0,=
 pad);
> > +                     }
> > +                     i +=3D u64_words;
> > +                     j +=3D u64_words;
> > +             }
> > +             /* TODO: can this be less conservative? */
> > +             pr_debug("Dropping stack user sample as possible ASLR lea=
k\n");
> > +             ret =3D 0;
> > +             goto out_put;
> > +     }
> > +     if (sample_type & PERF_SAMPLE_WEIGHT_TYPE)
> > +             COPY_U64(); /* perf_sample_weight */
> > +     if (sample_type & PERF_SAMPLE_DATA_SRC)
> > +             COPY_U64(); /* data_src */
> > +     if (sample_type & PERF_SAMPLE_TRANSACTION)
> > +             COPY_U64(); /* transaction */
> > +     if (sample_type & PERF_SAMPLE_REGS_INTR) {
> > +             if (CHECK_BOUNDS(1, 0)) {
> > +                     ret =3D -EFAULT;
> > +                     goto out_put;
> > +             }
> > +             /* abi */
> > +             COPY_U64();
> > +             /* TODO: can this be less conservative? */
> > +             pr_debug("Dropping interrupt register sample as possible =
ASLR leak\n");
> > +             ret =3D 0;
> > +             goto out_put;
> > +     }
> > +     if (sample_type & PERF_SAMPLE_PHYS_ADDR) {
> > +             COPY_U64(); /* phys_addr */
> > +             /* TODO: can this be less conservative? */
> > +             pr_debug("Dropping physical address sample as possible AS=
LR leak\n");
> > +             ret =3D 0;
> > +             goto out_put;
> > +     }
> > +     if (sample_type & PERF_SAMPLE_CGROUP)
> > +             COPY_U64(); /* cgroup */
> > +     if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
> > +             COPY_U64(); /* data_page_size */
> > +     if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
> > +             COPY_U64(); /* code_page_size */
> > +
> > +     if (sample_type & PERF_SAMPLE_AUX) {
> > +             u64 size;
> > +
> > +             if (CHECK_BOUNDS(1, 1)) {
> > +                     ret =3D -EFAULT;
> > +                     goto out_put;
> > +             }
> > +             out_array[j] =3D in_array[i];
> > +             size =3D out_array[j++];
> > +             i++;
> > +             if (size > 0) {
> > +                     size_t u64_words =3D size / 8 + (size % 8 ? 1 : 0=
);
> > +
> > +                     if (u64_words > max_i - i || u64_words > max_j - =
j) {
> > +                             ret =3D -EFAULT;
> > +                             goto out_put;
> > +                     }
> > +                     memcpy(&out_array[j], &in_array[i], size);
> > +                     if (size % 8) {
> > +                             size_t pad =3D 8 - (size % 8);
> > +
> > +                             memset(((char *)&out_array[j]) + size, 0,=
 pad);
> > +                     }
> > +                     i +=3D u64_words;
> > +                     j +=3D u64_words;
> > +             }
> > +             /* TODO: can this be less conservative? */
> > +             pr_debug("Dropping aux sample as possible ASLR leak\n");
> > +             ret =3D 0;
> > +             goto out_put;
> > +     }
> > +
> > +     if (evsel__is_offcpu_event(evsel)) {
> > +             /* TODO: can this be less conservative? */
> > +             pr_debug("Dropping off-CPU sample as possible ASLR leak\n=
");
> > +             ret =3D 0;
> > +             goto out_put;
> > +     }
> > +
> > +     new_event->sample.header.size =3D sizeof(struct perf_event_header=
) + j * sizeof(u64);
> > +
> > +     perf_sample__init(&new_sample, /*all=3D*/ true);
> > +     ret =3D __evsel__parse_sample(evsel, new_event, &new_sample, /*ne=
eds_swap=3D*/false);
> > +
> > +     if (ret) {
> > +             perf_sample__exit(&new_sample);
> > +             goto out_put;
> > +     }
> > +
> > +     new_sample.evsel =3D evsel;
> > +     ret =3D delegate->sample(delegate, new_event, &new_sample, machin=
e);
> > +     perf_sample__exit(&new_sample);
> > +
> > +out_put:
> > +     thread__put(thread);
> > +     return ret;
> >  }
> >
> > +#undef CHECK_BOUNDS
> > +#undef COPY_U64
> > +#undef REMAP_U64
> > +
> >  static int skipn(int fd, off_t n)
> >  {
> >       char buf[4096];
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 34c03f47a913..05fa0010c858 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -3337,11 +3337,11 @@ static int __set_offcpu_sample(struct perf_samp=
le *data)
> >       return -EFAULT;
> >  }
> >
> > -int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
> > -                     struct perf_sample *data)
> > +int __evsel__parse_sample(struct evsel *evsel, union perf_event *event=
,
> > +                       struct perf_sample *data, bool needs_swap)
> >  {
> >       u64 type =3D evsel->core.attr.sample_type;
> > -     bool swapped =3D evsel->needs_swap;
> > +     bool swapped =3D needs_swap;
> >       const __u64 *array;
> >       u16 max_size =3D event->header.size;
> >       const void *endp =3D (void *)event + max_size;
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 8178858d168a..8009be22cc3f 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -432,8 +432,14 @@ static inline int evsel__read_on_cpu_scaled(struct=
 evsel *evsel, int cpu_map_idx
> >       return __evsel__read_on_cpu(evsel, cpu_map_idx, thread, true);
> >  }
> >
> > -int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
> > -                     struct perf_sample *sample);
> > +int __evsel__parse_sample(struct evsel *evsel, union perf_event *event=
,
> > +                       struct perf_sample *data, bool needs_swap);
> > +
> > +static inline int evsel__parse_sample(struct evsel *evsel, union perf_=
event *event,
> > +                                   struct perf_sample *data)
> > +{
> > +     return __evsel__parse_sample(evsel, event, data, evsel->needs_swa=
p);
> > +}
> >
> >  int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_even=
t *event,
> >                                 u64 *timestamp);
> > --
> > 2.54.0.1099.g489fc7bff1-goog
