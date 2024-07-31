Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23581799F
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441538; cv=none; b=oejLN9JfKRkhAddPVtGsI20Ayx8EH71YT82mWhxoeZMGjsSiH0Myyyfv8m5n3xIZg0iW/9FDhIh0egwTEO7IW0KLUaR3vyLDpFn1iNykIh7IZRdfGHSAwI0CYDHB+SjEXpqHciAWzMPWLi+gw6fb+plSqvhj5ce3WR7XMzzYqKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441538; c=relaxed/simple;
	bh=HMYEQltRZ8Tw+WKokvRCPrxZb0HKX0yrf0ddXvi96Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujsNQoFozSym2ApWTguwxKVjuV3HPDoVk9cufs64b+NFM8FoCt/7N41iwt+4bjuQL7LBJ4pmtwMKMSbSmh9P3uQ2m3JU31cz0HpJj9SSFG7+pT6vsr8PyJg73YFafCuWDbQO1ZQK+eV7D7X+6VAZJSJ0rdtSIeiXWVltLDu+T1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fahv2gaa; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fahv2gaa"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fd7509397bso203405ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jul 2024 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722441535; x=1723046335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAhdp5zpySe0+FB5jDx9UjZEWAHh/7EBv/tXoOqBR90=;
        b=Fahv2gaaNSqNOzJfF0+Fl8SJQFS0sWpNlYUU+euX8+BlPidPVPRcRxUb0VuN2Tll9K
         3g0N7Pm9Scqd6O25E9dDXNWw+z7SR61+sBCkua43S0XYu1odwcnMpc+5oUB3QGfUj1Li
         CB6dYAE5Ji4c/7Fegv5BnZV1IOZ6xu496vS/6IZ7KiFaNlVCxvcT2K1C5RjlGenbpF1H
         hGdWTKvY53h3m1JERktMNc4TxRubF9H8Qklx1hrKK5c2KN3lTbFijzvytZ6vm5zjuIad
         78vUTd5LiS25FF9QS3YAKckQDQr1tyL/PHdE7rfpsr6QTeVGALE0BLE7yVUhaMjrblBK
         txoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722441535; x=1723046335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAhdp5zpySe0+FB5jDx9UjZEWAHh/7EBv/tXoOqBR90=;
        b=gZCp3JruJMe3tUGixTEGFX3ANb06mNMTeK8KTTLQGyOAEIvCzgJkJl3xqnhfSB1v/5
         zTu9FX1OAFO7RWgV4ldgLUSC8vDPsQOtZjRrVu+CxnG3wZ1mvA+v6j2rTu9pVx6GXtb4
         DSgvhZWniM9uERw62Lzz1GdB15DifV8jakGYJqJY8mehxqoD8rLw/g/vlbK1teICwyzU
         hDYdXq1b8nuAf1Hr0Qqfu8YHdFbkdu6fy35vqtg29Ph3QTFXzu7BwkHTY6YKh8xtdJ3y
         AvLtx4zK+iQspS960y6xzHEo6EHk+NVmzz5g7KogIvv0i4yN8HhPivBewb1XOImj7ZGN
         i6Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUHeYdgWFG6KrRVeGrAtIAY7hM7zah8HTeuafuTDv4H+RpahiOU6a9RSyQD49w9S+7b76RAPU0i6+8r8vXgqm7urHXmuyhqZgC6JcYqVK226A==
X-Gm-Message-State: AOJu0Yz4OhWHo795zr6qwNzSvxNRA93jqN+0KWanShjIeLQ4BfrOzvOs
	gCRvdkEqzSWmQ1Yk9sTNXOeeSxhuj8SxS3+izbU9HFjs6x/V4qbuUfMveAh3Xim+GkYxsftH8r6
	HX8wgqn2jXCFzIEoM06rticbKFK2vLYhXC+nw
X-Google-Smtp-Source: AGHT+IGMppatA2gCc9t440JBtXjRkJbktHUaH/U7LYdlrJiclQaIDtvsOz+rN1EUSUYMsorHuenPRwk2uXi43KbY4ts=
X-Received: by 2002:a17:903:120d:b0:1f7:1c96:d2e8 with SMTP id
 d9443c01a7336-1ff417d4905mr3381625ad.10.1722441534719; Wed, 31 Jul 2024
 08:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730191744.3097329-1-irogers@google.com> <20240730191744.3097329-3-irogers@google.com>
 <Zqo5vVdrkhL5NHJK@x1> <CAP-5=fXyOfPya+TrKVaFhCK3rNY=AuLZLG67ith5YHf_XXVdNg@mail.gmail.com>
 <ZqpZWywTe2j3U9Pl@x1> <ZqpcRIzzBb5KC6Zb@x1>
