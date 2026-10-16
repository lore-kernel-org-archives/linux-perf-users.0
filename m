Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8535553C3C7
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172733; cv=none; b=Rk+3auAcGsWmLtVq5D0tXNCfLEbRGGUpTh2jg8sdPjopXf8yhy34WgJhBsR8bWl9O0S/PdLXEmMXW4CMIXKIGvhFvWSbjGUuiMmfOzAapz3+d9azj2F8IcB85/iv+uUOxBwd6QLJhVY4KewXiW5ekjujlAXW7Sd9FW49ks2Xe3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172733; c=relaxed/simple;
	bh=j+Hs6zww/mz/Whwgwj9JNKTiEhQ7qzkU8FQqC80yK+I=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DaFlw1ao39nYlakyxDdHRlmvoUtxBkXY/oz4G4lGFph0zgGNbHtasM8pZ09MVTVG8S1fciU4HiRAmaHBIW4H/9v1tvCVFmE4DifInYUZ3p5xlEmeci4wKOeiSj8g9OGNVlbBPzG34Nhcw1ZUAxvAuNE8EL4fDp2yvqJpxDf0KEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmETaif6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmETaif6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9B71F000C4;
	Fri, 16 Oct 2026 17:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792172732;
	bh=j+Hs6zww/mz/Whwgwj9JNKTiEhQ7qzkU8FQqC80yK+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FmETaif6dXR+nKf3Z7G7eLZm4taDMR55VxqavzJP+Fof8KAIn7iya/z2A9E9OOvtM
	 NjiJ7Vs4onIQ+uqkYo468TdFNYA8wEdtqCcY1XxgMYk7hj6q46WM4g7Dy53EhvYuF6
	 wJKThow3FzcJNBAO+6I1q1t/9Z1yM7O+Nn4OB/QdL/LguuJ3QwkfZw0jYIBC7hJKLy
	 Nwpsc81TBn+FUStK4C+s+EiP62o0meZGOCGiy9AwisyT8Vbp6c3VMOXljE3phoCzAV
	 FQ5Xe4ONNBjKShCekxakBfYUa8Q6/kPM7Ayzte1x8uZUq3bgKPgDavnx2SKc2o9SZS
	 PkBbHxdZIgfeQ==
Message-ID: <sashiko-outbox-174745@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/17] perf mutex: Use kernel style
 compiler-context-analysis.h annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016173106.679725-5-irogers@google.com>
References: <20261013222622.1822619-1-irogers@google.com>
 <20261016173106.679725-1-irogers@google.com>
 <20261016173106.679725-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 17:45:31 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016173106.6797=
25-1-irogers@google.com?part=3D4

