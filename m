Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7864F9F8
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Nov 2024 00:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853158; cv=none; b=Yhu7L1y6QrnZw//h0nCi8GARbn9DJSsBUuj0KPNAAvoc8evtcfYxhnecwT0F5tpqocBPOqbJm9neA1tGTVFrBrbt0EnNrvPwQpZeftG2+VLkqgFsOzadkYJw+ml+MkbgXS13aHGuYUwnVSlPfwXFGVnzKbBF4Sd1EBOabtC6VV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853158; c=relaxed/simple;
	bh=W2MNS7vs8Wdqb5q6mm979sTO3PGe0U27MYkgdgZT9Yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7U9PJi71oCtjSyfUEEM/tn6nW6r+Ceg3P1XVhv8p9XIqR5EslDMlkg3eB+Fw8CmS1G8aETRXhKElo7Z5UztzxuhSDnv9Ajvmea/rzEFnPWDSnnCyX0Q+rgMoqCTBti7jhBbVs/yKsBexW9xiqVbB0B4oK3GFYHGQWjZCtrhHDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ogNx1LKA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ogNx1LKA"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so51889345e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Nov 2024 16:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730853154; x=1731457954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgQmIWY1Y20zXq4aq/x6E7RoCbmNzYOzB+1w+5Cai0k=;
        b=ogNx1LKAx01eLG1aVoibjEiAK6VkjRNvvzmV/LUhiqjB3sTYH9e9a8dP/amdD7RHuO
         LGhJRY8OElJqxur6LLcPAE7iGQMGvX6wKttqbi1Z3srnLZ2rHWCCJ8vECFKQ5YuQbu5v
         0Q0Wwjgmh84/Wp3+bSSYJPBZDZkqhXU2oZgeMDzEDYK+lZw8gOwi6MrXOdW6R+1ZBvps
         qxR5Ir4Q5q6lnD2y0u9STHGEObhnh+sOi4xPnczKH4enk0Ai/m5YztddPVeIbxoAE3CT
         t0hAq4816N58tM3RyToQVxISq284g3DLiF9RYaGc8jjY0IxRHo1nrjV4/BUMNX9Rjh15
         /Izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730853154; x=1731457954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgQmIWY1Y20zXq4aq/x6E7RoCbmNzYOzB+1w+5Cai0k=;
        b=OMYsH5GygdKvkj2C5xCaNTWj63eecwQvysjU8s0luuuq2vbhuap6uYkE1ESVtRoFbJ
         aJTXzOwRhXMD2ahx1cgGdZPEirMRgi/ejNsim13IEI7/U2GldpKLq3D8+4er7ztL862F
         WN/Z9CoTvo3tcSPL6hIPxxgUDlM5a8eJPvTtdfJYXI41Q6BcUXz8Rv0VBjooc05DnB53
         JQTtyjdPJBzgaH61IMuw2xXJkGqysfb2cCgBxoIwmhAY9duKh2bVYojwK8aphqW9SVgU
         lsM5UrjG4AEGiMeDQsv0Mgi5tKxzeLQbVQQUg7UEGKjlrAc27uiXmfflvlGWX/tCPwQV
         ivXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSNjMKs6bP8TYJ9fqLPgP/AZXqDCeWaPpyGQcNRyRtsVWYBKORsKEM3UXwgwjxBg8NBgFNSK9sMq34NJlC+pWg@vger.kernel.org
X-Gm-Message-State: AOJu0YwCqMnaCUBQcChi4GqocjinKXU1an1V1KgI+oK2+eI2cgpWWM1U
	yzLoZ6QFo3dqay7XYOt8iqOja6zdlH2rWnY+5QtGh6G97QdFJvIV6ZCLrYsvEkIpUfH0ebzp9bq
	frFEj5AuKIdsylE+nh88105K2MbF7o6db77J1
X-Google-Smtp-Source: AGHT+IGRX/BfDnE/ylrb2nu1HzcsSnkrmxoFVgn2PYUGFFm5Kq6UXrZ/5K54cVuz+foZxCgeQTkVL30IMYttPtUfOcA=
X-Received: by 2002:a5d:4045:0:b0:37d:3bad:a503 with SMTP id
 ffacd0b85a97d-380611e0f45mr25473953f8f.40.1730853154062; Tue, 05 Nov 2024
 16:32:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101211757.824743-1-ctshao@google.com> <20241101211757.824743-2-ctshao@google.com>
 <Zyli1TWn8ZaNWSxm@google.com>
In-Reply-To: <Zyli1TWn8ZaNWSxm@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 5 Nov 2024 16:32:22 -0800
Message-ID: <CAJpZYjVrTsuSwT-31hBYihzmK94j6BWGD4XxudTXMB0W+Hcb+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] perf: Reveal PMU type in fdinfo
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your review, Namhyung! Here is the link to patch v3:
https://lore.kernel.org/all/20241106003007.2112584-2-ctshao@google.com/

On Mon, Nov 4, 2024 at 4:12=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Fri, Nov 01, 2024 at 09:17:56PM +0000, Chun-Tse Shao wrote:
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
> > perf_event-attr.type:   0
>
> Maybe 'perf_event_attr' would be appropriate as it's the name of the
> struct.
>

Agree.

> > perf_event-attr.config: 0
> > perf_event-attr.config1:        0
> > perf_event-attr.config2:        0
> > perf_event-attr.config3:        0
>
> It's hard to pick which fields to show here but I'd say that those
> config[123] are not used frequently at least for regular events.
> Maybe just showing type and config is fine.
>

Agree, it should be fine to add more if needed.

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
>
> FYI usually the kernel changes are applied to a different tree than the
> tools.
>

Thanks for the heads up!

> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index cdd09769e6c56..c950b6fc92cda 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -55,6 +55,7 @@
> >  #include <linux/pgtable.h>
> >  #include <linux/buildid.h>
> >  #include <linux/task_work.h>
> > +#include <linux/seq_file.h>
> >
> >  #include "internal.h"
> >
> > @@ -6820,6 +6821,17 @@ static int perf_fasync(int fd, struct file *filp=
, int on)
> >       return 0;
> >  }
> >
> > +static void perf_show_fdinfo(struct seq_file *m, struct file *f)
> > +{
> > +     struct perf_event *event =3D f->private_data;
> > +
> > +     seq_printf(m, "perf_event-attr.type:\t%u\n", event->orig_type);
> > +     seq_printf(m, "perf_event-attr.config:\t%llu\n", event->attr.conf=
ig);
>
> I'm not sure if all archs are happy with treating it as %llu.
>

I think with type casting to `unsigned long long`, it will make it
print in `%llu` for all archs.


> Thanks,
> Namhyung
>
>
> > +     seq_printf(m, "perf_event-attr.config1:\t%llu\n", event->attr.con=
fig1);
> > +     seq_printf(m, "perf_event-attr.config2:\t%llu\n", event->attr.con=
fig2);
> > +     seq_printf(m, "perf_event-attr.config3:\t%llu\n", event->attr.con=
fig3);
> > +}
> > +
> >  static const struct file_operations perf_fops =3D {
> >       .release                =3D perf_release,
> >       .read                   =3D perf_read,
> > @@ -6828,6 +6840,7 @@ static const struct file_operations perf_fops =3D=
 {
> >       .compat_ioctl           =3D perf_compat_ioctl,
> >       .mmap                   =3D perf_mmap,
> >       .fasync                 =3D perf_fasync,
> > +     .show_fdinfo            =3D perf_show_fdinfo,
> >  };
> >
> >  /*
> > --
> > 2.47.0.163.g1226f6d8fa-goog
> >