In-Reply-To: <ZqpcRIzzBb5KC6Zb@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 31 Jul 2024 08:58:43 -0700
Message-ID: <CAP-5=fVm5FkLDOLk4cbD9K6VPZ088f3Yk3bG8LT79E_OLLN4Lw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf jevents: Autogenerate empty-pmu-events.c
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, philip.li@intel.com, oliver.sang@intel.com, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 8:46=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Jul 31, 2024 at 12:33:50PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Jul 31, 2024 at 07:08:18AM -0700, Ian Rogers wrote:
> > > On Wed, Jul 31, 2024 at 6:18=E2=80=AFAM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Tue, Jul 30, 2024 at 12:17:44PM -0700, Ian Rogers wrote:
> > > > > empty-pmu-events.c exists so that builds may occur without python
> > > > > being installed on a system. Manually updating empty-pmu-events.c=
 to
> > > > > be in sync with jevents.py is a pain, let's use jevents.py to gen=
erate
> > > > > empty-pmu-events.c.
> > > >
> > > > What am I missing here?
> > > >
> > > > If it exists so that we can build on a system without python how ca=
n we
> > > > use python to generate it?
> > > >
> > > > Now having python in the system is a requirement and thus we don't =
need
> > > > empty-pmu-events.c anymore?
> > > >
> > > > Can you guys please clarify that?
> > >
> > > The requirement for python hasn't changed.
> > >
> > > Case 1: no python or NO_JEVENTS=3D1
> > > Build happens using empty-pmu-events.c that is checked in, no python
> > > is required.
> > >
> > > Case 2: python
> > > pmu-events.c is created by jevents.py (requiring python) and then bui=
lt.
> > > This change adds a step where the empty-pmu-events.c is created using
> > > jevents.py and that file is diffed against the checked in version.
> > > This stops the checked in empty-pmu-events.c diverging if changes are
> > > made to jevents.py. If the diff causes the build to fail then you jus=
t
> > > copy the diff empty-pmu-events.c over the checked in one.
> >
> > I'll try and add your explanation to the log message, thanks for
> > clarifying it!
>
> So, with it in place I'm now noticing:
>
> =E2=AC=A2[acme@toolbox perf-tools-next]$ rm -rf /tmp/build/$(basename $PW=
D)/ ; mkdir -p /tmp/build/$(basename $PWD)/
> =E2=AC=A2[acme@toolbox perf-tools-next]$ alias m=3D'rm -rf ~/libexec/perf=
-core/ ; make -k CORESIGHT=3D1 O=3D/tmp/build/$(basename $PWD)/ -C tools/pe=
rf install-bin && perf test python'
> =E2=AC=A2[acme@toolbox perf-tools-next]$ m
> <SNIP>
>   GEN     /tmp/build/perf-tools-next/pmu-events/test-empty-pmu-events.c
>   MKDIR   /tmp/build/perf-tools-next/arch/x86/util/
>   CC      /tmp/build/perf-tools-next/util/annotate.o
>   CC      /tmp/build/perf-tools-next/arch/x86/util/tsc.o
>   CC      /tmp/build/perf-tools-next/arch/x86/tests/hybrid.o
>   CC      /tmp/build/perf-tools-next/util/block-info.o
>   CC      /tmp/build/perf-tools-next/arch/x86/tests/intel-pt-test.o
>   CC      /tmp/build/perf-tools-next/arch/x86/util/pmu.o
>   MKDIR   /tmp/build/perf-tools-next/ui/browsers/
>   CC      /tmp/build/perf-tools-next/ui/browsers/annotate.o
>   CC      /tmp/build/perf-tools-next/builtin-kallsyms.o
>   CC      /tmp/build/perf-tools-next/util/block-range.o
>   TEST    /tmp/build/perf-tools-next/pmu-events/empty-pmu-events.log
> --- pmu-events/empty-pmu-events.c       2024-07-31 12:44:14.355042296 -03=
00
> +++ /tmp/build/perf-tools-next/pmu-events/test-empty-pmu-events.c       2=
024-07-31 12:45:35.048682785 -0300
> @@ -380,7 +380,7 @@
>                          continue;
>
>                  ret =3D pmu_events_table__for_each_event_pmu(table, tabl=
e_pmu, fn, data);
> -                if (pmu || ret)
> +                if (ret)

Right, you need to copy:
 /tmp/build/perf-tools-next/pmu-events/test-empty-pmu-events.c
to
tools/perf/pmu-events/empty-pmu-events.c
to fix this.

This change has happened as you are testing with:
https://lore.kernel.org/lkml/20240716132951.1748662-1-kan.liang@linux.intel=
.com/
which isn't in the git repo yet (therefore, I can't make a patch set
on it). The change is WAI as it is telling you empty-pmu-events.c has
become stale and needs Kan's fix applying to it.

Thanks,
Ian


>                          return ret;
>          }
>          return 0;
>   CC      /tmp/build/perf-tools-next/tests/openat-syscall.o
> make[3]: *** [pmu-events/Build:42: /tmp/build/perf-tools-next/pmu-events/=
empty-pmu-events.log] Error 1
> make[3]: *** Deleting file '/tmp/build/perf-tools-next/pmu-events/empty-p=
mu-events.log'
> make[2]: *** [Makefile.perf:763: /tmp/build/perf-tools-next/pmu-events/pm=
u-events-in.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   CC      /tmp/build/perf-tools-next/arch/x86/util/kvm-stat.o
> <SNIP>
