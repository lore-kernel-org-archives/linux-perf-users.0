Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582692;
	b=jTzFqdDrC5W9wZfoBdZUo3feEBrR9uvE6hSy2DTtNjeoKz9EblalCLUB+IEEpLMj3diK
	 dTUMkgBxeU+dW5Sst5XJ98HKjP2xctSSGHgZH4ngvB6qnG2oKfi3Mup7nRwG3H6gVeT8j
	 HYfQaq8KNcTumUAR1VLZUiCeZ4GLQzzhhglUv1sS0cOq4DROcqigjO8AByYxY3/4n/3Nf
	 f0IRHqlidkchhw6WS9h8pOQZT2S9TUnqneEe8PDbaPscoKtKpYfuTE1jBwvWyzss0+V93
	 zpEID5GCSEOI5znOyfuV2g94Q/lYYRBLCZTMz3M/w2DIckz+7QRgOWNdy2BZVTx7Mhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582692;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TtXvpb2DbLcHcKMh9wZ3VEZULOnohjbmHGHE8ymY+t0=;
	b=QemhEzErv2KNrVPVpbkVDTF7WRlVdFWGDhZ6VJCPaKTu2K9hsUnhAU8EgMlXcPhBYvl4
	 1LL17DUHok/cbwOMzA/g+CVtA9LMO8tk0Zy6WfRscmEKj5PiwtB4xW1WV/YMf33pwTFOz
	 tw1vlbi3cVoKU3vltfFUYUCz0MOduBFUcKaHWt+71DwNFpy/ZGdpNyiP5G5Ex5H9Vtr9d
	 tc5B4J9gPF9m6F3TX4GB9n7hr2Pk8u0t/6AbVakJP/ctJTrA3X+XkpLnI9WE8dBiewDrB
	 BlyJQ+M9ytOLmHtQGtt+rIU/1Ztm9nIhODZU6YENw9pTmzKAuuoq6ZJ5Vucnt5x+ExA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQoC0OQt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DF8606A32D
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RQoC0OQt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB271F000C4;
	Fri, 13 Nov 2026 15:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582692;
	bh=TtXvpb2DbLcHcKMh9wZ3VEZULOnohjbmHGHE8ymY+t0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RQoC0OQtViiUvYt68EwvKZ6wapS2/5ex/fFSMIGlvzFH03pqkz0guciaQjuF50aJy
	 9JRKDWhjhhI79tfPv3KZB3kBFv1Fv0PWaNMa7X5rUG53FJqKC9fgaIgCMRcM14rigc
	 nwPF/WjkWAD5nntEQuualTBn9epX3AuTfCMZYsxenmKwVC2JKKy/WRQmWyOpNVPFve
	 aNYAZfhOlWvGmoIRpyIg+BKKhEwBUD/H/r3ANQ4tiMxavXiEQVFwqhR8b2SOKEB/AC
	 uSqoMY5HeFniRTTM5Dkc2jT1QA6wfujAzIBI4wCiJhqeTh5qgsgjKptaNLkFamv/zU
	 79oC+7hcML5Bw==
Message-ID: <sashiko-outbox-213061@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 09/12] perf cs-etm: Fall back to the recorded
 instruction size on a failed read
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113150555.1163049-10-acme@kernel.org>
References: <20261113150555.1163049-1-acme@kernel.org>
 <20261113150555.1163049-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:11:31 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> cs_etm__t32_instr_size() reads the instruction bytes from the traced
> program's memory to tell a 16-bit from a 32-bit T32 instruction, but it
> ignores cs_etm__frontend_mem_access() failing, which happens when the
> DSO or its debug data is missing, and then reads the uninitialized
> buffer.  GCC 16 warns about it and build-test fails with -Werror.
>=20
> Use the instruction size recorded by the decoder, as the A32/A64 path
> already does, when the read doesn't return the full two bytes.
>=20
> Fixes: a7ee4d625ede4f62 ("perf cs-etm: Support for ARM A32/T32 instructio=
n sets in CoreSight trace")
> Cc: James Clark <james.clark@linaro.org>
> Cc: Leo Yan <leo.yan@arm.com>
> Cc: Mike Leach <mike.leach@arm.com>
> Cc: Robert Walker <robert.walker@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113150555.1163=
049-1-acme@kernel.org?part=3D9

