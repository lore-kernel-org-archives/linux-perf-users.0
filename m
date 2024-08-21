Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48641531DA;
	Wed, 21 Aug 2024 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724272659; cv=none; b=EqSr8nj+w8AIr2+BUu9UPS+JnYv+w2Ojjx0NjYatzAgFewO4qLVw+qvbYePBZFkfaoV36YVIrTS5bjWjsCufsokpvu6tK0QxFcbWP50ZR3avDroqNQ8nXkmVpD+Yg0F1c1B4N2/jqCKjbCruvWl6uYTC0dHwz4DrRwrmg9OoP5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724272659; c=relaxed/simple;
	bh=iLsC/eF+DOw5vX5ljvpg6Wmzc3Ft81yZPapZQ36JtLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loB2n8PfLzvglbtd/S85cNj0PB7fCp6cXtIRbKUigpRl+qlGD9etS4fo03gPVlE9NgPxDxVKOvQxh+YIed0Yiht+5N3KQzDl8ny9FECGo/IRFtijkLEbi45BgQTiy39WiPTknYEw5Gar8qMOIi4vjw58b8/ZsSmcpummRt3R/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7a18ba4143bso112030a12.2;
        Wed, 21 Aug 2024 13:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724272657; x=1724877457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+eHk07shA5b75z7CTASXv5Brt93+G8BFCbapf1kXRU=;
        b=w0GlQm1M4PUtu4jQXNJGBEl8zdP25zrhgNFDsruH4HCnbIbw24F3ZwbLyQuSXXFPza
         pmoLTovu2JGoEYHBkPfumRwBlI9SgLT65dcsCCecyGPS7NvCyHR71LOILLnzSpA4pPmU
         gIcmDG4s7AYUqzxtZY0R5kTUMBP2lp488rciQM9w46kX2DkDcSxnC6wTEUDZ+LTRB3vf
         VYlZPINYWTHB8cRwA8GWbl8PRI9/xwDdZu/Pv3ywUmnNAMZaW83Vq6oqyBhAEwO2Mo4B
         64pSpJ/uy1GsEGDmKLcLszidPV04F8vJMN6xsFb4BZxjshNxXck/yR8v96TQlK0XzT5g
         u4wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsOuWCKl/B1SBs7/hWXqffdDJ9D0E3Tu/fC3UTbNbyQDUwd2Gr0gtlHrKP4Jox7Easb3xNn6QDvbnMrMw=@vger.kernel.org, AJvYcCXOOWf8hJzXRShQL2v0Eol9tv1uTDdrnPMQFyUAsFulrwWC+CdAKIbDzD7rRbXUH/9Bq4QQDu87dpxyegGVpDUdwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YydFYwXDrIakE9S566ZwwPRZ+S+LOYdSbZ2/LgsaXdLtSMwxkOa
	BJL98xugSyP9ExobBTQW+mBgUiraxaeB0pXs5fzFlIa+Cwb+5Ypm+cdCpULlhrjm7O+ZbKzPoaS
	oCQ5hyMZNEGhUjnKYkkIPVr1hPAg=
X-Google-Smtp-Source: AGHT+IF8rfYNJ+1ofwGlvKrvXqPvDfoN2aZCRh7B1rnxmvhE0JsYcW85L1IMyxX7oJ/Gk/ht69rbTEQ4Yg9pgD616cM=
X-Received: by 2002:a17:90b:3c8b:b0:2d3:c5f1:d0d9 with SMTP id
 98e67ed59e1d1-2d5e9b84c87mr4051812a91.25.1724272656827; Wed, 21 Aug 2024
 13:37:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com>
 <CA+icZUXpB4KMiRek3MkgCapwoW5TC31L4-TffrV=jdhM1k8=Sg@mail.gmail.com>
In-Reply-To: <CA+icZUXpB4KMiRek3MkgCapwoW5TC31L4-TffrV=jdhM1k8=Sg@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 21 Aug 2024 13:37:25 -0700
Message-ID: <CAM9d7cgHCJgJb10zaNt7b1Dy=4raiv+a1C1GwrVptNz5Uh+SNg@mail.gmail.com>
Subject: Re: [Linux-6.11-rc4] perf BROKEN with LLVM/Clang 19.1.0-rc3
To: sedat.dilek@gmail.com
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Aug 21, 2024 at 12:37=E2=80=AFPM Sedat Dilek <sedat.dilek@gmail.com=
> wrote:
>
> As a workaround:
>
> dileks@iniza:~/src/linux/git$ git diff
> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index 142e9d447ce7..db45e6fe7a21 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -63,6 +63,8 @@ cflags =3D getenv('CFLAGS', '').split()
> cflags +=3D ['-fno-strict-aliasing', '-Wno-write-strings',
> '-Wno-unused-parameter', '-Wno-redundant-decls' ]
> if cc_is_clang:
>     cflags +=3D ["-Wno-unused-command-line-argument" ]
> +    cflags +=3D ["-Wno-cast-function-type-mismatch" ]
> +
> else:
>     cflags +=3D ['-Wno-cast-function-type' ]
>

Thanks for the fix.  I wasn't aware of the issue and the fix
looks good to me.  I'll add it to perf-tools if nobody objects.

Thanks,
Namhyung


> dileks@iniza:~/src/linux/git$ ~/bin/perf -vv
> perf version 6.11.0-rc4
>                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
>                libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
>            debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
>                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
>           libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
>                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
>             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>                   aio: [ on  ]  # HAVE_AIO_SUPPORT
>                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
>               libpfm4: [ on  ]  # HAVE_LIBPFM
>         libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
>         bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
>  dwarf-unwind-support: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
>            libopencsd: [ OFF ]  # HAVE_CSTRACE_SUPPORT
>
> -Sedat-
