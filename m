Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCB93BAD89
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 02:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871952; cv=none; b=GSfooR+w/4Et426BBMPugeLqqI5Sg3OjRL62Ma846VqYGbwK/7YHuxchCSjzQ6ykwTnemC3hHImOB2DiUjr6xsdd0Tr25eOPI1b7kqr6yYbtDS6TuUDdflFqDy2gSTwnJW7ewOp0q+JNfYl5p3yYGGKp6SCNdLAuWJWpBmXdWE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871952; c=relaxed/simple;
	bh=TbZPX5RLIlUk5SMVzWE8xe+LxmBJOp+QWmuDIrZ/jnA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JAlljTZphhERGz+3KubieR6Q2A97aU0RJZQEA0A+JbLPeFPMxg4rIaxS/DF4U31UD9S9gVAm4cjRt6O8i8bhjkyjNtQcOXMAN40hbJxi4S873ibNFxtAWYVr5+vL8mBAeTea68zvYQ1KVdZA+FiAAtOpqgdYL7byuInrKCGC9Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdooPs+E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdooPs+E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8654F1F000FF;
	Sun, 20 Sep 2026 02:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789871948;
	bh=TbZPX5RLIlUk5SMVzWE8xe+LxmBJOp+QWmuDIrZ/jnA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WdooPs+EABEyFaUVXKFVQUJWolEA5yGwHGAdVxR2wI5u5juNVIBmItDegZmfGw6qi
	 5qSfeVtKplhWVDCIE2iRMwtvK+AbypSxpi5Oi8mxiwZWosM1ePH49OULhzhpGBnv0a
	 cOuMPRUvZNsNdi9yeDv2csuyPeqhJuT780uAJ1U/ausH3JfUj2ZPRIlgt7x2O/g98a
	 OT2fTeRfAeEzttqX5LfaGNTAh/81CqMwM8/z17zXj26fmUMeGKz50PcZuqfeKONbIw
	 50RNv6LOBvyBVN0gaXxnoVfQhz2j4aDyXAddgiR+Vj0nprHwrCdGqjgRAgN8lxyZJM
	 kCjcqWypWHVRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] perf test: Test lazy symbol loading and symbol
 memory limits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260919-perf-symbol-memory-send-v2-4-495b8f00ad7c@uber.com>
References: <20260919-perf-symbol-memory-send-v2-0-495b8f00ad7c@uber.com>
 <20260919-perf-symbol-memory-send-v2-4-495b8f00ad7c@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 02:39:08 +0000
Message-Id: <20260920023908.8654F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Alireza Haghdoost <haghdoost@uber.com>
>=20
> Add a perf script shell test for --lazy-load-symbols and
> --max-symbol-bytes.
>=20
> Record a small callchain fixture, require evidence that the controlled
> perf DSO built an on-demand index, and compare only extracted occurrences
> of the controlled test_loop symbol. This avoids coupling the test to
> addresses, diagnostics, or architecture-specific symbols for which the
> eager and lazy loaders have documented differences.
>=20
> Derive the constrained lazy budget from the unlimited run's
> index-reservation peak. This gives a deterministic boundary where the
> index fits and later materialization reaches the limit. Also verify eager
> limiting, malformed size rejection, and one-time warning behavior.
>=20
> Report unsupported recording, missing controlled output, unavailable
> libelf, and unavailable dependent data as skips without replacing a prior
> failure. Keep helper returns safe under set -e. Add focused coverage for
> skip-status preservation and truncated string-table reads in the lazy
> materialization path.
>=20
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919-perf-symbo=
l-memory-send-v2-0-495b8f00ad7c@uber.com?part=3D4

