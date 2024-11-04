Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033FC1FCF4B
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Nov 2024 21:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757460; cv=none; b=DU0KXJExbhOWwJs1yww55NvyfNM210CQzlFnNsXYF8OKBcNiDhpEIfP89fBikEDLoX2S+8vx8+HahCZlHvKfYhhKvea9YYrjWUSSBbUI9AKuFI2/9GHEmX2IBCDf+kYLQh4eeb41aGODR/rU/s4cjmOTYUZVjLysb7UVrUsiEVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757460; c=relaxed/simple;
	bh=7b3NphHe1SMhLznbwJa95aL1abiNwj0Jj7KX/5QQt5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCvd+4+1ejyjGzfc6NiC+EEFt2rQXOKMtDrJdjRZgimISKc3BYAvPA88oYW2bF70QERyZMB6Shw5YUNsG/5u8T2KYqRZ1veYdElzMLn4glnZL3FRq+58kPm37wMt5Jki50Mz7BmWh9JC6HJWaPNz0o/yLm3S2tnVNGuqrBw+Ezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FQhABIM6; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FQhABIM6"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so32235ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Nov 2024 13:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730757458; x=1731362258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ic52nDcc1ijiXuNQQjETwYbD/HuHlFFykNpJ7be9AwY=;
        b=FQhABIM695O+hUmv8X2E3GDYqgwdfjOqQxutFq/dVugDRpQvd/7wz4guXRBBAVZ9R/
         /DESa73MEXjGqLodmIeQ5iMAmxWgQ5IameviSBKijEAe+kd6U4FZQ3TB+CiVFsu+qajN
         17BKOYmVQWbS9dTzsXMt6XEl9jevw5/Pa67lj+GN1B9dbj1kyopLUw92nSzVQofTYzYU
         LWtT2rHgLC45ug+6gp11LFprKeJ0ka4rmVyJ1HDZOkykpgZzcFb/A2290gnES4yhHt1g
         Uicf45y1LmykbVIk5Pz03yI6CrNPmMCoGEtDU2/WGPVPF9NoEcJvybrHYh271/f+cjLQ
         4P6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730757458; x=1731362258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ic52nDcc1ijiXuNQQjETwYbD/HuHlFFykNpJ7be9AwY=;
        b=WXNwTdyf2lLBkO2cFNZwvQDn8Zx+4bXKCtsdnWqdka+4QTvDL8kLP1KZuOhjUoUIPa
         oUSEJi2rY7fm9OcUC+gQBWqd0xjRGgwM7j4rYl9IOLy7SJJQ94kxi/dRGD+U/sOJRMnj
         D4K7t1Uo2e2Isy0PpUpdKQ4KMWY8wjy0jYpNFgj4oov3uY53cENXlufYOS/rru7AExN0
         sSnOwfnLr97osLHsga6c7dT1zWg9iap6aSZ3ibECRKXM9m/4VInkG5II2PONShwtfMqw
         hcDzFF/V09cNS94X66b8HAcHEVwHOO+lb3vrFV/r0E35UAR6SP1lwERsoZIm4rNmIUm2
         c83A==
X-Gm-Message-State: AOJu0Yy3p0hUWPef6xG829reS7vp53np0a8JafKkjmxQCo6laRhoY/Dz
	a8SFLRRxdSb7E+V0m6O9JfNe8y3y5yaMzaH3orTKFdHEj7zf4VP3+7k4gSwWfX7uZuqrxJnh6bP
	g7hYtXUT0XsyZWEzk+IN3xu0JBhh5p8JkSq0L09AEs9Fp8NH6rwlN21c=
X-Gm-Gg: ASbGncueMDU4KmwE5ws/ao0aCfhI6bqLXrSoSni3U3/qYTs9+/ixAVztTvT6NK8NB0b
	qO9ajGQXzhjDOcMTqph8FvtsYTayEPJes3v+UWjgmja0xeEVTTPb1avDq0zsw2bY=
