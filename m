Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E23F5BF5
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289151; cv=none; b=Rb5hJdCA70FL8a2F555Jd7VdLBphvXCDqDb3kVJRexwK6yZpmfbP6Ty/yf49X1gNUDM2HCOT681Q0JZXE7L/0ky3BOMK6uXQP6UE+xVXS16EsVg3QTfrFGWP/5Kxit71Q1xf++zcAgkqvhcUk5DKlTauzzSRh/niSElvsZvV9+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289151; c=relaxed/simple;
	bh=OnmlRgHHp8rAfOYPly5N6beraUJnjuBuS5WQky4lp9Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o9Ny0F1vILHYUFEOWs2E+g2aQT5JwoR3RBFxKEaAcELmSS98YHHEJpcnN15QJfpDnPMyiYtkXGd3+f2hQYxlv8uLqkUipEkXa+Cfc8d5ym5h7UF56xbAFeqFL+Yy14yCj5cuRY76kBztHzny+SQpgb8D8gN4iwVoL54LBDeN6FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICRGILGc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICRGILGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFD81F000FF;
	Thu, 24 Sep 2026 22:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790289149;
	bh=OnmlRgHHp8rAfOYPly5N6beraUJnjuBuS5WQky4lp9Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ICRGILGcp4411JkarA0MEB8E3nnW/iQJaWmDFgiw0c32LHHelty1dmDHkep48LtlE
	 iLm1TIFFeiV7tecgfQkD7WkDNR2NNfPKC7W7YgeRMJaDdeQFiEPnNgp+JCoHyhQLxH
	 nyT3hNV6suhhd2FafyNngTcTGZdE6r7RW03JnFuUTmBNH/hkE8VJq1IRZtuuQBvh9z
	 m4iblSp441SI19MkniKYIeg4Hr5R8X1VtsU6911fxu/yDMfdBYtIMmxtS8KW6Zwh0n
	 6PiIOx7Jnjge29fnyQtRGaSkkppEiw32jtkBIZuoZ1eZ7QJMLAH0DIJzxwg6sFDY1m
	 ws0zUHImT7AQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf test attr: Propagate the return value from the
 test to the wrapper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Petlan" <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924223027.799654-2-mpetlan@redhat.com>
References: <20260924223027.799654-1-mpetlan@redhat.com>
 <20260924223027.799654-2-mpetlan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 22:32:28 +0000
Message-Id: <20260924223229.5EFD81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Currently it does not matter what the python script actually returns,
> the test always passes, as the $err variable is always 0.
>=20
> Fix that.
>=20
> Fixes: 8519e4f44c2af72214dc029f0334be068466e71f perf test: Add a shell wr=
apper for "Setup struct perf_event_attr"
>=20
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924223027.7996=
54-1-mpetlan@redhat.com?part=3D1

