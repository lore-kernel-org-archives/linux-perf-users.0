Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793373968;
	b=vi9TRSyEy0B8gQjwUhAcYEL2DfwaPq3AVtH5ruphT8pz/MWyz3MJgS31RBxUOXhz0doq
	 Eminb4qqMVtMMPZX5+1WfJPzDLL/0GSCJG/spLwsGfmypU3ahVdqPirdw+q4+rLjVcP1c
	 mRDoR1kjhv7gZLuJpPe7iCN4Jf9DQChUDf68PlC9soNaeD1TZyZxjmRJdDcJBTuoNGeDr
	 /kHuK9RQMDDApcvkrWCTDJqmtnB9RC8nDm+myjChGd9eoaXwx5zWFDni+qAMjVsjQkgVW
	 hD9MmFgInjgy8oVaQDNuyyvLhoYENAzM0rDD3dB6N1h3aCfVWVCP8Cl3SfOW7yqYWHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373968;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8eskYuPqODoDNuy2RAjCMQwnvWJ8H7RTSHlA9+ib0kw=;
	b=YiGOqnYEnxZv7VnG+Pf5MxH+mEL+JEQPSdKVpPHdEBAmSAxoMnZFjo57ZAW5ngfEoW4h
	 pt/k1pPpb145LGULhK6kvNlsGKgTXAjaNlpwlyDmcQ7xglgcOeRZ371glbsGN0PnEQP8S
	 eDRYuqfrKZ++KXpdgVAOVZ1+aFoTRdNggqbH6SO7Ftxr+IyT+4aqmKDUWxHPA2ECAAqpw
	 /drfyuEO4o83BSz7eQ+NBF4Pto5GmUENJqWPSvPcpeWW2MTyLTQL6geoXfz69W0Y1fBsj
	 Rey5HDqZyRVwP/egGigibRsHD4jk96Dsq2Mny1Yb7R0Kc3Y+8Eqy/Lo2VO/ERB3SmRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I2uqagz2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537BD606A31F
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 15:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 537BD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I2uqagz2
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-535f598d126so260881cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 08:26:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793373967; cv=none;
        d=google.com; s=arc-20260327;
        b=C05KEZDYYLD8HU+DIbufYY0ZUE4Aazl+LcQu61zDTUykUqyJa0rTjxBODKXRmW0/vo
         v0dlCfDiTu1cS7uHnxzMukzvH3CdEN3wy+eCAwIjxTCz8GnbRQh0Aj6X0gsNrFZRQjHs
         YEfxaZouz6Li2nz7++5E7YT02g71DY974yNEY109XxD92NAsYbKNOvNv04JOLtR6GY6Y
         /v4mwdPAk/aQrGM37R20xlCvAjoLuoS8fmuqgaqpH2EJP5JrMjqNQg072Zqf5+P1oiWv
         VX1hBD7K2UXSV3bsxnfVokjWHLrrvYSgyqsPn8e0OHCIB3yIMpWxD0U7y5emQWYw14su
         TZdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8eskYuPqODoDNuy2RAjCMQwnvWJ8H7RTSHlA9+ib0kw=;
        fh=Lwdy0R27KS2Ho5jeBvlHIgp7+KGCdRrGom9GIuasc1M=;
        b=qBqL2GG6wYsweF+Rq8S65XpZV2i16FxFdYvs0xAENOSom6IqmHEKWYTth1S/Jo4m4+
         ZB0k/bYS9XwDuy+23qrwE/C+798GMsvEIGpvqPFXMIaJnCRJOX6BJLtwDcuECqk21jD8
         x2xcjmCZyvBeS+Oq4+JnKHlh4GsNVjQPSu2uLvCWrirYZ/gDRzrn3Z2tEOwdHzHvd+RD
         YzlCZaPWPhDn5caWQwB0b8gfR61aHqdj9TEiwtGwEmlpFE/+ttP/nZ9Qj/tZxIgNPl7D
         LV1aX04K5uDvaBQOpI8uyOmHBjDpFRTqTGTnMM3DfV0SDNe0qF2rinf/yznG1MbKVtid
         rPxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793373967; x=1793978767; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8eskYuPqODoDNuy2RAjCMQwnvWJ8H7RTSHlA9+ib0kw=;
        b=I2uqagz20O2y0ikxY4OxrjVr3WXK+CegAO55W2FmQTDZn3dv4Qjwi3YlPs5nmSZMyi
         73Wz0mUEotP8ACKmF4UgBYyZabHYNxYNLcTidE01SXd6Jqp6/sANtDbhgjVzOcVno4su
         OWxbfzxVK+ZlbkyiLJJ+tD0QgtlO2ES4YXopIs3rdaAYZa3hE36uriPne1mvfJ1j5d8N
         5Yj/3VYOQgcJ07O22UXEdokmgabm8dFUKMx6H85tEPJ5UVjwawydHpyb+6fpgZ+7g3WV
         ytfBrtK/7tXYmUVDpNYy8rdYrdxmyytByCg3+ehestKvhEkOUjuSjkCJCPzDAMTBsC4T
         siKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793373967; x=1793978767;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8eskYuPqODoDNuy2RAjCMQwnvWJ8H7RTSHlA9+ib0kw=;
        b=CgA8dDXF2qWILNoKMMrkK1gBB8iry6wHE8agG5Y+yoG1uCwLfENYHjF+a65vz7novV
         rE78yePDPe1VFfNxomjaQ6Y2BkV1b4b6G5QiObKHTQXpNBVHiaaphcL2tkH0TkESW74o
         CW/9AxNboTcPoAo1d1fo+2eXnyb5j5x+fS9ghIMhnyv8+W93NG7AEojv/jNiICDbJOLh
         +NipIUgBoZI1R7FXXM5kPNfasICNcdrkWz3NLXagUSdFDAAv9fcFZJPiEwvVS6XkKgE8
         Rd/9SN9HVIb677j+qpsir5kPj1sFflOTmpIbxfHuOxAhL328MMFC0mENkMRA865ztrNV
         rGRQ==
