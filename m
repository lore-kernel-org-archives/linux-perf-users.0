Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FCE28F4
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 05:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709269382; cv=none; b=t/xs9J7EsMCii8korB3Js6rYT56/LOsZL8vUCz8Hyo8z2TXpMNhYGKIbopk6ah1ksYIc8ZdOCPa3hezkpb7M6aYUPo8vF7ukF4DBI2DIhXtL7Ha0hiXGPhmxjmtvNDbXgtHjjn9b+GLec3w+MWMjdMFPhjvdXvlDjta5JUQ2OA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709269382; c=relaxed/simple;
	bh=yUvFzWM+HJXyLOAC7y66wSXyf4xTtJ7HUVaTx3YpCFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h62zgL2pZpbfgqimtSE8P8jRkfHo15N6pwT6xCtgyYyWa73Sgoaa+SbBThKO9AuDN1i5QY9xm0poSaLN3C7b1vyX2XkRZzQpTYSds17WCMG4huJ6wv0w9xfb8NIcyU019QBdjv9MQcdUN5xrc1t/1/9DvnqhGEDNeypUydyErEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jvJqmOA+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jvJqmOA+"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc9f4d1106so102845ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 21:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709269380; x=1709874180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJCI+26zIfGoqoxPqGF/3KXwVzFCjuGI+FsZrZUdpyE=;
        b=jvJqmOA+NjvShZqj4OFXPcoaR4NljMuAzZRJI4qU1skcDbPuJasJEM6dNfUb5qVFu5
         kBGkiFEGgN2DW3Odc9EkoQ5VzhWnWRLZZ8BatjqzBFA7kSnf2VN8SzJ7PJTvn7hbZDuI
         pnXBDTVUH0Tvh4CaY0LlfMPJwasvLl0O9fk1LTxgfXNBm2wguZwx0I1O8NtERe90Blk+
         v7Lc+8yx0I2zP/hBEEpsORkHVdEVMRO2/LGmtb0JlorgZlpD8gQf/omxDSszEM5Q918k
         nwFUrCOMdRKoNeXSu2Y0hm+PCVCuQMFsb+uG3LWWtx8rgXUFQvDOgvCjR98CrfRBjbx/
         O+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709269380; x=1709874180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJCI+26zIfGoqoxPqGF/3KXwVzFCjuGI+FsZrZUdpyE=;
        b=NCa2Qpd8ttGJyfMlL2AJfq78mhWdEDm1VYryWURj1wej0O4U9WM2DB6G2KYDUo7a8d
         qrS+RRSN2XSPXQWhBz4h1tlkSKjMYZ1jRY/IjKfiwkj5n3yOs/XoVRA/dKTkzW7rbu6v
         apjs3u37GxnY5L7uvGoBVRCv3Hf9127sJfVuz+SSifuZ74uuISb+gr+3o4beJwm/QTWv
         RK0vxMVy9F8JlnnjNtZfRmA6XKVtc84cNJc7+tWME7LAKW9ari7eG+DPOb8wmSjCxLnP
         sIs1gz0yawfsyRF9udaCkj89trNcx70S1JwJPdtlz1P6lEWvgvm3l/Dw6rqIG+V6eAk9
         u81Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnVq6COgT42jZbTgpAf2JJfTtYhHjTVQyBSPv4xgFSNqHHXqCsIZjPASTxGWfo3YDHEZ5NCDOH3+NsqZ2q0XK8u2coQtv9zzm/x3UihjJgTw==
X-Gm-Message-State: AOJu0YzjupgpE/nOeB7KL7p5ps/DyTx5PXmtgwOMw6YoXS2oW+hItbYZ
	8F/mdLp+evtK1Q7kzWrQ8/kjLLs53Pf22211zXCbHU4mJrlP0HZM3soYdJ5epU9UgfwGKvBi3IC
	sciQUTfvyyF+6oNopWJK0Y9WEsaYhjvQ+VYWf
