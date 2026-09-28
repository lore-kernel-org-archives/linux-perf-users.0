Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9112746D2B4
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582451; cv=none; b=VGYy3x+78pZaIAvKkyKGZzmB8R0PpoJp6U93NrFu1QTpzkUbtANBSRCd2LJnTx43aGf7SkC61cambrRoP7WrHCWbdg6TFBBqxd8dUzv4eT7TXg96WIj4jdvrUyNouKuIACCc+s+RhUOBROruPBJ/M4CE/50NCXQJptsU/hB+J5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582451; c=relaxed/simple;
	bh=3393lYwPQYVvxtHT9vp72CNGwSexbbr8KE5wMbr5f1c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ny6AOQjJDxqvh0k6zgYbFcSY1eUZE1bFS95zDO1wj4nQyxwkkXCXniohGty64ZhGXZ6FRw5OW4n0AmWJz9XOoYneuvpUWHhdl9nxuY0X3RP+ZL87IKCtzQt+SsEihZW4OXw+ka3R7z0/SDd+i2DLoVBDdRR9Ij9ZRi5eptqZDGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUoAfTaQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUoAfTaQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1041F00899;
	Mon, 28 Sep 2026 08:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582441;
	bh=3393lYwPQYVvxtHT9vp72CNGwSexbbr8KE5wMbr5f1c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nUoAfTaQWNUd2vFr82F0N+T3fTHn0N8VyJwyqe2PCFkWps/bWDCUrNZTyJWn7XQli
	 Ql8wXNfpXhoskPvBbnOsfNt0Aj7qJD1gyiKeiU5pOiph7WVUoTBytaMJ3Q40j3m7Tl
	 4VyGKOsLhL+yncZ8v9ZwCZhuPXx92AVBS2DqJWNY6SIajNEepNFiye5KPDptRX2kN0
	 YuETrwSI/hJ6WkuUfLt8yX/aJbpqytB4jNXdhYxVVROtP2hbniBfkccrx0J43gD0+r
	 SkIRxCCYJovhuhBTjEmdfjau62LXgTml5wEvVGcyBxTgQ69+hw62Ax5pyrETpIM8k+
	 ay7rknNKQ0YXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/15] perf/x86/intel: Guard leader sibling walk on
 nr_siblings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928074309.898043-2-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
 <20260928074309.898043-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:00:40 +0000
Message-Id: <20260928080040.CF1041F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The leader event's ctx mutex is only held before calling
> pmu->event_init() for sibling events, not for a newly-created group
> leader.
>=20
> Some paths in intel_pmu_hw_config() call for_each_sibling_event() on the
> leader itself. At that point, leader->ctx is not yet initialized, so the
> lockdep assertion in for_each_sibling_event() can trigger WARN_ON_ONCE(),
> and the access to leader->ctx is unsafe.
>=20
> This loop is unnecessary when the event is the group leader, because the
> leader has no siblings yet. Guard the iteration with leader->nr_siblings
> before calling for_each_sibling_event().
>=20
> Also move setting PERF_X86_EVENT_BRANCH_COUNTERS to the end of the
> branch-counter validation path so the flag is set only after all checks
> succeed.
>=20
> Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928074309.8980=
43-1-dapeng1.mi@linux.intel.com?part=3D1

