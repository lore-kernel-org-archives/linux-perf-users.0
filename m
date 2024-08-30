Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D96D1B5313;
	Fri, 30 Aug 2024 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033902; cv=none; b=e3w+MgU7uD3k6Dv5vqpq7oHUzrQX2tQF/DF5lZ9AKGZ9bqsS9hFuapr2rlbfdehhE5mNKOqLklXHE1oEuChL4kuTWG7yuPu7HdGhzBtlI/aeiTpaYPhu+zVjhW/NSTC0KiODKn3hkLiv9pNNe0txCCqK3t86A24GzTZ9wl5103Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033902; c=relaxed/simple;
	bh=0PHexi5FCDXG5r1ICUuIysKsDC3B3eyH4Ldpm4z7DiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gon1LERlskkChJJdUW0n5jFhsKxBaMor7HxMc8yXsmcUkfPM7oLLVZJk4WtVSgpFRYIGiBkf2sixwNzCe5pt9f3pQPv4fXJqcwsmks984lT2S5yOzxmzyFUKfL/2NPTkWXIl1CSopDH+/XewBppLOOOLSdiIvUENictGN0Q5SeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71431524f33so1559493b3a.1;
        Fri, 30 Aug 2024 09:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725033901; x=1725638701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUpaf8BqvRvM7Np4XiIINOjrDZkTcAXavhuqF36JwdI=;
        b=IIT5H27ZUvMk4PBVJoRarPTt9/l23fb0wq3SNuQKTKpICbnSPnXoe9A1QT/eDsm2xq
         byLAK9yKKE2uO3ayPUqa/KixY1Kb6Z+Wzz16rdGTXPshlujpcMc1AKWEdFCN0upKiSN1
         7wtVJLyoD26lfYVl0B/xrtSI29sSzLRSp4k+kEPPgQp4GFcu5moCcZ0hmT6RUoqOQ1bv
         jIMWeV2xgOMfQkFg4bnc50bR8TKLaTkEC3L2YDsIeDxgvbtm9Kxp7E6VTZU6JEO3b9Bt
         /+9yK1PfOZX6SM5NeGFcFO9zZWotqyXjyF3chQ0eJtxQff1XQ7XeVcZ7MQubB1/iDGz1
         Desw==
X-Forwarded-Encrypted: i=1; AJvYcCUO+lNOCbluykz4l9Lv+hCvQ3/VaVhHrkjGrl2vUBH+t0xx95A9011kIKfqSxMhIEMxdHCnaKA7A9zsKyc=@vger.kernel.org, AJvYcCUgejKlYoOX0jnBrgKNH4JawbpQVPPQFrQMRDqPaQYyUsFmb3t5iF4S18AVHzIxJjooJWX32JQ/UO+5AW+1LuGHWA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Nao5QsfvkK7HXad0ijjMesy0a3Yq+HUUZW3wJE2THovCGCs3
	+GZlssgpiz/v7MfOavaMwCzT8aG3CGIGddo+962Gjq8S6c8axA+fqNpu+KXyNhIea3JKYGtFYn5
	ttCZ5yeQsmq8y3pR7rzVh0uAXBgs=
X-Google-Smtp-Source: AGHT+IFBrIo9zzBAxPH4X8y6loDwLwSYh9hMwKgrQhhfEH6LT8RhylD6QGYpRHDoeLggQp3h7ohucZ35yXb9YnbL68E=
X-Received: by 2002:a17:90a:bc89:b0:2d8:8991:211f with SMTP id
 98e67ed59e1d1-2d889912298mr854196a91.28.1725033900524; Fri, 30 Aug 2024
 09:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829150154.37929-1-irogers@google.com> <20240829150154.37929-6-irogers@google.com>
 <ZtDMf886_1vXWt49@x1> <CAP-5=fURe7yVy6OGWdKn1eSzsdfZPyvvc5fRMPeNAjukaWOe1w@mail.gmail.com>
 <ZtDg2BAI0V5zKpjn@x1> <CAP-5=fXa0r7sD9xbtBVbJQFgnq=3i-cnj6gUX9tze0JyhLhvZw@mail.gmail.com>
 <ZtFNGuwj0WzRQ8fd@google.com> <CAP-5=fUjjOLJ2fUd5gN7SbS0Apgtqft0RCP1HpghFxRt==LOCg@mail.gmail.com>
In-Reply-To: <CAP-5=fUjjOLJ2fUd5gN7SbS0Apgtqft0RCP1HpghFxRt==LOCg@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 30 Aug 2024 09:04:48 -0700
Message-ID: <CAM9d7cg0WpMnRja1z0a+R2BN8TicgB=Y4EDt=95383gFaqQKZA@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] perf header: Allow attributes to be written after data
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nick Terrell <terrelln@fb.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 10:03=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Thu, Aug 29, 2024 at 9:39=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> > Maybe I'm too naive but can we skip header updates on pipe data?  I'm
> > curious if this makes sense..
> >
> > Thanks,
> > Namhyung
> >
> >
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > index a7c859db2e15..b36f84f29295 100644
> > --- a/tools/perf/builtin-inject.c
> > +++ b/tools/perf/builtin-inject.c
> > @@ -2341,6 +2341,9 @@ int cmd_inject(int argc, const char **argv)
> >         if (ret)
> >                 goto out_delete;
> >
> > +       if (data.is_pipe)
> > +               inject.is_pipe =3D true;
> > +
>
> I'm not sure what you are saying. We can't know definitively if the
> input is a pipe style file or pipe until the header is read, which is
> part of session__new and something we pass whether we want to repipe
> the header or not. So we've made a decision or not to repipe but
> opening the header may change the decision that was already made. As
> you say we can opportunistically just copy/repipe the header if we
> know the input and output types match, but:
> 1) generating the header isn't that much work,
> 2) if the header needs to change for extra attributes, such as with
> some of the auxiliary flags, then the repiped header was no good
> anyway.
> Trying to keep header repiping alive for inject, the only use, is
> weird given all the gotchas. I think it is simpler to open, know what
> we're dealing with, then generate the output header accordingly -
> possibly synthesizing events for the attributes in the case of file to
> pipe.

I'm ok with removing repipe in session__new.  What I want is
not to overwrite the file header for a data file containing pipe
header.  In your example, 'perf record -o- > a.data' should have
the pipe header in a.data.  Then b.data from perf inject should
have the pipe header as well, right?  Then we don't need to
worry about the rewrite IIUC.

Thanks,
Namhyung
