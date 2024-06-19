Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495C34502E;
	Wed, 19 Jun 2024 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807830; cv=none; b=TccQULpCBbdHc2O8Rc2pwbVVvcZ3wfp17lMJ9zGOKzZrIc1zWFYW1BNHGGv0YV0zZdMbhD8AI2Av0OJF6CEJl8UcHq/yTFzP1fXJ1g27UVgRVXzWzFd/cJZxw4WUgJGXygmxBYkFPrrm01bpmI/GwOUN69jS8E7w5iUW5b+8JW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807830; c=relaxed/simple;
	bh=x6NRM0Wd/dKIBRZxOMdNl8xpgje8YklE7FrB9pPbj6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qr/121nzPRZsIwwrFb0zu1aqnh+qxuwMAJ/Pc30Y6igy7vpQAzNwylOqpAGK9+aKu0nGWMULK2uil0Or0jlTe2Zk8d53/lmnJPooh9NAiqt+CrKGTG3Q1tFTgRDlHyXxyi3Mqg4rL92KmuVpInshZqbgenzQEhL2gFdFNgn98Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c2c6277ef3so5349495a91.3;
        Wed, 19 Jun 2024 07:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718807828; x=1719412628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gP1VJ7kQiJGM0n4f6UiRupEpEMSQerAYURwdrjXyXxU=;
        b=v4tVvAfw/kt28T1BuknOuT/ShVTQ4jdpQlkEjJGtFik7yTn16C+SekeXIdXyR/EQDf
         fzVcDJav7GhaGB073600Kzkv8gLIIOcSiFBp5/F6ii8iyO/+75OBhmp3slMXx1ym8gN1
         Ci9nyH+TEW1qdSEfv3UJw5Y+Afv61fI7EUuLk7HcgPJtNz7Z5vTk9j1AOO+yDmqNn16w
         Vm49SwY4bBjNnQPTJ6iVSILx4yXrY4kPaWeq4akjM66JTagmdx6DCU2Dx2sh/jCd2gmk
         8q0u+tuuRANhpPGPHVCqvRR7MEmZkUOJmBtlWb7kP4YpzTNhGrI6Efhddb6qVqf3gSbL
         yajA==
X-Forwarded-Encrypted: i=1; AJvYcCXlO2QnqsnVNQ05lpbCRklBtS9SbJP3AdgqsSRQIJsyDek8O5gAMykb9iY3XR851Akhjy4JlsY+F77O8j9MzqTdoxSvFjWylPSxurN+VlmM15LWHTUjLxCqFZofiZiltlR2AY67W97bMYo5qpryfw==
X-Gm-Message-State: AOJu0YxYGEPrxkFx4v7I+SDs81+d0JXLva0SY8eXmNrHd6AGS83ZkAF2
	CxkuPW231uuJ/OJJ+arwc6dK5ZFegEZajOlO0JA4CeXzlPTu+WqeGpbN95ifChIkh/oQa04KfIs
	f4u8MgsuUQqEHx1TR3R02dKj1X9E=
X-Google-Smtp-Source: AGHT+IHKMEXkRsal/FHOajaYC+Tv1+w8iaV1TCo8NfL/dZIwCPWlmEgiVVy4KBRduSGi34Vb0d2Zy27J6CXTPXUW1Jw=
X-Received: by 2002:a17:90a:4ce3:b0:2c7:c306:8a69 with SMTP id
 98e67ed59e1d1-2c7c3069ee5mr1791355a91.9.1718807828459; Wed, 19 Jun 2024
 07:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619082042.4173621-1-howardchu95@gmail.com>
 <20240619082042.4173621-6-howardchu95@gmail.com> <ZnLianWCCEF6ydVO@x1>
In-Reply-To: <ZnLianWCCEF6ydVO@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 19 Jun 2024 07:36:55 -0700
Message-ID: <CAM9d7cg7yccjLJ8p7DG3JOOmafofJB1jOjsLmfVpjk=xmNBBSw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] perf trace: Add test for enum augmentation
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 19, 2024 at 6:51=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Jun 19, 2024 at 04:20:42PM +0800, Howard Chu wrote:
> > Check for vmlinux's existence in sysfs as prerequisite.
> >
> > Add landlock_add_rule.c workload. Trace landlock_add_rule syscall to se=
e
> > if the output is desirable.
> >
> > Trace the non-syscall tracepoint 'timer:hrtimer_init' and
> > 'timer:hrtimer_start', see if the 'mode' argument is augmented,
> > the 'mode' enum argument has the prefix of 'HRTIMER_MODE_'
> > in its name.
> >
> > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > ---
[SNIP]
> > diff --git a/tools/perf/tests/workloads/landlock_add_rule.c b/tools/per=
f/tests/workloads/landlock_add_rule.c
> > new file mode 100644
> > index 000000000000..529b5f1ea5a7
> > --- /dev/null
> > +++ b/tools/perf/tests/workloads/landlock_add_rule.c
> > @@ -0,0 +1,32 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#include <linux/compiler.h>
> > +#include <uapi/asm-generic/unistd.h> // for __NR_landlock_add_rule
> > +#include <unistd.h>
> > +#include <linux/landlock.h>
>
> This file was introduced on linux in 2021, unsure if it will be present
> in some of the older distros we test, I'll check with my container test
> suite.
>
> Maybe we'll have to just define those LANDLOCK_ACCESS_FS_READ_FILE,
> LANDLOCK_ACCESS_NET_CONNECT_TCP, etc as plain #define to make sure it
> builds ok with uCLibc, musl libc and older glibc.

Maybe we can check if the syscall number is defined first and
include the landlock header.

#ifdef __NR_landlock_add_rule
#include <linux/landlock.h>
...

Then we need a way to skip the test if it's not defined.

Thanks,
Namhyung


>
> - Arnaldo
>
> > +#include "../tests.h"
> > +
> > +static int landlock_add_rule(int argc __maybe_unused, const char **arg=
v __maybe_unused)
> > +{
> > +     int fd =3D 11;
> > +     int flags =3D 45;
> > +
> > +     struct landlock_path_beneath_attr path_beneath_attr =3D {
> > +         .allowed_access =3D LANDLOCK_ACCESS_FS_READ_FILE,
> > +         .parent_fd =3D 14,
> > +     };
> > +
> > +     struct landlock_net_port_attr net_port_attr =3D {
> > +         .port =3D 19,
> > +         .allowed_access =3D LANDLOCK_ACCESS_NET_CONNECT_TCP,
> > +     };
> > +
> > +     syscall(__NR_landlock_add_rule, fd, LANDLOCK_RULE_PATH_BENEATH,
> > +             &path_beneath_attr, flags);
> > +
> > +     syscall(__NR_landlock_add_rule, fd, LANDLOCK_RULE_NET_PORT,
> > +             &net_port_attr, flags);
> > +
> > +     return 0;
> > +}
> > +
> > +DEFINE_WORKLOAD(landlock_add_rule);
> > --
> > 2.45.2
> >
>
