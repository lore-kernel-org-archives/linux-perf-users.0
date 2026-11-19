Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114883;
	b=FE4ifyVZkYb06B9n/MlefBGE1jdYq1wizX65As+MRy6L2xdLMhnPDTrYu3+W+1wJhK63
	 sUlaCWj9GQeYsSOPmCPWabADlHIujwYYohaEhz9u8iP+p7840cnzFdF7Ukginagy2Zcfy
	 zrG0/yWU1WPkhb72K8ZewLYDJGxh2Kvit6LEeYx9VMYRhuU9nkO8MrlwCKcTK4Ag6nEA/
	 +Gu4BVjLpMcI+UOpUiswWs06OLjsZlN7SxrEmi2xHkS3FxjHSZWLMjRO2Tp346ALIcslK
	 +Ag5qnH1Ki8XgCVFdBl7cpoty27Lf63KUhbrod5S407xUZrC5Tncz0aPooCMricJNQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114883;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ui7rPI+BH1aw4gJ9ptg7rdxc8eksPe0uivlyfl+Dgp0=;
	b=DPMjyzX1Sit/0ML3AR6jh0wj8WCbMa3tqHEhLrytqs7q1biAZOA8CBMXmN+Ped4drOo9
	 Br9+HJ89iYPyQgYLNydop3RN+ETnJ2kNdqv1088PS280n++U3ITeznY1sK62B5OxCAbch
	 PzkmyFe5aKqvU8gtQ+8BWTYmAAnialzXx2hsCxxFD2K8BraIAwRT646lAeXNOmw4+WsEf
	 CVCjUWCHoCfKMHdBrgUI5GWpVBvAMmWr72fdRR6uSlmpsuDZQhUcAmpnxDNFQF7GwHrHb
	 YxQkAQB7I759G64JWcUO7QqwOXepbxDPcs19fk00DOuQfdtbQBV2cllIYagcEYqqj9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OPQFKdR8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73610606A332
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 19:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OPQFKdR8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089571F000CA;
	Thu, 19 Nov 2026 19:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795114883;
	bh=ui7rPI+BH1aw4gJ9ptg7rdxc8eksPe0uivlyfl+Dgp0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OPQFKdR8ZYzhKGCtPLB3EhShIrhdV94IFnxH1diKlrEl0dVdRd+NnA5GlD3OrVlAX
	 hV/C7a3GdvpwpZ4DCY8TlqByS0ElS1NNQyqDp/cT6YSWfBjjbdmWT57XMZExN5V/9f
	 dA0/fBkQdyG0bl686C22ClaWoY+Pson/xNIEHNVnhLDrsPC51QTY7f4rAgapawWWiO
	 XPF8k8/LiJbUKs0tADG3OZi/EOA5FLBmxFBZWb2LkrpCdcNOP0haftS85V5r7R5Zs9
	 ozL3UoQqnoHGn0GJAJ5L/MFkstx1yLMG9cEjg+FLwVwuBjn1eG29IDLicc9KJEE9E/
	 MKa27OLHgydOw==
Message-ID: <sashiko-outbox-223820@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 20/33] perf/core: Prioritize kernel-owned pinned
 events when scheduling groups
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-21-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-21-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:01:22 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When scheduling event groups in visit_groups_merge(), pinned and
> flexible groups are ordered by group_index (creation order). Normally,
> kernel-owned pinned events such as the hardlockup NMI watchdog are
> created at boot with group_index 0 and are scheduled ahead of userspace
> events.
>=20
> However, if the NMI watchdog is disabled and re-enabled at runtime
> after a userspace pinned per-CPU event is already active, the
> watchdog's group_index is larger than the userspace event's
> group_index. When hardware counters are constrained (for example, when
> PMU partitioning reserves counters for a guest and leaves only one
> general-purpose counter for the host), the userspace pinned event
> claims the remaining counter first and merge_sched_in() transitions the
> kernel watchdog event into PERF_EVENT_STATE_ERROR.
>=20
> Order pinned kernel-owned events (is_pinned_kernel_event()) ahead of
> userspace pinned events in perf_event_groups_cmp() and
> perf_less_group_idx() while leaving flexible groups ordered by
> group_index for normal round-robin rotation.
>=20
> Suggested-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D20

