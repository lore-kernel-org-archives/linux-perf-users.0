Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C181D3A0B09
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 11:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082428; cv=pass; b=b7Wbbv8IqbMPp8GJTt1lffUgsHyjOFa2NtV4kpPyXEoAlsmHpWR+Qj/yJml42GtsJFK/Js8TCDdE9l0HXX91twD0uZ0JIucqM3mP1JQyli4MAkimJ/zMI5npoZZdjtxi/y8DgW9lZO/VH+TPIXiAdJtKftpzYXYcik3IBfhzp2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082428; c=relaxed/simple;
	bh=n4SQWlevJx/WdvMfV1rCMA1VgLwX7M282m1WRU8aY5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9NP4t16Jipz0yqOEYfYWe2jj+2oHtlazMKsWlg4GBvmumAUaCVV/loTTgtJHeMARpP0PHSJEPFbJvFwH+RIXP84/TIQCSWaBaZIBz/poEnlQlAuxA+ma7sDGe9Hbu9T/aVmWUehM6+ZdBpc8eVcMRgVtql7XbIhGSCKcVJdvOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpYOiGHi; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpYOiGHi"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-45c958d480aso300575b6e.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 03:47:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769082424; cv=none;
        d=google.com; s=arc-20240605;
        b=FwiZSeXEvxWOG6ps3m3Ma7GbiF3HXWhyIvgkA4XlhUDleGIc2hgTWe6gx+byJkpGdW
         NRnJT88qe8H/RJ+qunrXKxQhXplrmOkMCZ2M1Y6DIRW8Ip8+iRZJMX8TJ1SSLQGLI+ji
         CHyYFfVhziGcmPPRKwn6f62PmnIruLRGLP4eAU3IuNAMo+hkKd3oxLLWQY9rLddUMYbG
         GcmQd6AcQTCvj2ohS8UUO5DF+TEAIvrOtHmESJc8jyvHzUaVT3R+HOEExWuj4J6SVYws
         0V7wjx23ds2U/G6XEwEAwOtC6BiNlTZ7RH20GbDuStJlmQB2erC99oUtNjSSPv7ozw4N
         Sv6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0GEdFKTShC0ZpJHoWL5oV3syGXTsJmRbqldb2CgIg7Y=;
        fh=GyfYlLVSM72dGjfs7ZbeVckrlJJGRMeCiWplFeA0Tyc=;
        b=JXtCG83RwagdywAbRjVPcpWjazoUQn64c8hicoggBpFW2lNW2rhKldqlNZBUkFoFic
         NPMiJKXXmeMFCcTrh47n5SUiywSxtfBHuoCYYxeDTZCSOmELedNMf//8FHpbSs7XKoMx
         aoOpU+Hy8XwCRwH3mTrwo7mc8lXGdtplTBIWknTElV90VMEA8XCh37vp4/hJH55i2uWJ
         VTEvp/YOm+yoAdJ2m44OQ+4Kz1Ae/KEx204EtY3cy4JRPfdOB1Erqf3JiskA0bILZlUC
         VzBrdvVL9SEx2YKwSlGPq9kiICRM/4JJdImu+iPENxvqojvKbnRcqhRdCCSXZcik834X
         +/VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769082424; x=1769687224; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0GEdFKTShC0ZpJHoWL5oV3syGXTsJmRbqldb2CgIg7Y=;
        b=fpYOiGHifCl8ph3SG9opZlgEx7T1SAyKjcthXICsV1xbmLpgi9hcJ1dJR9E+S+pdVj
         N9+V6A9RqdfpAWPTlX7qIeDpRVXc/G9cxInH2weyt1bkVNaJ8DO940dMfYP6f7X7zLZy
         3WotOZkCP+LVjvbayRFg0B78hIAGNXqDGC28qCfUpF8rdcM4d8I8Oh9JJBdqK/xn5l8j
         M1qc+E/p2gq5hl7GIeA+P1cuyZYmNHb0+lBBR6AxQMap5f7Vp35gT1jVQmZiAwhxfetp
         Hfnj7gGPAjaP/dOgUgwBN4HQbbmtH646Mzb6svTlSACfgc/fMatNK6+NXVP6yWsaC9/t
         x+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769082424; x=1769687224;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GEdFKTShC0ZpJHoWL5oV3syGXTsJmRbqldb2CgIg7Y=;
        b=pBR9MXNEldAmRLFfEqaqxQ6UhHkmuvXls2ksZx19IKlSVochVH1Qi8ii09gQHthl9p
         sJzSd0DHuLZ2RrhwgmPjtLbo4qqZILFKU92tA4UlickY7dikTIA7eQrq862H5ytUNuUk
         RQiM6KioCC0gNyGxWLiIg3+1E/ouFHYqX8xE8ZD0OFfvO0FsOC+Jh7B2vCSWltypzHW8
         QpPkWul9IB3Ak1yUIl810l/Fp9rBqkN7BNpO+llFQtg9P18MV2rpHMrmZP655bRUVLpg
         eoE7QC/Sts+KvTHvVLyWooEfQQx4cNP4OoY7fq0QCIQBouzCfdIFyn8r/dX4JXHdeZM2
         xDyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM4DMXXybBfW2lKmgicmQdcyUEOQL4/IsBTBBrXjVEITzuQmca7gi9ID6qZG81D8oP3Rw3h7Lfr/i6Sb9zQOwM@vger.kernel.org
