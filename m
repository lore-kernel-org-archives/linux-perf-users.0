Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949252;
	b=ZGZpk5neSM7ShXLacQfHX0UZHwauGz+Fg4eqn4LicWrnnmAa5XlSTnKuc5fTCUwWIhkJ
	 i5pRJuY9xKtkbfJFhgTiwNgH67rNit70QSjLxQc/kC8nFMuEBGxVM3Z55H9EYNe49XVVp
	 PlpTBKk5BWG0Ff3U/IOMLyQyoVVmmVAiNI73DFvs+uAWn1WiHfbPiideqhojeqvoAQKxx
	 Hzju88o2l1oQiwLDRwDo10iHH2ASGfoC5cis/Qe7B+3zvfQ1lefam5J+2Z2G3PX57EumN
	 p0uljgUFTlxKLz5QXF69Z6NsUPxwtrYqmkLKMuDn9gpO2j1tyOphRa3zgzFad+wFViw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949252;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/2hR+n2ox29eTjaNushIzcndb3OZ5mA6uGtWvlntACE=;
	b=b0UpQIQjCRavWQJ+heJDrllR7H8YfPwc8MGCnIanusVvbPRDFbWUBWSej/fwiJ+7L+oq
	 9zjDW5Z0qehYCpfAnFzawOzJ7JF3xdtc48LRN2koVAIzFWQ/5/ziAWX4ddUd0YlAg3RQU
	 O23GqQeZtqVrEHuygoWFik6P6q6NcLLWjwha8QfAPfZjex8+Amvf9G2eDMNJh78lVtqRw
	 3fyqybxo63U/jJObITM4EELCZK2p1sEQJ84pIXsBN0lIFunH3a2dAHrJKXBgblZ2zJzrr
	 zaIgc34winlZMV1djvvWVjEAsl/LvIH2hmc+3XA11rNOR1dpLPhIwCGURHraHNG4GtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kht5noUI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD86606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 07:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kht5noUI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6933F1F008A1;
	Fri,  6 Nov 2026 07:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793949251;
	bh=/2hR+n2ox29eTjaNushIzcndb3OZ5mA6uGtWvlntACE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kht5noUILY+I/mMIzutfKn2xqUBfGeUXK3ccbntQp8HN83QatxKc958G5PTU3JdjQ
	 Yl3OhW04J/GtiWhXaQWGC9KHhpttAmEWDtKohO0DTJYLsHSPM9TB4ucOF3LBVlQb/j
	 xPiv8yXbs37OyELAV1LRHYq8XaIM6BlqDiIZCNpxI7FE/PB3oqHlgpX5O/F3Iy+FlD
	 fj3S3AyQd3wFUwStg/fjDl9HUGWVRxQhZucUhVWlVmsS8FFwq9M+wZq/ykesVk8Ekc
	 yGvCe8//gkRtKDnFiTSY+w+m2KRKEhIoYIrXF4l6sDlLcauDf5NB321vBY0tgkfLQP
	 KJZnc4HqxIyQQ==
Message-ID: <sashiko-outbox-200979@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 04/20] perf mutex: Use kernel style
 compiler-context-analysis.h annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106070344.329897-5-irogers@google.com>
References: <20261106070344.329897-1-irogers@google.com>
 <20261106070344.329897-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 07:14:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Enable -DWARN_CONTEXT_ANALYSIS alongside -Wthread-safety for Clang
> builds in tools/perf/Makefile.config, replace the custom lock safety
> macros in tools/perf with the kernel's compiler-context-analysis.h
> annotations (context_lock_struct, __guarded_by, __acquires,
> __acquires_shared, __releases, __releases_shared, __cond_acquires,
> __must_hold, __must_hold_shared, __must_not_hold, __returns_ctx_lock,
> __no_context_analysis, and __context_unsafe), and remove the redundant
> macro definitions from tools/perf/util/mutex.h.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106070344.3298=
97-1-irogers@google.com?part=3D4

