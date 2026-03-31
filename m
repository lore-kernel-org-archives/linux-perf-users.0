Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6662FD7BC
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976505; cv=pass; b=jN7lt7HXZo6cp6qbHh3cr/heVVxEMGNuvdgWKMWVqiknD7HJ9ZHZ/kS7/jekodrsohhTJMN5xzLBx0M9dTTl3h2lMDePQfuJAdC2TYCCmmlA8j1FQIP3AeKNU41fWQQnaX8JLkKZCsntwAKxgx8EcgQHRNJtiNhVVCuFs9zhvCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976505; c=relaxed/simple;
	bh=rl0u0hIeWBtNdUocXLnNiARhsuLDdX/8oWVZ1ivbZi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YF72blSIu/el5A/DRcWJc+mrWeaco/YQjqtMYgoz6yCb244DfjNbuh9gtKbBLmpGL3YqrV7kh+r0+JVveFjY5IMo5joX4OsMLMw9BboopK2l+RLcQ8+QQByplN6k940Uko3LpZT3XjDKIvgqU4kNIkpdEdl+BxfxUjTX+x+KIQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O9DwtleY; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O9DwtleY"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1270fc2bdf2so12875c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 10:01:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774976503; cv=none;
        d=google.com; s=arc-20240605;
        b=HnMFtJHdn8JfSIxk8hpHeBmXGgkyZVzlQwwvMRBxYUhyCXll8FtS60M1LnzxNCvZhr
         zWvpnoU1qroEb6P1CzsCX6OEpXaNSJy9qtHynZkR1rNeQJ0RCf2GYFsb+aaf8FLkgWng
         IcOAC1UtwJ03ljizIs8bOcdaeiMpS2TwzFlQkuouZZr3u9yfQKE6ntXhfwTMe/tLeNPk
         5h4dyC4ctmnMDKLPdCGIg1oK4eP2r+lyWUK7KmaasvppX7a2gaOA2ae0eNEgeADs5D9Z
         FJJcOes6gCGeq7AplXrGUgm71VVIoO9xwVJfhsIwJi/sHbHNQzDtcNcfl+Hgtdog20I9
         tX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l98tvJP33qg7yUNaZsXGxPv2Z0+17QhIZr8805RPT0Y=;
        fh=Qr42zwuW7+Iv/aE6hOnQaLIjJT6YDgu5rkDHyaETzks=;
        b=YEyw7Th3lVfoK2o3uzSwhOeY8xwu3vHPgjrLlunqZDRIeX6Ny3wC5ojl+ZM4JWvTZx
         6ll9/YZlWYl+odkNPul0Yg5AsAcSn6iDX5TGiMhxyXAxPvitK0qUQgw2ed8iXQdYebLj
         IQMY6KHCzBo0OLwF6xZW7eEJ194D2dlQSo7yY0RDMu+JyIfMd0zmDI7AzaanZslxf/MY
         ycwQCfNU0++JrmAzz7XBOwEUXRiHi527ZyX+0BVeI4Yks3N9xyX/2oVNaKQWMbwIJBoR
         a2UMk1wdz18KxTkeV7iuCKO9pDfl+e5CUotshPm2EYgJ/S6C/jYUdN8UumlYYHwnsC9r
         3f+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774976503; x=1775581303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l98tvJP33qg7yUNaZsXGxPv2Z0+17QhIZr8805RPT0Y=;
        b=O9DwtleYx0vNgB2AdDC0mp8sa5LHVLkvWJdf+ZEzArigdYGoiPtsV3uIeb8dpR682E
         cIiRIVWZGyXWbML4N/VHqM9PZlhb+tpggrSSmQGfdKN54/w4aVSnFMBlhFWzbP0yZ8rc
         tEeaLrTZsqnnwaaWvNf468GuWnDdr76sxf5kivciiXoerSYjKUlG584i5Xbx+doWAK5J
         6DWkLwMlaTsi+MbhbxHlst7PyIt0iTd1UDDXzHXETpOnJk/FX1yZE9bKUU1SZ296+e/P
         04JfDtRKWOkW8IXkAV7oepQbQQcApobmqT9k+yJuoURaqcKK4R18pycQALn/5m3JdQE8
         LDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774976503; x=1775581303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l98tvJP33qg7yUNaZsXGxPv2Z0+17QhIZr8805RPT0Y=;
        b=pwnYUg4U5y4fyMhwHmVXJuexmTCDtgZgsfCdtduR8CBqskxnLhBkUonQSzTu6y/LZk
         wupF47z7lL233MKjLjJJRIV6n0HoWQeIygm1hvl55AJvpymiKYgp6Cj5t/Nn8NwJuoum
         XKOVEpUb8fQT+esz4jbMzFV3VCs8bgq4LSEGkH22fjHEtCwBdeDi4lcT9l+FIvuTUn2v
         FDai7uuUDqm5nk5dXahBs867Dp+vviwl6pBgioU4TmdNDyOuPkqacvEa0ie1JlQDxEki
         ExbISvmQDYwsBAywCP2T7VIHdBj1IVu0S5dDx5ji1TC5qOhNyVDZ7Gky4D4spIjyz89e
         9dCw==
