Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B551A352FA5
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404239; cv=none; b=uRFs5zKtBH+OfVFwyFQ+RvjwdV5N2JH5E3h+Wz7CPIkZFXndswyjTKQnHJhIDBH0a+JNj82U8tcjCq5gzO7/hbDndfG8Bii6h78DnvVKBvH86jPOt1k8Dw04SKXlsr4GlV5mfs8UXklpYEZ+7DcXM1iK7zejbBDoZU0QHJlOAkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404239; c=relaxed/simple;
	bh=G8vRSaWQvQE1c1rL4B+BJzLthkKhgXPSARs+y8zdksY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XYqA/xQNe2RSEIhfVgKdIdObehayYHWwAa7OX4n4fPJqY7n/WeDS/c/zyN2vvKEdjNy0QVcuceHExcXfpPb+//vq0w55xOGyAy416QIZDihZR5a6QSvF7OcZRLW+qxAd1nvgD7NhdTvSG7s3DWTSFKINiq7Fjopb1QKqrDDgGi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpTL2lwZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpTL2lwZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505161F00893;
	Sat, 26 Sep 2026 06:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404237;
	bh=jWeA5E3Aaz3BM4g7BEnDMDNj3FVZKxJXiup+rUpj+Dg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UpTL2lwZfukBa17REGyK+HwqD0Ff7cV8lp9PRbkkd5GaGVoX/7+IzNi/0cZLSgMKK
	 LomepGGHu/zkyTEgWkAbETAeGfOrM4DwOEsKsZBZNpOmAK1Ex4Foj5wXfAtI7Bzc66
	 nRmO/c4bPc+LBW8zQkHcq7x7ALnqcYtdn4v9H1p57xyEnb0AnPbDVxYLuVjRnHIWLV
	 8vJfDlRGCLtKZKe5Fx76uVth/maU1einDYm5mnBw+9s9G1aNfE9+yxBQB626o+qvdh
	 zeBQT/oexGfm8vlFW30c5wr5gf5eTs+6rEE+MW3AAPCd90wcYIOUvELOhOAf+6Njq+
	 +F1K4PU19Lo/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 20/49] perf python: Port gecko to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-21-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-21-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:30:36 +0000
Message-Id: <20260926063037.505161F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port gecko.py to a standalone script in tools/perf/python/ that uses
> the perf module directly to convert perf.data profiles into Firefox
> Gecko profile format.
>=20
> Improvements compared to the legacy script:
> - Encapsulate profiler state in GeckoCLI and CategoryData classes with
>   full type annotations, removing global variables.
> - Harden the local HTTP server in _write_and_launch(): write the
>   temporary profile to an isolated tempfile.TemporaryDirectory() with a
>   randomized UUID filename instead of the current working directory,
>   bind HTTPServer exclusively to 127.0.0.1 on an OS-assigned ephemeral
>   port (0), restrict CORS Access-Control-Allow-Origin to
>   'https://profiler.firefox.com' instead of '*', and restrict HTTP GET
>   requests exclusively to the randomized profile filename (returning
>   HTTP 403 for directory listings and any other path).
> - Add -i/--input and -e/--event CLI options via argparse.
>=20
> Add a shell test (test_gecko_python.sh) to verify the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D20

