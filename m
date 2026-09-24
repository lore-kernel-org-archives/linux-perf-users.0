Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BDF3BB126
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269739; cv=none; b=ewI7h6c4+CjRG7ylriE3Wi4KvRWPf3497NliTUPAKyA+hFqSTAwoK5XPe7K7DNa6jSYxn0KZ8YtBEha4tYpyw5MiOEGK4hvvR3ojTv9yUWsD+iqk2Wh+L4q+fr+eGRj3mMpy0g3Sq/cd8JH5/kMM0NBBGCUWgSJ+Ao8nSv2FAUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269739; c=relaxed/simple;
	bh=4X1eWkXD8WtpFfz7T6UWElrKDNg72m71qeOGU2Ya7QI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ODWI2ZacID6fJp+289uzh0yvVTYn6ofCGqe9v95cRnEPXFcpmHVZDglFNnR5PymtmSWsHHk757X/AaXG9oxsOpbEEacg008jxDcrsmr4PHMRdRXva3Y3dIdTftL9RniDOcE75NyNsiu/Zp6zhCweVDhXnKBWVb0uhqkW4N5o0tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOE8jCRE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOE8jCRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CC91F00893;
	Thu, 24 Sep 2026 17:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269737;
	bh=MWGngR5eyZIgODIkrltTedWTO6A5+Qk6ACIhSvn6NoE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lOE8jCREjLsHhLrPpnXBm86fj5QOKxqfaZotDzXW2PH/n9MH3ZE2I+qFo5dGJqGzR
	 8/6JFORtrb6npJYAOUyrcNYDg8EYvfqpI3Vk4DtfGszvivcz/yz/iAlXpOFQhUT67y
	 SDUqmKi0NfWHN0SUaPlS1kg/nn/BbeRooHwEwzROM6I1574jd+tj7S3jcRIWx2B0Jr
	 mVHTUP6bx2dg5v9YM6sQkbrWGnC7KQhmWI/KrIUNu94ga/moDNOpJXRomHNtIOUyVt
	 juSyPHhjs5Qqk34xDnvupH1+pB2svjbVYHbbajyn665xDq0hrwF4o5CNkR9zBeboB2
	 pXUZ1xqGKJ/TA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/26] perf vendor events intel: Update icelakex
 events to 1.31 and TMA metrics to 5.2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-11-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:08:57 +0000
Message-Id: <20260924170857.B1CC91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/563ea935e283a7fc5bf49bbc082fab5=
be81af5b7
>=20
> The updated TMA 5.2 metrics were published in:
>=20
>   https://github.com/intel/perfmon/commit/f9358e8da04bec945d8023e3f9b20a8=
87ad46c45
>=20
> Fix umask encodings for UMaskExt.
>=20
> Fixes: f42a7d02b7a3 ("perf vendor events intel: Fix uncore topics for ice=
lakex")
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D10

