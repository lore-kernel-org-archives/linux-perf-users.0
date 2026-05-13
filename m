Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E102D5412
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778633896; cv=pass; b=UAA5jOAZCHR6wVKZchxB9dqzpD+iW1fJYRxHB85XUb2fUp0mBTAdU+c6QpWTvzKUuYaO7eqv4Aqr33LodM//dKaAlwnqjseImkYfn/A0yqxW9JLxZcUSJzm6JGH8XQRvG3iXoDdMDFaNgsVTOIWc0MprlAUOdOp2BEoAUx7zozo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778633896; c=relaxed/simple;
	bh=h347xw53MS7OJe5w8eVUSe4ajz+LZ/kY+csyPwTnKE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTuI9yr2uOrScMcH/67LMDg7BcxhsdORbLipTjRUJAHllwrPySRXqUCA8OQRmSSwUoZdUPtMUxYKUvvfm3A2s9AZg2jT2Kwu1jLWnZVjFRNZATI8NioSmE7TiG0QBtw1/hHely0AkOUfaHhGZSF6SEYlaTtVqX+BcMpx0zo7ehc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cZdfi7/V; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cZdfi7/V"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1336742714fso99c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 17:58:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778633887; cv=none;
        d=google.com; s=arc-20240605;
        b=B+pf8EEwdiCm+z80dxRgkXCuFM3esgJYF+LUzQSlP13gwbyTidGf9mvX5RUPo5YQ+X
         TzQxd+rq5iYS3T+jfo8bdP3DDMqtdzhW5GvnIxftxLpJXTkxTw1sy6yI7lKGKF1Ifclr
         l+RVv/gGiZBVWa3C2PhN4hWQ253+q1QrdU1zUhNb3BnGjkjXc647PQb9xX/SNp7OhN+y
         p3TTc9vvUwMK3Rw79n1OEv9oedCarHa5gOeCBt8U2e2yDbDbANJ0tAK3c4fRRBtiH46C
         hD7cRsh1QcwQu5cht7yqwBegrkuTeWy+OJyYeA/m5iLcIkYj+uI3XajLuuJreFzBaPZ8
         j9/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LRO2poXnMaPTIgvnZ9fKozT82zPK5BjJ+UF96zATU5U=;
        fh=bDNWkoWQOZn0ylNCETXLWhaX6i9wntmTtduIsLQRd7k=;
        b=POM69YZ45RWx8PrCLZm3uCphQxe1PBHOn+AUjISmt/8fDVWrXJ+mIxLWwvDM4i5uyo
         Sy86y0Zu9aCGG3vDvocNTz8ilOiblc7DAgN4PCGoM7ZRbjx5fsR4MTzeuILta3W58owc
         iQCCBemdJJtW0U6KNFOqL4mPOxcgMsn5tnYMo09O2zNe7s75k3PtVKYHDghP2LY6i3K0
         vaZD60ydk4uDCmYPBwiqc5+KcXhRK9+aK5XNc/5b/oKgroEIVwZXWkpuOcgJuNTDeHX5
         bAtlDDlNkD43XZiCN6QhqqSUP3OHc4Gmd6cFtghgfNQKHXFPjpZio3aHCJd90yjvRuMt
         l2Kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778633887; x=1779238687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRO2poXnMaPTIgvnZ9fKozT82zPK5BjJ+UF96zATU5U=;
        b=cZdfi7/VLLcWWzaS0uqNu6lrOqH/XZiQyDjYb8mlrwJxecsiEJ/ElGVUqPcM+c7xdH
         yskRhjYg3dyifE+nHkohztpvimW8HZiPOqaDZh+TSE2oQhpPIw9x9yZF4xJ74rCG+RTS
         f/m7o3F7RySGVn/ax0oummuTAFOqCN/PxNG2GTGV1mZ+TInCfyYNN/n3WvAEwr9AG19A
         ZRKvBBtwuCp5M3cAqJ1lOU8Ot09J3UqtmkkKaJV2RxuhdC3PTBmxefdOQUtVt5W1PVBt
         d3aCatGHFE7KiMKnjKeAP9ZLXV4MvDuSZb1dqSlUPyNE/dgPuvPaQiX+TKERj+oaaJSJ
         N84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778633887; x=1779238687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LRO2poXnMaPTIgvnZ9fKozT82zPK5BjJ+UF96zATU5U=;
        b=GqZmQufHP8jW8MZ//pPbXO+hGbP/snNvZr/s91a6T0f58wVXgRSjqfoiTk2JFNoEDL
         hM3szmCNF//1K6da3LWvOADLx5YB4vA86x8K/OcYKXo0i6CsYW8ge08EV9/pyKLAYcIN
         FRaIx5+fIakNhIszPYK8q/o3sarwWmETZ3LG5I2e3GW+g+DhOozmrogfgCpPWN96VL+8
         t2QFhtGR9CddXu4HE2+bx9/UEwblfahhFe8KQbV5A4ox/oajk9RamvUCoL+h4WDfvghz
         9UYHJdkqhuLOQg1oHQlcgNKsI3qNRlKXR6DDcCn0fFxyRK3Xice0EhHtBGJ5x8KPzwWa
         x4ow==
