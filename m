Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334F14CF472
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792216357; cv=none; b=I/Ow5/kacVIG8q2UmAsjGyVbvAvVxeR1kFj2KAg8a3SdcF/7s8gnh4d0EimA+Iv8cBrYmEjtUDy66gBt/INaK8/XCkl9QNzwBbNybSlfewrGXkxHxvZIALnzKJ/5jrpgWqZFeRrN0Nkm4mv+9MhfOWsTUu0ym37Of0ZbioGemn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792216357; c=relaxed/simple;
	bh=zW766mooaJWp2SXtBBcDQSI0vGoxeNQTK+BPzMsPgsg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=mP8ShP4YsuZ7pDJQYwjaVtjgRvKuEFtmj6DzAI2YjxBIMvmf7XJ4uUJ1k5+KEyvyXvsOxANfVIAsFDKt027EjqIIw4Jqzay1eduSZpF8Z+Mm1wFT4mJRr0HjvuUQ7laDoT9II5SKcLhx/eSh+hg7cGE0mbZJUFJtqRhL5tPm+KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoSzTmdb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoSzTmdb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B621F000C4;
	Sat, 17 Oct 2026 05:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792216355;
	bh=zW766mooaJWp2SXtBBcDQSI0vGoxeNQTK+BPzMsPgsg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZoSzTmdbEsRqjmCwxtHWww0n78ce4cyhsWkE67fQywpCimaZJKt4Qt5TQ9olm/5VH
	 /5WITNVlswlrveYDhtz8fPwXAs1p6tMZuncUDadBMyy8qOiCq2xkQprXgQgmIsNKMf
	 e4O0ToLWSFsQmMNHaTq1OYeXR3YewjX3QALkcVphoviQPZAgjws3+yNL4ENccvBqlm
	 jnrrZBm2TJel3xlICTkjpDmCgrJlrpzWjoXY/470dIu3h9KOy1y3J3wXLwSCbxCp8V
	 o+DfaAgfeG3yWi4ttfdfAcVCwsgNL2+hiWGSLZ9CVVBigEv0zstOqJEC7gHurDLn7C
	 dpAWmxi8U7XNA==
Message-ID: <sashiko-outbox-175316@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/5] perf lock contention: Share common BPF and lock
 type definitions in lock_data.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017054555.1655407-2-irogers@google.com>
References: <20261017054555.1655407-1-irogers@google.com>
 <20261017054555.1655407-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 05:52:35 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Move lock_type_table, LCB_F_* flags, and the common BPF lock helpers
> (get_lock_owner, get_current_mmap_lock, get_current_siglock,
> get_lock_addr, check_lock_type, do_collect_zone_lock,
> do_collect_lock_syms, do_slab_cache_iter) and shared CO-RE structs into
> tools/perf/util/bpf_skel/lock_data.h so they can be reused by BPF
> sample filtering.
>=20
> Also add rw_semaphore.count and struct rt_mutex_base to the minimal
> vmlinux.h and extend get_lock_owner() to support rt_mutex and check
> writer-ownership and handoff flags.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017054555.1655=
407-1-irogers@google.com?part=3D1

