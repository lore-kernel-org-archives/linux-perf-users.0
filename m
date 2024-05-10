Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8F4481BA;
	Fri, 10 May 2024 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715378045; cv=none; b=s3vApijLMhAF0mHb81envsY6REVKsSA01dgOyTvF7dNMbCWNZnlE9XR55lNdmLpxvi3x52uiUclaw9+Q4kmBgMdTVH00+6kloAxyrS91WbcMerSCtaL2mafCemV9dmvLQ2fIDpIElMO6lxm2chXYEjQf14kL3uBrHl0DKPXwDQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715378045; c=relaxed/simple;
	bh=i/FPnuI27T+fA3b9H6PAA9JAHScCbdUPH69z4ZLw0As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqNgqNSjcAa+FasXl5MHINZjfMBUvwIB1OuibUiFUjnO9KQ0pmi00cf+Xa9+ssfzeyqmZq2Xnj17i66SNA+vmcI3E68RN+Oxq/vauWPxd81+TJNxNyvchxh7iSk2pmck5gwSDV4y0PMXjqe/FhcHILU/0wqdXZAw8QiNAeGjXnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-61eba9f9c5dso1998770a12.0;
        Fri, 10 May 2024 14:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715378043; x=1715982843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRPvGQxpDBclplaY0IKUR/KgWVjuexGs9D8VWLdD0zU=;
        b=r78OqZBEgTGlt1Kez5nuJmBDXAcAoGWuFCncdlp4333L1VgChg8Yq5pTuSmrwi/pdu
         r8vUTmE2u4crd5y8j2SeLsdEUu0hNj65pF4x8D2c7ht1IwtZeEzUt0vg+wwiIA7lubNn
         MmtezP6FD1rvqyn+UO27xIvRKc5uPkPOKu7Kpj8keZZ2k15vgGTwhsqadzC7SQMksohm
         Bmp6IGipLdHf1mmwS2gZc3NLkAgfo5nodL3wZcIfrvnSqmSrq+OQ3yw0gv6Gw9nsqDBb
         LI7BkYlZBxCJ21d93Szug3WrmjJQVVD3XH1WKnHBn3vnnXzUDn8/iHvBmXwXZo6nhTr4
         Wkfg==
X-Forwarded-Encrypted: i=1; AJvYcCXc292VLmugAad4Vgf3cjOV4hnEdGfxMvT6eTGA+UARNoGtYsFIx4BGd28zD+qZBz3St+9Cpk1gR5zCQfb+cHWgZyGQs7XxHltesAHZQSI1l94G7GXCfenDH7A1ZYhRp/FVN45IegmNnFBL3yIeLg==
X-Gm-Message-State: AOJu0YyORQJ03bJ3hRYMr5vDrXN1AYjWfQ/xC6csa9Grt2Qh3HrTI2VR
	uXvFuC9nLOLEyBr5g7fzrGAuq/dGqWsNRMmBwf5ZBJbHBWzH6//g3DhyAPD1g03Mwbv1WOeDNoJ
	GyDwmN1ELeh4Bn+uKpE7NX/iigOesaQ==
X-Google-Smtp-Source: AGHT+IF+odiXxybI5aBALPA5XYdwFgLzxBXMq8LAvT+QwarjaK6YnmsBVgjhS2oUkvm+YZXvpHu/EqZjmzMp+/0l6zE=
X-Received: by 2002:a17:90a:9404:b0:2b3:a79a:7e4b with SMTP id
 98e67ed59e1d1-2b6cc76d24amr3721113a91.22.1715378042862; Fri, 10 May 2024
 14:54:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509060541.1928390-1-irogers@google.com> <Zj4tVDdY3CzU7KZM@x1>
 <CAP-5=fWhSfZyWh3ye3WYmPBTEKsqRAd-ZrZjaT68=RVqb-m4kA@mail.gmail.com>
In-Reply-To: <CAP-5=fWhSfZyWh3ye3WYmPBTEKsqRAd-ZrZjaT68=RVqb-m4kA@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 10 May 2024 14:53:51 -0700
Message-ID: <CAM9d7cgos57-56NOevzFb+KwgSHZxjNPHddnf2fK-ypF6Ao7bg@mail.gmail.com>
Subject: Re: [PATCH v1] perf tracepoint: Don't scan all tracepoints to test if
 one exists
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian and Arnaldo,

