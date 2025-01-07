Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ED819883C
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jan 2025 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736288902; cv=none; b=oVsCNgmjTpRGaLTpoT7qIYMISG9zbn6zioTUsZJrUP7pr2d2GDodnDB4+LNb/XSCAGo6RDh/JKYlD/dzK6ePqTk98F5mjnkv3p81mbrsrXxoERAZtzXwKKLAgwdo/iaFxHALKdKto/cdX7kw41VhpV4ERDUhZ5aPHrZ8CKr80ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736288902; c=relaxed/simple;
	bh=gSVrRHgwighno61EiVc44ZJluuNvYDzsMX32Bvl3fiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=BCMgK6xsPdGALo/r1fHUdsuax/Y6Rsx5BTNHOs/Lhx4J7/JAggLfONSKZ6B5B1p8TjZ7hEBHnSBDWsebwV8hcwY2MGIZVhwsjMiBsvtRlAx6EMpZKrvi5uThbYJO4gok0uIr/VOiTWWZZ7VfHIK4tVaZdPKR/ClllVwFCMW2MKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iaMx5G5y; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iaMx5G5y"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso14795ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 14:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736288897; x=1736893697; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5J879ZPA6Zkph3ImpMp0qHwnS93PBi7/GMwvMBhp7Eo=;
        b=iaMx5G5yGN7qSRqkSGfjvHUWleuERFfEmjPWPtHB62jU1TaVKASVTQCZS40TjQUyPu
         woAUSfY1JzmorarJsYWgRw9UInqXhAWHqreqHn8Vx+0sd7pvBeNkknt7ak2Tu4PcxGtL
         ZkjK+sIxiDUEnpMhW204pbfe9TN4qrxPqQxpXlfRaUq+BfRWduUBY95SSzwj1xHMAbsW
         TgUw/+OBV8K9UWHIZPJWmqQvuSCk5RpXFYNS5iZ9lG6JzuLSEBste0YHRgu6kYJMMDfO
         0q2AGpuunAwyTEuCtUQfj8XbJ1kDo0rwCVRIfv90Qvv7Ad2s0EllRJTyXxXtpRFDjXMs
         oy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736288897; x=1736893697;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5J879ZPA6Zkph3ImpMp0qHwnS93PBi7/GMwvMBhp7Eo=;
        b=YA8DF92LFzLhAftiuBhHxkvanl5eeQEq70sq93B+t7BsR3TKk7dfkugs49+PKU4qnV
         c3K+lG6TPqyKstwlbQ+ZVN4xbXraqlhz/+k74TjrmWEVJLEdMj19FhgAQqEOIqcczryt
         1GN0wUWxCBmnIqQckFIjHx9oba1GLSLvP/YiUkV6M7C6RecXtm0aBHb8UKnae6wZtswZ
         +2YyVgoiyhNFEOU/igpugu6r2fhFOGZMNdeIhYMXTJMfxmKK1Ok0qXbe2MLNi3caci+N
         tKpKQWKjZ4iyLeQDX/LvJTO56DwMw5W0Y8ASAVJaZY5dES2wa3yUosSclxRFwnNudImE
         9RSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzOmMo3CI4uJE8pesqtgG+Bz1mbzvX2EBEoU1UMJzkytJW608aUFP2T68IdwcufYqR1z/fEoKnFIagJOPK8+0p@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqrhh7DyFhdxOhalnqhAeWZRuMs+Y627RhoQCZugdg7fJ4KXG/
	A41FIBUVHRhqkyllEZYKb/8/49CkK3+dhk9ziP1i4SWizwYSEbDyI5WpDGxTlQle4IHL1v/xMfS
	CcM3Ig8hf3aUx2kB9YwHCokKIMutshwiehy1O
X-Gm-Gg: ASbGncuF4oMaTQplkK062i9/iG2OTRLD0ULWqiPhWrIEwFTSwUTTsieWoPrIdOAGpgo
	o4UN0/8T6L+SFWHERKgMvmJBB+GxePF6if33xQde4BsNtpH3u46fcbZpkobhiDG0S85vsjQ==
X-Google-Smtp-Source: AGHT+IGk2RE560xg1rGqOhji8Z4dJVjjj4+r601fzS30fRFdP27e0DaO5ds+cMXgTwasEubtU9c0PUYpzyE+rycNfu8=
X-Received: by 2002:a92:de4c:0:b0:3a7:e301:a1f2 with SMTP id
 e9e14a558f8ab-3ce3cef81ffmr148655ab.15.1736288897471; Tue, 07 Jan 2025
 14:28:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022174838.449862-1-irogers@google.com>
