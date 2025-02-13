Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB53A28A2B1
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465801; cv=none; b=sqZ3+ex2+2k1N9pdTO7e7f4JtAMHmrqvsUy/GvK61idpEmmLjgAekwlV/Tnnx28qmSTBcvHIyI5Q9c8Ebxx629Ir32I11tqUQmP+kL+H91LtrATR0K2TSpxm1xbb6a4diOVXOmtjWwoUyX6uCSNGDoH8Y0LXRxLe6xGCone5j4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465801; c=relaxed/simple;
	bh=dcSbKUSUgV1vC4nrEBq2v2INp3bnxP1nnb8XGe6b7MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzcQZ5h9+0d+zqVZcsoJUXfS/Z7wuaoNYuXd7iXCYPwRUFZ0CWsklsCFxFZE0LCqwA4RR0L53qywX4v1sDOqHfRiyJsJOIWRwTC6FhuC/cgL5Dhw+GmLnksCaxKDbZ3cdl3/SOFT0Kduya0vIr3IsnGhWyoTRHdXLBmW0RLOZf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EI68Xw47; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EI68Xw47"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d1925db9e7so88215ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 08:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739465798; x=1740070598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WL3kome18vk8UhyUwihjEYjzZQ5S0bMqvxiO48PbJTo=;
        b=EI68Xw47BHGWjqghPGXLQfSrPy5yT90nGnwUJn3AlMqfEKbBHcCIPXXEoqIoiKk6/k
         5OiJynNDSckMK98mSXST9dHif0XVOKNBeqWNmq/TMOhMdPYsFmw4Nt6NQcDG5F9KLI6E
         IszxesXyz89s89qQSfRXL+Bm1bVnGo9HK8e3OawF/wDshQPX/TkNu1Lwad6lHJcyzJkS
         vIJzlAXgYaey2vfe2kuug1p3SfgbRpWFcQ7hJ4BrWTbFaqAdy2aJQ83iTEe3LqmTQqMr
         ewx883+wgRkUpNVdKQuUXSFfEYGd7f5JtxECVWGzSRUR0AfD+Q2kRBEazbPPkKauFotA
         tj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739465798; x=1740070598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WL3kome18vk8UhyUwihjEYjzZQ5S0bMqvxiO48PbJTo=;
        b=c92ov0buSmXNyE4DP/15so9Xm+gTmpHS9Y7pbNUTgXerrBofSafXgQ/Ag89qPPSTOP
         X1252yh3ltCyyxAdehG8ZotLON5wZHC8SijXAFbcz8CqI/OrOiv/pCDYFpjIc1ChnAg5
         97JyJVMwyaECUpwD6OH9rf1obc2MrqE6TWuiBIu6jjK8rrWBoHwwW1ceEAZD/Mios5c9
         CDtTojeQsZwSVL2y4w5gAxNGFcQj4MdLO5qYmAZ2Efv6FbhFEVUMuFhLKU0zT+2wCT1d
         0a820srP97v5pnA3AZd6gunvstRSBArVvd0WaisDCeA7684tjOZBCuvISStz1RLdiE36
         MrCA==
X-Forwarded-Encrypted: i=1; AJvYcCXyMoqEHoSOUOkMH77U0sLNPXrBeN8utuHZeyxjRAtSGVQTCNlivoxc0JjNtaGLj25IoWVFa5zO8M29orZTCfXR@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb7/Zju8a5nY3tVWUaExKtgiqirc/M/Ou04FcIMHyOt9GLw9go
	7uQyEM3xtbPBJtRiWcmqHQV/OrLglWigbUM0DuQYDXwSjhzpDV0oNYIIyKyTWTq1EEaSmHdhEFw
	IxbU5opHGCZFavSdZ9eocK+8LU/2eWVpPDRwi
X-Gm-Gg: ASbGncuzp8W4DKWJ+iw33DZFUm4sRJe0+H5vMo0xf5VWZ3W9e2yafV/Er3rt/xclpXq
	xkAgIXE25U1zFvxJ2QvCqP+ODdBC23L++eCbrikG3jJNf24OoZSfEOez4lRWLtJBaQBWv/puCLq
	6ATCmBgNByrOS+hVFYi87Bmv9S
