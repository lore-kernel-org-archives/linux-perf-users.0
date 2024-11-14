Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1C4185924
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731602317; cv=none; b=uz7qTD3qIZrgb2eOM+bmpIss+sMruFQcnNsv15PdDCgcPn4cjqpjUFniQq2pLRkd/HHgqbPGwUQKiL/b0Ba9pbpTubEtlyJr8CEIYsboVKIT2IghpFUmVLrEe/BU4zkdNwlf+OSZ5fnUNsoRvxSMfwN5/jLm8TM2Q4whEiCRF/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731602317; c=relaxed/simple;
	bh=VTRlQxRj7LYxmFU7Jtca8GrrDwS78cpWXvTH3RtiYVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLt7tgJb+T0ZwIXj29w+lbQrbdxUYIsXljZc9mH6grW45fDOayQDeg14t8kjygG5zLsW/toI7flHqHUD2N5WS+kNhJ8KfSkYcGboVfxiiz+ILz+2281vf9Pfh3HAoaJHAXQLsWN/5GDXJmjR5jdQUI/OUQSVmF9ec1vD/Cpw1uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q46xspvX; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q46xspvX"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a71ef98bc4so128395ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 08:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731602315; x=1732207115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71YOuq/AgbGzHQ8jYFrNXs1E+A1uKSuz/fYvkMEzSiA=;
        b=Q46xspvXsK0vx42AF0nJ/Bo7zM2FUBUbEriBk4Pb/g8LZ5PNiYVX0qVXWZuyewdmtL
         rrrTtKq7/xvC7er6e2j3RASwXVDWbVawrGwgWqw19bRUiGu6Wm71DFDEA9ouSIeZ+coo
         Wby2YoUIXm9cyQsy/bxL06HcxSSM1uhqCB06XhOGFedH1KE14TPXqFKekrQaz3UIN+Eh
         /4R6VvcW6yLRJUPaNHLezOjIaHFe09+RQi9nFZxYBPPwMYjQET7NRHlHA7sj8YUIdm0e
         dxGPBqdBUKLNAgt3OKgkbedDIzdpoXXBNFe+v2iMbCbuDP6NUMOtkT6LxJiZKFjwLE/P
         bE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731602315; x=1732207115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71YOuq/AgbGzHQ8jYFrNXs1E+A1uKSuz/fYvkMEzSiA=;
        b=FtcVJKI66C8tneBx8YS3OnwaclUybouuqg1xjsiZTOTHQYPKD96u+61IRjn8qCZlJo
         5R0KEv8kJadrLEMlg9P4Wjsph3KLAFdxBXbKF64ZsrAI82ux4FXsSUvDAYLsh78FE06K
         XYMQEjAB5Apdj5szCJVb8j5cx1QN0atWQnN1cbY+CleEHeJ0V2HpjgTZXa0koli2W5/9
         alG0l9bZIDaOjiYSIWdk2Saz3uYbKtU0QnSTf6JlwRtARaGiVSBlFEZh8QiFxtMpDPPy
         G4H0FhxKnJAF+skaujyAdVKvjzexyi/MvfDwG3BjQcD+c0ECHkVA5+TRoVOvOsiR7oIw
         XIgQ==
X-Gm-Message-State: AOJu0YznsBG3mKE5b9+KuV+7KxyBvMpgTpPmqgD+pKmglhWb9CSvnsS8
	DOKtpXRqyYn+05BdCXYkrUtkcC5UldQMAO7yl0d2LiveeDgmvmLXpesDuNL6ZCdNsc/iQUjyZc0
	LQnR3sjyo8+s7fv+eFiGnOycIS8ceTe00+RFFPF36RsYj74jkUlTqVE4=
X-Gm-Gg: ASbGnculWN5JWq4riMXLzvKfa84siHrauTrb6iSlCwVfewwGaJw7Zo1SHdKpyTbVLDE
	OuhK2xRXXQrWCy1383QuupUN/wgFBzBTT2ORRMYSIPqQGwNN5kHZwVjimZaYywmc=
X-Google-Smtp-Source: AGHT+IEGFQG9tW5hZfV/4zAjTGlOTJGId/53jtN3FTuvZQHJw39b4AUd/9Rtb8DEjdYYYb8hHlhySzmd1C8dA1Cl+vc=
X-Received: by 2002:a05:6e02:1909:b0:3a6:e960:ef97 with SMTP id
 e9e14a558f8ab-3a71f76ba59mr3210055ab.23.1731602314972; Thu, 14 Nov 2024
 08:38:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1731300662-5325-mlmmj-28e386a1@vger.kernel.org> <CACvH6ToqaADXOrJh8UpapnGtVkn3W+HYQ7kHK8ByQgin4jnFBg@mail.gmail.com>
