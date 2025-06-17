Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2FF2ED863
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178273; cv=none; b=ZDhIO57OlgNOK+B3uSy0fKw1qn5kwrOrqNErcSL5/WWkDuFf66vLENXcZuAd1mOSL/KbatldlyKAlL4KK4KPkA5Bkjv31juChAUgCVqKoyyirDmx1vl8KQJayKnbAjK1wqAqzOW24PBM7VO67vGndwtpIvQpJzdeROCpcnYUIww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178273; c=relaxed/simple;
	bh=9AsnWCEVPvobROcoxF8yG2zkQZX682cDYfj+9TgWn1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knV8IMYTiqj2Pe6j1NRX318I+lGTcG/XvyekBcFSYlgGh5IGHTDsaQ0J+u4JZ8dte7mIcM9FZcl3Dlvc23ABUkqWtLxjo0MiOus3OtEO3VTkXXDxltQK5G9abEBs7yPMumeD1jEkpwOjcCu17GFH5rKJ7vDIA6M4HCEJU7rgl5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=toGvl2LI; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="toGvl2LI"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so6015ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 09:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750178271; x=1750783071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNIHj7O+PWxCNnIe9gqj4fYo6MHuAFXiVGVoeRSwXLw=;
        b=toGvl2LIO6kFK50G53oOhuMVQ+PhQkqGJr8my20fWhoL5PF4W3DdDPQqq5qHR/7nQw
         YMAjucQENkPy86c/qBxleP8fEV7h2Bs9BI5RFuwS+R8tGVOY8g5p9ufCEciTMIecKDdf
         tZg5bQ+37W46S4NP5mBGY/6Arn+J1TSykfvA3cCM6Q4tCy78nNzJ/D5Ql8/0jBHdGghE
         47fifbe0EzYO5kJwL4lOePQOVyYnF7W0FJl/R+jn5G5ODiE3ldeqnetM7oRom4dFjM9E
         YslJX1EEL1Az98Y7uG1QxN0f18C7oU1TFLQfMUnTXaPWT+mjFjvMm2WcoOoez4P44305
         qBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750178271; x=1750783071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNIHj7O+PWxCNnIe9gqj4fYo6MHuAFXiVGVoeRSwXLw=;
        b=lYt3yvIpsl1dMLolcrsPpqlVc9iZ0lHrvQMiG8FJi2jTBWX12BzhbvvgCySkqejrPv
         kRL8edWTcSNxGbXyEHcsKoyz7Ayr1/Bo9iblydCktnxd6lPZHW6Q2RYDU5EIrBp61w/I
         2Lx7sX6ynNMmN+jeKdB4IqgadYzk1ZKX1wU8NggZ8Es9K8UPvdElmEIzLhg2vy4HRkV2
         2OfiPfvve7jNBuhavoTp/W8Afh0+mj8BgzZVLffsgSodX7E+w8eO+bGNSJlqER1BLQ96
         rNv5LPhVqUlsbpLgaI15Nb9XJAkivBN9rWxmI+85Pi9zbnsMYUTu+iI3f0pYRAz7Ypqj
         WVRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKWf8x8V839kzKEdnVsWEESuHHoN+YrKiKQ3zgqyE3I/jLu+LUq325tDjMmCyBHZ8YsnP7QrozGbYlTegNWs3U@vger.kernel.org
X-Gm-Message-State: AOJu0YzXtY0QsfYJyUU8fEk/c2O5Ds8J4GGgEn5f81qbukSa9pnkRuWh
	YqwJVAockV6TdDQ1dJYPtUkJOpR/j+xcClU2Ze78f9fxKSXr/e3QLklsIU6+pYg0nJ/RxBauNfX
	ve3+HG5koYGnij1u5QuUsX+Of33w5qZZkpfWmlLF4aSjfVrHqJAkaqjLB24Q=
X-Gm-Gg: ASbGncvUX+kr/5xTlFxLwyDGsySWAI5aijAM3RzD/mqpX8b2/oJbhWmJaluujc8iRu+
	//KHJYTpFgm88wTbfNHEnZX9z4eONScgdq8SwqjYtkB6CFp97Cyl1rJYUEtW9Ylzd6ctkfytLwy
	IKTCVq0n3a31Y/Hs1efLnPE7u8Wusk11ozT70yUUEPnM2K3Qht30jRw0sQ4XlnMhnkcvZNwqeU
