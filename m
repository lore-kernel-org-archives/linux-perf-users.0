Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1203F1A256C
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Nov 2024 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730496255; cv=none; b=IuEUsN1G+ctbFC6aHaPhOQbRBJyuNOHc+FItEpW2WXGyKIqT1NRwLTPgumxAua/MY+alCVENcnY5VcsEmCrInfNaDPlYdGZbgoLVlTWJhD7ee8c/y5boPv9KCJYZZUcxVnjhWHBwFLz5e4O4Y4Vw5iUyfqnMR8qKdkvGQqAlSBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730496255; c=relaxed/simple;
	bh=1xIA+BlfuPXS5MNT2eekQt6nrdzAAQ8mMRTUpRP5tjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orF/BfjaLve2wj6E9E2wm6URjY4uWGcCfp/9GJtFY4QLOaMY+LGdi8tqaHxuAaq4xhP97vwB8MwypRk84pNweCbvvZN9rmwZAnKFD/uaIx/dRlHGhhgRlENp7Si1gK9s9FzNG21uaEB6hailkCbL7uItJsis79VXNMbE/krtGzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YzUub9pI; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YzUub9pI"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3807dd08cfcso1853638f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Nov 2024 14:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730496252; x=1731101052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGNhWT/+3jcQzIMLrDioD/wPUZ00FjT48riH/ahhZjc=;
        b=YzUub9pIlf4omjO4Dhb61A0wiiiVJ1Hgyw2sdKPlJxv5TG739pmcskXQYNLwcH1EKq
         85jhHdpHTuxPmW7U4Yvobq8/cAl7LuDT5KQplMjjOnTdxS3GLBhi/nA0PfoIlrhTWVuq
         l6L/UIbndugYuy93VLIhZ42G6wMvyUC5Hqu1JiWFaCNJsJICitWHnG2PYK/VRHPolesO
         XhHA0BNYJFte8uzyGgCZl0XtTm0DIdbfow9WHKeuY+rMDr7ENwjBF9k7woGxeGGcZXaJ
         76J0QeZwPB4fB3MAOBj+O1Jct5rg0YmzBhECfnjYksI4Yhtms0gTMejeN+4IIPuM5H0S
         GciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730496252; x=1731101052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGNhWT/+3jcQzIMLrDioD/wPUZ00FjT48riH/ahhZjc=;
        b=L3hGEdMAJsxYFKLh5Cl+Jfb105J18JQVX5eQNg4rdC9D/Ld+OBf6E13OD+wMbb3+J8
         BJ4nqvpkiiEADNo7m5HSh5i6bIV9LXuoII/66mChTPeaRtPP4zNJ2MRzs69Me+n+iOun
         oj0j4RMctXkw6YMVbXr1EMdpf9pIVOr8GzhDHX4oNvV9O6mydVIFff0dhCJRBNoZxQ4g
         MuzkG0Ul66dELPOPyNGagvr1/X4t9FiUlxrnHrHUhsA+dyw3r+/DhlkjnpfeOF7UUAuI
         bf2B9QQDRbpkszvXSIBXdOd9hGJMJ36p87wT05rRpKzH4RCvDHzNAXBaCLyUH+8a+k/R
         vJIg==
X-Forwarded-Encrypted: i=1; AJvYcCWUUFjj7GMKYP83K4qRQUQjbCa371KIo8E0pq6Axm2fnnu+zr+nQXKrahYLyeKBQiGqtIgr8J8bFj0l8hxvPQ/a@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4OFNBSU9Ln9Iu1IlL+xzNWZeDE5GxJ8cfwW9zt/IozOgG64iY
	wUKMTjHZmVEmQ5zn34q6rN0JMMPDghqkcMv2ud1rcDgINCosXFSEAu5aGqDdwf9Amm752EQZJ/Q
	E3PkHAY/ZngXjZFnSVoBEJTqNldrtCd5NpsP2
X-Google-Smtp-Source: AGHT+IEnx1Glirk4swuvBjeKq5AcoRfj7PZEF2jLHYe380MDSfmIfvkIOxb3aj4c5MAOHxwK/ltfektbCrRcmVHOfkk=
X-Received: by 2002:a5d:64a7:0:b0:37c:cfdc:19ba with SMTP id
 ffacd0b85a97d-381c7a6bc70mr4115646f8f.28.1730496252214; Fri, 01 Nov 2024
 14:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031223948.4179222-1-ctshao@google.com> <20241031223948.4179222-2-ctshao@google.com>
 <CAP-5=fVaD8GLhMmM=d4DqHnT24ZDHPAWU56mzSF5OXY=pTO3UA@mail.gmail.com>
