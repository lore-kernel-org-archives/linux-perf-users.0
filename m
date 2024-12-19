Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9D12080F2
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Dec 2024 05:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734586684; cv=none; b=HjN398yfLOFg51SU9dfRc1AjJkFM3IQ7arrjVmacZU+4ZTO+ppWQJ1lE/10rPPDVnMexlz8pUFoBzqJMcDwOWbH1k3g+U2YKD6AP+ZGO30q37G9p1dTZfmxagaRgn4e3uDx/S6Enj7m3dHn3z+rFN+stcQWE6eTHUhEQibvv22I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734586684; c=relaxed/simple;
	bh=uGND9OTQgKgAF94ms86qWGoofQ833fJ74mmOKm4slFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHgikNlA4CuCmVu/7ffdBpQb+xVxr3SFWn1G3nlx2v9tcLsOgHYi0+e+TupCWHT6zcSbHJ6A9O+g/a2GEYj0P2x9sTFa6M7MtDZzJQIA8T8JO9j1U9u5pP1IlOg6DvKx1ON+zGTC7ZIRoIalNlWN/MH7CAN2YVInwu0UmkA2zfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FNdsVjlh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FNdsVjlh"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385e06af753so195092f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 21:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734586680; x=1735191480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbvFpyUL5vwr1w2uOdYglciSOqAcjANgQ4umT9wqGqg=;
        b=FNdsVjlh2C/DPCSl/QP9nbcQ3iX0m67sxQWMPml6xTOeJTEUEHd1L2+X64nMR/mo0Q
         K2SkvVy6EpTafBs1eTcpnl0bAb5Lq1BoBl8WzhSRQC996PDOek+9F7p7BpveJe9I12iw
         HX/H4jsfAr+4pZVUH7KU3DwgBHbc9RjRpbgDK5s6MwnXIJnXBu37okbUtNPf5IrEcpxq
         edEV3MNN3PnlSp5Ag30rCMQmwOTYeHcsQDi51ubFkaHcJdReLh0WxDovDzccrn2zjJ4Y
         yVH84M7QrC0Zc7IyWpboH3mnlgp8eQMdbtMDUUh+/bGoecgeKGYizKSBSHQtLoFMQtzX
         DYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734586680; x=1735191480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbvFpyUL5vwr1w2uOdYglciSOqAcjANgQ4umT9wqGqg=;
        b=f+b0Z0dpv3Y72v6kZaMhaQK1ke7bjwxi5XQxQPtDtO1D3N/eHDFnWjCN73kg+R77LA
         KSJnIbjzxqtvLdDiTAoSRhVFnOwbxXlbhqo5JpLPuRH9jNeAn7MRjad65qMnCmmLFxyj
         knZQbaZ/6Eum4ofz5WzbX7Z7tjMkuc2V84103XTSuRQPUq3pNc8mjgXDqanPS6kpFvV2
         t81g4diD+UMdCgBmKOcW7hLGngI2edFX5kMgBr6WRQXveCYkebfSSqNbdbsiQUa4DD7q
         RkE4mD2x/tycv4p9Y/s5VQ9e23jUkXJlan2/FeX15yJwjqy+GD0Jxj7xxA2QnCjrIQ/r
         tg2w==
X-Forwarded-Encrypted: i=1; AJvYcCW9ZNmiRUwuh68cl2L6IfNIQndkTMLgHL4JpHq9uRd0S7WgwZSXpxTT/tTR6n/R3Sgs4n+0Bdo/UCwkffoUbTJO@vger.kernel.org
X-Gm-Message-State: AOJu0YzNGlEZ3ToQ6kZ8b6ENAAwd63L+UpWAOJit8TX+5gfpBrFZupk4
	Hnbo47XTJnwryGLKaXGw4Z7oJCotScLuQQ2GissZ6Ud0GDTHc+t2ucK8q+IRLXI7lz8okyUE4vd
	sCj0MmM65A4ycLxGc4u1Fnz3HqGfxzuTsgM+X
X-Gm-Gg: ASbGncu6T08vGyOZQwyhuJX/zSR/oFQL7+KOFEY8xMeaN0odKcpDD7qVT4PA+/fQ0Uu
	Z11IWFqXjuDc9DQfNUcZDM7gSA2QiZOTnzCLe
X-Google-Smtp-Source: AGHT+IFPgMt7PwvQoXYRXTzpwSK4Gx+uIVRg7yO0QEG3NFDp/+To+voU61mi1oKjSzmUDdz/1yVtFncfbQoBDs4egTs=
X-Received: by 2002:a05:6000:4614:b0:385:f1f2:13f1 with SMTP id
 ffacd0b85a97d-388e4d83ad2mr4580568f8f.22.1734586680539; Wed, 18 Dec 2024
 21:38:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106003007.2112584-1-ctshao@google.com> <20241106003007.2112584-2-ctshao@google.com>
 <CAP-5=fUc0YttVUMB9oAit3u5hzVGuK5rTLnP_dXD0kqt7QcO5g@mail.gmail.com>
 <CAJpZYjW0evv8SmPMwymjcFQExy+zVHe_6XW79bB_ErRXCwgzfA@mail.gmail.com> <CAJpZYjUEn-Cr-YWfA68iN8jnR7BdSPhg3DxXsQq7OwA93bDpOg@mail.gmail.com>
