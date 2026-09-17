Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909D84E4C32
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661042; cv=none; b=Z2ZB2fcGjhmsJsY9bpoAueCFIR7gbO5zY991vkoQCtZrH7ssiDp/PGO3X8kRLx7j/fALlNwT//jm9+MuLrCSXvMdO79Y5YDrJcLkhs+JM5UZrxJ7brOMVuwcLMkVn4o++V7eSzh8lClExnDfADyEK5BFv1ARdyzbUYOb348F/yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661042; c=relaxed/simple;
	bh=srbp3n4Ei1db1EFZd1eIyPNk18H6goSvcCC3rfuzFTo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WLY5/m9xWqGQT9J7WetkQEqDXMb83wvHLeXYCvbqwk5olTzJEXeAJMHKxCAawtQY8H6SvD7/+sj6vhGibSPHAu/Nk6TKDusqAvHgVMO0n4buoOyRrFjncwEELro35vI7NL9j90Y25S9XWzFaVOLWUGqNS08B9VIXz/imJXvh6nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/tPXXWN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/tPXXWN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1430A1F000FF;
	Thu, 17 Sep 2026 16:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661041;
	bh=ic87yFq7fR/n4AjGgEpVRiL1Yp5X0qjvTvEzcsb1EsE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h/tPXXWNb4nehwTsTyIGQoEj0I6kq+omeHSGBvLSp8vglyJjiytXgqohPc3V35yc7
	 fHA9qMgp9DvhGERA5k/qsZfo72XOVWwdWkzp8zOAs7pnF3/woflzCL4gOzywwzg8an
	 lz0OKKiEGpBd6+gj2PLu/bJUlOYVbhd7FsTZmZklo9HIOukkqy5fxOafCeejs8iVpw
	 z1Z5RYCj2c35uWT5HctRsOceYBERK623xENvAWFRZD9czqK9mmB2q5ajXZgIA+dEWT
	 5jMozszAK7FCHx7ehr/u8+b803xuw5d04ekAB3dv6VTZuoNxii89iY4yXcLQ99+7DG
	 kr7tr0WFMK1gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/15] perf annotate-data: Show the sample count in the
 data-type browser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917155528.62607-8-acme@kernel.org>
References: <20260917155528.62607-1-acme@kernel.org>
 <20260917155528.62607-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:04:00 +0000
Message-Id: <20260917160401.1430A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The samples view (-n, annotate.show_nr_samples) prints a local
> nr_samples variable that is initialized to zero and never updated, so
> every member is listed as having no samples while the period and percent
> columns for the same entry are filled in.  Print the histogram entry's
> own count instead.
>=20
> Fixes: d001c7a7f4736743 ("perf annotate-data: Add hist_entry__annotate_da=
ta_tui()")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917155528.6260=
7-1-acme@kernel.org?part=3D7

