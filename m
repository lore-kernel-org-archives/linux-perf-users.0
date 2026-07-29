Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C473B5841
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353488; cv=pass; b=fQrVGrLbtkmIZ8C7VpyZjONH12M/5K+511F+MvZEkyx3ZO6qLo0yKlYmeDEyTtcISsPv89uTG6+AEpTl+CzjF4jj3U4e12ebMMsv1GqIzA4BMsuL4DhvHL4ntNO6HeiU9ceITtsIBIE+ZOyVQEhWxG9WE0AhwtsCKpHAabfmf6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353488; c=relaxed/simple;
	bh=AW+2NReGvoch2mVxj+60oV42GoQXvVY/28NZ+o3sxTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHLrVjIQK7oUINJhg2ru9ecHFCtmqDX/n2Ei4mG7OSvcfYY1fXvDhZOmGCkYoKXKVy8qLlViZXG7b66KR98sMM8Mr8ME/BMMrOVcEaQvcxXT3ZRu3yp46zZuegkWjMTkR4cl4PUk8a3N8w1T0vx/D5YKMCuVSPosaHfcfHpAHbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsCuZjvw; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsCuZjvw"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8487214ad2bso2033442b3a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 12:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785353481; cv=none;
        d=google.com; s=arc-20260327;
        b=FUPMxXgMrYRXvEMrgb76netWIx6soXtvCwTcpEnZJ5hrhOdj3k3rex+7gC6LjQNMKm
         po3pzcRQoct0ZF87qBedHk0OxbgeVI72PNrGJfmVQfo2pwJEu6raPRtZjWijB+sHO3wp
         JcyIURkbm1dKVPhQCJCDrTjyZ8rkv89J0w4Kc8GxIna4lidpkw/LXOmY2DCociUhOYQb
         Wuh9ngQkVg6pcXtXBV/jT3OmoUk52yUj8RawNd51zXMU1APO9WTcDZXG87kXZWYP5B51
         U4GVSeJIXB7KT6KrJLwUHATltTZBV6U7AWeEPTLNeS2bu9oR8KhyauQ1VbGa1dzUmNzf
         jzrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZEPCjaM0A4Cy5/l9buwk6OfkCA8SEBnX/nbFrur6xxY=;
        fh=jzdqsyGSD35OLK3wchzc3UbB55syTQVCFZuZpps+oEA=;
        b=oYAqBZN9BZMc8S+2Yi/qN6zy/4okgC3CsGlST9zWHyovD9dmVR6P/uRQmTRDGZhdTB
         jOTPLF1y8dKKlRVnh0HRW+MiLVVJeabhavDS7Bz+W12z5xWB3IoXw1CpkwoWPcaqHDcL
         y2JOA48NcIunp9ZVRiVdNNdg7rdQ+8qx2sQttAujclo4V62RZUANyu6QRXKB6XK3xhNb
         eyBRrZaJVo3ZlV/o1d4h7jS0j+TRMcBL2r9BEnE48dUZwMHEnqe4Qob6iKbe7vFAy4H/
         1K5sA87RYAL3r0PDf7pvC9827ezvqzOI5FH1lZTNBW9oztecPFHB3aLMpn0bWgYN4Dtb
         +3yQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785353481; x=1785958281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZEPCjaM0A4Cy5/l9buwk6OfkCA8SEBnX/nbFrur6xxY=;
        b=OsCuZjvwu53Bt5xqrwiBNeckfkSjiWJzvvxKY6fbPq4G9COH7Ao7fQV0AZfz58z/1k
         GIZ0BpmtujRkYBugLG2dR+6rnEbekKdfRwMITuWdJ8AovWlwsl79XJXZ5Y0ApsTWtZgQ
         Nwq1xEj6eWtYpteKMtKivHRPP0cXIzm+bijLcsOZNaHcXMIqDgkiRng3pDo4lNxhPxdC
         F/nexB2rV7cfx0Z3y8j/Z5yx+8U2YR1MBMfuizTq7qRQsbLhZ/rsbm+u8zL8A2nNqO3r
         d5HSRi2bbkmlizmKOvTi+lj8k8U+pyQNgWfRLduHxsxFKU8VZvg9B1GSRrPNyI1u8+jq
         3zMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785353481; x=1785958281;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZEPCjaM0A4Cy5/l9buwk6OfkCA8SEBnX/nbFrur6xxY=;
        b=HO4H4hGFhhbgkCu+3js+h81R2a4NNErgiapPUWXfwnEN9aEhidqARCYDrI9EBrFXl1
         LtgdUSCFSqHNH0KtYWEHi+LPUUNc8xnRYcx7C415oxGReko2wTTfb0n+iW6m96mVekCJ
         JekHG/+qA8XWQdnQedicqFQziyWuOClFrsjq7dvNno7wUA9hSgWHQk85aOHf5s9icwgI
         3ykEzHETKIDNsBDATWluifBhnFLf52QEwVgf/E6OQB/SLjYr0jejS26RZJU8IhJ1VgvO
         xSjFkOLfT5vAPEka5h7qXGw1eq9sGnwd5Xi6z7498GKARJtNtBscd0D0DbLrN8A8/6d0
         VP1A==