X-Forwarded-Encrypted: i=1; AJvYcCWleQapF0gGXivaD9O2ZafoKDFIzoAfHzHryPow5Mv+x89nhbq5kFhUSaF2r2BhDXQvG040CbaEHJTqmxuebaFp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy20cF1GrdGQsxf50dOxor91bp4C7lvdDSfjPSFVaOywlL8SRpn
	eo2HmGurCxrfAqigCbJLG8d2QbdxKwk748xRHcRpfjvanmXY7iF4+KX2bl5Zd68sTE+GukPImNH
	zTpClpdv64hpMF78qT7sY70uPytosHl/mGd1euuYF
X-Gm-Gg: ATEYQzyIx05DvHR1Prw4kiiZzBtcVfRjYUo5XBzSt6//FvXvrsjHYrvZCw8O+T0A++O
	gpmVh3rUSb817TBS4ILysBVMRB1FQ5yY1WVTWDYN7E++QvBD2TrAjKJ+OsJRAT6wfd1Ji3M110t
	Gc/5lyFxzl18ZrFTopCJqgPGeEjHfEb++CXfswtvsa/3Ne0guF+PJE4smOXHPxJQpCRxFTBaiD9
	QtFupYYEp7Z70wWHv8WPoZwxHIUBi1Xw/6GxcpV0xYeRqJp0IWuMYQdxPG0380I7b+cw3fYrVD+
	w+Tj6TPaOVjreaf9BfJHg+W50ez12ajpA+5mRg==
X-Received: by 2002:a05:7022:6987:b0:12a:8cf4:65d8 with SMTP id
 a92af1059eb24-12be6159009mr19765c88.14.1774976502067; Tue, 31 Mar 2026
 10:01:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fWVU3ktkGAnZQrjQJf+Z5AtQo73BVUhj-nr3H95GdcEJQ@mail.gmail.com>
 <20260305221927.3237145-1-irogers@google.com> <20260305221927.3237145-3-irogers@google.com>
 <acrln3IwOebvb6yj@x1>
In-Reply-To: <acrln3IwOebvb6yj@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 31 Mar 2026 10:01:29 -0700
X-Gm-Features: AQROBzAxOb5Fj0tz8CFxXnvG80J893x9iFJ4Ie0P731uMqrcv3OK1B9SMHLInoA
Message-ID: <CAP-5=fXn+uNEfZ71a5zZ5BdKw8-LfWgpzye8+eTJH32gL1=b_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] perf build loongarch: Remove reference to missing file
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, andrew.jones@oss.qualcomm.com, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, howardchu95@gmail.com, 
	james.clark@linaro.org, john.g.garry@oracle.com, jolsa@kernel.org, 
	leo.yan@linux.dev, libunwind-devel@nongnu.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	mingo@redhat.com, namhyung@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, shimin.guo@skydio.com, 
	tglozar@redhat.com, tmricht@linux.ibm.com, will@kernel.org, yuzhuo@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 2:05=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Mar 05, 2026 at 02:19:21PM -0800, Ian Rogers wrote:
> > The file was removed in commit e62fae9d9e85 ("perf unwind-libdw: Fix a
> > cross-arch unwinding bug") but the Build file not updated.
> >
> > Fixes: commit e62fae9d9e85 ("perf unwind-libdw: Fix a cross-arch unwind=
ing bug")
>
> Removing the 'commit' part.

Thanks, checkpatch caught this but somehow I missed it.

Ian

> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/loongarch/util/Build | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loo=
ngarch/util/Build
> > index 3ad73d0289f3..8d91e78d31c9 100644
> > --- a/tools/perf/arch/loongarch/util/Build
> > +++ b/tools/perf/arch/loongarch/util/Build
> > @@ -1,4 +1,3 @@
> >  perf-util-y +=3D header.o
> >
> >  perf-util-$(CONFIG_LOCAL_LIBUNWIND) +=3D unwind-libunwind.o
> > -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> > --
> > 2.53.0.473.g4a7958ca14-goog
