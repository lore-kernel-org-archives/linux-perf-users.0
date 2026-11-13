Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607352;
	b=QyG7FDqaEeNDzmvbJTVBT00xNKPsoy0oUMgEXaZoc0upprVN47KMdtFaKtgwW6Kn8Luu
	 8YeJ4VtLsF1jG5Tan6CfrYgLumOUhHROJyS+mnhIxfHR1VCunGMISVsC5Css0ObU+iDk+
	 pOlaJK21ppua2nVuyhLgN/DiIq/7xBTX8xvmoXVKAZ7lHZMMrW7QfyK3p4SNpvAdOTYPg
	 SlA5TSu0CDtVgrMXg6G4kvYOJNlfIYSMeFsXrNkQ+Uytyd9/xcgjAXvSKutVzwMqUd/yI
	 4EOb5gPkpWtO9RxqJft0mOVyDP7+CTCi8wQoYSB+Aoe8cbSRw0hVb3djIuFe4gVLb6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607352;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gdRi00hl6KXd0pIEAaBi2zoUzbz2D1LWVuhwFDNIIu0=;
	b=5gHVSKC1zteBL9476YdNKJfx6KHSjL6K4EAeOezeYLjZDNB2YgaiCUm3qlAILhc75sPc
	 He96K+93Jk7ORgT5pLHwtl/EaeUwH/0vy1PN5twNM6MXSSLf3eVLVd6sC9HYEbwnJP/wJ
	 GCMfD7u7xsh3faJFketZKoPiF2YdrpDI9Wix1HsG5x5Inf37op2/XqSI40qioOKsWdzAy
	 9+4r4Qd7e8UE2VIpVII1+p7VAz/NRMefEhP1+LdRZL2I/SExMnTqd2dbl5W6YIFGcmKc3
	 TSw8cMaUL4BONTQ9a2Z6kViD6YaO1VTTFu1vci/tUd8FEV7D+oZiynT8viE0oA2k+jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f/JSBB91";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD35606A335
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 22:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f/JSBB91
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C6E1F000C4;
	Fri, 13 Nov 2026 22:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607352;
	bh=gdRi00hl6KXd0pIEAaBi2zoUzbz2D1LWVuhwFDNIIu0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f/JSBB91Fr/WRUwPbcmWjkT14c7Lt8bwHmd7dfisrMXPpTROXVsHxHsuPkENFkU/1
	 3uy3RuOMRHYCWcAfCYiCrohYfxD5nZRNLI05TcyWWKGwBaCZ29Om4X+bAVfCOb5EFk
	 kaLAoxhmZYyZpZ3bFWznd/KqZyk6dmd+pmUnn8rY7FvM2oeF86b9jMWqKepQB2ALKq
	 wo1TNIpzWIl9zj6UpRbIxa9cQ2lQK/Yz+V3GixOUTpWBKiX7bWD3qEIIarWmA+dbSV
	 nr/Cf2DPp89QdtM1lU1Fp+Il6xHKiwhm4PY9934zKlofiX1qbTuquw88pTTLtSPxY5
	 LNokUDXYHbmTw==
Message-ID: <sashiko-outbox-213769@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 15/26] perf expr: Use generic hashmap for expr_ids
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-16-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:02:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] perf metricgroup: memory leak on realloc() failure in
  resolve_metric() [1]
--

commit ae2db9c3e031dce4b59bc868fc5b91f5ceff2de6
Author: Ian Rogers <irogers@google.com>

perf expr: Use generic hashmap for expr_ids

This commit converts expr_parse_ctx::ids and its helper functions to use a
typed hashmap declared with DECLARE_HASHMAP(expr_ids_map, const char *,
struct expr_id_data *).

> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 779fe56fe8d0c..41887fad49682 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c

[ ... ]

> @@ -765,10 +765,10 @@ static int resolve_metric(struct list_head *metric_=
list,
>  	 * Iterate all the parsed IDs and if there's a matching metric and it to
>  	 * the pending array.
>  	 */
> -	hashmap__for_each_entry(root_metric->pctx->ids, cur, bkt) {
> +	hashmap__for_each(root_metric->pctx->ids, key, val) {
>  		struct pmu_metric pm;
> =20
> -		if (pmu_metrics_table__find_metric(table, pmu, cur->pkey,
> +		if (pmu_metrics_table__find_metric(table, pmu, key,
>  						   metricgroup__find_metric_callback,
>  						   &pm) !=3D PMU_METRICS__NOT_FOUND) {
>  			pending =3D realloc(pending,
> @@ -777,7 +777,7 @@ static int resolve_metric(struct list_head *metric_li=
st,
>  				return -ENOMEM;
> =20
>  			memcpy(&pending[pending_cnt].pm, &pm, sizeof(pm));
> -			pending[pending_cnt].key =3D cur->pkey;
> +			pending[pending_cnt].key =3D key;
>  			pending_cnt++;
>  		}
>  	}

[Severity: Medium]
This problem wasn't introduced by this patch, but can a realloc() failure
in resolve_metric() leak the existing pending buffer [1]?

When resolving a metric that references multiple sub-metrics, pending is
grown one entry at a time; assigning the result of realloc() directly back
to pending overwrites the prior pointer with NULL on failure and returns
-ENOMEM without freeing it.  __add_metric() has the same issue when growing
root_metric->metric_refs with realloc().

[1] https://sashiko.dev/#/bug/linux-ca3710c6-abe9-465b-8da4-8cb1ea1a2b6b

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D15
