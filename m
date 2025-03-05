Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4F71DC198
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Mar 2025 06:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741156667; cv=none; b=kuJGY3+y96FR7Xg9ts8VrjcvBDDsbzfb1i2pCpbLZPX0tuGNR5GFQiSK4cy0SIyR/0h68MfFINgAKRDfY30U52JoamooMkoUoKYyU6V2dmLT+RcBERN4kjadscHhOXJC6XdLvPko+7YXGYNAqMMn6qeCOOnmwXwMBqrduM5N6bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741156667; c=relaxed/simple;
	bh=I+as+82YFlj5Cj2RDoEcOCu9kFoTHZ116GHE6RNe8QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpiLHx/SjUXFIj5fDmVNT18eq4TL89OPOy2InELeLa71kqrcD0a/Sk/e7gOZiSGQ5Qu/mmbfsppY78pqQghDmTqFHLYYJT24b8bHiHavARAKOZWLvmO8QR1M2P1NyY1dyzlUBaMQ7s1ttNVwptx/Xr8Zk7FxNsMy5JqWG3bgGaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dr4bn1M5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dr4bn1M5"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223722270b7so67625ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Mar 2025 22:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741156665; x=1741761465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi9xEZ7fcr5FmKQxbsnALzy8aDvLohO12d1QPXeIk0o=;
        b=dr4bn1M5G8kFKVMlFcJydCBsD3ZHgP3BVa1gepShYlluSBxzxHVLJhbxNH9hhPROAv
         dK+FZV5JNvIbV1gU+DKpYaKMJyEqLy4IS1c7WSORZFHsryQtpaxPAaLe255gFu43i61r
         QEAZXbY5rLnN+GSuqQgEr/SQce/pUM990lvCf9PDeBGj7b4UBehXG3Ta72GxUy+zHDMd
         jJNTyalMW8KGLQ1OjQSP451MkRTKbss4mYB0CHNLmnykiiOKZ7+p+U94XArN4Io2zNqs
         y1ADn5l91xq+/0Dwbsg8ucU6a1PoBWtqnM/ROG4ZgA6L7F0gy34P+8h9GMX/JhZNm/Ug
         JScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741156665; x=1741761465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fi9xEZ7fcr5FmKQxbsnALzy8aDvLohO12d1QPXeIk0o=;
        b=OLWofKFfK7WFeGEeVGB6mtUo23qyYjoS9tlLgEPPfQRJVyOiQK+42M7MbPItsm8/P0
         7QTUftVcstbzX1n/YIaO2/kTzKFVoRswzXPwhASEnfjxHWfZL8JXnjsbQ6dYvhX3B5mH
         r/vG5wiM1yOwx1rhze7GF+S9nXeihdXWLSeRR3P6iK1i0OQhwDgb7merac/r59K+2QDD
         RU9hTUbK1Z+t0vU759mryrPyJ7wBvcTXJA7MTZtz/VAQL7PUMFlardj4PBpkjNPvR3y9
         K98tJGWDz+3N4RSF3iOq4s+YbHXZToYv97PGa0Kgh9Q2fkCigwJ9XwBY7oJINzOr2yYn
         cB3w==
X-Forwarded-Encrypted: i=1; AJvYcCW+Psrkv7HktAqWPhsEaQYrtMvj+xsqD9FlCbSKAvfPBt5j/zhVdDpCypuycsTuRv/ZPd0Lyq4K8lbdbTk8IT2A@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlnqqm7hDvtpE6no02DK7TdYvdZ1E/0LU97b/xwI6Hb7o9tjrL
	yEvFpJ3kyZvePP5m67Z8I3/SyxhPsUD5BPlWAFsumQzkkuAgx9/S0rlLFIMVXE9DuwBKJzK2fFj
	+VuUOMCYWwk9uDshUADIr+SZ5MiFs4YsCvAzr
X-Gm-Gg: ASbGnctxBYFtWBf96UXbE6/X8JYhhzlvw2ZjcgwQEUPHxkodbeCXKEhK3unUKSwwO05
	sqEDQ1+Y6hOsiCz17iqst+gEdU017EfvFWnEGZZUtQPGvEiIHlJ/8rjfpn4pXEKeR2WrgEY9dnD
	i87JoSGyFMwdm/sH5Qd5VD957wU7s=
