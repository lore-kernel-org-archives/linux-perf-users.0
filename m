Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020521;
	b=XpR16l5nn4nYkxiLL7vcYXeqXw1UDBVruxJ8W9sz6f2ueF/AOl9jhbqOpVyKyUpdUr7l
	 zwv350snD8ghCJKNTA+7Z0WtQTbvY8DEZiFfUx50svKq70Q9XlL86kQe877JxHhAL1Pcw
	 1eVkcHQG9H56mlMABcnZYabCzuZROhUIN1roqpZfipgcpWfzuAqaisXlLyR1C+MC5tv82
	 7wMpfThmN643SK1F++gjpq0U32WLhAcJ+58tDx1F7mXInXBB9+DjJTVB334V0ylaxwylK
	 iRVkUA98CbHgGtR6s8LnWeM94hPqoPosyC3PVzt1OM2eyCdtXXJjpgsi1Srw96fLxpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020521;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yryZsfkSKWoF69gguT8hQMx95XDYyPZYy4UPUViaYlg=;
	b=zaM2ak/eOxSdQmthCqxBgvzadbNiTylFWZpgGZn5P2+JpHfCbAvenG8pHQukx6QblXo/
	 oPn2DmjeA8Dtavo9kgykarS5Ex1QNbZqRckz+uxXczI9R58Gd2pNxA3hSlaTkp6UusH5g
	 thunfzxfzeLrkLltRS23oYk/GsRo9VdxR+29O3O2KUJNy7ODduchMX4MYtSD+ZjwYfbK/
	 ffWuMWFYcyv3fFSTY2fTxZ+ARFvQxLcActHjiHLTumr7Jlmu/PtsQ4Bwwnhbk0bfWCy30
	 TxgNN9Z+/CXoxLLRCbT0iyVkGmruDV5NxEa2JkGoRFzu+muOpAr8hGDxREVmsAR8Zww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kjz/F3GH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F734606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjz/F3GH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A1A1F000C4;
	Wed, 18 Nov 2026 16:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020520;
	bh=yryZsfkSKWoF69gguT8hQMx95XDYyPZYy4UPUViaYlg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kjz/F3GH3957aHJLP86pnZaNSBEhrv1GMpJlGYtVHNoPCLV0Ig4EJ0RiWOpnnOe2V
	 aN29b+r/Nj0IfFZdPp2OX1JzLgCrZQ1vIQ0599nuqmZg6m+GwaGjMrcxAAuBd8/XgM
	 Zpd9xdVtdD8ISofwaQZl/TtXYkQOX7Bn2tzwsiyryqX/GhA1AdyuFZI9nvYFSCRo1g
	 xxQkjP+ewsNAWKwm6Dq8fcOx3RK6N4R0rw6I0Ft23a7/wsgNp9VOE20CfPdyO39Rxo
	 V6ES747N6MOoOWfZI8lw5uBzuk/ob4686yq9QddRfdHqimcuSUzdiVnuNKCOjVKAF7
	 ojUvWMn/cqvXw==
Message-ID: <sashiko-outbox-221558@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 28/34] perf cs-etm: Create timestamp decoders
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-28-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-28-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:48:40 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Create a packet-only decode tree for each queue when ordered timestamp
> decoding is enabled.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D28

