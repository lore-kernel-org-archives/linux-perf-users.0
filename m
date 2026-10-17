Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EBB20010A
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792196145; cv=none; b=of0zc06Xf3lmRHJQQDeLxTlbFrwqoijRR8abWvAdGmSCD3yyFLKxdKR2M+uc3uF1fNEfYtH9dvzZKOS2tvtJ1eO7gHHs8CYl6fQRCnL2ultF9KfXV6asZo3ByBpVBLUYtOZ9E7DBISmJwSCjBlI/hrAp4gHoWGPq1fOyt3ShPk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792196145; c=relaxed/simple;
	bh=5QlfnIoGObDgI4HHI/w6a0y3LdHBnNvbzYi7zej0liQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qJg900M4x4J+nWAP+XSR786ommUqZDcA3vXDSTogo+0aUeFOfxyLRy2Q5kGq9uHrunT6WjLeJm4EaavKcK3Y7mDeKBVxkZ9CJ1uhmSocybV+bhfCvyLCqmDE/VhI2lUK3HmOxbWU04zCTzTgejKGM/OYck7bhiG2eRyZcuJs9xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqUtKPib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqUtKPib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC3D1F000C4;
	Sat, 17 Oct 2026 00:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792196144;
	bh=5QlfnIoGObDgI4HHI/w6a0y3LdHBnNvbzYi7zej0liQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AqUtKPibLqC68n6k5BZ+m5w3sDTA+7lHj9FyM7GqQKXNDrQrRZv9/HeqnhrK5D4+P
	 MOeuMkTs0pmPKK20J5XqPMBu4j79ohaB6VOfZnQAMqIVrFNL/s0jW0kSQmloqL0F58
	 odKlchh5gkw6bu9jUY3s09b4VwdmWFSxsFZ1lWHQMPaF7r/WH5TFjjbB2qah4U+Qfc
	 QJYjCLoJhiRcMMjZbBFulOuKCER0A3ERcwi5VZS+KQ6P+mCea/mmifcbKe9IdHLUmN
	 MMKELx1MvBvn5sc9dNDPxAl5xkuv4kYzpxw74cSiB5aWWWJ8nDbxVTUbYFsyiUCoy8
	 3DHhl9H4emIig==
Message-ID: <sashiko-outbox-175061@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] perf unwind: Don't look up symbols when the
 caller doesn't want them
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matthew Wood" <thepacketgeek@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017000158.1178269-4-thepacketgeek@gmail.com>
References: <20261017000158.1178269-1-thepacketgeek@gmail.com>
 <20261017000158.1178269-4-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 00:15:43 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Commit 02b2705017d2 ("perf callchain: Allow symbols to be optional when
> resolving a callchain") let callers that only need maps, such as
> build-id marking in 'perf record' and 'perf inject', resolve callchains
> without loading symbols. The DWARF unwinders were left out:
> thread__resolve_callchain_unwind() just notes that "Not resolving
> symbols with an unwinder isn't currently supported", and both libdw and
> libunwind look up the symbol of every frame they visit. The first lookup
> in a DSO loads its whole symbol table and demangles every name in it.
>=20
> On arm64 this happens even for frame pointer callchains, because
> get_leaf_frame_caller_aarch64() runs a two frame DWARF unwind for every
> sample to recover the leaf function's caller. Since commit 29be60c93d2d
> ("perf build-id: Mark DSO in sample callchains"), process_buildids()
> does that for every sample at the end of 'perf record', so with -a it
> loads and demangles the symbol tables of every user binary sampled on
> [ ... ]
> and 15.5MB, with the same build-ids injected.
>=20
> Fixes: 02b2705017d2 ("perf callchain: Allow symbols to be optional when r=
esolving a callchain")
> Fixes: 29be60c93d2d ("perf build-id: Mark DSO in sample callchains")
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017000158.1178=
269-1-thepacketgeek@gmail.com?part=3D3

