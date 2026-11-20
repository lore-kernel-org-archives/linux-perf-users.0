Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138675;
	b=mtGkZwL+9xlT4sPCAYU2SyeDLo2qpYb6/0kJHnjzeOhhhUiixLR2aW/ccIXAJOLNDqOj
	 luR4HNyMIQG2JGfv34phng+tIRraBvWskOui2MZOEq92WRI+uDc2LjKfIF4kGBF9kxFH2
	 EtquIqOG5Ky3yQqFAHU8Wu2rlhkYGU5GeZkp7oDmqAIqSi1YaC8msPn+flvIM4n1kvCTJ
	 0JbLakuXgYBiazWnbtU0n7/b7Bprxw0V7o+rWImQj+JTvG+uqUkuu66yLjigWWX/Kmj0X
	 VEAVnm0liXtQshZnePQNtqiuCb3hpyn6tHQBM9bffE1Mb1aOGwJBQ3D0uUfvPqhWSDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138675;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QahoDLVwyHjSsdFz16t0iPl5E3BShhh3wi+K0oRIOLs=;
	b=GNC9ftjns095gPPJv984xGbw3zS/1jDgr/5AWXEvWmM90QjlVDVOpjZOg8QrsqQ2/xmo
	 oxzd/jAyF9VMXfYqqkKtQ+8ybwb5B85R1glDc7dOAyTDLtvOjbqayNf1j/ABBFiD4VTMJ
	 QMUK+iaO1NnXDAXwth3XUkh2oVRBLdJ45I4uXDFiKL8Cyfvr0SonBKm+jRxXmiPOjVs7V
	 O7iLhQ+vdRybhUWGG7U8+8nA0T/D7RbgBMNCtJ2kmm+D/BFp0czXF57mKvocNalZqRoNc
	 mCMBw8wmHU4IwJsJxw8z081GOrlBDISqi06X9OI2LSqYF1+hCmSHgqVGqdknXPAksdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L0/3cp7C";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC734606A326
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0/3cp7C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EEB1F000C6;
	Fri, 20 Nov 2026 01:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795138675;
	bh=QahoDLVwyHjSsdFz16t0iPl5E3BShhh3wi+K0oRIOLs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L0/3cp7CFm0CktWSV99Vs5sRVwisfeWfvpMs1l8wZ6CyuCT0+ySmkugPW6Xx4wvnA
	 77fxnfe/gkQ4qXZF6fJ1CaGsXDGt37zFpema0isDYhiaKpVtvLnClb2OuIo33rt/zU
	 LjO7qdCF9VMq25uqcnUezrBnrM9YeKKP5O82FtVfcztCUGMv65SoHRqNu9bEDoS+Sv
	 0beU2XO7nJqcBzhfnXzPVbpLdN2pAv/ovtYppDg9DK8Qs/a2udEe7la4Un98qgMAPk
	 TOx8pS/TFZ3ShJlTMXSFgOACqKlBpz7nA8kzPo5FZaESX33Qgo5PLvwE6gwYxKoQ6U
	 e3Y7BWQLUEr2A==
Message-ID: <sashiko-outbox-224325@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/13] perf annotate: Print the stats after the
 annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261120013211.1510-9-acme@kernel.org>
References: <20261120013211.1510-1-acme@kernel.org>
 <20261120013211.1510-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 01:37:54 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120013211.1510=
-1-acme@kernel.org?part=3D8

