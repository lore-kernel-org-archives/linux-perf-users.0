Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601916;
	b=RxjMbcOFtvGijcGvpVYufVAkACNtE9pq4KKyEqP/gjSPgTWZX9g7voX9RjmFGeN3wkX7
	 D88GLiBJ02T8YykSzUks3NARVtFkLhy6UU5zsk32lFmu7yxEMiJAcRAZEL7QDgyn+DH74
	 nxaIjWkbChVXlvuV6SFZeUPWGsN4b0vcxdoXJvu9DLZ4/7NvYdUgtpkGO7MXYCuC4nlyd
	 Ep6n0VGwpSjqgQEiSaWU60YM0KunOi69eXuWIzwp7E2istLOkkFGy8a/sRPXhNKCkaepI
	 SUCjv4HK1zIUZCUVe357sAAnerX6QW1YsNf/OK6ph3CKJcaW56PjQiE77/VoFvUIX1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601916;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6y6pKt19ltNrwVtcnq0ZLbmKrCLnodN6C2WwWVF3PDs=;
	b=Ottmtdk/rganUMPBLfxllYH7I4/Baf7N5Y+NVhaNNwT4YfkfmqsNnAzT6s/ng1pCB2lC
	 XEyVPRqpn+Z9YGWLBP+kvIyHLF11H0WgNfX0y7WHQC0xBxz8GlbUOT+Gs+SdgamNhLbSL
	 MfJrhZWoIHkEhDGncnslsQDz37QQedOApyIRNW3nWWlPl16r3k6fTj+p3WKVnMIvd5/MW
	 Kko1iyfxxYBiAxGnPCO/B1K4ysGW2jU4VshcXDQXfG3O0TunRxRGyv0gwdHhPnfxFH6wp
	 7HAaEiC981pE60Q5zXAU1cY+PB3tmW3R6+j/WscRmCZ2ZjSZ6F3ATr9HvWeCzyNEsGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZPzWqF5J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB944606A327
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZPzWqF5J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D511F000C4;
	Fri, 13 Nov 2026 20:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794601916;
	bh=6y6pKt19ltNrwVtcnq0ZLbmKrCLnodN6C2WwWVF3PDs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZPzWqF5J7NZQonki3dnFyquD2QCZzzIAUdhDfzxt6N6ys+/vrwn9Qmo4tj2pAmFwF
	 +yuBrpi8ftF4Mu7Q8cf/QT+6+SrWuWziMU9s++80JQCR3JXA1z3QtiMGKJiH7P3xHr
	 nA9PBlXk9PXemdrPemZ319ZrYptPLarv7dV9tlCznkQJHAFez60/5v5B594Ordy0Sr
	 SLh21jVzGBsrCyXWfN3qrS8m2KsT8VRr73Jxry6GD7kxjI0H3xj0Ak8WhJ/UqV71j+
	 3YhGOb8S5JkbKdC859ZEhyzxxOsJoLfctZR4raFkAYTRljSKpSgVM5rqrlDJy9mr5O
	 Erx6+LpCrOBeg==
Message-ID: <sashiko-outbox-213647@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/11] perf annotate-data: Resolve DW_OP_addrx global
 variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113200850.2803460-3-acme@kernel.org>
References: <20261113200850.2803460-1-acme@kernel.org>
 <20261113200850.2803460-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:31:56 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113200850.2803=
460-1-acme@kernel.org?part=3D2

