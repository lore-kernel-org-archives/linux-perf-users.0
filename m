Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C0B4AB3C8
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792103760; cv=none; b=ojyZAZftfwvhNU9w/hixGFZOC3vAkLyIXuRjyz+qVHiiJAInqQpNRuTYCuUNjxpcisOLB5cssboH1ZuIbtexLzv4473oKxNZzxjR9bCPfQ6yfedPDGVAEKHXAhdo/XqY6uf7Wjd/eLSEIlnB6/INt3yf+gBkPIW4uS9+sjT+NVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792103760; c=relaxed/simple;
	bh=cNb2599aisLf9N4nv6csEEr4VxPSgmqchakmgV0DaH8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=bwq7FX7XE7ii4N56bk20aPgenPws9f1xigdvmno8fs7M1XK9dGDiTNIKwg2k7arrRWaE8rmeGH3dNuaV+4ciJ2HQR+D2F+23OqfGuEEHOYvEA2pJMaFmvvo2SU+eJFXEJwWMvj2FBLBHNNAEmCJL8SCRT8o9lQXu/fZ2IYaCcC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjIqj7pC; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjIqj7pC"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35943f55c06so564351eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 15:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792103758; x=1792708558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xXSyEv36jnn0UrqVwNj52XhE8B6xeFQj285n9/QUz+4=;
        b=EjIqj7pCoK4+nk0gU9MX14g+breJOxcXlm0yFKr5EaiA8aq7vDFzKWKqk+IoaAcvMV
         mSk4mZuF73BmDubLI/kgjeBIyCTSOxz0+xTMAhHUnQy+xx/mhI9FpSqXCtR1GsB/HQ/K
         BfGvBbOB5qbbVG/vRaSijI7V088bcrEaSPx+mfU4LsS5YTmPXTAFdGc30M8xHlIR56zG
         Es7oHusr7nahKY3iRvXOTKZYXuBp/VBr++bBzCfjFl929eJRLbEmlP/94yn/pOgGzBkS
         h5EXmNuXi41gSBA+oH/q0PCluQzF70hc4fFgENnEBxbpR86TLZRDtN80ggq4m5Ay3lsG
         OqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792103758; x=1792708558;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xXSyEv36jnn0UrqVwNj52XhE8B6xeFQj285n9/QUz+4=;
        b=Kb87T/Dtzr06KWJl//ebm1mQYNlOHVdLUtEKZtpq0OJXf3JERTzD6Ab7t4QWh+4oWo
         9M4saTWiM2C3WqVWkfYmIlPc7wBRe3utIGUeZWsbiHJInmWXGKF/TAh4yTXL0HdH5LQF
         c+ilJBzP1xUZq4KP5Je3JrjH+OfTkc7FXGOO/5LwAOlOLhIfnQ50CMpqiXiYp/CBZeyP
         hT+BkmtazViVycwdXVKWvbNtqVJARtR7P1PFe8Run1+GygEPXzbHHFII33WlvdefHmC4
         Qz7Wg942+wBa5D4Ffc4t7oBpezLpL062gD08VOMZzZeqmB/Wqts8YWxAARSeHPWNIp9B
         BWbA==
X-Forwarded-Encrypted: i=1; AKwUvBw/8sJFYhFIRzoky1ekHD17c+VEgD42wL6s7pjugz/beQEof8Op+AZWZRbRmUtIcHfrCbShmGK3UkpwITO1Wr6J@vger.kernel.org
X-Gm-Message-State: AFq9FYK5N7r2rarGQsqbLQD7WeBDlaC88dSFN6evLXTjXkYS9vJXz+wB
	yVCV5ib2D4F+hqhId8BylDtJtG0hkcos7av2Df8l93rbYQREWVm4iGhQ
X-Gm-Gg: AYBFou0nBcvIJQ44gYV1Iz6Q84yungSXlL+QjxFk8wioaKjQP79gGgKf6pubmVkKX++
	EqeFf4tGXR+mK4f3kEbmaV55puVse4hr5f1niqSirgGbYap9ukSMQtci7OgGQSG/Yw6EcqTMOR8
	X0km+1Hi8JNIuHkYx5pMiBH5N/FO1B5NTMSbIoKxi7NMdmsX0xV1nSC89NO83zDHksDwbKOwuhm
	cB4OoztSL13qfRzHV14qiUYcJUSAcvEcFXhIZLqXJzntFIl44TzhZ3xMeEA78KfvAMGKjfspzun
	8o6UFnoTxNW67qbMXty8RXSsWwVBNHgErasX6O2JRbGCZyZZ1PS34qDKEq8aPNt4K+ocRCIkdSG
	Gn5rXtKsCRw+MtHshgVxwtSbRXJIGqiesq/JIFVCiLDatUPhXpaYSRmqOI5wA9b9+naKwzeLpx/
	FcqYYUknS0cAmeEORLWu3s0HwAE06ss966MOsGTlSxFkoFCYTQdYFDAYTQ8lpWzBsN1vTXybzcw
	XEGMLwjnDeGrHc=
