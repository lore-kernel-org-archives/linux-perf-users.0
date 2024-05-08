Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30501272B2
	for <linux-perf-users@vger.kernel.org>; Wed,  8 May 2024 20:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715201110; cv=none; b=qjx8xuLtsTLYOe8sJI03w/qJR5TXQXN8yTm4IDqBMkWSCcGQMLVE0ia4x+Hnj66stPbblZ2UDdzgPwD/WJQKgVmgE1m1+S60unrNO49RfFab2A7e11WrQMtGOLm3ZkDtyXLzrYnqTadKQgbFdz69Q45ooclWce/3XRkV7Ocd3ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715201110; c=relaxed/simple;
	bh=+TrNJxROO7MAmapZhWZcQZNsYA4TI5CqvlqU+QKwtRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPP9zrDxN4ngFaNrdwac68yujQn5BUuXAXlhtv5ES9o5mSh3t3zPA+IaUhHCDbcy1FLEFA9PwZkwGLwlWP0LusxJoAGIeBnlEX6Ee1eVP+grQYMbcqp/v1D3vEMLp2gJMd17JlCgMDEyM7Jf5v4TOPyYR6jQgZYJGaF9FHDh2KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ue3R8+yk; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ue3R8+yk"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43d361a2124so103201cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 13:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715201108; x=1715805908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrS4ra5r0MYUhXUqUrqqa9EFMt0orErlafYzq0uBTrk=;
        b=ue3R8+ykxQxwIVBBXHeVPWoH87ZNdT/hr+LTTSkUo/19PVxv9yd1TzXh8//pQDM2vJ
         /mJfLmuZw6jdZ95VbTYmD5Tz4SWyqxsXtKXQIEvRMiKm+EEu9y6OL6W3C5HBvO/eWFzj
         77WNLXeFNduacSPmbMA9ekE8uFQIar0oZoZPx3DTR4PNABcaaQ+OtGJsefoQ+nnszFr9
         UnIxc3mM93V5YcLXEVTfKVGNaavuRU4vDtPXS86oVUxAKydxSFnIIkgI22sVBqdMUuHZ
         GjqPkAXslFyvRj4ClCuk2KMBG3sEgeZkE7MlFOroOmFk8R3saAQBtk1RdufPWqpOTRcS
         np5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715201108; x=1715805908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrS4ra5r0MYUhXUqUrqqa9EFMt0orErlafYzq0uBTrk=;
        b=sprBhxyHHb5gvfxRjY2DKL4xNzdxAAD1hWHtrMxg+HKrrs/ytz/8KxGRaPswh5H5FP
         7s+bnoX/CHfTcK7PZraftFhcLL/3ecNBb8zEeeKdcw9i/d7NcaNxNoL91UOvzMLvfPZ1
         Tn9pmW8y3o/SdTWMTdnFDolwUnLKxfcnfxBywuUn8Ol3Fz/vk4H/gDV1tX9wkOsAsOmc
         p2Z/yeRPyHqNG9A2pUa9LuPJ05PCf4oMkcCioSv+GmzGD6nrDvaKDNzTDBUW6lTQgspa
         GPb0mWyhxi+grqvRQd016fCOnN+9VTV3AKZp06IqInufaAxU15vHZZV3hhD6Y+kJx8UF
         bzFA==
X-Forwarded-Encrypted: i=1; AJvYcCU4Nf3aLdv6KVZGHEAGsP1hxvYbseYuE3ODxnCJx79AfvIPc8WD1AT+3NZF+Dm7+omA4nPvwTy54cA8zb9z/n/ST05nX21v4CL3dNjTWDTGuw==
X-Gm-Message-State: AOJu0YzajMKb/MbMNazAWUe5dNr/gQyAaV5pH6ncWYL9k9TFYKTCmafa
	0EmYhGlG61jPiRW8aHE6zt/tBdFSWZkHrbyISvVSzYjUuJX7weJONDQml2M2og1ArpUWIzz8BRP
	WKIEfYyu2HMpTiZQgO+7FzTQY1D/kX4MvMjsC7Y4k4LDgNG5gRFjs4nw=
X-Google-Smtp-Source: AGHT+IH78yrpGhaO2gSlcGlq7AlTg4g7/GluKLEv+bGcOc0UlkSZjbXsCjMz34xRnP6fjTUeWEdXGxDu/sVE+za7bsk=
X-Received: by 2002:a05:622a:5786:b0:43a:b51c:46ca with SMTP id
 d75a77b69052e-43df483fa74mr51311cf.29.1715201107528; Wed, 08 May 2024
 13:45:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZjssGrj+abyC6mYP@gmail.com>
In-Reply-To: <ZjssGrj+abyC6mYP@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 May 2024 13:44:52 -0700
Message-ID: <CAP-5=fUvLiCDVDFFfJ78ng4T1FZ8j2N9Yt1sGTeGsupkbFEEug@mail.gmail.com>
Subject: Re: Makefile.perf:1149: *** Missing bpftool input for generating
 vmlinux.h. Stop.
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 12:39=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> So I've been getting this perf build failure for some time:
>
>   kepler:~/tip/tools/perf> make clean
>   Makefile.perf:1149: *** Missing bpftool input for generating vmlinux.h.=
  Stop.
>   make: *** [Makefile:90: clean] Error 2
>
> ... but if I clone a new repository, it works fine, until a point.
>
> 'make clean' doesn't work - and 'make mrproper' in the main kernel
> directory doesn't clean up properly.
>
> Only if I do a brute-force:
>
>         rm -rf tools/
>         git checkout HEAD -f
>
> does it get resolved.
>
> The failure condition triggers if I Ctrl-C the following build a couple o=
f
> times, without it being finished:
>
>
>    cd tools/perf; make clean install
>    ...
>
>    LD      util/perf-in.o
>    LD      perf-in.o
>    CC      pmu-events/pmu-events.o
>  ^Cmake[3]: *** [pmu-events/Build:43: pmu-events/pmu-events.o] Interrupt
>  make[2]: *** [Makefile.perf:709: pmu-events/pmu-events-in.o] Interrupt
>  make[1]: *** [Makefile.perf:264: sub-make] Interrupt
>  make: *** [Makefile:113: install] Interrupt
>  kepler:~/tip> perfi
>  Makefile.perf:1149: *** Missing bpftool input for generating vmlinux.h. =
 Stop.
>  make: *** [Makefile:90: clean] Error 2

We have a checked-in vmlinux.h:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/bpf_skel/vmlinux/vmlinux.h?h=3Dperf-tools-next
so this shouldn't have been a problem for a while. bpftool is no
longer on that line:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/Makefile.perf?h=3Dperf-tools-next#n1149
so I suspect if you use a newer tree then things will work.

Thanks,
Ian

> Thanks,
>
>         Ingo
