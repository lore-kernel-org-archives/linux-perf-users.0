Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0716347BBD
	for <linux-perf-users@vger.kernel.org>; Sat, 10 Oct 2026 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791657283; cv=none; b=YsoVYVtj4mqnG6lJAUijwToHKxXtNznf5TV/oyn4/EhB4FSqO4NmPno+PygR4nlnQkladnE5qPlSwE+m/yxKrX8i4l1g2RWuMktcaekmqB8f3ZPx7z08Q9TP0f6UrNSqTEoadL9lZyn/43ei0KGrC7VqCUgF/hn79coYhkaOlf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791657283; c=relaxed/simple;
	bh=XWyAdOx2dkpeeMLK6w2jbilTjZD+DNpaqj1ewVn39EQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=p8TdcnCKSVbvz+ajrz7pGowOAWQsS8vQXcjTz502igIQuF8WSHa2jhi/Ae8VLp69zZcnQTcCApkTQB1s5LK4if70i3OmCauL0JWk4AsRGweq61wlvpgR9HptYSPzg+cmV6jyfBiisVqGVtGQPgB76PDlbD3Kxemq8AXaKS6414Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaDNt1u5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaDNt1u5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0933E1F000FF;
	Sat, 10 Oct 2026 18:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791657281;
	bh=swhA/4tIihVW5DMYUhvQQMtS7zP9q/2sIQufNOEB9NI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UaDNt1u5wv/gm28Ldg+RRk8VCqjC8AmNQMe/rAvFrrrKmT3xk9GnRE1gvHvdgPA7m
	 k7oNOWSKlannBgoX0I4B8TmGMUSyFHczvATlp/35W0gtNTZQZyHyE3J+aQC4Kiygr7
	 AkYFrV2VUr2AqQQ14NXyoGNbnCtoyuwEb8AK/YukD1+ogV+OQ8PG+NWxShHYaMC/wc
	 ZRezyDQe1f2lg18923Rqd3JEazP0We1ZL5MnKtGuViFZ14A1kzFPwwGi3HlI7q741p
	 E48vh+feFerzoa54Pcn6gw5PhxEkw8fw8JsiCM0PNtgTRZuKF798kNu9ZeCNTmgpAd
	 SUYZurLMJK5wg==
Message-ID: <sashiko-outbox-166825@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] perf symbol: Set dso symtab type for libbfd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261010182439.9732-3-namhyung@kernel.org>
References: <20261010182439.9732-1-namhyung@kernel.org>
 <20261010182439.9732-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 18:34:40 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf: double-free and state confusion in libbfd fallback path
--

commit 8791c82124897f35132a0fe029d993b2dcd4a6bc
Author: Namhyung Kim <namhyung@kernel.org>

perf symbol: Set dso symtab type for libbfd

It missed to set the dso symtab type when the symbols are loaded by
libbfd.  When it happens both syms_ss and runtime_ss may not be set
and won't call dso__load_sym().

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 5e63c3477570c..debd0a66f9669 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1929,6 +1929,7 @@ int dso__load(struct dso *dso, struct map *map)
>  				symsrc__destroy(syms_ss);
>  				syms_ss =3D NULL;
>  			}
> +			dso__set_symtab_type(dso, symtab_type);
>  			ret =3D 1;
>  			break;
>  		}

[Severity: High]
When dso__load_bfd_symbols() succeeds and sets ret =3D 1, this explicit
destruction of syms_ss does not remove the struct from the ss_ array because
ss_pos remains unmodified.

Does this lead to a double-free later in the cleanup loop?

tools/perf/util/symbol.c:dso__load() {
    ...
	for (; ss_pos > 0; ss_pos--)
		symsrc__destroy(&ss_[ss_pos - 1]);
    ...
}

Additionally, since runtime_ss is not cleared here, can execution incorrect=
ly
fall through to dso__load_sym() and overwrite the successful ret =3D 1 value
from libbfd?

tools/perf/util/symbol.c:dso__load() {
    ...
	if (runtime_ss && !syms_ss) {
		syms_ss =3D runtime_ss;
	}

	/* We'll have to hope for the best */
	if (!runtime_ss && syms_ss)
		runtime_ss =3D syms_ss;

	if (syms_ss)
		ret =3D dso__load_sym(dso, map, syms_ss, runtime_ss, kmod);
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010182439.9732=
-1-namhyung@kernel.org?part=3D3
