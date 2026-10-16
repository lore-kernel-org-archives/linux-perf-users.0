Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC1E48094A
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189464; cv=none; b=p8IPp2mcWbIkP830u2FqRHTzbkvM5w/PduVR5GqolRU2arF5UK/dzUgXi2Hyn8JzD5x0IEkyToqxGC8BdhFgPcTskMLNtrK2O1OB++eIHg55AeuIL1XH69a+u4PVl/Wqjem+BWrtquB1Tv3UEtY0B4QHP8UQ2rF4+I5UhMwQQts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189464; c=relaxed/simple;
	bh=TM6zlJcez16uRQiI7XWNmqoRukzzNZDRb10Ct/uKln4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=TCPk9O4/GgYAMqkcjdEL3gTbJkdn4ldkly0vd7twCwnJerdEzEoCZ2H4MmLiIoZVVLcg8lh5abUSnADWuo0D89mGrbmehrd9e7SqgDr/ZvmDYX3uAQQtpIanMdWlWVrtoH49tuj+3UkdImtmJDKF9tpfouiAkmyFHFIwhWqlD9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXWa4Rex; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXWa4Rex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81141F000C4;
	Fri, 16 Oct 2026 22:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792189462;
	bh=TM6zlJcez16uRQiI7XWNmqoRukzzNZDRb10Ct/uKln4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NXWa4RexqH+wUQKHW/pVn9ZWnYub6sbI41jaKFQHjFI916HdrEdCDMibvdFmF5ajS
	 54xIQTU2U8evdLoNuWSEzW3qxw9RTeETHSKD8CBgggTgqo7GQl5fK+rC2K9UULQ5L4
	 BI98nHA/t/D1ZpSyXXCV+nJk5Z3moBVqfH3eKgjG45qeknXsxysaAiDw/XoTb5xG/W
	 TLym6BGUrsGOLcJQ9TkHSppWFeN4E4sLyK0z5fE1Vo2mVcFbvLhbwOonrovujgasAR
	 TdXNzXTg4jTVRSE5tviCz+/+wR9hv4TND2AC2zWE/HAItAd2SBj1CfgWnMV9I4P6Is
	 gidG6zb36/6cw==
Message-ID: <sashiko-outbox-175017@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/17] perf maps: Fix lock inversion in
 maps__load_first() and bounds check in __maps__remove()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016221700.1282659-17-irogers@google.com>
References: <20261016173106.679725-1-irogers@google.com>
 <20261016221700.1282659-1-irogers@google.com>
 <20261016221700.1282659-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 22:24:21 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> In maps__load_first(), take a reference to the first map and drop
> maps__lock(maps) before calling map__load() to avoid a read-to-write
> self-deadlock when loading kernel maps inserts extra trampoline maps.
>=20
> In __maps__remove(), check that the index returned by
> maps__by_address_index() and maps__by_name_index() is within nr_maps
> before indexing and removing the entry, in case a concurrent thread
> already removed the map.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016221700.1282=
659-1-irogers@google.com?part=3D16