X-Forwarded-Encrypted: i=1; AHgh+RrTvzGiU7k7oKdCThrrvde1EZ0xtcdnXGzZPeoT1DQJk5MRtWwtyEpjQRc/PWtRK8r6n/WYhEVxA+FG5RxjDv6C@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsi2Q+Yn3710tg4HgaKYW39eGkK6kmZ7aAeSAqI8is/9qn8lsa
	KUllnRV5x+tLcOo7Sfn5Cvn3Fz3WGEWfDDjOFpTg5WwCrFyFiND6bXyTaaZ9zcC50PQfISeanL+
	+rVsD50fFYkRC2MgPyWCjdPwKlQblUio=
X-Gm-Gg: AR+sD11AKTNACA+O5qvqBUEoc48jIzX4MgMXy5pClDTc+067A42q8IkO/jNp2SO1k+6
	ZDfls8OxbGawgFKfRSBXYtmppr43OZ98owrRjSMjJ2c0P1d9mknZ+AauT2beVMxAvHH0v5d3moK
	poWkX0f4Napq5aX4szYX4R78UOLBIMIWxI2PEFbNg0VhgjNb6uDBypOBkAtdJHi+RZf32c2d/Xi
	ZIW6n0xIk4ClPCvQOl0z82J7T8Zv4BgvzR4V+Qh4jG+lNxble7Cj+E+y2yNn+mzpkd+f9D+lgkx
	Y6HmZqLyIihuHR3rpcwoMJAwVu7fASQWjtTYutDYeJN17SEHoU9wDadY3urz0sdjF9e8MFWu6Lf
	rIZvXMc7Q9pd+Wf+w9vngNPS4By+uexJqyt0M
X-Received: by 2002:a05:6a00:2d28:b0:847:8250:2b2b with SMTP id
 d2e1a72fcca58-84eba209c22mr58219b3a.52.1785353480816; Wed, 29 Jul 2026
 12:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729-uprobe-v1-1-61896b87c867@debian.org> <amokG13tEnA7VVVf@redhat.com>
In-Reply-To: <amokG13tEnA7VVVf@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 29 Jul 2026 12:31:08 -0700
X-Gm-Features: AUfX_mwlnvUi1r-ku73ZCSAcs_YOxNgVJkyNNO_0D-3nnjYBTZf7rGtYqZPK430
Message-ID: <CAEf4BzYON57L_HD71qUOdRdni_=1S-Xomz27PeDBxbbXDy0Jug@mail.gmail.com>
Subject: Re: [PATCH] uprobes: Fix NULL pointer dereference in hprobe_expire()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 9:02=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 07/29, Breno Leitao wrote:
> >
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -832,7 +832,7 @@ static struct uprobe *hprobe_expire(struct hprobe *=
hprobe, bool get)
> >               if (try_cmpxchg(&hprobe->state, &hstate, uprobe ? HPROBE_=
STABLE : HPROBE_GONE)) {
> >                       /* We won the race, we are the ones to unlock SRC=
U */
> >                       __srcu_read_unlock(&uretprobes_srcu, hprobe->srcu=
_idx);
> > -                     return get ? get_uprobe(uprobe) : uprobe;
> > +                     return get && uprobe ? get_uprobe(uprobe) : uprob=
e;
>
> Well, looks "obviously correct". At least the current code is obviously
> wrong, it even checks uprobe !=3D NULL 3 lines above.
>
> Andrii ?
>

Yes, indeed, I'm more surprised this didn't come up much earlier
(probably it's rare enough to have uretprobe with refcnt at zero
during fork). The fix looks good, thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> Acked-by: Oleg Nesterov <oleg@redhat.com>
>
>