X-Google-Smtp-Source: AGHT+IFK/3u2ql/BLwsbaFEJNXqLzpmU03twYKMq2xT+7s+qvfJdn4DPjghI4DzvYX/nXOSCs00d/1xhNf7rCA+ieKc=
X-Received: by 2002:a05:6e02:152e:b0:39d:2555:aa2e with SMTP id
 e9e14a558f8ab-3a6dba4b10bmr132105ab.13.1730757457820; Mon, 04 Nov 2024
 13:57:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fafa202f-59a-4838-1e30-74b4862aed5@redhat.com>
In-Reply-To: <fafa202f-59a-4838-1e30-74b4862aed5@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Nov 2024 13:57:26 -0800
Message-ID: <CAP-5=fWEPdvpm+x_h=VTLtf5aQoYm3t84HC0jqHJVP2Gf8dG5Q@mail.gmail.com>
Subject: Re: python3-perf pulling dependencies after build refactoring
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, vmolnaro@redhat.com, 
	jplesnik@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 1:22=E2=80=AFPM Michael Petlan <mpetlan@redhat.com> =
wrote:
>
> Hello Ian,
>
> Jitka Plesnikova has spotted an interesting fact about he python bindings=
 --
> perf.cpython-*-x86_64-linux-gnu.so library -- the number of shared object=
s it
> links against has significantly grown between v6.10 and v6.11:
>
> Before:
>
>     # ldd python/perf.cpython-39-x86_64-linux-gnu.so
>     linux-vdso.so.1 (0x00007ffefd1cb000)
>     libm.so.6 =3D> /lib64/libm.so.6 (0x00007f4c9315e000)
>     libz.so.1 =3D> /lib64/libz.so.1 (0x00007f4c93144000)
>     libelf.so.1 =3D> /lib64/libelf.so.1 (0x00007f4c929e4000)
>     libslang.so.2 =3D> /lib64/libslang.so.2 (0x00007f4c92600000)
>     libc.so.6 =3D> /lib64/libc.so.6 (0x00007f4c92200000)
>     libnuma.so.1 =3D> /lib64/libnuma.so.1 (0x00007f4c93136000)
>     /lib64/ld-linux-x86-64.so.2 (0x00007f4c93247000)
>     libzstd.so.1 =3D> /lib64/libzstd.so.1 (0x00007f4c9290d000)
>
> After:
>
>     # ldd python/perf.cpython-39-x86_64-linux-gnu.so
>     linux-vdso.so.1 (0x00007ffd889f3000)
>     libm.so.6 =3D> /lib64/libm.so.6 (0x00007f75cd125000)
>     libz.so.1 =3D> /lib64/libz.so.1 (0x00007f75cdbc0000)
>     libelf.so.1 =3D> /lib64/libelf.so.1 (0x00007f75cdba4000)
>     libdw.so.1 =3D> /lib64/libdw.so.1 (0x00007f75cd089000)
>     libcrypto.so.3 =3D> /lib64/libcrypto.so.3 (0x00007f75ccc00000)
>     libslang.so.2 =3D> /lib64/libslang.so.2 (0x00007f75cc800000)
>     libperl.so.5.32 =3D> /lib64/libperl.so.5.32 (0x00007f75cc400000)
>     libc.so.6 =3D> /lib64/libc.so.6 (0x00007f75cc000000)
>     libpython3.9.so.1.0 =3D> /lib64/libpython3.9.so.1.0 (0x00007f75cbc000=
00)
>     libstdc++.so.6 =3D> /lib64/libstdc++.so.6 (0x00007f75cb800000)
>     liblzma.so.5 =3D> /lib64/liblzma.so.5 (0x00007f75cdb76000)
>     libzstd.so.1 =3D> /lib64/libzstd.so.1 (0x00007f75ccb29000)
>     libcap.so.2 =3D> /lib64/libcap.so.2 (0x00007f75cdb6a000)
>     libnuma.so.1 =3D> /lib64/libnuma.so.1 (0x00007f75cdb5c000)
>     libbabeltrace-ctf.so.1 =3D> /lib64/libbabeltrace-ctf.so.1 (0x00007f75=
cd03f000)
>     libpfm.so.4 =3D> /lib64/libpfm.so.4 (0x00007f75cb400000)
>     libtraceevent.so.1 =3D> /lib64/libtraceevent.so.1 (0x00007f75ccb08000=
)
>     /lib64/ld-linux-x86-64.so.2 (0x00007f75cdbe8000)
>     libbz2.so.1 =3D> /lib64/libbz2.so.1 (0x00007f75cdb49000)
>     libcrypt.so.2 =3D> /lib64/libcrypt.so.2 (0x00007f75cc7c6000)
>     libgcc_s.so.1 =3D> /lib64/libgcc_s.so.1 (0x00007f75ccaed000)
>     libbabeltrace.so.1 =3D> /lib64/libbabeltrace.so.1 (0x00007f75ccadd000=
)
>     libpopt.so.0 =3D> /lib64/libpopt.so.0 (0x00007f75cc7b7000)
>     libuuid.so.1 =3D> /lib64/libuuid.so.1 (0x00007f75cdb3d000)
>     libgmodule-2.0.so.0 =3D> /lib64/libgmodule-2.0.so.0 (0x00007f75cd0390=
00)
>     libglib-2.0.so.0 =3D> /lib64/libglib-2.0.so.0 (0x00007f75cc2c5000)
>     libpcre.so.1 =3D> /lib64/libpcre.so.1 (0x00007f75cc24d000)
>
> I have narrowed it down to e467705a9fb3 ("perf util: Make util its own li=
brary").
> It has also grown in size, probably because of this linking change. I thi=
nk we
> need to get rid of this probably unwanted side-effect of the build optimi=
zation.
> What do you think?

Hi Michael,

it wasn't a build optimization. The problem was that we have things
like lex and yacc generated C code that things like parse_events
require to, you know, be able to parse events :-) So that we don't
duplicate logic from event parsing for things like
heterogeneous/hybrid/BIG.little machines we've been moving logic in
places like evlist to use parse_events rather than hand craft struct
perf_event_attr. So evlist has a dependence on parse_events but
previously the python code would stub out parse_events meaning the
python use of evlist had regressed.

