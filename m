Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680873B38B0
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 23:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009421; cv=pass; b=AvbVkllKaws9+2OOFHAw4Du4RmrnUpoNeOVhNTk8diczktD84XjrbWuwn1wbsEJfG+I/1tIM/EWX3hLzL6DWOvg7rk78nlVQ+ufyyhutST1VSy2+tHtDpOXGt3QOXcc0eZMfepV7uAG2IknVAEGObXM7+zRQbzDXNajXH/0bHgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009421; c=relaxed/simple;
	bh=d84urZHnX1IMH3c0LEMaaRDUNk3d+u1hYDrxi7qHTag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJkMeTVKi46cA09PP3O1YkDnrfTnDXZIq9qFneQ33E37hSUm8dB7g1C1tCqB4JPjws/uYCJy1aewjhhY8GwMs4zh952wdJxhM66/jvLrk5JabP48acUIKVXRAwo5htMHo864NuuuRSlS9/7OUU9cr4NBJrXM6r6GB9Gut0HCI2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qi/bryGX; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qi/bryGX"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c15a5b265so112241cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 16:30:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787009418; cv=none;
        d=google.com; s=arc-20260327;
        b=XYiaeh76jOT8tUNlDJewTSOLV2jkQUVESVXqz6YR5OX6E8Qxk/kStT3uK3clKVJ38F
         md9D8RJxsnmW8RsBxXeOrJKW8t0QEGvBEMnsndfo6vhKgeOALtG4EC4Ie2DN9p0jqRsa
         UfIiCeWg3JDYb0QddqRcmHtc8WFUVECTXam+xjw4fcK8mp31M7PXR7n+2w2IWhwpiLOM
         UK8j2busXiUE1pTW2kB4KeAhq/MsKL0HAcCUmp7g4zFgHAaqd3gqTR/Jmm9hLNGhWtAO
         +mLHVzqngzlDG4kw8MNq8Nnq4iJuA0ac95jvamSUjxqNC+k+ry7vOFr7SvopbIILCIPv
         et6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dKC5vwgmoJTsdAkuTFLcQw+YitiH1BUv/DgjpZmZNt8=;
        fh=bSN4YJ7oMI31BxCPI0TcPTkv+DhB8vEWuR+XvGGjUGw=;
        b=p1NfVCecPjMMjamQmTaPuc39IVxrA9ndxjp1EMqfojhz+u1EA1OtPBnM7U5aONPgKH
         nGtAQ3coEtgD8ZGNRLkhrBxD2jPz0FDkC7tJ1ofhR6fNjZ8ZZiXwVb7PJMcHEzxR5HxM
         QY6O945pQiiril1KRLfSTKsZmChzD9UaL5gxFSz+ncxMucGNdYUdNxdUE7SNZBRgPZbl
         uvLhSuCMpWj5Idi3bAfgd7XglGUlL96+o2MjdQxuHqZYHIR1jzhpfOulyCvaeUVdhp2V
         vVmeos0DcQz4nl2FQLtqgBTYrjndiSC3jTfnZRD6YcxV6L8w+g7Cgzbeljf1jITTBcUH
         eUuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787009418; x=1787614218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dKC5vwgmoJTsdAkuTFLcQw+YitiH1BUv/DgjpZmZNt8=;
        b=Qi/bryGX+h26LKzHSXnl19ZJI0+jq3JBTNYxOsukogemp0o6ztvJBMNIExGVu/i2Gi
         l4bZsolnfFJKLwtPfoUwE+sa8LXFYiUSek8HKpTwabnCHW9kY2pmBPb8UZoZCcF4cTqo
         Afw5UQOqMMUNabj1nV1G6cq6DRD57CvOWDmgQD0WcvjPIGtQLsEbbMsBudXq4ISCWZg0
         M3PDp6qbroAwWVPMl6y8gi9BByjZu0SX04UehHxcZ5kqCrrZCd9oz2eS7OwV1nsSxQhW
         /4enjNdHhhVe5/p2H3/IttaRxnFI5TUri3/aiiE7DNvYYKVmuJLDxUNQCxmskpA4+qOZ
         L0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787009418; x=1787614218;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dKC5vwgmoJTsdAkuTFLcQw+YitiH1BUv/DgjpZmZNt8=;
        b=MVK9r2J+XWNroKSi6fGpglgVFifLn72OCd9d3YyIxNSpjuXOBMdK3QTXukyxSaeAOh
         QQU2uq0zb6TCWPyurcc1AgmjDKE5SIU8E74uAHA232etKkRdQU1OLZBLSl/VRjk200f+
         XVeVInnAM0KFrWpbc1wP4bZgFraV6aE6gUncOhMgRp8lEvl23FvNH8W/7s3bk1xF6B1v
         pkhlGa4FmyObv4hSvBFWpDjr+w+0mq08X4OCBOtOmfj6X6dQheNWdbH0OIOJxDWtPjL8
         G5Qi7J0vsJacQAK/A5a/doh37mydNOoAR2TACtskEabJTkqxnVk4SZuE0zcpcy/WaQ10
         +HTA==
