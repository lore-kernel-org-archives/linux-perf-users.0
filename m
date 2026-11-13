Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601451;
	b=yIweZ4Ks17H/XPz3XrIW9lw48MNraU368UCjnQTijk3l8QSalcJvmacu+ob/u24nOyWv
	 m+UP7Ccxp3lZVL9xneaYTOZTnjcipWYP1dkx6gdTTh5lg5zQTuQEIPzlscgn82NjBvuM5
	 B9+5tWRMBsxKnOW/TmGas4siO9oibTafLo+OKMRD1XnqLYkWtT/u+Bkx1zPSBqfbBqb40
	 Fr+P0F6CckwfwWBnUVoTkLJmN8XVUgjcyDWPqF3OMpr+FohqRtdAeUTl2R363gFMACFBL
	 Sy3xkmSDH/KhLnW9Ixfg2zpX9f8jHevUPcDnQk7Ae4LsWaIZKu/j6loZVBsjeu18oIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601451;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=t/kYLhIdTLgHZvEy59rKOTCS3fR9y10kexSl7IqGQWo=;
	b=xk5MCirAbIZ4FHPUNN83rIPMR/DIS4cLWWyBupHW4oQgGamKa+UTcShm7SL6CbSRmGi/
	 1djWA9kmnRkZ5tp4S+x+qDAzFCzixlL0JSdFxJg071qVLRSx190DWFE9GJj6jylgpqKrv
	 Ki4O1mgNXBlEWhw7tcRjOioVu6rIWtCb8vuhEs84obnh91BSelsjtV8L26BhnS64YIT+h
	 BMEarh1eAAH2Kzx7mc2kA0BTGsF2ZACB7ERhzCaBAU5o1WvPTRspw18aLCXcbUTENxW61
	 ZN10SP0Ym1sKvViGRbzmx+4+Lu7bqt1XdwZoKjXzu8stU3O14UtW6WcbvML7Q7BzpCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZVkhCx+Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90582606A336
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZVkhCx+Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DD61F000C4;
	Fri, 13 Nov 2026 20:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794601451;
	bh=t/kYLhIdTLgHZvEy59rKOTCS3fR9y10kexSl7IqGQWo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZVkhCx+YKGFFl08IGPCZQMUIVd5gWC0yfBYCBRpKurfzRaojbaWyP1zcY2LoIx30s
	 quIBVmnnOR0uaNG0TuN+htOPPcBxIiaxcbloBTihQ43uSAmkIUdsqqPy95RpyyJEGA
	 NtXot/4dkIf3H/BWtcNVKeODZneGAJ7J5M+GzcsW30EcP/XbMxyJLidxEo0JhX9rm6
	 8M5gRvi1jmytjfmB/naei4Zf1CXvN/62+kZopmgzhcpe2tfH0S/B1Un1hWNJxHlnJI
	 7/vKteULFtnObAhf2A0b/mKrZ7Bk76V0jvEy0RWj0Ol/soxbtFQSwH1C2gfPj0gEhL
	 Mmb3N7VVrFQuQ==
Message-ID: <sashiko-outbox-213634@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/11] perf annotate: Print the stats after the
 annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113200850.2803460-7-acme@kernel.org>
References: <20261113200850.2803460-1-acme@kernel.org>
 <20261113200850.2803460-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:24:10 +0000
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
> The instruction stats are printed before the loop that accounts them,
> so 'perf annotate --code-with-type --insn-stat' always shows zeros.
> The data type counters are updated in --code-with-type mode too, but
> only --data-type mode accounts their total, so they are incomplete
> there.
>=20
> Print both after the annotation loops, the data type part only with
> --data-type.
>=20
> Fixes: 58824fa0087e1cb7 ("perf annotate: Add --insn-stat option for debug=
ging")
> Fixes: 61a9741e9f78c64c ("perf annotate: Add --type-stat option for debug=
ging")
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113200850.2803=
460-1-acme@kernel.org?part=3D6

