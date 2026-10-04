Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E800477280
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136537; cv=none; b=QIJSkxsXKog3ns+dF1Z0KKyguWilKcYfMWZn32gnPGg3poJZxqMwGsrSQvhC4env6oZowUlWG0QMzy7ENvO+KycVtje64Bdmtp5QcU4+drtBKM4oxTd4VasfoDWY52WjjPxHNmTkiI3eaNSZoqPLslrE+1Ubllv2fA/BEeedCrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136537; c=relaxed/simple;
	bh=duyEC+WrXXH+bF/viEG1qs/dVmPccYoGxKRVjoCY/8w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ns5OHTi/CKQtFExh8ha+F5CDmrVjJw6opQqD6mV4fMI9+p+MYej0Ka5r/FrEprS1lRs4pq+gVqGPclKMVJuFMjR06p4Ld1xt2UMUjOYw8tzUUbEGTFltaL+443vkus5kH3KMHA1aEDchryGN0OwgVDC1ur2rfubabDrxoLqqW+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ycb1JhuD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ycb1JhuD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA881F000FF;
	Sun,  4 Oct 2026 17:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791136527;
	bh=keKk2Jrz93na9pBgsC3ywP37brjLzwzgFeZIjtHJdg0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ycb1JhuDJJSHAdX3NyMVjgyeU9g1W9iTH2o+4bbnFL0cBIzm+KgaQT5qKoNI1w3pY
	 yBtX73kQ/FMKvHn36hyd45kKTVbGKYo7SiUFgB97IB8X5hlQnT0pzM+JPROa8vm8no
	 dD6pGH9KyUFgMZkuvUDI8XqcQHJTcnJFL7r5lJcBHwRjHDc+y2vwB3y1cJLjvLm82U
	 z0doB1tBUZTlbLoosVTKqgm6szGyHaAaB66vMYbMlKdSN/qyAZoh9VbUuJwM+40WQs
	 TQR0eSib2ko4fxlPQhajuy3tkqdTAozvQ2MUV5xG7xwgtrdEypKk9um+98xkw3LbTz
	 cLAFEhMxU1wcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] perf/core: add AUX buffer ownership for kernel
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kunwu Chan" <kunwu.chan@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004173458.837842-2-kunwu.chan@gmail.com>
References: <20261004173458.837842-1-kunwu.chan@gmail.com>
 <20261004173458.837842-2-kunwu.chan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 17:55:27 +0000
Message-Id: <20261004175527.ADA881F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add an in-kernel AUX owner reference and setup/release helpers for
> kernel-created perf events that need an AUX buffer without a userspace
> mmap.  The setup path validates that the event is a kernel event with
> no parent, rejects non-power-of-two page counts and negative watermark
> values, allocates the perf buffer and AUX pages, records the kernel
> owner, and attaches the buffer under the same lock.
>=20
> perf_event_release_aux() stops AUX writers, frees AUX storage, and
> detaches the buffer, in that order, matching the AUX teardown ordering
> of perf_mmap_close(): perf_pmu_output_stop() walks event->rb->event_list
> and rb_free_aux() must run while the buffer is still referenced by the
> event.  The single event->rb reference is dropped by
> ring_buffer_attach(event, NULL) itself, so the release path does not
> put it again.
>=20
> Both functions run under event->mmap_mutex, the lock that already
> serialises ring-buffer attach/detach transitions for an event:
> perf_mmap(), perf_mmap_close(), _perf_event_set_output() and
> _free_event() all hold it around ring_buffer_attach().  Concurrent
> perf_event_release_aux() callers therefore go through the same
> serialisation point, and a second release call, or a release of a
> buffer this API does not own, is a no-op.
>=20
> Keep aux_mmap_count dedicated to userspace mappings.
> perf_aux_output_begin() accepts a writer while either a userspace or kern=
el
> owner remains, preserving the existing teardown ordering.
>=20
> Co-developed-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004173458.8378=
42-1-kunwu.chan@gmail.com?part=3D1

