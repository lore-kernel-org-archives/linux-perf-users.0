Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA512E403;
	Thu, 27 Feb 2025 06:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740636229; cv=none; b=Y9MppbeSS2D2OF5gSEvVFuHoxWHkkNz690EeJmHQumBZGU5XDrZWRVD1usanxbj2enpYfVZYC2Jw+H9j3qETA2/xsXvU2fyk5YcfJNDkfXEC9tYCPHpjdVxPvtVRzZwkk3f609S8VRPkqw0U6OgExjHIkhqN6yxk5NaPWnoMxHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740636229; c=relaxed/simple;
	bh=id8Qg4h5TPS0BUzKQKO0wT6fCrQR34/3Z/Bv0E4J2yU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlEe/maFQt0UomvK4IREOawk1XW821iKRDqfC72m9LNCpwwfS/jhZ8YACaytDQwH9p3C8D3OiPjP+eaxcFnwitLAOWOd4NcyzZDKhkCvb7ZXO01NOX2eZCrMBb0W8r1kcdjYhACJqT9SnpxonVzb9+rIp7OQbbuMZNwdPRxwJVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWLR/RtY; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWLR/RtY"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6f7031ea11cso5752757b3.2;
        Wed, 26 Feb 2025 22:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740636227; x=1741241027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdOFGgb65k0Cn9Nz8/cPncizPnzFIKvzyuAPw/gRjP4=;
        b=MWLR/RtY2TWFVqsK0b2ge9qpf8IBHNcQ/RXVj69UAamHgGkURYV7vohHmjvzw2fMXO
         k+QcY18gbivX0QUwntJEJ4W/VkW2S6krCVf5BuQL1jAZ6BBBLwqHmOhCBSexH4OX4Ydy
         EoYE0S5kxNCGkaoxTbLS4eyxd9zxpsMwllZk5IKiUhJTxLHmKYfqClFDwvsNOae7md3O
         msH1X1F2WrlYYjPq4Mla6VP/7A+TVKU5Oi9NQxT7J90QejK2rdmyPtPBvf1q0TtMVmWT
         LBTa4y/ByuEUN00qFpj0UX5gpHwZkP98pjkMcROG8O37OYPpO1S1WjgZw52i09++T3nt
         8KtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740636227; x=1741241027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdOFGgb65k0Cn9Nz8/cPncizPnzFIKvzyuAPw/gRjP4=;
        b=kYhz78tzf+IurBLGwS0/S0D9ZcwFijPaDRGxP6FsTv8dNPSdtjS53SUoPpTaAa4w1f
         QJ7wANGHtBZfUqxZqeIqR1GD20oWhEMK7R5tEm5P3xzgixZD0h1yklwzi+HYpSYeOyDp
         8otm/8pK/4E0Cx/WL6uC15qEEpM1OyiDTX0AJHYtTAZWZS6ZLtaTshMVJCGukJ7hK5dm
         YIrfkRMWv80J90hv/5Po/u95o6Qb9ef41jkF791I7hi97Dy7h31mD/Wv0lhdE024zQGk
         vy5paNyeLEZFdPXKWDgY0nzRzJFXScTUKUOOSxQjFutWxKaOXZY7R54IQNJM8zoDxpIZ
         FXDA==
X-Forwarded-Encrypted: i=1; AJvYcCWlYsgV18udL77CjWIrJCf/QIixn2WjeHWm5etlRq/U+DSgJT4d+LEwkgJd727VL0Vz702b3tYIzjiiQGo=@vger.kernel.org, AJvYcCWnEPXvbavwPSQGNng3LncgV47ASBoXn7E6B50xYl/BiyZH6mBh/ZOmEZ/U0d043BnT6RI4m+xRM5n3eOBQE9PKwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWhKFQVS6E5JLjQ2O+eQFM9gd4jd+YTRSspn3Om/8Re0qW5Vws
	JuMDX0YtyOqNjWsd1pvwTdyzALqhHC4iGi/EiRIaISC54fi/LKddwPVpUgb0Ib8GI7g+Gjicq5W
	3Vksu1327EucNG4fVivlw2fP8qQc=
X-Gm-Gg: ASbGncvbXxOaMXiqBCTq27oEh0Zq6J0YXp0KUM3C8FcuIlC9DRMpMhPQDb0ZDmRjzMZ
	OO8tyOD14Y1QIXjnJEVWiGbM7FGH/x3TGLF9QWw+hOJ/9PVZ5Uiu6JgUPwUp2JFx8RnRVWKMa5/
	xkCd7oEg==
X-Google-Smtp-Source: AGHT+IEL++qAZVyzQTn3ojQynvJrhqG0fQwgG7E/+e2foO96+UUWr560txlmn5uxcQbG4RpwgMUNs+QZpy3Bo6DAjn4=
X-Received: by 2002:a05:690c:690b:b0:6fb:a467:bff4 with SMTP id
 00721157ae682-6fd220852f7mr71661227b3.24.1740636227042; Wed, 26 Feb 2025
 22:03:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109075108.7651-1-irogers@google.com> <20250109075108.7651-2-irogers@google.com>
 <CAH0uvohxfk0wYv8NB5i7dZJ2+0PX22iqVAJqWLGqKykrqC-RgQ@mail.gmail.com> <CAP-5=fW_j_jisBsMw8AU0t3NgQdfE-ZBgqHN5y4ezA+bvRWW2g@mail.gmail.com>
In-Reply-To: <CAP-5=fW_j_jisBsMw8AU0t3NgQdfE-ZBgqHN5y4ezA+bvRWW2g@mail.gmail.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 26 Feb 2025 22:03:34 -0800
X-Gm-Features: AQ5f1JrjW713G-ilRFqcL6ISJ_ZFKLSu0dKZM33DAXk2Psjh1hw4kB__o9L3hrM
Message-ID: <CAH0uvojRo0YV+OGwzDHCh6+p5zaLBPKP6aQLjcexEfTmiBqKmA@mail.gmail.com>
Subject: Re: [PATCH v1 01/11] perf debug: Avoid stack overflow in recursive
 error message
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Feb 26, 2025 at 9:45=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Feb 26, 2025 at 9:40=E2=80=AFPM Howard Chu <howardchu95@gmail.com=
> wrote:
> >
> > Hi Ian,
> >
> > On Wed, Jan 8, 2025 at 11:51=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > In debug_file, pr_warning_once is called on error. As that function
> > > calls debug_file the function will yield a stack overflow. Switch the
> > > location of the call so the recursion is avoided.
> >
> > May I ask how it created the recursion? Too ignorant to understand sorr=
y...
>
> If _debug_file is NULL then debug_file calls pr_warning_once which
> calls debug_file which calls pr_warning_once again, etc ... :-)

Got it,

pr_warning()
  eprintf()
    veprintf()
      debug_file()

ack.

Thanks,
Howard
>
> Thanks,
> Ian
>
> > Thanks,
> > Howard
