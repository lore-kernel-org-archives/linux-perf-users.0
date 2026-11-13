Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583262;
	b=dzybEaIPr0pzWrd4TTXc2F/mZa6Es3EZC0oCZJc4pa9WGUtSwFUFw+x5Ez8wLxa2Gy7g
	 gq4TwDQ2F3uOvDMjjeVbB9XhwkGVx/a/d5dN2rHwIUa9orYUNh/LvwLMirCh7sDLAtXlc
	 LCSFCrJMmLPFj5Pk1klbrxXS5WwfxLsDksRrbJBXVTlemShHUxdNu7UGoakq8/xEmi+fi
	 6hvHFUYevbgmecxgrZ0SAz0je7jdQHHbJhpwsIGAzcjpjGhaXqNmQzyaM574GPUVBJE2/
	 1ADzbKueUH2V3ZWbQhJe29A5cCpe3s737hVvvik28Fs2w0s69CESj08fUhyqv/PDoBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583262;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LqRlCrTsqeAvVeBR4i9pvP0T1/T7Tn0Mzb5ROH4jd2M=;
	b=gM8zIcouoNpNnmZFGvWmKHo2pVwJfiOQbwoWNgPXNfo9AyoTkkWeldTrAeil78Hn9QVh
	 Owhig88I7Kx1l2cuMF4pdquUA1ggrCCVy4AE2aq0klg5mBA1LQFRZ8ToQVxMA/E9Ww5mR
	 ZLyPNWsiabsZCBS6pZxNln+hyLifz9M4rIpwVtJCLr8+mugQCRyi1VIg0skW+eWV7ZfX9
	 kvVZe76siYqXxG0kSWT8ICngLhssmdEJz67pBshmTGITNr7ok0RpjClFGdezfiCfmy0kc
	 6q3XfGPtr5gaNYUecXdfJJ2NH/iH8wSTk6KFcYAGEyRVDSOQ9J8FWh8f/2LuOuBL/4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fc1GFs2L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F54606A331
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fc1GFs2L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B847E1F000C4;
	Fri, 13 Nov 2026 15:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794583261;
	bh=LqRlCrTsqeAvVeBR4i9pvP0T1/T7Tn0Mzb5ROH4jd2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fc1GFs2LP3ep7F8YqhV/ge3u3d16UzSBB2kKwHJkWszt2joxiNFLDUF2647QwLE65
	 QSyE9YvXSt+uhrkkvNtGIyyBP+h4olV3Qrsn557soFmXA0T7hiKyIASCVNwPUrTF10
	 1trWJmv5uv8q27BlNUwgptbGbv3qS7105ntYdZideT9KXJgugY7cL5CMoZ9aUHPQrD
	 haggvOsVw/WXJUpH8dcLxqQIo6tIngDfno0bJ6QoV34bUWQ+BvosZRoqKxvm32PktQ
	 snPjI8ccRcPV6Vr0YqephcaIQ7eeRvkJPRmsGpeC44vozx2Aw41Tc8W6fsGrhwUYIv
	 03bWtri6QutSg==
Message-ID: <sashiko-outbox-213077@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/12] perf annotate-data: Count flexible array
 accesses for the whole struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113150555.1163049-5-acme@kernel.org>
References: <20261113150555.1163049-1-acme@kernel.org>
 <20261113150555.1163049-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:20:59 +0000
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
- [Low] perf annotate-data: missing member_extent() use in TUI
  get_member_overhead()
--

commit db1590c6b9cdacf042578dbb6359cc6b78b628eb
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf annotate-data: Count flexible array accesses for the whole struct

This commit introduces member_extent() to extend a struct or union member's
sample range to the end of its last child so flexible array accesses count
toward the enclosing type in print_annotated_data_type().

> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-d=
ata.c
> index dd9c1d7b2da8b..7fae186ffd76b 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -2233,6 +2233,25 @@ static void print_annotated_data_value(struct type=
_hist *h, u64 period, int nr_s
>  		color_fprintf(stdout, color, " %7.2f", percent);
>  }
> =20
> +/*
> + * A flexible array member is resolved past the end of its parent, so the
> + * parent's samples are not bounded by its size.
> + */
> +static int member_extent(struct annotated_member *member)
> +{
> +	struct annotated_member *child;
> +	int end =3D member->offset + member->size;
> +
> +	list_for_each_entry(child, &member->children, node) {
> +		int child_end =3D member_extent(child);
> +
> +		if (child_end > end)
> +			end =3D child_end;
> +	}
> +
> +	return end;
> +}
> +
>  static void print_annotated_data_type(struct annotated_data_type *mem_ty=
pe,
>  				      struct annotated_member *member,
>  				      struct evsel *evsel, int indent)
> @@ -2240,6 +2259,7 @@ static void print_annotated_data_type(struct annota=
ted_data_type *mem_type,
>  	struct annotated_member *child;
>  	struct type_hist *h;
>  	int i, nr_events =3D 0, samples =3D 0;
> +	int end =3D member_extent(member);
>  	u64 period =3D 0;
>  	int width =3D symbol_conf.show_total_period ? 11 : 7;
>  	struct evsel *pos;
> @@ -2253,10 +2273,10 @@ static void print_annotated_data_type(struct anno=
tated_data_type *mem_type,
> =20
>  		samples =3D 0;
>  		period =3D 0;
> -		for (i =3D 0; i < member->size; i++) {
> +		for (i =3D member->offset; i < end; i++) {
>  			struct type_hist_entry *entry;
> =20
> -			if (!hashmap__find(&h->samples, member->offset + i, &entry))
> +			if (!hashmap__find(&h->samples, i, &entry))
>  				continue;
> =20
>  			samples +=3D entry->nr_samples;

[Severity: Low]
Should get_member_overhead() in the TUI data-type browser also use
member_extent()?

tools/perf/ui/browsers/annotate-data.c:get_member_overhead() {
	struct annotated_member *member =3D entry->data;
	int i, k;

	for (i =3D 0; i < member->size; i++) {
		struct type_hist *h;
		struct evsel *evsel;
		int offset =3D member->offset + i;
    ...
}

Because get_member_overhead() still iterates only up to member->size,
inspecting a struct with flexible array accesses in the TUI browser continu=
es
to omit those samples from the enclosing struct's overhead, sample count, a=
nd
period.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113150555.1163=
049-1-acme@kernel.org?part=3D4
