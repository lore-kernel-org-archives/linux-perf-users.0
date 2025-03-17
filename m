Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A370942070
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 21:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742247954; cv=none; b=YGhdYqTdavJh6Fra6DQ/fernuAEHdit4AVBHEqlJGYyKmgnWTbpDDT47GtSP6zKrddth+B+VDBinL70oVr9l2ySSQYatitxWiG7OCuTISA0dpSUh7X38GGMGHx7VXOyxGq0qR5nTHj/c2vze8qdcJBrs5YIpTznzL/vZUlqlbTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742247954; c=relaxed/simple;
	bh=zeNC7bWh0psVEoJto4+K4TDFocNWgBAus0XwkQq7PtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nm4T/QLEQLB8WuvA78Jnhmd9y2B6YttSeXmbis3YoszRIdUo4T/1Wv6uBjVW22OEp9ms1bIGReUAnJP92H6E9K365i5BuNx/SIDs1RRMbZ7OIIVYbUqD0x4DgOwr2DIKfIhJ7nJ1UMNuUIWhmhl/KI3QJznGK8doh7KVrtGzqEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lJeiuTHK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lJeiuTHK"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abf3d64849dso808555066b.3
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 14:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742247951; x=1742852751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ML1DoU4xjPV/CAXxytjqLcAmMi1DuWz/qisu6b0oJ0=;
        b=lJeiuTHKNMPDw2fZDehjnxQvodfr2zh3UrLUEXD7U9MFat0OqbYh31UzbmK5zyhZPt
         BecG3ojFeqeBK66E6lPRYZfD5bmWZAgopHeqhLljdes8vWYGpcOHbscUfiREYSQxcV4F
         Ar3kW7J3tzWdKRaztgEuJkW4afWNtC1y5dNeYpOqCUKcj1CFiMT0GRhuRErJASKlxKs8
         Fov7R/HtWuksOge61gbfhPFhphenUY+md1VJUuAi7WxumJPPsUCkAfm7Sn1G9Ynj4uqp
         hzz4eaZvTDbIaSPLAwDOtUAST/q3GyoMZ0snRh7OYXLe58tzGQwoRXc0f7QaJu1EOGoI
         +fnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742247951; x=1742852751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ML1DoU4xjPV/CAXxytjqLcAmMi1DuWz/qisu6b0oJ0=;
        b=DsEL5COnCggl2p/nFobQClN0WVM7Fu7kidYbLevn2hclZBKeza5Uqm/KTEz3Kdu5o4
         Vrf2YmIF7fDn0eSCZCJA3plmE41hhj6gYhsz45cxGMC8omBQe0IEWbGs3kzOwBNFJGc8
         oWegeAzmZaAiy9wSUdTk4au0QKxfAMyo8rAo0/VXg+ZIeCLvTWYG4uAkMiymr63Gzgvy
         P4uKIwDXT4NckhZtJahyfLm5ZPmVfKEquTqF89OvSGnarvXdyHTJLqKq5L2VVHy69l8w
         ClM5z6rWomdo06+e6D4Txt/GFCN8g895FdwXOccSJjqsa/ysNKAwoC5w3aK5xkmhx6hb
         F1/A==
X-Forwarded-Encrypted: i=1; AJvYcCX7Xd2fiAFPyv36BE2ZXKJ55Lumd2Up7c83PJzVajnnV2wBMdebE7qB51NpJXxFAzgepZDkcsvAJLxRKrW8ccma@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+VTFjN+0GL9/EkOq37TiOnVZPedqxJ+Qm9cdXaizA8EXTnXG7
	vnceLWCNQaxtEf72jtcWRu2hsp6h+PJ3lvUEm/G0LYHyuLnfWd1RqfUjBwr29XjQZApIK9vwvse
	hSphgHGZz0t7NeB6+PBRq0WGC/lW5TawDWVKx
