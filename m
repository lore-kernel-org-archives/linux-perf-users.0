Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE6D1097B
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Feb 2024 03:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706930484; cv=none; b=c8mKM522eNJl7nLDCslfCdD6guL33huhAag6i6+7X0DO3KOkLUDUeBZ0RA3WfZoZRQNbyKymDlSXGzptvywbQTvqZbFXboD3JpiuoYiww4oxswHJVMEhVL/UEvsCW2YST3GN1mm5ToXhuG9AR5yVSHdupFUBg4E8JJpSKT8Euo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706930484; c=relaxed/simple;
	bh=9bbV8v/XesQnkV5S5/dZRkkgLTcqBfC/AF/L1stS04Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iC+IW8MJnrRfOyWiheRO9de57ax+hj4fNTXIF/wYSYLnKLXdRp0UFlahrZCRcypcHDpsXzM7WpSnFk1h4y2n3LvcsKKUS4UtGdtI2yRlypjsZwRk5ruyRcOR9zSfpxmafCpJyIy+k+PpDfxJOrwQ2aKzOjsUoYTzvjEp6jyM2lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qHkpa9F/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qHkpa9F/"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d93b982761so102175ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Feb 2024 19:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706930482; x=1707535282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2u//wf4yb5ku/Yg3213XLgXCGYC5NdB6fyXKhm401o=;
        b=qHkpa9F/YQAHgsIY1cE+pRO7lp/6i+GDZGr+gE8QVkhMrj+SARkA8sy/2Zv5T+v+di
         36XHVja/pGHY1E8SFTdkHVUaUc03di5KE5CLR4oAZKFzRWiLRBWCnNJrSXv1Y+5D2/X5
         XKeek48k1xsFgMGnpEuTuuoJBeghpuRWDKGUC04TISw1Vn7df3btrxdoVeUZ4LlqUyCm
         q1i9DwRasaOl7RAypjjDb/9R/nPdjKGiF479KxPe3Is5802sEwt8mf0wFEVFkTi8TzBU
         fi0p1KUe1mYXKjEiYfhdf/hwFZ5OyzXG9AprVu8Px6Plmb6VPbpWV7FDtaKg7SH6rSds
         Wm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706930482; x=1707535282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2u//wf4yb5ku/Yg3213XLgXCGYC5NdB6fyXKhm401o=;
        b=GJozPCFRafckG6yu+JjgmJVzetNECj3Uvheycp8Lom63KhphTyVkQQegaf0KzUnb5R
         BpF9glJcKUL6xYVElzAchlGO+Q99gYJwaew6AtE9J4a2oA3QfI++sU5i09XQMrzMyO43
         4HPiKweM64Z7Vt4DcG+RQdXwwbwkyNz0OKQ2oxlWe/zdEdrWNYb7sEdPhCMX3GabGagg
         kvJRjyk8E9f7Z3jj3sHTrFmYLlaLAmmr2alAwVNQl90ot5W/qk0FGiVaRk58eVG8RZsC
         AYDJ5/avcN5vWXxu94MQsSPQ4uzadcAIY220gtmSqWbSV4lNxoy3Izri9ggCqBq8YKLo
         s3Rg==
X-Gm-Message-State: AOJu0YyBhofgLxzBDOL/zRPpHobrc1tljpVSybVP5pMlHd8Ww2NJc0vY
	9XBvY2mk3575cpQXlkJ3HQBu6Dl+vITpOKMGZakt/NFTqo4I6iDdwbn15jiDI/XpqndlUZyOZNx
	aqj4nJUKwxlNsVvWbGDLuDs8AfIt7Y/R1Abse
X-Google-Smtp-Source: AGHT+IGAk0k1DBjlKTa3qXwHjikNO3DQIpo8PmfE1+IuKKtWK6lfiPhAVz0TF2wE8HETTzA62P0HIaMI9gbDNxccIdI=
X-Received: by 2002:a17:903:608:b0:1d8:dd63:674f with SMTP id
 kg8-20020a170903060800b001d8dd63674fmr70951plb.5.1706930480522; Fri, 02 Feb
 2024 19:21:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202220459.527138-1-namhyung@kernel.org> <20240202220459.527138-15-namhyung@kernel.org>
In-Reply-To: <20240202220459.527138-15-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 2 Feb 2024 19:21:09 -0800
Message-ID: <CAP-5=fUWaKW7d6_YkET0o26=fjBwX6PPJ1gXQ9wndQM_Oi2O3A@mail.gmail.com>
Subject: Re: [PATCH 14/14] perf annotate-data: Add stack canary type
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 2:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> When the stack protector is enabled, compiler would generate code to
> check stack overflow with a special value called 'stack carary' at
> runtime.  On x86_64, GCC hard-codes the stack canary as %gs:40.
>
> While there's a definition of fixed_percpu_data in asm/processor.h,
> it seems that the header is not included everywhere and many places
> it cannot find the type info.  As it's in the well-known location (at
> %gs:40), let's add a pseudo stack canary type to handle it specially.

I wonder if cases like this can be handled by debug info rather than
special cases in the tool. Special cases are fine too, but are
potentially less portable.

Thanks,
Ian

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/annotate-data.h |  1 +
>  tools/perf/util/annotate.c      | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-d=
ata.h
> index 0bfef29fa52c..e293980eb11b 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -77,6 +77,7 @@ struct annotated_data_type {
>
>  extern struct annotated_data_type unknown_type;
>  extern struct annotated_data_type stackop_type;
> +extern struct annotated_data_type canary_type;
>
>  /**
>   * struct data_loc_info - Data location information
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 5f3136f57c62..f2683dadf3cf 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -116,6 +116,13 @@ struct annotated_data_type stackop_type =3D {
>         },
>  };
>
> +struct annotated_data_type canary_type =3D {
> +       .self =3D {
> +               .type_name =3D (char *)"(stack canary)",
> +               .children =3D LIST_HEAD_INIT(canary_type.self.children),
> +       },
> +};
> +
>  static int arch__grow_instructions(struct arch *arch)
>  {
>         struct ins *new_instructions;
> @@ -3764,6 +3771,17 @@ static bool is_stack_operation(struct arch *arch, =
struct disasm_line *dl)
>         return false;
>  }
>
> +static bool is_stack_canary(struct arch *arch, struct annotated_op_loc *=
loc)
> +{
> +       /* On x86_64, %gs:40 is used for stack canary */
> +       if (arch__is(arch, "x86")) {
> +               if (loc->segment =3D=3D INSN_SEG_X86_GS && loc->offset =
=3D=3D 40)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  u64 annotate_calc_pcrel(struct map_symbol *ms, u64 ip, int offset,
>                         struct disasm_line *dl)
>  {
> @@ -3938,6 +3956,12 @@ struct annotated_data_type *hist_entry__get_data_t=
ype(struct hist_entry *he)
>                 }
>
>                 mem_type =3D find_data_type(&dloc);
> +
> +               if (mem_type =3D=3D NULL && is_stack_canary(arch, op_loc)=
) {
> +                       mem_type =3D &canary_type;
> +                       dloc.type_offset =3D 0;
> +               }
> +
>                 if (mem_type)
>                         istat->good++;
>                 else
> --
> 2.43.0.594.gd9cf4e227d-goog
>