In-Reply-To: <CACvH6ToqaADXOrJh8UpapnGtVkn3W+HYQ7kHK8ByQgin4jnFBg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 14 Nov 2024 08:38:23 -0800
Message-ID: <CAP-5=fUACPpVUGunmADUd0OccamKAO=kDv4eb6u9q4XRCFwZdA@mail.gmail.com>
Subject: Re: HTML message rejected: Building perf from source, with changes in
 source code
To: Deva Narayana Babu <dnb.ranjikaa@gmail.com>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 8:00=E2=80=AFAM Deva Narayana Babu
<dnb.ranjikaa@gmail.com> wrote:
>
> Subject: Building perf from source, with changes in source code
>
> I use kernel `6.6.55` so when I tried to build perf from source, I was
> getting the following error, and when I changed some code(diff output
> given below) the build happened. Is this a bug?
> =E2=9E=9C  perf make
>             [....]
>   CC      util/synthetic-events.o
>   CC      util/data.o
> util/thread.c: In function =E2=80=98thread__free_stitch_list=E2=80=99:
> util/thread.c:481:17: error: implicit declaration of function
> =E2=80=98map_symbol__exit=E2=80=99; did you mean =E2=80=98symbol__exit=E2=
=80=99?
> [-Werror=3Dimplicit-function-declaration]
>   481 |                 map_symbol__exit(&pos->cursor.ms);
>       |                 ^~~~~~~~~~~~~~~~
>       |                 symbol__exit
> util/machine.c: In function =E2=80=98save_lbr_cursor_node=E2=80=99:
> util/machine.c:2540:9: error: implicit declaration of function
> =E2=80=98map_symbol__exit=E2=80=99; did you mean =E2=80=98symbol__exit=E2=
=80=99?
> [-Werror=3Dimplicit-function-declaration]
>  2540 |         map_symbol__exit(&lbr_stitch->prev_lbr_cursor[idx].ms);
>       |         ^~~~~~~~~~~~~~~~
>       |         symbol__exit
>   CC      util/tsc.o
>   CC      util/cloexec.o
>   CC      util/call-path.o
>   CC      util/rwsem.o
>   CC      util/thread-stack.o
>   CC      util/spark.o
> cc1: all warnings being treated as errors
>   CC      util/topdown.o
> make[4]: *** [/home/dmacs/Downloads/linux-6.6.55/tools/build/Makefile.bui=
ld:98:
> util/thread.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> cc1: all warnings being treated as errors
> make[4]: *** [/home/dmacs/Downloads/linux-6.6.55/tools/build/Makefile.bui=
ld:97:
> util/machine.o] Error 1
> make[3]: *** [/home/dmacs/Downloads/linux-6.6.55/tools/build/Makefile.bui=
ld:150:
> util] Error 2
> make[2]: *** [Makefile.perf:666: perf-in.o] Error 2
> make[1]: *** [Makefile.perf:242: sub-make] Error 2
> make: *** [Makefile:70: all] Error 2
>
>
>  On inspection I found that the function/macro has been used but has
> not been defined anywhere so I followed the compiler's directive and I
> changed the function name to what was mentioned and `perf` got built.
> The diff is given below:
>
> =E2=9E=9C  tools diff -r /home/dmacs/src/linux-6.6.55/tools/perf/ ./perf
> Binary files /home/dmacs/src/linux-6.6.55/tools/perf/pmu-events/__pycache=
__/metric.cpython-310.pyc
> and ./perf/pmu-events/__pycache__/metric.cpython-310.pyc differ
> diff --color -r /home/dmacs/src/linux-6.6.55/tools/perf/util/machine.c
> ./perf/util/machine.c
> 2540c2540
> < symbol__exit();
> ---
> > map_symbol__exit(&lbr_stitch->prev_lbr_cursor[idx].ms);
> 2841c2841
> < symbol__exit();
> ---
> > map_symbol__exit(&stitch_node->cursor.ms);
> diff --color -r /home/dmacs/src/linux-6.6.55/tools/perf/util/thread.c
> ./perf/util/thread.c
> 481c481
> < symbol__exit();
> ---
> > map_symbol__exit(&pos->cursor.ms);
> 492c492
> < symbol__exit();
> ---
> > map_symbol__exit(&lbr_stitch->prev_lbr_cursor[i].ms);

These errors are usually the result of a header file not being
included. Perhaps you have an unusual build configuration that is
causing the #include to be missed due to #ifdefs. This is a bug but I
can't see why it would happen from your output. Which branch are you
building? Development is happening in the perf-tools-next branch here:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/
It would be nice to see the feature detection part of the build log.

I remember Howard Chu creating docs covering topics like this. We
should link them into the wiki:
https://perfwiki.github.io/main/

Thanks,
Ian
