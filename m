Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB5E4D9F75
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364078; cv=none; b=b9N2VF5ObZA35RPurVbolfccf8TNVqppDnNqTmSs3nlk/cDBLTY2hn5UMST1Gj0wsx11w9niHP607johfWqBk9iWMMdX76nAn4sVtHVHyosYL2vpa9/tnKCVfTKqmPpBlDS5VZsh8nvzRjgi0YyFLt8ifTycbLusJHV/g9ZGnHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364078; c=relaxed/simple;
	bh=6E7Cm39WhG4LJnp6TwXrwFqmsxTZE/7IUsyrzn+1H3c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YCHjWh9REcinps2UdvaDcunkOqN7Cp32PeDDJ1IHcNvd7IFecvcaNTzS/JfblUii7mZhVci3tstazubEiIsb7LJjt+84QJ0t1GjjYy/5NuXLgiGRHa9eDFOCEik1ye6oIK7ipMIGxZFyBnObyxoCqy7Qk3Jg+0cMBbIu/WCUNfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSn5LdCH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSn5LdCH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15A81F00893;
	Fri, 25 Sep 2026 19:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790364075;
	bh=6E7Cm39WhG4LJnp6TwXrwFqmsxTZE/7IUsyrzn+1H3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aSn5LdCH7NddGhcd7mVSiIJLw2SEkHbi0lXD3mk8CKAA3yjl4yqbjf4kY0P/gS1xF
	 LvGgvZeA86DRuWJ2npx1OSPRTzq211TYJ3uG52iSqp7/xqlDAX5Lk0UWMv9ZZm/e5S
	 8T1Akw9ltmS0j2ujQB49iONP5tc0vJo/89pPCi+M+N2eiuiTE1RN8rn/2Z4lVFeGL5
	 9Oxw9NZ+E+yMNB4XIgeXjlZApbczJD78Hsg87/+O57VxL/7i4No7GsS2tqet90TmGh
	 qwNv438YRpFxEMp5UdAjWaUrrPv+ldHlfbrhvUrsNbkMvbLPGgJQpcaxas/LPySfnp
	 OBEHQbnoYSU/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] perf symbols: Factor out duplicate symbol
 selection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260925-perf-symbol-memory-send-v3-3-3e4e234c363b@uber.com>
References: <20260925-perf-symbol-memory-send-v3-0-3e4e234c363b@uber.com>
 <20260925-perf-symbol-memory-send-v3-3-3e4e234c363b@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 19:21:14 +0000
Message-Id: <20260925192114.E15A81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Alireza Haghdoost <haghdoost@uber.com>
>=20
> symbols__fixup_duplicate() chooses between symbols with the same start
> address through choose_best_symbol(), which needs fully constructed
> struct symbol objects. A loader that selects among aliases before
> allocating symbols cannot use it.
>=20
> Move the policy into symbol__choose_best(), which compares the size,
> name, type and binding of two candidates described by struct
> symbol_candidate, and pass the same description to the
> arch__choose_best_symbol() hook. choose_best_symbol() becomes a wrapper
> that describes two struct symbols. No functional change intended.
>=20
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-perf-symbo=
l-memory-send-v3-0-3e4e234c363b@uber.com?part=3D3

