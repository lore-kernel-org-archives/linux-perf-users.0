Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E146A6FB6
	for <linux-perf-users@vger.kernel.org>; Thu, 23 May 2024 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476273; cv=none; b=Kszg9r7IBQGx8LJEJpbG8orL/CkekzGr6EvYXvxszkvxyNv89TURGcY/PO8B1LdRCRm4NeRk8cNU1WuQc1bH/bGP+xxloSx56h9mAD/kM7xRa0xgkXQmMsN3e4gCxOQAjC/ETWROuPHsj/LYXAGzXf7fuqPe8rlFwK2Za4AP59I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476273; c=relaxed/simple;
	bh=6Dei1V8D5Yb33LOSasM4iRgudjF+kcW7OT5HoSApcHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UiUEe1CRBdYE8SBShoXAz6VWW4TM02/wJQI/6F/ej16nhquQIJKBe0cAk480qp1tNcbNuw2t39aR5Z1ILeN56fElg+R8tm79aN9jpcmJjsZ8RMQDH8cZps+stg6eND9e7MdqE/jTwRrgDXNjL1b2KeRFzkqWhsA36tI+TCU1jNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0xefdoz; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0xefdoz"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-df4df150f29so1984085276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 May 2024 07:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716476271; x=1717081071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68oizoRonaSH9DwwD0pjskztzrNV7Q/9PfajjCfL+FI=;
        b=A0xefdoz2XoOZWZn8jyL52BumGoe1eQcPoSwOcAEW1TZB/Wipqmhi/BMpooDw9zk2Z
         AscT8EgVLtBjriopARAoiJpXzwWg6QYGJy9gCMwco8gi2zKwOAmDgsKr9+NJV8+wBBca
         CYZ2pQq6+/s86eV4A63wFU/ot6903C24Fl6tvxF+SQeRgQQQyJ28is6QyeldDinY+2Zz
         DkkK+TGxpnsccj+PoqR49lTiVYRM+T3pL3iPs01zHmp0ukKLy+dmN8r4I7dw/zXuN377
         Lo9a2sqlmhv+mq4tJZ9mOXMXLxhRBAKZyvqjwgeTEZEWF/KdMwTnWSZFwbu6FrWCmfA0
         +13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716476271; x=1717081071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68oizoRonaSH9DwwD0pjskztzrNV7Q/9PfajjCfL+FI=;
        b=Zur7PYc+FCI41bBbhuDoVwCbdsQL9j25+v8kZq4tK1ZLWa/SvHm7u9ZbPhERlA6lRw
         XG8Nevu/MQDJK43aFYQfpAqGjszfhdZNJ6k4ZaxRD1lvzYViUXzbmWnl/WZcuSx+OZ+9
         /xDByUnab15h72iEd/8XfbfnlKe4dIQoKHu3ROyxmcQJhwif0T+H4a6Y5M3E8B5y/0Dh
         Lu2Eng5mCPWPaYGvwyIhQ/zN0+oqH2M4IaGDL9MU8mbjqYaPE7AwwpBxY4TwAQAyefKu
         tqD2r50zFAOxIA9hCEDC/X91hjifrKhiJv3/uip0irgJ7x2s0JgMH2VVIwYz+eC33ngI
         y13A==
X-Gm-Message-State: AOJu0YywiRzd0kUtnsEErcN60hBdIZG7CiERuCIyzj4whcf1Jhyck2oP
	CzuaqeZ1DIuRQSsyQ3YEGUl5L/uen8P8DcXVp3NcmeiZh5cypGEHxbKOkRJn0Z6DPwD6n2yBJMU
	nCKbIZHd2dcmfvVV5teghAiEc5/WYYfHi
X-Google-Smtp-Source: AGHT+IEjuPEhh9NnODDmXy3q3UAN9GJ4N3UkIOt66mfLabbWT0AgctSop8QL4gxXcPEhH0+4A8B+sGOmo4uj7dkI9gs=
X-Received: by 2002:a25:aa46:0:b0:deb:3cce:b158 with SMTP id
 3f1490d57ef6-df4e0df1e50mr5361292276.59.1716476270676; Thu, 23 May 2024
 07:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <u3pton5jobtjoaym2zahds6r6xtewry75asyiebwyeqdp5ivee@a5ffx2g2r2ib>
