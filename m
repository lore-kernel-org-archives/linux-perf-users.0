Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4900408031
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289282; cv=none; b=au9NdKE4bJV85eL9ONlaQadJ6mozkrqEd7HOUVdWDEQEOIOxYZItqxOAhfF2PTDlY2/T8IIT7imMrXyBmF3LYIBxd8rZzCY9Jyvblx9dLptIL0hwQoRS0Mg6ZAWT/buRbXLI/gLg7+PfDGtJKlVNKshkRuSllM0e3MeLcO1DyhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289282; c=relaxed/simple;
	bh=g8iRWaJRxE7MBtRxib0v1Id5iJg7WE+HMyJvpjBykEU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ft8httpJmuO5ipzpZa80yTiDyRplDg0IhwXKTByJfTWL/WSdoKilpfghf+ZCVINig9/JNCr81D7B6Sw7cffqzB4nFnfJWYV9kPI1rjbEN8hKvtNcy2irVrz+HPwD/P4e5ZTRksDaCGViSgGB++p1cuk8ALYfrW/xj/ZIt77lgRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRj1a1NV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRj1a1NV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634BC1F000FF;
	Thu, 24 Sep 2026 22:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790289281;
	bh=g8iRWaJRxE7MBtRxib0v1Id5iJg7WE+HMyJvpjBykEU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mRj1a1NV3ggbvfIiltz8z91sJttVeHKCuzBrLbaSjWxnfC4nUU3rricv1KTNQiWE8
	 vmNF1r19NGZ5bXwDGXPp2IekgiuJ4wTOq26AnguobnDAao/NPhFDJ7C9FyfSXoaQLK
	 oPKNnob523x6L/hZ8QVMflBnHRr4ckQF0GxlplfQh0af5sNBD1aBVMoXzpVz2i3TF7
	 PeCFpHH0z8KgdfvZTxnrQ8nCmfzmiI3Q4RkvrNoqXIS4WJRunKvJO3JtqBHN17QkZ0
	 /z4OlfLWmxFpdkMTzyw12ZXeNxIbkq05CGhEx/P1mr0u+gPhQDjzpD0qKVZYouGcIY
	 LL2O9gngEYwMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf test attr: Fix wrong size expectation for
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Petlan" <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924223027.799654-3-mpetlan@redhat.com>
References: <20260924223027.799654-1-mpetlan@redhat.com>
 <20260924223027.799654-3-mpetlan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 22:34:40 +0000
Message-Id: <20260924223441.634BC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Although config4 has been added into struct perf_event_attr, the size
> expectation for the struct hasn't been adjusted. This hasn't been
> noticed, since the testcase's return value has been ignored after
> rewriting the testcase to python until previous commit.
>=20
> Fix that.
>=20
> Fixes: 80cdf208117a36de82a30d210b3b8df0f193e75b ("tools headers UAPI: Syn=
c linux/perf_event.h with the kernel sources")
> Fixes: cbbfba4847b8a5299d36e002bf864b21bb83295d ("perf: Add perf_event_at=
tr::config4")
>=20
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924223027.7996=
54-1-mpetlan@redhat.com?part=3D2