In-Reply-To: <CAP-5=fVaD8GLhMmM=d4DqHnT24ZDHPAWU56mzSF5OXY=pTO3UA@mail.gmail.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Fri, 1 Nov 2024 14:24:00 -0700
Message-ID: <CAJpZYjULGa80tC6LBGZyXfUNk3yG5tyieegvheMg6N13QhoHCQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf: Reveal PMU type in fdinfo
To: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your review! Here is the link to the v2 patch with
fixes: https://lore.kernel.org/all/20241101211757.824743-2-ctshao@google.co=
m/

On Fri, Nov 1, 2024 at 9:02=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Thu, Oct 31, 2024 at 3:39=E2=80=AFPM Chun-Tse Shao <ctshao@google.com>=
 wrote:
> >
> > It gives useful info on knowing which PMUs are reserved by this process=
.
> > Also add extra attributes which would be useful.
> >
> > ```
> > Testing cycles
> > $ ./perf stat -e cycles &
> > $ cat /proc/`pidof perf`/fdinfo/3
> > pos:    0
> > flags:  02000002
> > mnt_id: 16
> > ino:    3081
> > perf_event-orig_type:   0
>
> nit: I think this should be:
> perf_event-type:   0
> this output was from an earlier version.

Thank you for the correction!

>
> > perf_event-attr.config1:        0
> > perf_event-attr.config2:        0
> > perf_event-attr.config3:        0
> >
> > Testing L1-dcache-load-misses//
> > $ ./perf stat -e L1-dcache-load-misses &
> > $ cat /proc/`pidof perf`/fdinfo/3
> > pos:    0
> > flags:  02000002
> > mnt_id: 16
> > ino:    1072
> > perf_event-attr.type:   3
> > perf_event-attr.config: 65536
> > perf_event-attr.config1:        0
> > perf_event-attr.config2:        0
> > perf_event-attr.config3:        0
> > ```
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> >  kernel/events/core.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index cdd09769e6c56..e0891c376fd9d 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -8,6 +8,7 @@
> >   *  Copyright  =C2=A9  2009 Paul Mackerras, IBM Corp. <paulus@au1.ibm.=
com>
> >   */
> >
> > +#include "linux/seq_file.h"
>
> nit: I think you should use angle < > rather than quotes on the
> include for consistency.

Fixed.

>
> Thanks,
> Ian
>
> >  #include <linux/fs.h>
> >  #include <linux/mm.h>
> >  #include <linux/cpu.h>
> > @@ -6820,6 +6821,17 @@ static int perf_fasync(int fd, struct file *filp=
, int on)
> >         return 0;
> >  }
> >
> > +static void perf_show_fdinfo(struct seq_file *m, struct file *f)
> > +{
> > +       struct perf_event *event =3D f->private_data;
> > +
> > +       seq_printf(m, "perf_event-attr.type:\t%u\n", event->orig_type);
> > +       seq_printf(m, "perf_event-attr.config:\t%llu\n", event->attr.co=
nfig);
> > +       seq_printf(m, "perf_event-attr.config1:\t%llu\n", event->attr.c=
onfig1);
> > +       seq_printf(m, "perf_event-attr.config2:\t%llu\n", event->attr.c=
onfig2);
> > +       seq_printf(m, "perf_event-attr.config3:\t%llu\n", event->attr.c=
onfig3);
> > +}
> > +
> >  static const struct file_operations perf_fops =3D {
> >         .release                =3D perf_release,
> >         .read                   =3D perf_read,
> > @@ -6828,6 +6840,7 @@ static const struct file_operations perf_fops =3D=
 {
> >         .compat_ioctl           =3D perf_compat_ioctl,
> >         .mmap                   =3D perf_mmap,
> >         .fasync                 =3D perf_fasync,
> > +       .show_fdinfo            =3D perf_show_fdinfo,
> >  };
> >
> >  /*
> > --
> > 2.47.0.163.g1226f6d8fa-goog
> >
