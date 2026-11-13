Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582846;
	b=oxDRD3mNYGXR1q8e3TyTWg+Su4RlKiF277E29yskvSzveHOGOJtfQmynASf12LIYkyOo
	 3E+9k0KwFKE/aCGi036iewk46QR18YNTWwIByk5PR81FR4IfeumEZ+myFTMsumS9LtodO
	 VydtJ9PQN5ucs0ZqJ1wxFrhTQW/Yb99F3OF0t/qofU/3qq4tZRzFwjYjTOcw4M8VC5twB
	 MEh2b4rdTfYO6OGpeBKlHLQRnTQF/3F7AHB/VL1k5AnPU4nLjB5i5IS24e0Mulw/34Zp8
	 GN5iDx9lyUj9cps37YubRlcjSRuR/5ZTx7rYvyOZfO/7axUh9/zk8X0gK24r451CWDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582846;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=akdCsRz0NO8BPeSWn92PrHS3vRYTS1it9anrnW0Nxsk=;
	b=ZJG7/4XOKb2kyIl/hzX3e8vjIzuGrfKGrsL0TLa8VmxGF03J4TGOdtkjtqzIYjyIDNRf
	 P4RP/a10FO+aNw9HdRxAdsbxaP/CNLkJIaorU2k56cE1gkReQtgkwUmSsr1E62WHyepJ8
	 CbSEODLGK5wdA5T2lTS8NSZQANuFcb4c7MK6BwwludgVopaVdtDOQ3gdOgOvPQZ0O5lHK
	 FeT9HlGoAB++PUU3qQ2XRhsZHwDsVdIqd0RdwZGRStVgn9np+1juOuLL/b+BIItIb6zdo
	 0ESPU6sAiWGx1uytmEXK8Ie5QnG/bMXVSN7zbqArwPHuGjGH8zjC3pS6oHQXj4i8F3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8qIE+D5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10EA606A327
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8qIE+D5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC721F000C4;
	Fri, 13 Nov 2026 15:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582846;
	bh=akdCsRz0NO8BPeSWn92PrHS3vRYTS1it9anrnW0Nxsk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i8qIE+D51YTSXvWGaR7LqkBA3zaD63kEmgxkxsbfXh0gFAeiIsd7cQgYTs5XQRFZd
	 /Z0WQu5JyW/KFFRXLcq5ddEFZ4EyKvp75heW/Z1q+O5n49UKKG14Kz6cW4A81+hjPR
	 YIIsqyYdI/RzhTFH5nK01x9SDCvgX3Z19jYWe0Cd3y2EzieS5lQb6YAp2YfHbWTxkI
	 p2+QjeVsF23M3U144ySa9ZikndZokbTleSVz8oun6hUd1L+RPzISVRYF1MLDfdmiQH
	 P2od5XqdEzUTtH202IYHhkmRmZ1OcPN/4Gf/Gw3Z99McysH3VwvNO4Ua3mNvU5CzAv
	 6ouKIy19pWYKQ==
Message-ID: <sashiko-outbox-213067@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 02/12] perf annotate-data: Resolve DW_OP_addrx global
 variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113150555.1163049-3-acme@kernel.org>
References: <20261113150555.1163049-1-acme@kernel.org>
 <20261113150555.1163049-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:14:06 +0000
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
> clang emits DW_AT_location with DW_OP_addrx for global variables in
> DWARF 5, gcc emits DW_OP_addr.  The address index was not resolved, so
> those variables were not found by address; the by-name fallback also
> missed the ones in .bss past the file backed end of the last segment.
>=20
> Resolve the index with dwarf_getlocation_attr() + dwarf_formaddr() and
> use the resulting address in the by-address lookup and in the global
> variable cache.  Add a test that compiles the workload with clang
> -gdwarf-5 and checks that the global is annotated.
>=20
> Fixes: d60469d7c0e5c4e8 ("perf dwarf-aux: Add die_find_variable_by_addr()=
")
> Fixes: d7b60803a790b716 ("perf dwarf-aux: Add die_collect_global_vars()")
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113150555.1163=
049-1-acme@kernel.org?part=3D2

