Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9054E9C36
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009892; cv=none; b=hE8gMGdK2QFp42s220pqAyGjPJJIx2+pI27LXXZP2Cx5s/S5X0dfV9q8mobw4dpfAuYrP7D94LdJBYChAPZVhf/FCXUAeyckCUk6pv8H2zK/QhA66oaIb5blkDECGVqkFCcsriM4WjTIxll9N8i/DdsqoktYV97UCH0wFCkJ9t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009892; c=relaxed/simple;
	bh=fs8mRn113K3UbgaQ0BJ28abV+/P4kSYWXHQLl6CaB9s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vnzg2WJMNBRxJ9Be/roUx9aHXyX/HDwFoEFU77UzluLwkq9Eekq6/sLxCMfdFYtmKPwqa8WaYO9VJHzZwrp7bgBBvIkvWz6cUs8lGdTz0TkhuP2u2TDHDe3yLtauElIRMkgw1e8ScHBp8YxlEPCk6F6IJH0W9RKBhh31nduf5AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onerwL1n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onerwL1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3001F000FF;
	Mon, 21 Sep 2026 16:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790009891;
	bh=2rSd4384UOyZxR8QZFBk+05FBsYT5gaBgSFUXFVP6kM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=onerwL1n44RQG7YiHjCgCjTFb9tkspnfZwvjinL6Ganuwg+7FT/lLrGfZsVdhfizD
	 rgXggctqU2IMgKXR9lMoyom+hZd+qys4VqrUk1Mma/DjlhdtHOlHLmb0xjCwbEZRTd
	 vS7ojYWG+oOoW1buFAMC/LmwQ7Flc8fH/oS9tTq72Z266F5pbjuuEwUwDTiflYPxIW
	 rSmJ9EmQvzGXIYEDW8s7j7q2hDXZh+htO0i1ZIE0+h5diNwyC1wKfrnGlFM4cU8Igj
	 Yq9BXkA6V80uvCcROMwobb0n1lw/xPDq7c3cOk3k8RUz/38a6jXzc/3dssWRYU6f0g
	 7X9cxJjHinobw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] perf mem record: Use the IBS swfilt filter when
 available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260921164813.6727-8-acme@kernel.org>
References: <20260921164813.6727-1-acme@kernel.org>
 <20260921164813.6727-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:58:10 +0000
Message-Id: <20260921165810.DB3001F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> IBS events with exclude_{user,kernel} bits, as used for per-thread
> recording when kernel samples are not allowed, are rejected by the
> kernel on hardware without the privilege filter, so per-thread 'perf mem
> record' fails on AMD:
>=20
>   $ perf mem record -o /dev/null -- true
>   Error:
>   Failure to open event 'ibs_op/ldlat=3D0/u' on PMU 'ibs_op' which will b=
e removed.
>   Invalid event (ibs_op/ldlat=3D0/u) in per-thread mode, enable system wi=
de with '-a'.
>=20
> Kernel v6.14 added swfilt, a software privilege filter exposed as the
> 'swfilt' format term, making those events usable per-thread:
>=20
> [ ... ]
>=20
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Suggested-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921164813.6727=
-1-acme@kernel.org?part=3D7

