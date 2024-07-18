Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F058727269
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721317511; cv=none; b=g1Z4FO6WWrUeNwKb07/kqMuRygozrdsPkNLfIUF9fDCCr2ftRuEOpWpMDo2fGQLWx5y47jAUHjXsf+TTgFes38r61DZUx7qFcFmz3YG0aQz/o2xiMgkvrPTObyNAaUDzP1L8R2aYAHN0OokWPoZv3facTzDxeMN2AJnNfgdfGaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721317511; c=relaxed/simple;
	bh=+iYCEV4jnUP+xMe0ntI8OP1dBwqyZjF6AplmoGAlDRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHxinEfnpPBW3JCkN4r47CEqJGCJyMWlsBQH0cXwiLd2bxu6r+dr0LVxxgvdR0DP7Pabk6aWEYmXvoMtfSqoI9KD+PkDMmM/GKkIbeydVQikA40sS+Mgr6+iEHiLkVE7ifFTwSFH/jp6M4zgbg8l0/tZRgZhmUbdWBoNZ9Xsmv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ndl+M5U8; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ndl+M5U8"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44e534a1fbeso123251cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 08:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721317509; x=1721922309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1TIacI7GtvAJO8Y15W9fPDXH2ieEjKop8QJs+VMXnA=;
        b=Ndl+M5U8S9IrB7H/c6kIH5GSxcWL88nvhZLQ1UchDkQSO6RoBxVouz9hTu0c+aF/DY
         lelaKMqXiZv6wMO9mvwsoQcFrnC6s/j3aR39SEHb1hk2678Fylo7eaAXX/UQHPUBx22c
         WngiVJe3ECVLmlVvQzw1Q3GIU+Vg66GEdIEG7y2o+D58xLH7E5NyXnJr4qdVpIZYbaZo
         vCApbeE+zF/yzFIDdHjYaCuNSMwKZUejvtkyswbXN5fKz1LNXgi7EkrvNvCPiZM/RtT+
         tdOVHisud9G30BOrFRKYYR5WA8W1C9k4r1jt6Rbolcwo6p7SJSs9NQEfvSj5nTieYULy
         1Kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721317509; x=1721922309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1TIacI7GtvAJO8Y15W9fPDXH2ieEjKop8QJs+VMXnA=;
        b=ok2d+HAq0blEvUYMSMkWcyjNr9hxZdh3/FqWm5kbvsXeDrvVY8sG3bfYspmS0nRf8Y
         vfLT40U3Octjl9t3EjLAA8RP1x2rZfjATRF08Vavcosymuw4wbLiWigzngz21qW2Qcf4
         Mped27HGge4aKHHQ6oy4uU2HSNvPDv3cXoHEJ/Acykw/6wBv7fEjEpKYtVlJ3UiRtjLG
         WOSVBR5dVayURemeWOk73HCsdm/VxBsQ0GRWAqK3SFLe7lyF+rcEd0QWlok4gPqu2PY/
         CmmbPPNO03Iqs5jlw3UpiG8HuU1xdnDnfd3f2VXTtms0JIgdIO0RNmZJg8cgpTw6PRk6
         nKwg==
X-Forwarded-Encrypted: i=1; AJvYcCWwsKZ8sHFmQWfHhPR5m1GHC3N0LKexEQE4o3X1IWnpjJJjTAUI2Mp8phk+q20uhHNnuSC1a2JkgBe985rySxQhJoOx0cu59zDBqdsvKexULw==
X-Gm-Message-State: AOJu0YyyuMP5bFXJxuioscymaMVMaPklLWlWaxFKr17No+/+BGaCzYnv
	PpvNR00pW4S1CaIg+IO5X2B+K4vC+p2uh4dbGqKUu1ZhGxGXeDTY4cJP00YgL/fDb0DtjTKoZv5
	YLvDIlRsJO9sPkmYwHZzUZu3cBKqkqGpFtp+D
