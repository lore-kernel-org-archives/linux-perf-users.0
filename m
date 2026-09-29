Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371AA392825
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790717083; cv=pass; b=KseRJYmaPX21a++n07uVYg5CbtcyVq1ttrJEeGBg91D86IhdCDWYqMlrZ9D94R7wb4Oso1fq5u2/q3g0cqvwIFb5oucNgNad/+hfH0e8kKIdsOCllxwOMHJzTI5YWOgyiQW1kxiyYI8zNGmnTN04NjNvWwsI3dB/xCpW5qQFTzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790717083; c=relaxed/simple;
	bh=iLXo43O7JmOuus9Fwsu7TvH61/8erOqVOuqqIrToHow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pdu55oQOaHiaFlzv4FHNhPax2pV5VXGQHSziMQMFiqHo1IxXHiXgwimxQUS7JDiFJuUapbggclZYLJT5YSnU9WavYv+WuxhhoviAj9V4qUJvUeDuczJrXZ3NGaxy8II947NoN+KxZuqvzRAhTrorDXWEneaBWNqVZG3RoeF6pJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=kZ3JRQWR; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="kZ3JRQWR"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6714595153cso1110152d50.0
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 14:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790717081; cv=none;
        d=google.com; s=arc-20260327;
        b=lnRogXz59esgc7aVZ/6t/GVKkX6VC+U6WaHoNkp/0PPWBPy/Gmznv0RXnIGZVTzgpj
         ECVANyWKZPdrXIM5x1mIL9IAbgUS1M1g28CU/Y8FqGbQ/nvOtWUuAWazoDKzSTJlKrHT
         4n+pFcB8InfdhvzrjVJ/lqCj9aX55HG5x6Q9b+3ZVbfnhAPJoUTyRG+BBgvnofmhM+WH
         ZH6GhTIzhUufBgk+MEoAwD2/tfE+0Cer9DRT1U9/nh7+eS+asMuIE6KPDRZO1IHD5eJf
         MWCcyx1LVwllh6PVkd0Vf680SOT8vZAK8e0mU1+DDYXBemgmLp3iv9W6ww5po0I4ivxR
         2E0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XsxJSbC/0qpT3PgH/uznE1JYs4z7KKK2Tw1kr61c3yI=;
        fh=sjJ2/JU4v2WXXDD1N/ySPkfi0VFxDVeCMiI6ZDYZsGw=;
        b=rMwkCtEStRm7sCqZ221TfIFAnS6AZojgEUa4rOBMn4/r8BbOp/oCPrrT5TLd+abtH+
         sFkskKYDlFQWD/OnM+CmnluphMn81P5Op1lVCI+KYbSOWjYiJ7ba4wFXi8AOD1+v2N73
         DZ15oLiG8QWiDj/gUjBCC3f4oYaF7Gk2FXU0rzpWdnh+8kBzy19Zpfy5HBc0sW4YlmiL
         emXVRmV8ql0E0HN/IyKjyZChmI4iep85ngXiKMURHbWi7KFUb0bQJVH0uyKZYQ8BUP76
         QlNZP32xO7C8HS4qyzzKRybwSWAnrNuEfYfNlE/ipCWjxs+vrGIYk5xW349uzk2UVH/E
         s9MQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1790717081; x=1791321881; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XsxJSbC/0qpT3PgH/uznE1JYs4z7KKK2Tw1kr61c3yI=;
        b=kZ3JRQWRs+OYJ98JSBjxauOL9k9ApdE0uxNiXuDTEPfbt3NU3XdEkY1NQU3NThkjJt
         dY9ikm7H2XNYTv8wX3lxb1fZlI8oIw751GGU7sh6/uX6L+JA3MNAEexGedR9SIeo4A2M
         T1ZT7YlpGdkqPm15ehtFQF9xXNU3VYHcz//mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790717081; x=1791321881;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XsxJSbC/0qpT3PgH/uznE1JYs4z7KKK2Tw1kr61c3yI=;
        b=LJzGIzIysmtg05gXAHjzO/NuYUmFKTNHnMk5qt9FMs4D6h6IH6i5wk6o465x8uEkQA
         HeIr/e5GIHJSmsHNP/EZ8an3JhQ6hwbZk7HN1EL0PxIfWqj2jf0StttNAFqpyi7Mhxeh
         65RhPjs9MngkV85S4X+8V2SNueK5TQHsb9e52+hrKWyeb0a+cB1vL+ISu0JzW0+u3hKR
         m5tLDxF89f5Krm7JjQSwcP7FvVtusMR2GjeNni/Th0ihwMeDw7G11zP4xIlZS1sKxdvu
         NlxbWmT0AEqS3xxJA1iHsRaNCIvIutw4DJIBlNkxKNrkucSP8VA/Fowb1INOS70uwqQP
         z8mA==
