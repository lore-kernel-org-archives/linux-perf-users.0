Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7A8220F21
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Oct 2025 19:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759778485; cv=none; b=annUENwyk03nlMu7EjW7SX90LUSHK8ctDHq5+wk9VRGeYrcOKnSMnk8zrnJzP7e8qNGgqR3C26zgPWvmGuaXe0RqMVjmCKogn3ENsAfKAoAr29oFhc1ia7JQEReknIoDnP3P8RRlaE1e6yOjMmd19GT2Xc2t09wmPIk+ApQE7v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759778485; c=relaxed/simple;
	bh=22y8nJ9Bpq5EeYH1zp5PzyrB0NyQ3miT4wcugsBz2U0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opemrTWgwyJu1jOO3IWPTOdEWVzZux21CGd6h5bZ91sYKjKlfhrajP+SNT4otfl3eHh9aZZTu1JDvy6WFU8/Yc5VH+bkXWuufS/w7L6Kr2vqEM6TEKPsEOuSHM07su3aHLIct7ur/e9HBNVizDxiHAhB8caeKdrDGOD3Yzl6U40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSSyop6j; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSSyop6j"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2681645b7b6so1735ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Oct 2025 12:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759778483; x=1760383283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MP6UIz3AnPITo29hjyvg2u8Pjbod8UaowINUGAaaqjU=;
        b=MSSyop6ji/y6XFf6LECfQta5+DefNg8XQsmzXvYbhSARfoAnz0VROFctBk0uvbH4QP
         Taat0773RwK1XzUMFMSomGayetgMAxLRQWDONnl5C2aCDuX62YbLa+5mA8IBhJCOxX8R
         8ar9jdRp4BOS+GHSCq0e3O0lzzAXA6RZSWWDIs5TY4iM28Qg9nE4UXPlJmHcsLGt+oAC
         hk+kXvgWxqAdOmTbXnN7P5csq3gAxlK3JM0vBqg2TfCbkp/Hb/hV142yPQ88YitWOyDN
         +5l7aYUpLjjq6yG9Nmeq0Dx2TX63OsQQ5vlWvPhezR+d0CSz0W0QBF28OCyzw+jyer77
         2INQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759778483; x=1760383283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MP6UIz3AnPITo29hjyvg2u8Pjbod8UaowINUGAaaqjU=;
        b=Zc3Vs6ZgLCuGtrxPlJ8DKd72sfocT4oFY87z6QwMIYFUyLhgbzVMd2JoB0TxtxMSlz
         /Ep7nvDEXd1W5Ckh/2geZBLTHeq5+y+pyqUgkIjZt5+NwZ14JKRP2W4tT5Bap0BVoICR
         77M0l8N5GVd25s+z4Js7t2CSoM1+oRzDk2Nw3KWQ/snacQlaRaG7YjZlIv7UJ1l4UJum
         HthPiXt067gMBzO6jnLddvCwLW4mmXPDqp1WfH5Cz5hmGTZQ284VzJ+tVZCDl6p+Zv14
         PoDkh/Qwc4LyPi0bLHFsce4XWONGe0NT/eH3qCAs0bz71D+y9HpxfqQVQWt2VKTJDcB9
         7uFg==
X-Forwarded-Encrypted: i=1; AJvYcCU2HG3mG3w5xPPuosUcs18p7exgVU3boTa8hkqh540QE2L3GuOFXCrAROetdKk8m54Pe1QJfc/S6DiozD4GrVlh@vger.kernel.org
X-Gm-Message-State: AOJu0YwsksP0QOK8SV/WFYvoB37siA2+u5yHfZSZ4lgHRO2306gPExeu
	7Is3C0qwSxy56IvpaPfBpY7+wTCmBIZby09l31f7cjka76LNXoBJTkIg2QNt803riAr6sUTf7Ec
	SuNS19hQO9QcMu1jqEhxoJvU5jc8UsL9YcCHJtt86
X-Gm-Gg: ASbGnctdMWKO1hrvUu9ZtZsl1xk79iFy3s0w/sPuHtzJ676xW4ktGmPX1d2lfl1r9+P
	BoUpx3oC6uensQBdTB4T+BH86Kj3T3cTspvB4sqQPiDVRwy52PxqqzIWc1/1irSL8ObP+Iunctr
	gjVFV58Xmxe/J8Xz8eFdxOHNtep3NIIYsTF8M1Rub508zo0WiNNw0aTQrc6UR/T2Kr3m8Ud15BA
	dZNCwcN1nlpZbV+oWXxbLWKi177AKR8FViHICETGEpV0uKrD2Ijk8/5nhiLbXBpr59y
