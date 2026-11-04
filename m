Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827331;
	b=kchRCWskvtyd+D5wwFWwwkBQ2SlVg4SUSzfwmWe/wQLSJoIVBWijaU5aGtEfMFavXsdj
	 NtVAdWckMBch9/kI1HrhQbhuiyDLzKe6pEdQL0tbn6JN/gSx4AMJsR/sFf5kbwau4PVO2
	 mxdvqVlc0id4kwR3bG+S1W3VqUu3Csjj/5qROdjvk+vTbJWcgXQ1LVd6sNnMWvztTnZOh
	 QbELWHGCP1/7OfwxZBQrLMNPOJgSQuvIQDZS/9eLvBciLuLs/NLwaZGrE2M2SYlxLmb7i
	 fI2u6ljxt+TU30hNLGPJDDmEnPW0bbQ3y08h7GCz5w8kefaBYNcIXRy9iL7rJfS4DBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827331;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EhL/HFwObYtS0C+LwsM3V4vcAMRWlPWoEbpLxcCgR3Q=;
	b=jC18YUGkDKql3IIxuEZW99eyDptu8xpLfndUI6lnu7nnABJJ5f1rRX0XvpUW6Pkr6dOk
	 WzAzhhJJ2vrVuoA8rqIULE3yzU37iRXk7K4wXP6vwYfkOu+Zh4tSTP4/XyHiiBMDnTZqB
	 wdJOPhWqpkCOU6xdMDQW5F1H3mLDZ1yDCFfEyzfs78FQEIe28MyPQm2jepySdwHlQYy4T
	 HhkeAinyY6te4+aYPydHQz9r31nCx6Hzzr2MD3lzAuaZ/tdatvcPg//7FIyhx5SuCLVZh
	 k0dV70REjHoMS/GlJBd+0GnI1577voPN0qhFR6heV7Xe8fBx95YXztriXT4nUPF8swg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kiEKEp6o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626AC606AC03
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 21:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kiEKEp6o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7381F000C1;
	Wed,  4 Nov 2026 21:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793827331;
	bh=EhL/HFwObYtS0C+LwsM3V4vcAMRWlPWoEbpLxcCgR3Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kiEKEp6oaNBbn03okPrubjXX8rMnDpnP97ZcGQldHQI7Byitv2QRy7BAiL+qYXdnq
	 JFrUlioXAgom98mrxHe+YQSS0QMj4Q18CAjlYV1EgPVzYCRggWAE0MQ4bHcF0lRU55
	 7N4ZM/KX5JgktCy+hA+yUN4mBrcRAzH7FSNvI5C9X9MOpMtGfSLeHpk6XzQG1dWTi7
	 h99v9Y1nL6RXghLy5V48CHHuWCwXuT6EmFmYxd5It7lLL6RJkPjpWzsrG9yjSuLnKz
	 hvR+jyp74N9kMyleSCElODFSwetqBiyZt2RrlL7vuZTKRzzOYttErqEZla8cslwLWb
	 U9dsbw8f6Gqng==
Message-ID: <sashiko-outbox-198107@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/19] perf dsos: Skip BPF and OOL DSOs in
 dsos__find_kernel_dso()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261104205909.2078411-9-irogers@google.com>
References: <20261104205909.2078411-1-irogers@google.com>
 <20261104205909.2078411-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:22:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In machine__process_ksymbol_register(), set the binary type of non-OOL
> ksymbol DSOs to DSO_BINARY_TYPE__BPF_IMAGE (which
> machine__process_bpf_event_load() upgrades to
> DSO_BINARY_TYPE__BPF_PROG_INFO on PERF_BPF_EVENT_PROG_LOAD), and update
> dsos__find_kernel_dso_cb() to skip DSO_BINARY_TYPE__BPF_PROG_INFO,
> DSO_BINARY_TYPE__BPF_IMAGE, and DSO_BINARY_TYPE__OOL so that
> dsos__find_kernel_dso() does not match ksymbol DSOs in machine->dsos.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104205909.2078=
411-1-irogers@google.com?part=3D8

