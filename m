Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38106519E09
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172573; cv=none; b=XS73WHK44R9JswGpSWBD5Xwe6Ue/woO0A0Hfw9BxKXWLBJS7+S3FOnCYVRBhtV7H8XUCjNE2k1poBZhPrLxTPVnPAK+pG13yH2Y5EYyJb2BVrrkjlyFOzsPUFrK7V46VN7LrkAE6jeTAZwi9fdUERF/c6FA6RCRTM9pO9wdorCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172573; c=relaxed/simple;
	bh=gZt44muFQHLUXuHw0c5YUdv07miHy14eDOlNqARy2uU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=rP0YgbjdkHrKLwGhRCQCR9ehqXktUhcONPJxLclUrNXpL1Za/FRKY9hwu8R9WHIQGrxn+qLG4JYbgVn0B76xEX9ZV/0tRz1hb9VrU2WJnRauqbcwC3+ria4V9RKS842C4K/eZoI26ze6SibPZNW1agveSyTQGHYA4MKemlMUY1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vb7d6UBq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vb7d6UBq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AAD1F000C4;
	Fri, 16 Oct 2026 17:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792172571;
	bh=gZt44muFQHLUXuHw0c5YUdv07miHy14eDOlNqARy2uU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vb7d6UBq4eLlqXJY570xoGwvLE5IPIYi3Cd2YGlEYB19bNAYMVBM4OiFIOX0/wYC0
	 AMnq0H5IGlYbxPdKWLySoALhoN2Wdb3jPMAELoBmF+1D9AlpBO2VT1XgmezHyLz/LF
	 z7AB5vnuxRLQLGG3e1Petediq1r1LhGzaMu9Fs1Xggb+JanEp/b0X8+Zl1/KuGYuZ9
	 7QK064S0rxnD+3TpanLjfzkmv0Wx/ucSlhS33HTNNdydDsSu/XT0OtkX1e60vH+Pq7
	 xB/8GWv2KedLAnk1GACqDlg4uJULwE1C2ijupndc+UFF3AlefHvJhN9NziASPqGtCG
	 fuTbiRRzImMNw==
Message-ID: <sashiko-outbox-174738@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/17] perf vdso: Fix unlocked __dsos__add() and race
 in __machine__addnew_vdso()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016173106.679725-8-irogers@google.com>
References: <20261013222622.1822619-1-irogers@google.com>
 <20261016173106.679725-1-irogers@google.com>
 <20261016173106.679725-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 17:42:51 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> __machine__addnew_vdso() called __dsos__add(&machine->dsos, dso) without
> holding machine->dsos.lock. Acquire machine->dsos.lock in write mode,
> double-check __dsos__find() to avoid inserting duplicate VDSO entries
> when racing with another thread, and set the long name before calling
> __dsos__add() so it does not attempt to re-acquire machine->dsos.lock.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016173106.6797=
25-1-irogers@google.com?part=3D7

