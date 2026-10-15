Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD76488232
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792099601; cv=pass; b=DjOPjOvLuk7z1cFckPbPU0reJlb6mtHJ2rMVZCvoDyX3ywXZXPBLYe5R/ByoCnRApALhd14AXjdLXYBdP3xLEX4iLjBhcetx7g0S1/lV9hYAa86xRluQS7AN31LxdRdDDfkHjiXdm869DhxdHNs7zMhMqECp8YfLwWFkWZgKuNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792099601; c=relaxed/simple;
	bh=S24dOVcDoMu01ibSOw1+bNFyN8uZ1WIV5X5lG+8sUTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttcNj5MKmK9ioM+ErZyGhu6/6/7pjgwvPFo3IMP+c18/j1a3Y5OO/kuzFejVG9tinsiOjx9c6lK9+f0XTwowo6kd6o7ch0l0Uidrjy6/CYpX/BW1jWY6a4lE2jqnwVkaHPjQnkKIuGoq11HS/PTYQ2d8paaWkTVEXLT+PD8Ju1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oKrckloV; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oKrckloV"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-535f598d126so38671cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 14:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792099598; cv=none;
        d=google.com; s=arc-20260327;
        b=dkUqgM0uLah+G11Nz0qUReIOcCB34CR3VMwal8JsuyQtkQui5F440hLB6FynRPyrxI
         fB9JCcboRkYMo3r4hZWrROXyVPsnJ5hk5d4VKPCLRZ1bDR8rhZ7nvLJ1OThx3Mqvi4Ox
         oksXuozDNsnGy97Nqb1dRWGY81+kYYVE0zPYbPtbCBAaeBD7ohzxzTUy4067b3VhWFo7
         Gi5xThYiMYDuWgk/hI2oIaeRE5ckSNOIB3Hitqm7fTfN9gxrY3BGkjB96lagWdbJghWy
         2RhZKHc0w+2RnAKTWoZY5fJgVKvW6XqvFV9M213U4RDx44+5cXmNy6qr3kRX608/5ARh
         1blQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OgcgdziUoCAQVTSOyr0xkG5j6Rc5FznnZ78bB8A0JZM=;
        fh=jPYKDKMl0vNAoWkmcmh39JhRjAhIo2f+whASGRP5zLA=;
        b=Yc7WF0EFt76wd/2VbQKSzA3iGMHmtPmSmoWy5gsiYAqv1muWnX5dPL96YykvmoNrmg
         21SlQ76GHuYBSiPtDNfPh8z34keZwzduhHWPco1Alil1t/J0KNvbW5kz72cRTGKmXeVx
         7g3TOJ68C4AHOBIWcCXlNP8NerecHr0Dkuz7WsiOt0tYpFovIRV+yKiXCIuAQYFm9JI7
         jXrZxdKFuBwHxGv+rGlY6XZYaivV0yiRA0w3jwd/7U/ei3UVk7SjJ97ugNUVkBt4fYml
         ynTdO7g6FuCv9Kvw2dblFav58vdi803tuCNhYOtpp+S6F12w1scPANRIPNYDvWvQx03G
         QAgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792099598; x=1792704398; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OgcgdziUoCAQVTSOyr0xkG5j6Rc5FznnZ78bB8A0JZM=;
        b=oKrckloVPBkqU275fV0Dp0vswVpn9xI3pbBF0luDu5tSShg5dkG2YFZkgn8FRW6zce
         SC6ce0/U2RwBMT7UdzqImKj7Zwk5S0nhq6OPLHt7tgXeMAaz7CD4ePFHyCr43fJxXA0Y
         2jw5Oyrx7g+KPlc3TkA9w3oG2VFtEizziz3jHzVGNBWpDorHwNjHlbHymuYcu8CVQyzI
         mvaz+FJ/xCsHJnZ4uSZEhOWijfOu6wwnL3wJ1s+dxyrL6peIWJod70X2U1Wzemtm1L0N
         CFqg8wwGGvxXUvAYmKzgnxuDknpyeEjx5L1091lujDB82PDgTH1VZb4IgR3IDFsb64PI
         K/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792099598; x=1792704398;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OgcgdziUoCAQVTSOyr0xkG5j6Rc5FznnZ78bB8A0JZM=;
        b=X1iuLN3vYIjpRHGUiWx0e59pU9ehQ32fn8UQm8sTXv4sX/2jnrlZ1snZa455VQUdt1
         iGbeh+pXB3IPIwuMzV6jpvml9kXba45uMBzlRdgk2x68HAlipKXWqcnxoujog/uiwSe2
         79ufQ9nP7LwTbqFZig/zlTXZQT18xiFaE6AAWYUs2RLgc5F9HShYns0L0KtuCrRO5Qfy
         UuGxIaqKrmC8fn/8MFum2Hr1CPyByOIRphwkxxevvSVgGunkU1tL1ccZgSyiKen1GCkd
         CuD0V19gWabYqWlb2IAxy3v3WP/QQ256A9lbPqTazRifDNEHZOckyXM+1jGLe6+DMQDK
         DQbg==
