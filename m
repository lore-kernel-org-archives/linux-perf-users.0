Received: from mail-yx2-f16.google.com (mail-yx2-f16.google.com [74.125.224.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B9EEADC
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 04:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789965927; cv=pass; b=gjnxUmCYOujyMO/C68YU+/0O9AUZttrcQkdYs4zTyHU9RmuG8xNkvMnoSZ6uv+nRYqxD5+nL98y+t4+0bYLopWQi/f8ttdXE0A7czkOWQOEP6/nqnQKdmQyBmImaJlTZGPPuUXlHDKU8NNan0HPQF24uh0wB+9RO690AXwUoNR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789965927; c=relaxed/simple;
	bh=3HIETohqPRiYfSTVCCWaaA/j95DFfsx7y+xQJdoYbzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3SjSLMtEQRLYTXqtLg+znXRUWuwGvIDaaqqc/O3N+diyzSXZcx48CFpSQpw3+b7qPJrqRJVPOai777tLCJeidlKrAyCbpj+nADgcvsKWI+1chrSrOW7YCuL6yL6amHQrAA5mUyJch2IiGJDKw3qOYuwYEfDbpY03bOdNV9gBGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=3lY+SgFF; arc=pass smtp.client-ip=74.125.224.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="3lY+SgFF"
Received: by mail-yx2-f16.google.com with SMTP id 956f58d0204a3-66e56a1fe83so2086990d50.2
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 21:45:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789965925; cv=none;
        d=google.com; s=arc-20260327;
        b=nQrABLDLaRb/aGqnV2lxhZsyUruua4+zVK/Q7G64vE/b+XA3Fn3lT9UzN3Ew9ysytx
         ZPKnisYVl/6kFOxNblOyNIhucEYGm0JExdVfAtl/p0sHBMW+jkbsNNaIW0atoIABmsX4
         4B7Fvm1wpt8JlfsynEpQKPDBHB7D3KrhEGKFhQvpEZR58Gm+AI9FsnHVeSs/pNJooOXH
         ViU5KrO+G0ioJ6bRwB0mYrAVJ1UvfNU1CNWLR6cnM0A1ue43z/i6sJ3yMkfW/9/lHGss
         5/k8DNnk7Akh1IP6lOPbKJmeA3Z3S11ZKujARnKqZlzv0yyzR/g5Xhr6eKO1d0Iq677J
         Sq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BI5PV8JEsmgNBkZ9uF5itWDVqgLrnZZn4wXuURr5w1k=;
        fh=WXVsy1DAMNIfr1wcv3GasqemD1GMT+HB/18hiWY8AP0=;
        b=emYuGmgnKq9Oz/coUAy2a1CM/0qp914WX+Bh/sWA97a7Ytt/8+ldx7tG7tojkcwqwu
         v9yqSSoY4tBd6xNYJZSiLXzIZ9pb0Gyej8+pgoVFvHL7dLXxK5rJDJ8iSVMM16NdhoE/
         8XB1VlF+H66NhdwcvyYXLFlX2hAF0DwtthvlcuLt29uUI74OtbBCaRRJdbZaPSE9CQsU
         L9cTtn9IWfNiDDwK1u+WITGSYkg8Q4Zs1xvnHzpTKctQ10fPE6lqmDfqUHSeJ+4hCPUh
         h5zg8XuEjw9QVKnx+97UXjEF7XhyMNkCJqoTjJ+M+BdW//pgQFOOFcQmsGCrvKzrej+f
         Urzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1789965925; x=1790570725; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BI5PV8JEsmgNBkZ9uF5itWDVqgLrnZZn4wXuURr5w1k=;
        b=3lY+SgFFQBwsvGrfy8CaWjC7ilWULy1BDuOPv1rEK2ho9plmgQOumNOHBiIIJieF9Q
         vx30netqkxm/DebN2WnRLLCYaPK3bjwJKsVZhD+f39WRgLe4sj5bQU6G8DWRNrqENiQi
         muZDpormgflcF1kNGUgwShoKt6nr0qjXyoW94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789965925; x=1790570725;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BI5PV8JEsmgNBkZ9uF5itWDVqgLrnZZn4wXuURr5w1k=;
        b=v8R4Emv6IgxyAxjTWvAtDqmpuRCPs05dOuQnCYfpPHjaZhQPivnrPi0QTTfQSbiOuH
         IRz7SlPn/XdTNJR1SVrLn/zEfR1m5ibxpeSRiGcZMPrC81G9IEjnv3iTcT+/yf8o5sFv
         +X37Qt8yQIIZr0HXw9xRlpfHZ+6WplPHgLSxh96FMtuI5Bii7Cq/4yPyea988ij/3MeE
         IpllJPCT59mYDSCXBA0FKp6kCw4+Zp2tXG7P3Aa3OTWYZd7WXbouS4wrYkeKNgHsC1WI
         iFuoVrf1kXpPsVQ+WpjalCrlh0LubYqxTRrIeGefZaVGUHogQm/kRw4qxIjj83jQVLje
         o9aw==
X-Forwarded-Encrypted: i=1; AKwUvByyHnY7HpPCei/od8/TNXLWz93Fb+/JxBQB5R1JW5RO8x1uRIm/ua/YD/e1a0rwvLf5D25UCxmYDMmdhidS5vlN@vger.kernel.org
X-Gm-Message-State: AFuF++nAyK5GC9cWthDPGYJPDJZBjBZgaI3yyrQ/Yue6o0x0Pt8bSHNC
	p4KYXf32srRds09moIvLt1dnFxb7MpM8bCpLLZp7ipEshsInCWeeNLYiSL9wMyclPFODNGkeB+q
	GqJgrb0FRogapaDab5b4TaCOt0zV6yia2lmwBYsWopA==
X-Gm-Gg: AYBFou13cJQLVvUqpm/RssP9qRY0MLIIl8dVhnswioLWB4HSxY/OrzBN/GOZ4tWNWm7
	ei7p8lXYf52ZCSWRxJQXgCqg7x2u8kopeuekoqOrvLJy+rkAzYP7Q7atfAeuEvAOBIgyZJUjwXB
	EKOHBvbSBGcd+2q0QX+UOnlmpFr/cOVgnDS9kJJK47YN06GXWwVZy8P1nmYvnE+uFxejD9UcW9r
	yHvFcMbsw16ktHe1itCBhuSfQyqxBQe2GPxBfULuCfRBdIpZPwgwSNgI+reuF4gX+vPm2mKAwoJ
	JQWKE+FtBlcsKzzVcX8L6fGfRAC4hGm3TA/f0irpd15EVo2f6CDMFtFGXstuvoTNk5cyd2sY05a
	YpFT7dy8S0dsk
X-Received: by 2002:a05:690e:806:20b0:671:631:785c with SMTP id
 956f58d0204a3-6717fd9b0d7mr1841359d50.57.1789965923516; Sun, 20 Sep 2026
 21:45:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919-perf-symbol-memory-send-v2-0-495b8f00ad7c@uber.com>
 <20260919-perf-symbol-memory-send-v2-3-495b8f00ad7c@uber.com> <arB4G744iWiSPAnV@z2>
In-Reply-To: <arB4G744iWiSPAnV@z2>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Sun, 20 Sep 2026 21:45:07 -0700
X-Gm-Features: AcwNN1VO_qCFY9m4mP87ZE5UPrksR7jfkJOOvczZnZ-njyecDFIgbzlRdTw4DNI
Message-ID: <CA+w=M=R-i1+8p7SDLueMHV8Fv5yupXR+ongVCbeAKGyq8UjsQA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] perf script: Add --lazy-load-symbols for lazy
 symbol loading
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andriin@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > +
> > +     if (!symbol_conf.allow_aliases) {
> > +             u32 out =3D 0;
>
> I think we agreed to factor out this block of code.
>

You=E2=80=99re right. I interpreted the earlier request too narrowly and on=
ly
factored out the pairwise selection policy into symbol__choose_best().
I=E2=80=99ll factor out the complete block in v3.


> > +
> > +     /*
> > +      * Keep an exact-path data DSO for the symbol source.  This may d=
iffer
> > +      * from the runtime image (for example, split debuginfo), so usin=
g the
> > +      * primary DSO's data cache could read an unrelated string-table =
offset.
> > +      * The standard DSO data cache manages descriptor eviction and re=
opening.
> > +      */
>
> Yes, it's a known problem and I hope to address it soon.  Can you please
> make the path handling a separate commit?  I think it's an independent
> fix for split debuginfo.
>

Ack. I=E2=80=99ll split the exact-path DSO data-cache support into a separa=
te
split-debuginfo fix and have the lazy-loading patch build on top
of it in v3.

> > +static int choose_best_symbol(struct symbol *syma, struct symbol *symb=
)
> > +{
> > +     return symbol__choose_best(syma->end - syma->start,
> > +                                symbol__type(syma), symbol__binding(sy=
ma), syma->name,
> > +                                symb->end - symb->start,
> > +                                symbol__type(symb), symbol__binding(sy=
mb), symb->name);
> >  }
>
> To reduce the size of the patch, I think it's better to split this as a
> separate commit.  Please consider minimize the patch size in general to
> help reviewers. :)
>

Ack. I=E2=80=99ll move the shared duplicate-selection refactoring into a
separate preparatory commit to keep the lazy-loading patch smaller in v3.
