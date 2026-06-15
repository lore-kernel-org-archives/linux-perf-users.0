Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B8B339853
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781564655; cv=none; b=ms2yjVc3OAJk1xhany7Q9WQ0VrogXthbygChh7MZRL29qln2OJ4CFaCI30SsEGagXHmo0IZRyI1FO8k33TAuJZ2P6liVk2AM+WWljQWE0eatChZeY7Nu94CpkJbRxI9HS9p3tl2kqWDL0bN3jMgJ7uJfzjjoIo0ERIfb1E2vh8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781564655; c=relaxed/simple;
	bh=564WMzKtc/Kikm5+V75+e85jwIjd01vgqhps1d5c1ns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FaPirQhkDjMny2KrLiPuDLciRjPbNDm+oqWPvLqZD8Aod3PqLgdr/PI2sMfrhBMxtSng5m2vYedl8poYMbAhFEo63reXvoNReV5rKJE0DxiMqn+X7lz0szdnY/dBLAgp2YqkTyKs7enCIvObgeEGXPmKxu00MNk1yat4VzO2UA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUjqLHzK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUjqLHzK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0914D1F000E9;
	Mon, 15 Jun 2026 23:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781564654;
	bh=0dH4rqFcBkf3r8hDu8RtZsjrUPTIDVNrxvC+ty/Kaig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RUjqLHzKtw6y8NgkP/l4jL25f1grDWvrVrLE2/fK4VSQOySPJyFRnwJKj3dDd5gSj
	 ITB9XAwhJYpWEE7z3MLvhOS0AqwY72qI1/9GJmXR0f1duvL4/utL1B3EaGIjC1oo/D
	 hfIPTHN9ar7T0wTnp5HTJGFmHcx/NrXiwwqr6ntJmQr4t/r9A2nD3CCqogTCKlX02f
	 i2t+eGrPhDnPqQbpyvxgSsh4MJFEGdCK2w6tQ1/r2aoQ5fdrPUd2VOv3MwKYISjagT
	 3LZALOe2/6XZQ5Yd9ha09vnsePVXUc/ZJxDE+ySYxL/WzGA8dkCYeLiqBhrhCAlFjC
	 3OACt/jM3B31A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/9] perf c2c: Fix hist entry and format list leaks in
 c2c_he_free()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615223249.36598-8-acme@kernel.org>
References: <20260615223249.36598-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 23:04:13 +0000
Message-Id: <20260615230414.0914D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] perf_hpp__setup_output_field() and perf_hpp__append_sort_keys() =
append formats to the global perf_hpp_list instead of the provided local li=
st, polluting global state and causing missing output columns.
--

commit a4f0bc9a81bce084555c8dfe98ae2f6675da0ef8
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf c2c: Fix hist entry and format list leaks in c2c_he_free()

This commit addresses leaks in c2c_he_free() by replacing
hists__delete_entries() with hists__delete_all_entries() to walk and free
all inner hist_entry objects across all rb_root trees. It also adds a call
to perf_hpp__reset_output_field() to unregister and free dynamically
allocated format entries on the hists->list.

> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index eabb922ef295e..c9584dbedf77a 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -184,7 +184,7 @@ static void c2c_he_free(void *he)
> =20
>  	c2c_he =3D container_of(he, struct c2c_hist_entry, he);
>  	if (c2c_he->hists) {
> -		hists__delete_entries(&c2c_he->hists->hists);
> +		hists__delete_all_entries(&c2c_he->hists->hists);
>  		perf_hpp__reset_output_field(&c2c_he->hists->list);

[Severity: Medium]
This isn't a bug introduced by this patch, but does the setup for these loc=
al
hpp lists append formats to the global perf_hpp_list by mistake?

Looking at perf_hpp__setup_output_field() in tools/perf/ui/hist.c, it takes=
 a
local list argument but uses the global wrapper perf_hpp__column_register(f=
mt)
instead of perf_hpp_list__column_register(list, fmt).

A similar issue appears in perf_hpp__append_sort_keys() in the same file,
which uses perf_hpp__register_sort_field(fmt) instead of
perf_hpp_list__register_sort_field(list, fmt).

Does this inject sort formats into the global list (polluting global state
during processing) while leaving the local list missing those columns and
breaking the output display for inner hists?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615223249.3659=
8-1-acme@kernel.org?part=3D7