X-Google-Smtp-Source: AGHT+IEvc46D6GqoAanelEA1ZPr2HWAK5uEFLCCXFpZ9Egj2KviVkDj9kSEH/ZP/2etoP4j1QH+RJmJeg9YMh71gSJQ=
X-Received: by 2002:a05:622a:5196:b0:447:dd54:2cd4 with SMTP id
 d75a77b69052e-44f96aa05d2mr1652561cf.22.1721317508578; Thu, 18 Jul 2024
 08:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718143009.197851-1-m.liska@foxlink.cz>
In-Reply-To: <20240718143009.197851-1-m.liska@foxlink.cz>
From: Ian Rogers <irogers@google.com>
Date: Thu, 18 Jul 2024 08:44:57 -0700
Message-ID: <CAP-5=fXPC+pXmJCpvkr5x2Ae1hdKeL7Cd6Uak+7mn+uG+R8yVQ@mail.gmail.com>
Subject: Re: [PATCH] perf script: add --addr2line option
To: m.liska@foxlink.cz
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	acme@kernel.org, Martin Liska <martin.liska@hey.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 7:30=E2=80=AFAM <m.liska@foxlink.cz> wrote:
>
> From: Martin Liska <martin.liska@hey.com>
>
> Similarly to other subcommands (like report, top), it would be handy to
> provide a path for addr2line command.

Thanks Martin, lgtm but you did put a Signed-off-by tag in your commit
message. There is an option in git commit and git format-patch to add
this for you.

> ---
>  tools/perf/Documentation/perf-script.txt |  3 +++
>  tools/perf/builtin-script.c              | 10 +++++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Docume=
ntation/perf-script.txt
> index ff086ef05a0c..5abb960c4960 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -369,6 +369,9 @@ OPTIONS
>  --demangle-kernel::
>         Demangle kernel symbol names to human readable form (for C++ kern=
els).
>
> +--addr2line=3D<path>::
> +       Path to addr2line binary.
> +
>  --header
>         Show perf.data header.
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c16224b1fef3..301ea1c98e36 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3897,7 +3897,7 @@ int cmd_script(int argc, const char **argv)
>         };
>         struct utsname uts;
>         char *script_path =3D NULL;
> -       const char *dlfilter_file =3D NULL;
> +       const char *dlfilter_file =3D NULL, *addr2line_path =3D NULL;
>         const char **__argv;
>         int i, j, err =3D 0;
>         struct perf_script script =3D {
> @@ -4052,6 +4052,8 @@ int cmd_script(int argc, const char **argv)
>                         "Enable symbol demangling"),
>         OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
>                         "Enable kernel symbol demangling"),
> +       OPT_STRING(0, "addr2line", &addr2line_path, "path",

Thinking out loud. I'm kind of wondering why we use a local variable
and not just &symbol_conf.addr2line_path here. I see you've used the
same logic that is elsewhere like builtin-top.c, so I think it is
okay.

Thanks,
Ian

> +                       "addr2line binary to use for line numbers"),
>         OPT_STRING(0, "time", &script.time_str, "str",
>                    "Time span of interest (start,stop)"),
>         OPT_BOOLEAN(0, "inline", &symbol_conf.inline_name,
> @@ -4138,6 +4140,12 @@ int cmd_script(int argc, const char **argv)
>             itrace_synth_opts.callchain_sz > scripting_max_stack)
>                 scripting_max_stack =3D itrace_synth_opts.callchain_sz;
>
> +       if (addr2line_path) {
> +               symbol_conf.addr2line_path =3D strdup(addr2line_path);
> +               if (!symbol_conf.addr2line_path)
> +                       return -ENOMEM;
> +       }
> +
>         /* make sure PERF_EXEC_PATH is set for scripts */
>         set_argv_exec_path(get_argv_exec_path());
>
> --
> 2.45.2
>
