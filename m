Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B936E2EAB9D
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Aug 2025 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092479; cv=none; b=QxZP4HQK4w8fPSvURxUVM8rcgwIzxWHhxrPiytNoDmdPZYEJ/kLiEHudZ/JNWzQj6b704p4LVN4gNdyFZYTLh9xK8l7HjPjBvKd9EnzyEwiHLjbyodg6ZOSh4ZsH8cCSsEKWdxnXu0faDgj8P8/roKarwWaysZ5rOAZ/ZWnnCtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092479; c=relaxed/simple;
	bh=cAR2FPV/ROme89E5VHNey3/dlly2/gqFm0nN2kQt4sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QGJTOt2CzSnZQwhs/48qlC8gPe8/gdXiR5O2SSbIGRaPW1W7eiVo5S+TjS1kGzSglueV4kEUb9/qoy1cGj8g4EIQWZyvF7VdPPpV4/CttqhMwBDwV8jcEok2rr5kXrpbCZWC5i447TnJxv2+JjS81iRlWuGvCOvZbF3W2QWz7rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dvkvDwn6; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvkvDwn6"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b34a8f69862so4967616a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Aug 2025 06:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755092477; x=1755697277; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BuoYHGYkCh033zSzlMciRVTnS9J8QMWvk5NZ+OdGx/A=;
        b=dvkvDwn6Q69ZDEiOFDSsL7Dop7VF90MGADW9JBQw1QJNXOGwlo+PvbBIYBWQhsi+Hf
         rpIVh5RNYa+/exggyh3FUfaMidQ/OpITp9OFptcW1tIWt8j2nB3zqe9s+gVbo00HE3dy
         9m6STNrujQ5Ax8vh7NLrqyMZwC0GRHbE8GlfgZ2gsJsjHhP/7zGmSv1QY/QzafrG1UsH
         va/iMAC4DFLx2M6+biC8spPoN9lU2JJGP3DSYFxCH5ersoq2EyzJ4/csS4vPtU4a7jSB
         piZoeAj61M+nZ3NAAcZ2frN65DEP2NtiWNGOVogxl7gftDuUfyn+A0j19IHcEIwNSFv2
         oryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092477; x=1755697277;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BuoYHGYkCh033zSzlMciRVTnS9J8QMWvk5NZ+OdGx/A=;
        b=qKKFHsEazHdpHAjdAooSBKtsSjI97rF/5NGB5UVc76OHuoLav4ABC5ZM30WlUpN7Ah
         NURLXYhJELDUfW4ze/sgwPvHU4dS3xnmsd1SW7f6w1bEpSlwmeY6+0s96zb+hqq7By6k
         12PKnlfwY6TuB8fnjd3U+ppzBhfiRgnG+tl/P8VjFdyHRHnlwyzOxm98WMvGWE5j4JDZ
         CRuchPCqH8PT++ltUnNgChqNeZKmCUsEL1Vhev0HDwK+zif5O8zpYWBYFmVHI+DE4WXV
         Em6DJ6SWRypqIF6neeaO+xuSHbFOSPXb5mfjWEJK1AKAyjZrk99U+gG4VloLE7xT4tfS
         ZaMw==
X-Forwarded-Encrypted: i=1; AJvYcCXKKv0ezJpyR6zT4fCgVv5kAndbJRHZJ+LecDXInxxuQNKkjH3XW5K2GvtqZ+HK3kvqr23RQWFKrpL7G/o4TlGU@vger.kernel.org
X-Gm-Message-State: AOJu0YzVY6yzooXvOx8vWNasnryCf0ofDJBEInsmN6iVpkRs2mxWG5PZ
	nbmRiQTiNjscnasLrVTHjdl8Nl/6JIpHs0U1XucztqldolwkuS6wMn97wpjANnANe6V54MwhB0a
	iBWRYeaJ+mc677s8r20j4ZaRht1emUvz+8yCbeRU/Ww==
