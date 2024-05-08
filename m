Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EEA52F6D
	for <linux-perf-users@vger.kernel.org>; Wed,  8 May 2024 23:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715211629; cv=none; b=tAAOweyOrGSgouXzaI7I45lBrg/9eKLIcYAJixTg2D3+efuqwdJe0hs9nGtlTAmRIKfQbei4z8WkMaSW0EQSNuuoL7R3hDFgI+2tjIQG3MD2e7q/P6jqSaVNHDHR+cfkuPwuIvkgFAUoe6lS8DrjYoZEwNkei0Mfy9VwOqY9bKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715211629; c=relaxed/simple;
	bh=+wtLczbdW/FxsW0T85EByS/LSghiVmxUEfbES7DYGDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=chhJPm7/1jvwZe5u6XWq1waHHxdNsFrfL1YFmccnBxgPhQ3jO/oU8/+UzUm5FRhuc4uwTnmCkjeyAWFVBE/LumNBJiYrPmSgu2JHuPW31PtP/v5boFQYg7Iy4On115sjs+AcaR4TY2EUwo9sZ+fFro3z0WU8aZJsYMygdIQiNEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2C6oBAML; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2C6oBAML"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-439b1c72676so94241cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 16:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715211626; x=1715816426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jATuZPpZr2U9Ga/FPqShVFC6Jp9UCpaINafz+jyTdg=;
        b=2C6oBAMLKFLjDyWQu95xlozNq2SrmzrLrPvjXVphkNrSmf7R7gyNzz3OBO7EStBSsv
         MgrQ4aGqBiEgBhC45gdoos4kov3NzbcDv4Nq2clnIt6SqSlO+Ji676gyaGt7IuPkKIeX
         351c/G9xg1ArAOHjcHg9sTYk+ZYMiJjXA3VYHsnvspCw5HUjR6L+iOiW5voGNyVjyXTm
         moLBEAWn0NGGrmF4Z2nl9DPWZ3Lg69nMeO0BFid29L2RkToEX88wMxrB61Oq3C4LXMNM
         FbHOvgMjtYw7pXNDMweIFrD0/xJf8IUQqXwpQFNALJLR8pvlDE+xr5wvipF2G7EYIsdD
         Wu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715211626; x=1715816426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jATuZPpZr2U9Ga/FPqShVFC6Jp9UCpaINafz+jyTdg=;
        b=W6zJpWx9KYAI47vliJmhV6ArXF/Kw+90R6nHG/51BcoDTB9p1ulXSehE5wrmxfi0Kv
         DL5VktOCyC1hSprHpsYmxorvgqHucttKhMWsN8OQu315O38/SImydQd7S12jcyOcL/gm
         Jc4IUG73XyjT2trwhf4zWOFf7j/NpXb15Qkloa6rvE+e/Xi7Vy2UG0n3xbRzUr3AeW6x
         vde3ONSPfMv3E/Cepiaz6nJpwunx7Ex0tSaLGK1ThRosw4x7RktFHUYgasozc4I8uzop
         Y/lJgMJ63+5Kwha3y51MTy+6zTTZwwFgp7e63tuqdQ1+9cC1y3MJq0GaHlTPWtb4xlW4
         48RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJVIl59VSvdKbTiiJFxKHLVolmAygTU+LEltlp57G6v7kUYtyNg220FIEolT1zFCu7lyWhF7VhjQWyHCDoMXgQa6bN2NOkYii9HacKLaMbCg==
X-Gm-Message-State: AOJu0YwQAde2i1lbUQxPzVvgk3D19KuNLZGeKB6aRp7z1NGdzqQC/NV5
	/oUp5me9OE3gekarxuu5xxbOUsJFKVw849nZP54sQczpeyUxXCq7evNyS/VlNzQA+ic2wbum/W4
	+0qArSkOnejaDWqHstmHbUUlXh0I8v/Qj8TIx69hMfpGvP46nKIoa
X-Google-Smtp-Source: AGHT+IEzM/v17pOrH2E0AcDlysaONbJ9WV32yZgY4IdcqsgZEc5Rc57AmhGuXksMDKk2ok6tUH0P85eZgXr+e2WgwZw=
X-Received: by 2002:a05:622a:2283:b0:43d:e9ce:63ad with SMTP id
 d75a77b69052e-43deec6a98dmr1246531cf.0.1715211626478; Wed, 08 May 2024
 16:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZjmcGobQ8E52EyjJ@x1>
In-Reply-To: <ZjmcGobQ8E52EyjJ@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 May 2024 16:40:15 -0700
Message-ID: <CAP-5=fVz8a29_k9-j4LnJdAoqiXAREwg9g+owx5WZ0LhgT7yTQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf callchain: Use zfree() to avoid possibly
 accessing dangling pointers
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 8:12=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> When freeing a->b it is good practice to set a->b to NULL using
> zfree(&a->b) so that when we have a bug where a reference to a freed 'a'
> pointer is kept somewhere, we can more quickly cause a segfault if some
> code tries to use a->b.
>
> Convert one such case in the callchain code.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/callchain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 68feed8718096f78..1730b852a947400f 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -606,7 +606,7 @@ fill_node(struct callchain_node *node, struct callcha=
in_cursor *cursor)
>                                         call->brtype_stat =3D zalloc(size=
of(*call->brtype_stat));
>                                         if (!call->brtype_stat) {
>                                                 perror("not enough memory=
 for the code path branch statistics");
> -                                               free(call->brtype_stat);
> +                                               zfree(&call->brtype_stat)=
;
>                                                 return -ENOMEM;
>                                         }
>                                 }
> --
> 2.44.0
>
