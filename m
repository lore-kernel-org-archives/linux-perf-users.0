Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94623154C0B
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Dec 2024 04:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977495; cv=none; b=jiGV6tSmW5sD4bXyTYH+vAB9utPA3MgUhz9excDZW7aEH1zk6e3UX3WDepxwLpnKgeouhyFTtSW7mXXS0ukV5sTgkRNbzV88/ZBxYcUTQ2VqRXVWEp+xI3KLxb3EoIqUNLSOzwVgESugZllfG+OdhCVFoW+9GcbywUQW1d36QmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977495; c=relaxed/simple;
	bh=5McNTPhgwuTAZitJsZKO7cUAyaEVDxm0YVa1JFu0Cys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5/9SUd+bDesTcCD53+m5x+ZqbTk+U4ZrkPj3dxL3HDjHu69Vn9IFCRimir9veVwd2jw2poNHxpw2tp/xYjr+ntEQuU1FkaIiTx+YVkE679+8+EXhIvASixjrbZ4LLVkL+DjOiBNIWOH132DE+ThhxzFrDx3FZYjz1z2HmOIEmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fWYHAvM8; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fWYHAvM8"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so57625ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 20:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733977492; x=1734582292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMNonVSTAKAhdnESlZhBPVMi0k5FuDoi886Qlqbxejk=;
        b=fWYHAvM8/D3LKkHhYide0/MS44hQfxaqiJvSsKh02bT4mOsoLZkuok4LMEdagBZx7Q
         cyryqaHtYk2yrB3hK+fSbomiO1vgZfb3LYCQp70AKuXx4qWbrIz+9PWnBhdcg5d0WnuD
         u3h1+O44I0tQyaWDTo0inYMNxz20g1HaA9hVGsCJsF3c7vDlrIdGrpCUlfMs1S8sa+2w
         Mu+hTRq2vV0rNGIGfZhRGvgzm9WbfLlLN/RuXj37or/krH29caj73n3XwyGUAgIDR0n4
         E+/ZrrteLG/w5cVfECZ+kJSa7yav0lTnfN+btB0vYz3qnhrOgy7/v+tJegnTLiosGmCH
         qJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733977492; x=1734582292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMNonVSTAKAhdnESlZhBPVMi0k5FuDoi886Qlqbxejk=;
        b=aNJjaogg6fdpHCdz7PPuerxIedUw8XKQ7sC6/zpV8eNHH0jaGJeK+WjCN29Ys25DKZ
         nYpNSg4ZzU/kqzYpQAyNeYz5FKqLCBtPrWbaAkJmKp9Wv4FAJM8FVeVyHdozVsoKgAs+
         OKy4sB2ZEX1UBKWrlEgffFzZMpIdTL+xuyAe5CVmhO9PjsYsPzKjBnJ0T66NI9jdsdjg
         nanZNptodTzqIzWB6pjPfrpRvIjimLNEsxUdwS5iv9sDUF7D+8sn4bIPD5fUC8y9N8up
         nNoWynIaNACOBbz7b3ioYgAavR218f8xYnMRE1CAfvtWrevZv9VwHVS5sVCwD7e1FOQk
         q5rg==
X-Forwarded-Encrypted: i=1; AJvYcCVzYm7vxngvaMUu4qpqrEHGe9V2BVHjV0XupZKpT6ORQFCPZ8bCAjEQTnXra3SlPm9+FdwgKFLIGk/fOz3i5vhS@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi7Ww5DMn/MrTYKDXEY8FfIK44rSi4sm7cKprM2pRKZB+p3LRJ
	shQ31F0vqSDoeSclvUkLs6SYCFc0adpOa/gzPzYYzXXJ+YfDXifFjd6BXh5p+C0AlqoxsTVAckd
	itst1CKaOI6bRlk465yf55jeS9xGHnoKWuBW0
X-Gm-Gg: ASbGncts9k69jMpQu11mnusdTgisU1pt8TKeTQYqIxpTIOkitlDjz81HXuJ/MfLJj9g
	6H7+GFjUoFlhpvC3GKUEkDsyLUxTZP43miw1vynM=
X-Google-Smtp-Source: AGHT+IHE2kXy+Z40PPp4+ulYpNyAnZdtK/qutnj5lKaUda+LXh3U6WkDzUvspnw1LuYHpK/msBAN68/hIkKJQNgAJW8=
X-Received: by 2002:a92:d409:0:b0:3a7:deca:1fe6 with SMTP id
 e9e14a558f8ab-3acda64e3ecmr1157415ab.13.1733977492544; Wed, 11 Dec 2024
 20:24:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211224509.797827-1-acme@kernel.org> <20241211224509.797827-2-acme@kernel.org>
In-Reply-To: <20241211224509.797827-2-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 11 Dec 2024 20:24:41 -0800
Message-ID: <CAP-5=fUhyjHXx=q+VFQzvvHxkK30xQc9O59x+KJO+Q7q6o=dDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools build feature: Add some comments to explain the
 FEATURE_TESTS logic
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 2:45=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> The tools/build/feature/test-all.c works in conjunction with the
> tools/build/Makefile.feature FEATURE_TESTS_BASIC and FEATURE_TESTS_EXTRA
> contents, so that if test-all.c manages to be built, we go on and
> iterate all entries in FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA setting
> then to 1.

nit: s/then/them/