X-Gm-Gg: ASbGncst6vvwyOrtfPqpjEqi1i9Ue9DGHBRats1XAkuzJhoZD9M+KQsUdVwAV7/TReR
	Pth2YlRWMIsFTboxCP3BACYrAKt+Agakce6KMsiIiTJurO/FC0238estmilZDJCAxKWtul8bRK4
	hs8yRkGAJi7mgKIVp4G6Ba1w6uMsXgX8cNkV9MjvMufYG1uJuj4bZusgfdfsXat8111cbRDAirB
	mA7PsBzzZqNoU6BROYjZEYgNlOTnhZiymxSTgWe
X-Google-Smtp-Source: AGHT+IHJ5NorMBOk/mMmvjq4NxC90d+IjwHZjpyxn70pQloc6AgGTp1y/wa+zMeluJYPNCBvRdh21gvKSjV030UR2Pk=
X-Received: by 2002:a17:902:f785:b0:23f:e51b:2189 with SMTP id
 d9443c01a7336-2430d0f9a4bmr54705775ad.17.1755092476818; Wed, 13 Aug 2025
 06:41:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812173419.303046420@linuxfoundation.org> <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <bf9ccc7d-036d-46eb-85a1-b46317e2d556@sirena.org.uk>
In-Reply-To: <bf9ccc7d-036d-46eb-85a1-b46317e2d556@sirena.org.uk>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Aug 2025 19:11:05 +0530
X-Gm-Features: Ac12FXxKeYVh06szquTrecWrS7rqGYyi8ckXtXfcapehmWdAEuqul8ZUWvjf2tw
Message-ID: <CA+G9fYtjAWpeFfb3DesEY8y6aOefkLOVBE=zxsROWLzP_V_iDg@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, achill@achill.org, 
	qemu-devel@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	LTP List <ltp@lists.linux.it>, chrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>, 
	Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, 
	Zhang Yi <yi.zhang@huaweicloud.com>, Joseph Qi <jiangqi903@gmail.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Aug 2025 at 18:21, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Aug 13, 2025 at 05:46:26PM +0530, Naresh Kamboju wrote:
> > On Tue, 12 Aug 2025 at 23:57, Greg Kroah-Hartman
>
> > The following list of LTP syscalls failure noticed on qemu-arm64 with
> > stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=y build configuration.
> >
> > Most failures report ENOSPC (28) or mkswap errors, which may be related
> > to disk space handling in the 64K page configuration on qemu-arm64.
> >
> > The issue is reproducible on multiple runs.
> >
> > * qemu-arm64, ltp-syscalls - 64K page size test failures list,
> >
> >   - fallocate04
> >   - fallocate05
> >   - fdatasync03
> >   - fsync01
> >   - fsync04
> >   - ioctl_fiemap01
> >   - swapoff01
> >   - swapoff02
> >   - swapon01
> >   - swapon02
> >   - swapon03
> >   - sync01
> >   - sync_file_range02
> >   - syncfs01

These test failures are not seen on Linus tree v6.16 or v6.15.

>
> I'm also seeing epoll_ctl04 failing on Raspberry Pi 4, there's a bisect
> still running but I suspect given the error message:

Right !
LTP syscalls epoll_ctl04 test is failing on Linux mainline as well
with this error on LKFT CI system on several platforms.

>
> epoll_ctl04.c:59: TFAIL: epoll_ctl(..., EPOLL_CTL_ADD, ...) with number of nesting is 5 expected EINVAL: ELOOP (40)
>
> that it might be:
>
> # bad: [b47ce23d38c737a2f84af2b18c5e6b6e09e4932d] eventpoll: Fix semi-unbounded recursion
>
> which already got tested, or something adjacent.

A patch has been proposed to update the LTP test case to align with
recent changes in the Linux kernel code.

[LTP] [PATCH] syscalls/epoll_ctl04: add ELOOP to expected errnos

-https://lore.kernel.org/ltp/39ee7abdee12e22074b40d46775d69d37725b932.1754386027.git.jstancek@redhat.com/

- Naresh