X-Forwarded-Encrypted: i=1; AKwUvBzKgxigtqjiPMs6LRuLk/o83qPJXBGn+aLhhnGNc/ApxbEzahYLlFuPE5tbDUpMJOSPkmlJL+GPOVeVNRCbfp7z@vger.kernel.org
X-Gm-Message-State: AFq9FYL4bhpYk7d4Cm6DXwCXxtx3Ai7qXeb1ox6H4swPY0PIIzlbSUCB
	xHcHv69le787iAO/FTwEBcu7jeoLjHx5W+yli73nqwRrU/30nEhWAoCn4DaVgM1aO7QoYTtx4gC
	6DNLnAJA1/vY9bpLPpUILLjtk3pB1PYW07VUIVW2Y
X-Gm-Gg: AYBFou0Us6oHQYp87+cTcPefSB42r7y1wFsC23zcRKL1SUMzPn5pHJeBrltqbvUhZSp
	CBPUwtdoO5JNKfK/PMAuXprDyw8Z7Ybx14pEev3ffHQHywdhTjE9/bmjkSb83OrV4m+KkLWyVZc
	aX2FmXjumQZ2Fe68krXBnEGqqybKmbD2OW11i++n+3Rfpv4vEumF3pBfIaNENMn694/iJEW4dFE
	g7DQ5g1uUqYOzzV39309iDR9l1lFHFNcCX8CA02tnM1UmoDPUxquTKRzND06c8WnwZDeSGtdCnA
	ugDM+dewBcK/Tm2y6sLUDouBYm+Mu2bNt/0TlroEnFr8LuLOl89UhzKneypl5AMg275jAVijOwj
	f4HVKiZJVQ7ci664nz85pvA6zB3EE8MOIdE1piOxMqjFpGrDsrKfKoQxIZsMZ6/nk+OAD
X-Received: by 2002:a05:622a:400d:b0:533:9746:9a86 with SMTP id
 d75a77b69052e-5412d80f80bmr42530261cf.5.1793373966380; Fri, 30 Oct 2026
 08:26:06 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028-perf-symbol-memory-send-v6-0-7e90415f0101@uber.com> <20261028-perf-symbol-memory-send-v6-2-7e90415f0101@uber.com>
