Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D05B15252C;
	Wed, 19 Jun 2024 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718821627; cv=none; b=sDXOpdoY85Z6wlp49nEfrnvSSgxrJwPkY3IrWLTbjOW6PxAoBTvplugdHaQMp0izMUJa5bEez/8ME8yX9BGGlggBAlo3zp7v8u2qszUL4bk2qOMzIcLds7VnmWvZbZ3uimn2k/I/T/QKY+hRbCtO+AiKM2459VqYr2PF81XsuBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718821627; c=relaxed/simple;
	bh=KABG2wuzIOaQNn7+dKSaXBK4oIWHzA/QfCI3cMYlNRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O474cP8UGKLEGJymctXpUKJ4PrV7rVPaF+SOYQO1dwRLof+Csr8Tw2KLX2TPyRbjhmkf+KXPoFMekXeGLm2GR3npkuKKDyw6fZ+SryTgMBElGsSTyKHCH0vyokmrJromsyZu9VJE5JJq7/5EDVvXWE8P6pEwZqcqbhSpa5RohP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxWKKm7+; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxWKKm7+"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-63267c30eaaso162107b3.1;
        Wed, 19 Jun 2024 11:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718821625; x=1719426425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwDJUI/coNCTREvHUkwFtmxjLL4Y9HIlzwN2rs8t5Cg=;
        b=YxWKKm7+dwmJEeyS08sLnHvfV/7vFa6MSX2M6SHWCRhr8KTN5fC91OmNIyQ24mYRez
         oMGwoU1Uxf0jytb1AtJcrnnj4rSpd2n8KscH2jAQPhg6yIAjR+Obg6YeCBi332c08PWi
         tztioTVCnzKIw6s4+OaNakgxrY0ztWi5oDKjaV8pg2/QkqltW+PCMoA4nvJwLzBhnXHv
         vpUioLgERO6CzGl8UBEuNOsqkwQq2RpGSGEFvWFNooxV+W8gdBMC2chP9T09r+NrK9VN
         QtQNOzsN0x72pPy5INWucCHr1fmJvZhnexWN3UUSunkGhHNsh0/8MvbYr3+mhK1QZBe+
         IoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718821625; x=1719426425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwDJUI/coNCTREvHUkwFtmxjLL4Y9HIlzwN2rs8t5Cg=;
        b=mYUuTJsFi7Z/HIfGnZxL5Z8Hogqgddwjj6lPsP/GbMPRX+EvCYB+2RIA4ZMu+98VSQ
         GP8vc7r2AkrEDMn8Y3E/jZvYUkdpXkNXHzChoAF59G2i5Brqhj0OCSYE6MH7wjc+MN5f
         m6JJ31zCieMWp+jw1QVUhccQ0GiZKofHF3+pLBfKcn0v1Nq1/rJSE76JSO441fJYUGd6
         TxnTONKYkvPEsqv22vE9woeWLd0I1t6Zmd7TI1CzxaKTotZMpSmkFLB1/8YFxl99gQ7Y
         MkSxrzEKV/vh2w7wbbQ/JW761vgswYZdDQ7deVw69s20HRL8+P/AWThR7UZkopwHAHW8
         b70Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvqnsa4sZ24eZp53MIhbQVYOYOTTGdVNYvVRSnYUTPNYtVM4J/uWy++wmGXdfEkk3Py4hPjl761/1yBeVpzQCaw+CrXKDucJ6RcmpOWqT3E367fVf6OP/l1/6cyPVXb58F1KvvRhWYaOutcA9nrQ==
X-Gm-Message-State: AOJu0Yzo60UWksn4uUbWZX0BnrD8BbtZdxiuMfWSXRLuosESP3NAW6YT
	8XoXfXidPn6ndTwS/yti5EJmsj1c14xtJ9wDxvADOgYtEMrPv2+fgM9bmAbmVa4aXqoNNkUAPPf
	a6RQojoKejZ4WXEVnYN+9dx/kFsU=
