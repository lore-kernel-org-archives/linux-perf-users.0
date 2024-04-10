Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44B217F377
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Apr 2024 19:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712776493; cv=none; b=JZkfkB3H3tYMt8bv2r2gRPOgP3Ox7kPC04fQ4uaVbfrGpA8W6Kr5FZ25xLD4TgbNzstGIKPbd+k1L4ioLVeQfPDlgCF/Xy/vX+FDQaUg8VWkGDKEqDNaAMQQf3YUQLVFJEpYJ/C3fYCMFyTeiyeOhwFP21UJRj4Icr0D9kaLl+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712776493; c=relaxed/simple;
	bh=1svL0E74yAjpQMbTutyztcwNrRVSEN5XvfFbGICi+Zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gG7juhx5ndQNK3l9McniCkRlo9p6LWQ34LbXtphXoRvvgdEHMk8rtzTCzoibLm+oJaIO4FUPsyEENAlEF3aQh9Sph+Pn/eQptB5WmGn59dwhDsuG44i+jZBeUMRQYZuHY0uZjgTYsLym3kTL1IFydFpTKl75HCA8VXas0OstjGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J8R0v2V6; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J8R0v2V6"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43477091797so56321cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Apr 2024 12:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712776491; x=1713381291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnSzzFgP2liAY4gSnshhFACs6sQ4XACv2JFHDRUpzPA=;
        b=J8R0v2V6gHZEtzvofZ/erUeB0bClsvAtgKVPe9YXzsfRluAJkhffpF4lRmT6yXdNX+
         vKhSjurTB9HisjNg8sHokfKQ/9jLxsIozqs4VJQhPHPW6xmt7UF9fZ2XcvmovbzR7EQF
         QfZSf6tVFwZFpiaOhVVRfTTTHH1cvJWbDQ3AatGkpid+9g0uz11PIFy6NJ57KnaxxCjO
         TxrmFProz1T2RJiKDBWhH2bd64SAVhhAqWaqi+lJSSQxw3+kM5o8p+eTgsKK20GYqhnX
         2NmO6d4Nwg0KU3sm/4+MOIZxtEkd9gj6ahPS8RbqnsPhEGykuSmakUxF70hVDy/zysFt
         epzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712776491; x=1713381291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnSzzFgP2liAY4gSnshhFACs6sQ4XACv2JFHDRUpzPA=;
        b=ZubbG++gxKVY5pbsCdpEJF6rKfjWAcbOQKp0jgWQOHIc/LPy1cyMdoswYLxdmt0wWs
         8pFN1nZVLGTA/s9VedWs1knN6Q69pGJPPfim9G9NZ+gtYkEfY+q87y14zfcWZ7NU4KsP
         wqKJYkW2y6sAmvajowyzX2M2YYVvhrIDKE7s8QPEX35WjiS5A+65h7hlCbAkvcXMz9fN
         i0ylKpBxM0aTsgxfUiz98MzykCehgv3UMqspEze51SHUHLDMInaF15MD8SvXDc+VkXIY
         CYtkPzyFImhxse8IBQG/4twHE7ok9UP1b9ahjm/KNGVxWtqYAYa5e5M9PfavZz+4ldK3
         0WtA==
X-Forwarded-Encrypted: i=1; AJvYcCWcTkf9CnrC2f6MdaGB+NdbjDSmd5bxzpEgB5i3LztiTipnsRImy4uIq7IgiiKwiMUmws/72t/+zy9qAbT/ElavCYQTAyu01IuAS5DKl43e4A==
X-Gm-Message-State: AOJu0YxgmyLPkfaq0NJCEjBubUBtFPZcLJRalO6RiL2Lw69prZKeJrpa
	FdwamJwQBjuYpbRxVqzoDU9aCyUHus1e6PmKzKmga/xfnw+xwpXhjusYE5BGalLhcwZvTuKl2HE
	dfeK2e8HRrcGFi8T+zboI7sEg93PJlYTojJ5l
X-Google-Smtp-Source: AGHT+IHXVM/rxOkvyaDPAoKQ59qRsklTHGKlP31SHouUdoafoSVXDuobM6bY0ykUcWsmXEHIn5XFlcm2mx9dboBqHMY=
X-Received: by 2002:a05:622a:4d88:b0:434:4a49:da75 with SMTP id
 ff8-20020a05622a4d8800b004344a49da75mr30363qtb.11.1712776490581; Wed, 10 Apr
 2024 12:14:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410185117.1987239-1-namhyung@kernel.org>
In-Reply-To: <20240410185117.1987239-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Apr 2024 12:14:37 -0700
Message-ID: <CAP-5=fXeM32=wnkMnp49wLYDS1PWwhKtK9UiKyAa=XvJz9kANg@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Skip DSOs not found
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 11:51=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> In some data file, I see the following messages repeated.  It seems it
> doesn't have DSOs in the system and the dso->binary_type is set to
> DSO_BINARY_TYPE__NOT_FOUND.  Let's skip them to avoid the followings.
>
>   No output from objdump  --start-address=3D0x0000000000000000 --stop-add=
ress=3D0x00000000000000d4  -d --no-show-raw-insn       -C "$1"
>   Error running objdump  --start-address=3D0x0000000000000000 --stop-addr=
ess=3D0x0000000000000631  -d --no-show-raw-insn       -C "$1"
>   ...
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Perhaps: Closes:
https://lore.kernel.org/linux-perf-users/15e1a2847b8cebab4de57fc68e033086aa=
6980ce.camel@yandex.ru/

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian


> ---
>  tools/perf/util/disasm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index a1219eb930aa..92937809be85 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -1669,6 +1669,8 @@ int symbol__disassemble(struct symbol *sym, struct =
annotate_args *args)
>                 return symbol__disassemble_bpf(sym, args);
>         } else if (dso->binary_type =3D=3D DSO_BINARY_TYPE__BPF_IMAGE) {
>                 return symbol__disassemble_bpf_image(sym, args);
> +       } else if (dso->binary_type =3D=3D DSO_BINARY_TYPE__NOT_FOUND) {
> +               return -1;
>         } else if (dso__is_kcore(dso)) {
>                 kce.kcore_filename =3D symfs_filename;
>                 kce.addr =3D map__rip_2objdump(map, sym->start);
> --
> 2.44.0.478.gd926399ef9-goog
>
