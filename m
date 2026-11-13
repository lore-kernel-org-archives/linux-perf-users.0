Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601607;
	b=1wRi1vfHZvtlCtJR81jV2pYnjyGm6pnUaUozTkpciKW5KcswZw3hxIBpk9Q2P7C/zADL
	 7iNjA/zc2Z2E3eu4JZs5TDQ/5ABgUL/lF/KHzu25PvsjoyzATxhBaIX2CiCm/g23eY/h1
	 0CfIa56svQxYDCNpcJIIP/8ZEyr+Gbi510wl/3MykR6HJb8mrTDO5Hj8ut2erzz/SN18V
	 ksUj8rVqZZrzzMUmNfi9WRfnol+2QuHXqsyZCcsdt7gLQUrPbwTvUzycxARKhYISjhktR
	 Yiv49sHSH44NzjKzhqCD2ju6UFPAtcjhM9CBTkwxktuGerz11tP4AJqinzmkpiUCk4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601607;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CltdJaIE1PCzJDfnN0l8WK0WYIuFR4MGMkedOM+rMC8=;
	b=meuijA43U1fjHlxe772pCBcCVrgIdZRkLdhsEOtR0e4hiPnpZ1WYtDRBGJB44jevLYSJ
	 pRLLTb63BXFYTSO0a3+biAjzL4Yvap7IgVqLlGKO0jYGBhfAR9I4CJH9J1Jk3lQbN1XHC
	 eeXcXe8vUzZ5H8FLw/Af24KHhUQxJCYn3CPp9+OTCnZpACqzeodE/U34OD+lKfe2lT4JS
	 yLIfYYed+b8bNG/Esx6c8NQDHwf1wlTfHKHQgeBP7RWWKZlrHcS19Tsf0mrkSUh6CAFmF
	 0ELXnyvRGHkFWEu7zQqiHgZ80KAabbnsd94fTqEOUUbL/OLZPwn3gL6BCFUczSYGxtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yr7zJHaG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72638606A333
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yr7zJHaG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69411F000C5;
	Fri, 13 Nov 2026 20:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794601607;
	bh=CltdJaIE1PCzJDfnN0l8WK0WYIuFR4MGMkedOM+rMC8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yr7zJHaGWK0Rv/wyjGdKwhkUDNOg1YVBcKeW6LSTB6HRzlNa0YBQAJxM+c1aWmOEe
	 W+8ksc1slFmsF1T7WIUDpyjL9oEuDl2u9DrL2pB2EuWwPiKa/w1d0sI6mlgNi8h4uS
	 yorKflaRThK0s6EEjKhNhovL/khnrWxIbDXb3vuexUBEKoP8wwTqKRmzUo9aW76liZ
	 YQ/j0hqsVHCQVz59VqvXCh1su1gvXSRg2tweC9blhMeGO78tsyUgvV7MW3maHwrCH7
	 Rb9W8DSFdyo5+7V1+yCenunVXXXYf3S0BKOKvpHnJrJpElmPXHayYV5DUKu0zd2qMC
	 TU661Xaa9F/tg==
Message-ID: <sashiko-outbox-213639@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/11] perf annotate-data: Count flexible array
 accesses for the whole struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113200850.2803460-5-acme@kernel.org>
References: <20261113200850.2803460-1-acme@kernel.org>
 <20261113200850.2803460-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:26:46 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf annotate-data: missing stub for
  annotated_member_extent() without libdw
--

commit 08cc9872c27cbef64cf4ff8273d106d1700fd31c
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf annotate-data: Count flexible array accesses for the whole struct

This commit introduces annotated_member_extent() to include children such as
flexible array members when computing the sample range of a struct or union
member in both stdio and TUI data-type annotation outputs.

> diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/brows=
ers/annotate-data.c
> index 0f778788df4a9..0e1e06acf2b23 100644
> --- a/tools/perf/ui/browsers/annotate-data.c
> +++ b/tools/perf/ui/browsers/annotate-data.c
> @@ -53,12 +53,11 @@ static int get_member_overhead(struct annotated_data_=
type *adt,
>  			       struct evsel *leader)
>  {
>  	struct annotated_member *member =3D entry->data;
> -	int i, k;
> +	int i, k, end =3D annotated_member_extent(member);

[ ... ]

> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-d=
ata.h
> index 184262c735621..880b11849a932 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -260,6 +260,9 @@ void global_var_type__tree_delete(struct rb_root *roo=
t);
>  /* Print data type annotation (including members) on stdout */
>  int hist_entry__annotate_data_tty(struct hist_entry *he, struct evsel *e=
vsel);
> =20
> +/* End offset of a member, including a flexible array's children */
> +int annotated_member_extent(struct annotated_member *member);
> +
>  /* Get name of member field at the given offset in the data type */
>  int annotated_data_type__get_member_name(struct annotated_data_type *adt,
>  					 char *buf, size_t sz, int member_offset);

[Severity: Medium]
Does annotated_member_extent() need a fallback stub in the
#else /* HAVE_LIBDW_SUPPORT */ block (or to be defined outside the guard)?

This declaration sits inside #ifdef HAVE_LIBDW_SUPPORT and
tools/perf/util/annotate-data.c is only built when CONFIG_LIBDW is enabled,
whereas tools/perf/ui/browsers/annotate-data.c is built whenever
CONFIG_SLANG is enabled.  Building perf with TUI enabled and libdw disabled
(e.g. make NO_LIBDW=3D1) fails in get_member_overhead() with an implicit
declaration and undefined reference to annotated_member_extent().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113200850.2803=
460-1-acme@kernel.org?part=3D4