In-Reply-To: <20261028-perf-symbol-memory-send-v6-2-7e90415f0101@uber.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 30 Oct 2026 08:25:54 -0700
X-Gm-Features: AclHuK_KiufgJUQSaxd3tfd6fQpijRSFFUdjGxHrq4Nt9wDMcaxFsk8JN9DpE0Q
Message-ID: <CAP-5=fWX6xN_0=-fJ9_v4vsTkUEgLLYYUN5KhTwNH19nRM0DYQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] perf symbols: Split out name-independent duplicate
 symbol selection
To: haghdoost@uber.com
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 4:42=E2=80=AFPM Alireza Haghdoost via B4 Relay
<devnull+haghdoost.uber.com@kernel.org> wrote:
>
> From: Alireza Haghdoost <haghdoost@uber.com>
>
> This patch is a refactoring and does not change behavior. It moves the
> size, type and binding checks from choose_best_symbol() to
> choose_best_symbol_by_attrs(). It also adds symbol__choice_needs_names()
> to report whether choosing between two symbols requires their names.
>
> symbols__fixup_duplicate() keeps one of the symbols that share a start
> address. It compares size, type and binding first. If those attributes
> are equal, it compares leading underscores, name lengths and the result
> of arch__choose_best_symbol().
>
> An unresolved lazy symbol stores a file offset instead of a name
> pointer. Thus, the lazy loader cannot call choose_best_symbol() until it
> loads both names. The new helper lets the loader keep the names
> unresolved when the attributes select a winner. It loads names only when
> the attributes are equal and duplicate selection needs them.
>
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Generally I think attr/attribute means perf_event_attr in the code,
but I lack naming abilitites, so it works for me.

Thanks,
Ian

> ---
>  tools/perf/util/symbol.c | 26 ++++++++++++++++++++++++--
>  tools/perf/util/symbol.h |  1 +
>  2 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index b61a574ce9a3..2d611c05d000 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -157,11 +157,15 @@ int __weak arch__choose_best_symbol(struct symbol *=
syma,
>         return SYMBOL_A;
>  }
>
> -static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
> +/*
> + * Choose between two symbols at the same address by size, type and bind=
ing.
> + * Returns SYMBOL_A or SYMBOL_B, or -1 if only their names can decide.
> + */
> +static int choose_best_symbol_by_attrs(const struct symbol *syma,
> +                                      const struct symbol *symb)
>  {
>         s64 a;
>         s64 b;
> -       size_t na, nb;
>
>         /* Prefer a symbol with non zero length */
>         a =3D syma->end - syma->start;
> @@ -194,6 +198,24 @@ static int choose_best_symbol(struct symbol *syma, s=
truct symbol *symb)
>         if (b && !a)
>                 return SYMBOL_B;
>
> +       return -1;
> +}
> +
> +bool symbol__choice_needs_names(const struct symbol *syma, const struct =
symbol *symb)
> +{
> +       return choose_best_symbol_by_attrs(syma, symb) < 0;
> +}
> +
> +static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
> +{
> +       int ret =3D choose_best_symbol_by_attrs(syma, symb);
> +       s64 a;
> +       s64 b;
> +       size_t na, nb;
> +
> +       if (ret >=3D 0)
> +               return ret;
> +
>         /* Prefer a symbol with less underscores */
>         a =3D prefix_underscores_count(syma->name);
>         b =3D prefix_underscores_count(symb->name);
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 46b1649c64fc..d8386c4a7fc5 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -303,6 +303,7 @@ int arch__compare_symbol_names(const char *namea, con=
st char *nameb);
>  int arch__compare_symbol_names_n(const char *namea, const char *nameb,
>                                  unsigned int n);
>  int arch__choose_best_symbol(struct symbol *syma, struct symbol *symb);
> +bool symbol__choice_needs_names(const struct symbol *syma, const struct =
symbol *symb);
>
>  enum symbol_tag_include {
>         SYMBOL_TAG_INCLUDE__NONE =3D 0,
>
> --
> Git-157)
>
>
