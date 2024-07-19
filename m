Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7431B86D5;
	Fri, 19 Jul 2024 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721404586; cv=none; b=KuodtNtv8WKxCG03aCSFSp1lqBCnXXbYL8gnLocsZ8H05Xx2UCbyOJjQriJwH3LcuzYfPeTJ0fiFKwKIF9kps31JvTxcZ9QzLYyh6152fJkFPlMz0M0+1b7hPev+Q4wPgf3igZFJNr5ocVL3YTQsFJBcLCdP9xzazC3sN+KC4Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721404586; c=relaxed/simple;
	bh=+BKBZ5774TCOg+pY5eqYS7Hi4ZyfCyYXwJoDM5g0gJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nL3/ItaGpFZGP6VWcaYbhSZLETBlCzFkhN5sIFT008p9iaQ22MKRtjz3PnfI4G0ADrRld/isBgpFI6Tneq80QnYiJrLqGhQgrUU+gGIMHUMEL/efjYSepDYcKLCnvJzU+lVmSBwMcWxj9z5P5JgUp5abDMvugXyRZmikzVti97Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=Z76MWWVD; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="Z76MWWVD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1721404566; x=1722009366; i=christian@heusel.eu;
	bh=md4fxjDvoKtJafsGWHVwyEzKIUIHCFn+YAHjG3lWpNY=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Z76MWWVDNC4MgnLRiOFas+zmlUZnLvowhk7sP2S/dzDdwUTCEOtoHqT1yaRflszo
	 3Wd+wUsw6tBtohJ90j+W6xqIey52uKnrg+boCBprWZ+Tg947lRZnRHZorr/JKfFfX
	 a5wkvW9fC/FlYNmbPqXSv9TO3MyMW5RzJ/mIhJsa8oWc9ctrmJh2Dx1zujzxGcij3
	 b30ukM2SFBkZqyknfuRD7QQwtG7nq+DuxeFky8eIDp354r11MzlZ7Hk+Y/37pKfBy
	 7kfusBWAYsm+OBdoRfaP11DfnwZy+9Aq/L+609kxfaxA2TrkewW0nkR8P+k8Avh3j
	 7nw+sxoFBsLBu1JtDA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([80.187.66.79]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MN4ux-1snsaA29bx-00JylW; Fri, 19 Jul 2024 17:41:12 +0200
Date: Fri, 19 Jul 2024 17:41:04 +0200
From: Christian Heusel <christian@heusel.eu>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf trace: Avoid duplicate code in fprintf_duration()
Message-ID: <c105871a-6462-4678-9f0c-b2ed5a254bb1@heusel.eu>
References: <c564da16-062f-4da6-9021-c68f9c6eab63@web.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m7hjjenmd5vtslfv"
Content-Disposition: inline
In-Reply-To: <c564da16-062f-4da6-9021-c68f9c6eab63@web.de>
X-Provags-ID: V03:K1:w0MOn1nMqBRpHJaCJc/YCa5vMWdqSfo+968q2TPjOYF3YjA+9WW
 /YaHWWZkzkD7vvU3AW4VfaVJTZW0/sY7CBZZqdxcCnxNHd7i0nErKkAkDy66zVOAkgf92aC
 nNbCll3ka3leKQk6hnGZwWImwwnze6II4LaKzYAzINrc9Q9m1hhxzpO6TZ5tBic+r+KP2Aj
 CAaKANLOh13j1ODjZJVBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UmgJgDO60jE=;cWfsEGS7l1zjyRmFumVdbAO+qte
 agUfXjuXDUT/7BRPuMDCYkuNqWOpXesRhnKnE4kZ+r4odc1qrfwKzSuIwJSEN2vWBl7w6e9lm
 GV8DjXtPQJLA4vihIvyfp3mnbkhDDvabl7Yntl1NVJbg4PYYj9s7l8yZB4BqWpLNXDYVI+rE+
 zrQm3htVfiaeC5JR86kzUmPqVNyXK2H1ymEAt0R0Nt1+Cw+7oZlu+DdRWWgEZELC6nFuo1zxU
 GlcDTdoE6wzjSrc5URiWuXeF0OZbl2e6HDasNXRNfPiMaCZDilAcgyJ0oUJKEhT81jwj0M6fs
 6MKhFvn/jxUbN7G4Ys1+8OOXppAlhlQRBJk04GrQmQdP7J8OsD9ewTM0+vyXVVTrch1sLyM9l
 380UmzXJlAtyxTmmu6Fo2xe9GUJru2Jn42S3jnJUfEJd6Z/4fdnDxZOBY48IEw+OCbkuDA+4x
 nHylyHMRP345V0FnwizgJ6DBzqrb226WFwsn96wg1cN9Di17OcItUWDC8s63Bq/5aYj3LCVbd
 sc+0cJpxXbB6HZa0/1Xhz3wmU9zsVoPSyQ6Xp4lhM18zOXYVn/cvS4O+0hr62Nxxjp/FRz7bh
 gH7OteNoOePQwOKns5xUvqZjlOsfv2R1tOlXtBpTZNaCg5geXlxnwS4SkPMkOoukibCr155kP
 bs9XuJXA1f8J0kILW20aoIi42JyGy8uLW0tZFpRXoZJ0mFVzqGOFO/ghZQ4TeAEkDuYxfWwoK
 GPaJD8PdrrhTd+sBOkFoExUSksbRZe6Gg==


--m7hjjenmd5vtslfv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/07/19 04:17PM, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 19 Jul 2024 16:12:51 +0200
>=20
> Adjust the colour selection so that a bit of duplicate code can be avoided
> in this function implementation.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  tools/perf/builtin-trace.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 8449f2beb54d..e29ae5cb95b0 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1258,12 +1258,16 @@ static size_t fprintf_duration(unsigned long t, b=
ool calculated, FILE *fp)
>=20
>  	if (!calculated)
>  		printed +=3D fprintf(fp, "         ");
> -	else if (duration >=3D 1.0)
> -		printed +=3D color_fprintf(fp, PERF_COLOR_RED, "%6.3f ms", duration);
> -	else if (duration >=3D 0.01)
> -		printed +=3D color_fprintf(fp, PERF_COLOR_YELLOW, "%6.3f ms", duration=
);
>  	else
> -		printed +=3D color_fprintf(fp, PERF_COLOR_NORMAL, "%6.3f ms", duration=
);
> +		printed +=3D color_fprintf(fp,
> +					 (duration >=3D 1.0
> +					 ? PERF_COLOR_RED
> +					 : (duration >=3D 0.01
> +					   ? PERF_COLOR_YELLOW
> +					   : PERF_COLOR_NORMAL)),
> +					 "%6.3f ms",
> +					 duration);

Why is this a desirable change? Folding the if-statements into the
ternary operator makes the code quite unreadable compared to what it was
like before and doesn't give any obvious improvement.

--m7hjjenmd5vtslfv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmaaiRAACgkQwEfU8yi1
JYU8NBAAinnuFkU8WOl3M81bwuAkgGxtxgB1MZssGbfl1Yp2IyKks5DcDfX+oLnR
EwgU2oNvSM3ty47sdSWIbu/SXDTcVN1FDdjDSQnPL9ZB6+P9eux3KuJlEHZOyvmW
1bYy1NCSsJ18pPKwNhG8khcpwsgC70/AUk1IQ/xv26ZERiddhvrd7+RIJl4Y6wCn
B7MKoMFNLjrvCPco9TtaL01r93jL74fC31qThuIF2qKZen04Pkl3cET11HG/dyt3
tBkkZu36Tdj36NBM5lWzf4ehxYLcf6KI/OL8MInwLhoJb15lbq3AgTNBo2xlFyhX
Tk8PYCNxFxqeIhXMrn9ARErYRBiUWMr0d8csdSyyALi1R7opXxmK3JzigPgpz6Jl
MXjzt3oLQ/WfzYSahpfhK9vQAB6O/I1d/fdN3RVJ1i1iQV/nbJvG1Ll0eUjo9ZTM
9E8XWZdpGdY/gWXYn1cVD8YZojNlucCYNT+ZUc+VREl3IdskvA6aghJCzzOXt5Pt
6/FWWKQmw+5xxcQRjIV5MUvx2KvxoL8qTQDBlVs64uDXj96ts968w3sP5S5io2C4
Okw19vJyMqXxeMHBLNLBeAW0/RtmHW3dha9RFjCWLJXTCq0ii6DbLO3XbMGTrchd
iOh11k6SlXLCfLmz8ahiGGH1P5GouBv5U9G8tpaUHY1/Qml3nYM=
=6fHp
-----END PGP SIGNATURE-----

--m7hjjenmd5vtslfv--
