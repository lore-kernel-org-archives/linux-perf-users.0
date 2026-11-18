Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795041725;
	b=Ckan4/kOZt4Bw5m4XgKZwC1Q90Drb2IPrHjM1wLNb5xTf2EMxQ3o6z/fgdsEaHLmyk0K
	 8vRcCCMdDBZUymPkTnvyInNpohoTTaemNPMupZtGL0MhfSGads4Lr7QS9fkAcmXtj5mhX
	 n8gcG+GjfCrR/bCVpLnXGMvoEDC98gCvrT4mnBgU+OUJ3rrg4yyxASRAqoFZ7dxNWCYNE
	 rcfFvPiXQedUsCzJ4/PyN5LyTob2a5k5jybDnhMv7FgIzSpdR8FEc30Rha7Or8c18wqpi
	 ZaaAT4mLpdISMRtHb1zonPfDOI/H/Ce7PEPSzraHrhnIBO7nTmjdCtY9yGgNZvUQucA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795041725;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=w/adz3BXcZH6EgrtTppx9Dhn3x9r5Jk+mcEePvJJGY8=;
	b=V5WAV03U0ByCVjVxRLSBPIEyZ/0hrqwNbZM+c2QshHAZyKHLRSUhwkOqBDgTkPkIpnLc
	 izTWIvKcPe1CVxUYADk9zF8LlxwceUn/mWMoi/sHr+2JzA6aaccL1RW+ytj+sLcz7WcJc
	 VYGieGqKsjhXIYDwOLig4x4UjNDRVum/32NbX0xb+xPKct4DHM4AsC3XIlSUilNpIiel3
	 e6yLLXlqqL+YvyIpb5lVWNT1jP7ltRZQd6FwQUPh5Ga4lUTezgNMaPD7q7i7pLZcvL6TR
	 e3louEgKfSgZ+gfjS+nnWGVP6hzLdSitBOErDQhuDvExiWuuxwZqES9sthNp8kJI2aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GIlTQW7P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060C6606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GIlTQW7P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96751F000C8;
	Wed, 18 Nov 2026 22:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795041724;
	bh=w/adz3BXcZH6EgrtTppx9Dhn3x9r5Jk+mcEePvJJGY8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GIlTQW7Pivt6OjHk4zmSTWKcWgIsJ1VSXXMP8uNYloQ3eEhDVIF9qc1JFU13x9HCH
	 pppOKksimU49KPNLsCSxgWeIXDWQ8kUn9kQw1sWsrOQI4Q8xOahrUT1r4bnYgSBO7G
	 yso7A/5gajYoOa7o4RntlOEbGNB8X19tplLUJFTahSoFER6073l1N7Ed07xX72adGw
	 ZSZz28Lnk/EAY1pMgfze19RzZoJQ5Tbm7PTRm/qGkzp50RqDkK2Jo7ac0gJddbMFLy
	 vOXXHlxlXCJw2WbLVCIHmftnv7CXGco+Gkq5gEFBy7ALGSFQG3/GNY3IF5hO33yvQp
	 Acm7QgF4ZK9lA==
Message-ID: <sashiko-outbox-222111@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/13] perf annotate: Print the stats after the
 annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118223725.121500-9-acme@kernel.org>
References: <20261118223725.121500-1-acme@kernel.org>
 <20261118223725.121500-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:42:04 +0000
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
> With --code-with-type the instruction stats are printed from
> hists__find_annotations() before that event is annotated: the first
> event reports zeros and later events can report stale counts.  The data
> type total is only counted in --data-type mode, so --type-stat without
> it is incomplete too.
>=20
> Print the stats once after all events have been annotated, warning if
> --type-stat is used without --data-type.  Leave the TUI's alternate
> screen before printing, so the stats remain on the terminal.
>=20
> Fixes: 58824fa0087e1cb7 ("perf annotate: Add --insn-stat option for debug=
ging")
> Fixes: 61a9741e9f78c64c ("perf annotate: Add --type-stat option for debug=
ging")
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223725.1215=
00-1-acme@kernel.org?part=3D8

