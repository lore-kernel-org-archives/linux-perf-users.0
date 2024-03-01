Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EFF365
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 00:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252368; cv=none; b=ukfMjKZHnRjcstAfsjc9lMP/7VSc43bKo5riflcZNDpNDMsIikZoRcmIV382icfW3N3DzOojMt9gz9Ga4oQp0gIp7ruNC18+SqSMUjrkuagwjIOExGggHXVosskQ2z4W4bQyzuFY3qvdypFb8D2wIyEU50eOXkPVoDQ7KeE0wo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252368; c=relaxed/simple;
	bh=7oaRx7txOLY5lh/ghksCzjvbdA7i/vJfUT0jQTEBt2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5KDdr3PX7wwUV1ysDKpImXsVYGp7whdjnSfjUxZwWr9m4x//GmcIIVni5Au7zeS06N9yfKuSn2bk+2izcf9Q+01aSsh8z/Kv/fAG8t/1nkXfOHgax5pvv+hiuWINY7BRzZtqEeTjNCaiZ2quEvFJRIPYZ9MTGR3F8onfNqE3+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NEAjVP/3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NEAjVP/3"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc744f54d0so82515ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 16:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709252367; x=1709857167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UWpBAgUjQGEcDfT6+E949LPPMhHm1UHzIqySFkY11k=;
        b=NEAjVP/3lxBxNeGI51nhHxu7G41cEIy8va/gHYs61xSjqwHrWSxhthvcLYrWniZrqc
         ATRet53Ni8hZ/O8CZKXaM6yfYFFV+ungVLGxVXn4vRo43uynlS59P+bmQxcxCt86llvl
         kAmQq9OdEyMIS2+++6X7aWvljiWKuOj9bRI+3FPuLcsaN0TSKOrUs90OFU6m09OgqSe/
         wipTBNL6vfrm2iAyYNSt34I4cMPOLxf1Fi7YAyPHXatC7Ibaomtv1daJun9odZSRIpas
         wmj9QXKQCW/ypOiHyKPaROgPbdYiP3uVsZmrhP/MiR2lEHGSS8y0MGfwJzn/4XnqI/7e
         2njg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709252367; x=1709857167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UWpBAgUjQGEcDfT6+E949LPPMhHm1UHzIqySFkY11k=;
        b=B4fy3h/sO5+z3xguD4jLRinlW/QsYTa0nAEuCjUQmyHzIlWMivBV5cgu9Hb/i8rwgA
         pzunSndyk+ef7Uolo1nQHCsd+K/2bXrPrr+wK9w1EY0+cSm7WnJDLIOVR7WD4winZ+xN
         9qAJZF4nRcbVs4WnTD1SzPsLD+918+/5l2ynrj8pL/2Nrnn/AUJATZkGohIPVtfzmLHM
         Yie9thtFc4FWsoEv9enq9/61zGxv4+hv0625tYSnjEDo30rhp1JV2/fTuIqfUsmERiNA
         uFwMUbjMzGBsxi4qOE25L8qwPTzewO+miwLfQNdNCCeCNLeO+JiRn01qx8cJAKio7RfB
         nLnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVupidipUIB4NMbWZkIEhpdO6RqrSKTEbAnOzr+zOgrgAZ0mpyiGUL9hVFFP0cq190QXu34suNELNBjja2r01sH0Mu2h+5wV3Er1AxcQ62/3w==
X-Gm-Message-State: AOJu0YwTdF2t222KpEZ+OOkEtiRmIiU/jpTGzQG4Fs7wpUsCvs1ZGqR2
	T5DWZuUbcHFEdkWAIX2j1C6+2Euc9nX3mkXS22i/q50/jkJuQ+W8pdW7iuO7t82nTZSC2MrpRbt
	aK1dAFjD50CfSWWRBrL6DxWZNKqZiC4QrjRXm
X-Google-Smtp-Source: AGHT+IG+krEZg1W4lxxNiq3BuiCY53h8CWBR5bxCp6JLwaMIKWJDGBm2DvjENztc4Nf5wogg1bUBirKz0SR/4ekNyeo=
X-Received: by 2002:a17:902:db0d:b0:1dc:6cf4:5908 with SMTP id
 m13-20020a170902db0d00b001dc6cf45908mr80892plx.6.1709252366428; Thu, 29 Feb
 2024 16:19:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-5-irogers@google.com>
 <CAM9d7cjuv2VAVfGM6qQEMYO--WvgPvAvmnF73QrS_PzGzCF32w@mail.gmail.com>
 <CAP-5=fUUSpHUUAc3jvJkPAUuuJAiSAO4mjCxa9qUppnqk76wWg@mail.gmail.com> <b60c7731b8a84e01a77fea55c31a77b9@AcuMS.aculab.com>
In-Reply-To: <b60c7731b8a84e01a77fea55c31a77b9@AcuMS.aculab.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 Feb 2024 16:19:11 -0800
Message-ID: <CAP-5=fUGTZXQv28+v-t1mhFyWb9BuxRzCD+N4WTU0=hTqv+xLA@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] perf threads: Move threads to its own files
To: David Laight <David.Laight@aculab.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 1:59=E2=80=AFPM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Ian Rogers
> > Sent: 27 February 2024 07:24
> >
> > On Mon, Feb 26, 2024 at 11:07=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Tue, Feb 13, 2024 at 10:37=E2=80=AFPM Ian Rogers <irogers@google.c=
om> wrote:
> > > >
> > > > Move threads out of machine and move thread_rb_node into the C
> > > > file. This hides the implementation of threads from the rest of the
> > > > code allowing for it to be refactored.
> > > >
> > > > Locking discipline is tightened up in this change.
> > >
> > > Doesn't look like a simple code move.  Can we split the locking
> > > change from the move to make the reviewer's life a bit easier? :)
> >
> > Not sure I follow. Take threads_nr as an example.
> >
> > The old code is in machine.c, so:
> > -static size_t machine__threads_nr(const struct machine *machine)
> > -{
> > -       size_t nr =3D 0;
> > -
> > -       for (int i =3D 0; i < THREADS__TABLE_SIZE; i++)
> > -               nr +=3D machine->threads[i].nr;
> > -
> > -       return nr;
> > -}
> >
> > The new code is in threads.c:
> > +size_t threads__nr(struct threads *threads)
> > +{
> > +       size_t nr =3D 0;
> > +
> > +       for (int i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> > +               struct threads_table_entry *table =3D &threads->table[i=
];
> > +
> > +               down_read(&table->lock);
> > +               nr +=3D table->nr;
> > +               up_read(&table->lock);
> > +       }
> > +       return nr;
> > +}
> >
> > So it is a copy paste from one file to the other. The only difference
> > is that the old code failed to take a lock when reading "nr" so the
> > locking is added. I wanted to make sure all the functions in threads.c
> > were properly correct wrt locking, semaphore creation and destruction,
> > etc.  We could have a broken threads.c and fix it in the next change,
> > but given that's a bug it could make bisection more difficult.
> > Ultimately I thought the locking changes were small enough to not
> > warrant being on their own compared to the advantages of having a sane
> > threads abstraction.
>
> The lock is pretty much entirely pointless.
> All it really does is slow the code down.
> The most you could want is:
>         nr +=3D READ_ONCE(table->nr);
> to avoid any hypothetical data tearing.

Completely agreed, but as this is user space code I'm unclear on
thread sanitizer support for READ_ONCE. The code is also only called
in debug statements. The migration to a hashmap in the later patches
means the complexity of taking the lock is more justified, although
we're using libbpf's hashmap that has a size variable.

Thanks,
Ian

>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)
