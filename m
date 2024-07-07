Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055116026A
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jul 2024 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720372399; cv=none; b=RT2208jG/sbdHw1qP4lP9c888Lwh1Arj3GUTsZSdVI1rv2sAccUL0JrKEFmgQSulKyvDLJt73wknTBuOy+iuOQDw90XqviIXJDfCC11Kn4Lit96xkdr8BFMGHufffCohokTp4W5WSD+9/D1Q3vH+0E5Dny8TIYMKKC5uz138e/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720372399; c=relaxed/simple;
	bh=J0jrxKdDMr2AdjcCVmd2BpEvtYrwz3Y0g+i6h3TnlkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKOqCKk9HReIA/klmTsqcgElneWcniOLeESoWeyD8oIx0SOQ+QNcJ4kx0hhzt/WemfqLjMzlp+TBVXpMhU+qZ0zzyU38V7mdpWMwFbcZ4yRmEHegc0kWg3QACb6uYTXFBV9XPugoiO2cGTFAodYeJ6I0UbXMWmesxeeKj58NplU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fN0lFyXD; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fN0lFyXD"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58ba3e38027so3646750a12.1
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Jul 2024 10:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720372395; x=1720977195; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mjTPh09wDczJZgWa15mFs+a1MJQ6GutluL7qqV8IXRY=;
        b=fN0lFyXDF+ZChvByKU22DFhTcyz7KlcMQeBOdrzqW3Z0hHT3uvCXbEHo7kbcILPXqH
         A4fteomYdxzTRq4tfqpbKbu5Jm+/TXo8bGitYCmHzZY28EjYprqgzsKNWHfLj1H6pfWw
         384rLHUBK5jJMHYro6hXO+U/1tNEJlNV/+NG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720372395; x=1720977195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mjTPh09wDczJZgWa15mFs+a1MJQ6GutluL7qqV8IXRY=;
        b=gmyD3/dlqnTcFlk+6TJoj+NVYFfODghGTm0joqRni3JTfb7xbQ4S3hCwf8phrqGnw1
         3nX8y/RcJUSPRtTXc9FDM6YeQYtDw96tABJATZ1P8dhC2yf3vyvUp+GLrj3Lio0MwXHi
         /PtnegQoM20vVB+ELWkaCMlh6J0XZdheXGD7uDHmJO44KLTMe34BI6dIj9IxTIGm47o1
         Bwa4TmdoU94gTiR/V5sPba8L4oLTttETVNQNQiMFaetOOHaUpX2b7hUj0CG6gJuEMKDJ
         0xe6YxKSMpEBbaRXciBUgDmWfU8Axn9EJ5wyh+x22CZDxo+EmPrUQGyvJp6oS3BE2jRp
         QFCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+J+TDoy+9uyFmqfacsEp0bTXS/gReBwD5/TQEEEthlssXObp2Gmv66m0kwDnBNSefk4VLhrQ1NmauWqn+Srf4bD1IYIm7QSZV/K9IbrYIQw==
X-Gm-Message-State: AOJu0YxZShlYeZ56mNr+4h3Nzjf7NrKOCSAhnOfVkWYgJ2U5o20WnbM+
	wsnYOKGflky/Zw+5ebNtMRt0WrLfOCLcZJ0XAUuCCgY8RKo4RcbipizMT7ww44UmTO0OQAfDqts
	iKOY=
X-Google-Smtp-Source: AGHT+IHsPl+pOG3X6JiHBTBqsf/NPWe4WJjS0vCg/K7gSm0Nx3zncrSyxbmq3NbcIZid1NeXTQHMLw==
X-Received: by 2002:a17:906:f296:b0:a77:cdaa:88aa with SMTP id a640c23a62f3a-a77cdaa8b23mr518630566b.4.1720372395008;
        Sun, 07 Jul 2024 10:13:15 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77b6c8b69csm315470766b.45.2024.07.07.10.13.14
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 10:13:14 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77b550128dso398131766b.0
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Jul 2024 10:13:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWv2CgyOH6ostBmMBTpXA5uSS5r5K+mblh0KthAAn2TNCi1SrpLBiOZ1ODYrbUso+u3r0+rS3dJLhWcz0sWbObdA8N8i39MkQDzDwgCQp4DwQ==
X-Received: by 2002:a17:906:22cb:b0:a77:eb34:3b42 with SMTP id
 a640c23a62f3a-a77eb343ca3mr222219166b.12.1720372394201; Sun, 07 Jul 2024
 10:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjT_zSfzFVMyhv=Y4c94o2GDed253dV=TLyBbSuPdGzLw@mail.gmail.com>
 <6fb1197f-f2bd-4d80-a14c-526a1fad09a7@arm.com>
In-Reply-To: <6fb1197f-f2bd-4d80-a14c-526a1fad09a7@arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 7 Jul 2024 10:12:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEg6FNqZgBQ+_sT_xRpm6bXnzBd81y-nn3_dr3ZDQ74w@mail.gmail.com>
Message-ID: <CAHk-=wjEg6FNqZgBQ+_sT_xRpm6bXnzBd81y-nn3_dr3ZDQ74w@mail.gmail.com>
Subject: Re: Performance of 'perf'
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Jul 2024 at 07:25, Leo Yan <leo.yan@arm.com> wrote:
>
> could you do a statistics for the perf events?
>
>   perf script -D | grep PERF_RECORD | awk '{print $5 " " $6}' \
>      | sort | uniq -c | sort -nr | head -50

Well, I think that command is interesting. Mostly because it seems to
have the exact same behavior as "perf record" did - it's taking
forever.

And it too has that

    newfstatat(AT_FDCWD, "/proc/self/ns/mnt", {st_mode=S_IFREG|0444,
st_size=0, ...}, 0) = 0
    newfstatat(AT_FDCWD, "/proc/246780/ns/mnt", 0xffffcd607988, 0) =
-1 ENOENT (No such file or directory)
    fcntl(8, F_GETFD)                       = 0x1 (flags FD_CLOEXEC)

constantly in the strace output while doing so.

Except it also does

    newfstatat(7, "", {st_mode=S_IFREG|0755, st_size=6550752, ...},
AT_EMPTY_PATH) = 0
    pread64(7, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\2\0\267\0\1\0\0\0\0006A\0\0\0\0\0"...,
64, 0) = 64

over and over again. Sometimes the fd 7, sometimes it's 8, presumably
there are others too, but the fd doesn't really seem to change (and
it's not opened and closed all the time - it's doing the same thing
over and over and over and over again and again and again...)

And it's clearly trying to look up the executables at the time of the
profile, we have

   fd/7 -> /home/tux/.debug/home/tux/bin/perf/22d3e56ba06ec670dc94d4d2e5c8171754bfd952/elf
   fd/8 -> /home/tux/.debug/usr/bin/gcc/21252acc9fddc6654518fdd490ab44f7fbb5ed25/elf

Anyway, I guess this will take half an hour too.

The sad part is that I'm absolutely completely uninterested in this
all. I asked for a kernel-only profile, and the way I then tend to
look at the result is with

     perf record --sort=dso,symbol

exactly because I don't even care about which process it was that did
the system call, I just want to see what the kernel load was.

So all this "look up file details for every single %^#$ perf record"
is completely wasted effort.

But it sure takes a long long time.

           Linus
