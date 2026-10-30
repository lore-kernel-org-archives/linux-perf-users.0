Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793332856;
	b=KZ8sQ4kIR69cM0PiOCFbLVfoCPHPmPwxRMqElKEiDV+8bkjT5rMwKGWZo2t8zkn4b3n4
	 hVVr6HK7/vedANupaQSW3PDxQAQUUNy2XN6R7V7AgMZw8N3VFeK5KOfOzGDRCTaSS78Rt
	 jxv0CUVIzxFQ7fp7c19c/ayHxLqLDK9cS/r39+mbtxNb6JEef/vqImfipq+c61HCH2IT0
	 i+05ChqOMbaKoTcpe31dIejTzogI9NWzfYpWTj/1Y2oeGsFXaRRSkYGlJDm3c54gLEheE
	 rwYDqevDudq6gItrgJgW8mZnQpoGT6iWsOeUz8zMOmi3eAbgrzl18BdKBcSCniqeBug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793332856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8m6uTadjpBwBsLxAqFfYb4n2COxFt9O2P0MYlt7cnpU=;
	b=J54bFoVbP0KK85B9AuyO3Dr1c8KzG3S/KsoF/bNuUSWyrObKKH7dmtDfgObnsC96t1LY
	 MPaqLjOEMvbvTb6eWbDKxbJk8+K4lTAg3x5LczjFLFQ3R7E7ytfHLldhQJRz3FFKU+RIr
	 gNP+xIORXiTchGKSzcELnk/W0UFMWUK06P12NwRu97hbwfkjitHgZZO3//+e1eUavtaMx
	 nx/+MKF8q0MZb9lM5jZx0lWO53UpO6s26sKBTqpeIYTdNPwHqlKmoHMeqLqoUrZYT7pab
	 cvtHzRxdl9JAs2mpyuavLMt57u+ylntaa9eJJuqZH8jBMb6uwe/l1jQOXwrf5SWhESA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MLQ8fT2b;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.182
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9B2606A325
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 04:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A9B2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MLQ8fT2b
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3ab46699a09so2356261fa.0
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 21:00:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793332854; cv=none;
        d=google.com; s=arc-20260327;
        b=NJq1cYKhyAOfboTHnBfRMaq0yLhlKEb9eEHT1ImcsacER7N0FRxUZCHoubsPdhMQdq
         5UxkJ/mByXg8EfnyzMZmBi/JNtaWaLq6ZwbVQgXruYkY6BiQsWNRUDDQA+qkZgfv7O5s
         gQ+jdsxvLtlEKSRGHAADz3nMLAfnkJ3NfM/ogUDt0IGN/dRBpyMdMGoyc+eoULMuL3KT
         l8ztxvuGpknsc3rXk8wZhxbrUcdouy0UGsI+6MOvebmo4zQlba9BZeOPr4tGhEhx+xcf
         gkahbccM79TOwCeMBlzG4cab84oM6uIthnyr73LBykYI80aQWC5Y36Iyw0xIXXANJzzR
         m3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8m6uTadjpBwBsLxAqFfYb4n2COxFt9O2P0MYlt7cnpU=;
        fh=tHxss1ZLLSsw7D3+MXoYCky0MNJyjtz1qSUwwr9wcTU=;
        b=p6EvTlmDRrBMiagE7l4PWYeZMZJIJdSlfOhAZ7xvhyPWcOuIT4uZY1MDr+iqGM2kp+
         1chz7Ddj9I5kShiZtli3JjFR7FIl/hGw9qOh/JYWbiRiln0aqTfhHVs3+PXcgyYZrmm5
         1Ghev4lZSpJYmUvlnhO7THVRRDVwkwyE4pGa0zkcEs7P9NV4gr4Nmy1xTxAEleM3cufY
         JogMw9i4tyMmq8cM57gPZ28cObxtkXI7l5YO5sYs4oReleQiXAc3Rb9yvQjpcVrLXlKY
         x1IikoMcwsZYtNuP21cfC3GiEmeBgDD8Rw2jfnqUtd9DejORF+qu1xiFs1QFkIKdyFxH
         5Cyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793332854; x=1793937654; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8m6uTadjpBwBsLxAqFfYb4n2COxFt9O2P0MYlt7cnpU=;
        b=MLQ8fT2bA0IrB2pWxDyIfLSZwP+jWNfK8KitmWsaH5PvWcsxpG40uPvwBHXRfLS+F8
         89jJ4mCB9yzWEMFfYAZOifPZFwdESXCh0QaBKJIXS0HkyTQI6U2cynrF0eh8XR3vpzmR
         /0FCy+cThpruJWT2/pk0Fz0CWlL5Z0TvB7Ju9uOCeA7NO3Sv18Xx0FGBhUuU4kFx9Kra
         c3PwWxHE3Ne9clhAT9BJiemvOeYSJv/igs4A06foLgG0jV/1o/AeeQf+uO58xje9NkxK
         zO63q/P7lgO7se5dOw7JrM+th6b4GKT2ODiy2BIKtp0850iRKgmJ1UOyixEeGRCzV2WM
         UlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793332854; x=1793937654;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8m6uTadjpBwBsLxAqFfYb4n2COxFt9O2P0MYlt7cnpU=;
        b=LcY2XLJAyZOuaXp3j3CcUtXRcCkSnI72oTPooPqMEGwpmRGIwNCnMA3L+P/SNze8Cu
         20dHCT66FsmGfgqhSlB4f4saIGGJ9ZDQUFbpUWCPS87gztdQHtzhSeyqnZlIrWD8WQVo
         sq82IFH9a8/Y/vv3D5FW7BN7rGZHup7Zf79rXotTdaNZl/tUKtLwLfyOh6JTilsy/Bpk
         AbO2Z+CjvTFw+kCx6jHD4hD160G23h0JxAboByK8ojR79pCdHuQJzBFYVG4Ix21ehAUA
         9bnFMjjJfkhi5dSuEz1SQfeGIKJaMv8e7//xJHd0lGjy6nx+WZ/2eWdM+jHJ86pfxuWp
         2I+Q==