In-Reply-To: <20241022174838.449862-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 Jan 2025 14:28:06 -0800
X-Gm-Features: AbW1kvbWZMgzYRCo-1Asq-be0vdTfJuhk17UlfmQ9IseEmeZ5MYXLrw4Gn0vdZs
Message-ID: <CAP-5=fVQZ0nQhOPsA9oGtTZQwMYY2o7t-6xuNL+Qp+TfVYKSPQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] perf check: Add sanitizer features
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 10:48=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Sanitizer builds can break expectations for test disassembly,
> particularly in the annotate test. Add features for the different
> sanitizer options seen in the source tree.
>
> An example for an asan build:
> ```
> $ perf version --build-options
> perf version 6.12.rc3.g939b0caafd01
>                    aio: [ on  ]  # HAVE_AIO_SUPPORT
>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
>             debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
>                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>           dwarf-unwind: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
>               auxtrace: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>               libaudit: [ OFF ]  # HAVE_LIBAUDIT_SUPPORT
>                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
>            libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
>              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>                libnuma: [ OFF ]  # HAVE_LIBNUMA_SUPPORT
>             libopencsd: [ OFF ]  # HAVE_CSTRACE_SUPPORT
>                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>                libpfm4: [ on  ]  # HAVE_LIBPFM
>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
>              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
> numa_num_possible_cpus: [ OFF ]  # HAVE_LIBNUMA_SUPPORT
>              sanitizer: [ on  ]  # HAVE_SANITIZER
>      sanitizer_address: [ on  ]  # HAVE_SANITIZER_ADDRESS
>         sanitizer_leak: [ on  ]  # HAVE_SANITIZER_LEAK
>       sanitizer_memory: [ OFF ]  # HAVE_SANITIZER_MEMORY
>       sanitizer_thread: [ OFF ]  # HAVE_SANITIZER_THREAD
>    sanitizer_undefined: [ OFF ]  # HAVE_SANITIZER_UNDEFINED
>          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
> ```
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v3 split out annotate test check
> v2 build fix.

Working around the asan issue for the annotate test is no longer
needed for me. Should we carry this first patch so that tests can have
better feature checks on sanitizers? I can resend the patch again on
its own, if this is useful.

Thanks,
Ian


> ---
>  tools/perf/builtin-check.c | 49 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> index 0b76b6e42b78..c44444008d64 100644
> --- a/tools/perf/builtin-check.c
> +++ b/tools/perf/builtin-check.c
> @@ -9,6 +9,49 @@
>  #include <string.h>
>  #include <subcmd/parse-options.h>
>
> +#if defined(__has_feature)
> +#define HAS_COMPILER_FEATURE(feature) __has_feature(feature)
> +#else
> +#define HAS_COMPILER_FEATURE(feature) 0
> +#endif
> +
> +#if defined(__SANITIZE_ADDRESS__) || defined(ADDRESS_SANITIZER) || \
> +       HAS_COMPILER_FEATURE(address_sanitizer)
> +#define HAVE_SANITIZER_ADDRESS 1
> +#define HAVE_SANITIZER_LEAK 1
> +#elif defined(LEAK_SANITIZER) || HAS_COMPILER_FEATURE(leak_sanitizer)
> +#define HAVE_SANITIZER_ADDRESS 0
> +#define HAVE_SANITIZER_LEAK 1
> +#else
> +#define HAVE_SANITIZER_ADDRESS 0
> +#define HAVE_SANITIZER_LEAK 0
> +#endif
> +
> +#if defined(MEMORY_SANITIZER) || HAS_COMPILER_FEATURE(memory_sanitizer)
> +#define HAVE_SANITIZER_MEMORY 1
> +#else
> +#define HAVE_SANITIZER_MEMORY 0
> +#endif
> +
> +#if defined(THREAD_SANITIZER) || HAS_COMPILER_FEATURE(thread_sanitizer)
> +#define HAVE_SANITIZER_THREAD 1
> +#else
> +#define HAVE_SANITIZER_THREAD 0
> +#endif
> +
> +#if defined(UNDEFINED_SANITIZER) || HAS_COMPILER_FEATURE(undefined_sanit=
izer)
> +#define HAVE_SANITIZER_UNDEFINED 1
> +#else
> +#define HAVE_SANITIZER_UNDEFINED 0
> +#endif
> +
> +#if HAVE_SANITIZER_ADDRESS || HAVE_SANITIZER_LEAK || HAVE_SANITIZER_MEMO=
RY || \
> +       HAVE_SANITIZER_THREAD || HAVE_SANITIZER_UNDEFINED
> +#define HAVE_SANITIZER 1
> +#else
> +#define HAVE_SANITIZER 0
> +#endif
> +
>  static const char * const check_subcommands[] =3D { "feature", NULL };
>  static struct option check_options[] =3D {
>         OPT_BOOLEAN('q', "quiet", &quiet, "do not show any warnings or me=
ssages"),
> @@ -47,6 +90,12 @@ struct feature_status supported_features[] =3D {
>         FEATURE_STATUS("libunwind", HAVE_LIBUNWIND_SUPPORT),
>         FEATURE_STATUS("lzma", HAVE_LZMA_SUPPORT),
>         FEATURE_STATUS("numa_num_possible_cpus", HAVE_LIBNUMA_SUPPORT),
> +       FEATURE_STATUS("sanitizer", HAVE_SANITIZER),
> +       FEATURE_STATUS("sanitizer_address", HAVE_SANITIZER_ADDRESS),
> +       FEATURE_STATUS("sanitizer_leak", HAVE_SANITIZER_LEAK),
> +       FEATURE_STATUS("sanitizer_memory", HAVE_SANITIZER_MEMORY),
> +       FEATURE_STATUS("sanitizer_thread", HAVE_SANITIZER_THREAD),
> +       FEATURE_STATUS("sanitizer_undefined", HAVE_SANITIZER_UNDEFINED),
>         FEATURE_STATUS("syscall_table", HAVE_SYSCALL_TABLE_SUPPORT),
>         FEATURE_STATUS("zlib", HAVE_ZLIB_SUPPORT),
>         FEATURE_STATUS("zstd", HAVE_ZSTD_SUPPORT),
> --
> 2.47.0.163.g1226f6d8fa-goog
>