X-Google-Smtp-Source: AGHT+IGL0lxlQ7j+RDA1jORWHAc/B1SokDm1CZBwo+MTUz8A6W1WHSRs91Jh4B9CH7SVzvSdCrVNv1WyelwCBZOkhlA=
X-Received: by 2002:a81:ef11:0:b0:622:cc0d:62c3 with SMTP id
 00721157ae682-63a8e2d1256mr35838767b3.28.1718821625320; Wed, 19 Jun 2024
 11:27:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619082042.4173621-1-howardchu95@gmail.com>
 <20240619082042.4173621-6-howardchu95@gmail.com> <ZnLianWCCEF6ydVO@x1> <CAM9d7cg7yccjLJ8p7DG3JOOmafofJB1jOjsLmfVpjk=xmNBBSw@mail.gmail.com>
In-Reply-To: <CAM9d7cg7yccjLJ8p7DG3JOOmafofJB1jOjsLmfVpjk=xmNBBSw@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 20 Jun 2024 02:26:56 +0800
Message-ID: <CAH0uvog-ef980ZJ5-LVZLBaogJQGCbh0QoHMZ33XtcMpJVbScA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] perf trace: Add test for enum augmentation
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 10:37=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi,
>
> On Wed, Jun 19, 2024 at 6:51=E2=80=AFAM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Wed, Jun 19, 2024 at 04:20:42PM +0800, Howard Chu wrote:
> > > Check for vmlinux's existence in sysfs as prerequisite.
> > >
> > > Add landlock_add_rule.c workload. Trace landlock_add_rule syscall to =
see
> > > if the output is desirable.
> > >
> > > Trace the non-syscall tracepoint 'timer:hrtimer_init' and
> > > 'timer:hrtimer_start', see if the 'mode' argument is augmented,
> > > the 'mode' enum argument has the prefix of 'HRTIMER_MODE_'
> > > in its name.
> > >
> > > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > > ---
> [SNIP]
> > > diff --git a/tools/perf/tests/workloads/landlock_add_rule.c b/tools/p=
erf/tests/workloads/landlock_add_rule.c
> > > new file mode 100644
> > > index 000000000000..529b5f1ea5a7
> > > --- /dev/null
> > > +++ b/tools/perf/tests/workloads/landlock_add_rule.c
> > > @@ -0,0 +1,32 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#include <linux/compiler.h>
> > > +#include <uapi/asm-generic/unistd.h> // for __NR_landlock_add_rule
> > > +#include <unistd.h>
> > > +#include <linux/landlock.h>
> >
> > This file was introduced on linux in 2021, unsure if it will be present
> > in some of the older distros we test, I'll check with my container test
> > suite.
> >
> > Maybe we'll have to just define those LANDLOCK_ACCESS_FS_READ_FILE,
> > LANDLOCK_ACCESS_NET_CONNECT_TCP, etc as plain #define to make sure it
> > builds ok with uCLibc, musl libc and older glibc.
>
> Maybe we can check if the syscall number is defined first and
> include the landlock header.
>
> #ifdef __NR_landlock_add_rule
> #include <linux/landlock.h>
> ...
>
> Then we need a way to skip the test if it's not defined.

Thanks for the suggestion. I'll add this to the workload script.

Thanks,
Howard

>
> Thanks,
> Namhyung
>
>
> >
> > - Arnaldo
> >
> > > +#include "../tests.h"
> > > +
> > > +static int landlock_add_rule(int argc __maybe_unused, const char **a=
rgv __maybe_unused)
> > > +{
> > > +     int fd =3D 11;
> > > +     int flags =3D 45;
> > > +
> > > +     struct landlock_path_beneath_attr path_beneath_attr =3D {
> > > +         .allowed_access =3D LANDLOCK_ACCESS_FS_READ_FILE,
> > > +         .parent_fd =3D 14,
> > > +     };
> > > +
> > > +     struct landlock_net_port_attr net_port_attr =3D {
> > > +         .port =3D 19,
> > > +         .allowed_access =3D LANDLOCK_ACCESS_NET_CONNECT_TCP,
> > > +     };
> > > +
> > > +     syscall(__NR_landlock_add_rule, fd, LANDLOCK_RULE_PATH_BENEATH,
> > > +             &path_beneath_attr, flags);
> > > +
> > > +     syscall(__NR_landlock_add_rule, fd, LANDLOCK_RULE_NET_PORT,
> > > +             &net_port_attr, flags);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +DEFINE_WORKLOAD(landlock_add_rule);
> > > --
> > > 2.45.2
> > >
> >