X-Forwarded-Encrypted: i=1; AKwUvBwsC62ZsI/6w6JHMnvYztichKe2mBJiHaqsb0fkwMOGxolhiD2s7qjfKr04d34ksHxAhhkjFvQctwrx21gSymh5@vger.kernel.org
X-Gm-Message-State: AFq9FYI2vfveFo06aY6vOWHmRdPGoCJAmUFIO7gnWP9pkPPl9fR9CKSM
	eQDczHoBQcz14FFv0cEEOu1RJBQq/VaLWgeGbdNhZTzKv5qUyFO79l7SSliK34wPbcoS/UP4eHt
	0+ftAFJBnUrKytWFixcB2RNkOjE0PP7OUsiAumJvS
X-Gm-Gg: AYBFou3V3wCO7FCSlDdk2EtffPyh4rf7cBm8SnjYpNUUkXgg/py8dHxw5ySLdAMcbSE
	N5GpYx8djAN90/gutAhK9+e3sVwfZrr7jEzOiwwZuYWZogl+TRsk9dbSj7QLm7Ajl6BhptlL59m
	OF5wBtKMEGT00t66ICG8PQQbMTjDxLs/HW40JHAKxChxSjYqWwCPCwAYTLhDyrEnxGOMiyorB/j
	PQBcpwQFfQ/9YXT1a4nSUc4COYnUG9oaJb/YVdY+ROpkyiEbJ0yRj5qLkT+n9+48aRl9IINFMwT
	U3/obarPNlYO6oTPhZ0ZTEpxFTDzrFPPktHS09D28W+WaElJxVQT+zwv92le69Mdbm/+Y1dLU5J
	L0rUMXNuxuQ==
X-Received: by 2002:a05:622a:580a:b0:535:cee9:78ee with SMTP id
 d75a77b69052e-5362b4d91b9mr2154821cf.15.1792099597789; Thu, 15 Oct 2026
 14:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011233647.2454648-1-sashal@kernel.org> <20261011233647.2454648-4-sashal@kernel.org>
 <CAP-5=fWFY-tpJz2vcBZvurwdZY5gwd8cuTemE9q1rtZ0Vi0dng@mail.gmail.com>
 <20261013170854.647305-1-sashal@kernel.org> <as6SxXELnoIJenIX@x2> <atEo6aIQbgww4G0y@laps>
In-Reply-To: <atEo6aIQbgww4G0y@laps>
From: Ian Rogers <irogers@google.com>
Date: Thu, 15 Oct 2026 14:26:26 -0700
X-Gm-Features: AclHuK-FmTfmnNngMCTHGyBJ-W37rLbDe_VKRvUNDuHeCzq-aOwVNF9WYcEKmR8
Message-ID: <CAP-5=fVq9rpDm2v8EjrQBVz6aV7SLaYzAwncQBwut0QDnFJ-kA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/6] tools: build perf in tools_build
To: Sasha Levin <sashal@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org, 
	Namhyung Kim <namhyung@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	linux-kbuild@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 12:26=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> On Tue, Oct 13, 2026 at 05:21:25PM -0300, Arnaldo Carvalho de Melo wrote:
> >Why is that difficult to run:
> >
> >make -C tools/perf install-build-deps
> >
> >To do a recommended perf build deps install?
> >
> >That would be useful as it is what we expect users to do.
>
> That's what users do, but it wants to install packages.
>
> We need a path for unprivileged builds on bots and CI machines that can't
> install packages, and many of those builds are cross builds, where perf n=
eeds
> the target's libelf and libtraceevent rather than the host's.
>
> >If that is too difficult, for some reason, there is a minimal build in
> >tools/perf/tests/make, that is tested since forever:
> >
> ># all the NO_* variable combined
> >make_minimal        :=3D NO_PYTHON_MODULE=3D1
> >make_minimal        +=3D NO_DEMANGLE=3D1 NO_LIBELF=3D1 NO_BACKTRACE=3D1
> >make_minimal        +=3D NO_LIBNUMA=3D1 NO_LIBBIONIC=3D1 NO_LIBDW=3D1
> >make_minimal        +=3D NO_LIBBPF=3D1
> >make_minimal        +=3D NO_SDT=3D1 NO_JVMTI=3D1 NO_LIBZSTD=3D1
> >make_minimal        +=3D NO_CAPSTONE=3D1
>
> I tried make_minimal on perf-tools-next. It still requires libtraceevent,=
 so an
> arm64 cross build without the arm64 libtraceevent installed stops at that
> check. With NO_LIBTRACEEVENT=3D1 added, it then fails building the Rust t=
est
> workload. Natively it still enables aio, libLLVM, libslang, libtraceevent=
,
> lzma, zlib and Rust when they are installed, so the result depends on the
> machine.
>
> I'd like to go with Ian's suggestion then: a MINIMAL=3D1 knob in perf tha=
t turns
> off every optional feature, which tests/make can use for make_minimal as =
well.

I can put a patch together for that. Just for discussion, I did do
some work to break perf dependencies with libraries using dlopen/dlsym
like:
https://lore.kernel.org/linux-perf-users/20260130233439.647447-1-irogers@go=
ogle.com/
An area of controbversy with this approach is that it is still nice to
use the header files for the library as library authors are bad and
will do things like change function APIs over time. If the build uses
the header files, why use dlopen when you can just link against the
library? I could imagine using dlopen/dlsym for libtraceevent, but it
would end up repeating this header file and library argument.

Thanks,
Ian

> --
> Thanks,
> Sasha
