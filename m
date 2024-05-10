Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAFD13BAFB
	for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 22:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715379119; cv=none; b=Xv6O9zTRPgBOocZPhD51Hp6ehP2wdh1icSzLJ2UT9LO49WwJ+ApAMH828lA1QgnT2FkSgCmiQeVeV2Kc5Om7Viii3yXh0HHeLRQRXyS/imoH97vmddHnTGrxDaWrQpTKy5cEnPfonGLxpi0eo/8o16yRQZCJeszr84QOSd+8Pk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715379119; c=relaxed/simple;
	bh=9UA8EvXGRK6QntEENYDmDZAaNuDr1xaXYsTvR7OHr3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ng2FqrjWuiuCXvYHlZ8BfLtOsXE4xz+7kw8NeLje60IRTgllUjKNMXefw5q5enD2VdGyepIDUMN4aUSiKrtCwFdv+uudwHt865lQ9CDxgfkVjpaH4CS+JqRpW/EYQr5XQqcaM1UDDa2r5kXIDyKuIV7GLP1rCeEMGZdKyP83NDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dyyl2Icp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dyyl2Icp"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ee0ccf9c2fso46785ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 15:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715379117; x=1715983917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqHkljHlklw+WhZq2gtJh/FlWOrJYAuo01S5RboiGdE=;
        b=dyyl2Icp78pULTwNjq4YCHbnmlu6vjbRmNkFZsqO0/nMTzV36cNIKVasAe0LXIfqOR
         bUlR0q/Y4FkYumvWxxmQtlk1EVWGCouoUS9ss3E7Ay8D9Xz1290jQP6R0ki1gMRq8TXO
         V0eMD/f9t17roBXGqzx2U0tGUDcDITFrcFGaX2QCs16n4BoZ7B/3YhEwrR3znOWm/xEY
         7Ey6zrKOV3JUTkd5yrWOzTZZuNtXlZp5I6WM4/lk/nkBk1oNJuN51f2kQqOZy3CeV4QE
         9+cFPlz0msdFnVStbqxioxbniMIEoFYDZ9xd4vvcJYEGKiFx9xPWgRxvgMQo+Uv0afVj
         W8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715379117; x=1715983917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqHkljHlklw+WhZq2gtJh/FlWOrJYAuo01S5RboiGdE=;
        b=BeRKfjhVyEK/8FQCny94HYdFzA2mi+A5RLCEomFfy6P4V5txN84sff6HKZaTxzd1md
         E0H9sYFJmhdTnzeVcBHrhUGEqTzRNq2SbEwhSu/vLMm1ve8MKgUekijdXM105ZnZq+fr
         Y6hum3NyeJ0Amz6bpbJzD9mqq/sU3VzkdJdqqB2U78fvF4vQPWIWTJK5dQ2RN+gPseyq
         RyGtQJLkwkCslj7Xv+fWF/TxB9AC+OJVcg9IaTBTKhPBrZdBMRfqMwglw7F3tJoM5WOk
         bGwr/snPVp6nJk+MqA+BPDUSXwIpYgbEFd56YMV/N1o5MNNlnlkjRsWe5ShnUBt3ClD2
         rIPw==
X-Forwarded-Encrypted: i=1; AJvYcCUA4r/E363S0qZ+4ce5mSTLvO/UjQ4CgK3dO/HojHVTqphM1/SlWv/TsYrv1C/yLFmCR9pK6s/5mwY8Xfe2wRJu+VgiyC+fXMpyaaL2P650qA==
X-Gm-Message-State: AOJu0YxiHolV9EX1DFh5OZ6F8rmYt4eIhIwh6lp8dXaZWQqE/8UTzC+o
	G9V8J3FJ+zXbk+9M26fW5BE7D5/ipzMYDXjdqYsnzNCjid/xRPvmVGlRIJiPZ4kSGA/3slwG1B5
	ibUPQZK9/x86DFy2mZpEtbbkugxs8v0DxAyjw
X-Google-Smtp-Source: AGHT+IHePXfRjYVDTfcVN8nYfOC7Pg60+7P8XDx/dpz5zCRYK/+CqaDba8QFTJ2UzQqzdIqDrIrd5rJdgvS622ZudBs=
X-Received: by 2002:a17:903:2349:b0:1e3:e08c:5a98 with SMTP id
 d9443c01a7336-1f060bd113emr240695ad.29.1715379116746; Fri, 10 May 2024
 15:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509060541.1928390-1-irogers@google.com> <Zj4tVDdY3CzU7KZM@x1>
 <CAP-5=fWhSfZyWh3ye3WYmPBTEKsqRAd-ZrZjaT68=RVqb-m4kA@mail.gmail.com> <CAM9d7cgos57-56NOevzFb+KwgSHZxjNPHddnf2fK-ypF6Ao7bg@mail.gmail.com>
