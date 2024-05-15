Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA553032A
	for <linux-perf-users@vger.kernel.org>; Wed, 15 May 2024 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715794759; cv=none; b=iceWeeFihPg2MI1+rXBzn0Rl8XV2idKntnjmEpIFxBQJ7JXAx13+TozbCTMkF+aWokNZOnGzMsqsPfB2bGF0txB/aGlKXNv6M55K8dSne5gaydI2stzBObGDvtyrD5Ul8wL64Fe0cLjtPLjc+OQI7CgrPPOVPGJUEQAqJJtsl4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715794759; c=relaxed/simple;
	bh=p07boBCL2/GwD13qsVqUM9ebWhmEg5Pu7asTAv4Yb+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6bB1VmIUi0iHo+pg0xXwxrOUE+8VEDNEUvA7EbO4WS+nOCMJrJWB9GqrmCdB3jJ4r8B+zgUCtYuRaAIPPynTc/XlrMyAQMAg9qkRagn6Za4Nql3ynQKcBSWMexZub5y5cwgKgR352MPPT8fmsxEz2GxBVRTpPqGwHr/ZzmPj+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k51Yfg4/; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k51Yfg4/"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso35239a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 May 2024 10:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715794756; x=1716399556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKLVYctWbrEOc7GL4VlkuESIidRYpab7R3opOD7N7jE=;
        b=k51Yfg4/pryeJsipNTX80n3kMl3G6mGJe0As1ksB2+7Og4xjuzoDRmqeJjZq9+Gy3D
         a0GfftUY5JxJ9Y9HW4FjMwrO00tBKMAhAuCPmpfRRqksUVk0BmuAWawksfot3v5FEPxI
         t3pW9u0vDb0vHmkSdu26VoxXIYZDQfhXuje+HLKGdiJx5RJK7w6ISY/e1/jzRF5G7R0R
         2kTPBvvVcu2da43rI6rgWj+j3U8bijWDqwqpddaynbyyhijeK+5doDAJhpGVdAqeLcN5
         158/C3zAISZ1nB3wN0SJUzVZCo19a1BfCKxbmcvuWrP4oEk4w7ZFzZueiM2X/S7dGYUa
         TYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715794756; x=1716399556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKLVYctWbrEOc7GL4VlkuESIidRYpab7R3opOD7N7jE=;
        b=e0F/2eRkja2d98cxKDHjz262mKT1YG9qYZmsei0IeoBv3lGialWIEd4SPT5j36K8UM
         qqsk7b9ulUka5rg3ZuD3bzNv/9igSH29Sze3NEjrBHmw2iVeNfMVEa/r6HwDpZ5NtQ6C
         z6OhacNP7Lw5qshmjsizL1JHzRwz+tUBtNV4AXOs5kiBNRaDqH0oh73lNzoQXslMAxpS
         D2n9vs4eJwVhBwXI58hiYMP3ETL42ZJqgXZNf9sSIbK7in7q0OJuZER0ddII8FKsN3Lw
         QdSgWe7b7FU+oFUUhS/LkERVSkO/3dmZjAqDkdydq6x5j4mQwScP0xqAuJPQrDf9HtCs
         RMMw==
X-Forwarded-Encrypted: i=1; AJvYcCW+reOlhVw86tHxv/TaMcAom65LWB5xboUB/wyVJzeNCropdacdrw9GAPe4i6rX/wlpXYOUuiIz4HVJVQYuk/YMy7FjKFAbwmSzng8P+1HXiA==
X-Gm-Message-State: AOJu0YxRv4vAwe9/EfinfL8JSiu6lf00lPCFsoS5vXQihG7mJRo6Ln50
	a06ihNEcs04X0vl6DQ3a0zXaPz9iCp1t4wggFSWfRBIw2+sP/1fxaFZam7gUgScww1LS6TYTeo/
	ElYzGKJB1nncGjXbSvmX5zmhzln03BIqa369MFM+xj+xHoQOe
X-Google-Smtp-Source: AGHT+IGyktch+M6iWO5ulke6CgJpEkTsLZ+6zTMOnCvKIwpZsMqeg1GMJqbTSW9Hzl6ImHPpTMIx03EfjgzCAZqXil4=
X-Received: by 2002:a50:c90b:0:b0:572:a33d:437f with SMTP id
 4fb4d7f45d1cf-5743a0a4739mr813646a12.2.1715794755056; Wed, 15 May 2024
 10:39:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510191423.2297538-1-yabinc@google.com> <20240510191423.2297538-2-yabinc@google.com>
 <20240515085755.GC40213@noisy.programming.kicks-ass.net>
In-Reply-To: <20240515085755.GC40213@noisy.programming.kicks-ass.net>
From: Yabin Cui <yabinc@google.com>
Date: Wed, 15 May 2024 10:39:01 -0700
Message-ID: <CALJ9ZPPyLP3xYtaoJ9+j1o_CMhMCA0tbd2xhh6CbeidDqW0s6Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] perf/core: Save raw sample data conditionally
 based on sample type
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good suggestion! I will send a new version.



On Wed, May 15, 2024 at 1:58=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, May 10, 2024 at 12:14:21PM -0700, Yabin Cui wrote:
>
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index d2a15c0c6f8a..9fc55193ff99 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -1240,12 +1240,16 @@ static inline void perf_sample_save_callchain(s=
truct perf_sample_data *data,
> >  }
> >
> >  static inline void perf_sample_save_raw_data(struct perf_sample_data *=
data,
> > +                                          struct perf_event *event,
> >                                            struct perf_raw_record *raw)
> >  {
> >       struct perf_raw_frag *frag =3D &raw->frag;
> >       u32 sum =3D 0;
> >       int size;
> >
> > +     if (!(event->attr.sample_type & PERF_SAMPLE_RAW))
> > +             return;
> > +
>
> Should we add something like:
>
>         if (WARN_ON_ONCE(data->sample_flags & PERF_SAMPLE_RAW))
>                 return;
>
> ? And I suppose the same for all these other patches.
>
> >       do {
> >               sum +=3D frag->size;
> >               if (perf_raw_frag_last(frag))
>
>
