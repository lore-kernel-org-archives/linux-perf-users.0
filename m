Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971395221E4
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602805; cv=none; b=jlRfhMUA9cE5zXPI3eV/xg79JROF4msVvV3yk3lfhtrVryH2Dic2Ummgg5Vr/8grvMhIweNNLCfFEJj0JKsbpSccDdyX7X0+rgqk0g/EmK9uVVFKzkletlIIuz+tgwnLuAp2PsVUxo2Y8G6mSLanAktsxetzpKK/hPXkHsbW2ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602805; c=relaxed/simple;
	bh=YrNWZsfjHSTvuHCT+t2ivKyjXqG5/GJMIP8MOQBEznk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lfwIajuHzpKCwoXJVuA9DBTnYQHdeMVRY9NnT3bZc2TGeexS36K1f7m0QuiBXEAUepyzmBkkeYd6PWbtm5re11WylTngbL3tFdmKeerSmphCTf7XlVmu4GER8sDXnHFKwO7cxLtNtrD8IfT1v+MOSLh32KHf/JspqlmCOClDLNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYUvHVHQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYUvHVHQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7041F000FF;
	Wed, 16 Sep 2026 23:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602804;
	bh=YrNWZsfjHSTvuHCT+t2ivKyjXqG5/GJMIP8MOQBEznk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EYUvHVHQgbuGJGIfv94PpasHoJTF6/jnbDquLxG4x0Ot1VT/k0r13iBmuQqFVevBl
	 kKQZDdtrLMSQr8DGImr0IaatbcBuJDKXmRKDa4dbOHMeGOQbr939ZnQUtmTnpfPmdD
	 ent3LH9olZkI/ElIq9auv3ruRX2uWEn5g8OrUMwHsAo07Wf2pTYWe5s5YPF/4svjFW
	 yFi1kJ0pV84yeJuM0RADLzhz0d0rlX86hNpo/yhRzl4BjwBRlDmssM/J89V5Mfy9Ti
	 5gQdS0ApljCBTKSkMohDEBJdMj5hGAenVcJ0RdJp04XjT5f6jAhoScBwSKTemNlwhO
	 FoMfuTmyCfQVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 8/9] perf test: Expand tests for --hybrid-merge
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916234652.439778-9-irogers@google.com>
References: <20260916065248.3153556-1-irogers@google.com>
 <20260916234652.439778-1-irogers@google.com>
 <20260916234652.439778-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 23:53:23 +0000
Message-Id: <20260916235324.0A7041F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add a "Hybrid event merging" test that checks evlist__can_merge_hybrid()
> and evlist__merge_hybrid() directly, covering the events a wildcard
> expanded to over two core PMUs, the same over three, and events that
> must not be merged.
>=20
> Add a report_hybrid_merge.sh shell test that records and then reports
> with --hybrid-merge, and extend top.sh to cover perf top with it.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916234652.4397=
78-1-irogers@google.com?part=3D8

