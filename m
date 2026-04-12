Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C7F286D7D
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 01:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775956460; cv=pass; b=AFadwPfeZXAekZsG3Vu2tsYgWzW8A3XsTqKfwXblgSMP6Wkw8HhRl2ws49ptOYKLaq9aOdc/6hzWBSZw62q9tzzEGu8m5oKH5b7jhEqc0B5pzPoapz31OFBZGCqIamuE1sju/g3dcHy3czOUDkWaJHQMG4F9u6q3yB8bTuy/P9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775956460; c=relaxed/simple;
	bh=Ubu2BKqCV9U+N5NgZ9KEZNJCg58RCPUVHhvzRbPycMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFFtpOiDKHw6gdi8tfepg52TUyFS1MzMdgZClSVhiNJGr9vBfZ1KT2ab1KrgHcSLWG2PVE0AsHsOE2CG/lKMO6MJS166J7efRBEJAoGtrDBwmgKoeu+sLhuB9WcJ87iCSMHAwx/B9+doaWUT4ww7DAuJVVLYffzvFw2qp/xuyHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nj/e2U4k; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nj/e2U4k"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b243198058so277025ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 18:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775956459; cv=none;
        d=google.com; s=arc-20240605;
        b=cqmZEf66v6qSs9h1WSdM9I/wiXRQnCW9S6nIrGd0jyo3abBT8kQqxCrtDrrBHT4KrU
         xoRlxscLdEa410ahmVQezdXsdcjEjhtlrsb/YvmeKvGGT70WAr/NSp+wXTePT0fkGKEX
         eoRGGqPyyA9WIWBIMuqVZOs/moS2B8sIoQEQHtge7GF8BJMpGNnQC4ztTS4R8NYRL/Y/
         UxY8M8EA40Z79gI3BxahN65ZoAUVh3hdgJQGKzF+DgLJyqgQfrFJ0g4oNh2gHWi9GOlx
         FdQFKHIn7Tsj8luyPIPcVqFMKcDH7VdfDiYqlhMLEaxfrjTBMjt6s3zwbQ7urPHjqId9
         rJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/AZhzxqPX5mqnjiLPy+maGxKzzx2/k1Y1sKM4rH1bFo=;
        fh=7h0izHys8KHgVwAHFbDqh8DXgNjj235aXcN4iZY+6bA=;
        b=gP4bjPyDO1TYILJ4D/pROdWJvYQvo0y+Zk9e9awsqtXkrjdA+cdAyrVe6VkWcf1jW4
         QZb95nsMRxn8PH/KDjn6GD2VhvoM8e7hN4UC2PeGDLxSURzHCdWQtISP67h4JaR5t6W9
         jH98W9LDlOQUkas298vQvVHtbaQQW6jpeb+kOgdIYwrlBYEryxVnPw+iIwDst3+9jGM8
         5t8ax1tfmk1+QScCVFsKb+c8y9t5nYbT3/623zvwB2sUpdvsSjFwL2Gobmqf6K7vnUnV
         1CsDJkEC7ohq4qzn/oKyaYyQZylJw5FOoXw/MicwcvtLPa2+xS1a10Ni5fwAI+JzfWxW
         dghg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775956459; x=1776561259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AZhzxqPX5mqnjiLPy+maGxKzzx2/k1Y1sKM4rH1bFo=;
        b=Nj/e2U4k8PYAazx0m5HxvDzn3HLND+7ehfV84ziuYWSZZtVTYTfPyTSNqXE/u6T1qL
         xSfBIdmLP5EPqs4HyI/95CYwKsyyjFk1LKjYYQgZP3bkHfYh2Z+OJaVGP7pceeUcSwPR
         y1gGiFpHT1klnz3T/5q5nNk6+YuGWeLMcVzTb9QknlTXn+/ZC+Uy642GUeM/GGCku7Ro
         W0V05MOmOEDeBlKFfDsSsu30HJmNmGmlnIF9Me2rvfGyJLJ37deMllwTQ6RG+4Xs1Jt1
         vPTKqHB5yYpxVonuhZhB6aRmgAQMHkFelxtUERBY/d2C/Tz7zA9TShRLDR3LBuQYCecI
         MPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775956459; x=1776561259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/AZhzxqPX5mqnjiLPy+maGxKzzx2/k1Y1sKM4rH1bFo=;
        b=n6wSVU9F+BUxvbYaOzDrtb8LxAxFlDdK2wqnX/24/RkkYEa0f6CuD8sb0cnhvEsyPZ
         PbzYozg/iiGGsfx4ga8O14DpD4JNMYHOT0TTBSyC0o9177jThVRXuJbFfn78U2G2RMMb
         OpZFlbsaSRMYk2YbITGYwe2+VD9kEKXFZnworP2LUZG1aj7Ae3Mjfiq30xJxQxkZaxqC
         XOt0AlrD11HvzKJfseeyVVMA7Ey78tVBNMGPbXhzcARYzvoJ4m6Peltg/3Q/UqY9iADk
         XbjACY9ZIEJEVmLjD6Ud8hICc3GleCYOE9zTqcZdOejooaws09rZgm62lScbD66T3L18
         QgRQ==
