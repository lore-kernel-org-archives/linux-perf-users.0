Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9832C4EA394
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Oct 2026 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562656; cv=none; b=YEmsvR5CAaXPRwhYnCplSrsZG9tuZuAInJcRlVrFF8hVkplPDLC6hmLScS7SxkIIOO4sV3UpjTbA198YJb1HazshXttM5farJYVZ2LlOIoHtTn8WQSKFi5kSRPoyLV6KW+0x1i+B1IOVdZOxmXH0DI4PZwfG4B1hj1TcYJrgx/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562656; c=relaxed/simple;
	bh=S1dv76yH3JsHkTsq8jlPlxAk7/TEJ+tC0/qXubSUqEc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=mrEidz1FhlEIa85JZffiyMP4uPqssHYsyGMLNFhqzTh2/FKTw3Q2arVd1lWHIJAH4vDZsjGpt0+98Lj+x9ErNqyK1b6hE8uRKF91A9kM4aelB97bmUXMWfmy8qDcWu9N6lKbPs+uxeJd14oxm8/wtAtvoZoVrjDyfB11vydmOOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7kVhUEE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7kVhUEE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47FD1F000FF;
	Fri,  9 Oct 2026 16:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791562648;
	bh=oWYpB7ptQVEcZyzRDFIlRuZoX7tZ9gUM0cGWMH0hNG4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F7kVhUEE/IIJfFiMAgsKzpa44kpBJn6w6moeTYoy2oh6aXglOPLyuBye3rZ6eX0hz
	 sRB14C5v5n0IqaHGbGVjFQ23sh+/OxAhHjad0i655R+hP+Rcz8sDTXy0wO2dtwVm2g
	 OH+/ZbpfowPZfwfuIqd+KqUCnGH6Gn8oiNjxrWMMaa16XZb+2jHxFfwnDBM5IV3lEt
	 603vOSqWZtXEl/fL25Zg2qSRv6AkrI1/Kg9lSQ6mX5D9i3g2SrCYOX1i5W+Hipf8OG
	 STMTnr8gOWyGwsKnwYAHiB01GfiBoh2BccIUWntjVU6Ag0Mu6jag+3PA9B0TYN4xg1
	 u3PA+xQGFjK2g==
Message-ID: <sashiko-outbox-165822@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] perf/core: add AUX ring accessors for kernel
 consumers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kunwu Chan" <kunwu.chan@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261009160010.1829642-3-kunwu.chan@gmail.com>
References: <20261009160010.1829642-1-kunwu.chan@gmail.com>
 <20261009160010.1829642-3-kunwu.chan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 16:17:28 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add kernel-consumer accessors for the published AUX producer head, the
> consumer tail, and copying a possibly wrapped AUX interval without exposi=
ng
> perf's internal page array.
>=20
> Use the same memory ordering as mmap consumers: order data reads after the
> published head with smp_rmb() and order completed data reads before
> advancing the tail with smp_mb().  Validate cursor distances in the
> absolute cursor domain before applying the ring mask, so rewound,
> already-consumed, and future windows are rejected even across unsigned
> cursor wrap.
>=20
> Hold an AUX reference while copying so storage cannot disappear under the
> consumer.  Restrict the helpers to buffers owned by the kernel AUX setup
> API.  Document the API in
> Documentation/userspace-api/perf_ring_buffer.rst.
>=20
> Co-developed-by: Lian Wang (Processmission) <lianux.mm@gmail.com>
> Signed-off-by: Lian Wang (Processmission) <lianux.mm@gmail.com>
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009160010.1829=
642-1-kunwu.chan@gmail.com?part=3D2