X-Google-Smtp-Source: AGHT+IEOAzG6/6dYVG9ftumCGB20yTydBORTEx9wLLKqE5ulQb+oWe1B9LMAjYFKCcRjvKpSA3D8w5lKquLn+RXKUPM=
X-Received: by 2002:a17:902:f642:b0:26a:f9c7:f335 with SMTP id
 d9443c01a7336-28eca553440mr687985ad.9.1759778482777; Mon, 06 Oct 2025
 12:21:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006175710.1179040-1-mpetlan@redhat.com> <20251006175710.1179040-2-mpetlan@redhat.com>
 <CAP-5=fXo2+tKbTtNKN8oxiva+rKYB2AMpOCjA4+5xxNagC01UQ@mail.gmail.com> <ec1dd178-890f-4eb7-b6e6-e027e7c2d7b3@redhat.com>
In-Reply-To: <ec1dd178-890f-4eb7-b6e6-e027e7c2d7b3@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Oct 2025 12:21:11 -0700
X-Gm-Features: AS18NWDCPotyMuItVNmlaiZ4hlQM0XgdYGdEXHspZ3-sFPV4dakTS5jsXJVNq9A
Message-ID: <CAP-5=fWKr3G4GC=bKZv9MmFueK4GdUGzRo4H-=7=NVfaLNx78A@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf tools: Remove /SYSV from no_dso maps
To: Joe Mario <jmario@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org, acme@redhat.com, 
	namhyung@kernel.org, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 11:28=E2=80=AFAM Joe Mario <jmario@redhat.com> wrote=
