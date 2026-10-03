Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF00377AA6
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991223; cv=none; b=mMtFdC7ui7n7Y98BzG8lwT8bWLN4Iv5+1Na5gH7K+OyijvS4R87advnA+ulzjfk0unirW1hgJxKDioGd63kPXDpLzp0VEo9ZnFvaoWb2YTSXf5PxQR5iPaQmUymo/S5YikB6ibavy9e/OeofAuTRQM0M5TWS/p5DQn0MZIj6ohM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991223; c=relaxed/simple;
	bh=+YcbGnu1W4Am0o2UA3fs3NTZ0ykrnnzvHUHEhsGwn1Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HbVydxuajkb+4y0KsRG+/MJEv/Gpaub3UUmdX+JZfPmoy3YOgYyUPDZ22IY49vy1KCIvx3+enNotH1kXwFZrM+VVZw71bWOcUn0uQjj4XKo7uuhgD+rfbCyAJmWkohhYU0T2zI99K9/j8763Vf/+2kpKekkQpPs6qnfWEFeemBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgbIqLRL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgbIqLRL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CA81F00898;
	Sat,  3 Oct 2026 01:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991222;
	bh=+YcbGnu1W4Am0o2UA3fs3NTZ0ykrnnzvHUHEhsGwn1Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VgbIqLRLeb2/K/aG++T10beEUsF1tv3nN+XX1OlCKJsm2DaOV28S2QMJZjpuslRhS
	 V4ld4jZ2glRUCtcBs00B4MqnT5oqwkHDIH3yKHiuivhIcWNHYaidhWZLccuPdUdlXe
	 Pt3HCX/e+EJE7EXERtfQ8KYTrfFtIFBeqi37OABphABwpsDWL4be3ZaeLD5wS1l3Gk
	 9WBql4HHbVLSjybkmxZWV2raKBmlCSvUzUYvNbu6J7nd/4KEWr6xHF6uy7IQhveVAi
	 Ti+cH6WpCjyL8YYEJgAEIv8U/repDXU3+jE6VXz9X9QN4xvr6mZQy9WsKI5ujsX1SJ
	 z9vMgF8R8+rVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] perf script: Add --lazy-load-symbols for lazy
 symbol loading
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002-perf-symbol-memory-send-v4-4-0a592bb2539e@uber.com>
References: <20261002-perf-symbol-memory-send-v4-0-0a592bb2539e@uber.com>
 <20261002-perf-symbol-memory-send-v4-4-0a592bb2539e@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:41 +0000
Message-Id: <20261003013342.07CA81F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Alireza Haghdoost <haghdoost@uber.com>
>=20
> perf script eagerly materializes eligible symbols from every DSO
> encountered in samples and keeps them in an rb-tree until exit.
> Most of those symbols are never sampled. On a large profile this
> turns symbol loading into the main memory cost of perf script, and in a
> memory-constrained cgroup into an OOM kill.
>=20
> This patch adds --lazy-load-symbols for userspace ELF DSOs. It builds a
> compact address-sorted index and materializes ordinary struct symbols on
> demand. Names are read and demangled from the exact ELF source through
> the existing DSO data cache; resolved symbols are then inserted into the
> DSO's existing rb-tree.
>=20
> struct symbol is unchanged. Each index entry holds only the address range,
> [ ... ]
> entire lazy index and detaches it from the DSO. A detached index remains
> alive until its last reader finishes, ensuring that no symbols are added
> after the name-sorted array is built.
>=20
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-perf-symbo=
l-memory-send-v4-0-0a592bb2539e@uber.com?part=3D4

