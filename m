Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812699;
	b=RrxGm02knAO00y3Z52uwLZ+A+2al8ojQGNdctukj1R6LwxdcLW5T2D819FBWw0MvYgTm
	 xW91wLgco1SC+vMywrsdfWxrHPlxtKbYCtEfcQbCMuwOliiO18/oZ4WLnheSmfzrBmTZX
	 Z07w5y+9thUuDhpuFTVr4mJdQSKtuoyVx+sO//E3Jq8dGmnE0YLXlsDydml1DnF09y6VR
	 WmCTNNw5/icRaqoJ+Xw7wKrwqZMffIaioaL2AsuVQ98OkKSJh76OvhlSPX5ZH9G0+fQlM
	 hvYAMcp9+RdH4CllNHEIxnZDjDnLNymcwW9poWVIkXeg9GU+6WpfYTyNpWM62vIax4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812699;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WaX+EdpJCgG9POnN6VqcdSLjwX6ht/TQJ9Zl8YM0r0k=;
	b=cLtik+48ReTbRRqRzJWYKapYB7FPXx1+XLJ+wx0t8qH6JFXdDvKXElbGpATL5c4NmMlR
	 JYE/Su0FlhnnHtiB4MOLqk4SjRQcJ6RvdD7ENkpsJ3IR3SM/7ooYnSdWxEu+TbJnLi2iC
	 Jp8PWPah9ZWM078UKq2ecNSLBi3SsI9qzODH6zVQjraswSElNHbtAypEUbT8NuScCX8IH
	 TLrW8xhzyt04C10rVNHjksebyF3sJK4xGMaHwlNPLHmZEoTl0pXSV/j+oatuY9ZVzcils
	 dnbPGSxgYyO3w6SEzjiMGYrmTZZETLI6ZSkVDZskAGoxQDeUyxPK6U4aGL4AAwF+D8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a2jt6G5R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833F3606A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a2jt6G5R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4287C1F000C4;
	Mon, 16 Nov 2026 07:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794812699;
	bh=WaX+EdpJCgG9POnN6VqcdSLjwX6ht/TQJ9Zl8YM0r0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a2jt6G5RILMZ6pI0mZ+cS3WrCPitsdwIuu+Tft37xG7Kfxy5yH8atmM0FzZcavc4S
	 ByLNf0DMkWaNefcHtl4GD6Js9KMLeOjV0EqCAMlf0qiO0fQD25YmOlAt/KGXnXSL25
	 +x1MQm+8ZuJFDZjnQXWQ9Ot1vGMAnWvA89ag4epK1xMxHtBhVaa1ofjq1y3NfzTZYY
	 NHJbWGVL/+M1rGMDewTAV5eDHcDOXKdzLmh8SCRnMKcysJ4C8bTR/2MI3SbbAuyMGt
	 fy3osaFqWucINBf4YDiUpj42W+c61oN099qux/xeQ760VrbiOJX5bzgHTc5EpuBcwM
	 LJgIoCG9Ip8oA==
Message-ID: <sashiko-outbox-216376@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/10] perf jevents: Add --compress=lzma block
 compression backend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116070038.2968725-7-irogers@google.com>
References: <20261116070038.2968725-1-irogers@google.com>
 <20261116070038.2968725-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:04:58 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add an 'lzma' block-indexed string compression backend to jevents.py
> using Python's standard-library lzma module (imported lazily) to
> compress each ~8 KiB string block independently as a raw LZMA2 stream
> (FORMAT_RAW + FILTER_LZMA2, dict_size=3D64 KiB) decoded on demand via
> liblzma's lzma_raw_buffer_decode() in pmu-events-string.c.
>=20
> This provides random-access per-block string decompression indexed by
> (block_id << 16) | sub_offset on builds where liblzma is enabled without
> libzstd or zlib. On x86, --compress=3Dlzma shrinks pmu-events-string.o
> from ~6.90 MB to ~819 KB.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116070038.2968=
725-1-irogers@google.com?part=3D6