X-Gm-Message-State: AOJu0YwIQl4QumC7IB+9HhYvUzWGALlOcbVlXxC/0qXG/0l3Fos7bIiC
	rFcx+GINuoN9+keUQbiS2ChEySBqv3hBiGwwqWRHEPYave1km17edq0p6sGhIEntendZhCwmUOM
	zypGSz8gyKnXrEtnXEmtmvCLCSznkd4jZ9qliD6eF
X-Gm-Gg: AeBDieu1o1gWYQWUHhyyFvQh4Ht2KbGUC3tL4xL8boWJHRom8u6mWp6GHLuRw3vSzWR
	2xQLUsU4JtXBVoSgDZkIJYpG6owyY+A+lxp+7aC9/gDJ1xst8trf6z+BUc8n8um/8oi3afYp3ey
	P2rkJ3S4IFL6oTYIOXzYWxKgyem+kwfDcjEcdHOhVvUbzEv7Spdl8cIKBPxdMrDpPoOx6e23V1o
	wO1q61KKD+8YTMjJUxD9KO0Sqer/T1SolJmlzBS5IC6NPWGxbZUJfq0df0I+Hky6JTnEbAyKCry
	PjF3fhbt4w/Z75TdgC4=
X-Received: by 2002:a17:903:2b0f:b0:2b0:5e19:1862 with SMTP id
 d9443c01a7336-2b2c8c74a19mr9132395ad.5.1775956458063; Sat, 11 Apr 2026
 18:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411193705.735269-1-irogers@google.com> <20260411195423.4C949C2BCAF@smtp.kernel.org>
In-Reply-To: <20260411195423.4C949C2BCAF@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sat, 11 Apr 2026 18:14:05 -0700
X-Gm-Features: AQROBzCzmRC6_AJAS-FddXGPSNJ2tzJQjoSrAk5fV3Wn_jV8Rz-zjmDJ4IIO1Rk
Message-ID: <CAP-5=fUvMcBbHTumUVRmxFA7OL6bBP-bC9SUeWHDi5XQJ=ZWkg@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Fix inet_pton probe failure and unroll call graph
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 12:54=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 1 potential issue(s):
> - [Medium] Unconditionally requiring DWARF call-graphs causes the test to=
 falsely fail on perf builds lacking DWARF support.
> --
>
> commit dbec7073d294917f7866e8ea3a6b39004a7407ad
> Author: Ian Rogers <irogers@google.com>
>
> perf test: Fix inet_pton probe failure and unroll call graph
>
> This commit fixes an issue where multiple identical event names were outp=
ut
> by perf probe when creating multiple probe points, which broke subsequent
> commands. It also updates the backtrace collection to explicitly request
> dwarf call-graphs and increases max-stack to 8 for all architectures.
>
> > diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/to=
ols/perf/tests/shell/record+probe_libc_inet_pton.sh
> > index ab99bef556bf0..eca629ee83f03 100755
> > --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> > +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> [ ... ]
> > @@ -40,12 +40,12 @@ trace_libc_inet_pton_backtrace() {
> >       echo ".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" =
>> $expected
> >       case "$(uname -m)" in
> >       s390x)
> > -             eventattr=3D'call-graph=3Ddwarf,max-stack=3D4'
> > +             eventattr=3D'call-graph=3Ddwarf,max-stack=3D8'
> >               echo "((__GI_)?getaddrinfo|text_to_binary_address)\+0x[[:=
xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
> >               echo "(gaih_inet|main)\+0x[[:xdigit:]]+[[:space:]]\(inlin=
ed|.*/bin/ping.*\)$" >> $expected
> >               ;;
> >       *)
> > -             eventattr=3D'max-stack=3D4'
> > +             eventattr=3D'call-graph=3Ddwarf,max-stack=3D8'
>
> Will this cause the test to falsely fail on perf builds lacking DWARF sup=
port?
>
> If perf is compiled without libunwind or libdw, running perf record with
> call-graph=3Ddwarf will exit with an error. Since the test script doesn't
> appear to verify DWARF support before running, the test will report a har=
d
> failure rather than gracefully skipping on minimal perf builds.

Since perf probe requires libdw and libunwind is deprecated this isn't
a concern.

Thanks,
Ian

> >               echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bi=
n/ping.*\)$" >> $expected
> >               ;;
> >       esac
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260411193705.73=
5269-1-irogers@google.com?part=3D1