X-Received: by 2002:a05:7300:50f0:b0:35c:eb2a:8c2a with SMTP id 5a478bee46e88-3602ae5f83emr1712774eec.8.1792103757626;
        Thu, 15 Oct 2026 15:35:57 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:2bf0:60e7:ae00:5bc5:e41d:2ee5:2023])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0cab0sm1155305eec.3.2026.10.15.15.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 15:35:56 -0700 (PDT)
Date: Thu, 15 Oct 2026 19:35:50 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Sasha Levin <sashal@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
 Namhyung Kim <namhyung@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] tools: build perf in tools_build
User-Agent: Thunderbird for Android
In-Reply-To: <atEo6aIQbgww4G0y@laps>
References: <20261011233647.2454648-1-sashal@kernel.org> <20261011233647.2454648-4-sashal@kernel.org> <CAP-5=fWFY-tpJz2vcBZvurwdZY5gwd8cuTemE9q1rtZ0Vi0dng@mail.gmail.com> <20261013170854.647305-1-sashal@kernel.org> <as6SxXELnoIJenIX@x2> <atEo6aIQbgww4G0y@laps>
Message-ID: <C62E88C6-52AF-4F68-95FC-310A84DDF8FC@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On October 15, 2026 4:26:33 PM GMT-03:00, Sasha Levin <sashal@kernel=2Eorg=
> wrote:
>On Tue, Oct 13, 2026 at 05:21:25PM -0300, Arnaldo Carvalho de Melo wrote:
>> Why is that difficult to run:
>>=20
>> make -C tools/perf install-build-deps
>>=20
>> To do a recommended perf build deps install?
>>=20
>> That would be useful as it is what we expect users to do=2E
>
>That's what users do, but it wants to install packages=2E
>
>We need a path for unprivileged builds on bots and CI machines that can't
>install packages, and many of those builds are cross builds, where perf n=
eeds
>the target's libelf and libtraceevent rather than the host's=2E

I see=2E It's unfortunate as the end result will not be that useful, as it=
 will not be testing what people use=2E

Maybe use make MINIMAL=3D1 when doing cross builds?=20

I think we can make this easier for you somehow, like disabling libtraceev=
ent when not available instead of asking for it to be explicitly  opted out=
?

>> If that is too difficult, for some reason, there is a minimal build in
>> tools/perf/tests/make, that is tested since forever:
>>=20
>> # all the NO_* variable combined
>> make_minimal        :=3D NO_PYTHON_MODULE=3D1
>> make_minimal        +=3D NO_DEMANGLE=3D1 NO_LIBELF=3D1 NO_BACKTRACE=3D1
>> make_minimal        +=3D NO_LIBNUMA=3D1 NO_LIBBIONIC=3D1 NO_LIBDW=3D1
>> make_minimal        +=3D NO_LIBBPF=3D1
>> make_minimal        +=3D NO_SDT=3D1 NO_JVMTI=3D1 NO_LIBZSTD=3D1
>> make_minimal        +=3D NO_CAPSTONE=3D1

>I tried make_minimal on perf-tools-next=2E It still requires libtraceeven=
t, so an
>arm64 cross build without the arm64 libtraceevent installed stops at that
>check=2E With NO_LIBTRACEEVENT=3D1 added, it then fails building the Rust=
 test
>workload=2E

I'll fix that, make_minimal wasn't updated when libtraceevent was made opt=
imal, IIRC when it was removed from the kernel sources=20

> Natively it still enables aio, libLLVM, libslang, libtraceevent,
>lzma, zlib and Rust when they are installed, so the result depends on the
>machine=2E
> I'd like to go with Ian's suggestion then: a MINIMAL=3D1 knob in perf th=
at turns
>off every optional feature, which tests/make can use for make_minimal as =
well=2E

Sure, for your use case it makes sense=2E

- Arnaldo 