X-Forwarded-Encrypted: i=1; AKwUvByxCcBo1zQNyuzu4TS/VbaVdW1fyJgwTYGXC7Kmod87U01zKG0zXwVmfqzP2RjZwMEc1jxZqIQWFKqc1/V77edC@vger.kernel.org
X-Gm-Message-State: AFq9FYLro/tromzl+yc4viaBraIe5n4YERZb2mn1PbFEM1MUPLXU7CWh
	eNbyR4w+BQZ+C9vSc5EyiboJaG619GJlyS8QBamxd3sVgPpovsJjGxcKRbFch7SQA+wZZIGie/Q
	Xx78sL+WlJQ0XJu0OZHuV2LARBczJD6M=
X-Gm-Gg: AYBFou3Bhhazc3rq7nuwvVvNkCOojlbwK0wHNUL0glHiaqZEgxxThQ+wri46vNlEWZi
	DdezfyomaUSYtPGf+QtWs4NIcEfDCp4qnKFxsW80ADun1CPo5NH1R27cWg259Brvla9r61uC5kF
	1lRFdri3Uus7lvoU5otmgbHp8W8yEoxPHSbB8VItq608P+q/vWFvDM7VqgeSdulL3diXIT9Qj4p
	bVZ2DZceCXkgGIIuLo03lIdQaVHR6S0Pksh4BbiQjjvm2yPbKOUBgVKyOfkOP7uVvLzdkVpg+ay
	qjgZLIo5tM3efoCIMATsoMS9i56fynk1rxk0bxk8gX377vAn6y+4E4LaZj25sQ5qB07XDBVl2RI
	Q3dwo6MyQnf9QfrTzgW+livqFn68JbCFbM9DXrVy30wB9lkYvIp0Wl+UwIQL3H9rPxMn0SOjstH
	s+vFh8mHg4tXGu9HVCUtEhV5OhJulVve9bCkFUvznUZmn9gA8HYvWx
X-Received: by 2002:a05:651c:31da:b0:3a6:55fa:a63 with SMTP id
 38308e7fff4ca-3acb7ac4432mr1662031fa.16.1793332853588; Thu, 29 Oct 2026
 21:00:53 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028-alpha-profileme-v1-0-d44b52bf2500@gmail.com>
 <20261029091141.GG1779021@noisy.programming.kicks-ass.net> <CAEdQ38GiZLmnjYxzN6C92uz4-MOX7KoYvTuRrZ5Zike8ssDCqQ@mail.gmail.com>
In-Reply-To: <CAEdQ38GiZLmnjYxzN6C92uz4-MOX7KoYvTuRrZ5Zike8ssDCqQ@mail.gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 30 Oct 2026 00:00:41 -0400
X-Gm-Features: AclHuK_z8jslhuN5ZuHXp-j3J2LHCtXaMNwtybHEsthjNqU9OxnrlVuVJiof-vs
Message-ID: <CAEdQ38F1+iCoxseW_M_16m9wXW0xe-4eKtr2OnehP=3XppF4MQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] alpha/perf: add ProfileMe sampling
To: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Magnus Lindholm <linmag7@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 11:34=E2=80=AFAM Matt Turner <mattst88@gmail.com> w=
rote:
>
> On Thu, Oct 29, 2026 at 5:11=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Wed, Oct 28, 2026 at 02:09:29PM -0400, Matt Turner wrote:
> > > The 21264 from EV67 on, and the 21364, have a second performance coun=
ter
> > > mode, ProfileMe, alongside the Aggregate mode that the driver uses to=
day.
> > > An Aggregate mode sample reports the PC where the overflow interrupt =
was
> > > taken. On an EV7 that is anywhere from 15 instructions before to 12
> > > after the one that overflowed the counter, which makes perf annotate
> > > output close to useless. In ProfileMe mode the CPU picks one fetched
> > > instruction, follows it down the pipeline, and reports its PC along w=
ith
> > > what happened to it: whether it retired, whether it trapped and why,
> > > whether it was a mispredicted branch, stalled before map, or was kill=
ed
> > > on a wrong path, and what PCTR1 counted while it was in flight.
> >
> > Isn't this the thing that ended up as AMD's IBS?
>
> I have no idea, but it wouldn't surprise me too much :)

Looking a bit further, it does seem so. ProfileMe was published by Dean
et al. at MICRO-30 in 1997, and IBS works the same way: tag one
instruction, follow it down the pipeline, and report what happened to
it.