X-Google-Smtp-Source: AGHT+IG6fZiFd4EhQIWkGpNMjg0uFzMn3guOtEnraG5nq7MRHteC5pWqbBK5hK3pxVWDDicVuAxJcYxz9pGwfEC8c1k=
X-Received: by 2002:a05:6e02:2405:b0:3a7:a468:69df with SMTP id
 e9e14a558f8ab-3d18e1e6710mr3476685ab.3.1739465797683; Thu, 13 Feb 2025
 08:56:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQCU67EsHyw_FsqGbRuityahZTSAtWzffU=hLUJ7K=aZ=1hhA@mail.gmail.com>
In-Reply-To: <CAOQCU67EsHyw_FsqGbRuityahZTSAtWzffU=hLUJ7K=aZ=1hhA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 13 Feb 2025 08:56:26 -0800
X-Gm-Features: AWEUYZkoIohHuSrn3oMMwROWD6Hky2MT7RA-4UOAdTY_hlR22FmKgO7HVKb8kHc
Message-ID: <CAP-5=fW94Q2i4EHGoM7kczTZUsfmD4nK4sAjVtcLzqZy29Quxg@mail.gmail.com>
Subject: Re: perf: Question about machine__create_extra_kernel_maps and
 trampoline symbols
To: =?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 5:10=E2=80=AFAM Krzysztof =C5=81opatowski
<krzysztof.m.lopatowski@gmail.com> wrote:
>
> Hi,
>
> I'm investigating performance issues with perf's kallsyms parsing. Runnin=
g
> `perf record -g perf trace -a --max-events 1` on an x86_64 Ubuntu 24.10 o=
n a VM
> (perf version 6.11) showed that about 61% of time was spent in
> 'kallsyms__parse'.
> Total execution time was 370 ms. When running latest version from
> tmp.perf-tools-next
> It's 530ms total and 38% in 'kallsyms__parse' because the old version
> doesn't have
> bpf skeletons enabled.
> During regular execution this function is called three times:
>
> 1. In machine__get_running_kernel_start - searching for _text
> 2. In machine__get_running_kernel_start - searching for _edata
> 3. In machine__create_extra_kernel_maps - which is the focus of my questi=
on
>
> Regarding the third call (implemented in tools/perf/arch/x86/util/machine=
.c),
> I notice it searches for:
> - _entry_trampoline
> - __entry_SYSCALL_64_trampoline
>
> I'm puzzled by the dynamic allocation in add_extra_kernel_map, which seem=
s to
> expect multiple __entry_SYSCALL_64_trampoline symbols. This functionality=
 was
> introduced in:
> https://lore.kernel.org/all/1526986485-6562-1-git-send-email-adrian.hunte=
r@intel.com/
>
> I've attempted to trigger the trampoline logic in two ways:
>
> 1. Using the example provided (uname_x_n.c), which only recorded these sy=
mbols:
>    - entry_SYSCALL_64_after_hwframe
>    - entry_SYSCALL_64
>    - entry_SYSCALL_64_safe_stack
>
> 2. Setting kprobes and kretprobes to try to make the kernel create these =
special
>    trampoline symbols, but this approach also didn't work.
>
> Questions for the perf developer community:
> 1. Is there a reliable way to trigger this trampoline logic in perf? I'd =
like to
>    create a perf test for this functionality.
> 2. If machine__create_extra_kernel_maps is obsolete (since it's
> x86_64-specific),
>    could we remove it to reduce /proc/kallsyms parsing time by at least 5=
0%?
>
> I'm working on a patch to simplify machine__create_kernel_maps to call
> kallsyms__parse only once. However, I would appreciate guidance from thos=
e more
> familiar with perf.
>
> Side note: Could exposing the kernel's lookup_symbol_name function
> (from kernel/kallsyms.c) to userspace eliminate the need for reading
> /proc/kallsyms?

Thanks for caring and your analysis! I think Adrian can best speak on
the possibility for performance wins. We do have a kallsyms parsing
benchmark:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/bench/kallsyms-parse.c?h=3Dperf-tools-next
I was curious to know if the regression is also visible there?

Thanks,
Ian
