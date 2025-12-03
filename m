Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566B62DCBE0
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Dec 2025 21:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798679; cv=none; b=WX7x0Pbd64+wFLJO2Wcn/SHjr0EjT95SkTgDyyahz6J6kK+NOyGUBh+bS205JIg10eFa2xo+ALOxmLlsPH7rBU2/INA3L3HpmDODRh9EWFWpHGEnj6ZaCYuNoGMHFkcf9FUEKnmEaqHBt2OLtYmFqOb/daSny0yLtFBlvXUo8gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798679; c=relaxed/simple;
	bh=oSTCN59RHaF/BFgo8zzJKa+5K4tKjM046cM7KL+wLyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYenZetsepZ6WUSsHxKspcYx/MvPiNhcCbE2rkDKrR0Tc6Hf8mchoqfAAGMoYpTJ8Ln0kZ0aQURPDC/b1ZXJIeaSjZOXFbj3kCU9tWBWSJwAfowgAGoYPGCSFNiOgKeugHMy6fN2n2HKfC1EVczDg7K16/P4Az0kF7Wkq3gkr+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1UjSWmNG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1UjSWmNG"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-295c64cb951so57085ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Dec 2025 13:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764798677; x=1765403477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xr3HyFkHSSGTb33wkJrXY95CS6Z4GdjEvX6KNWzd8xQ=;
        b=1UjSWmNG1MJnAkFrDpgsA2BnSZRP9E2p6XjxH9TXzJnoNt1XlOf18GTx2PTYU/fKh2
         cw8Dte2Nz8h/Aknc0nERvQx39Gj959ZUAkQz/EfcSijUic7u4hE9nQzS58mHD/PS+gjP
         IyWFeFeNboJ4mXSD3k2kreIjsplzpM7ylaJOJRDz6z9DYdQpA1v30ECZnUzJ7qCLGX7X
         QizOgqGBFlR33MIwfxlMTx6T6fkkf6aAT6nEYhXiUWcyMyjjoEdfgO50DBNePqW1X0SP
         Clqo3kGdsM3BglQV9K430qmRXzCqN9GL9UHxtqoiiYuhm21gEGutWVX/efI34rVmK0bG
         yQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764798677; x=1765403477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xr3HyFkHSSGTb33wkJrXY95CS6Z4GdjEvX6KNWzd8xQ=;
        b=G2U+F174GUhkwm70M2ZFakbmLaIrQXLtvZ4SEkvn8Hx9Gmwid5LyjTR03oUIYgqmaT
         +L89TR/NsWy0/I823r05JefV3KzcBOTqBcx14AVrZ/6fH3LVGC/GHn0U0BqvO2um9fPX
         EXd1czxdgyjCUaF0r8sLtWtH+tsirOomS+dk2dIz6EDegAQFuSSuX0SImKb/orXc/KZb
         jRW/cefwNlzlMtn6kPvRI9qBo/a/PlV0xkvlZ/m9nq/SNZiDAflABeWNPaxm1IodLUYP
         oo9GNbMEfbAM1IPkWG54INfUYFZQ34ew9f0rF+5lGpy5AJdUy9KkzkMSP+MwbE+m2XdT
         AwYg==
X-Gm-Message-State: AOJu0Yx8lXME8D5/lxS3t7qC5hi6qSfHZ6jKpT6LwWkNTGMNnPi1PYaE
	Y6gEB4fwrci+E5QOYVV/1Z8cCvPPSuACbP56qfr07PTXSBI42NZzhbWYUy2YPvWdiPCQjmjC6TK
	vyV980C+33/TXd+CIGcmsikNwy0AloCvgz2VhQKFX
X-Gm-Gg: ASbGncsYb2tUij8VtRWM5Uy7z7taZNMKk+YEiazWx03GwSjFz0dcYR040wdvVc3YuCJ
	iYZBb6KVAkH1uG1QbLof71sSGAbMmbEQM29Wb4zjLe186YKUJyMmzNg/sSEyaIgDwpPBxKqrsVO
	BE3yfEEtjJeKukCM2ACmSzy6/yNB1PKwB8h5bUlFJo9PwilreHr9YhJYNwkgJfVgp3T9WGiAVe4
	olT9LUL6h/+NeXKvXt+gTaCyRoLL/yCAjNrgqjsEs18lsOZxmp4zZf8HIJ2iLPr2kYS6265
