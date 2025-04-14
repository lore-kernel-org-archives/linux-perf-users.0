Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BF4292916
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652549; cv=none; b=s4xvXorOGEsQyLyT6KLz/tiF6z404Mm1kZnfZbKnjjQY9/wbhZCO8h4rN/MVJTIK0AUeRaFR9Fr6JuCQRR/PDqiiFJskZAnG3LvuSmImJduYb13lDUmXBnvMjWUNGSnyOFC3TrQAtS+u34qcPgcl8rlV2ljtJtR3NHK7jvHItfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652549; c=relaxed/simple;
	bh=r/oZLu7g97RF6TF9183rjWt7sdJ2elJ9pfcYGZQAci8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5tB/rJ+chorez/+XOjOJYSpNQosqo2+poY+ayjiVmB9o+4ax7lPizyACY6yhhmVArtiS9GMSIK0pSwpauHK+JM+mO5HeJXLLbku3hrk98IBAOfzTobhpvwptWCy+tOgCOYivd0K66y0N63SDthzecrBEPQa6ZxevhJBacs9QB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BiSHoYa3; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BiSHoYa3"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaecf50578eso840021466b.2
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 10:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744652546; x=1745257346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6dXpssTyEnXZw8Werw0Cfea5OuCpmeGi7WA4m5w0Kg=;
        b=BiSHoYa3fgJSiqVoP3e0H+/FxsvaWZzno78abprQ7Dm0KE5tnvU1RN5Bv7EOMusnhZ
         qlqJfPG8iitoFObxWWFMGys/INnO8lfSbVdTu3vxGXVO/BBbq7rwhxkeItMJ+RWTfo7X
         ukGtkO898mKlTACCgY9X6Y0S7E2Z779/KSbzt5EeTW7bDaGADKo5qOAiXZumrWLIOkYj
         UJgc2LKySaUQwezESr2fSxwXDUX73RBR4ZKBNvG4CkUNn1m1Y+UKOUfia3etcJGPHQ7v
         JDm8wE60JaNl3Agqp0oWBH1uSM2WuExpguzaSeN8QXCRBOTb2uGSPTh8OYOucw8HXbwj
         KN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744652546; x=1745257346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6dXpssTyEnXZw8Werw0Cfea5OuCpmeGi7WA4m5w0Kg=;
        b=iqAuDt5CymmbDb+05HhZqZS9RbiAa7lvNhfwkav6EK27t/jtWsRcvibJYghhWkMKXV
         XryOaVJwvnKfFd3ay1ANoxm4QUbaiMAj718K9lFysyep/Cokr1dk/ikQV6nscVzdbOJh
         s1ORdaXfqZWY22TriMvRKDcoLkMebS7FUmCBcsW8h+iC2Z7uBUjRvH4DjYFJ3/2ql6Bw
         zTYgpO/1B70U8Ijxi6YZspGnCKVzftEgkcmlmcMSeVQPBvD4dgadWi08FDUKeohNKxcq
         6KUWQiRrOBNQCOnsk8Quk2Pqc0XlsdxdM2omBNAQMnCa/UJQxRCYFwnOWXLTS2tPLtK2
         vGEg==
X-Forwarded-Encrypted: i=1; AJvYcCVhURL5lzAP+gAFUcFd39zOgvjSNuNzyRBUTXzsDIjy5w68UWbB7UTKvGyxbdo4JU/t+tssVx7MkjL+zdLhb0xG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5S9EF1eKExyjF2/TKFJedFTQ4f5ApaTOw/83Fs+/2orXWsOsk
	MpczHSPAes+aZLA26pjB+r7XtsxJx3njfrTf3YEgN5XXlbtxwgEeoKR2zacd/l+gFfKzA0G/d/4
	lbCIJ37yXASDOV5hnriK9ZvL+pCZUtR1o+V0x
X-Gm-Gg: ASbGnctZg/pU2sj/3GgpcxjnBiSSIRF1ftep5qtnnzbQDrUcl7aCNeEmpRT+cOn2Adw
	kOfZY2p+JHQ5g9hxPinFju6vb+R4HxNhm1a9sfBTkgr6D2i/vXyYcon5upxEO0Jem95DmrPflaI
	uOsFBhvJqbE4Hzaske5JPjXcKnTL8r/hE/IsLxIR/3HveaRdW4
X-Google-Smtp-Source: AGHT+IF0lVacdLNmQXyNIUxEHd+nTqR58C8tfUD29Jy3htQ250p/42LkgbUJpDeJ9P4uGPCW5RLhDiIuWo8Z2TF5ZBs=
X-Received: by 2002:a17:907:7f23:b0:ac8:14ad:f3cf with SMTP id
 a640c23a62f3a-acad349c379mr1122853466b.23.1744652545646; Mon, 14 Apr 2025
 10:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411174547.2208959-1-ctshao@google.com> <Z_mAxgbgVBqHDRfD@z2>
In-Reply-To: <Z_mAxgbgVBqHDRfD@z2>
From: Chun-Tse Shao <ctshao@google.com>
Date: Mon, 14 Apr 2025 10:42:14 -0700
X-Gm-Features: ATxdqUGmO6XE11TB5jTq_YVjbnQWRZYMA-7dZ_XSG_Wlq2Fx3_o8Rp8eMDvgThU
Message-ID: <CAJpZYjXduAo1vHzfGzCXk+ZuGwo+Sy5CpZ-cohrooz9k0qwM4w@mail.gmail.com>
Subject: Re: [PATCH v3] perf report: Skip unsupported new event types
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, peterz@infradead.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, dvyukov@google.com, ben.gainey@arm.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for my oversight, just sent out v4.

Thanks,
CT

On Fri, Apr 11, 2025 at 1:51=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Apr 11, 2025 at 10:45:21AM -0700, Chun-Tse Shao wrote:
> > `perf report` currently halts with an error when encountering
> > unsupported new event types (`event.type >=3D PERF_RECORD_HEADER_MAX`).
> > This patch modifies the behavior to skip these samples and continue
> > processing the remaining events. Additionally, stops reporting if the
> > new event size is not 8-byte aligned.
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/session.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index 60fb9997ea0d..f55b2ac4e103 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -1639,8 +1639,17 @@ static s64 perf_session__process_event(struct pe=
rf_session *session,
> >       if (session->header.needs_swap)
> >               event_swap(event, evlist__sample_id_all(evlist));
> >
> > -     if (event->header.type >=3D PERF_RECORD_HEADER_MAX)
> > -             return -EINVAL;
> > +     if (event->header.type >=3D PERF_RECORD_HEADER_MAX) {
> > +             /* perf should not support unaligned event, stop here. */
> > +             if (event->header.size % sizeof(u64))
> > +                     return -EINVAL;
> > +
> > +             /* This perf is outdated and does not support the latest =
event type. */
> > +             ui__warning("Unsupported type %u, please considering upda=
te perf.\n",
> > +                         event->header.type);
> > +             /* Skip unsupported/unaligned event by returning its size=
. */
>
> This comment also needs update.  Other than that looks good to me.
>
> Thanks,
> Namhyung
>
> > +             return event->header.size;
> > +     }
> >
> >       events_stats__inc(&evlist->stats, event->header.type);
> >
> > --
> > 2.49.0.604.gff1f9ca942-goog
> >