X-Google-Smtp-Source: AGHT+IE2EPsNNgBFgqE58/RDic/IaeDCcq5jDG+0OfY6UUZHSyyzMC+ISaxivWDiHJvQg3dWhhTReCNuwY3KHovMNMg=
X-Received: by 2002:a05:6e02:b41:b0:3dd:f4d6:1bbb with SMTP id
 e9e14a558f8ab-3de09f4df07mr10211855ab.3.1750178270513; Tue, 17 Jun 2025
 09:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b0b0ae91-785e-64f6-348a-ca6edd448b74@maine.edu>
 <CAP-5=fVivxz-TPVap6-+6U=ueU9W9fdZSH3w5F7e-h=uN--8kA@mail.gmail.com>
 <CAP-5=fVa14Y+0a=nrxo85uEOHfiEJRbQXt6fOV7E3dQJDf4fdQ@mail.gmail.com>
 <2c759cfb-41b2-6f50-e893-1545a965d106@maine.edu> <CAP-5=fXHgzhp6=xrVi1GK6gO_dtVAAStK__eKKoaAvvge4oNow@mail.gmail.com>
In-Reply-To: <CAP-5=fXHgzhp6=xrVi1GK6gO_dtVAAStK__eKKoaAvvge4oNow@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Jun 2025 09:37:39 -0700
X-Gm-Features: AX0GCFuT7Q2r5uO2wUOLXx_UyF9xeXfAQZu8ABSEEwQSwP6aTHpnJIVKdqLQGG0
Message-ID: <CAP-5=fWYfMe8y-xcZkkEnppA11+H0r33Xnn0Mn2d4_y3dortmQ@mail.gmail.com>
Subject: Re: perf_event: avoiding gpf on rdpmc for top-down-events on hybrid
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 9:36=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Jun 16, 2025 at 12:34=E2=80=AFPM Vince Weaver <vincent.weaver@mai=
ne.edu> wrote:
> >
> > On Sun, 15 Jun 2025, Ian Rogers wrote:
> >
> > > So I spoke to Kan and posted a revised perf test that works on hybrid=
:
> > > https://lore.kernel.org/lkml/20250614004528.1652860-1-irogers@google.=
com/
> > > Basically on hybrid before doing the rdpmc instruction the test now
> > > ensures the affinity matches that of the CPUs the perf event can be
> > > scheduled upon.
> >
> > for PAPI we ended up using restartable sequences which more or less wor=
k
> > for our case (though we had to get some fixes merged with the upstream
> > rseq developers)
> >
> > I don't always track the libperf code as its license makes it
> > incompatible with PAPI (which is BSD licensed).  Does it handle the
> > rdpmc case where by default on x86 you're supposed to sign-extend from =
48
> > bits (or whatever is in the mmap page) but some of the top-down event
> > rdpmc registers use all 64-bits so the sign-extension corrupts the valu=
e?
>
> Yep:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/lib/perf/mmap.c?h=3Dperf-tools-next#n514
> The same code is in UAPI perf_event.h which has the Linux-syscall-note:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/include/uapi/linux/perf_event.h?h=3Dperf-tools-next#n651
>
> Fwiw, I don't think restartable sequences would solve the problem of:
>  - 2 events programmed 1 gets the fixed counter and 1 on a generic,
>  - the thread gets ready to do rdpmc for the generic counter,
>  - another CPU/thread requests deleting the fixed counter event,
>  - the event is deleted and the generic event is now scheduled onto
> the fixed counter,
>  - the rdpmc executes but the "index" is still set for the generic
> counter but the kernel scheduled the counter onto the fixed counter
> which I believe would have a different index.

To answer my own question, the sequence number will vary after the
counter is read and so the read loop will be retried with a different
index value loaded on the next loop. Perhaps this is the right fix for
hybrid, if you have a hybrid system a per-thread event with
cap_user_rdpmc and the thread is rescheduled (say p-core to e-core),
then the sequence number needs changing in the user page mmap. This
will trigger a second loop where when the index is loaded it will be 0
for disabled.

Thanks,
Ian

> but to be honest I don't understand how the mmap page works for say
> only opening the event on a subset of the PMU's CPUs. Or if the
> "index" is loaded and then thread preempted onto a different CPU with
> events scheduled differently (as with the delete case above).
>
> Thanks,
> Ian
>
> > Vince Weaver
> > vincent.weaver@maine.edu
