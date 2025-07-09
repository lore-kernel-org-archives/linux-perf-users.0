Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818B4AD21
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Jul 2025 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074723; cv=none; b=GqCPv2K9DZXTf5buF5RuihAsJSI22gxdrD8dfKHF+F2FA4biLLtQ3aTOSBjmG3lPB4PXpNM0n7N/Yw5CWoOSkap5QNPuwAjQuXW25qztDzCWIhF00StF7U4CM2kSlhK4K1mVnqq9y485h6yqAKaFZANitDfcYOZcExIP2H6d2mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074723; c=relaxed/simple;
	bh=CxJBqhlrcAX6OgfPXG4HJO7yEixQ9vduEz7ZaZR2wQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eq/0HMApGITbCEu8o0MPkz/uJxn5yzs8qnpLEQH3+Qe1HqCia6I4hXAU3RZrd0CDD+N1BSUeUQDG7xK6o+gc133pu+CxEujLJc37qDHOE1KPdEHJyZ9tOmkt/kNR25Cjd1bsBz+3IQGTQKCBvTh2MBMrW1ETXzjw6sRMSsVUeI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HZXAGjOz; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZXAGjOz"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3df2fa612c4so257015ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Jul 2025 08:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752074720; x=1752679520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MXttdVhsPyPi72qpkf3PBJn9R3oi0UkWvffsszV45M=;
        b=HZXAGjOzGntmN7VnkBpG9d/rNmu9i7j/jPgwmgDfZVvpiyppeBzdz1xzXiu4MqI7Lf
         jd5nfWcolWCpbKNEXyqnVtsmt9hQDansQmOWychG6w/J+uqI9rEzbUp/0OZ6oD84xVFR
         nUKDcWDO3jWy82KYY4lDVeeloMmYX2DERhnW6Vy97JOcczM1joxisx0bhLXCgqQJ2/zC
         XNJZo8f/k0oy+IaumW5TpxhInlbmjV7bi4HLHUMTbhoiuhAw7WOmdSn0nz6ldy1q2wHF
         Sd0mWXY79dtr5vuFRZj+Ce7w6jTtFicIo/7uVvTwV0lfYa+Y6qTKzpKje+lF969ocOJS
         6Yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752074720; x=1752679520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MXttdVhsPyPi72qpkf3PBJn9R3oi0UkWvffsszV45M=;
        b=jH0GNJF54cOJPCtpDAxMjwGjYCSx+RAe7lVkNnfK9YDBNwFuvaa/OJVwcZs+Aih5nK
         drKIJW3ZxUakNWDQCttT3hs43WqHzC3PsId79J+4hZTr/Oud1MLs8awL5M+eWpVMkmes
         Gb7d4XFDAvRRVQCCGUXhj9PW+qKtKfIhWg1vOGAWXY1t74I8LyAcSNyY6yw1gXFv9HFP
         Fb6jbjTA4WHGIu6vitCAplNicaWtgliq3npW3SiEEEGuc0D+jf7wJYaiuE/VJfXeaTco
         XdxZwRzLlWXNDfxgIxZi272IgB4kzWJcsSGeP0kvfpxt2ICYd3fGXTGcQUMc7z1L/Yy3
         Kjhw==
X-Forwarded-Encrypted: i=1; AJvYcCXejHHPp0oLaBzmCWC0pESWwdl7cxXkYbHRfn3BW/fuocsV0Oj7PZRa+R4mOkRPn8GB57Pzzi6nEukqgxsHblz5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1SN3L3/aYlv0zsudmx9YyolgsN07fyDLQZ/FTH3EAn+NjT8vK
	eWNCp73R2b/poXj3rDP5t9XTgCU/CayU35Rt5vDLcNqcbH0uoh1a6qYRdOIOereQP4GqgnAndWE
	vZWUcwLNq/ajJVKylKdeQTtb6uDHsqkE+xE9QP/km
X-Gm-Gg: ASbGncviQ/S5tJ4p43yEAZaOw/C6sHB0QbpZ1Kie1CNKW6wnELQ4g3UWDzctNzXDO1p
	5iNZ7GEJMKy37DqdMLvpgY+iIP8kmhji+P1xdMoX9ymKPyp+CAlwCCo0Th9owRzEiCPMOHA8Mew
	IcN9V6DZvEG+svRQnHgKDePXmJC1VKl5b3sANGCkYb5hV9NKvlqEIJrQogx5JkfKDdjetQi+Uv
