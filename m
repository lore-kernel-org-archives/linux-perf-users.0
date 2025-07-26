Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CE17DA9C
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Jul 2025 00:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753491499; cv=none; b=CKSr5zSRxmc5jO5amm3hinLZrb7yORBndNrzbwhiIsfchyU7spxBvFgziJi0l+IUGeKsGbXOtlUSP8I68IGGnevBeGP7WPerCUCV1h4YvTuFcViH1qPIhswRSgfQScBYKrt7dLUShg6lTRojaOyQKwm8jJgbwr0aH2uYGeqZwDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753491499; c=relaxed/simple;
	bh=DIf6O7PnWgEkqOWfZT2pbDIF9srrUdRo1wLN+ipZlJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElTeNz99BqlflgCyFhg+i94PUDDpdiVSoteuqmFXjwjDlWHmkLfrT5lWGzTce8GSn4KYLDv4ZNpr2RoXPM7vcGy5UmFjXe92U+Y+QRg++yfgzwjeeJC5p40mcUyA6jccsF+bGHIbqG/NcUSJFBwdXQd8mCNzYvg281DBiLKR9tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VVDe0V+b; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VVDe0V+b"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23dd9ae5aacso45805ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 17:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753491498; x=1754096298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fplU80zmFpf0ULHak+TNWOazTGxzQTr6hTMAaKKe0E=;
        b=VVDe0V+bTGJ+juYXAVS/iuSUAgn5R+31oniOzyoXUCjpJ+8TjH6RKQ+TdUQsWDdivj
         61uW6ICS6q5kq6oXFdZ/yg9Ok1poDbaiA+Z486dd2Zvs7V+lVMyFKsG60J+lDWpdpoQH
         RwWZEj8vxNefHEooXSxmfD9OrGmDPXeL1AkRaz2mDe3msrRuMSU3Nh5ObqWep28HxOpp
         q92hlBwmPSccVrInz4EON69ynZzXa0oSUl4Z8nj1gV14xuZzZAEpFnrpyo1sz/OGuloY
         bISufNYy8RYhNmtkHWritRFnU6sm0VKeU268IPOOg+KrPjMVNW+gq8+SLGFgaTcxFM10
         Ju1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753491498; x=1754096298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fplU80zmFpf0ULHak+TNWOazTGxzQTr6hTMAaKKe0E=;
        b=c/3S4cp7e8o9CTIpgNXPcmUrF//KaCvkWo6dkvxFDv+BDFZX8KVi+qCh0GmtvzD5QI
         +BbWfupSnC+VZCrTsAN3rdL87DHdrTvkXYQyv5ElweDQGD87l3JNIzoakv5dVfLtsZw8
         MYPvbIwzw9yRePEm4nKRUC8ShbLluhkt8kVz9HK7A88IdaRkkZ+KxUqk+lF+I1hx5S8F
         M5ylexdCUhvKTFiqLY7ZAI5p2PnXrlMLxq8X+xtNpqQt6UDGoPhqGQzrzkNmGey0DgYj
         nqQY0fYTn85gIhjjtIapHIcfs8/fV0w3k3zP6zOpq6Kz/lj+eF/xeohnQaBRo99QmnAa
         PwBA==
X-Forwarded-Encrypted: i=1; AJvYcCUH6zfYkFepvFsPLBzu1qpFR8DHNTlBDJ/svBgNiX/YYvJ7dymW28J3nvxetXyfh1CeV7b4l/tmz/oQ80mNT4rf@vger.kernel.org
X-Gm-Message-State: AOJu0YyRjNFN6SLeA0HM5QB3lSe7wx2t/B5J3TwzyMwTOiK8pjXZJWjF
	QuBHQCp2oDQCnsS9+CwYvWkhhVDTMw1EKDI71VPA9uQRrmb5I3TaySY5G3fkWmzpd2SUYiJnMaK
	bfhXcNWBidBZWbTII3EN9YGFILgFYGDpXSHKgHY6t
X-Gm-Gg: ASbGncseEaVgcwTQZfAMMMO7BuEQ9+I9y5Nu8bo6PN7LEedgIII09QIh71zQTJirHLS
	Z/BbFTHDIYj1SX3CAver3ZQduCjRp3Od+VGcnR4GjRV8N/Ceq3mrexaik321wrBYrT7JJShAaES
	TTWjS9JJ+ilEbC8CEUSQTzKEbv4Ukq3o/fzd9wIl9sNpCup2gD9M9GYzvfB7BGPLgHXTbFLciOc
	cELbzyo
X-Google-Smtp-Source: AGHT+IHeyEi742aFO3hV++AeipeYKf/qUxIOv48p8HeoniBt1Dakppqs9grY2COUbSw6mP1pEx8383vgJzT2eDE3tHY=
X-Received: by 2002:a17:902:c94b:b0:223:fd7e:84ab with SMTP id
 d9443c01a7336-23fbfd1a554mr1233415ad.24.1753491497158; Fri, 25 Jul 2025
 17:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725202809.1230085-1-zecheng@google.com> <20250725202809.1230085-2-zecheng@google.com>
In-Reply-To: <20250725202809.1230085-2-zecheng@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 17:58:05 -0700
X-Gm-Features: Ac12FXzpELJCcryfhuSE4R5Cmu-ZJknOKDSv3fvvFdgvz8mX4aUbhKb-Qd_Capc
Message-ID: <CAP-5=fV3KaHMR1eFtUh0kY6CmVkZjw8vJ0UNcY3phH=2jsiwyg@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] perf dwarf-aux: Use signed comparison in match_var_offset
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Zecheng Li <zli94@ncsu.edu>, Xu Liu <xliuprof@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 1:28=E2=80=AFPM Zecheng Li <zecheng@google.com> wro=
te:
>
> match_var_offset compares address offsets to determine if an access
> falls within a variable's bounds. The offsets involved for those
> relative to base registers from DW_OP_breg can be negative.
>
> The current implementation uses unsigned types (u64) for these offsets,
> which rejects almost all negative values.
>
> This commit changes the local variables within match_var_offset to
> signed types (s64) before performing comparisons. This ensures correct
> behavior when addr_offset_ or addr_type_ are negative.
>
> Signed-off-by: Zecheng Li <zecheng@google.com>
> ---
>  tools/perf/util/dwarf-aux.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 559c953ca172..bf906dff9ef0 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1388,10 +1388,12 @@ struct find_var_data {
>  #define DWARF_OP_DIRECT_REGS  32
>
>  static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *d=
ata,
> -                            u64 addr_offset, u64 addr_type, bool is_poin=
ter)
> +                            u64 addr_offset_, u64 addr_type_, bool is_po=
inter)
>  {
>         Dwarf_Die type_die;
>         Dwarf_Word size;
> +       s64 addr_offset =3D (s64)addr_offset_;
> +       s64 addr_type =3D (s64)addr_type_;

Would it be better to make the function take signed types? I'm
thinking if a 32-bit int is passed, with the signature as-is it is
unclear if sign-extension will happen.

Thanks,
Ian

>
>         if (addr_offset =3D=3D addr_type) {
>                 /* Update offset relative to the start of the variable */
> @@ -1414,7 +1416,7 @@ static bool match_var_offset(Dwarf_Die *die_mem, st=
ruct find_var_data *data,
>         if (dwarf_aggregate_size(&type_die, &size) < 0)
>                 return false;
>
> -       if (addr_offset >=3D addr_type + size)
> +       if (addr_offset_ - addr_type_ >=3D size)
>                 return false;
>
>         /* Update offset relative to the start of the variable */
> --
> 2.50.1.470.g6ba607880d-goog
>
