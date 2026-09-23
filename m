Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB14548568
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188649; cv=none; b=dNTIKEFxZDn4SLwa1NSW9pqka5sowqzHG/QO2mZhddagYF/2Vb6NbawOJYKzUA0O5ucG4gzP2bJzzIYb6HUdFs3JZZTWDp0cX8WvEe/efW5/FJd07eWYNz2Ug9LZEf/27afEiAwt34yuNQXrJY6n3rP3SaJQEJnGmroI7gNYbAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188649; c=relaxed/simple;
	bh=Ha24NEEBSYUGo4/RwyhKyNb0kql93IX/ACiuoP573lY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ksvGfLUbmy3uv5BjXm3dmELnaZYMo2mGYEml6akvExB6oDpUtq9vEKSJG50rg3JYcwZJU4b4FxRIan5laBYJVoqyhTUwKbBliFPoXZt0mjUuyCrxA+d6qVx0I08yZpef0D4C4o1RUfGHGxk9J5aNRfNMxUewEAUnwy5bb4N8uTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfzaeSp5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfzaeSp5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFBF1F000FF;
	Wed, 23 Sep 2026 18:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188645;
	bh=8nKg+PdCyAUDZuQMw6d8FtSaXmRH73RRxzvKSf/pC2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZfzaeSp5maQfQ3pU8cZHFf4EDEI8Qv/Ox4gHLUCv1f4EW9VQEN+IJ5IyAweK3zjHQ
	 3zKtI9u8aa0lKObXgXfaHXVKzuNyRrWCgr41corqGUshLODm3ulZOwDb998PDOexfE
	 zIx6rbSUv9qUpzm3YwFj/dIYettNaqvDAS2UF4FoK/pLl7I1p0EXgCCDjzGJ8vWVzn
	 E5zCrAlhmtjMoSDuOHepaAIuKHAInYJqaowCAMTf8XYwVVL4q5bz7HiAhfJCErijt8
	 uyYMiGraRc//n7KgOhtjSdGU0iRga59odSqttCqEOQHT56cVnmUjikzN0Fkv+kP4x+
	 aKMb9P/Gljmtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 34/49] perf python: Port compaction-times to perf
 module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-35-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-35-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:37:24 +0000
Message-Id: <20260923183725.6BFBF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port compaction-times.py to a standalone script in tools/perf/python/
> using the perf module directly to analyze mm_compaction tracepoints.
>=20
> Improvements compared to the legacy script:
> - Replace Python 2 constructs (such as sys.maxint and raw integer
>   bitmasks) with Python 3 enum.IntEnum (Popt) and enum.IntFlag (Topt)
>   types.
> - Access tracepoint fields directly on perf.sample_event and add
>   -i/--input CLI option support via argparse.
> - Add full type annotations passing mypy and pylint without suppression
>   comments.
>=20
> Add a shell test (test_compaction_times_python.sh) to verify the
> standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D34

