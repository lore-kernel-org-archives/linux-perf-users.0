Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F86E4AB3CB
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575797; cv=none; b=kYHF7mMZd7pvbkHPQW0tRQozswQ2cTGZr6GL8eXP6S887ad7bv7fWvL0lZTH1WbH6UcmRVSIo6lkg6rbDlcgijT5dOpS5n2Abq2v0TT6ZKQ7Fw7KkUnVJUAMxwQvXKk67u/VMjA28pK0m3M2LQow6Q4PY6D5iTq+PeTZ6ZIY/UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575797; c=relaxed/simple;
	bh=/gfIPIvNOpJZCtenFnGD5wx4gl4Io2fzjOkRaMbE0a0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N1CwPmja1e63GZL9UA71MqBoRWYpLNINOJYiFPhNFk56ZFtMctLxT+gA4e4bXxDkQVeYq5da65KcZkbd0H3v9gV2AIhn5Iq8qv87SVj9bbGd6Aw/xSTj1d2rr5tr/GwXugeiY6bHrm56fGW2bTgVI8MKn4GHP+Oj4SeXvYoRgZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzZ0SN1h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzZ0SN1h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125FF1F00898;
	Wed, 16 Sep 2026 16:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789575786;
	bh=/gfIPIvNOpJZCtenFnGD5wx4gl4Io2fzjOkRaMbE0a0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FzZ0SN1hCBUDPxQb/NehtiqoXkoDg3RUQbd2TaxO89JHokqLMiUBv0bMHiiVeTm/Z
	 xDBKWKDJUgOW6wyZVcqejgaYNrc95I1ObX3DQ5D0BPA3+yTByfqTL+8sbXA6zM9d6b
	 W9ngpZZK1fI3ZRYj1T/t/b5vUknqVZDLVxbHhIDS5rB6kP1P0ZAri5dMNJJSlT3o5T
	 ExyDyyNQ90JZJ/dJAgAMeRzUEXPXUu53TAk+75LQ91IEVuTgu4BpETqsnS2kKE5DKA
	 t5EiOLhtvKUI8FafPhWVK4qbIKiZUoXjJ2QY1OLvuv8ujMUEC28rfO/Alhwg1w4y5z
	 NFXyKLVzCAVwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf sched stats: Reject mismatched or incomplete
 snapshots
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tianyi Chen" <hi@tychen.cc>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916161125.2548499-1-hi@tychen.cc>
References: <20260916161125.2548499-1-hi@tychen.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:23:05 +0000
Message-Id: <20260916162306.125FF1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The before and after records are paired by list position. If a CPU or
> domain disappears, counters can be subtracted from a different record
> or left as absolute values. An extra record can also advance the cursor
> past the list.
>=20
> Identify the second snapshot by its timestamp or CPU ordering, and
> require matching CPU/domain IDs and versions before subtracting. Check
> that every record has a counterpart before printing, and propagate
> errors from either input of diff.
>=20
> Add a shell test with synthetic snapshots, including equal timestamps,
> CPU filtering, and missing or reordered CPU/domain records.
>=20
> Fixes: 5a357ae6ad63 ("perf sched stats: Add support for report subcommand=
")
> Assisted-by: LLM
> Signed-off-by: Tianyi Chen <hi@tychen.cc>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916161125.2548=
499-1-hi@tychen.cc?part=3D1