X-Gm-Gg: ASbGnct5Pdx0R39yaItFV2MV9Dh1JHH+80FYkkIFvTOyR0Q8D9paXfrvpq50DHokLyg
	ZBiazO3bhnSWKjm0tClUYdzwxFHTBa5Jw98jHWUEkRWz/oh1Rd5uhLhmEOIMtBd4s4aGD1W1Trc
	SOxYXuzqvsohlmeN9hFENtQ4rpxG2WXxqgGaUIPtR/JDtv5tvdOnAq04LTVA==
X-Google-Smtp-Source: AGHT+IGoTQYSTsn1rW+dXX8gjG0kqDLCsgJMqqwLrfNO+PwBAz+FZdEAPfikbKqLQZ/bH+yKN6q47iCEmvAIDfgUt7c=
X-Received: by 2002:a17:906:4541:b0:ac3:45c0:6d08 with SMTP id
 a640c23a62f3a-ac345c074b8mr1024706666b.0.1742247950838; Mon, 17 Mar 2025
 14:45:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303183646.327510-1-ctshao@google.com> <Z9TXabugl374M3bA@google.com>
 <Z9hFJtEKfsGGUDMg@x1> <Z9hLKsZOfouM3K7H@x1> <Z9hR8M-SQ5TD2qMX@google.com> <Z9iHiTv_ud6GEhJh@x1>
In-Reply-To: <Z9iHiTv_ud6GEhJh@x1>
From: Chun-Tse Shao <ctshao@google.com>
Date: Mon, 17 Mar 2025 14:45:39 -0700
X-Gm-Features: AQ5f1Jp1Z0tscdVE63VW8QSDVwa8l2BYdhLMyytFhnJz39Xwk9sGkFUrMFXGgYo
Message-ID: <CAJpZYjXwUz7x1XUF7AzgYR6PZo_igrwK9BkxGx_3N0pCs1YRvw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf record: Add 8-byte aligned event type PERF_RECORD_COMPRESSED2
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, terrelln@fb.com, leo.yan@arm.com, 
	james.clark@linaro.org, christophe.leroy@csgroup.eu, ben.gainey@arm.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 1:35=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Mar 17, 2025 at 09:46:40AM -0700, Namhyung Kim wrote:
> > On Mon, Mar 17, 2025 at 01:17:46PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > On Mon, Mar 17, 2025 at 12:52:09PM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > > Checking the discussion and the patch.
> > >
> > > My first impression yesterday when I saw this on the smartphone was: =
how
> > > will an old perf binary handle the new PERF_RECORD_COMPRESSED2? Will =
it
> > > ignore it while emitting a warning, since it can be skipped and then
> > > what we will get a partial view?
> > >
> > > Having some session output showing how an older perf binary handles
> > > PERF_RECORD_COMPRESS2 would be informative.
> >
> > I think it'll show the below warning:
> >
> >   <offset> [<size>]: failed to process type: 83
>
> Right that is what I got:
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ perf.old script -i /tmp/perf.da=
ta.ck8
> 0xbf0 [0x250]: failed to process type: 83 [Invalid argument]
> =E2=AC=A2 [acme@toolbox perf-tools-next]$
>
> I think we should change that to something more informative, like:
>
> 0xbf0 [0x250]: failed to process unknown type 83, please update perf.
>
> And then does it stop at that record it doesn't grok?
>
>         if ((skip =3D perf_session__process_event(session, event, head, "=
pipe")) < 0) {
>                 pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n"=
,
>                        head, event->header.size, event->header.type);
>                 err =3D -EINVAL;
>                 goto out_err;
>         }
>
>         head +=3D size;
>
> So we're stopping there.
>
> Maybe we can just warn and skip?

Thank you Arnaldo, it is a good suggestion and I will work on this later.

-CT

>
> Anyway, the series as is seems ok.
>
> I'll test a bit more and send my Tested-by
>
> - Arnaldo
