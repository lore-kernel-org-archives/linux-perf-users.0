Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D3A4BE450
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005010; cv=none; b=pV5V6/kzS3hzVF4Ur1NTRNQ5ctEOZOfFUbq33v3gz4XFbvu81K0piRzDfVgzhVyUFFoGGuSJI41HZ8zwh6kpIBEwjyoVaFfO7un24zwA1SHulrYotSXBPoyqfyXUa92OVmk8RVhE33nZLUMtM87Sp87x6F3tZvVeoqpEb20R9OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005010; c=relaxed/simple;
	bh=swIeYYkZUxVO1xWB1xnWxNUAZy2+iXtTrl4YY+3hR7E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kKSSfhLG6n+wRoMBi3hm1qovxl0hFrk9kAnwaD4e+z7snYNxqdJn7Ae+DH3izPLtv71/tl0iGCK0Ji8HFJ48SWMZ5R9+IPKQS0g3wev1OqGwvxrhIqUrn0pYLNE4cGTsQxiFFUtGnFVRHn8Esix3DKIhZL7r7mijdBLz14lKiW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5ywKl4s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5ywKl4s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18101F008A7;
	Mon, 21 Sep 2026 15:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790005007;
	bh=swIeYYkZUxVO1xWB1xnWxNUAZy2+iXtTrl4YY+3hR7E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g5ywKl4sKuI4rqqaVHhVCMCP7WLPptQ5iCAJZWrBqY91i4xDTnizrV6iUQqoInTyI
	 gDBOVA5YaoPRLqiZ7dtlvbwhTEDM0wGnkvKTc7Au51x0IUH8l4UYk0DKYbNrD9gdRI
	 Wp452G42qxbLWweku7rxv0tM6B6eDhLliWU87Z+gBEtnTZwcvyyOCoOA2U0RpMgABu
	 V1ivd2GOZl4jfJRbXcSpXnbwPHv5vEpWA2voHdZrj9EBLp5+HmMGUYMkrq/1voKymD
	 DyAln2MRv4ljIXrmwpbG9lUyzRuvLoeVNsh0tM04DeZrYI8WeorTaTayGy2LMoooEY
	 dDTcso5DgJLbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] perf/x86/amd/uncore: Remove redundant event slot
 scan
Reply-To: sashiko-reviews@lists.linux.dev
To: "Usama Arif" <usama.arif@linux.dev>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260921153108.2713179-2-usama.arif@linux.dev>
References: <20260921153108.2713179-1-usama.arif@linux.dev>
 <20260921153108.2713179-2-usama.arif@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 15:36:46 +0000
Message-Id: <20260921153646.D18101F008A7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> amd_uncore_add() first checks the slot recorded in event->hw.idx. If
> that misses, it scans ctx->events[] for the event before looking for a
> free slot.
>=20
> Perf serializes ->add() and ->del() for an event. Initialization sets
> idx to -1. A successful ->add() claims a slot and records its index
> before returning, while ->del() clears the slot before resetting idx.
> CPU context migration follows the same delete/add sequence.
>=20
> Thus an installed event can only reside at the recorded index. If the
> direct check misses, the event is not present in ctx->events[].
>=20
> Remove the redundant scan. This avoids walking all counters before each
> new slot search after multiplexing has scheduled an event out.
>=20
> On a host running a production workload in the Meta fleet, amd_uncore_add=
()
> was called 56,575 times per second from mux rotation. Its 16-counter DF P=
MU
> makes each failed search scan 16 pointers across two cache lines.
>=20
> Cc: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921153108.2713=
179-1-usama.arif@linux.dev?part=3D1

