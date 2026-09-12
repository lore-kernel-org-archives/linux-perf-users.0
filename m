Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B304BEE5F
	for <linux-perf-users@vger.kernel.org>; Sat, 12 Sep 2026 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789192607; cv=none; b=d6E9qQFxxTCn2pO79UhTmStMajg2rlMxloLVqSUQIJ4sSlEjoTg04fOpnavtDv3RQ8mxqDn6gsmwnSMCmacOWZZVZDH0sSH7SEwU4oiTcKyhsILfYpey59dzfTjO25fwJLXNr2oj8eEb71v0KEhyJ6irkFKpYgOyOdnnakqKSxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789192607; c=relaxed/simple;
	bh=qUspKEfoo20hCAE4JDf4cCHryC/BhpntvvLEMB/D0bs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jjD5D0Cexgxisp75zcH0pMrxxoGH+eN81v0ejeUcWY8rtOXS/+pQsw1KYn95cIiZJkA2JLCxFS/2sGIUF4jQqodNo/oNuAwV5xPb09tEsjIrZlPHApNHYLN/4mbvMU1RI3CSNbNBNIxKoSzDg/F8ZjwQA63uS/Tarfq9FvDKcUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ove6PnjU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ove6PnjU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034D81F000FF;
	Sat, 12 Sep 2026 05:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789192606;
	bh=fS8BZAbyk1gyoqTdYRGwxa95y++Up7StcLkXoJAwwKc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ove6PnjUIXoBDp1yvCUJHqNiUXLaoNEBvpHdxgKNZvynnRD0aAihNsDGPDoIPelQU
	 2UZk+g8dSJykIYYaJiN1+2GAB+TTt2FTpD61nEtYvcnvparAmhwDr3ebinSvdQUeVu
	 7IS0l/27LtjQGBFR80O+VjBQFlwymh9wJv4eb8fCU3ukCQUyR/mCJtWdkXRUp8fslT
	 dLwEDAXfXRgkrq8PEH7b6Ehwy3GgzX2DwMrpulUf4KKWDNedMt1SO5mNn9SCnHdOUd
	 W8GUZ/wuQCeuJiIxmK8r2tiZHjSkN3M4WnXhWEMNjOvU3BBbSB5af8qmqSnpAIDGVJ
	 RSklZkdlAZ9gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] perf annotate-data: Convert type histogram to
 hashmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260912054706.1475583-2-namhyung@kernel.org>
References: <20260912054706.1475583-1-namhyung@kernel.org>
 <20260912054706.1475583-2-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 05:56:45 +0000
Message-Id: <20260912055646.034D81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing index increment when hashmap lookup fails in `get_member=
_overhead` causes histogram columns to be scrambled across events.
--

commit 4840a8fb0b1911e5130194633a0b05e4bf3e21fe
Author: Namhyung Kim <namhyung@kernel.org>

perf annotate-data: Convert type histogram to hashmap
   =20
This commit converts the type histogram from an array to a hashmap to
reduce memory overhead. It replaces direct array accesses with hashmap
lookups across the annotation components.

> diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/brows=
ers/annotate-data.c
> index aa8c89fe2e82c..82667c6ae2e74 100644
> --- a/tools/perf/ui/browsers/annotate-data.c
> +++ b/tools/perf/ui/browsers/annotate-data.c
> @@ -62,12 +62,17 @@ static int get_member_overhead(struct annotated_data_=
type *adt,
> =20
>  		k =3D 0;
>  		for_each_group_evsel(evsel, leader) {
> +			struct type_hist_entry *hist;
> +
>  			if (symbol_conf.skip_empty &&
>  			    evsel__hists(evsel)->stats.nr_samples =3D=3D 0)
>  				continue;
> =20
> -			h =3D adt->histograms[evsel->core.idx];
> -			update_hist_entry(&entry->hists[k++], &h->addr[offset]);
> +			h =3D &adt->histograms[evsel->core.idx];
> +			if (!hashmap__find(&h->samples, offset, &hist))
> +				continue;
> +
> +			update_hist_entry(&entry->hists[k++], hist);

[Severity: Medium]
When hashmap__find() fails (indicating an event has no samples at this byte
offset), the continue statement skips the k++ increment.

Will this cause subsequent events in the group to write their stats into the
skipped event's entry->hists[k] bucket?

If k is not advanced for the skipped event, it appears the histogram columns
for multi-event annotation data could shift and display in the wrong event
columns in the UI.

Could we ensure k is incremented even when the hashmap lookup fails to
preserve the correct column alignment?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912054706.1475=
583-1-namhyung@kernel.org?part=3D1
