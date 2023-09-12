Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A574CA0EEB
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Sep 2023 15:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236496AbjILPeI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Sep 2023 11:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbjILPeB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Sep 2023 11:34:01 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A61810EF
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Sep 2023 08:33:57 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-6535b9caa1eso31871786d6.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Sep 2023 08:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694532836; x=1695137636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jn3gYV6z0mHJzWuz6G6eyUwdrkRbzHbTqw/XH7fEH4s=;
        b=jXSW4sr0/V0TjTygldTr884ibK6jtHHyYxRV6nM1uAsrYMhRGlPYT5IV8wxSASiQt3
         etjGNSVMhu9OE3YJ6Taca3oX5YOEBO8AH1muDseBgwvJBZPgGW7wvFhhovPvA2VVvYvi
         7cIYUxtFUbsyGMxzcfNUGm8QCKQfdVFW8dIzAKgcEcy3bStwurtLo3txAKaYJWHG2/Ds
         jDpI9FyiEYuT9LF5bnbNrhBt4GdREQlewD7YDtkaJEYJ0Fmaw3Owsb0Y09JGEnu1fZqU
         mkx7I0agpaYsSJFNrXWo8vL7ZONfceEepwrEp7sAQ5mlMZZf6vJC1p+akXVskBatrkUx
         IFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694532836; x=1695137636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jn3gYV6z0mHJzWuz6G6eyUwdrkRbzHbTqw/XH7fEH4s=;
        b=RYXaxZPiRvcDAz4kUlKl8WDr5rrcvQAFkiYUQXEJm4MAA324LY6PMuXOEs9sgcNGNN
         xB73f8MktSUL0Qd4HWQf521ruNsoAo3ke3Qn6ftb6HS5+3XHg2Tj87oTw0i/zP0j2XyO
         06Xg/HaAdB+379QzL9zuAncxD+DIiLDclsGLCxhFIkS6MPzJVl9k2vutW11Q58e5c+j2
         dk16bRMjZqcSDR31mrK/cpq93mXFU6WvDjzPxXGywy9DVTzzwlyT/4ZEpHYOmbgxgKY1
         yyQ9nLf8LKNQlemQst3z9Dg/fzpiuP6GVBlA+MPw/Mr6AekH0IyIax1sX7Ui6MOn3vwS
         lnIg==
X-Gm-Message-State: AOJu0Yx0yA62g9Dg649omXhW7IUwUh1s7nu3MzGOaeeiAdvNaRf1YsGj
        fwIKcVz1x/ECGY3Zfj2weYsB2eGezwsaALs8sgsjbw==
X-Google-Smtp-Source: AGHT+IE0Ca2qfQkE6enrGukSoNDCb1OXtuL9IDZszmjiWUcu3f+9cYN/mXNgIzl2i4wDmR90/hv9yYRTETUzcz21Ipg=
X-Received: by 2002:ad4:5d4b:0:b0:635:da80:e53a with SMTP id
 jk11-20020ad45d4b000000b00635da80e53amr4483115qvb.12.1694532836379; Tue, 12
 Sep 2023 08:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230912060801.95533-1-bgray@linux.ibm.com> <20230912060801.95533-2-bgray@linux.ibm.com>
In-Reply-To: <20230912060801.95533-2-bgray@linux.ibm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 12 Sep 2023 08:33:42 -0700
Message-ID: <CAKwvOdkP1uwU0Cq9541zf309tudfFdbu-10Xo3h+g07-k=Fg4A@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] ia64: fix Python string escapes
To:     Benjamin Gray <bgray@linux.ibm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, llvm@lists.linux.dev,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Todd E Brandt <todd.e.brandt@linux.intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Sep 11, 2023 at 11:08=E2=80=AFPM Benjamin Gray <bgray@linux.ibm.com=
> wrote:
>
> Python 3.6 introduced a DeprecationWarning for invalid escape sequences.
> This is upgraded to a SyntaxWarning in Python 3.12, and will eventually
> be a syntax error.
>
> Fix these now to get ahead of it before it's an error.
>
> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
> ---
>  arch/ia64/scripts/unwcheck.py | 2 +-

Ard is proposing removing this script, along with the rest of the architect=
ure:
https://lore.kernel.org/linux-arch/20230911163129.3777603-2-ardb@google.com=
/

So this change can be dropped.

>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/ia64/scripts/unwcheck.py b/arch/ia64/scripts/unwcheck.p=
y
> index 9581742f0db2..adc24152d3b9 100644
> --- a/arch/ia64/scripts/unwcheck.py
> +++ b/arch/ia64/scripts/unwcheck.py
> @@ -21,7 +21,7 @@ if len(sys.argv) !=3D 2:
>
>  readelf =3D os.getenv("READELF", "readelf")
>
> -start_pattern =3D re.compile("<([^>]*)>: \[0x([0-9a-f]+)-0x([0-9a-f]+)\]=
")
> +start_pattern =3D re.compile(r"<([^>]*)>: \[0x([0-9a-f]+)-0x([0-9a-f]+)\=
]")
>  rlen_pattern  =3D re.compile(".*rlen=3D([0-9]+)")
>
>  def check_func (func, slots, rlen_sum):
> --
> 2.41.0
>


--=20
Thanks,
~Nick Desaulniers
