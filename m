Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5023AAF5A
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912830; cv=none; b=lcbP1TNcXJkSf+1xSxvmbb4ycC0nLR+oGxGOeGLTumLqRL6Rhgp65kCFtNUlUpUbwftC3Phel2zsd96mQLEauOXoik6gsCOwQzw0P8D/r1vsOAOFDFqrw1V2tYzCNgACBnHKgWT1GfC2FVFBGIqRHRKOVIlyY909rmjrxurz1W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912830; c=relaxed/simple;
	bh=MRIC9GkUlDKssfBbKnsOKNAPa7KfvuSRWuSfnOMUlKw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=prPh0u117hARsn7CSePVFZ7SyW2rBu5RXNzG9YBaOIJZsEcJBc1u+ZQR0w/Q7yavS8+VF9liS/UC5rs3FciWn6Aeai195R+gy2wNHZmBvj/qZ21lZrmWEx9VEdpk+144doDdc1q9LaIXF7QIYYd7tLCiDdM22mBsmbklSrSPhzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8lxLmCG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8lxLmCG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67DC1F0089A;
	Tue, 13 Oct 2026 17:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912828;
	bh=1wq1Nz7I7ykNie6rCHskLKPBREvHuB1cvEPCBZU8da0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G8lxLmCG38FLYTcZ+J812BwFfJJifOLU/efdqY+QEPhmYxqmUIZtgrHQvDUzT13be
	 qUzk7NeeuyyncE8qig0IVfc8HHuKsOMMDG9fLiMksRKhPCds1kFRoTEqZjIhG+KQDo
	 n2wzI/sX/o4EIHKTPS8ZHScrNzeNI6HVFqDOgbpBxiA2F6TPweXTyilRR13EbDFIk/
	 BXUlPpvlx2zIFHZ7kpQEa+5aEgALWpYa/h+BVGpCSZI0vfJ3bbPGYBBN6B/2wjn9n7
	 EYUTaivJrork5wtC6bYIS0Bo4svItWG2eOy4nL6Z6E3CiE69JmZOT5I0vtAHXnQ9Gq
	 iXVjStL28cTzw==
Message-ID: <sashiko-outbox-170236@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/11] perf symbol: Set binary type for JIT map DSOs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013172155.160869-9-namhyung@kernel.org>
References: <20261013172155.160869-1-namhyung@kernel.org>
 <20261013172155.160869-9-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:33:48 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The perf-<pid>.map files contain symbol name of JIT functions.
> As they don't have the binary data (instructions) no need to try
> for dso_data.  Let's set the binary type regardless of the result
> of symbol loading so that it can be ignored.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013172155.1608=
69-1-namhyung@kernel.org?part=3D8

