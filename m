Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F935489866
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262468; cv=none; b=iheV14WVr6MSfdfyG37kpxGtJN4inPydxV7waQySIR8dmUdKFqOpKl8KQB2x8rGm5jlisvRXh66BBsnWCeRn8NNSWfE2LkjV+kuYOPR4RKhJJNexcIJhp2PAMOohkoHUXHvA2SwsUPx1vaBQz+zo9xINgn4tTTCaLaObaPRBpJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262468; c=relaxed/simple;
	bh=bZuutEGoYooYCnKrcs3FGjIELpSjJjY21zyEBaGEHGQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YfU391H6Di2r65zWqEZbSIZFMAW6cyJNowPK6Bsl3Q1/axd9fdaZUopn1uoZAtm2ZSVMNKD0A5pRwSJs0z2SeSJ9x1iCZJ3dmvd3Tlt9xmQooEFKxum9uyajWrzVntwdREw2sco3xnYl8fTGXZ8M9LsjngNiAyU4+pdfdeXtsTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsiEKUtM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsiEKUtM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B771F000E9;
	Thu, 20 Aug 2026 21:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787262466;
	bh=bZuutEGoYooYCnKrcs3FGjIELpSjJjY21zyEBaGEHGQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UsiEKUtMyCQZyIGz/4tYU7ZN4Onk9Obfz8p59fYS1aGlWQB03qD3MbVxYUjVY475T
	 /BrvcWybFUSoqeDOKOo+/mGRHvsVHrgDJ+0dPqdGbeCSQNvtFH4LizM6z7qEmhNalg
	 YV4lYXFXk46JN59vxYvKs7lnTb9trndgWtmuuchM08UAtKEBBT2JQzg+4b7en7o3Bf
	 JjYn3L0dtvm6T2XZsQocDRm8sxJnbXeIMCN0pv7k8NjATn5eXJ0Qp2xyRAbCmR2nO7
	 zv8zcnYtY+7OqHBPuJ9w+5Vu0mIaFHf8OmLGBlN5sQS0fZVm0fOQ3r4+sJwlzOSBU1
	 pnRa8dl2IQcDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8] perf record: Fix unhandled POLLHUP on non_perf_event
 descriptors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260820213757.2970316-1-irogers@google.com>
References: <20260820200214.2865570-1-irogers@google.com>
 <20260820213757.2970316-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 21:47:45 +0000
Message-Id: <20260820214746.98B771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When processing POLLHUP on a non_perf_event control descriptor,
> evlist__finalize_ctlfd() is invoked to finalize the setup, correctly
> setting the core evlist's poll array file descriptor to -1. However,
> this finalized teardown state is never propagated back to the
> individual thread's local replica of the pollfd array.
>=20
> Consequently, on the next iteration of the main recording loop,
> record__update_evlist_pollfd_from_thread() performs a strict
> equivalence check between the core evlist's array and the thread's
> localized poll array, detecting that the fd values no longer match.
> This causes an immediate -EINVAL abort and a premature teardown.
>=20
> Fix the underlying logic within
> record__update_evlist_pollfd_from_thread() to sustainably propagate
> the finalized teardown statuses (-1) originating from the core evlist
> back to the thread's localized poll structure. This correctly
> maintains synchronization and entirely prevents the unhandled
> index mismatch crashes.
>=20
> Additionally, add a unit test that explicitly validates that
> fdarray__filter() preserves its invariants regarding
> fdarray_flag__nonfilterable items to guard against regressions.
>=20
> Fixes: fb4751e79c45 ("perf record: Fix teardown hang on system-wide multi=
-threaded sessions")
> Assisted-by: Gemini:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820213757.2970=
316-1-irogers@google.com?part=3D1

