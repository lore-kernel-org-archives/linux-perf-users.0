Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961EB342524
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578722; cv=none; b=F8Qik2abrfOGpg9NpRL3bhaOv8BWt3gLuxsmD1pxHK7x0cdrw+0SkTGdpSmJOS8toOTxTdehi+R86w3BLF+XxgEVn/fzpIInieu3Cg57A/dtrLQQw9s0FYxModgBAXLfxx/77qM6GPJCEzRGWkRhmnOh+8pysKg7gAnh7UWtYb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578722; c=relaxed/simple;
	bh=xNozlAOVLPjTOwZo692ve1mTwyViuW9i5OAS+FVxEGY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ePYbvc5wdflijjnsEv0NoJ88zoP0G8K8idD8iOLhy9q4x3rQpBUbqRPlG5cjOGwR6lGJm3BMmLYK9L+4mzQL5Lign25eivc+WZzuN6sz3bea2yHvdK/FZjFOTXq51QmbdtgeCwZDb7WUeAGQYAjoZciwP8SE2kMU9XPkyoNNKlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBtABB9n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBtABB9n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B821F000E9;
	Mon, 24 Aug 2026 13:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787578719;
	bh=xNozlAOVLPjTOwZo692ve1mTwyViuW9i5OAS+FVxEGY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fBtABB9naO80/CiM8JqiRZlo69AJXJmlIlHOm2E8GszLCYSfpc4qITJOUIKdXRkPY
	 OjSPK3QbpwhWJQJtasCQfLl7pIHWoi8QOhMfc71KiUdm6CGUBEGvcJD0FB1MwSL29g
	 YkojQYw+oipQ06H3nOCCnfqgBXrENz21commp3bEVlx4IBAUmmbsgJqQ5f71MzwMdz
	 XLsr79GmJtiPyDkNfrXHRgxJcBViigTws3j6UVyYVYjuQz6m3vQepb6RUH7LOHj+V7
	 PkV+eiZT6i+FUtu1Xpp6m58E9TFTtASDMi9TzPtmskzbhENrOBrgUqVydi7D7tF3zV
	 h3JOuZuM0NIBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v6 5/5] perf tests: Add shell test for
 kernel symbol beautifier
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824133122.751733-6-atomlin@atomlin.com>
References: <20260824133122.751733-1-atomlin@atomlin.com>
 <20260824133122.751733-6-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 13:38:39 +0000
Message-Id: <20260824133839.A7B821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add a dedicated shell test script, trace_ksym_beautifier.sh, to verify
> that 'perf trace' properly symbolises kernel virtual addresses (e.g.
> call_site in kmem:kmalloc) and function pointer fields (e.g. function in
> timer:hrtimer_start) using the kernel symbol beautifier (SCA_KSYM).
>=20
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824133122.7517=
33-1-atomlin@atomlin.com?part=3D5

