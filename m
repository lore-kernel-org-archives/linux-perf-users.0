Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731FD1448C1
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731342242; cv=none; b=dKj0sQqqRDkXdkBw7tZamf0fDsfOyMpfnV+jBBxzLNAo/v2beSidgWLSml8yzT8+ObzUQXEu5TprsGqMMH+I9fpZMttdo2qQyq32/s/pEZcANggu6OzaFf75WOKLLQsnDfvpNHxvcJNFgZIJ/+GX95mln0PGuwxNwrsO3PYd09Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731342242; c=relaxed/simple;
	bh=C/ZKJtEMz0SyqVbvSf5hB1w0Xf7+ekrT+ab+K2Vfzic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=or5GjFts9gLNRIATSgBUBEc9GN03+C+4L5BQJQEvixN7m2fD0y/xzCblXgyq3f1Fi6dgEcREE9SI6BypD3vuhiV7mFU9XxCrcrEMv96S6Lt6O60lK/eZp7t3EhbfiF5a3HLsyuMVFAXJtrHAKb02qquQ7D/JC5p3P7NLtIK1wx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJ5f6xqk; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJ5f6xqk"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c8ac50b79so285755ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 08:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731342241; x=1731947041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWQfL3C9nyhxBVUKmcisEF1opkOxSNvHHHeay6Me78A=;
        b=bJ5f6xqkOmd5WgIAmWgla2vTuX6wNI+DmYmnbbVLbMN+w2M1dO+XzeOfk1KUfAtA5Y
         1pQZo7IVA+EZVi5eHCqjSre7Mi8ipQc/RS3sQcr8/CDsFaG/3Bexc5Mv4MuYRTaDGod0
         F3qWQT2GxlhTiIslSCIS/B/DtTTq9aETcgZIZE6cwpIzbUxYDjKEFKJrqp5esjPH3iNb
         KDoLHhLrdfjG51LO8v0nuad5MtGZlHlKiz7qjYUAqzmOhoH61+yr2DT7xyITD+nBrt+B
         lK3kLKOWOiq3NTh15znr3GzkhBkxygh5aR/I7NQvLUqF/oAHgVnko+NV0EIYpK2aGEJh
         cOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731342241; x=1731947041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWQfL3C9nyhxBVUKmcisEF1opkOxSNvHHHeay6Me78A=;
        b=A/X1AE2Il2VfxITNZK06TkSi5bMpDbikGAymWyiI2J6kA08M4w10HVKAMJMtzn1z3a
         VND09y9jDBpe32OiNTS+uti45FynePAQ0FtTq+tIQIZy8SlC7bIALIr+9MfJLQ5T2tap
         OnkqZl8fDB0F++AxVG8ulf5ATUbxk/cbltaF4lh12yQYNlLd8sHUVSmTbIKxSrS8Ie5Z
         9zkbZmdREUrpBx7YTtHPexgeR6UNpUKAsNmv/ZE9olMwU8IyBFkU7ts++dc6dlrpbGrl
         Nl0aD8gfv1pUAieMNzRKRnGkewAVHDzfRoTVRbFB1v1jjgq3IW+2mvkLZmaAY68zrTdm
         spmw==
X-Forwarded-Encrypted: i=1; AJvYcCWTvf1Q1ge4zROhVJCm2226WasIHymkW7L4YB7ENHNw26BsScjCWtHdvXfDcv4mOKt0U9W9Srgl4weZwd0tMjyp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9aI3qW/qkER4OlUV+95YvdkGN9mQDJvPHyL0KAYyKg+8gXdYs
	1HSkBNySRQ1RtiXosYvXLXj3uPAVIT1VejV6CPP8tLDXPEa1d+WQAg73XOddJhABBffkEdtuQty
	EmajKGeoGuEkqcpH/F1n2kbjhyuAFkFNvkd/X
X-Gm-Gg: ASbGnct5j1b/OZG7WPRS/JIBEku7TD59bFyLDuO/h+WcEmJ7nrYg324JwIhA6RtQ2F2
	TIfK1Vydq5hMHTuhJSRbumyCLbyfYrNOW7IbHmLj8UgswauCSn+EDmAHwFPnGFTE=
X-Google-Smtp-Source: AGHT+IF8o7ng37E2Z0SqMFPiOzBfXFwrPVaJqZdBbfDN03WHyen5S0dOxbQQs+WjymC0RfUQLfWKoXh878ETXZfa6CI=
X-Received: by 2002:a17:902:fa4d:b0:1fc:548f:6533 with SMTP id
 d9443c01a7336-2118f0e8417mr3560495ad.3.1731342240655; Mon, 11 Nov 2024
 08:24:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111151734.1018476-1-acme@kernel.org> <20241111151734.1018476-3-acme@kernel.org>