X-Google-Smtp-Source: AGHT+IHzYwcVE8vOHoXHoNi2SlVmZHN2p4elfH3n1On0m3+V0/TicM03vxIA5SKHhNVI6qwUDEnOIcWGkxzj5jck+rw=
X-Received: by 2002:a05:6e02:1489:b0:3dc:7cc4:3cb0 with SMTP id
 e9e14a558f8ab-3e1662767ddmr3981645ab.18.1752074720284; Wed, 09 Jul 2025
 08:25:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603181634.1362626-1-ctshao@google.com> <CAP-5=fVjA9630Com3xNWvgDHbwmsswQ8GEbqvnZ5QCtARQJuvQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVjA9630Com3xNWvgDHbwmsswQ8GEbqvnZ5QCtARQJuvQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 9 Jul 2025 08:25:09 -0700
X-Gm-Features: Ac12FXwUms8IDbdE-vcEByBVyBXkIv194VzMSR9YD-Tpp16vi9yDvoR_cAvJhuc
Message-ID: <CAP-5=fXY68WRiz3PVD19GBPg4t+_-f3pyLCwhdCDZHmQ=Aag3Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] perf: Reveal PMU type in fdinfo
To: peterz@infradead.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	james.clark@linaro.org, howardchu95@gmail.com, weilin.wang@intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 8:06=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, Jun 3, 2025 at 11:16=E2=80=AFAM Chun-Tse Shao <ctshao@google.com>=
 wrote:
> >
> > It gives useful info on knowing which PMUs are reserved by this process=
.
> > Also add config which would be useful.
> > Testing cycles:
> >
> >   $ ./perf stat -e cycles &
> >   $ cat /proc/`pidof perf`/fdinfo/3
> >   pos:    0
> >   flags:  02000002
> >   mnt_id: 16
> >   ino:    3081
> >   perf_event_attr.type:   0
> >   perf_event_attr.config: 0
> >
> > Testing L1-dcache-load-misses:
> >
> >   $ ./perf stat -e L1-dcache-load-misses &
> >   $ cat /proc/`pidof perf`/fdinfo/3
> >   pos:    0
> >   flags:  02000002
> >   mnt_id: 16
> >   ino:    1072
> >   perf_event_attr.type:   3
> >   perf_event_attr.config: 65536
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
>
> Ping.
>
> Thanks,
> Ian

Hi Peter and Ingo,

This small kernel change enables being able to better diagnose which
processes are using perf events for what. In the series it is used in
perf to blame EBUSY for PMUs like intel-pt on which processes are
using that PMU.
Are there issues that need resolving before the patch can be
considered for inclusion?

The original patch was sent in October 2024:
https://lore.kernel.org/lkml/20241031223948.4179222-2-ctshao@google.com/

Thanks,
Ian

> > ---
> > v4:
> >   Removed the first patch in v3 since it is merged.
> >   Retested to make sure the patch still work.
> >
> > v3: lore.kernel.org/20241106003007.2112584-2-ctshao@google.com
> >
> >  kernel/events/core.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 95e703891b24..bad563692d63 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -56,6 +56,7 @@
> >  #include <linux/buildid.h>
> >  #include <linux/task_work.h>
> >  #include <linux/percpu-rwsem.h>
> > +#include <linux/seq_file.h>
> >
> >  #include "internal.h"
> >
> > @@ -7077,6 +7078,14 @@ static int perf_fasync(int fd, struct file *filp=
, int on)
> >         return 0;
> >  }
> >
> > +static void perf_show_fdinfo(struct seq_file *m, struct file *f)
> > +{
> > +       struct perf_event *event =3D f->private_data;
> > +
> > +       seq_printf(m, "perf_event_attr.type:\t%u\n", event->orig_type);
> > +       seq_printf(m, "perf_event_attr.config:\t%llu\n", (unsigned long=
 long)event->attr.config);
> > +}
> > +
> >  static const struct file_operations perf_fops =3D {
> >         .release                =3D perf_release,
> >         .read                   =3D perf_read,
> > @@ -7085,6 +7094,7 @@ static const struct file_operations perf_fops =3D=
 {
> >         .compat_ioctl           =3D perf_compat_ioctl,
> >         .mmap                   =3D perf_mmap,
> >         .fasync                 =3D perf_fasync,
> > +       .show_fdinfo            =3D perf_show_fdinfo,
> >  };
> >
> >  /*
> > --
> > 2.49.0.1204.g71687c7c1d-goog
> >
