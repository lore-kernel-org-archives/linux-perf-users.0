Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CA03EB80E
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 22:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787006065; cv=none; b=S6sqcaKGeo11VlRJOze3/JnH6ZCdZWG9Ry7evdFrPfo5rtVlRFgE3dDKQc118Ux3f2eolsye670iI3bgySDtXFpk5rsDvrDEx6ghV9mkC5cUh/fUOZjMlByK0Q4s8OBFmc337Q3+/NFNXN/qB+L22oBR2Sy/SSaPCdU7HEM6SZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787006065; c=relaxed/simple;
	bh=RrJiPcfsHypxbIB5N5szcWD6+f0s9GKJcyFKGe/CaD0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LLRDT0bS+MdxTl5O4B75+aICRbqh+bm9XU1q/xu7VwgwmzHUlDvLZpC/9K7dHB7bSe/VZTqu1nNJ4WXwna11PpR8SPfilHPcF+DvkV04TVWFmqYMw6vXNnXXUVJucBDy3wrbNYeF3B/5lNmKtgaEiztJx6Y3te0uoSYTqs1IaiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlzwlXU4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlzwlXU4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCD21F000E9;
	Mon, 17 Aug 2026 22:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787006064;
	bh=RrJiPcfsHypxbIB5N5szcWD6+f0s9GKJcyFKGe/CaD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nlzwlXU4R8PH1ShORnehydZaesdhYaZpnrX6l2aZOxvwnKdcGRlA71AqKqMclPiGp
	 OHplTz7cj42JoyhSZ5Hf8chr5xyUTtpA0O6tlYc30xlxbSeIO9ja0PbBNY8Fmj2Ku9
	 TgCGP64FPxY2kKSfwVeGx86+lyCFb/4kk9+ySNt7L2INWPvFScYK9l89QT6cBrZIhj
	 A6IohFyhYx9Ugfaeq22M78sdkztwbcKAUCoi3Zdi+cNZAkOF2mEomqcir37omu3M8w
	 nd8z3UlkgU4n4XXIy/qAOmZs8d9AOBLE4RNhbJnPOS4cB8ntzxWU7/vG9i+9ETTVqI
	 LBtLHPIn9s1YQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] perf cs-etm: Split up
 cs_etm__process_timestamped_queues()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <ac33d12949419373516ca02f2972c7e0af01c069.1787005265.git.aaupov@fb.com>
References: <cover.1787005265.git.aaupov@fb.com>
 <ac33d12949419373516ca02f2972c7e0af01c069.1787005265.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 22:34:23 +0000
Message-Id: <20260817223424.5BCD21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> cs_etm__process_timestamped_queues() currently does three things: it seeds
> the auxtrace heap with one entry per queue, it decodes until the heap is
> empty, and it then walks every traceID queue to flush whatever is left in
> the branch stacks. That is fine while the only caller is
> cs_etm__flush_events(), which runs once, but it does not survive the
> function being called repeatedly.
>=20
> Seeding cannot be repeated because a queue that still holds a heap slot
> would be seeded again, adding duplicate entries and growing the heap
> without bound. Flushing cannot be repeated either, because ending a block
> finalises state that later trace still needs.
>=20
> Move both out. Seeding becomes cs_etm__update_queues(), gated on
> queues.new_data so it only runs when new AUX data has been queued, with
> etmq->on_heap tracking whether a queue currently occupies a heap slot;
> this mirrors intel_pt_update_queues() and intel_pt_queue::on_heap.
> Flushing becomes cs_etm__flush_timestamped_queues(). What remains is the
> decode loop on its own, which a later patch can then drive incrementally.
>=20
> No functional change: the sole caller performs the same three steps in the
> same order.
>=20
> Assisted-by: Devmate:GPT-5.6
> Signed-off-by: Amir Ayupov <aaupov@fb.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787005265.gi=
t.aaupov@fb.com?part=3D2

