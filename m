Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603311;
	b=Er9wCm6P2j1tlEv5RbBr42WF2rhhP5/9sl8gPt+rIRYkNqjyJFLgvHE0i6KQgzZf62Lt
	 kBSj2PwbmQ5CDMrk2FZRQTBXTO60fwrtItVM/0V21AsoXY0sQDbQoeJUJQ8hEtj4QQtHe
	 EgVu+IyIchHjkc0a1A3gfi3pyXgby7oASVDJfjroTpHJjTZSC4XEPqkaK0M0edQG8c2H4
	 Ojx6Ib+shz5kaq6TJCON1zZo3tnUvNUvRvqOfvot6BFy98ZCV2SvxXzJT690DAsRV2NrJ
	 umU8afITCZbRjlMjgwLpPEn66gcKiZ86NdiHLDKfjJBYhbLKD6KP/g50fxauUQ30U1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603311;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3ewTZtglaSHXXENQafu7KoAVGU9DLhlXV+6p8EfjeIc=;
	b=d35IeB2owmn40MekdUOKWQboo7zl629BeFKRQESCmOE7tQhf6+1essmcFcOWUceCOj2F
	 vu7pE7PeMlkOHGiR2dZruR3uHA5hw8dp8HWcIfmvZ+xrR+3ZZaJyFvX546uPNwHYTAWNU
	 QE3pF5RmL6PLkgSdjvsUKL94fmHWfiIFve8FqtXlYCEOagvhPJuhZlhqqjuMH2SKD8nf2
	 10Rj+QoBeX0TJTopTRBjGob26u9/Cprp8PFYNVzHjbmbgOlZXNatrMnrJKpDm3cEJYlOp
	 fH9ACf/OnZ1RSFjclATcKGLwxsmg2HosQdjQxlkADQdnatxJRfvhgucftrTs+gflCMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fr19PbyT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2558F606A31B
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fr19PbyT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8291A1F000C1;
	Wed, 21 Oct 2026 17:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792603310;
	bh=3ewTZtglaSHXXENQafu7KoAVGU9DLhlXV+6p8EfjeIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fr19PbyTi8uVxOQTxdMEijNU+UlJ8EUfgbdirZlYAcClfRXBsqITTwNz6pmkyTZUZ
	 u/gFhUmN7JxPTkVAcm9C+/ddWizzU3aKBIzX9XhJk2Mh324KxxWq4oZJHhAbUhcpWN
	 04+08ZU/TgOluAFyBUhKeAqtsLRlg+/a17L+xW9205lvkGzfopNuPr5x9kyn5h7mCR
	 2fSSkYStouWcgsyxQvyaRpn/CLLKVFA6tWi0CctNHbhpXXig14NDNAuNStfoJJBd8q
	 U9pZUGmrc11N4TcS+mkflKw5kpFk7+IE0WibTOLN6WpbGwaeUq7sIg0iYrM28jbHpH
	 1PdZNWDoWmu0A==
Message-ID: <sashiko-outbox-180518@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/17] perf vdso: Fix unlocked __dsos__add() and race
 in __machine__addnew_vdso()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021171044.155240-8-irogers@google.com>
References: <20261020163640.746159-1-irogers@google.com>
 <20261021171044.155240-1-irogers@google.com>
 <20261021171044.155240-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 17:21:50 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> __machine__addnew_vdso() called __dsos__add(&machine->dsos, dso) without
> holding machine->dsos.lock, and machine__findnew_vdso() and
> __machine__findnew_compat() initialized machine->vdso_info and created
> temporary VDSO files without synchronization. Acquire
> machine->dsos.lock in write mode across machine->vdso_info
> initialization, duplicate checking via __dsos__find(), temporary file
> creation, dso__set_long_name(), and __dsos__add().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021171044.1552=
40-1-irogers@google.com?part=3D7

