Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794560435;
	b=tSOC0VIpaROJ7AGvBafXaHUH8xKYpSnIKr4EYOBiHB8x2NM5bUJaYZnfR8X2Ba0IAHvq
	 ezPanYiNqfsuO4MHGUfTrVvg78Gyfxa6uCdFfRGkkli+mMeC3OSAA/kGqQlJbHuJRXeXR
	 XTvQ0q9uI+RNFgsTINZ+p4EJW0LwYFBDUmi1/IKA3dLBk+Litf9xxIZE+EkqP+PkUnLW7
	 ijVinhrtp66awbBfDNfdan+kUgqNAzOhnHjxi3LaNR7E6jP//SUk/sTbudJJOYn+2ejeT
	 Oz9oLooH6oATVEMrOQiyQnC6odWy2X0JtmEQ+BNtvSOttUwFBdBzqIu66xLFzXBb5mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560435;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Jnb+Cl5lZq6ZnAks751sAdzTI25zlIMijUSm1Lxgy5I=;
	b=Du9NlqaTAQPSC0XlGNVYF4BBDPoZUmik8853LwcCJ4bthgDkYtgTJKkOZjqlG5eqdChG
	 FgRPnondXE+g5u1yrOYWVNmDk4AA9cVqx5qIBS9wHt82aNHabNnf6pK2uqKAhrrreNqQ0
	 nwPUsSuFPXNH3GP9fCugo2ZoatKVGZJMV0r5NwT6jSJnt8iKoyT0imArDDfUGzrY8eD3C
	 GgVdmGyGwzj2ZOgFDvtIhwhGBSSWXBDh7hF3X13/PW2cekEFHVzRmi/ka+cm8FLmp+7GE
	 r+JXRtp1x/mG6yEzeH3FiGQ6Sr4/LoqAqRKQnZhhVrkP+Mk6HcQnf/IKs2i8TWbiYng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h0YwKjDi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E7A606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h0YwKjDi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BB61F000C4;
	Fri, 13 Nov 2026 09:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794560435;
	bh=Jnb+Cl5lZq6ZnAks751sAdzTI25zlIMijUSm1Lxgy5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h0YwKjDizhT6S8FvKW2/ZiSHzwbD1LezpcyCJmB09tdVuT4slcw3TvTAbj7C3W9BR
	 2C3yUWd3g0Fp9yptBGGpdXFjvuPoR80jHjBHQ7nuK+2BZQybZtKg3jAdTuHuObLH3N
	 3T8na6H9qg+PkuZ4cR0N4+U4Jos/uGLA/LUc0qX35Na4GGOLEZXljE7CAnFEvK48HA
	 975iTPSh27sdZsCzzq2qO16TBbJx8VPOlz4PtZhMkQUkv7bvtkk9w8zNfQ7O3qGIVB
	 2ZCvCz7tdesT8xdsBfkK7lhR5CaZzfCIJgLigQIKeap+gF5gw/Jl32i1PemJVKYvbg
	 at64QWGyBvkMw==
Message-ID: <sashiko-outbox-212492@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf parse-events: free evsel and config terms if term
 conversion fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gu Bin" <gubin@cmss.chinamobile.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113085202.2334-1-gubin@cmss.chinamobile.com>
References: <20261113085202.2334-1-gubin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:00:34 +0000
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
- [Medium] perf parse-events: memory leak in parse_events_terms__copy()
  [1]
--

commit 4ef9371b87de8bcf35fad7acbbc63f271bc56ae7
Author: Gu Bin <gubin@cmss.chinamobile.com>

perf parse-events: free evsel and config terms if term conversion fails

This commit frees the partially populated config_terms list and releases the
allocated evsel when get_config_terms() fails in add_tracepoint().

> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index f3ba70d4f76b2..e4f8425321451 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -490,8 +490,11 @@ static int add_tracepoint(struct parse_events_state =
*parse_state,
>  	if (head_config) {
>  		LIST_HEAD(config_terms);
> =20
> -		if (get_config_terms(head_config, &config_terms))
> +		if (get_config_terms(head_config, &config_terms)) {
> +			free_config_terms(&config_terms);
> +			evsel__put(evsel);
>  			return -ENOMEM;
> +		}
>  		list_splice(&config_terms, &evsel->config_terms);
>  	}

[Severity: Medium]
This problem wasn't introduced by this patch, but can
parse_events_terms__copy() similarly leak [1] the cloned terms on
dest->terms when parse_events_term__clone() fails partway through the list?

tools/perf/util/parse-events.c:parse_events_terms__copy() {
	list_for_each_entry (term, &src->terms, list) {
		struct parse_events_term *n;
		int ret;

		ret =3D parse_events_term__clone(&n, term);
		if (ret)
			return ret;

		list_add_tail(&n->list, &dest->terms);
	}
	return 0;
}

When parse_events_add_pmu() or parse_events_multi_pmu_add() calls
parse_events_terms__copy() into a local parsed_terms struct and returns on
error without calling parse_events_terms__exit(), any already cloned
parse_events_term entries and their strings are leaked.

[1] https://sashiko.dev/#/bug/linux-dd6119ed-0ace-40b2-bfe9-492b265c7283

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113085202.2334=
-1-gubin@cmss.chinamobile.com?part=3D1