On Fri, May 10, 2024 at 7:29=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
>
>
> On Fri, May 10, 2024, 7:21=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kern=
el.org> wrote:
>>
>> On Wed, May 08, 2024 at 11:05:41PM -0700, Ian Rogers wrote:
>> > In is_valid_tracepoint, rather than scanning
>> > "/sys/kernel/tracing/events/*/*" skipping any path where
>> > "/sys/kernel/tracing/events/*/*/id" doesn't exist, and then testing if
>> > "*:*" matches the tracepoint name, just use the given tracepoint name
>> > replace the ':' with '/' and see if the id file exists. This turns a
>> > nested directory search into a single file available test.
>> >
>> > Rather than return 1 for valid and 0 for invalid, return true and
>> > false.
>> >
>> > Signed-off-by: Ian Rogers <irogers@google.com>
>> > ---
>> >  tools/perf/util/tracepoint.c | 53 ++++++++++++++---------------------=
-
>> >  tools/perf/util/tracepoint.h |  3 +-
>> >  2 files changed, 23 insertions(+), 33 deletions(-)
>> >
>> > diff --git a/tools/perf/util/tracepoint.c b/tools/perf/util/tracepoint=
.c
>> > index 92dd8b455b90..cca6808f7951 100644
>> > --- a/tools/perf/util/tracepoint.c
>> > +++ b/tools/perf/util/tracepoint.c
>> > @@ -4,10 +4,12 @@
>> >  #include <errno.h>
>> >  #include <fcntl.h>
>> >  #include <stdio.h>
>> > +#include <stdlib.h>
>> >  #include <sys/param.h>
>> >  #include <unistd.h>
>> >
>> >  #include <api/fs/tracing_path.h>
>> > +#include "fncache.h"
>> >
>> >  int tp_event_has_id(const char *dir_path, struct dirent *evt_dir)
>> >  {
>> > @@ -26,39 +28,26 @@ int tp_event_has_id(const char *dir_path, struct d=
irent *evt_dir)
>> >  /*
>> >   * Check whether event is in <debugfs_mount_point>/tracing/events
>> >   */
>> > -int is_valid_tracepoint(const char *event_string)
>> > +bool is_valid_tracepoint(const char *event_string)
>> >  {
>> > -     DIR *sys_dir, *evt_dir;
>> > -     struct dirent *sys_dirent, *evt_dirent;
>> > -     char evt_path[MAXPATHLEN];
>> > -     char *dir_path;
>> > -
>> > -     sys_dir =3D tracing_events__opendir();
>> > -     if (!sys_dir)
>> > -             return 0;
>> > +     char *dst, *path =3D malloc(strlen(event_string) + 4); /* Space =
for "/id\0". */
>> > +     const char *src;
>> > +     bool have_file;
>> >
>> > -     for_each_subsystem(sys_dir, sys_dirent) {
>> > -             dir_path =3D get_events_file(sys_dirent->d_name);
>> > -             if (!dir_path)
>> > -                     continue;
>> > -             evt_dir =3D opendir(dir_path);
>> > -             if (!evt_dir)
>> > -                     goto next;
>> > -
>> > -             for_each_event(dir_path, evt_dir, evt_dirent) {
>> > -                     snprintf(evt_path, MAXPATHLEN, "%s:%s",
>> > -                              sys_dirent->d_name, evt_dirent->d_name)=
;
>> > -                     if (!strcmp(evt_path, event_string)) {
>> > -                             closedir(evt_dir);
>> > -                             put_events_file(dir_path);
>> > -                             closedir(sys_dir);
>> > -                             return 1;
>> > -                     }
>> > -             }
>> > -             closedir(evt_dir);
>> > -next:
>> > -             put_events_file(dir_path);
>> > +     if (!path) {
>> > +             /* Conservatively return false if memory allocation fail=
ed. */
>> > +             return false;
>> >       }
>> > -     closedir(sys_dir);
>> > -     return 0;
>> > +     /* Copy event_string replacing the ':' with '/'. */
>> > +     for (src =3D event_string, dst =3D path; *src; src++, dst++)
>> > +             *dst =3D (*src =3D=3D ':') ? '/' : *src;
>> > +     /* Add "/id\0". */
>> > +     memcpy(dst, "/id", 4);
>> > +
>> > +     dst =3D get_events_file(path);
>> > +     if (dst)
>> > +             have_file =3D file_available(dst);

Off-topic.  But it seems we don't release fncache entries.

Thanks,
Namhyung

>
>> > +     free(dst);
>> > +     free(path);
>> > +     return have_file;
>> >  }
>> > diff --git a/tools/perf/util/tracepoint.h b/tools/perf/util/tracepoint=
.h
>> > index c4a110fe87d7..65ccb01fc312 100644
>> > --- a/tools/perf/util/tracepoint.h
>> > +++ b/tools/perf/util/tracepoint.h
>> > @@ -4,6 +4,7 @@
>> >
>> >  #include <dirent.h>
>> >  #include <string.h>
>> > +#include <stdbool.h>
>> >
>> >  int tp_event_has_id(const char *dir_path, struct dirent *evt_dir);
>> >
>> > @@ -20,6 +21,6 @@ int tp_event_has_id(const char *dir_path, struct dir=
ent *evt_dir);
>> >                   (strcmp(sys_dirent->d_name, ".")) &&        \
>> >                   (strcmp(sys_dirent->d_name, "..")))
>> >
>> > -int is_valid_tracepoint(const char *event_string);
>> > +bool is_valid_tracepoint(const char *event_string);
>> >
>> >  #endif /* __PERF_TRACEPOINT_H */
>> > --
>> > 2.45.0.rc1.225.g2a3ae87e7f-goog