X-Google-Smtp-Source: AGHT+IFNM34p4hYpmaz75oaRgmGGWtF7uvr6OwxBeVLM724V0LiOi8wHDxZpXtBlReJQwDCA8uBo2Cz+lcTSstIQMEg=
X-Received: by 2002:a17:902:ec90:b0:271:9873:80d9 with SMTP id
 d9443c01a7336-29dacbe34femr141325ad.7.1764798677305; Wed, 03 Dec 2025
 13:51:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <94313b82-888b-4f42-9fb0-4585f9e90080@linux.ibm.com> <CAP-5=fXFJJOCDqdCXi4hT65o9g0GH+xwnUT3Qq-OErra51kKFA@mail.gmail.com>
In-Reply-To: <CAP-5=fXFJJOCDqdCXi4hT65o9g0GH+xwnUT3Qq-OErra51kKFA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Dec 2025 13:51:06 -0800
X-Gm-Features: AWmQ_bnaQGNfLE0ZN00pHyV6jZ8hiVbX6SlFRIlrD15iz_COWeNJNEFvMy64lEk
Message-ID: <CAP-5=fUoYYThz4vA_hCGoCLorNHZUWvc5BTK+sK5xp0Lkm4kZg@mail.gmail.com>
Subject: Re: perf stat dumps core when CPU offline
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Jan Polensky <japo@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 9:47=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Wed, Dec 3, 2025 at 5:20=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.=
com> wrote:
> >
> > Hi all,
> >
> > Is this a known issue? Trying to do a perf stat on a CPU which is offli=
ne.
> >
> > # echo 1 > /sys/devices/system/cpu/cpu1/online
> > # perf stat -C1 -e cycles -- true
> >
> >  Performance counter stats for 'CPU(s) 1':
> >
> >            123,965      cycles
> >
> >        0.000356838 seconds time elapsed
> >
> > # echo 0 > /sys/devices/system/cpu/cpu1/online
> > # perf stat -C1 -e cycles -- true
> > WARNING: A requested CPU in '1' is not supported by PMU 'cpum_cf' (CPUs=
 0,2-7) for event 'cycles'
> > Segmentation fault         (core dumped) perf stat -C1 -e cycles -- tru=
e
> > #
> >
> > This happens on linux-next and linux.
> >
> > Thanks a lot
>
> Hi Thomas,
>
> sorry for the issue! I ran a similar test and got the segmentation
> fault. gdb showed the issue was similar to a bug with `perf stat
> --null` and testing those fixes gave me:
> ```
> $ cat /sys/devices/system/cpu/cpu8/online
> 0
> $ perf stat -C8 -e cycles -- true
> WARNING: A requested CPU in '8' is not supported by PMU 'cpu' (CPUs
> 0-7) for event 'cycles'
> Error:
> No supported events found.
> The sys_perf_event_open() syscall returned with 0 (Success) for event
> (cpu/unknown-hardware/).
> "dmesg | grep -i perf" may provide additional information.
> ```
>
> Not a great error message but hopefully when:
> https://lore.kernel.org/lkml/20251201230904.290733-1-irogers@google.com/
> lands this will be resolved.
>
> I think we can test this behavior as the only thing required is a CPU
> that's not in the cpumask, any very large numbered CPU will do that. I
> also think the error message of "Success" is confusing, we should
> probably just drop that message if the errno is 0. I'll add these two
> patches to that existing series.

Patches to fix, test and error message clean up added in:
https://lore.kernel.org/lkml/20251203214706.112174-1-irogers@google.com/

Thanks,
Ian

> Thanks,
> Ian
>
> > --
> > Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germ=
any
> > --
> > IBM Deutschland Research & Development GmbH
> >
> > Vorsitzender des Aufsichtsrats: Wolfgang Wendt
> >
> > Gesch=C3=A4ftsf=C3=BChrung: David Faller
> >
> > Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht St=
uttgart, HRB 243294
> >
> >
