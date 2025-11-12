Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CC41F4169
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966811; cv=none; b=i2JkwLzVJAeBY4bNBNMRSD3uQ96SN7iIQSBj/IZgxvWW8Asx/1VDQwVRiYu3ETmerVjXvXjCvJaPFKfbnvDHFTKwnikCmQH5LpvQFez91YtdFy1PyphDBBxHdKDE4qauIh5ro98jUZ05hn8x0+/qwKqRQ81eDDSPTR7hvXpOG2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966811; c=relaxed/simple;
	bh=OUe+i0yH614qxh5dXGbsQFtPU1q5ASZItjxnY/0ztIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGNY0zUr7mIJjfNCDxuS3K9ayibM7et6qI59Vdzm1cI22BFnqGaXV/ikaWPhVcCXd2rFaLw2yxbyh5RzQHieA4a4IIurB3tgfGNXbQSknkFNby2mBIcl22E+jo/Xb4uqBgx5YFOVV1KTouK9gfcVUB7cIEGo3DSL2fK+Peu9FS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Vzekm/U; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Vzekm/U"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29852dafa7dso132305ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 09:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762966806; x=1763571606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1P20WNcj3mXYsq9G1MhsNUTXtMdI6bPIKWJ6kbQB3A=;
        b=1Vzekm/UU1h7CVzcDE+WEPreExkEw2BZ14LMiIDXNpZtfIgfINdGwNK+th4orTYbhI
         Lg/lwfxl5ST8JOTfMSk/JHNxFYQtVTOQjdFcq5RfnYZ5D1IYoFORiATL6z2GJ4TlIVaK
         B0y4tmNgThcgvoCEijwyLslJTz3p5QgRIxQuVte7hkbGJ8uqbiyqZ40qrunebLZzE4Q2
         j52j4fLgSwO1qxv5ayFN/gHxqND0GbtoSuPlEo25JsLZ+GMbuzeU8oRLl+GASsSVQj8p
         PiKVfluJ/35TP7h4k+tCSuztIQrW568TX+XfWn9OBhRGlgqEF3JFu1YVu0MWh/xe7vH4
         K00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762966806; x=1763571606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N1P20WNcj3mXYsq9G1MhsNUTXtMdI6bPIKWJ6kbQB3A=;
        b=nabjso4Vg3JPCaIzgQD5GxB56nu26yS0neR66WPODS+RHsyw18285ouQ/i5wKjlDe7
         Mg9wWop8+3Bi36pIs0w4GaZswO9woHt2NGIbfVCDLewjDQWzhjVfcweJ3hB0FQeRmKKf
         nbj3o5wfI1/xh6kFoGOjNsg/rvKIuqLs75qibQ2v67/bgYtUsjLYgI+uPapGFQTqOSWT
         3MoD9grdbwrgLMOIDVw+visF8EKifJKx5NP308YleOrKLMy8eDlFNjlsGDP8NsZi+C66
         hYhU0SpWit1Idpl7sVQJ9oexTorX3yGz0ogHrzBW0Wsg2WyS+WXnj4FEB3G5VIuxdFbU
         KxIA==
X-Forwarded-Encrypted: i=1; AJvYcCUbWjTku/TtjyJCshXmVj0CtJTv0he+zdEIPBJkJSe3PmttxAD+t94LQlEVVQJBa0ZwUrShxmLGoKLcf+aPhAx9@vger.kernel.org
X-Gm-Message-State: AOJu0YxBTs0k8nFeTPOPixhlmurNaDKUqO5aOYAYGF12kbIuo0fy1+0K
	dqvX5EOGIeq6CJY9tO49PsnlxIoYzbK5JwaVqAlLjJqwAKb3OzsWE9rf0LLcb45lsu6H3s43f2j
	AbyqmFynj1BXEtMv+eHFLEJSFD1a72waQGSazRTMD
X-Gm-Gg: ASbGncvCvbSzU5fn3JHcGVKrwivxKZKnrGkjeN7xH7+2ZV3brVfpUmp3LBtL1sYU8v4
	qhyIuC6SujB/bIHA0yU0fqgByI+tL+/W3lLbsXEpBvHaBTS966uaHqfiDIC3gCIcj81tT+6jVOj
	ngDqC6BFNxNz+/9foG3abcRJ7t0zJZvdS+Qx6Tp2zKdR9PebAW0eOX2xrEEOegsTHt2OlwIzhiT
	JKG2WLm0yoKIX6qqNnh9+A/MzWci1JCUBfQEdJX2r4yPWWNLRvBuXjddGT8VgSlwn4kxzJpiLma
	F6Jg3v5XNnc6q2qTOgFDxzrIoqbc//2Nv8gO
X-Google-Smtp-Source: AGHT+IEC06rGle+UIW5ANn2hQ8uIBqNe7nL5BGNBktN6KUTeAETqYMHCENlZJVa01/UdsEb2OweFn4FjFx/aca4afaM=
X-Received: by 2002:a17:903:2352:b0:291:6488:5af5 with SMTP id
 d9443c01a7336-29850709f33mr5717185ad.1.1762966805002; Wed, 12 Nov 2025
 09:00:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603181634.1362626-1-ctshao@google.com> <9413e707-35d2-4c9a-9058-d14112ebb2cc@linux.intel.com>
In-Reply-To: <9413e707-35d2-4c9a-9058-d14112ebb2cc@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Nov 2025 08:59:51 -0800
X-Gm-Features: AWmQ_bkj9-1UtHq-Wg4bf-5hpNakikJbXzE2v4UnHphTg1wxWXHdq7CMbKEijqs
Message-ID: <CAP-5=fX0-W5BKha32qZu5zhJN=7Jvocz+ZwxLzXxYw_g2Zsz4Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] perf: Reveal PMU type in fdinfo
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, james.clark@linaro.org, howardchu95@gmail.com, 
	weilin.wang@intel.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 8:12=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 6/4/2025 2:15 AM, Chun-Tse Shao wrote:
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
> >       return 0;
> >  }
> >
> > +static void perf_show_fdinfo(struct seq_file *m, struct file *f)
> > +{
> > +     struct perf_event *event =3D f->private_data;
> > +
> > +     seq_printf(m, "perf_event_attr.type:\t%u\n", event->orig_type);
> > +     seq_printf(m, "perf_event_attr.config:\t%llu\n", (unsigned long l=
ong)event->attr.config);
>
> Could we print the config field with hexadecimal format? It makes the eve=
nt
> is more easily recognized. Thanks.

I think this is a reasonable suggestion. I think it would also be
useful to dump the config1, config2 and config3 values. I also think
the state of the event would be useful for debugging.

Thanks,
Ian

> > +}
> > +
> >  static const struct file_operations perf_fops =3D {
> >       .release                =3D perf_release,
> >       .read                   =3D perf_read,
> > @@ -7085,6 +7094,7 @@ static const struct file_operations perf_fops =3D=
 {
> >       .compat_ioctl           =3D perf_compat_ioctl,
> >       .mmap                   =3D perf_mmap,
> >       .fasync                 =3D perf_fasync,
> > +     .show_fdinfo            =3D perf_show_fdinfo,
> >  };
> >
> >  /*
> > --
> > 2.49.0.1204.g71687c7c1d-goog
> >
> >
