Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AA7126BEE
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731609016; cv=none; b=WgfqjTjCpwqeWWFf4HNa1Yp+kZeU51dsgbfTNAQHw2yef1vGgcOStDAw1MygslgInk/VI14e9nxjfEA2dhoZduGiT0PIiyR/83w93AyyXANHnTVYRSRYDaCf3rfayFC6ZIe9mJPnNsFO4N38SOtoiReAX/gwvCp9r1ryvi+ooWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731609016; c=relaxed/simple;
	bh=Kr0hE3k5FC/KnAkCH3REPq2yTw28oTp2Mjo1YenTWvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMI7CqBpV5CGb94Y4Q5iPEevQTayu74M2pBFjhp/zqz+DyqBWOPq9LIoYYg0vhLZDppWu+WjXbx/dUMLQZrDBgXJQwK290ah2dlrRt5ZbxsgXd5NqxGsSjdg4F5ZDyrIvDsvbjorW0GtzcFTmqeEaqQ+WvDsJ+44LXExPNnotxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2X2nm4ZX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2X2nm4ZX"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431ac30d379so8461675e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 10:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731609013; x=1732213813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVUW+fryu8sjk7dvvS0Y/dTeXAbZLIJBIGf+5Rp7Ou0=;
        b=2X2nm4ZX90tyRa/xgRX+2blIEpMM09V6vxrPzRfc/zId8rNstxX5RQrRwtmKUNa/QS
         yQ7rW6pR/lE6Je6w7FVACGwMjtCWLUnNE/GYPEhju6PXZg2SrswQK9tXM1UpXR2SKhbs
         hBoiP339rxy78lLErJBLDZGdvfeB3Nsk4gAtcXP7UIUAjK7s4H6GKiHErFKg2qE5d1V9
         0hvSVtQoIUOOEW3tcHKAWhFFoZ+R4CULosEh+8z4I5eMeegHOdN9yrMomC4mwoO8cqrN
         M/5r6+TaJsna1/sU/d0ptYgXkxyqR2lP9oulvUtZK6XkMikWcz8W4IvLcai49tqKxoPr
         Z3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731609013; x=1732213813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVUW+fryu8sjk7dvvS0Y/dTeXAbZLIJBIGf+5Rp7Ou0=;
        b=u+Gg9McnooDWJj3YRMntVk9x3gh7phlogSL+vU0RHDdHfNnyczt+JzDEBe5yZjyT1Y
         5zh2O7uqIHvS5JTBqLwzeUaaxAz8a66Q8yh19fSBN3O5AxwnFhlKxx9br0zmACacsHWB
         81ultEhsJp5ZHxpDDptzPN9FJlbZmMEW8fIxyoYj43hoJXZFFy9xOFJ02HMwpwi5kIsP
         q+dyvtBp15Yv7E2vH0dN72x1II8RSQ4cnfEbI5iVveEQJI6dRokbZRICKZ60s/ugTwO5
         N5tvQmDFc02+EfbnZuJz+62IWgUU9Q/r/jlqN80O3uTg/ba0JhTGHY1p4AU0K+ITXMke
         xNuw==
X-Forwarded-Encrypted: i=1; AJvYcCU3oZPzi/RN5J3Q89s8Ew9kDuBcO0yWqzDPmBp3fXisNHQ/t3zMPxLPGDa2HCJ8pUOhIXIBItNoEr3GkdoElRBr@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+0SlWpth6cGtGy80cJNISg2gW8Fj3NpIDa0S+QsSED41ajrS
	OL801hoJs1AyDBl2VdaRzvCDlFdTBKtrS8mzEi8SGntyt4kstAZK+MfPGKh/4fvYRQXmHoOzWO5
	ZJ/nETAete2fXCRQEBijQRrN2V7UUAoRFlReJ
X-Google-Smtp-Source: AGHT+IGH8NF9fj4Zodyu94TAlU6ALUhFoOCiA49oPNUuyhMkDakBJFCxl5trdgO+xI2wWUR48WmA5d9kU1memP3RdQM=
X-Received: by 2002:a05:6000:1445:b0:37d:446a:9e60 with SMTP id
 ffacd0b85a97d-381f1839803mr22161366f8f.0.1731609012720; Thu, 14 Nov 2024
 10:30:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106003007.2112584-1-ctshao@google.com> <20241106003007.2112584-2-ctshao@google.com>
 <CAP-5=fUc0YttVUMB9oAit3u5hzVGuK5rTLnP_dXD0kqt7QcO5g@mail.gmail.com>
In-Reply-To: <CAP-5=fUc0YttVUMB9oAit3u5hzVGuK5rTLnP_dXD0kqt7QcO5g@mail.gmail.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Thu, 14 Nov 2024 10:30:01 -0800
Message-ID: <CAJpZYjW0evv8SmPMwymjcFQExy+zVHe_6XW79bB_ErRXCwgzfA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] perf: Reveal PMU type in fdinfo
To: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Thu, Nov 14, 2024 at 7:49=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, Nov 5, 2024 at 4:30=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> =
wrote:
> >
> > It gives useful info on knowing which PMUs are reserved by this procesz=
s.
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
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
>
> Reviewed-by: Ian Rogers <irogers@google.com>
>
> > Change-Id: Ibea5618aaf00bae6f48a9b2a6e7798ab2b7f23ce
> > ---
> >  kernel/events/core.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index cdd09769e6c56..398cac8b208b9 100644
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
> > @@ -6820,6 +6821,14 @@ static int perf_fasync(int fd, struct file *filp=
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
>
> nit: is the cast necessary? I don't see __u64 listed on:
> https://www.kernel.org/doc/Documentation/printk-formats.txt
> so I'm unsure.
>

In this case I think it is safer to cast it to `unsigned long long`,
since I don't know if any architecture would have an exception on
__u64.

Thanks,
CT

> Thanks,
> Ian
>
> > +}
> > +
> >  static const struct file_operations perf_fops =3D {
> >         .release                =3D perf_release,
> >         .read                   =3D perf_read,
> > @@ -6828,6 +6837,7 @@ static const struct file_operations perf_fops =3D=
 {
> >         .compat_ioctl           =3D perf_compat_ioctl,
> >         .mmap                   =3D perf_mmap,
> >         .fasync                 =3D perf_fasync,
> > +       .show_fdinfo            =3D perf_show_fdinfo,
> >  };
> >
> >  /*
> > --
> > 2.47.0.199.ga7371fff76-goog
> >