:
>
>
>
> On 10/6/25 2:01 PM, Ian Rogers wrote:
> > On Mon, Oct 6, 2025 at 10:57=E2=80=AFAM Michael Petlan <mpetlan@redhat.=
com> wrote:
> >>
> >> We will need it for upcoming commits. Also adjust the function
> >> calls in perf-inject, in order not to break the logic.
> >>
> >> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> >>
> >> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> >> ---
> >>  tools/perf/builtin-inject.c | 4 ++--
> >>  tools/perf/util/map.c       | 5 +++--
> >>  tools/perf/util/map.h       | 6 +++++-
> >>  3 files changed, 10 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> >> index a114b3fa1bea..cc090da5c445 100644
> >> --- a/tools/perf/builtin-inject.c
> >> +++ b/tools/perf/builtin-inject.c
> >> @@ -773,7 +773,7 @@ static int tool__inject_build_id(const struct perf=
_tool *tool,
> >>
> >>         if (is_anon_memory(filename) || flags & MAP_HUGETLB)
> >>                 return 0;
> >> -       if (is_no_dso_memory(filename))
> >> +       if (is_no_dso_memory(filename) || is_shared_memory(filename))
> >>                 return 0;
> >>
> >>         if (inject->known_build_ids !=3D NULL &&
> >> @@ -813,7 +813,7 @@ static int tool__inject_mmap2_build_id(const struc=
t perf_tool *tool,
> >>         /* Return to repipe anonymous maps. */
> >>         if (is_anon_memory(filename) || flags & MAP_HUGETLB)
> >>                 return 1;
> >> -       if (is_no_dso_memory(filename))
> >> +       if (is_no_dso_memory(filename) || is_shared_memory(filename))
> >>                 return 1;
> >>
> >>         if (dso__read_build_id(dso)) {
> >> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> >> index b46c68c24d1c..6d13b4602970 100644
> >> --- a/tools/perf/util/map.c
> >> +++ b/tools/perf/util/map.c
> >> @@ -133,12 +133,13 @@ struct map *map__new(struct machine *machine, u6=
4 start, u64 len,
> >>         if (ADD_RC_CHK(result, map)) {
> >>                 char newfilename[PATH_MAX];
> >>                 struct dso *dso;
> >> -               int anon, no_dso, vdso, android;
> >> +               int anon, no_dso, vdso, android, shared;
> >>
> >>                 android =3D is_android_lib(filename);
> >>                 anon =3D is_anon_memory(filename) || flags & MAP_HUGET=
LB;
> >>                 vdso =3D is_vdso_map(filename);
> >>                 no_dso =3D is_no_dso_memory(filename);
> >> +               shared =3D is_shared_memory(filename);
> >>                 nsi =3D nsinfo__get(thread__nsinfo(thread));
> >>
> >>                 if ((anon || no_dso) && nsi && (prot & PROT_EXEC)) {
> >> @@ -174,7 +175,7 @@ struct map *map__new(struct machine *machine, u64 =
start, u64 len,
> >>                 assert(!dso__kernel(dso));
> >>                 map__init(result, start, start + len, pgoff, dso, prot=
, flags);
> >>
> >> -               if (anon || no_dso) {
> >> +               if (anon || no_dso || shared) {
> >>                         map->mapping_type =3D MAPPING_TYPE__IDENTITY;
> >>
> >>                         /*
> >> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> >> index 9cadf533a561..616f32504e46 100644
> >> --- a/tools/perf/util/map.h
> >> +++ b/tools/perf/util/map.h
> >> @@ -258,10 +258,14 @@ static inline int is_anon_memory(const char *fil=
ename)
> >>  static inline int is_no_dso_memory(const char *filename)
> >>  {
> >>         return !strncmp(filename, "[stack", 6) ||
> >> -              !strncmp(filename, "/SYSV", 5)  ||
> >>                !strcmp(filename, "[heap]");
> >>  }
> >>
> >> +static inline int is_shared_memory(const char *filename)
> >> +{
> >> +       return !strncmp(filename, "/SYSV", 5);
> >> +}
> >
> > Shared memory could happen because of two mmaps having the same file
> > and offset. Is the mapping shared within or across processes? Perhaps
> > there is a clearer and more capable API hiding here.
>
> Hi Ian:
> We see it happening both within a process and across processes, where the=
 code does something like this:
>
>     shmid =3D shmget((key_t)0, 8192, IPC_CREAT|0777);
>     shmat_addr1 =3D shmat(shmid, (char *)0, 0);
>     shmat_addr2 =3D shmat(shmid, (char *)0, 0);
>
> The separate shmat() calls can either be in the same process or different=
 processes.  As long as they use the same shmid and a NULL address, they en=
d up with different virtual addresses pointing to the same location in shar=
ed memory.
>
> Then if cacheline contention occurs from accesses to shmat_addr1 and shma=
t_addr2, perf c2c cannot detect it.
>
> I hope this helps.
> Thanks,
> Joe

Thanks Joe, it helps :-)

There is a maps API for a collection of mmaps within a process, and
the map API is for pretty much for maps within it - the special case
kernel maps even have a pointer back to their owning maps instance.
Looking at the use of is_no_dso_memory(..) I don't think we want to
change the cases when we're looking to inject build IDs to try to load
build IDs from files called files called "/SYSV" which is a
consequence of the change just above.

Looking at the use of is_no_dso_memory in map__new I'm getting confused :-)

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/map.c?h=3Dperf-tools-next#n171
```
    no_dso =3D is_no_dso_memory(filename);
...
    if (vdso) {
...
      dso =3D machine__findnew_vdso(machine, thread);
    } else
      dso =3D machine__findnew_dso_id(machine, filename, id);

    if (dso =3D=3D NULL)
      goto out_delete;
...
    if (anon || no_dso) {
```

given that `dso` cannot be NULL then I don't see how the `no_dso` test
can be useful and therefore the whole no_dso usage here seems
unnecessary.


Anyway, that's is_no_dso_memory, I wonder if we want to know if a map
is shared we should add a helper something like:
```
enum shared_mem {
    SHARED_MEM__UNKNOWN     =3D 0,
    SHARED_MEM__NO          =3D  1,
    SHARED_MEM__YES         =3D  2,
};
DECLARE_RC_STRUCT(map) {
...
    enum shared_mem shared_mem : 2;
};

bool map__is_shared(map, maps)
{
    enum shared_mem state =3D map__shared_mem(map);
    struct map *shared_map;

    if (state !=3D SHARED_MEM__UNKNOWN)
        return state;

    shared_map =3D maps__shared_map(maps, map);
    state =3D shared_map ? SHARED_MEM__YES : SHARED_MEM__NO;
    map__set_shared_mem(map, state);
    return state;
}

struct maps__shared_map_cb_args {
    struct map *map, *shared;
};

static int maps__shared_map_cb(struct map *map, void *data)
{
    struct maps__shared_map_cb_args *args =3D data;

    if (RC_CHK_EQUAL(map, args->map))
        return 0;  // Skip the shared map being looked for.

    if (map__dso(map) !=3D map__dso(args->map) || map__pgoff(map) !=3D
map__pgoff(args->map))
       return 0; // Not a match, keep searching.

    args->shared =3D map;
    return 1;  // End search now a shared mapping is found.
}

// Returns the first mmap in maps with the same dso and offset as map.
struct map *maps__shared_map(maps, map)
{
    struct maps__shared_map_cb_args args =3D { .map =3D map, };

    maps__for_each_map(maps, maps__shared_map_cb, &args);
    return args.shared;
}
```

We can also update the map__new case to set the flag on the map based
on the filename being "/SYSV". This will mean rather than in the uses
of is_shared_memory in the current patches here they are changed to
calls to map__is_shared.

Thanks,
Ian



> >
> > Thanks,
> > Ian
> >
> >> +
> >>  static inline void map__set_start(struct map *map, u64 start)
> >>  {
> >>         RC_CHK_ACCESS(map)->start =3D start;
> >> --
> >> 2.47.3
> >>
> >
>
