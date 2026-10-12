Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79D14477FA
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791791959; cv=none; b=pqZMXonHzQq5+e+jMibGiVxLqlBn17uwqKeKPmXyb5jLg25KpiFlfQzkGCWPt7dHGQj0rYzy0gQ51g1D7NicntYlvhCJtzrQT2k4lweFP8KyXmNCrkmRtMkAOR3Xh+16DbErX6CEFU0A0kBCTMQNXM98TEZJx/wFM8m6fCAvR1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791791959; c=relaxed/simple;
	bh=aH78mFxSgGkO5836UvKwNzRz1JVfmloOyeyY/fh5k5c=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aLRQ/Hd6xRLOyo3IQ7e5EqfhsEpATiRrGe7gh2STuDZuLIXdtpJ6DxJxf2lA7D/yOEsk1LMxuS6CAVN55mumxnDxo1yoZ2n8j6Tnzn5Xmr7hsLURGqj/rTq0GuGwzKzxlpfuguLpa+e5gX+0NcJDvP6JpaP7etBSHpumZ+uC2Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVniDrav; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVniDrav"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389781F0089B;
	Mon, 12 Oct 2026 07:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791791952;
	bh=aH78mFxSgGkO5836UvKwNzRz1JVfmloOyeyY/fh5k5c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CVniDravkfnJ+6QifdcMAKbpH/XFd4oYtWhO0Y+DVFBalEbypjgshOGNyNOi3GUqb
	 uXr/MV6IVHAxzzyU4RQUul8B4T5Cs2tSA6VhxaF2C3MwfBhX89vRyrFotnCfGBPOo1
	 ch9lr1Sfco8EIjkhvVUCz3oJDoZtnWO62xMHhBXcPBxOHZP1AW37Yv/G5oyIO4spbH
	 43D+LYxakZMDFg4sQWuB60Rdcuy+Z1Vz5i9BOy1fFBaiwe6PrLi7tD6kgAZBHuiu3f
	 VyvZ1dbqqHo3MPjxoQB4PvojzSq9SrzB0CKQr6rjcxv3ezNQyJNJB3neZ+ROhdnsD2
	 m7AqKSFtQED1Q==
Message-ID: <sashiko-outbox-167817@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] perf vendor events amd: Remove "PerPkg" from Zen 6
 memory controller metrics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <8f22b9814dbe0014a1486a9510da3bb48ba8aeb1.1791791463.git.sandipan.das@amd.com>
References: <cover.1791791463.git.sandipan.das@amd.com>
 <8f22b9814dbe0014a1486a9510da3bb48ba8aeb1.1791791463.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 07:59:11 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> "PerPkg" is an event attribute and has no effect on metrics. Remove it
> from the Zen 6 memory controller metrics for consistency with the data
> fabric metrics, which do not set it.
>=20
> The "PerPkg" setting on the underlying events remains correct on Zen 6.
> perf de-duplicates "PerPkg" counts by socket and die, and on AMD
> processors these are the same domain. Each UMC PMU instance belongs to
> a single IOD, so the CPUs it counts on always share the same socket and
> die. De-duplication therefore never merges counts from different IODs,
> unlike the single Data Fabric PMU, which spans both IODs in a socket.
>=20
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791791463.gi=
t.sandipan.das@amd.com?part=3D3

