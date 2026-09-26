Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12CD388E5A
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790449793; cv=none; b=KfvGQs4gGQThrXmSRYBMtboOBF3AyH0ShOXbe22Heko+12jSwyCPv+dnpEQD5lsrsn2tpikb2pg8PkGEZ+afuNm4qqTbl+DnIEoaSFpTHktmz45PIf9TO7rZVty/SSmv6/sv1SFqSdP7Uph/NkHimh4wf16Rzqy2M0rTjbcUbns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790449793; c=relaxed/simple;
	bh=r32P+4tgtjj6joRXqxPnY68VmtxP6W4dFxZxMVPS1HY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fb4kIahEALIwQJWCZ89IMlsOQ0LodSnODE/67Lb3/Y8LvLUiEB2q/fd6dLlfU9qxAs6d7D6Nls+ScmDtSYt8RlA288TLRotKXeaXUEdJTWe3E/Ro0YAOEDTfYfzcqMyFczF7YOkCYEc9cRGi4wjGq6c3OcESzQQKXdZZHVUfX6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZALOolY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZALOolY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E03E1F000FF;
	Sat, 26 Sep 2026 19:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790449792;
	bh=pML5xL5nAfPbJl6Q5AmuBZP7cxpUP2JxQQvALq+dqrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nZALOolYRP00wJ0nB/neCeu+dNchVRZCYE1YlCxRJiSxXc3fuxNiIf1Aa5QU9J966
	 H4sXHK5VoQyFHyf4Nbs42riCoNTjnT3ZWAfxCKj0bMdBDACRr8XdCtS9AxH3G5QScA
	 qGXf12kmXLfFS1cKn1wCMQnzZqXTB/kLlRJbGjmr5iXv0jvsbWm7Qxo/dWQ0dCkJ5P
	 umTxuZqjGqWfFkOvSbABY2zR04i4vT5/4QPNwknqtyyo6bQ4jyuY2thtI0t1Z1+6tI
	 3Uiwpe2L+n2GG0AlAEPjQav2hgFqO4JLU54uYt3RAVXj1KFi6lklKgKbz/6p7QpgOY
	 Vs2fQfNaJE3DQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] perf bench futex: Set the number of hash buckets in
 futex wake
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Pluta" <michalpl2003@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926190407.1106421-3-michalpl2003@gmail.com>
References: <20260926190407.1106421-1-michalpl2003@gmail.com>
 <20260926190407.1106421-3-michalpl2003@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 19:09:51 +0000
Message-Id: <20260926190952.1E03E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> 'perf bench futex wake -b N' fails unless N happens to be the number of
> buckets the kernel is already using:
>=20
>   $ perf bench futex wake -b 128
>   Requested number of hash buckets does not currently used.
>   Requested: 128 in usage: 64
>   perf: prctl(PR_FUTEX_HASH): No such file or directory
>=20
> The other futex benchmarks call futex_set_nbuckets_param() to ask the
> kernel for the requested size, but 'futex wake' only checks afterwards
> which size is in use, so the request never reaches the kernel. The call
> now happens before the run summary, as in the other benchmarks.
>=20
> Fixes: 60035a3981a7 ("tools/perf: Allow to select the number of hash buck=
ets")
> Assisted-by: LLM
> Signed-off-by: Michal Pluta <michalpl2003@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926190407.1106=
421-1-michalpl2003@gmail.com?part=3D2