X-Forwarded-Encrypted: i=1; AKwUvBzED9R5kfuzuhVE8atl6zQaB3R9EnRhHBs9nXPAGoCPKXCfmesP+TACcDfEEYaAPZjdD6v8VVULYG+7ubef1kUn@vger.kernel.org
X-Gm-Message-State: AFuF++kYjRihu002XXrBLrZXjtCHc2hhj8gQsQfQU3t8fzxGpRu3w2ox
	ifnJ9gZjxv5P8aOsUxSsTrqGyLZIycy5D4iBqVMKgq9zXTHOECTKyPlq95PSWePDiKRiHimH3Ho
	EDrjBsnHocbIqXERSe2Y0mmq4FbILNmNPwXqpHhys4A==
X-Gm-Gg: AYBFou1jXOqCQeBSuOlqY6Sa8k5EnEsCC3fMb+GvpZvKnpKp0pjJPnSfysBdR1TpVPR
	P7q94j1aAfnkigV8C6ImhPqHYnB1k+K4UorgSmF9+nqJrla+3zGRweKrV3KyvRp+dmHSaEGFrsT
	oT+PaoDVx/mK0x6rtS63DEuvWhJtnMk8sU1sH9840kbQBNupJZZstqb0yLKiql5tGMVaWmwUiAX
	e0Xq5kRpxJcZGA5B6M9oj0bjwE0tOrTOu24wukjLgKipK/cqSTiUSA7VkNL8OP+pm7RrZwzRiQM
	TitQmmTav6Ff3HhQPX+eN08UsIeYr/bTYF9Yd4pMh1y52YERTbjSZ06yEdTzEAhdQRI88YSHQsR
	Q1BRWOQ9LQ54=
X-Received: by 2002:a53:d019:0:b0:675:300c:3938 with SMTP id
 956f58d0204a3-67560b590aamr1239328d50.14.1790717080747; Tue, 29 Sep 2026
 14:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com> <CA+w=M=R7vMK9-YZufh1ZW7efsVh=vCVkeh2_4rPSAsN=SH8MuQ@mail.gmail.com>
 <CAP-5=fUFWGxNSS+TW4iHqeWu+24-R2rq63oBX19VxkTXnqo+4A@mail.gmail.com>
 <arrhc_7jvX_W2uXS@google.com> <CAP-5=fUuwXTN6kjDrSqygN-Dy3OFuWMH705_tsCXX=dbG747QA@mail.gmail.com>
 <CA+w=M=S3USeLyFNaHSjHL+cmzssWk2Bygahetzr0dNU55TZEMw@mail.gmail.com> <arv-9NWWZ14TG5Te@google.com>
In-Reply-To: <arv-9NWWZ14TG5Te@google.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Tue, 29 Sep 2026 14:24:24 -0700
X-Gm-Features: AclHuK9U0_hOZFiXzRILk-R0tWVBa5apQWlupDVVHBlduv0A77qNXQe3k2lPckk
Message-ID: <CA+w=M=TFNBOr9Bxca0WmvAH3gSnr3Yc73jsubus=s4WSL-n1eQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] perf symbol: Reference counting, flat array
 storage, and LRU shrinking
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > That is close to what patch 5/6 of my v3 does. Its index is a sorted
> > array of fixed-size entries:
> >
> >    struct sym_idx {
> >            u64     start;
> >            u64     end;
> >            u32     name_off;
> >            u8      binding;
> >            u8      type;
> >            u8      flags;
> >    };
> >
> > That is 24 bytes per symbol. The name is read from the string table
> > and demangled only when a sample lands in the symbol. The difference
> > from your description is that v3 then creates a regular struct symbol
> > for the hit and inserts it in the rb-tree, because the rest of perf
> > holds struct symbol pointers. If the entry itself were the symbol,
> > with the name as a pointer/offset union, that extra step would go
> > away. Ian's patch 1 would help: once every name access goes through
> > symbol__name(), that accessor is the only place that has to resolve
> > an offset.
>
> I'm curious if name_off would work well for PLT symbols which come from
> the dynamic symbol table.  Probably you need to handle them differently.
>

Hi Namhyung,

Yes, synthesized PLT symbols need separate handling, but current
upstream already has that path and my v3 series keeps it.

For a regular ELF symbol, name_off is its st_name: a byte offset into
.strtab for .symtab, or .dynstr for .dynsym. So the same index format
works for both tables. v3 uses .dynsym when a DSO has no .symtab.

An @plt symbol is synthesized rather than read directly from either
symbol table. Upstream's dso__synthesize_plt_symbols() gets its address
from the .plt layout, finds its base name through .rela.plt and
.dynsym, and appends "@plt". The existing code also handles .plt.got
and .plt.sec this way.

Since name_off only identifies the base string, it cannot represent
the added "@plt" suffix by itself. I think we should keep synthesizing
these as regular symbols, as upstream does now. v3 only makes the byte
cap apply to them and, in lazy mode, clips the index at .plt so a
preceding zero-size symbol cannot overlap the PLT entries. With the cap
disabled, which is the default, PLT synthesis is unchanged.

There aren't many of them. On the sample fixture, has 381
.rela.plt entries against about 319,000 .symtab symbols, and the other
binary has 100 against about 637,000. Therefore, I think keeping the existing
upstream path has little memory cost compared with the main symbol table.

Thanks,
Alireza
