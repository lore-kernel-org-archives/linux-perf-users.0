Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793392749;
	b=xM16RIvtDkZevTCxePGQ+YMwQJLTPcNm8+o7vIiqL9mfkqOyuhVV2vYOKFP7YGydqtgE
	 0KLBpl6lEDH1HdnAqNwecC3hi3Tz4eSaC06NCokMlF9Ge4SsrXkcTqykfKgptzeylnb7/
	 QicSoToyGA5FpErpzj2U4riOZQdZWiZczbCmtZixuhe0srP3ZIIFCqlo4V2vlR5ywRmcE
	 mTprQi/2r3OUv1/rEOb9iX5pG5Nw3yCC60lPBiEY2dL7CnqKT7cKwo5UceeBqHj0LFLm+
	 g62otWbS5zSv7MmKPzF0+XKYKOrjJUnk6ovwrCO+bNEFxNZ0ELzvJfEOnl+G9djP3cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793392749;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RWjnu+VTUKhbqmCF5HaQdp2daJvV+GDt1a0eWdi712Y=;
	b=nZ6QmFYrd3beFK21GDyMnqY93HCeWwxyBJwfkcIFdU7tc3xSttse0HV6SPzNfZmoenz3
	 u4e0n3UcLCMexQ1X1vSEUNgDwT6XcYBdefkjeaqnCX9pxeb7/Er9CHvtfFyCNIVJFcWRq
	 6AIoI+cWyur3DrJW9CoX96d0jyHOeLnbgFMvxjyfBtqqjYCBiFou89IkWia1xmMTPZlEK
	 BOfAUW6RF6abKjrJ07UhyU9q3LOrRGssVuLn82lot92bLJPF2o/5vE0xBxQvekUdVOMIj
	 vhtkF+Z+clrpLzFW/wkOWAt/2wUU7AMs7jWDE71U2VLNyplvB9hHgojuXC90xB45/Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOMmRw70;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547C7606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hOMmRw70
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37E31F000C1;
	Fri, 30 Oct 2026 20:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793392748;
	bh=RWjnu+VTUKhbqmCF5HaQdp2daJvV+GDt1a0eWdi712Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hOMmRw70ye7YqwyudRrTU8A51LfTE+TkiKG0l37MXPusuC+staFFL4szIdRsUY2zE
	 vGX7eaoKmlR3WMnV4JsLKVAFHXszbsPdoGDDjiCWKIQG+HqmHrWa9wmnCAlSBYdxWB
	 le9GZpH/gWq2ju/+vbGSAPe604eEuLPl4TrAsf+Sco21Cj/T1ORJ+3pPDybE0sGhMB
	 buESXSCvYBRu0bxaS6Xc/E02dr+8DGsYumuSQkOgoP6qtJCo1SsVEb9qnN7bO5UWF0
	 vQHooN0F41jx+IoYgMFOl3ONX3Kefgon0J8E1CdLqv+SO6IwENJf6F/QWGEbH5lxYu
	 lt0V+OK5NE2Dw==
Message-ID: <sashiko-outbox-191487@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/3] bpftool: Prefer zlib-rs over zlib when
 available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030202710.3863806-4-irogers@google.com>
References: <20261030202710.3863806-1-irogers@google.com>
 <20261030202710.3863806-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 20:39:08 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add zlib-rs and zlib to FEATURE_TESTS and FEATURE_DISPLAY in
> tools/bpf/bpftool/Makefile and use feature_rust_lib to configure
> ZLIB_CFLAGS and ZLIB_LIBS when zlib-rs is detected (unless disabled with
> NO_ZLIB_RS=3D1), falling back to -lz.
>=20
> Decompression of kernel configuration (/proc/config.gz) and compressed
> ELF/BTF sections (via libbpf, libelf, and libbfd) processes data that
> benefits from a memory-safe implementation. Preferring zlib-rs over C
> zlib provides memory safety and improved decompression performance while
> keeping bpftool aligned with tools/perf (including sharing libz_rs.a
> when building bootstrap bpftool for perf BPF skeletons).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030202710.3863=
806-1-irogers@google.com?part=3D3