In-Reply-To: <CAJpZYjUEn-Cr-YWfA68iN8jnR7BdSPhg3DxXsQq7OwA93bDpOg@mail.gmail.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Wed, 18 Dec 2024 21:37:49 -0800
Message-ID: <CAJpZYjUDKxdLEfYJ3TdOz3N5m5R=et7P01a+K8UNpdgjYe3R=Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] perf: Reveal PMU type in fdinfo
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter, just want to bring your attention to this patch since you
left comments on the previous version of patch.

Thanks,
CT

On Thu, Nov 21, 2024 at 1:18=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> Hi, just a friendly ping for review, in case anyone missed this.
>
> Thanks,
> CT
>
> On Thu, Nov 14, 2024 at 10:30=E2=80=AFAM Chun-Tse Shao <ctshao@google.com=
> wrote:
> >
> > Hi Ian,
> >
> > On Thu, Nov 14, 2024 at 7:49=E2=80=AFAM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Tue, Nov 5, 2024 at 4:30=E2=80=AFPM Chun-Tse Shao <ctshao@google.c=
om> wrote:
> > > >
> > > > It gives useful info on knowing which PMUs are reserved by this pro=
ceszs.
> > > > Also add config which would be useful.
> > > > Testing cycles:
> > > >
> > > >   $ ./perf stat -e cycles &
> > > >   $ cat /proc/`pidof perf`/fdinfo/3
> > > >   pos:    0
> > > >   flags:  02000002
> > > >   mnt_id: 16
> > > >   ino:    3081
> > > >   perf_event_attr.type:   0
> > > >   perf_event_attr.config: 0
> > > >
> > > > Testing L1-dcache-load-misses:
> > > >
> > > >   $ ./perf stat -e L1-dcache-load-misses &
> > > >   $ cat /proc/`pidof perf`/fdinfo/3
> > > >   pos:    0
> > > >   flags:  02000002
> > > >   mnt_id: 16
> > > >   ino:    1072
> > > >   perf_event_attr.type:   3
> > > >   perf_event_attr.config: 65536
> > > >
> > > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > >
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > >
> > > > Change-Id: Ibea5618aaf00bae6f48a9b2a6e7798ab2b7f23ce
> > > > ---
> > > >  kernel/events/core.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > > index cdd09769e6c56..398cac8b208b9 100644
> > > > --- a/kernel/events/core.c
> > > > +++ b/kernel/events/core.c
> > > > @@ -55,6 +55,7 @@
> > > >  #include <linux/pgtable.h>
> > > >  #include <linux/buildid.h>
> > > >  #include <linux/task_work.h>
> > > > +#include <linux/seq_file.h>
> > > >
> > > >  #include "internal.h"
> > > >
> > > > @@ -6820,6 +6821,14 @@ static int perf_fasync(int fd, struct file *=
filp, int on)
> > > >         return 0;
> > > >  }
> > > >
> > > > +static void perf_show_fdinfo(struct seq_file *m, struct file *f)
> > > > +{
> > > > +       struct perf_event *event =3D f->private_data;
> > > > +
> > > > +       seq_printf(m, "perf_event_attr.type:\t%u\n", event->orig_ty=
pe);
> > > > +       seq_printf(m, "perf_event_attr.config:\t%llu\n", (unsigned =
long long)event->attr.config);
> > >
> > > nit: is the cast necessary? I don't see __u64 listed on:
> > > https://www.kernel.org/doc/Documentation/printk-formats.txt
> > > so I'm unsure.
> > >
> >
> > In this case I think it is safer to cast it to `unsigned long long`,
> > since I don't know if any architecture would have an exception on
> > __u64.
> >
> > Thanks,
> > CT
> >
> > > Thanks,
> > > Ian
> > >
> > > > +}
> > > > +
> > > >  static const struct file_operations perf_fops =3D {
> > > >         .release                =3D perf_release,
> > > >         .read                   =3D perf_read,
> > > > @@ -6828,6 +6837,7 @@ static const struct file_operations perf_fops=
 =3D {
> > > >         .compat_ioctl           =3D perf_compat_ioctl,
> > > >         .mmap                   =3D perf_mmap,
> > > >         .fasync                 =3D perf_fasync,
> > > > +       .show_fdinfo            =3D perf_show_fdinfo,
> > > >  };
> > > >
> > > >  /*
> > > > --
> > > > 2.47.0.199.ga7371fff76-goog
> > > >
