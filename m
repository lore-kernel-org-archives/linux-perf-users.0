Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E034923C9;
	Thu, 27 Feb 2025 05:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635188; cv=none; b=UQE7Mr/7RcyRE7ptRg06Dv3MJxdaLSk436qeWEj5kq35bZtyk5IFnyq3BT1c569XVz5aVLqbiZui/vC1l+NzT/gyweJp34Jx/TisSqjfIJEv3uJLUNWTKtTTDgzRRx2S9qaNDKtIOADU6PxUBASvCSvHvXmNdL7xdkwUYHfRIWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635188; c=relaxed/simple;
	bh=eYJwDtZADtElVi9D4MbUQ4sDdr8vV4wstXBdam4cgMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6m5EJiHdgVuTdNerzGo8OPnuu8vOyYFmIuyKT+EUJSENYWinScr2ago4mApTQQLdwUwCIJYc3twzowLQhaNpKuY9IcijgDlOw2M8Ooz+xDgXU9v5ozI8T/9h7e7xhD+rp6iLD2sbfk8pjkHqCM5CDZZqaVK4t1V1jcy8htKY0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGVF9yEO; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGVF9yEO"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6f77b9e0a34so4380887b3.2;
        Wed, 26 Feb 2025 21:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740635186; x=1741239986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LI04exR2yDAWb4WrSgtjk6OP2Gj9wO+tiWBJo3HZHvg=;
        b=fGVF9yEOz3oG/sTrp92YsTr0f3hjmeNedwixg7NrxRaBXI7AOiVU3gXCzSjaVVZlfa
         8QW5sokkDMEfLaMDswfusGfxBsFi7hglMu/1xgw3n5PAQl0/ZlvuBMyOw6MN3jW/HVA5
         RjTcrSnntZc6WJT4+hSp+GUT+5itCTXMkJcQQZ1im4WLDHvpHuXDuqj0ajgJWbQtm3ew
         uXd/4MNpyfi40rAw6OINtq3ITCQonKnDJTBEnfj55xrXhxscAG4GmV+c48f22OXbQ037
         4Ja3aoXR8w0glvdAXzy/3bASwiRvyJo99fgPGJPxW5fIS0MV5wYn6R5po2Q/pXBhvWvK
         Ux3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740635186; x=1741239986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LI04exR2yDAWb4WrSgtjk6OP2Gj9wO+tiWBJo3HZHvg=;
        b=f2N/vmRzXF2VO1HX0SNX3372p1xjqbinXHU8uV7ZWr5Pqk7cA8Rt2AincFBOQcShNc
         qY3771IUSuSQ0ZLo0cuVjDks4tPHQPaEB0dPejZaRjaOrRt0KFNOSxOsb/4D/EUdGs8N
         w7Lc/WFgXqECQagVnB78NNn/pPf5ALqhOwXltQKhea4AMJ9x2dFHK/SrZGBf+qFJUQci
         Mhd293S4wfMZasPj79dn1fOSjFmdevS7aBTTX79KYpefkBaPbuZnK20RRZicUDR8VKSt
         OB9i1ez6QdXPo4z/ZjTVIwKYJZV7TU3JjfyzOhPOzQgB6yzQ22Wo8uT93EYSCDqspbp1
         bArQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJiXohMCgUdrn+cEV1Ky+F/kZ0bFUTgfMbHk/wSY5lDYQuwRvTKuMSLTS1boyuX1BQtCHm4QrA+BtAlqjZ2+e+Uw==@vger.kernel.org, AJvYcCUN4vsjBIDoiQPZ+iVaiC5O8qCxM0c2CHgr55islakOLrZcQ7D3utd82vBkFeOLFsCj6csVctFnujM/2zU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqPL7YJuO3T87479kW7aAYPuhqcUKTRoWrnpigyPaiGkArswev
	gyOuLopOl3DLAmXjtTv5Amr8CBY6rNYKpXVjvCB+1vEosANvwlJKORyNAul8HvyCefcmJJjH6uJ
	kAywKH2uULVAaocLkoSErWnTe6uQ=
X-Gm-Gg: ASbGncs8a5ugeViLellRK0PgJ/tNEDbeW6+wa/8xu2oW7r1HrPRihoqvojAZG/Mf3d6
	gVlE8DANEQXRcuoan32MZ74pfcJ4B70oTAv2ExLhyh4k5KFT+vHolAYiBpmZoPjJXS2rx8HH6OW
	0EgpctAQ==
X-Google-Smtp-Source: AGHT+IHUeNu0/+cIrjaweXhSO2pZYGHo0g4t+54vjdcP+SKlzLHK/AIt8c12/IX31eKN+uFKlgzLGAj8CkHuJGYJXgQ=
X-Received: by 2002:a05:690c:3387:b0:6f9:d938:9262 with SMTP id
 00721157ae682-6fd220b0ca6mr65496357b3.37.1740635185864; Wed, 26 Feb 2025
 21:46:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109075108.7651-1-irogers@google.com> <20250109075108.7651-11-irogers@google.com>
In-Reply-To: <20250109075108.7651-11-irogers@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 26 Feb 2025 21:46:15 -0800
X-Gm-Features: AQ5f1Jr6j5phXjEj7e9lBp9_L4DHo1Czztuta0Y-SSWI3Phhj6_a8B60A6is2Rs
Message-ID: <CAH0uvoj=PJMbOR_iQDFxRsGN+Q04tkkHdAceReHoZANOtv3uCA@mail.gmail.com>
Subject: Re: [PATCH v1 10/11] perf python: Add evlist.config to set up record options
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

On Wed, Jan 8, 2025 at 11:51=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Add access to evlist__config that is used to configure an evlist with
> record options.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/python.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>

<SNIP>

> +               .user_interval       =3D ULLONG_MAX,
> +               .freq                =3D 4000,
> +               .target              =3D {
> +                       .uses_mmap   =3D true,
> +                       .default_per_cpu =3D true,
> +               },
> +               .nr_threads_synthesize =3D 1,
> +               .ctl_fd              =3D -1,
> +               .ctl_fd_ack          =3D -1,
> +                       .no_buffering =3D true,
> +                       .no_inherit =3D true,

Are these indentations intentional?

Thanks,
Howard
