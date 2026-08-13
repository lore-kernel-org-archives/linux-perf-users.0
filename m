Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489132D1911
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786634206; cv=none; b=adCJFWO+oltppzB/BmsaH4m/DphNHmZUYqXdVWr2DIohCtabOm7thGdXA8WuoSNEuidzRktAKS8t/8+27ot7HVq0onVhkgC3ufeeiJOo734EY5vzI0iIVjnyIVgjdJAHOY72NT75hAYmvaiDgarAx0oNvuUGXsbPKXOpVLE3vxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786634206; c=relaxed/simple;
	bh=bS4o7CqqcIqSkyoMMs3HGqY31jCqGv+u2wHd5CDKtbY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dzdCW946klln1J8ChCtLNWWbLtgl1AfTSkQjV+KueDcPWrSisC3QLZxFJuly6GwsTWizIV//IkAL8bBMc49/SqnYBIroGi1zD7RNGCk90gzAmaIl/0HsG/3rAR7qWPxym4XOX769NZLgkcC09pgEa91BIiHiXB3BUbJWqtreX9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIAl+2oj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIAl+2oj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF9E1F000E9;
	Thu, 13 Aug 2026 15:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786634204;
	bh=bjboSHV+twQ8mKFEF+27s6ZTfHUS1Yd2baT5qjjMQlQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hIAl+2ojhucydNaLfOEA9wst8epsaz99j9hOmeiyqXOXB3i89u/Ks3XKj2SR65s96
	 NCUh5kIor+d/Aq1dQp00tF3Br3Ldm1Xa71HGhsxbNP6pS2lfM19OeJrRe5hE19rKIh
	 B0KJCQCFIN9nkFBXPw4Rb1OtYle+g0lxzvTbFDV+eWNCreDdx3MtHt6HHYdgJRCN/Z
	 l3dJ+UfC709v4sweP3gwvyaPhwWnnQ653oqIj0x+CffzOQk83fiAILy4Ri9TYjXFPM
	 YkHN7VMfPAq1e3Cx5pdrpVGEA+/ae/DSrbY1GPhsP8sp1drIwGgwQTyRjApxOUS0Db
	 K2+ZsCrCpPGeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] perf dso: Guard close() against invalid fd in
 dso__decompress_kmodule_path()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813151148.23169-3-acme@kernel.org>
References: <20260813151148.23169-1-acme@kernel.org>
 <20260813151148.23169-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 15:16:44 +0000
Message-Id: <20260813151644.AFF9E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> dso__decompress_kmodule_path() unconditionally calls close(fd) on the
> return value of decompress_kmodule().  When decompression fails or the
> DSO is not compressed, decompress_kmodule() returns -1.  close(-1)
> fails with EBADF and clobbers errno, which callers up the chain
> (dso__get_filename =E2=86=92 __open_dso) depend on for error propagation.
>=20
> Guard the close() call with fd >=3D 0 so only valid file descriptors are
> closed.
>=20
> Fixes: 42b3fa670825 ("perf tools: Introduce dso__decompress_kmodule_{fd,p=
ath}")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813151148.2316=
9-1-acme@kernel.org?part=3D2