> To test this:
>
>   $ rm -rf /tmp/b ; mkdir /tmp/b ; make -C tools/perf O=3D/tmp/b feature-=
dump
>   $ cat /tmp/b/feature/test-all.make.output
>   $ ldd /tmp/b/feature/test-all.bin
>         linux-vdso.so.1 (0x00007f2a47a67000)
>         libdw.so.1 =3D> /lib64/libdw.so.1 (0x00007f2a477cf000)
>         libpython3.12.so.1.0 =3D> /lib64/libpython3.12.so.1.0 (0x00007f2a=
471fe000)
>         libm.so.6 =3D> /lib64/libm.so.6 (0x00007f2a4711a000)
>         libtraceevent.so.1 =3D> /lib64/libtraceevent.so.1 (0x00007f2a470f=
2000)
>         libtracefs.so.1 =3D> /lib64/libtracefs.so.1 (0x00007f2a470cb000)
>         libcrypto.so.3 =3D> /lib64/libcrypto.so.3 (0x00007f2a46c1b000)
>         libz.so.1 =3D> /lib64/libz.so.1 (0x00007f2a46bf8000)
>         libbabeltrace-ctf.so.1 =3D> /lib64/libbabeltrace-ctf.so.1 (0x0000=
7f2a46bad000)
>         libcapstone.so.5 =3D> /lib64/libcapstone.so.5 (0x00007f2a464b8000=
)
>         libopencsd_c_api.so.1 =3D> /lib64/libopencsd_c_api.so.1 (0x00007f=
2a464a8000)
>         libopencsd.so.1 =3D> /lib64/libopencsd.so.1 (0x00007f2a46422000)
>         libelf.so.1 =3D> /lib64/libelf.so.1 (0x00007f2a46406000)
>         libnuma.so.1 =3D> /lib64/libnuma.so.1 (0x00007f2a463f6000)
>         libslang.so.2 =3D> /lib64/libslang.so.2 (0x00007f2a46113000)
>         libperl.so.5.38 =3D> /lib64/libperl.so.5.38 (0x00007f2a45d74000)
>         libc.so.6 =3D> /lib64/libc.so.6 (0x00007f2a45b83000)
>         liblzma.so.5 =3D> /lib64/liblzma.so.5 (0x00007f2a45b50000)
>         libzstd.so.1 =3D> /lib64/libzstd.so.1 (0x00007f2a45a91000)
>         libbz2.so.1 =3D> /lib64/libbz2.so.1 (0x00007f2a45a7b000)
>         /lib64/ld-linux-x86-64.so.2 (0x00007f2a47a69000)
>         libbabeltrace.so.1 =3D> /lib64/libbabeltrace.so.1 (0x00007f2a45a6=
b000)
>         libpopt.so.0 =3D> /lib64/libpopt.so.0 (0x00007f2a45a5b000)
>         libuuid.so.1 =3D> /lib64/libuuid.so.1 (0x00007f2a45a51000)
>         libgmodule-2.0.so.0 =3D> /lib64/libgmodule-2.0.so.0 (0x00007f2a45=
a4a000)
>         libglib-2.0.so.0 =3D> /lib64/libglib-2.0.so.0 (0x00007f2a458fa000=
)
>         libstdc++.so.6 =3D> /lib64/libstdc++.so.6 (0x00007f2a45696000)
>         libgcc_s.so.1 =3D> /lib64/libgcc_s.so.1 (0x00007f2a45668000)
>         libcrypt.so.2 =3D> /lib64/libcrypt.so.2 (0x00007f2a45630000)
>         libpcre2-8.so.0 =3D> /lib64/libpcre2-8.so.0 (0x00007f2a45590000)
>   $ head /tmp/b/FEATURE-DUMP
>   feature-backtrace=3D1
>   feature-libdw=3D1
>   feature-eventfd=3D1
>   feature-fortify-source=3D1
>   feature-get_current_dir_name=3D1
>   feature-gettid=3D1
>   feature-glibc=3D1
>   feature-libbfd=3D1
>   feature-libbfd-buildid=3D1
>   feature-libcap=3D1
>   $
>
> There are inconsistencies that are being audited, as can be seen above
> with the libcap case, that is not linked with test-all.bin nor is
> present in test-all.c, so shouldn't be set as present. Further patches
> are going to address those inconsistencies, but lets document this a bit
> more to reduce the chances of this happening again.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/build/Makefile.feature | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 80563154318601ac..52600e4d33af8712 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -28,6 +28,41 @@ endef
>  #   the rule that uses them - an example for that is the 'bionic'
>  #   feature check. ]
>  #
> +# These + the ones in FEATURE_TESTS_EXTRA are included in
> +# tools/build/feature/test-all.c and we try to build it all together
> +# then setting all those features to '1' meaning they are all enabled.
> +#
> +# There are things like fortify-source that will be set to 1 because tes=
t-all
> +# is built with the flags needed to test if its enabled, resulting in
> +#
> +#   $ rm -rf /tmp/b ; mkdir /tmp/b ; make -C tools/perf O=3D/tmp/b featu=
re-dump
> +#   $ grep fortify-source /tmp/b/FEATURE-DUMP
> +#   feature-fortify-source=3D1
> +#   $
> +#
> +#   All the others should have lines in tools/build/feature/test-all.c l=
ike:
> +#
> +#    #define main main_test_disassembler_init_styled
> +#    # include "test-disassembler-init-styled.c"
> +#    #undef main
> +#
> +#    #define main main_test_libzstd
> +#    # include "test-libzstd.c"
> +#    #undef main
> +#
> +#    int main(int argc, char *argv[])
> +#    {
> +#      main_test_disassembler_four_args();
> +#      main_test_libzstd();
> +#      return 0;
> +#    }
> +#
> +#    If the sample above works, then we end up with these lines in the F=
EATURE-DUMP
> +#    file:
> +#
> +#    feature-disassembler-four-args=3D1
> +#    feature-libzstd=3D1
> +#
>  FEATURE_TESTS_BASIC :=3D                  \
>          backtrace                       \
>          libdw                           \
> --
> 2.47.0
>