I tried a few times to restructure things so that python and the build
would work as it was, but in the end the simplest solution was to
break apart the build. That is make util, tests, ui, bench.. their own
library and then link these with the builtin and perf.c code to make
the executable. Then the python code could depend on these
intermediate libraries, not worry about how they were made (lex/yacc
building, etc.), and we could have the full parse_events code in the
python code.

Now the code in util has additional dependencies, and we're linking
against libraries with those dependencies, so that's why the size has
gone up. Can we do better? Yes, we can. In these two patches we remove
the test and bench libraries from the python build:
https://lore.kernel.org/lkml/20241031014252.753588-16-irogers@google.com/
(unmerged)
https://lore.kernel.org/lkml/20241031014252.753588-18-irogers@google.com/
(unmerged)
The removal of the bench library will remove the use of libnuma.

Can we do yet better? Yes, if we can decouple the util and ui code
then there is no reason libslang be part of the python code.
Unfortunately that code is quite interwoven currently.

Can we do even more better? Possibly, in these changes libtraceevent
becomes more optional:
https://lore.kernel.org/lkml/20241102165400.75785-1-irogers@google.com/
(unmerged)
But removing this would also remove libtracevent support from perf, so
this probably isn't something you'd want to enable.

The libcap dependency should be gone after:
https://lore.kernel.org/lkml/20240806220614.831914-1-irogers@google.com/

libpfm is tied to event parsing so we probably want to keep it as a depende=
nce.

libbabeltrace I thought was used for syscall tables when other things
fail. Hopefully we can just have syscall tables and do away with this.
This cleanup makes me excited:
https://lore.kernel.org/linux-perf-users/Zyk9hX8CB_2rbWsi@ghost/T/#t

The compression library stuff is so that compressed events can work,
hard to see how to remove these without disabling compression support.

As perf script can run python and perl code we get those dependencies,
maybe we can get the relevant code only to be part of the
builtin-script.c and lose those dependencies from the util code.

libglib and libmodule I think relate to the not very maintained GTk
code. We probably should delete that code from the build. If we
decouple util and ui then again I think the dependency goes.

libpopt, I don't know where this dependency is coming from but it
looks bogus. perf's command line processing comes from the statically
linked libsubcommand.

libcrypt and lubuuid I think are only needed for genelf which is part
of `perf inject -j`. Possibly this logic can be carved out of util to
avoid bringing in the dependencies.

Thanks,
Ian
