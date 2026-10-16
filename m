Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A673D1AA2
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189364; cv=none; b=nwX2ASEhLwMLqsF5HbQABo6cuULHUFNPLafeSl/iO+H61SZZZhBRZCyA4UkH1iyQ7DLxmuX+C5W7xL2LOkmtjs5+swFSJEVGHP1eqAXAtUTTEZXj0fhAFURMhWmXoKi78HJ6ovg8/tGYKzO7VMSzsnbwnbeekq4qSswJtrvB0+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189364; c=relaxed/simple;
	bh=vpjEMnLYGYKLf2N1swlCRFc7JzBaTbvh5c74o1GVrVE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rwE2ygp475me1i+lagqABjr/OfAxcQX2XhjfTElLcmHtJh9iMKrxkOjEdT1lRLRJuCIooUzhE8TIJtAJcizN44z4wfjpyuuCLTFbcZidXNiENKGNy4CxHLnlskCtj7p70SVaA71kZ59YiG8jaLOUHTSgZazT5dpEHLFS5w+yono=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQo1KG9Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQo1KG9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D797A1F000C5;
	Fri, 16 Oct 2026 22:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792189363;
	bh=vpjEMnLYGYKLf2N1swlCRFc7JzBaTbvh5c74o1GVrVE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BQo1KG9ZL5WdtQyYqA3CI33fow81lww/4VzMYydXMZVQ/EN4ymGDMA3y779HJZbyS
	 BsNOQNx8hN/YGR4PRuKDr/LjzovBzzJIbMpJfsaoNOorLAx2Sx3JtHQFD4yK8utpVn
	 LxraWg9m9WCFa77XaS5SgKJxu8nuWSO/Fi5kiyh2RrhYiaVuqaK+AZfTLK2cAxal7J
	 CbeW0kkmVopv2v0WityYZwiszYhx+bLdLWuewRVT+BWQO9a3aLf6VX0W/G2yAT829R
	 BUUi3NBxeHp2/kt2YrZeqekDa8ojRgHq9ZV0OT9V3ByyDvMUTguZ+zCAQ+Zgp/3L4v
	 4pbay7azEoJXA==
Message-ID: <sashiko-outbox-175011@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/17] perf maps: Add context analysis annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016221700.1282659-18-irogers@google.com>
References: <20261016173106.679725-1-irogers@google.com>
 <20261016221700.1282659-1-irogers@google.com>
 <20261016221700.1282659-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 22:22:42 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add __returns_ctx_lock() to maps__lock(), annotate DECLARE_RC_STRUCT(maps)
> members protected by lock with __guarded_by(&lock), and annotate
> internal maps helpers with __must_hold() and __must_hold_shared().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016221700.1282=
659-1-irogers@google.com?part=3D17

