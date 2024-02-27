Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD66F4F8B1
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Feb 2024 19:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060595; cv=none; b=WwVpBNBsuBU6PIUHvbgCo+fyzQRpRKhDLC5QyEcSwGbNcGe3GUGMveFHy/eMLBq8muXnvKhWRHC3DV1Y17N7rWkQJgdFijoIQGCTreiVFH9wCVXgUpy5RWsTDJwjIkHC0ab2MN7r8khvyvRDSB+9OBN9qPbdWqr32twjUsaHS7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060595; c=relaxed/simple;
	bh=9nLhrXPMhg/lpHUesGNCTSpBc6WvsvSD3/Ew6JjfWno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8VP6zoaSpCX84DwYS1x3vvsZE8NByl+8Mje6GW5bS0RBKTsy4NYkJNNEbV38R3bFYhQD8fZOa6frOT00Ad39mbej+0SKlHUXZAJMqxf/CrLE2PnCJc/N4THKvXHlri4zn44DGgcCrxlO2eDUrKyfTFpbXgnBg8abQf3MwgbTsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CqHlh4sF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CqHlh4sF"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dc744f54d0so21365ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Feb 2024 11:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709060593; x=1709665393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRRnLAvPnPJL+HqV6rL3Yv2zNLZuv51RwIxNYUJXEyo=;
        b=CqHlh4sF4sqxO6/CJ5naVIdHRRM7Q9iZWUmmVPbm43sC4DyVHXP/fNGOfhXHgNxtyS
         +aszEzGjmPMFDTNz1NdCdAkgmeLGyrl0jVblqHwzYyBEmbG8bpcZXEcm7+EhuCynsPrs
         8ttx2SDGnExpjMU2IYCjVzxvjekbhTgRjbeGqziXaLIHZ4eI0AysYFhhtFVBZShEHN2X
         HDhqyecnkH1758H+tlIqwnuIhblJFcn7PQusxTtitjq9KORYOwBjH4XyXOdbpaRZMuT9
         6zyV1aNssyZd8FnAABZYBjzZZ7gSFjn+KExoYPa9F6/Cp7zdY+waLYb6P3Z0EA4vzjKx
         0f1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060593; x=1709665393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRRnLAvPnPJL+HqV6rL3Yv2zNLZuv51RwIxNYUJXEyo=;
        b=vfgg9QHwonsaBla3hIF5liiZZUaHeYgiw43cIP5QhUt1z0WB5cHMWFMzAhBgcwNlvA
         PRYb81YxvuZUFN84MZkfMA/ze0elyzNpbSfdVHp0QZqBPhJUCE1IQx2sYQI5VOHUZOZI
         VpB60yb4PnGu1QmnFO8NgofYKWwjsjVAY4RDc6+rTUnP3HsE8BoIv9m5wIox5m2VLYn8
         IzQDJ0v72cv7qeXzrlzH6j9er+66+GP5XIG0IgptuHT0zz6DuNn9dvY8Cl2uGGWlgDfW
         HR7Srm1g2b7R3DVHkrQC5dFOp+j8uiFYhyhiIofOp3FLyl4ewI+7od0fWQhIlnSLwmhn
         op7A==
X-Forwarded-Encrypted: i=1; AJvYcCXSps0C/KOWClrPXrSe8BUULnNevBbg0ndv7CT0dMaEhyLEKQhNKWj9EkiGTxxHjbWadfUBhKOXQDyT4JiSEBrbdiZ7rZ91ibIPF19DgGSmuQ==
X-Gm-Message-State: AOJu0Yz3PQIYmPxXYqf5/aubEsircpjaDffbXsjwzdFQfjhJOGVXCb2A
	4KboWjkfed5rLLdps9pGDb5ngAgea2ujEK+58un+AeDoLQ8ZtjTS4d8cS2I4JmORKZNheYDHsjk
	WKxx7R69XN/DJPPTKCObz/X/a84vPSPA9FuKl
X-Google-Smtp-Source: AGHT+IEiON4RseddIodoGaU6Nkgdyx9XK12cP+jVYnkT2Xl0+jJS3diTjDQKhKnwCZtjWLmf8ZGXp6rKwXJE33LiWmo=
X-Received: by 2002:a17:902:e1cc:b0:1db:7057:24df with SMTP id
 t12-20020a170902e1cc00b001db705724dfmr323406pla.14.1709060592780; Tue, 27 Feb
 2024 11:03:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-5-irogers@google.com>
 <CAM9d7cjuv2VAVfGM6qQEMYO--WvgPvAvmnF73QrS_PzGzCF32w@mail.gmail.com>
 <CAP-5=fUUSpHUUAc3jvJkPAUuuJAiSAO4mjCxa9qUppnqk76wWg@mail.gmail.com> <CAM9d7chXtmfaC73ykiwn+RqJmy5jZFWFaV_QNs10c_Td+zmLBQ@mail.gmail.com>
In-Reply-To: <CAM9d7chXtmfaC73ykiwn+RqJmy5jZFWFaV_QNs10c_Td+zmLBQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 Feb 2024 11:02:57 -0800
Message-ID: <CAP-5=fVmrrkMdNwYPqYbK_M3AKQMqoXEi4whbzoUeoj-ROxzeA@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] perf threads: Move threads to its own files
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 9:31=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Feb 26, 2024 at 11:24=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
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
> I can see some other differences like machine__findnew_thread()
> which I think is due to the locking change.  Maybe we can fix the
> problem before moving the code and let the code move simple.

I'll see what I can split out in v2. I don't think findnew will change
and the nr change is trivial. In the previous code the lock is taken
before calling __machine__findnew_thread, which doesn't make sense
when we try to abstract inside of threads, where it should
take/release the lock in the threads and not the machine code. Moving
the lock to __machine__findnew_thread doesn't really make sense as the
__ implies the lock is already held.

Thanks,
Ian

> Thanks,
> Namhyung
