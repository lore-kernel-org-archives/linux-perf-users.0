Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC561E98FF
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775061141; cv=pass; b=AIkdJAH5/yMzA9wO87VUtpl34XPSDt3ZXpCvemQHUIJDp64QVOLRjlOjCmleWBQeShCqAhxJqR2erSTkhCYaEtdPK1Wtz3tuxYw11iZcnmGT4PkLQ2Ii3RuWaQVnVc+X4kJxQFqd6v5bD2Jx633BZB24MR/xYf9FmxQB0kCj8b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775061141; c=relaxed/simple;
	bh=Q2rkDE3RcKsGQIDvG7G9l4W/xFa87PiCjn92xyx0acI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GP3FkLhHffRWt3RiGMIJPN//yLZe89OyJynxzGX+lCqhpt3RfgHOzgtuVos2L1W8hB40U0xEg5cR1VcDkcogFA+zauXKr/eaCGfHCWDEHezNz48D8XLsRecRwKlhTdc3urI7ZrM4LZnlOfU2V/TortXxu6zDlE7o7jwXtUM3Uw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=opS0yUIr; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="opS0yUIr"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b243198058so204185ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 09:32:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775061137; cv=none;
        d=google.com; s=arc-20240605;
        b=lMSfjYFXOmem9crg35lSgojaVvOcvobfzG88IBgdsBNiEZbyOYRp54qeR6OZm0E2zG
         7u6Ntu5Zn8E+C2fhmnJCQEoKX14934SbWezZ/M2p1MDBECZvJpKbhAYcFW2cOBzDKoSA
         6Et8t/vqbrblfj1Z5Hb0/d0lfEyGMkkh5KCD4ga4h38e1K2x7fdEcAaJz6tPLs2wg1+O
         P0rBPucVFgqm7GLXZwI1M+MGcybHCK4jloa7kyLsYCI/rGDavj4BO9PGzafuNaCLP91V
         1Krm/qd1mexbwrP2fveaLyxjyCuQ5ND0scp5Tr117faPw0Q4Pco1V7F+JOSrz7Qr5VKn
         ZeQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CXBXVKK2TXmfSRBdjIo4v/2ObPRfZ8Hmuct+Up9E5CM=;
        fh=B31VvvP6y1tPQbIWTrg1DwJlcCSCBYW7Zg8NkpexL0M=;
        b=ghSk639Dh308+wkKW32SWFR5c/8Eak08UplcKZBfYofrOuLsqxTqK4ydFE6etz6IEE
         Me1QPYYxl2q3CLQ4uFbu6DZ0w6GtrdRDhqD7NS0EYrIh/iJ6rHj0PuYskeRm7RlCtAuR
         Dd4RaYx/e4qqunqGG7AtQbx8aBRGujvBzMYPAmMi2N5Fs74uP5kbHJI0qEP+80WULwmz
         xAKUe+y9UK5iLMeTkUZQ5VagJHkTQmqwPESe2w6XNKEgT3XvkN+2lJT1eEcYsmYMP13x
         0uKsGVAjf8YtWKl3W6WGwXCpo7HFa9UC4o59yRoDooMo2VhAGDh1VN13HfrgQRnFyU0R
         zjMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775061137; x=1775665937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXBXVKK2TXmfSRBdjIo4v/2ObPRfZ8Hmuct+Up9E5CM=;
        b=opS0yUIrWJzEE7BZLDXCsdZNIiYd0OrVQNsIWRSVDMTgxbfzb2L6CUUZ6N4odXuz7t
         TeUJdQri1GiwpKFrvBiomk0mrNfZpxnn/HNFo00v1LTCZvmNWPLWcc86ZZAPwmP3uvO4
         mPD79h01iks4bkYXJi/GfO9BguUnza3k/F+biGt2aD3UmbxhANSs5vtBWXxe6cQ84W8q
         DyH+reHmSsbGAD/PuL5m6AUDiT1oki71KUS4xPmTZ7V/nskkHcO7Mq749MLbdvpATp+m
         Jlf+EWn+2TxGB4qT8Qufi4/YXeEpWMLDEsiEEvSESJkozTgJBbslTzG9Fog6hyZt1JfU
         /S+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775061137; x=1775665937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CXBXVKK2TXmfSRBdjIo4v/2ObPRfZ8Hmuct+Up9E5CM=;
        b=C6jDlWa19kAgHb4SLVbksaIQmEvQ+IaYI01Lftt6enyGV015xRpIsFKxAjw1hmrkKn
         bEvxs3D0o+1T3PeW2q8qL5uVotLH+rMTinhmej6oM2JX7+jbLsEBjYQDwBp1XZcV362u
         Rx/RXUsUhxP4OqK2F7Agw7WgYc33z2Xecamk0Jx06rdcQRii9iSu4h404C0M89SJziL6
         ym4y0xcdPmM7jiv1qR+DQPxdXMo8bRVaJ+Ad8FCOUi/HDDR6LKWZ82LqyeAhao3kVq4L
         NfaxdMz2pcHlsYs5PP40ZYtZdD9S6eEyYmyGpGDEcBBtZ6+uI9F6yjThV9/JjIjWCGsT
         isyA==
X-Forwarded-Encrypted: i=1; AJvYcCUDeLK6guGl16A4uCJmPOzjCrd3QATxbHiPlrOXiQc6XdG1OfNQdFBSYCgwMLhiMmoICDxIyFVwB1YoAq/9ShiD@vger.kernel.org
X-Gm-Message-State: AOJu0YzIsogxC8s1cXqM2Gp4FhItXNCUvRzo3QX9WOIuklhXg5bhL/Hs
	Y9vqknZS5i/yrBNu6QxDL0LJexIlKRK6eUIaOe3yidsoOKPZ6+PcCDatveOb3CnqvZ2aL45BabF
	jpVGP7FHad9chOKBW87UIO2cwYHmqpR6UsvmK3Grg
