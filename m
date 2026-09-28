Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307344D9540
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612273; cv=none; b=s/+jBM92vEmhEvKtnZjl3XoNdsMOT9HzRS+oSwXTRhdEIImzPQ3slblM/d3pWBGYq/8pCilnauzu2l3QZ9F3fIw7/z6rKPW8Vyc0IRDY8/jEWHS2jxxhojfdf6BMOIx69NkTGG5tSmsdmYooIKFix+9LrEPm/Rd1DRUqF1d44OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612273; c=relaxed/simple;
	bh=6Rw1gElFcBpnU1pb/9BjjWqUUU3i6v7QWwLIfb/1EhQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cCWZpjNXebB4Hij84HNDtUfjAQGfHiGe8T9kUDuN0zP3rJdbNjG8egdn6oEkddWI2EntwjU6FR5lp49B1WgtMTmHdRoLXfI5cXBpjD/Lg4WGolfS58Z/IRTAWm+EHY+TY+d7FkOyw2nAvCK+S4Hj4cybzu1Kq6HGqoKsoLOzbbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DodPwIPr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DodPwIPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8111F00898;
	Mon, 28 Sep 2026 16:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790612272;
	bh=6Rw1gElFcBpnU1pb/9BjjWqUUU3i6v7QWwLIfb/1EhQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DodPwIPrgfJWQND4NVhqDXrkdECM37KYusC3+TfRN7k4JzoM21HigtN6GF689c0Ko
	 iRjoz93qLCWe4feOgXp5RXGbEPRKRUAsM7U94dwjx0R5MdG8/hmm8rRUYRODifHX1U
	 GXOWPqA5PY+NVH70RSGfbmuOCLFIJvr2tygZ8+EAaDdyVFTvSHQXMySec05z51EZUG
	 VgBis8rjbTBjdKVcKkwJHLoYgNeyHyKUL+CR3UCWWYhfPeCW8MC1utTTDAcR38qHt3
	 EQhN7HrZTLrRynqGkcwJzKnKN2ozjad4ArMQzAe0Hg4VkX45rXIiokoYlonp2dZxyn
	 Oxu4+2+RY0hiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf arm-spe: Add Neoverse V3AE data source decoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928-perf_arm_spe_add_neoverse_v3ae-v1-1-738c9ed12d31@arm.com>
References: <20260928-perf_arm_spe_add_neoverse_v3ae-v1-1-738c9ed12d31@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:17:51 +0000
Message-Id: <20260928161751.CD8111F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add all Neoverse V3AE revisions to the list so the common decoder can
> populate the memory source and snoop information.
>=20
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-perf_arm_s=
pe_add_neoverse_v3ae-v1-1-738c9ed12d31@arm.com?part=3D1