X-Forwarded-Encrypted: i=1; AFNElJ+6qZAnsn850diFSjExwcVvcmIja1yjP5QeN2hN7q9DxmIinVt7PrFBmKa1QSxJqovTGREHLDgOYjD6zs00qusk@vger.kernel.org
X-Gm-Message-State: AOJu0YyfKYfpM8eOW+8aY8Eq/s2d3t5BfewMO7ZnjLkGCIevQyru1ycP
	jeHMZBJn2mC9Oi2nUJERdVNXEeQKjYySytc9SaPWF++QcOHD9DpE/jYYumgeEJzbA0WksfOo59/
	dxhOcdLTo/d2d+f9XLft5k5y+JNivpiIDCQlH2SFu
X-Gm-Gg: Acq92OF0vsKTx9PlXwZ9bYxRJeGuHt0XNF1UAJXzJPGyHPg/4cYE4MxFknejnKMAbCP
	3Oan4dsCC9KG2u0SfDxkjnw4Ug2uOqPUWF6PA7YGiNI8fOI9pEdusG0P8cC5FhVk2pX7K0USpUF
	a8QoTZs4AzOy8PLI7y7OyST5VeZHPfztNeChDcihURueArkOJWS//m6hb/PqeMCNHpvuYrYDhPB
	EljzNPlC+4esh1rLKEt6qg3WD1l5A6P7EgRA+eT+fnIA8bqIKGNKTt+Uzwqu2ozMXp9O3VX93er
	+z/H8g31QdSKYkUvYWA=
X-Received: by 2002:a05:7022:6086:b0:130:5c2c:d255 with SMTP id
 a92af1059eb24-13489daa204mr50475c88.21.1778633886492; Tue, 12 May 2026
 17:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504154205.21394-1-atrajeev@linux.ibm.com> <0FE86BD2-554C-402C-80A2-C8F86FC2F685@linux.ibm.com>
In-Reply-To: <0FE86BD2-554C-402C-80A2-C8F86FC2F685@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 12 May 2026 17:57:53 -0700
X-Gm-Features: AVHnY4Iu_AOdMqdqvEdJ7IC4E2i6EdbXj_msN7yrwjVaC2EmP4ZJe5hojHarpTc
Message-ID: <CAP-5=fXeZxvikfUf5--Zc7bNBDu7gs27sRj4WoGAyQPJ79mq=Q@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] tools/perf: Fix the check for parameterized field
 in event term
To: Venkat <venkat88@linux.ibm.com>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, acme@kernel.org, jolsa@kernel.org, 
	adrian.hunter@intel.com, mpetlan@redhat.com, tmricht@linux.ibm.com, 
	maddy@linux.ibm.com, namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, hbathini@linux.vnet.ibm.com, 
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, shivani@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 1:53=E2=80=AFAM Venkat <venkat88@linux.ibm.com> wro=
te:
>
>
>
> > On 4 May 2026, at 9:12=E2=80=AFPM, Athira Rajeev <atrajeev@linux.ibm.co=
m> wrote:
> >
> > The format_alias() function in util/pmu.c has a check to
> > detect whether the event has parameterized field ( =3D? ).
> > The string alias->terms contains the event and if the event
> > has user configurable parameter, there will be presence of
> > sub string "=3D?" in the alias->terms.
> >
> > Snippet of code:
> >
> > /* Paramemterized events have the parameters shown. */
> >       if (strstr(alias->terms, "=3D?")) {
> >               /* No parameters. */
> >               snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->na=
me, alias->name);
> >
> > if "strstr" contains the substring, it returns a pointer
> > and hence enters the above check which is not the expected
> > check. And hence "perf list" doesn't have the parameterized
> > fields in the result.
> >
> > Fix this check to use:
> >
> > if (!strstr(alias->terms, "=3D?")) {
> >
> > With this change, perf list shows the events correctly with
> > the strings showing parameters.
> >
> > Before the fix:
> >
> > # ./perf list|grep -w PM_PAU_CYC
> >  hv_24x7/PM_PAU_CYC/                                [Kernel PMU event]
> >
> > With this fix:
> >
> > # ./perf list|grep -w PM_PAU_CYC
> >  hv_24x7/PM_PAU_CYC,chip=3D?/                         [Kernel PMU event=
]
> >
> > Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > ---
> > Changelog:
> > v3 -> v4:
> > Updated commit message to show real example
> > addressing review comment from Namhyung.
> >
> > v2 -> v3:
> > Split the strstr correction in a single patch
> >
> > tools/perf/util/pmu.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 23337d2fa281..0b8d58543f17 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -2117,7 +2117,7 @@ static char *format_alias(char *buf, int len, con=
st struct perf_pmu *pmu,
> >   skip_duplicate_pmus);
> >
> > /* Paramemterized events have the parameters shown. */
> > - if (strstr(alias->terms, "=3D?")) {
> > + if (!strstr(alias->terms, "=3D?")) {
> > /* No parameters. */
> > snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->nam=
e);
> > return buf;
> > --
> > 2.47.3
> >
>
