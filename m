Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123CA3DB311
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189253; cv=none; b=sDLxD/WnBfkWR8qXHHImHNWxipqBiguRCe+zAapPqPOHJIhaTXKklPslRgkUezFrYb+w/xpwx9tfh6EanIfUSgakGYA5i7nmmdneU8SY3f5O0nnw6rMn/bNzBB97UIK8EgLpjFLQCtMVvG0gQmbdg1GFRcDYlAoXNlBzxiVPicA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189253; c=relaxed/simple;
	bh=jW32xss5U6jQXKS6tWtruVCulAfNXSpsddIy3NJl8vs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Th1O7r/E0VfeGzndYdR1pFXSvyLtTLTK+P0YfoqkbjjuZnq7JMQkywgAU9L1F25I2Qfg38UoL3cbdtIchPn0hjYQAWg2jtTzyL5I7LhZ69F1wbbts80geD+U5MFQphVPqcRu8T1oETeNPeBh8ZJG7dZ7/cRldUT8F5RiqKAKpvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW/ojil7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW/ojil7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936711F000C5;
	Fri, 16 Oct 2026 22:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792189251;
	bh=jW32xss5U6jQXKS6tWtruVCulAfNXSpsddIy3NJl8vs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NW/ojil7VORWiOHM8Z1vHMLaxiF9YejLJzWDDFlCrtS8L2EvTaSK4yqqhTLrGRjHG
	 nswkMImyA2t8jKW7OeoqksgilSvu1Glxs6mXgNptF+800lLrw05cfNyewCgzyQOipP
	 nOnN048oQsOXoVUQeDpjjAitJtjyto2f6dQQ6rAFk7LCbjVZKlG38ynI9ilcVflu/4
	 1FbTt9ii0NR7ZGViFF8Nu/OpDKXC0c6DrtuhQIXN9Lg2reRQaXjymqPC5n15rhIDWS
	 13s/RhrshONfNqVoXna8hGuY5gklgu+yHvH6YE8cYWtvRPY8igNfrWnQebDrsIKPIl
	 y+6pQ+5dH+B/Q==
Message-ID: <sashiko-outbox-175002@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/17] perf dso: Use DEFINE_MUTEX for
 dso__data_open_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016221700.1282659-10-irogers@google.com>
References: <20261016173106.679725-1-irogers@google.com>
 <20261016221700.1282659-1-irogers@google.com>
 <20261016221700.1282659-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 22:20:51 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace _dso__data_open_lock and its pthread_once() initialization
> wrapper dso__data_open_lock() with DEFINE_MUTEX(dso__data_open_lock).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016221700.1282=
659-1-irogers@google.com?part=3D9

