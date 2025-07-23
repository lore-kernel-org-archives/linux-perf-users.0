Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131FA149C51
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 21:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753306261; cv=none; b=KT3C6CpYJyoScFnXYeuZrQia7PISIrbylJ5k0YzjwIz3eOYyFkZRyLrSNcNK6TWS9OLRAf5nFqcukf+oOWPki6fxblX1yESswbA4PM+3gfGIncWzC24qyzzNSg+YxGvm1EigIQQg2fdtV7PHVp6CDcwGLodH083m/O1Phj+Q1zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753306261; c=relaxed/simple;
	bh=8GqfXgHYNXVpgTshJHFZ9EKz1NILSN8zm/sk8THPuhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=furg2iKJ1feh5VrlVlS+jj3R/Tro0iZowv+M3o6l/zrHiGqYKRT2XLgAVnNkUyhB1QUAwiv/A5tY8i58qeFtWdaDDMzHsHMIYQwQr1mQkUwV+MfAkFDx9kG38zd0GCEpJyLkI57ETk7dhdPgc2ItXxuIMBFVgBAFFQClcrA9EnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LigF1vSz; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LigF1vSz"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3e283b2d065so22545ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 14:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753306259; x=1753911059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orgQ53VxvDE7K4DI58+91p61IvF8xtetI5VKe7hXQlo=;
        b=LigF1vSz9NMpcGW9KqZtigS3qC+SzL0AR0zSC6/JLUauEGeLSjP7JS8zPca8PL7lSe
         cWnIj3Utg/DQhFAdIj1HnWzzks0SczrH6D3NQOm9yhgPr8CKoYJjEq+ABZ20z17XHiTV
         gg3eJ6/ZfMW2bBZtvkq0lTm9r6RXC1DVxiKMu+D7L63Jo/8tsn35qvtkKw2CKAcZ1Axd
         FHm4vFD8JC9cs+WTyqfI47/CMve3ncb+1F9BPPc66SjI4Y4aHZgpI4GnxWzd4UD/c0wC
         8PaKZi5Zgg1UHPOIpk7/fuYRGn534eNWvjhOBOO14pjinflc6lhNJbgQZmMk1xINT5Sg
         U5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753306259; x=1753911059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orgQ53VxvDE7K4DI58+91p61IvF8xtetI5VKe7hXQlo=;
        b=wSGjpUEZ5UCFaavaGnbAP7Y1Q4pbcTKBJBs1XEChOliBQr+1AaiOkVIexwVfpTPDaq
         2YQRxmZJ+4d6SncsYjHB/snP4xWL9D+9f3FjMKlOWggLulo6cJNs4qieIGqlz0cM+R3I
         MfCwFSEVmweFrTD/KcqsrpQIpV09dnkrkpLAoMGlxTpy379bElB70wvnSnCUbg0TcOw1
         o2bMc/KLSdv4OwjnxmOKIvl1X+ZwL2I1l5Ywg0fBrMgTt/Y+l+is3fS9te0DxaAGkdI8
         YRidXYnS2WhPPReHDquPRImJzzQYwIrPynqsF2FmdlQCByV55+VPupEKIuw6OeTpzUbo
         MREQ==
X-Forwarded-Encrypted: i=1; AJvYcCV65G2kGfTa2y/B44yidGCDuQrJGQBVPuqGDN4VTr9PlmZ2Vn4y0w46Mlh6MGg9h4raI9GkKP47PJ7+EOA1l/ol@vger.kernel.org
X-Gm-Message-State: AOJu0YzCt6V55mTFYAjg/IBORA2M2O5E/1pxWQlGXlKBU/SI2SRJXVLT
	qhfpVLfvgQskK7a0OiKRdVMDZFj0f+f2oBtYike3lJWcocfc1r24UbdGdQQddfwbVYveailMckl
	2/2pptwUhwUPsx0Fo2cIcwy7ReU7DfJM0Q1qV9PBd
X-Gm-Gg: ASbGncvc9tpK+BF4ipcORESP8c5EUOPK9+q5TiD4pkHwQokP6EkxDu78CJ6taM9+wBQ
	g65uIHvOg+Iqcqsz8gznf5qjZ1wEEESwr479vAn8nj77sCNKbR0nWrMUOA5ZXRUEeh+kLtTgpgM
	xslKoLynDER8Kj6FaQet86BpYT6GyPKzQrRfXNV5oNmYzLZHznsO9l/9ORG7JXOhVoz86PAK8NB
	r/oIzYkVoNecU4nJJKe/6sZta2rBaYJyhsI5Wpm138DI2I=
