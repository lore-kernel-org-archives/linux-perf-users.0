Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFA91CD15
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Aug 2025 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095527; cv=none; b=tnC1xqp/F1/tAmVZQOEXXZvwD92+CQBbsAUENSo314A4RABIetSZKsedQhxCwYevd1QPl92JRrUNnzFY/kz73LSx0q53TcBn+vYr1cyjKHilA5fLXvavyN+mtrVhNws7V9v0votd6YB67BcuKeJno1YrTy/I3HN9O26zEEn16gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095527; c=relaxed/simple;
	bh=ipApUWXD/vc+gn0dpjkARbKTGMwSNJWFy53h/IiXXnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWr0VsQSzLQJmPp5rga8RJRFYi9VFJlCLxeduG2CUUM5HNgcCenf36XY+fYrlECItaXEOXveGFcZalOOtlETnkYFK5ahwQASIitemWY2FEQbJCZKQkRs9lz+sHxHqw/WBlfwDLrqVmxJw+lvmPq2vdvBa7UscgapXyTzqH54wcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OagzIKxm; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OagzIKxm"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3214762071bso8125027a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Aug 2025 07:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755095525; x=1755700325; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SdEySWA9pjFNhAetIdOe+TeBj+YFSkBbS61Z6xuGeG0=;
        b=OagzIKxmmqyqb3udhiQ9X5ZnsWD902l4tGC1vq8DetSlLgrd6fiX/6jJ5aWzUO0HT7
         1RPrXod7+PDSTjjPFoitGwp20HiGZAdEFGsHo8dZ3whAMwLYQWGNIEOGVcSHMpyRjOs0
         RUQId8z4UfQW7cF5AtY6qbu+QGbRtIy3TlPp4aCUyCCy/0EksNlxUBKYGjiASAaW6IIZ
         ZcoOBfbd6FhhqUdZh6KscUfL4HUo5RomEeu12790Kn6Zr2OoEd8jyX+QDzwY+Sb31dk6
         QMfQSBXeHI3VbV4gkL3sLqfOdbl58htcmv1HP8iQ8qjFLVNFMssDSxTCg+qhZPM7eEne
         VQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755095525; x=1755700325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdEySWA9pjFNhAetIdOe+TeBj+YFSkBbS61Z6xuGeG0=;
        b=l35W0BqOndCEhJWrQ94KHNGzVTVorqwrrWxbYhaBM65ugygPiW30RTj7rtnngQc3jn
         QA1T0B6E3V3T+UA6caNRfE8jOFvfwCFE4YlTTOjjujZTn4gzzezVdm+Q1sivIupMblhV
         V6gIDnYqtvKBMQPvKHoD97Wvl4TIgGxg2+BPcm5BDGCglYAZE2gGeUqH4iaPdOOLbz0/
         eXw0hO5WiQ9LCYOB6pyl3f0hvYjMP6jGXNqVQZPkEP8aFm4yYJQ7X/hONapqXHJM9UJf
         InNXsasQbNpB2BqDJoQykxW/L0SZfh54UL9WBZU3cTWg3J3kzgVVAq6UP2QpcHZowc8U
         6khg==
X-Forwarded-Encrypted: i=1; AJvYcCVKzpiUp3YOPbgbAizq5G/3c9qK9Ajkl2urhyLBRlNghZTOXSBdqpzQU0TO44XFoAup24BshYrsF7320bpfT+7L@vger.kernel.org
X-Gm-Message-State: AOJu0YxdCXZeOorJYQcjmxXD/fxI7H+GOCrOVlgzeTEh2OFmNfiakvij
	GZX9FsIZlMQpvSLTkANaKW1fE6h4lZ9XGljfAFqjjZ96iPpwgoBPzpCpRGem7MLrrwvVUGvJUzF
	tzKG4OuZDqvGz6+PvsUMdb6HCQl9qtbadhuhuhuxnXQ==
X-Gm-Gg: ASbGnctjfNb0KMxifaKRnuk3M1mBxlNauAEeMFpANIEuAS7UHcFpkzy6BYXJOBfZclf
	uC8EIBiPRvwP0pxN4okzOiYf3e5Z8CvZ/EAzrK3asEe1swJ9T83H0toARtkeQcLKNsZ2A9NXnzC
	ItElH8rwwebz/WI4Zsevp9iEBEJUUKF0dBD8E3CHrf7fjnckB7A0U5w/Rcra8VMOx8gYUGesWRd
	4xf60T7oNl/7fm1/GoqL/eXfWRW9t7pd8h1cnICq6rmGR5fv0W83V8A77TsJw==
X-Google-Smtp-Source: AGHT+IFzsa7z2LB/NwMV+7ODMzwtQZ5c6SDjL/beKBH/4CiDe3n9MltwqzwrpDodhDWNKfzJI3ZmU6XpdnvXzSkeC14=
X-Received: by 2002:a17:90b:39c7:b0:321:cfbf:cbd6 with SMTP id
 98e67ed59e1d1-321d0d6912bmr4596811a91.6.1755095524619; Wed, 13 Aug 2025
 07:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812173419.303046420@linuxfoundation.org> <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <2025081300-frown-sketch-f5bd@gregkh>
In-Reply-To: <2025081300-frown-sketch-f5bd@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Aug 2025 20:01:51 +0530
X-Gm-Features: Ac12FXzTlKbJUDUafTa4ZlpVkqfN8sdY7Wfx9w4NKXTaujZ4mJCVSf-u4y5vZP8
Message-ID: <CA+G9fYuEb7Y__CVHxZ8VkWGqfA4imWzXsBhPdn05GhOandg0Yw@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, qemu-devel@nongnu.org, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	LTP List <ltp@lists.linux.it>, chrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>, 
	Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, 
	Zhang Yi <yi.zhang@huaweicloud.com>, Joseph Qi <jiangqi903@gmail.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>, 
	Zhang Yi <yi.zhang@huawei.com>, "Theodore Ts'o" <tytso@mit.edu>, Baokun Li <libaokun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

> > 2)
> >
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
> >
> > Reproducibility:
> >  - 64K config above listed test fails
> >  - 4K config above listed test pass.
> >
> > Regression Analysis:
> > - New regression? yes
>
> Regression from 6.16?  Or just from 6.15.y?

Based on available data, the issue is not present in v6.16 or v6.15.

Anders, bisected this regression and found,

  ext4: correct the reserved credits for extent conversion
    [ Upstream commit 95ad8ee45cdbc321c135a2db895d48b374ef0f87 ]

Report lore link,

https://lore.kernel.org/stable/CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com/

--
Linaro LKFT
https://lkft.linaro.org
