Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6B0350A39
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753087; cv=none; b=qmjmE2THgMGLn8Y0hoffCcTtkpH2qnfRd85nOmx15T+2sCc9gc3ZkqF0KMogSvuucZ0iePyJcOdNv8LlkkNF8FczQxR5bR5XQlNK5SlFM0aNZG1tEFxdDvrO/L711mVXkN1yrQoOjmXxVsM+AZK1wBQOKXrSkxT4sHExUdHSqQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753087; c=relaxed/simple;
	bh=3bEomzO+Em1EB3N65Xv0TWxi7FEIz9wM74Y684nja5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pr1BHLiu69751dscIc+Z6maN6T+AwqdXk18D4kwYCWXjIZi9gekEnE3nGD3prbyCSVvz21+fS+rMKFhZ16s2VW+kU6CjCWN+gE9f/ZqOXrSFEiilGElfzVmdNB45OTq6Xh9dhteBWWK/vqUWav0KQwqqMr5uMf2xnoRbpmc/JDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i0xNNR0J; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i0xNNR0J"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27eeafd4882so252405ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 08:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761753085; x=1762357885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5ZanK+qIbdS1y0Xd1H0WJwWTeFqf0pFYX63nf1APa8=;
        b=i0xNNR0JRRuR2/WCI+syogoE4/YMozJQ6+hoy8izSLDP1OuPBbJ1iJPMkm9AZJYmKe
         Y6jnybUtz+X2zVZp44l8n/eQwHGAtYIyVxVuntkUoywHEIDEyvkaIXzICOnwnzCc9ool
         yCUZaikELrKxUosmjrqmMbFCk/aMs325WuIIAEWVi0O7yc4BOeqeolCE5pC2VfZRJ3N3
         qA3sfDI1FNRnDSF+hG3gLOgy6NfVmdwvv6doDWAhTNhDSXkh3B9RIDTq7mqcd4d6DaNG
         bslyNX+bYe4fW1UbsCyV/+G+MhQhRj0t+EsBiN+lwXPFQ2To4jE1xVJ9JLvSjQPFfpqO
         0iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753085; x=1762357885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5ZanK+qIbdS1y0Xd1H0WJwWTeFqf0pFYX63nf1APa8=;
        b=rzvYSyVpGNGmxpbkddttvE+z20Ljnqu6emJ7BUztMU6FTs8keSCdfj5fdIwasYwVgZ
         paV8OKzQganltTbuyloEaMIwkAZft2xov3bY1LgbVVWizxL7jYu8WOsAPDFATQlHmzw+
         R/a0ZfHIi9hlHRLtt7ZOWBh6WtX4YELELoGK3Fx4Wi4G9u4Ys/vulFBf0DpanCaDS7wD
         4BIogFr+1JXkTweCMi4T5xWQf3+/5hn6Bu+zTTkff3RaF8IYNGc/WdlRvsZmi1Chpni+
         wEITg5Ynzk9SIpLdp2uDqPrtRixWPCLQCTkXGXK7cBDq8YIjVDi0QTvx9oizL2VqjQBC
         MNPA==
X-Gm-Message-State: AOJu0YxxH8+bqz9NfYGOcE4tYV89eVMpYm0iVAngWWfIPO4AQC0WTIFJ
	cmjSXb7VODp7HJikqxP8IaM8Y24X/zkZCEPX8aDGp7IcsYFJCF6Y7Ca9iEPWvVaTly16OXkHoHa
	Oil3vhQtKuNgBuipRxsa4FF3MvzjY5+thu538cvGE