X-Google-Smtp-Source: AGHT+IHa8E6SGvre3z5lAyD3hgBdrG1LWtWJLI70ia+xv9xvbarp5qfBNf1UyCGO55sjYql1FVMbZMIIFInkmwSh5OI=
X-Received: by 2002:a05:6e02:3009:b0:3dd:872d:b3fd with SMTP id
 e9e14a558f8ab-3e3b6418762mr1447175ab.2.1753306258827; Wed, 23 Jul 2025
 14:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com> <CAP-5=fW=AG8ztbzS-KXpo9fH_Hp_fkZ3CVDuG9pN7P32Qm0oyg@mail.gmail.com>
 <aIEjMroa3bW-T7d-@google.com> <aIEzRNLTCTA5Gqhm@x1> <aIEzzt1f3UWDCAIw@x1> <aIE24fDAuIqDXX3h@x1>
In-Reply-To: <aIE24fDAuIqDXX3h@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Jul 2025 14:30:47 -0700
X-Gm-Features: Ac12FXyJnNr28uVoH2tm43QH4OsNUTUqvtfYcvTGkG-r5LRzTbiSQSKtzuyCDh0
Message-ID: <CAP-5=fXCCKn5EREFCrS5JpRf_Y2ueWAd0cXy4fBfLQcP3XmqJA@mail.gmail.com>
Subject: Re: [PATCH v7 00/16] New perf ilist app
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 12:24=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Jul 23, 2025 at 04:11:13PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Jul 23, 2025 at 04:08:55PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > On Wed, Jul 23, 2025 at 11:00:18AM -0700, Namhyung Kim wrote:
> > > > > I think there is some follow up for "make install" for scripts li=
ke
> > > > > these, but I'm keen for the python API to move forward.
>
> > > > I'll review the series today so that we can get some part of it, at
> > > > least.  Basically I think we need a wrapper script like perf-ilist =
to
> > > > run this easily (maybe with documentation).
>
> > > I just tried, with the series applied:
>
> > > root@number:~# perf ilist
> > > perf: 'ilist' is not a perf-command. See 'perf --help'.
>
> > > Did you mean this?
> > >     list
> > > root@number:~#
>
> > > Now trying to figure out why it is not running.
>
> > So it is not wired up like 'perf archive', trying it directly:
>
> > root@number:~# ~acme/git/perf-tools-next/tools/perf/python/ilist.py
> > Traceback (most recent call last):
> >   File "/home/acme/git/perf-tools-next/tools/perf/python/ilist.py", lin=
e 11, in <module>
> >     from textual import on
> > ModuleNotFoundError: No module named 'textual'
> > root@number:~#
>
> > I thought there was some discussion about catching this exception and
> > providing guidance, lemme try...
>
> root@number:~# sudo dnf install python-textual
> Updating and loading repositories:
>  google-chrome                                        100% |   6.1 KiB/s =
|   1.3 KiB |  00m00s
>  Copr repo for PyCharm owned by phracek               100% |   2.0 KiB/s =
|   2.1 KiB |  00m01s
>  RPM Fusion for Fedora 42 - Nonfree - NVIDIA Driver   100% |   2.6 KiB/s =
|   2.5 KiB |  00m01s
>  RPM Fusion for Fedora 42 - Nonfree - Steam           100% |   5.8 KiB/s =
|   2.4 KiB |  00m00s
>  google-chrome                                        100% |   7.2 KiB/s =
|   3.2 KiB |  00m00s
>  Copr repo for PyCharm owned by phracek               100% |  15.7 KiB/s =
|   4.8 KiB |  00m00s
> Repositories loaded.
> Package                           Arch    Version         Repository     =
Size
> Installing:
>  python3-textual                  noarch  1.0.0-1.fc42    fedora      6.6=
 MiB
> Installing dependencies:
>  python3-linkify-it-py            noarch  2.0.3-4.fc42    fedora    110.4=
 KiB
>  python3-markdown-it-py           noarch  3.0.0-8.fc42    fedora    496.3=
 KiB
