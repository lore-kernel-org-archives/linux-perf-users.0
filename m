Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F7E54B1C0
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991396; cv=none; b=O9/2MTfQFM1cfynkgEq8QqeMJB4hrRbLLP6qfaUleRBY+qn79vH1Vyr/T9SJHPL4LQpREl9jqPslZqc3z+v9wbG1p6D0jq+s9sw3VsA8Qa2bHH5eTftf+/NYuSbO0f+RGqJvuLv+nWC9LJJenOLwRBQybt1sIEUzjqYVCUBDeOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991396; c=relaxed/simple;
	bh=4aZhc071xu+mDnYGcnyOFb8WZ1gVW17IwSrMqw+dECI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=F4v549unUSkXslaoWrfoCUDmecMPXDMNjOLixZTWOAJyq3A1AaaNHNqGId8HTbLA2lUt0buFhBFfI4kvJrctdNeoJ5X78eNPmCCn7jf/5bEt2TkZQ3e8Y3nDS36sbFOGyR7jjoNaozKvIL8pIz+El1a+3pCe34UneDMZuMyq2XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JS3ZvRjZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JS3ZvRjZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9BB1F000C7;
	Wed, 14 Oct 2026 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791991394;
	bh=4aZhc071xu+mDnYGcnyOFb8WZ1gVW17IwSrMqw+dECI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JS3ZvRjZxB8onqkEXV+HPVBrDJfbgNi78O/lh/zohy9aspGOKjEI2BHxBR5XxNF/g
	 QCgYfswp2QmZDt/QA8nZtdg1xzglhvo77CMlQrRlifwLVU39u1IsOTU8OMq8LWR0K7
	 3CFDQt8coj/K+FQ2i6fUUGEu/eQkEDwn2BFjhhVO8ei78iiKo0+mGtFDorn72Hso61
	 wCe7xe1u6Dc2xFVhgy5HVgl+QCQf7j/z+HYkN4XQR6a30T/ymhfe9zqm1NkeZVHBN+
	 dx/REBK85NbsvUBxJph/z1/BZzSjNFzSluINmZLFueITUydutAV0PMy5LC480NPYvA
	 XYfYBwTNLdZiA==
Message-ID: <sashiko-outbox-171466@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf machine: Don't unwind the arm64 leaf frame
 caller without symbols
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matthew Wood" <thepacketgeek@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261014151326.4142140-1-thepacketgeek@gmail.com>
References: <20261014151326.4142140-1-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 15:23:14 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> On arm64, 'perf record --call-graph fp' also samples LR so that
> thread__resolve_callchain_sample() can recover the leaf function's
> caller, which is missing from the frame pointer chain. It does so via
> get_leaf_frame_caller_aarch64(), which runs a DWARF unwind. The
> unwinder looks up the symbol of every frame it visits, so the first
> lookup in a DSO loads its full symbol table and demangles every symbol
> in it.
>=20
> Commit 02b2705017d2 ("perf callchain: Allow symbols to be optional when
> resolving a callchain") added the symbols argument so that callers which
> only need maps can avoid loading symbols, and passed it down to every
> add_callchain_ip() call. The leaf frame unwind was missed and still runs
> for symbols=3Dfalse, so 'perf inject' on arm64 has been loading symbols it
> doesn't need ever since.
>=20
> [ ... ]
> in the same DSO as the sampled IP or the next frame in the chain, so
> build-id marking loses nothing in practice.
>=20
> Fixes: 02b2705017d2 ("perf callchain: Allow symbols to be optional when r=
esolving a callchain")
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014151326.4142=
140-1-thepacketgeek@gmail.com?part=3D1