X-Gm-Message-State: AOJu0Yx97ConSlBODK+xDSY8i8/G6pO+skSsG66lBvYJmx24Z1Pn+P7U
	3IRD2hX19GAifPEbxenHtFOHxEaw9tsld8uuyojBoizVvIxIQwMlRGRYHpc1qJ6yA2O29mI+6W8
	PEJmJlgDp0bdBN8uKwsyZqKr/jTVNNbyQ0HI4h/8=
X-Gm-Gg: AZuq6aKi9wKDOJCB30cdU1cQh7LONYmYI5tBuI+KUnX8yfza2Iv7/EmPGQ3xJbpjePH
	JVPg0J8RfiEY41ACni3D7mlTufnTdWr6eU3qtpiu92uU2jgSHw3qbG+E40I/YOdhYbqJGhxNxFG
	K/OTsG6F1W1UKoGtM14EaIN++UgLHgFWSXlwpuBIIpbDAJ0SRcnQS3jUnjW0JdrBYGWo2KsOVQt
	QBBGdpI/YqJf1yDqfxeTpQDiuBii9pgKg93ocqvuaQxbHqwKazPTQ4ackeQHXQW2UFVR4jB
X-Received: by 2002:a05:6808:538d:b0:450:340:2693 with SMTP id
 5614622812f47-45e8aa24273mr3205271b6e.42.1769082424420; Thu, 22 Jan 2026
 03:47:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122073127.375139-1-irogers@google.com> <20260122073127.375139-3-irogers@google.com>
In-Reply-To: <20260122073127.375139-3-irogers@google.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Thu, 22 Jan 2026 17:16:52 +0530
X-Gm-Features: AZwV_QjrC7BYx4_l0qj0u58o9jMWpinoFh5JfqyMmM-71XKtG3yyoT8qR6m_7W0
Message-ID: <CAO9wTFh01Qzn9tAiXf8_eGd7AAJiKzjmHNw-hBBCzcYR9Mb8xg@mail.gmail.com>
Subject: Re: [PATCH v1 02/11] perf annotate: Fix args leak of map_symbol
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Guo Ren <guoren@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Zecheng Li <zecheng@google.com>, Tianyou Li <tianyou.li@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

> @@ -1119,7 +1121,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
>                                       struct annotate_args *args,
>                                       char *parsed_line, int *line_nr, char **fileloc)
>  {
> -       struct map *map = args->ms.map;
> +       struct map *map = args->ms->map;
>         struct annotation *notes = symbol__annotation(sym);
>         struct disasm_line *dl;
>         char *tmp;
> @@ -1151,7 +1153,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
>         args->line    = parsed_line;
>         args->line_nr = *line_nr;
>         args->fileloc = *fileloc;
> -       args->ms.sym  = sym;
> +       args->ms->sym  = sym;
>
>         dl = disasm_line__new(args);
>         (*line_nr)++;
> @@ -1172,7 +1174,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
>                         .ms = { .map = map, },
>                 };
>
> -               if (!maps__find_ams(args->ms.maps, &target) &&
> +               if (!maps__find_ams(args->ms->maps, &target) &&
>                     target.ms.sym->start == target.al_addr)
>                         dl->ops.target.sym = target.ms.sym;
>         }

Hi, a noob here so please correct me if I'm wrong.
Looking at symbol__parse_objdump_line(), shouldn't we be calling
map__get() when initializing the target struct? Since maps__find_ams()
now calls map__put() (after patch 1).
struct addr_map_symbol target = {
    .addr = dl->ops.target.addr,
    .ms = { .map = map__get(map), },
};
This would match the pattern used in call__parse() and jump__parse()
that were fixed in patch 2.