X-Forwarded-Encrypted: i=1; AHgh+Ro7v1BwJytSixULJLw/7tSNM1ws8uckTy+L8uzo30WTpfTUu0Q5l3WiT2CGBcZ5QugxbbZERZrPR3FA4zgpp0N7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4bBk3a6QE5siFpqkWAOq0ewkpyMsEhfJReulXR/sIg5h7MucS
	Q03f84hy5RDHbyBq6rSn3dJoxkh5IUo4vWjPujj4F+0PADBWOM7EEByKWqMHyorOlmsHAEkQYNw
	Kwq3oKBgNEU6iBm9pLI3Zc3riqUz0oBPze0KyEUH9
X-Gm-Gg: AR+sD13cPJzbzeYazT5PtMXzZk4yAiYQZZP0+c6jhKFJnEn5BviPAJKg0QwWUDv07Mr
	P/MYHljnLpv+aL4rFpsz8MvVy+BYASISWUFIlVRPBH2nd/Db5aGaVFC3EF2PnQ8wKRoN/9GWBgW
	lYznyplEbT99DUundg2HAz1Ki6xlttgcf4gwLPR5TU54rBAzn6TsNFaDTpmynkZ0coF+DDtl1MH
	7gjJAhSNuKBy/39Ot72fgiO8muKKJDvXiYVqBYfAP3UsGZgIeK1YIy1AbdEf/hH6KnAm/m6fJLI
	+SpkgY/Zgv5jxy7W4JhKvKThz8CuX12gyDjqyVgxxBcVFjkPQsHy5W/V93iMaxDJTaIRX8rr5Sk
	=
X-Received: by 2002:a05:622a:2598:b0:51c:ca9:3d17 with SMTP id
 d75a77b69052e-52dc0a72ef1mr7659031cf.12.1787009417513; Mon, 17 Aug 2026
 16:30:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723050409.991665-1-irogers@google.com> <20260817230431.424646-1-irogers@google.com>
 <aoOWh-e5BR2PX27Q@google.com>
In-Reply-To: <aoOWh-e5BR2PX27Q@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 16:30:06 -0700
X-Gm-Features: AcwNN1UbaEe81DwAczlxSjcYH_A1UUcwrK-UFYOu3lFeee_mgDP-aGJkf524pLg
Message-ID: <CAP-5=fVeyG_obbMb8uLRHTv8muFKoBWdVL9p7Bnkc48J3mS=zQ@mail.gmail.com>
Subject: Re: [PATCH v4] perf fdarray: Fix destructor invocation and event
 counting in fdarray__filter
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, abyssmystery@gmail.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 4:17=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Aug 17, 2026 at 04:04:31PM -0700, Ian Rogers wrote:
> > When processing POLLHUP or POLLERR for an event in fdarray__filter, the
> > function invokes its destructor callback. However, the exact behavior
> > around unhandled POLLHUP events on control pipe descriptors caused
> > premature termination due to thread and evlist pollfd index mismatches.
> > This occurred because they were skipped by the early nonfilterable cont=
inue.
>
> Do you have a concrete scenario to check this behavior so that we can
> verify the fix?  It'd be great if we can add a test case.

So the fix is trying to address hangs I see in the TPEBS test. We
should be able to add a C unit test. I can do that while I wrangle
with Sashiko.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Address this by refining the early continue filter to only skip system-=
wide
> > perf events (which are nonfilterable but not non_perf_event). Control
> > descriptors (non_perf_event) now fall through to appropriately have the=
ir
> > fd value unset to -1 on POLLHUP while avoiding their destructors. Final=
ly,
> > maintain the invariant that the active event counter (nr) increments st=
rictly
> > and only for completely filterable events.
> >
> > Fixes: fb4751e79c45 ("perf record: Fix teardown hang on system-wide mul=
ti-threaded sessions")
> > Assisted-by: Gemini:gemini-3.1-pro
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/api/fd/array.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> > index 67b73481df27..3681ad7c6527 100644
> > --- a/tools/lib/api/fd/array.c
> > +++ b/tools/lib/api/fd/array.c
> > @@ -116,14 +116,23 @@ int fdarray__filter(struct fdarray *fda, short re=
vents,
> >               return 0;
> >
> >       for (fd =3D 0; fd < fda->nr; ++fd) {
> > -             if (fda->priv[fd].flags & fdarray_flag__nonfilterable)
> > +             /*
> > +              * System-wide perf events are nonfilterable but not non_=
perf_event.
> > +              * We want to skip them entirely and never process revent=
s on them.
> > +              */
> > +             if ((fda->priv[fd].flags & fdarray_flag__nonfilterable) &=
&
> > +                 !(fda->priv[fd].flags & fdarray_flag__non_perf_event)=
)
> >                       continue;
> >
> >               if (!fda->entries[fd].events)
> >                       continue;
> >
> >               if (fda->entries[fd].revents & revents) {
> > -                     if (entry_destructor)
> > +                     /*
> > +                      * Control descriptors are non_perf_event and don=
't need
> > +                      * their perf-specific destructors triggered.
> > +                      */
> > +                     if (entry_destructor && !(fda->priv[fd].flags & f=
darray_flag__non_perf_event))
> >                               entry_destructor(fda, fd, arg);
> >
> >                       /*
> > @@ -136,7 +145,8 @@ int fdarray__filter(struct fdarray *fda, short reve=
nts,
> >                       continue;
> >               }
> >
> > -             ++nr;
> > +             if (!(fda->priv[fd].flags & fdarray_flag__nonfilterable))
> > +                     ++nr;
> >       }
> >
> >       return nr;
> > --
> > 2.55.0.699.gb54405d56f-goog
> >