In-Reply-To: <u3pton5jobtjoaym2zahds6r6xtewry75asyiebwyeqdp5ivee@a5ffx2g2r2ib>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 23 May 2024 22:57:39 +0800
Message-ID: <CAH0uvoieGyrhFLq1qrt6ppP+OyQS1jg5nfZRuBSuXcT9pcNmzg@mail.gmail.com>
Subject: Re: perf script -i ... -k ... report flamegraph
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-perf-users@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

So the `perf script -i $rootdir/root/perf.data -k
$rootdir/../build-target/linux-6.9-build/vmlinux report flamegraph`
actually runs a shell script called `flamegraph-report`. On my
machine, this script is located at
`/root/libexec/perf-core/scripts/python/bin/flamegraph-report`. And
this shell script has the following code:
```
#!/bin/bash
# description: create flame graphs
perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
```
This shellscript is calling perf script to run the `flamegraph.py`
script. Unfortunately in this run, perf script doesn't have the -i
argument to specify the path of `perf.data`, so it tries to read from
the default path `./perf.data` which doesn't exist, therefore the
error. Besides, it doesn't know the path to the vmlinux.

This command works for me, but I'm not sure if -k is working here
since there's no sign of perf script communicating with flamegraph.py
to tell it the path of the vmlinux file:
`perf script -i ~/hw/cabin/perf.data -k
/usr/lib/modules/6.8.4-arch1-1/build/vmlinux -s
/root/libexec/perf-core/scripts/python/flamegraph.py`
In your case it might be:
`perf script -i $rootdir/root/perf.data -k
$rootdir/../build-target/linux-6.9-build/vmlinux -s
/root/libexec/perf-core/scripts/python/flamegraph.py `

If you couldn't find your flamegraph.py file I suggest just do a brute
force search `find / -name flamegraph.py`. Because I also find it at
`/usr/lib/perf/scripts/python/flamegraph.py
`.

So yeah, `perf script report flamegraph` definitely needs some more touches=
.

Thanks for reporting this bug,
Howard

On Thu, May 23, 2024 at 5:33=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> I'm trying to generate a flamegraph for a perf.data/kernel from an arm
> machine on x86_64.
>
> $ perf version
> perf version 6.9.gc760b3725e52
>
> For that I do:
>
>         $ perf script -i $rootdir/root/perf.data -k $rootdir/../build-tar=
get/linux-6.9-build/vmlinux report flamegraph
>
> however that reports
>
>         failed to open perf.data: No such file or directory  (try 'perf r=
ecord' first)
>
> which is unexpected to me given that I pass a perf.data using -i and a
> plain
>
>         $ perf script -i $rootdir/root/perf.data -k $rootdir/../build-tar=
get/linux-6.9-build/vmlinux
>
> works fine using the specified perf.data.
>
> If I do
>
>         $ ln -s $rootdir/root/perf.data .
>         $ perf script -k $rootdir/../build-target/linux-6.9-build/vmlinux=
 report flamegraph
>
> to workaround that issue, I get:
>
>         No kallsyms or vmlinux with build-id d1f71a2e9aec6ff7ef1d5dc544d5=
a76033496b70 was found
>
> despite
>
>         $ file $rootdir/../build-target/linux-6.9-build/vmlinux
>         $rootdir/../build-target/linux-6.9-build/vmlinux: ELF 32-bit LSB =
executable, ARM, EABI5 version 1 (SYSV), statically linked, BuildID[sha1]=
=3Dd1f71a2e9aec6ff7ef1d5dc544d5a76033496b70, with debug_info, not stripped
>
> (so the right build-id) and again
>
>         $ perf script -k $rootdir/../build-target/linux-6.9-build/vmlinux
>
> is happy resolving the symbols.
>
> Is this a bug or do I hold perf just wrong?
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