X-Google-Smtp-Source: AGHT+IGv0rGuZR2kqmbCENwI0HOXsJm6Glwl1C7kChv6KWGtNwAkSPqlGgaqP1jr9iy4NmEqZ9UTNgpLQ9Imjd+bVSs=
X-Received: by 2002:a17:902:d4c4:b0:21d:dca4:21ac with SMTP id
 d9443c01a7336-223f267fa45mr1839545ad.6.1741156664692; Tue, 04 Mar 2025
 22:37:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224083306.71813-1-dapeng1.mi@linux.intel.com> <12110f8591ad185e32746b7f8073afda6e99c337.camel@intel.com>
In-Reply-To: <12110f8591ad185e32746b7f8073afda6e99c337.camel@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Mar 2025 22:37:33 -0800
X-Gm-Features: AQ5f1Jp6dNqq7bT5_SsmN-t8AWQ1NGJNaB24czM_VqinBBcVP07Kme0rsBvdnkU
Message-ID: <CAP-5=fUyVYBfrDQ9BfiW-JhWgMQ39cNOM4wjWcE5HhqSigEE-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf x86/topdown: Fix topdown leader sampling test
 error on hybrid
To: "Falcon, Thomas" <thomas.falcon@intel.com>
Cc: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org" <acme@kernel.org>, 
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, "namhyung@kernel.org" <namhyung@kernel.org>, 
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "Mi, Dapeng1" <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 8:49=E2=80=AFAM Falcon, Thomas <thomas.falcon@intel.=
com> wrote:
>
> On Mon, 2025-02-24 at 08:33 +0000, Dapeng Mi wrote:
> > When running topdown leader smapling test on Intel hybrid platforms,
> > such as LNL/ARL, we see the below error.
> >
> > Topdown leader sampling test
> > Topdown leader sampling [Failed topdown events not reordered
> > correctly]
> >
> > It indciates the below command fails.
> >
> > perf record -o "${perfdata}" -e "{instructions,slots,topdown-
> > retiring}:S" true
> >
> > The root cause is that perf tool creats a perf event for each PMU
> > type
> > if it can create.
> >
> > As for this command, there would be 5 perf events created,
> > cpu_atom/instructions/,cpu_atom/topdown_retiring/,
> > cpu_core/slots/,cpu_core/instructions/,cpu_core/topdown-retiring/
> >
> > For these 5 events, the 2 cpu_atom events are in a group and the
> > other 3
> > cpu_core events are in another group.
> >
> > When arch_topdown_sample_read() traverses all these 5 events, events
> > cpu_atom/instructions/ and cpu_core/slots/ don't have a same group
> > leade, and then return false directly and lead to cpu_core/slots/
> > event
> > is used to sample and this is not allowed by PMU driver.
> >
> > It's a overkill to return false directly if "evsel->core.leader !=3D
> >  leader->core.leader" since there could be multiple groups in the
> > event
> > list.
> >
> > Just "continue" instead of "return false" to fix this issue.
> >
> > Fixes: 1e53e9d1787b ("perf x86/topdown: Correct leader selection with
> > sample_read enabled")
> > Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> Tested-by: Thomas Falcon <thomas.falcon@intel.com>

On an Alderlake:
Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > ---
> >  tools/perf/arch/x86/util/topdown.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/arch/x86/util/topdown.c
> > b/tools/perf/arch/x86/util/topdown.c
> > index f63747d0abdf..d1c654839049 100644
> > --- a/tools/perf/arch/x86/util/topdown.c
> > +++ b/tools/perf/arch/x86/util/topdown.c
> > @@ -81,7 +81,7 @@ bool arch_topdown_sample_read(struct evsel *leader)
> >        */
> >       evlist__for_each_entry(leader->evlist, evsel) {
> >               if (evsel->core.leader !=3D leader->core.leader)
> > -                     return false;
> > +                     continue;
> >               if (evsel !=3D leader &&
> > arch_is_topdown_metrics(evsel))
> >                       return true;
> >       }
> >
> > base-commit: 4bac7fb5862740087825eda3ed6168e91da8b7e6
>
