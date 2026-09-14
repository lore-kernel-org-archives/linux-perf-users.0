Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC53C35292A
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391233; cv=none; b=Qs6njGMiwJ3Qi485ei7n1VDG05uTpZ+d/jlpsfA/nXTwDMVnrp/8CLQEgZtYedUkN7Yv/vQtw5aeZMMOdSulkUe/ZMp8Boq7Xdv/XjfvSLylA7vwTUMx/4veyrKzS9lHT22g9fh3JwU7ZKljUqbYIzAkSkvXy9L77t43l9X1fQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391233; c=relaxed/simple;
	bh=H5kOT8iNKB6FPoXgyRNuJsTpBdZ8bJQw73+2kLSqXWE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UXr6CHGiLwxez3ZEU7Ha6QmMvAI0iJfRWvK/i52/Xei2CRjLZdDTwgjgTuKqdvwbxw9Zw62kpHKT8OBaXthpVFI4dqlpwFd/QwoIo9f/7S7Xxo2Q5ChKLXMXuHZMNGeTjUWixrv+aO4sknQsnrEmF/Lgz/PHjEitPrqPzTCXwQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6gWJB0K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6gWJB0K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C31D1F000FF;
	Mon, 14 Sep 2026 13:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789391232;
	bh=roDKmNZ/3+SRa9+ldCo2baWmTfsWJe769Rqy9n2lkU8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j6gWJB0KBUXw32yw7+Cgib3XUXGnHi486Hg7H+A/3V6yZbUfMNRJjYidI9UD7WRu8
	 yhsRQYxHfH+K74PAq7mb1RXIyvPqZjtmpdegPNo9/CXqKc+lCm9PrKWmV6wDj/lZ+u
	 jJRkV7pW6oMD8cf1r5TSXMy0Tfasg+JrhQX3rR02kEk/pwBJHHOR8zRwilo621Ox1Z
	 6TDACL4oubpRPfSjRZS+uRsfJaD17wG0gBJEIOgGErf6bE+LVNLR8T8+jvB0/e8afO
	 nwvlj0wWeVHEC8efYQAMJz6d+pRUwSavBJeVzxvrqd63l7BePkT8NWcJOGqc9bh+/+
	 Bd0g83zMBfjDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] perf debuginfo: Fetch debuginfo keyed by build ID
 using debuginfod
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914125451.2045-3-acme@kernel.org>
References: <20260914125451.2045-1-acme@kernel.org>
 <20260914125451.2045-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 13:07:11 +0000
Message-Id: <20260914130712.2C31D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> perf already uses debuginfod to fetch source files when annotating
> (via probe-finder.c) and 'perf probe' has open_from_debuginfod(),
> which queries debuginfo keyed by build ID when a module's debuginfo
> isn't found locally, largely the same thing this adds; eventually
> that one could be moved over to the new helper.  For the analysis
> tools there was no way to obtain the debuginfo for a DSO in a
> profile when it isn't available locally under the name the DSO was
> opened with, for instance the vmlinux for the kernel a profile was
> recorded on when processing it on another machine, or after the
> kernel and its debuginfo package got upgraded in between.
>=20
> Add debuginfo__find_build_id(), that uses the debuginfod client to
> locate a debuginfo file keyed by the build ID, checking its local
> [ ... ]
> that make NO_LIBDW=3D1 on a system that has the debuginfod client
> keeps linking.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914125451.2045=
-1-acme@kernel.org?part=3D2

