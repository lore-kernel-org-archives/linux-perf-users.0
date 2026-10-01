Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B021851D511
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790864776; cv=none; b=Tdx6FOPucfGCBsGdN9L3jMwRxYLOezDtWBusJ/0JsszzPZpPwaZCNHZC0Vo7Sw/yzzoAGMq4z/79uqM0FSyLEKvabQXKNZP0ACHFQlQ9fVFVNgb0WSjeiq48o8C58tL+8mvh+cK1OiGRbrgWowJgyqsiI+Mc2w3UQhsglBC4JHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790864776; c=relaxed/simple;
	bh=2xo8RbybLwH9v1fxDxgnWgJ+Z17unL9gthqNDyVTn64=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=saw/7ccTN3JonalXrAxiKb1vClaCtRUcp0/nVuLi+ruhegrffpKHz7K0vQpSx6esSE9Jo55UXvZ/Zi+lg+vEBTcsoO0LHW1mYuaoeUyBWzj8SZ5Q8y7EWIkvHyNJPSH4IBaytC/lXJWW4MI0hBp1uH/1NJTkMlSuIpX/L2mlXro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXFXn/4/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXFXn/4/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8F11F000FF;
	Thu,  1 Oct 2026 14:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790864763;
	bh=2xo8RbybLwH9v1fxDxgnWgJ+Z17unL9gthqNDyVTn64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EXFXn/4/c3AD/0ba9CnlD5+R3UGrobU0S84h7byaEbmzXovW/znO6eyubxUyI2Ffn
	 TVnmpEcvhyNcUzwv4VZwT1wp09ueauZyteupLf503RBCKdMz6XUAEasKkFavJtskll
	 c7WVzljDPvRMNyE3YTReY7+EUCsk8rx3aHyY0KoX7RUaG5LfVMvjNJUpK+dK/mFEpN
	 kylln9HucGWiFKsq+EDm7dFWn3z7JyDQ9Vr9iVvNE6d9V8g10xYKZWpicm5QRb6Kfq
	 tU/Ycke+Fvt6OGuATK6paNapndEnBds4oRQEP4yDUE5b9A+Kdwfa/MtaKIoWx0G4QY
	 Zl/nkPQJIVS6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf/core: Return errors from
 perf_report_aux_output_id()
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261001-james-cs-retry-hw_id-v1-1-4d45ab46cde7@linaro.org>
References: <20261001-james-cs-retry-hw_id-v1-0-4d45ab46cde7@linaro.org>
 <20261001-james-cs-retry-hw_id-v1-1-4d45ab46cde7@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 14:26:02 +0000
Message-Id: <20261001142603.5D8F11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> It's useful to know if this failed or not so a retry can be attempted
> later. Return the error code or success.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-james-cs-r=
etry-hw_id-v1-0-4d45ab46cde7@linaro.org?part=3D1

