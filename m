Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349216;
	b=5IGP4n1UjYpQXcrVrhxTT8BqJrJPN0X3jwROtfB/EuH+W1e0ae5BFxa5HZvYroJwKIHA
	 /XgrqgR4Yo2ruM6FpI8631780WC4yg+XwtkeEWYCVl1UYkPJ8R1nCmQTLDQhB1Qjlk/d6
	 2AARtunexqDsYV6nD2zetqjmwAJVZkgy+N5LLjZgi+fcFiUOKtJcw8+Y3qlM1cDZxmWRC
	 sWMV2lQohFgoc/Z0OuYPn67Vhhi9D3yTfUCdRP778tNLvmWN7c6OH6mA+uVAcmT0WUcmZ
	 NKIoLHEB+cxHCBEyBab47KrTgCp6CXV+jWZNkM0pZFLz6l1uPyQpz9un3X7GD3HknIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349216;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CpeNhdOvXCXcX3jC9PEOTg1Z27GWnQPZGLMEO2LxfB4=;
	b=lDClC6EpwsKbIx0ImH19JYU2SeGRiOEND1sdCDLbxrRkHdAoyAKPnA3fL60w03obQMiR
	 lijzPA4Z94CGxuy2E+aLHezYIojG3q2LvS54TDqvwLlwV/z+LgUwobJP06vksRT6hq50D
	 A46/xOCP560i0gfU2qrtPDIhMkYGDjovKES8+TpDK0PdInGTQNskRnp2z6zEu2f6QBOlV
	 OQ3VE6ifPSJGGH5QjCq4M7R44/7nYUVP2iHG+Xlr9A8HBHPtYdTCcMTsOT+EfGDuEv+Jo
	 00DgkVVDlMnxUZGmPwwX9TsLOcIFUNbJ9SFne1Q74qrLAN1XKJn6OV3+Wsq2DewM4Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GBgyHwDe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1B3606A320
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GBgyHwDe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF26D1F008A2;
	Tue, 10 Nov 2026 22:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794349216;
	bh=CpeNhdOvXCXcX3jC9PEOTg1Z27GWnQPZGLMEO2LxfB4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GBgyHwDeMZn4FnmTcAxNAtSGUbDSqeTREifTsn91uxBG3fnw571SIdSPqYJ9j2w9v
	 P7HjWaY/rGDIq8MxzCTJcl3rNGB3N2R4zuyT08cbbmGDRXpWyJwxny3Uikz7x/gY04
	 V3fo+iIafTCI0zL1CDnNTSTGa3WhMcSsqxDla1iJlWvfHin/cTDizHclcAKUjG9kvQ
	 tQOeKpu16MxCfHr3pDYcLB8FoBk5BLgqEtKe6bvocE+YFHCmIxlyZYQFa1Wph+A0Rd
	 nhoofsaw6MvuaXAClf6DdB6bbOzBQYhXDowY09ivYqwRp7qXBtDnmEH4x7AMV4wdXZ
	 yTYBWAm/GsBaA==
Message-ID: <sashiko-outbox-207818@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/20] perf call-path: Use struct dso_symbol to
 retain symbol DSO lifetimes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110220803.2503416-7-irogers@google.com>
References: <20261027231513.816148-1-irogers@google.com>
 <20261110220803.2503416-1-irogers@google.com>
 <20261110220803.2503416-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:20:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> struct call_path stores resolved function symbols for the lifetime of a
> call_path_root (in thread-stack call/return processing and db-export)
> without holding a map reference. Similarly, Python callchain frames and
> nodes store resolved symbols across Python object lifetimes.
>=20
> Replace bare struct symbol * fields in struct call_path,
> struct pyrf_callchain_frame, and struct pyrf_callchain_node with
> struct dso_symbol so that each retained symbol pins its owning
> struct dso until call_path_root__free() or Python deallocation. In
> python.c, this also avoids duplicating symbol names for call_path frames
> and allows pyrf_callchain_node__get_dso() to report the DSO of resolved
> call_path symbols whose ip was zeroed.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110220803.2503=
416-1-irogers@google.com?part=3D6

