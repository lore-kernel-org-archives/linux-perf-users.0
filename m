Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AA145EF5D
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189540; cv=none; b=jI3Lkigtw22CBbA66B+4T36rr5DMmQZy8N0Z5GNYKrNeBH9bgHaefJuBb4TLx8EnFMDaBdMOJfowZUi06noqr8o2WI9+BO15A5BBochdmfx9atvcJDZJav3x8UE6M3lZW9JujRDoVDvrvkuj7nuhwDG9QZbRKp9wr1J9N4zZMq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189540; c=relaxed/simple;
	bh=6QnbegW6YOVJSyit0Jvg+lI0KoF/AKNEasOA3kVmaPQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hbTLUEgPa215qhS56KvFZmHlkCZOFalffjzBEicjWQHk3JsV9LmIgPiKiAsCBuOHiLfSy5B7oiPWpoQDFksbKlmvYjWiEQ+xczD+hkt7Nc0uu3jLPU16K2Zr4G7anoUpNsFEDk3lsYv/trdaK8nzwLN+N5NAsk5aeqRVC5ZmH4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nr5Umiu1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nr5Umiu1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823011F000C4;
	Fri, 16 Oct 2026 22:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792189537;
	bh=6QnbegW6YOVJSyit0Jvg+lI0KoF/AKNEasOA3kVmaPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nr5Umiu15i0GMGqT+UFx9QbRgSEBw6pnkfMmhjhR3XnMnCE0B6C96mMSDC6mTKiSm
	 N1VUdKsZIWWTMkpf9zsWNUS64HG/OTY3wHfBBf4TaSR45p6ndeyu+nFlrR4HHX87mW
	 PcBX3tp7TpnAyEWzzbu4y1ualhUhN0xdqjuYMxZDw9iL4ay0o9CmM9muBFTUn3vsC/
	 GW0hmdfx0iJK35/tLkh3l4g2PyoA4gezFmSggml4xmJWBL1EBXST4iPJscm4ufmFiU
	 uk31/ZgksKtnJGfujvf6kca/ce4J04dwEszfuVyCkX3bB94sB+owCw2tGjCzkD3crw
	 yRPkltfpVl1ow==
Message-ID: <sashiko-outbox-175018@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/17] perf dso: Pass dso_data to close_data_fd() and
 dso__list_del()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016221700.1282659-9-irogers@google.com>
References: <20261016173106.679725-1-irogers@google.com>
 <20261016221700.1282659-1-irogers@google.com>
 <20261016221700.1282659-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 22:25:37 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> close_data_fd() and dso__list_del() only operate on struct dso_data
> fields, while close_first_dso() retrieves a struct dso_data * from
> dso__data_open. Pass struct dso_data * directly to close_data_fd() and
> dso__list_del() so close_first_dso() does not need to recover a
> struct dso * from struct dso_data *.
>=20
> This removes the REFCNT_CHECKING dso pointer from struct dso_data and
> avoids dropping _dso__data_open_lock in dso__list_del() to call
> dso__put(), preventing lock-order inversions and races during EMFILE
> eviction.
>=20
> Also place the DSO loaded in addr_filter__resolve_syms() into a dsos
> collection so dso__dsos(dso) is populated when dso__data_file_size()
> opens the DSO.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016221700.1282=
659-1-irogers@google.com?part=3D8

