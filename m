Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795300369;
	b=jGgrWD/0HaWY9hu5CGQK8GV8nAcwK0T6MwuepLQ9PUHPrnHL7cgEOQ7aLPEi7kYVguqw
	 ug/2WHWIaYz5MrUKCbf+/5rKa7eN3ZTtE1YCQCOkGpKeraI2s+PXdlzUf46v4i0cTes6c
	 dQWkxahLnkOZ5sKvkRgVY4YiuCtPYfjX/OVR6fjXSSoxyQNCjVlI8yLuki/hL9nQh+DJQ
	 zzdhukTDOhIg5tHlGENSd2kQr8rnkw+paA8N7hBAPqM5o8ZQxl/46O10TcaNYxULc748N
	 3NZ0TSeaCCoZAEXsH8chqpTERm/Iuh2akU7IGjA+0HakTIXc96bCDTIcbGu5e2HWJtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300369;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2p3fxxUduJLX9v4TnCIrnQNs0Jl6cDAG8d839SlxoLo=;
	b=B1ldkS3TfrbH+mzHbCA1pkRjDwWRjPiRpRXBE2WRhQWX3H+OuZm2/V4jiX3TGf01o0v/
	 9G/FFaq3jmNJLSmGjlmPlNMI0/MHl8TTsaYv318IoHHZ3fV0iDOpkZaGXEZvjHYBe9PCn
	 UeCyg+15hgZxsjy5Nff74ltNC0S76PTdB8DiwVQT0PYvI/0Z+Yad/cST77eg+EcCKRaWk
	 Ekm/jaz/1iw3t5lu85X+JoafdJXHls8aNMkQcHoJdXYKqE4tSrT+WZ0gQd664/DloCjf7
	 ifD168LNV+fcwp7xb/+rn4QUAQpGBk/SqdgX8BlQ0bcEEvr+je9m64z8yLbBfFWiXxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3vbxt3P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94564606A320
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 22:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3vbxt3P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B781F000C4;
	Sat, 21 Nov 2026 22:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795300369;
	bh=2p3fxxUduJLX9v4TnCIrnQNs0Jl6cDAG8d839SlxoLo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j3vbxt3PKbybDEbHERmlYbpaaFCKi1eJapPCiCikoBJyPBsH/8mrA82gX8WnjnspI
	 8CgQVxvrRQ5Ij4bXjWeS7fRVzKxzREPZ3LHkkWw6X4c/30PkygKT+U2W51u7tddPTB
	 vMRMlMnO5nak7uGTO4Q2VGbqSmk8mUuWZpp2/aaO/ZcNTD9q+8wEkl7E+UI5vWmT0M
	 o5b+NLbXKkDqRvN3+h5ZKmZzO3FE7GyPhHF9QuPgAYgyaeqT8zGi2mv0jZ76pKXVbS
	 Wbvak7v4Mn3HmUaNLCM2s8bFHOoLCros7kvRxSrto+8DHonFHZA9tgxuaua1Ifm+OJ
	 IBsnQATFglFsA==
Message-ID: <sashiko-outbox-227446@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf dso: Stay in perf's mount namespace for cached
 debuginfo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261121-perf-dso-ns-fix-v1-1-897322ddadf8@uber.com>
References: <20261121-perf-dso-ns-fix-v1-1-897322ddadf8@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 22:32:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Alireza Haghdoost <haghdoost@uber.com>
>=20
> When perf reads the data of a DSO that belongs to a process in another
> mount namespace, open_dso() enters that namespace to open the file. It
> does not do this for files in perf's own build-id cache, but it only
> checks for DSO_BINARY_TYPE__BUILD_ID_CACHE.
>=20
> Cached debuginfo files (DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO) are
> in the same build-id cache, yet open_dso() looks for them in the
> target's namespace. The file is usually not there, so for example
> perf script -F +insn prints no instruction bytes. If a file with the
> same path does exist there, perf reads the wrong file.
>=20
> This patch skips the namespace switch for both build-id cache types, as
> dso__load() already does.
>=20
> Fixes: 5363c306787c ("perf symbol: Set binary_type of dso when loading")
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-perf-dso-n=
s-fix-v1-1-897322ddadf8@uber.com?part=3D1