>  python3-markdown-it-py+linkify   noarch  3.0.0-8.fc42    fedora      9.0=
 KiB
>  python3-markdown-it-py+plugins   noarch  3.0.0-8.fc42    fedora      9.0=
 KiB
>  python3-mdit-py-plugins          noarch  0.4.2-2.fc42    fedora    289.4=
 KiB
>  python3-mdurl                    noarch  0.1.2-9.fc42    fedora     41.4=
 KiB
>  python3-platformdirs             noarch  4.2.2-4.fc42    fedora    162.0=
 KiB
>  python3-pygments                 noarch  2.18.0-4.fc42   fedora     10.6=
 MiB
>  python3-rich                     noarch  13.9.4-2.fc42   fedora      2.5=
 MiB
>  python3-uc-micro-py              noarch  1.0.3-4.fc42    fedora     13.1=
 KiB
>
> Transaction Summary:
>  Installing:        11 packages
>
> Total size of inbound packages is 5 MiB. Need to download 5 MiB.
> After this operation, 21 MiB extra will be used (install 21 MiB, remove 0=
 B).
> Is this ok [y/N]: y
> <SNIP>
> [13/13] Installing python3-textual-0:1.0.0-1.fc42.noarch                 =
                                                        100% |  10.1 MiB/s =
|   6.8 MiB |  00m01s
> Complete!
> root@number:~# ~acme/git/perf-tools-next/tools/perf/python/ilist.py
> =E2=95=AD=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80 Traceback (most recent call last) =E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=95=AE
> =E2=94=82 /home/acme/git/perf-tools-next/tools/perf/python/ilist.py:470 i=
n compose                                                                  =
                            =E2=94=82
> =E2=94=82                                                                =
                                                                           =
                            =E2=94=82
> =E2=94=82   467 =E2=94=82   =E2=94=82   =E2=94=82   return tree          =
                                                                           =
                                                    =E2=94=82
> =E2=94=82   468 =E2=94=82   =E2=94=82                                    =
                                                                           =
                                            =E2=94=82
> =E2=94=82   469 =E2=94=82   =E2=94=82   yield Header(id=3D"header")      =
                                                                           =
                                              =E2=94=82
