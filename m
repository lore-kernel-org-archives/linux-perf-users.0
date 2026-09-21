Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A6320E334
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968431; cv=none; b=KfGHTwxM1Rr0bPPoM724y82amVhqQQtMx3osG5L6ShGFjZqMetrVEL60Cu/TTL1gBWoG57d7p9wBP6fHKYwZH8vDJaR6hoTV2usqWjIpUn0OMQy58EjNkHRnFvwWPHj5dUZlXIcE4kmK+CHxtdARE/mrkSq59lpZyVQKW6B/8g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968431; c=relaxed/simple;
	bh=0qGsX20z9tQsE8pCncNty+x3dEhSiZoRQ9s4/rqSZYY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RrqOrcMBsH/TExL+kx383AjpAzOvEeiV6hg1rXpzyo11pdMz1+QouA3CDZ7Tiq0MdPin4YRkbEuqevdeamO7KwVLCENH5rNqOuE5FDjZ0IBrNSEmddjGTMUm4XGyNpbgbAzIHtqMDqNq/aWXYQPvamQlMkdje2Uz1FVTqqltQb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjZFNwj2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjZFNwj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5451F1F000FF;
	Mon, 21 Sep 2026 05:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789968425;
	bh=G7jT1qMaZze5SZOtHE15syTYrpzhxbo4/pGPCMJdsUo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hjZFNwj26AAWn1yksSIBe5VdSj427uAWY1JC7V4vPvRoA9HOhhQ6RsIX/DZUPT0LD
	 GTpe15cP3CIZ4qtx1j13EQ+cC0tl69Zn9KAlu80LItX9rZ9sqJZvJWQY0B7F9S27ra
	 Dwu15I23+z7vEvaYutZ9PVFG43ax7JfQnocCEDtDFhMS1eJRjCtXyk2kkxdsRektyo
	 JxN8IAUQtoX9dcedohWZvU4E2yb+iWHEetX0u6Uyjx4/+MVm1M7p5O+RDg/LXkWrqy
	 ULvNW5fnLnhwtiTwiAOBjIWYoR4ifF3m/6LmG0oaoKd6QSX5RCSzVGEgbyFyjPg5RD
	 dFjAxa6yLTiww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/49] perf python: Clean up pylint warnings in
 treport.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <2b4c064f5416148998951cf2cfa95867d8f4ae0f.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <2b4c064f5416148998951cf2cfa95867d8f4ae0f.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:27:04 +0000
Message-Id: <20260921052705.5451F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Clean up pylint warnings in treport.py so that it passes pylint without
> warning suppression comments:
> - Replace broad 'except Exception:' clauses (W0718:
>   broad-exception-caught) with specific exception tuples.
> - Pass both pid and sample_tid to session.find_thread() so guest and
>   process threads are resolved accurately.
> - Rename parameter 'args' to 'pos_args' in FlameGraph.__init__() to
>   avoid shadowing the outer scope variable 'args' (W0621:
>   redefined-outer-name).
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D4

