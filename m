Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6BA22D7A1
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 00:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110185; cv=none; b=RjkKD5G8J1j9Gp4gFGrl+VKG1IzEtdxAGu3ilDjoKub0KYb4T5aywj1XCazgol5jtktwK0jtc2Z+gpNCCZCwkYPupuJFQOyw4HmPbNjOVeeVGgA8dPA3mliaCHN+ca/y62y0UEbWKNCTsROyPFVmck71sYoZGssD0S7ZECp7tHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110185; c=relaxed/simple;
	bh=lmBkPftFlZp3cz9+f7r28wwTvHmyyVggoIdrz2J7Efg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HEjmTZoC1mnjMmWttygRqwpqaIGa5obnIj+AwCLiRFcCBai5l69UFCdo7+RoOzuPGeQu19xKutnSS55/yVRzfnpvYqilgceuCahpj+TvC07dHXwVHS6HATpV4nn5uBLKkWk+yWeLK9jF2vw4GlKNzdQcgh/eHZdNGFfuwcr3joI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muHmS3l0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muHmS3l0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFF01F000C4;
	Fri, 16 Oct 2026 00:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110184;
	bh=DQQcYB6BS2UzXZi86AjbpH/UgFXzdr7BuYpkqKOkKSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=muHmS3l0p4v7bdBsQMJDgo1HlVFccoJQ+NF3S7mDOLpZUZAPdrXXAWftNeI2qL+jD
	 DwLIuLKenFYPOuD6D4NDnO27xD0CFHuAPk2w3cg12zAmjteUfKiyVBQGba9Lbsc0yz
	 dLCQGc839qva4ACEPS6QLGiNo/EOL+oObGmsHH87WIh/jArAl3UpuMZMX9ASsCObl+
	 7Y9fdkyVaxE1Q7E7gvUilYOn8rOcN+6mIf9Unz33cGDqoObjxiq4cwKL8CIGNnlxw+
	 eWxHTiZ+WM8/lyIjN1Zxt2DM5CdO+JQg+SxcwJZxUOodKz7SXp4mc5mFtDeE7Ob/iP
	 w8/wifv4TWpBA==
Message-ID: <sashiko-outbox-173514@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/19] perf test attr: Relax group checking for
 ungrouped expectations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016001843.71978-6-acme@kernel.org>
References: <20261016001843.71978-1-acme@kernel.org>
 <20261016001843.71978-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 00:23:03 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> When matching the recorded events back against the expectations,
> attr.py requires every event opened in a group to match an expectation
> that declares the same group.  The perf stat default metrics open the
> events of each metric in groups, but the test expectations only verify
> the event attributes, so test-stat-default fails with:
>=20
>   FAILED '.../test-stat-default' - group failure
>=20
> Only enforce the group of a recorded event when the expectation it
> matches declares one.  Expectations that ask for a group are still
> verified in both directions.
>=20
> Fixes: c7adeb0974f18da4 ("perf jevents: Add set of common metrics based o=
n default ones")
> Fixes: 2dfc0cab3da4a205 ("perf stat: Add detail -d,-dd,-ddd metrics")
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016001843.7197=
8-1-acme@kernel.org?part=3D5

