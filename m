Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC9A2F83A2
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Oct 2026 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222256; cv=none; b=ujOjjNQxA6QBgZRtEZHmtO3ni2/ldouRnawTMi1YIZJ2JhAIIr0NuoACUN4mUjJX+orOXU++bitlzIPFUVznDYrPoJhxhugqG6vc4KM3eFMojVjVN9K8JaOhAOJ/zHXB1tUItj9ZiCH8UGx1n0fu+7OlOg/1ATABdtjrB+6HbZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222256; c=relaxed/simple;
	bh=A/EGoujZITJ0403WoC0Cq6qnIixjcekWRNf94MpUVkU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Li6ShHYMm4rryMQrhfbfyvH2WJJskxNGh1YUBQDnZ52aArOKHiWp/2BWjWVthagcEEa7AVxj6psmiFpJrJ3skNwFb6lRu2GTJ7Je+U+V8I8r8luub1zjJRXlTbjsnY/uvOEnTUPgneAtIGmWHCxpKbHeZftM8MbKkuKoIP3MfSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQe/1W8N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQe/1W8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930CE1F000FF;
	Mon,  5 Oct 2026 17:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791222254;
	bh=A/EGoujZITJ0403WoC0Cq6qnIixjcekWRNf94MpUVkU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kQe/1W8NiHpvS5rd2ktunVQEhMS6qttg35uskqriN+CEdWdJ/pDL5v7HYGPBaTx19
	 qECtPYyfX7QXFD2S311s+BW60LcZrtZqFXEv6kBg+j4g9/9EhuA/4xpJaXulfT75Re
	 BPYark07RoS7hg6Q1YeWkMa7f3VvJna+2td82KfLsxSlu8ax7I3ZuHhity7Q5uDDxb
	 dlXlkm2L4SPOlRQ2t3V4eo0nqn3XKnDyHFO9ZARpqYZnihxMUmHQY7KZc+QEt2nAJV
	 xm3yE/MITQtfSatGrQHmby3Oav8RHthv8W3BGq6Vxl3vxPy7Kp+tcgk98YBQo9ioAp
	 E65ClWfpI7lpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/5] perf script: Add --lazy-load-symbols for lazy
 symbol loading
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261005-perf-symbol-memory-send-v5-4-165dceb2b049@uber.com>
References: <20261005-perf-symbol-memory-send-v5-0-165dceb2b049@uber.com>
 <20261005-perf-symbol-memory-send-v5-4-165dceb2b049@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 17:44:14 +0000
Message-Id: <20261005174414.930CE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Alireza Haghdoost <haghdoost@uber.com>
>=20
> perf script eagerly materializes eligible symbols from every DSO
> encountered in samples and keeps them in an rb-tree until exit.
> Most of those symbols are never sampled. On a large profile this
> turns symbol loading into the main memory cost of perf script, and in a
> memory-constrained cgroup into an OOM kill.
>=20
> This patch adds --lazy-load-symbols for userspace ELF DSOs. It builds a
> compact address-sorted index and materializes ordinary struct symbols on
> demand. Names are read and demangled from the exact ELF source through
> the existing DSO data cache; resolved symbols are then inserted into the
> DSO's existing rb-tree.
>=20
> struct symbol is unchanged. Each index entry holds only the address range,
> [ ... ]
> entire lazy index and detaches it from the DSO. A detached index remains
> alive until its last reader finishes, ensuring that no symbols are added
> after the name-sorted array is built.
>=20
> Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-perf-symbo=
l-memory-send-v5-0-165dceb2b049@uber.com?part=3D4

