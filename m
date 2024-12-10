Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CFD21422F
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Dec 2024 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733862124; cv=none; b=boYR5XwPzEUIj+EER4V604ctcvkGz/LsHea0UKNWl92OgkwW8r1BSvXtWp2R1Ze8RHAERzIMMw5ZoqrgGEjfuPwD/hS7DW/PT7sxgIFu44OX6bzizRXL+Sq2+3SvH2zwp4sUwhVtEzv5z0k0HuO4wdYUmrM9ZyJx7P2j+dFZ4wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733862124; c=relaxed/simple;
	bh=VdZ9tWWMXQdXRmLsSkUQnr1nqd2BXz3EBB0bhDeyBoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G15EcVqiX1UrJ+2PE4apZxigHfgyugy1bDgPsnfcdqmBlE8lH+WOFZgIp0cp8rf9jhkc8DA/qfWrS00AHL3Zpi7OJFfiG4IeVqpAnJC6AQUJJvcWBeWPI2AZgdcu6UA2P0Mnf4VNudaGTYx6LHJp6EglVnsCrQBXAS4HyA7yEM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zwwlmy8c; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zwwlmy8c"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so20785ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Dec 2024 12:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733862122; x=1734466922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvmfWDO1Af0S26U6cj7VCliJRz5OXCapvu0BjHLNBvs=;
        b=Zwwlmy8cHu+t68oq1s5UeE8xUZ2bhgM07sIg1ZM58FG9Ks1NaXtcFz1djbIPbBDKkM
         z07NoRb90E0N4SQCZ0Sb2EBkqEF1AqtA2hayxfFmSs7Ce/KhjyDi/JI60l4w8CJvbgsw
         8xjq1iH9BcdgNu8jhEqVB3ZjnJp8fdl52v+AD+vQdXGsEVQi2b0BIVppAt1+hRWAksAl
         5CF3TLIPneYwBdE/7RZHzNUKpzvsvbfq6sclTpJtzu3chlZmZ33zj+c395TAoTNmZa51
         ahZtJ8o9KKKUHzUBrn0xdNkCi1j0ZaQNGntcwag7K65a0BrFfFrILqNwCJ/W9rEYzLgJ
         QGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733862122; x=1734466922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvmfWDO1Af0S26U6cj7VCliJRz5OXCapvu0BjHLNBvs=;
        b=iQ6YeVcl+9y84gF89YfsbmJ6U/r6HeP5m2nncidy4zvl2lYCNXKZHnEftJcsM6CZuB
         aq/88wTvOZD/TwgLzi4CX4KrCOfpa2l7PpUi3dHOFi4ipZOsOYy626ZV1nNteod8e740
         /qJT3PTXwAxiHTtGVigv+/6faa4/CmIBk43mVhLA9Z6IPClbGZie7Fo73APeyqcLrLWp
         diCwjexcTE/iimDy5XWYBUT3yt/7OcRqHSTUvdPt1KnKDbLtRnAAd/VdK9RxaJF77k07
         lTDWF0prCRINe3P6hfTezotNVxiatbL3fCd8OK9xI8C4zW5t5q/u4FPTpM42SlfmDY+o
         k1nQ==
X-Forwarded-Encrypted: i=1; AJvYcCW35KTQEw9LfQisxNBTl8z0CT2cAlFZNsDgm2Wqs0KkRx9vn48xaBJVaQwKxj/Qd1sjRP6Pm/XwcoMtFYzgP0fN@vger.kernel.org
X-Gm-Message-State: AOJu0YxskCXJAqhyZZR1dyMwOaiSW9h8s2g61kRq9R5TnTzdSFWy36yn
	46a8VPH3EIKv9yiuaV8DwUUoPzIE06XvAe/0MWxxNPKqpBnSka36yi0RCs+48C1bOIlODlLIEr4
	TXt2FQ4PQ8eFFiUZJz0JqHGGqs5angcxDWmV2
X-Gm-Gg: ASbGncv08juK8ECoSH2LAs6OhG3+pdBgBYoHU8jhaIPVQsXF9TgLz4Quj3+M03qffdf
	/Cjcwc+w7QIdA1ubt0C49PNX9eQVxwG0aPWEr
X-Google-Smtp-Source: AGHT+IHLGIQXkLZux6LSbCvDW6FPEK24Ir2c4mFDudpsdRPS9Pn+YMo+EzV5uv05eEfk+eFqJY9OyH/BHVAMKmUT1R4=
X-Received: by 2002:a05:6e02:368e:b0:3a7:aa54:ce07 with SMTP id
 e9e14a558f8ab-3a9f9d277d3mr502585ab.22.1733862121707; Tue, 10 Dec 2024
 12:22:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113165558.628856-1-irogers@google.com> <CAP-5=fWK-eeDEvE4+LeeScbHFecmc5+H8WB_5fepfrJJLZsF0Q@mail.gmail.com>
 <Z1dS6HrfkVS4OeZz@x1> <CAP-5=fUze9j8etq-17L0dWVoYfE-bA+61wrEAXN9vJSCj9dCbw@mail.gmail.com>
 <Z1g-8ggHQ8MoVNhx@x1> <Z1iTtJcMMsuwI0JX@x1> <CAP-5=fXN-KaVnyciw-YBauS=QSWfi36Aan9eGu1xFV57MDcnNA@mail.gmail.com>
 <Z1idV3K4RxLdMhT_@x1> <Z1ieEX22EyS-v36o@x1>
In-Reply-To: <Z1ieEX22EyS-v36o@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 10 Dec 2024 12:21:49 -0800
Message-ID: <CAP-5=fX5U3rWnSd6BhPq31b48tJb62i4kEYJrf+jeMnNZrL2OQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf jevents: Fix build issue in '*/' in event descriptions
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Sandipan Das <sandipan.das@amd.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 12:01=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Dec 10, 2024 at 04:58:19PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Dec 10, 2024 at 11:24:28AM -0800, Ian Rogers wrote:
> > > On Tue, Dec 10, 2024 at 11:17=E2=80=AFAM Arnaldo Carvalho de Melo
> > > > On Tue, Dec 10, 2024 at 10:15:30AM -0300, Arnaldo Carvalho de Melo =
wrote:
> > > > > Probably best to have big patches via perf-tools-next at this poi=
nt in
> > > > > time.
> > > >
> > > > I'm seeing this after applying:
> > > >
> > > > /home/acme/git/perf-tools-next/tools/perf/pmu-events/jevents.py:434=
: SyntaxWarning: invalid escape sequence '\*'
> > > >   return s.replace('*/', '\*\/')
> > >
> > > It likely needs to be:
> > > ```
> > > return s.replace('*/', r'\*\/')
> > > ```
> > > note the r. Could you test for me?
> >
> > Sure.
>
> Yeah, no more warning, thanks, fixed it up.

Thanks for your help!
Ian