X-Google-Smtp-Source: AGHT+IGFzadOowQIy/Sa/Ec/9HPST0VW1lGI8Jdl7GpPOSJ1uOTsiucmWmZG0Hnnb7JHLQowSSUfftsvaCzY+Bw+fQc=
X-Received: by 2002:a17:902:ced0:b0:1dc:c779:5537 with SMTP id
 d16-20020a170902ced000b001dcc7795537mr122788plg.4.1709269380271; Thu, 29 Feb
 2024 21:03:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229063253.561838-1-irogers@google.com> <20240229063253.561838-5-irogers@google.com>
 <CAM9d7cj9CgxmvSMLvDa=RM8zPRJpRbKqMkU7_B68HwEX7qo=hg@mail.gmail.com>
In-Reply-To: <CAM9d7cj9CgxmvSMLvDa=RM8zPRJpRbKqMkU7_B68HwEX7qo=hg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 Feb 2024 21:02:45 -0800
Message-ID: <CAP-5=fWpnrLAo3yB6SAxDHjzWNMYcAPdq0RHgs_C11Y5dY6ZeQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] perf machine: Move machine's threads into its own abstraction
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 5:36=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Feb 28, 2024 at 10:33=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Move thread_rb_node into the machine.c file. This hides the
> > implementation of threads from the rest of the code allowing for it to
> > be refactored.
> >
> > Locking discipline is tightened up in this change. As the lock is now
> > encapsulated in threads, the findnew function requires holding it (as
> > it already did in machine). Rather than do conditionals with locks
> > based on whether the thread should be created (which could potentially
> > be error prone with a read lock match with a write unlock), have a
> > separate threads__find that won't create the thread and only holds the
> > read lock. This effectively duplicates the findnew logic, with the
> > existing findnew logic only operating under a write lock assuming
> > creation is necessary as a previous find failed. The creation may
> > still fail with the write lock due to another thread. The duplication
> > is removed in a later next patch that delegates the implementation to
> > hashtable.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Thanks for doing this!  A nit below..
>
> > ---
> [SNIP]
> > @@ -3228,27 +3258,31 @@ int thread__resolve_callchain(struct thread *th=
read,
> >         return ret;
> >  }
> >
> > -int machine__for_each_thread(struct machine *machine,
> > -                            int (*fn)(struct thread *thread, void *p),
> > -                            void *priv)
> > +int threads__for_each_thread(struct threads *threads,
> > +                            int (*fn)(struct thread *thread, void *dat=
a),
> > +                            void *data)
> >  {
> > -       struct threads *threads;
> > -       struct rb_node *nd;
> > -       int rc =3D 0;
> > -       int i;
> > +       for (int i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> > +               struct threads_table_entry *table =3D &threads->table[i=
];
> > +               struct rb_node *nd;
> >
> > -       for (i =3D 0; i < THREADS__TABLE_SIZE; i++) {
> > -               threads =3D &machine->threads[i];
> > -               for (nd =3D rb_first_cached(&threads->entries); nd;
> > -                    nd =3D rb_next(nd)) {
> > +               for (nd =3D rb_first_cached(&table->entries); nd; nd =
=3D rb_next(nd)) {
> >                         struct thread_rb_node *trb =3D rb_entry(nd, str=
uct thread_rb_node, rb_node);
> > +                       int rc =3D fn(trb->thread, data);
> >
> > -                       rc =3D fn(trb->thread, priv);
> >                         if (rc !=3D 0)
> >                                 return rc;
> >                 }
> >         }
> > -       return rc;
> > +       return 0;
>
> Don't we need locking in this function?

I thought there was a deadlock, but I was either mistaken or now it is
resolved. I'll add in the read lock as you say.

Thanks,
Ian


> Thanks,
> Namhyung
>
>
> > +
> > +}
> > +
> > +int machine__for_each_thread(struct machine *machine,
> > +                            int (*fn)(struct thread *thread, void *p),
> > +                            void *priv)
> > +{
> > +       return threads__for_each_thread(&machine->threads, fn, priv);
> >  }
> >
