Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E18324B33
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Oct 2026 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562477; cv=none; b=fK6XcGdJfkl9ZO1TPQohKs6G7MEWElUjHTFYrasOZ83WzGWW+vlP7vqs85EfPBn60nvGDpxtZPjrQ8B6z1slRu+Bg9fYEIqueJXlOaogP04iB2zBogTkvgOil+U67snbInPoZKROohH7tZruQx02jZJW+40XW7Zw7RBIB8bEJ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562477; c=relaxed/simple;
	bh=kfz7Kg7VmeJQKjyUUuYzqTul6gFQdPNwbqPFGouHMe0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MiTQhX3c0tVEB0Varm9fHx8HdXs1QQ8DXl2ZazS3Es8xgnq3YpOJKUNTYeerVzbldt+t9+/m8xHi4WrFMzOpoQvhVi37r2UhmWDHjX8FSkBpjw376PzrgWbMDfNN0UUgT9rcbN6REibDm4dCZ95EEdCHUIGmR+eQjSNmn4wBmOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwTRqROo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwTRqROo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6ADB1F000FF;
	Fri,  9 Oct 2026 16:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791562476;
	bh=bqFx5Cjzht8RjKRpmM/SttkMhJobEeW9LVCc29w/36Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZwTRqROo9S4AG8xfzJ9TZz/SgSoDyh+PUJB2KlSsyJLMLV6Zxg90kI4kMczO+6FAH
	 vgc6KMLM30U70kCWiJuIrjuLrhcksmCDFakp2dyDzjNudfgDpTP4S6rR+O3Et8jhjH
	 6VVy/tXM9DxNtkHtIjR1X7E5Hh99q6KN6U0XBbI/SZ2IJNtqzQ6n9F1JAUel4yosMt
	 ELGXfyUDn1+XfzScFsm5EQosx2otUPAyoi3a81CYJcRXNBvqr+oKVKsUtkFOjSh30c
	 sx/IDhyfyq/bUyC2rOd/27wRc6ZB08htXkGDD0IEMa+DjBRYeAJT2/o/39J5D2iDBG
	 /FbNUKVzCjbYA==
Message-ID: <sashiko-outbox-165820@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] perf/core: add AUX buffer ownership for kernel
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kunwu Chan" <kunwu.chan@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261009160010.1829642-2-kunwu.chan@gmail.com>
References: <20261009160010.1829642-1-kunwu.chan@gmail.com>
 <20261009160010.1829642-2-kunwu.chan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 16:14:35 +0000
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
> Co-developed-by: Lian Wang (Processmission) <lianux.mm@gmail.com>
> Signed-off-by: Lian Wang (Processmission) <lianux.mm@gmail.com>
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009160010.1829=
642-1-kunwu.chan@gmail.com?part=3D1

