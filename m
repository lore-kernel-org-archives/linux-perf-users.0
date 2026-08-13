Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F17F30ACEE
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 23:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786665120; cv=none; b=cUeltkG4oQJlZFjTBpbLVWDp6rLD9OXdG4FT+GC3+RdZlAnQTK/Hbsl+9Zu0F1Q6684KEN2gsXutIV47geMfKa9a5TB3H0JRsgNVKOK816la7qrZfsfcnh8uv1DaEoLUHm9AgKejjCOKzkWXWd5+AwSBcjyGpSaayOEcUV+nqLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786665120; c=relaxed/simple;
	bh=469WtrqFyZSt26YXHkpToS0fYCs1lLW4CmggmHuqxec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z+sq5LaD36fVrZFdTGW37Slkv//gAP+Pb8dIj0R4afIwyc8odCECPQ1usfzRv5oIlyKe76TkVW9rRlQEvJx9X5zIe63/eg58OwQ0ajn9SRU2YQVGHXsbGWWr/bhuoHcUubAkYa3Zszs7i3noa8yJylNZSdO8t7tzysZA6lP+aSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4uavVIN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4uavVIN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D88C1F000E9;
	Thu, 13 Aug 2026 23:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786665119;
	bh=469WtrqFyZSt26YXHkpToS0fYCs1lLW4CmggmHuqxec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S4uavVINXCUkHYYj//Ut5gTzVNHAfWeHqckI8QznBdhZ/mDAXM70MudCPOX55PRAx
	 s6100TLNW/kUEJcvFpMfYeU8xE0gOxRU6sF7nBwwtFunOyiI4EFXaYPL5irY2p04jV
	 6KtE9Yd4z5nOGztsp07hzK3Rt/TNTmPiCYAbAr7GC7s591EMJvH4CLRpvEgnFIyGI9
	 zLiLLOsvG2bucOCLAsj3lSRUTNN/0r/lnvhMdATBLYAUo6xoc7C5TjRLgkTj0D2nkm
	 /HPQAyS9T1hh7NJcd+fdo4fMu1X19IcvDUoHfQ0yyb4pC+fD3rW9SILmkxsLwYjH12
	 jMTMlYJ/C7Kjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/23] perf lock: Constify trace_lock_handler
 variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260408072601.210837-9-irogers@google.com>
References: <20260408072601.210837-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:51:54 +0000
Message-Id: <20260813235159.0D88C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Structs don't change and so constify.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408072601.2108=
37-1-irogers@google.com?part=3D8