In-Reply-To: <CAM9d7cgos57-56NOevzFb+KwgSHZxjNPHddnf2fK-ypF6Ao7bg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 10 May 2024 15:11:45 -0700
Message-ID: <CAP-5=fVf0G9pnHGL2DNFmBdzm_kW2gHzz-D9ToTyy51BQ_W1RA@mail.gmail.com>
Subject: Re: [PATCH v1] perf tracepoint: Don't scan all tracepoints to test if
 one exists
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 2:54=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian and Arnaldo,
>
> On Fri, May 10, 2024 at 7:29=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> >
> >
> > On Fri, May 10, 2024, 7:21=E2=80=AFAM Arnaldo Carvalho de Melo <acme@ke=
rnel.org> wrote:
> >>
> >> On Wed, May 08, 2024 at 11:05:41PM -0700, Ian Rogers wrote:
> >> > In is_valid_tracepoint, rather than scanning
> >> > "/sys/kernel/tracing/events/*/*" skipping any path where
> >> > "/sys/kernel/tracing/events/*/*/id" doesn't exist, and then testing =
if
> >> > "*:*" matches the tracepoint name, just use the given tracepoint nam=
e
> >> > replace the ':' with '/' and see if the id file exists. This turns a
> >> > nested directory search into a single file available test.
> >> >
> >> > Rather than return 1 for valid and 0 for invalid, return true and
> >> > false.
> >> >
> >> > Signed-off-by: Ian Rogers <irogers@google.com>
> >> > ---
> >> >  tools/perf/util/tracepoint.c | 53 ++++++++++++++-------------------=
---
> >> >  tools/perf/util/tracepoint.h |  3 +-
> >> >  2 files changed, 23 insertions(+), 33 deletions(-)
> >> >
> >> > diff --git a/tools/perf/util/tracepoint.c b/tools/perf/util/tracepoi=
nt.c
> >> > index 92dd8b455b90..cca6808f7951 100644
> >> > --- a/tools/perf/util/tracepoint.c
> >> > +++ b/tools/perf/util/tracepoint.c
> >> > @@ -4,10 +4,12 @@
> >> >  #include <errno.h>
> >> >  #include <fcntl.h>
> >> >  #include <stdio.h>
> >> > +#include <stdlib.h>
> >> >  #include <sys/param.h>
> >> >  #include <unistd.h>
> >> >
> >> >  #include <api/fs/tracing_path.h>
> >> > +#include "fncache.h"
> >> >
> >> >  int tp_event_has_id(const char *dir_path, struct dirent *evt_dir)
> >> >  {
> >> > @@ -26,39 +28,26 @@ int tp_event_has_id(const char *dir_path, struct=
 dirent *evt_dir)
> >> >  /*
> >> >   * Check whether event is in <debugfs_mount_point>/tracing/events
> >> >   */
> >> > -int is_valid_tracepoint(const char *event_string)
> >> > +bool is_valid_tracepoint(const char *event_string)
> >> >  {
> >> > -     DIR *sys_dir, *evt_dir;
> >> > -     struct dirent *sys_dirent, *evt_dirent;
> >> > -     char evt_path[MAXPATHLEN];
> >> > -     char *dir_path;
> >> > -
> >> > -     sys_dir =3D tracing_events__opendir();
> >> > -     if (!sys_dir)
> >> > -             return 0;
> >> > +     char *dst, *path =3D malloc(strlen(event_string) + 4); /* Spac=
e for "/id\0". */
> >> > +     const char *src;
> >> > +     bool have_file;
> >> >
> >> > -     for_each_subsystem(sys_dir, sys_dirent) {
> >> > -             dir_path =3D get_events_file(sys_dirent->d_name);
> >> > -             if (!dir_path)
> >> > -                     continue;
> >> > -             evt_dir =3D opendir(dir_path);
> >> > -             if (!evt_dir)
> >> > -                     goto next;
> >> > -
> >> > -             for_each_event(dir_path, evt_dir, evt_dirent) {
> >> > -                     snprintf(evt_path, MAXPATHLEN, "%s:%s",
> >> > -                              sys_dirent->d_name, evt_dirent->d_nam=
e);
> >> > -                     if (!strcmp(evt_path, event_string)) {
> >> > -                             closedir(evt_dir);
> >> > -                             put_events_file(dir_path);
> >> > -                             closedir(sys_dir);
> >> > -                             return 1;
> >> > -                     }
> >> > -             }
> >> > -             closedir(evt_dir);
> >> > -next:
> >> > -             put_events_file(dir_path);
> >> > +     if (!path) {
> >> > +             /* Conservatively return false if memory allocation fa=
iled. */
> >> > +             return false;
> >> >       }
> >> > -     closedir(sys_dir);
> >> > -     return 0;
> >> > +     /* Copy event_string replacing the ':' with '/'. */
> >> > +     for (src =3D event_string, dst =3D path; *src; src++, dst++)
> >> > +             *dst =3D (*src =3D=3D ':') ? '/' : *src;
> >> > +     /* Add "/id\0". */
> >> > +     memcpy(dst, "/id", 4);
> >> > +
> >> > +     dst =3D get_events_file(path);
> >> > +     if (dst)
> >> > +             have_file =3D file_available(dst);
>
> Off-topic.  But it seems we don't release fncache entries.

Agreed it is weird. Going further off-topic it seems silly that we can
tell whether a tracepoint is present via its id, but we don't load the
id so that we can do things like pretty printing unless libtraceevent
is present:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/perf_event_attr_fprintf.c?h=3Dperf-tools-next#n242
I think it would make sense to make the tracepoint PMU have
events/aliases and load them as a special case from
`/sys/kernel/tracing/events/`. Currently all the tracepoint event
logic is special because the only event name containing a colon is a
tracepoint - we don't allow `tracepoint/lock:contention_begin/` as an
event, which seems out of keeping. I think we could go pretty far with
what perf needs by supporting tracepoint events through the PMU and
removing as much "#ifdef HAVE_LIBTRACEEVENT" as possible.
I mention this as it would make sense to have the name fncache be
related to the PMU in case PMUs come and go, as could happen with the
perf daemon.

Thanks,
Ian