In-Reply-To: <20241111151734.1018476-3-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 08:23:49 -0800
Message-ID: <CAP-5=fWWy8hAT+p3uO5S1sOhJhvP-tOf8fZ4xCC1DkY9Wd18ag@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf disasm: Define stubs for the LLVM and capstone disassemblers
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 7:18=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> This reduces the number of ifdefs in the main symbol__disassemble()
> method and paves the way for allowing the user to configure the
> disassemblers of preference.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Steinar H. Gunderson <sesse@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Ian Rogers <irogers@google.com>
Style nit below.

> ---
>  tools/perf/util/disasm.c | 40 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 36cf61602c17fe69..83df1da20a7b16cd 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -1422,6 +1422,13 @@ read_symbol(const char *filename, struct map *map,=
 struct symbol *sym,
>         free(buf);
>         return NULL;
>  }
> +#else // defined(HAVE_LIBCAPSTONE_SUPPORT) || defined(HAVE_LIBLLVM_SUPPO=
RT)
> +static void symbol__disassembler_missing(const char *disassembler, const=
 char *filename,
> +                                        struct symbol *sym)
> +{
> +       pr_debug("The %s disassembler isn't linked in for %s in %s\n",
> +                disassembler, sym->name, filename);
> +}

I can see why you're doing this but it seems overkill to have a
function just for the sake of 1 pr_debug. The #ifdefs make this look
like it could be doing more. Perhaps the style:
```
static int symbol__disassemble_capstone(char *filename, struct symbol
*sym, struct annotate_args *args)
{
#ifndef HAVE_LIBCAPSTONE_SUPPORT
    pr_debug("The capstone disassembler isn't linked in for %s in
%s\n", sym->name, filename);
    return -1;
#else
    ...
#endif
}
```
Would be preferable as the #ifdef's scope is more limited, you don't
need to hunt around for 1 of 3 functions, etc.

Thanks,
Ian

>  #endif
>
>  #ifdef HAVE_LIBCAPSTONE_SUPPORT
> @@ -1715,7 +1722,20 @@ static int symbol__disassemble_capstone(char *file=
name, struct symbol *sym,
>         count =3D -1;
>         goto out;
>  }
> -#endif
> +#else // HAVE_LIBCAPSTONE_SUPPORT
> +static int symbol__disassemble_capstone(char *filename, struct symbol *s=
ym,
> +                                       struct annotate_args *args)
> +       symbol__disassembler_missing("capstone", filename, sym);
> +       return -1;
> +}
> +
> +static int symbol__disassemble_capstone_powerpc(char *filename, struct s=
ymbol *sym,
> +                                               struct annotate_args *arg=
s __maybe_unused)
> +{
> +       symbol__disassembler_missing("capstone powerpc", filename, sym);
> +       return -1;
> +}
> +#endif // HAVE_LIBCAPSTONE_SUPPORT
>
>  static int symbol__disassemble_raw(char *filename, struct symbol *sym,
>                                         struct annotate_args *args)
> @@ -1983,7 +2003,14 @@ static int symbol__disassemble_llvm(char *filename=
, struct symbol *sym,
>         free(line_storage);
>         return ret;
>  }
> -#endif
> +#else // HAVE_LIBLLVM_SUPPORT
> +static int symbol__disassemble_llvm(char *filename, struct symbol *sym,
> +                                   struct annotate_args *args __maybe_un=
used)
> +{
> +       symbol__disassembler_missing("LLVM", filename, sym);
> +       return -1;
> +}
> +#endif // HAVE_LIBLLVM_SUPPORT
>
>  /*
>   * Possibly create a new version of line with tabs expanded. Returns the
> @@ -2242,24 +2269,21 @@ int symbol__disassemble(struct symbol *sym, struc=
t annotate_args *args)
>                         err =3D symbol__disassemble_raw(symfs_filename, s=
ym, args);
>                         if (err =3D=3D 0)
>                                 goto out_remove_tmp;
> -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> +
>                         err =3D symbol__disassemble_capstone_powerpc(symf=
s_filename, sym, args);
>                         if (err =3D=3D 0)
>                                 goto out_remove_tmp;
> -#endif
>                 }
>         }
>
> -#ifdef HAVE_LIBLLVM_SUPPORT
>         err =3D symbol__disassemble_llvm(symfs_filename, sym, args);
>         if (err =3D=3D 0)
>                 goto out_remove_tmp;
> -#endif
> -#ifdef HAVE_LIBCAPSTONE_SUPPORT
> +
>         err =3D symbol__disassemble_capstone(symfs_filename, sym, args);
>         if (err =3D=3D 0)
>                 goto out_remove_tmp;
> -#endif
> +
>         err =3D symbol__disassemble_objdump(symfs_filename, sym, args);
>
>  out_remove_tmp:
> --
> 2.47.0
>
