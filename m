Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DF233F597
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686420; cv=none; b=djaEF4OPKhc5iaUeHLSa5dtO7LNhKt05SmjcxPeIZGhMNTPMUDxg/I2RRmWOvL9nWinlV0wYZiPkh5LrefcXgkRLgTshOFMMBkWLTdqdHppVRvbjKseZADyw46WNgeJViL/rNiFLICzQOFq/I2qfK9XM9748OwJ12rCVUtg2I2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686420; c=relaxed/simple;
	bh=grrrxgqhnSOZKA90VaOEdVe+0oKqh14J/UkKulDdrGU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kFu3S5dVCyHCUteXgBQn687zwyo2OxwJeni6bjH3oIkXJv60ipYFojE/Yf+zwXVQdFuoraaHtgGULJw9i6L4YonLjsExtIJlJYCjnlbnGcukqT5BAimdSPog2W+NNRHzsIZlR1JY+qgJvrippMLcoguJLsAmfbgHY2DQx4TYbsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bL4UxoGR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bL4UxoGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77A91F00893;
	Fri,  5 Jun 2026 19:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780686418;
	bh=Qfgnk5OqimZFIC1nlxPC4ZyweqRLDs6A4DTGeHm74dU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bL4UxoGRhcNxFQrBDjtrMX0Fl1KIQM5K6b24NYacH0twSULhamnKpGsXbzVoromav
	 82MWcnAOnuEfGVMmQrSANrry6dblEV8ehiyC5I1j6z/WHu1zMlaGEiDhxxWU8vLHv1
	 o3Wcs4oKql3KBfzwxhUx+fUd6gAyDPHOw9X3LnjKlmNH8EOpKXP7O5RgfWfjZEJ0k9
	 A+bEMLb6tWIV/N1v57gaYFuFOL+lIBnfUYgW96YxBCF+2Z2JCeJBqoQft6ZgFTQDSy
	 Slv91KRHIxw5CxW463DEXOf6kZE3ylRu5ztTKGVVFan0nqM4T2/9RSDE/35Z7/1HZ+
	 4ANIqvSe4Yfmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/5] perf maps: Add maps__mutate_mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605185215.2359881-2-irogers@google.com>
References: <20260605185215.2359881-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 19:06:58 +0000
Message-Id: <20260605190658.B77A91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Compiler error in `maps__load_maps` due to accessing non-existent `=
name` field on `struct dso`.
--

commit 42ed9a7e77f954259213b06a013da93fc23180c3
Author: Ian Rogers <irogers@google.com>

perf maps: Add maps__mutate_mapping

This patch introduces maps__mutate_mapping() to safely perform field updates
under lock protection, resolving a concurrent lookup race window. It also
adds maps__load_maps() to pre-load all kernel symbol maps up front at start=
up
to avoid deadlocks.

> diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> index 923935ee21b66..aed72c9f0a509 100644
> --- a/tools/perf/util/maps.c
> +++ b/tools/perf/util/maps.c

[ ... ]

> @@ -626,6 +669,41 @@ int maps__for_each_map(struct maps *maps, int (*cb)(=
struct map *map, void *data)
>  	return ret;
>  }
> =20
> +int maps__load_maps(struct maps *maps)
> +{
> +	struct map **maps_copy;
> +	unsigned int nr_maps;
> +	int err =3D 0;

[ ... ]

> +	for (unsigned int i =3D 0; i < nr_maps; i++) {
> +		if (map__load(maps_copy[i]) < 0) {
> +			pr_warning("Failed to load map %s\n", map__dso(maps_copy[i])->name);

[Severity: Low]
Does this cause a build failure? It looks like struct dso does not expose
a name field directly. Should this use an accessor function like
dso__name(map__dso(maps_copy[i])) or dso__short_name() instead to retrieve
the name string?

> +			err =3D -1;
> +		}
> +		map__put(maps_copy[i]);
> +	}
> +	free(maps_copy);
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605185215.2359=
881-1-irogers@google.com?part=3D1
