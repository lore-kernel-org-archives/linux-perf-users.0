Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603229;
	b=hRFTc8L2nXHPugzACgl3aavCR5jUNMWzLo6OndvetpwwMkKNDeocwrSS9K+3M/2zcFUh
	 0XLSVNDGK0TzlSCq8jvPg0VwQgQF467O1iq08BqShVaRz6S/2YqXCgCBeJ9ZVR8cbpKPW
	 9a7L0HRDJu3QNuUpMK22mEx7mpD/p4LBrff5JCSQktgxrGV9Fsr2UmWH5zLjvY7onR8OT
	 YKUuU7E63ss/KwO3+NvvHM2HHnV2mnF9PDkyWDYwxp1TfDV3NCUHIgfHZJY2FL1tdyqCC
	 PVv2DrIutDalKFNy6uWWWkDVnrIo1imVlzNEwMCTKwPlg0IFbzGixyaHuFXxSNgPUqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603229;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yVcfUkVeW3F//kAR2JHr4RRqgXcuoiz3I7+5dYfTAKg=;
	b=nKRJ7nl/GjD+HcTx5mTKIpD3RuIGX85XWYapdUhFduZMfKJ0aIDtNfuZh5+xJxCg2G0Z
	 a1YmN3+0l3XXNbjuUL9m3Ivj66tMkjH/nfO4j2/xaMIWi5hpgNcIwu6KVQuVCr1recc0O
	 qF/hS2A9jF5cJ9jHOJ2mJkxOIDTwsG+X4eCXaKzSlZqXPs4x2pqIv915tZLzo0gIq/URJ
	 jWeeBISsIBhWI/vAhiEXj8WArSZfW51+1oaa93waNq3o+h9TBWiBVAtfNTBiiOAKBUBDD
	 lyYPFQv8d3xcGbH0nCPamtDdMjtnfwaTrwgKbspwYHP9F1rjo6YftfP4vBiEIJYZpbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mfNcoqT6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193B6606A31A
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mfNcoqT6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DB51F000C5;
	Wed, 21 Oct 2026 17:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792603228;
	bh=yVcfUkVeW3F//kAR2JHr4RRqgXcuoiz3I7+5dYfTAKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mfNcoqT6dDYsXDZDd+eFck1v1eYdKgiWwcpIufpf2GC8cqhk0ZXdWaK2HWHc5n9xq
	 41bq8f3/UdVNM2pnBfW0HgSLOxUG1Z0XqcEto+4i9dx+LCre1W9ZFno5uS+iWfHUx8
	 jkCbT+/6hC3Zcb8SHvY+xhljC0iumM13Zu86xWQ4lS4cZ3BgQALZs0TUtp7tyV8zJu
	 IJnkkWiYTQzrejgD7NfJrh/OKDr5PI+WnjCdt1Tg6+K8/LqqZ4cEaHeWOf0YZfzIfu
	 LNzJb+WeJObJwyxr6Qem6SZCZiZsKdij81bAw52vF7Wiw9upVHh2LcL1bq7Un7KCj4
	 rHhue7fCgfl3Q==
Message-ID: <sashiko-outbox-180512@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/17] perf dso: Pass dso_data to close_data_fd() and
 dso__list_del()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021171044.155240-9-irogers@google.com>
References: <20261020163640.746159-1-irogers@google.com>
 <20261021171044.155240-1-irogers@google.com>
 <20261021171044.155240-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 17:20:28 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021171044.1552=
40-1-irogers@google.com?part=3D8