X-Gm-Gg: ASbGncsjZc6i4k3AmwU1jgzH7l50Y1m3xQGy7lIfR2ToX6f8XlB4VKgJ9A3uhHl26lr
	s3AcwB5AjAb+tl39YY4ZE47sq7UWvkBsPknM5tC5/WPGFGdJGSD98cJ/hjnnqU0u8acqZMxv/Ow
	sg7juZlJzF695pbrVS3u7Ee0xfmEJC8YRONJxEksZTFcoZsyKAGiD8+HNcL+fMmXXkF0qAzDy3j
	IBcjQEqAy+xCp2moynockzL2tlknatbUWspKLHDbusT/3DcX543dStrHteJsNo0w4kqvkBezFHG
	XkbUfW649Dfhig==
X-Google-Smtp-Source: AGHT+IFRx6FewEYdw5JrBQ7WWIgIepepPzoEOpUGJEGwgkJbFAiqJHPWXcOFAovdJPumnLppL8nmMeoo0aqXydkU4ps=
X-Received: by 2002:a17:902:d50e:b0:292:b6a0:80df with SMTP id
 d9443c01a7336-294de45c881mr6778855ad.10.1761753084488; Wed, 29 Oct 2025
 08:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aPkivW2WoySU1Zkc@suse.de>
In-Reply-To: <aPkivW2WoySU1Zkc@suse.de>
From: Ian Rogers <irogers@google.com>
Date: Wed, 29 Oct 2025 08:51:12 -0700
X-Gm-Features: AWmQ_bkPfy2On_5x92MddqIyt9lSnrnRp05PkxSAoBIyhr-qrvCx5jKneAhP7-E
Message-ID: <CAP-5=fU4y2y+pOT590GZG-A+zO5YdAAzUyPgUX5RTji0nh6Z+g@mail.gmail.com>
Subject: Re: addr2line performance
To: Tony Jones <tonyj@suse.de>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 11:30=E2=80=AFAM Tony Jones <tonyj@suse.de> wrote:
>
> Hi.
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218996#c1 mentions
> "there are proposals to move this logic to being from a library again.
> I think the addr2line processing attempted is valiant but ultimately
> using a library will be best" (this was when LLVM addr2line support
> was already present),
>
> Obviously the test patch mentioned in the above bug doesn't address
> the underlying performance issue, only better classifying a timeout
> error.
>
> We have a customer bug complaining about the performance of addr2line.
> I'm seeing cases where it's taking over 20 seconds wall clock to
> resolve certain addresses which obviously causes the io_timer to trip
> but the performance of the success path isn't great either.
>
> Obviously BFD isn't an option and (for various reasons) we can't use
> LLVM for this specific distro so I'm looking at the performance
> of addr2line.
>
> Can someone point me to the prior "using a library" discussion
> referenced in the above bug or whatever the current thinking is.  I
> couldn't find anything searching the archive.

I'm not sure there is an explicit discussion rather than discussion on
individual patch sets. It is something that comes up when fixing the
text parsing of addr2line, something that is particularly problematic
because of inlining. It comes up wrt removing non-distributable stuff,
most recently in:
https://lore.kernel.org/lkml/20250823003216.733941-1-irogers@google.com/

Wrt the bug, the --addr2line option for `perf script` is merged:
https://lore.kernel.org/r/eadc3e36-029d-4848-9d69-272fe5a83a26@foxlink.cz

There has also been clean up into how the addr2line implementation is
picked, see:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/srcline.c?h=3Dtmp.perf-tools-next#n117
which came from:
https://lore.kernel.org/lkml/20251005212212.2892175-8-irogers@google.com/

Wrt dependencies, I have been pushing these patches that use dlopen
for libLLVM mean installing libLLVM can be done separately from
building perf against it:
https://lore.kernel.org/lkml/20251007163835.3152881-1-irogers@google.com/

So if addr2line is the problem, perhaps use the command line option to
switch to the llvm version. If that's not fast enough, and you can't
distribute linked against libLLVM, some feedback on the dlopen libLLVM
changes would be appreciated!

Thanks,
Ian

> Thanks in advance!
>
> Tony
>
> --
> Tony Jones
> SUSE Kernel Performance Team
