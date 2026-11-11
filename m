Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377910;
	b=5Tz7xduSvZf5Om3CGa3vbtE8zripCv/fI5AGRGDu/aSVveh6MowmEnWOQQy8WRS11MtJ
	 a+EkTHCTkDght1NUXEgqUzIhkDbsFdrh0u2XcgdmcrrHi7+7aq+q0Mq01cBimyRx+bsc/
	 c17XGGVjkBclAsnAk315NICCpjedDCaHljZ9ztkxsly6wcLc/e5YjB4E4myNFc5PH8RGU
	 pUabzVYJW8WF0SLx+2NtPGappfQxBcC4kmIy94wXR6DsGhpEkZw2J54YBqvGf5KPqtQub
	 IZCuBA5J6e5FRnKDEqNm4x0LJb3vMv3e0mQvhX15FHhnN2LX7didG0nX7aqSvHNWwxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377910;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VKu2xHEkhwK9Kq4tiWZRGgYWUPgmWjGSDblVBQuCnEM=;
	b=BND80fV7NT+4KGuVGYUnHy2DvM1gusiPSGlAjkq07wU7SZZmORTm9Nmd2pTgoEGic2bH
	 YDIVwCCACw4SDtHrdZIPvYOJlLH7Uk0QcdZ5cHzJWlrGKPrSsnfYRpxrPwXqfsuLYjWMU
	 kjj8ZxJ+HjrAs9GJBrRmBwkahzlWhKqDWvXjAWGNZdoQnWaeH5y1uD75m3nOO14nEVi90
	 BkAT7Nevv8xQMKQFCOM92MQhJDJO1SjWthzT+caUhAGJP/2OrH5qqpXsY7NzBMAWz3WCg
	 3YGicKU5nX/2IBi+B1PF0UgR/HUvJDHRxntMDYzspCjsUYFeDuJKZ5cbWB0zJPNcorw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ToIrRYi6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6980A606A33B
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 06:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ToIrRYi6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF76B1F00A05;
	Wed, 11 Nov 2026 06:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377910;
	bh=VKu2xHEkhwK9Kq4tiWZRGgYWUPgmWjGSDblVBQuCnEM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ToIrRYi6xbymw1BLNxYoQZe5Nzb70MGxzuqwzFhgLL11Xxs1uF4RLcN51emN48qu5
	 8ONL5dE4CMIT9QWxeY8ZmAs8rzI03DfoN3eQ+vrjwB4fjH1gPl2OnwfEKXeaCAWyU4
	 KPZJrPKicowzBlPgbFXrLAcaOXfEdJ9EZ1GpbtzJORb7B6Do0VAkU+PVrapwj5OxpW
	 f5wfkHarkKKklWZqYKYiLlHqnptyLV7LkoxBvaqU5JSlXFXr6Kd5KMritIYLTLNjhw
	 A7lNiE6GLFZkn0z2XvjOCewY8dkRCEVQ+fQknd5T35n1Rt7DKT5Laf2FAd0VNKVNuj
	 xbRDXBtpBbRvw==
Message-ID: <sashiko-outbox-208426@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf stat: Count kernel events in a group led by a
 tool event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hang Zhengyang" <hang.zhengyang1010@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261111-tool-pmu-leader-v2-1-3faa0fb98c51@gmail.com>
References: <20261111-tool-pmu-leader-v2-1-3faa0fb98c51@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:18:29 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
>=20
> A tool event like user_time has no perf event in the kernel, but
> get_group_fd() still passes its fd, the /proc/stat fd, as the group_fd
> of the members.  The kernel rejects each member with EBADF and nothing
> is counted:
>=20
>   $ perf stat -a -e '{user_time,cycles,instructions}' -- sleep 0.05
>                    0      user_time
>      <not supported>      cycles
>      <not supported>      instructions
>=20
> Open the members with group_fd =3D -1, as the enable/disable code already
> assumes.  They are then on their own, so read them without
> PERF_FORMAT_GROUP and open them disabled like a leader, so that -D,
> --control and enable_on_exec still apply.  Keep reporting a broken
> group when the leader failed to open.
>=20
>   $ perf stat -a -e '{user_time,cycles,instructions}' -- sleep 0.05
>                    0      user_time
>             38257394      cycles
>             21228043      instructions
>=20
> The kernel events in such a group are no longer scheduled together.
>=20
> Fixes: 6828d6929b76 ("perf evsel: Refactor tool events")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-tool-pmu-l=
eader-v2-1-3faa0fb98c51@gmail.com?part=3D1