X-Gm-Gg: ATEYQzzSvzm/Bvb8/1zNBNkrvIqwXshl3rbq6FPVEDzVD5n5RTBTIZAMJJlgcpJD1Y8
	GWJumYFmmosKhLy6pQ7OZ2Kcgwb6Sm6K93uqU1p1o9cNHoo1j3ZF7WX7onn543R+T7p2XqGD79k
	Iqg4eDgTMhJyiYB/dplOfAExyqDWdb8jVXt7VufdWpOgOWta1JDOKHKB+kR1ZQt62T8dAtPWUoZ
	JfuJ2Uq7A2+9CK1NSgVzBs82Z1q/BQPTStMXHTMz8kNpQ3Kb+A5v5rANOkSZGoGiXIYUxv4Z0df
	v9d3zZohJC4GwHUi2maRLcuQhqWa1tBP1hmX5x2GSYRxFfE=
X-Received: by 2002:a17:902:e54a:b0:2ae:c7c8:f46 with SMTP id
 d9443c01a7336-2b2753979dbmr146085ad.18.1775061136342; Wed, 01 Apr 2026
 09:32:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603181634.1362626-1-ctshao@google.com> <9413e707-35d2-4c9a-9058-d14112ebb2cc@linux.intel.com>
 <CAP-5=fX0-W5BKha32qZu5zhJN=7Jvocz+ZwxLzXxYw_g2Zsz4Q@mail.gmail.com>
In-Reply-To: <CAP-5=fX0-W5BKha32qZu5zhJN=7Jvocz+ZwxLzXxYw_g2Zsz4Q@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 09:32:05 -0700
X-Gm-Features: AQROBzAItQEatsBOCWfr2iBB4xUcsp0KHETqKe22dc1uIJJM3O4JS1HV6O7FoEg
Message-ID: <CAP-5=fVPgHyAtLCVemMfedvH=J__9j28DXdNHJZGD12GNgF7AA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] perf: Reveal PMU type in fdinfo
To: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, howardchu95@gmail.com, 
	weilin.wang@intel.com, linux-perf-users@vger.kernel.org, 
	"Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 8:59=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Sep 29, 2025 at 8:12=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.inte=
l.com> wrote:
> >
> >
> > On 6/4/2025 2:15 AM, Chun-Tse Shao wrote:
> > > It gives useful info on knowing which PMUs are reserved by this proce=
ss.
> > > Also add config which would be useful.
> > > Testing cycles:
> > >
> > >   $ ./perf stat -e cycles &
> > >   $ cat /proc/`pidof perf`/fdinfo/3
> > >   pos:    0
> > >   flags:  02000002
> > >   mnt_id: 16
> > >   ino:    3081
> > >   perf_event_attr.type:   0
> > >   perf_event_attr.config: 0
> > >
> > > Testing L1-dcache-load-misses:
> > >
> > >   $ ./perf stat -e L1-dcache-load-misses &
> > >   $ cat /proc/`pidof perf`/fdinfo/3
> > >   pos:    0
> > >   flags:  02000002
> > >   mnt_id: 16
> > >   ino:    1072
> > >   perf_event_attr.type:   3
> > >   perf_event_attr.config: 65536
> > >
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > > ---
> > > v4:
> > >   Removed the first patch in v3 since it is merged.
> > >   Retested to make sure the patch still work.
> > >
> > > v3: lore.kernel.org/20241106003007.2112584-2-ctshao@google.com
> > >
> > >  kernel/events/core.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 95e703891b24..bad563692d63 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -56,6 +56,7 @@
> > >  #include <linux/buildid.h>
> > >  #include <linux/task_work.h>
> > >  #include <linux/percpu-rwsem.h>
> > > +#include <linux/seq_file.h>
> > >
> > >  #include "internal.h"
> > >
> > > @@ -7077,6 +7078,14 @@ static int perf_fasync(int fd, struct file *fi=
lp, int on)
> > >       return 0;
> > >  }
> > >
> > > +static void perf_show_fdinfo(struct seq_file *m, struct file *f)
> > > +{
> > > +     struct perf_event *event =3D f->private_data;
> > > +
> > > +     seq_printf(m, "perf_event_attr.type:\t%u\n", event->orig_type);
> > > +     seq_printf(m, "perf_event_attr.config:\t%llu\n", (unsigned long=
 long)event->attr.config);
> >
> > Could we print the config field with hexadecimal format? It makes the e=
vent
> > is more easily recognized. Thanks.
>
> I think this is a reasonable suggestion. I think it would also be
> useful to dump the config1, config2 and config3 values. I also think
> the state of the event would be useful for debugging.

Any updates on this? It seems to have been forgotten about.

Thanks,
Ian

> Thanks,
> Ian
>
> > > +}
> > > +
> > >  static const struct file_operations perf_fops =3D {
> > >       .release                =3D perf_release,
> > >       .read                   =3D perf_read,
> > > @@ -7085,6 +7094,7 @@ static const struct file_operations perf_fops =
=3D {
> > >       .compat_ioctl           =3D perf_compat_ioctl,
> > >       .mmap                   =3D perf_mmap,
> > >       .fasync                 =3D perf_fasync,
> > > +     .show_fdinfo            =3D perf_show_fdinfo,
> > >  };
> > >
> > >  /*
> > > --
> > > 2.49.0.1204.g71687c7c1d-goog
> > >
> > >