> =E2=94=82 =E2=9D=B1 470 =E2=94=82   =E2=94=82   yield Horizontal(Vertical=
(metric_event_tree(), id=3D"events"),                                      =
                                                      =E2=94=82
> =E2=94=82   471 =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82=
   =E2=94=82    Vertical(Label("event name", id=3D"event_name"),           =
                                                                           =
   =E2=94=82
> =E2=94=82   472 =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82=
   =E2=94=82   =E2=94=82   =E2=94=82     Static("description", markup=3DFal=
se, id=3D"event_descript                                                   =
                     =E2=94=82
> =E2=94=82   473 =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82=
   =E2=94=82   =E2=94=82   =E2=94=82     ))                                =
                                                                           =
                 =E2=94=82
> =E2=94=82                                                                =
                                                                           =
                            =E2=94=82
> =E2=94=82 =E2=95=AD=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80 locals =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=95=AE                                                      =
    =E2=94=82
> =E2=94=82 =E2=94=82 self =3D IListApp(title=3D'Interactive Perf List', cl=
asses=3D{'-dark-mode'}, pseudo_classes=3D{'dark', 'focus'}) =E2=94=82      =
                                                    =E2=94=82
> =E2=94=82 =E2=95=B0=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=95=AF                                                          =E2=94=
=82
> =E2=94=82                                                                =
                                                                           =
                            =E2=94=82
> =E2=94=82 /home/acme/git/perf-tools-next/tools/perf/python/ilist.py:433 i=
n metric_event_tree                                                        =
                            =E2=94=82
> =E2=94=82                                                                =
                                                                           =
                            =E2=94=82
> =E2=94=82   430 =E2=94=82   =E2=94=82   =E2=94=82   """Create tree of PMU=
s and metricgroups with events or metrics under."""     =E2=95=AD=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80 locals =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=95=AE         =
                             =E2=94=82
> =E2=94=82   431 =E2=94=82   =E2=94=82   =E2=94=82   tree: Tree[TreeValue]=
 =3D Tree("Root", id=3D"root")                              =E2=94=82 pmus =
=3D TreeNode('PMUs', None) =E2=94=82                                      =
=E2=94=82
> =E2=94=82   432 =E2=94=82   =E2=94=82   =E2=94=82   pmus =3D tree.root.ad=
d("PMUs")                                                 =E2=94=82 tree =
=3D Tree(id=3D'root')        =E2=94=82                                     =
 =E2=94=82
> =E2=94=82 =E2=9D=B1 433 =E2=94=82   =E2=94=82   =E2=94=82   for pmu in pe=
rf.pmus():                                                      =E2=95=B0=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=95=AF            =
                          =E2=94=82
> =E2=94=82   434 =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   pmu_name =
=3D pmu.name().lower()                                                     =
                                                              =E2=94=82
> =E2=94=82   435 =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   pmu_node =
=3D pmus.add(pmu_name)                                                     =
                                                              =E2=94=82
> =E2=94=82   436 =E2=94=82   =E2=94=82   =E2=94=82   =E2=94=82   try:     =
                                                                           =
                                                            =E2=94=82
> =E2=95=B0=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=95=AF
> AttributeError: module 'perf' has no attribute 'pmus'
> root@number:~#
>
> Ok, that was with the 'python-perf3' rpm package on fedora 42, trying
> with the new one...
>
> root@number:~# export PYTHONPATH=3D/tmp/build/perf-tools-next/python
> root@number:~# ~acme/git/perf-tools-next/tools/perf/python/ilist.py
>
> Cool stuff!
>
> Lots of flashing lights! :-)
>
> Interesting to quickly browse all those events, I like it.
>
> I searched for "wakeup" and stumbled on ftrace:wakeup failures, but that
> should be just a minor adjustment, some exception list:
>
> root@number:~# ls -la /sys/kernel/tracing/events/ftrace/wakeup/
> total 0
> drwxr-xr-x. 1 root root 0 Jul 23 16:04 .
> drwxr-xr-x. 1 root root 0 Jul 23 16:04 ..
> -r--r-----. 1 root root 0 Jul 23 16:04 format
> -r--r-----. 1 root root 0 Jul 23 16:19 hist
> root@number:~#
> root@number:~# ls -la /sys/kernel/tracing/events/sched/sched_wakeup/
> total 0
> drwxr-xr-x. 1 root root 0 Jul 23 16:04 .
> drwxr-xr-x. 1 root root 0 Jul 23 16:04 ..
> -rw-r-----. 1 root root 0 Jul 23 16:19 enable
> -rw-r-----. 1 root root 0 Jul 23 16:19 filter
> -r--r-----. 1 root root 0 Jul 23 16:04 format
> -r--r-----. 1 root root 0 Jul 23 16:19 hist
> -r--r-----. 1 root root 0 Jul 23 16:04 id
> -rw-r-----. 1 root root 0 Jul 23 16:19 trigger
> root@number:~#
>
> Do you know how to take text screen shots in textual?

So there's a built-in screen shot thing. Press ctrl+p to bring up the
inbuilt command palette, then select "Save screenshot" which will save
an SVG screenshot. It should be possible to force a lowly terminal and
then grab the characters, I tried but didn't get very far with it.
There are console recorder apps. My preference has just been to grab
regular screenshots and then cut out a PNG. Attaching any kind of
non-standard character or image to an LKML post I think would cause it
to be bounced. I've posted some images here:

ilist working first on events:
https://fosstodon.org/@irogers/114677152263351891
ilist metrics working on hybrid:
https://fosstodon.org/@irogers/114831660998075850
ilist running on WSL on AMD:
https://fosstodon.org/@irogers/114849910913098482

> Apart from the super minor nits, thanks for working on this:
>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks! I think there are still improvements to be had like improving
the layout of the screen, deduplicating PMUs, etc. nothing that can't
be incrementally added. Probably the biggest thing is what to do for
"make install" and packaging it [1]. I think it is a very nice way to
discover what perf can inform you about, and I think everyone I've
talked to prefers doing it with this app rather than trying to get the
same data from regular `perf list`. For example, I was surprised how
much data I could get from WSL.

Thanks,
Ian

[1] (some thoughts on packaging in reply to Namhyung)
https://lore.kernel.org/lkml/CAP-5=3DfX1j_MdzjqLTYeNGFTWLaQp8Dmbi093QN98b2p=
NgFcpBA@mail.gmail.com/

> - Arnaldo
