Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589311;
	b=pzhd2KBxtj8bf2WMeTgFHVEi/0HuwZc3W6JfRNeFuiQWuGvO7M5sU3FZp9+1hV+nNhlh
	 ptYR5Wr+SRdvy8Ua5hfGntLyxSRHmtmEQ39ckN7VS/d5W+iDOSI6zsuyC7yQMxtMgxWws
	 Lac4Pxn3d3UFthT09wnL07U6sLzWY5LSHRCfAXgY7hgBQ33Ww3SEm4l8mI6b9xOYWUh1h
	 ZQVeD1x2PU9IwiYIXlrSoYSxI1wnUQA5GOagnOh24bNvzg1uqK8RUIGEU0veP2oalN5Cm
	 gLyybf+xDgO1/zLqXcXcOufvTj1xQbS2OUOMOREcXH0De+6wXAu83st0c3CujxgT0Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589311;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sqDz2GJjtfqssyngAvjr6A1rkvUEYoTQ3b9hCn00IoE=;
	b=oldZzze56mxtmrAdeRgvYZDPiQIo6YhUfQ8t7Tf5ILiMFaM8v+5e99mvEouPfRUVfKf6
	 vvSU/rifQ+D1CdMXrtfUXidCTzeHeP+dPiFeTp/YyMRd1YcVz68dr/8Kd+rMd1t6X3V7Q
	 OaFTeOTApPCDrTgaMtck7PjSYjbGVGMapgfQ6L89YTRvRMvMGveX08YvvlR7/7eZQTJTg
	 WQBY7tEFKF8RtZzpNMdHQu6SfftnWqUoyMEfTOeL9DD/XdEVc69T7Gh8r7QMIVbwNVQQy
	 ZBjE2TYS/h8IcNtYW0baj1vrZhYRZzaD9GxztOH2Epgwl0geC+nnnAQATr+7xY2bulQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=isco4Oh9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D79606A883
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=isco4Oh9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC94B1F000C4;
	Fri, 13 Nov 2026 17:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589311;
	bh=sqDz2GJjtfqssyngAvjr6A1rkvUEYoTQ3b9hCn00IoE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=isco4Oh9gFbJckm/Kc+X4IwoB2/DYVAJTBZvJP7WVUwIA+hcLNn6Xi7psCR+7UdFp
	 YMpDlX/XjzuETEjWA2ceC8XoL+AYAyv77tfx3wCpHxxtXqrK+luellrKH3aC/w7Z2c
	 qcmNhGKoaKogHasdIIOU1++o78SdiunS3P+16yQMO3R3ji9trdtjIopraok9HKempd
	 rBOJl40PBOl7oPRRjwJldreSQWtRjSE8xlRgdhA4N7784I7mrtud8+uSIOBNQy4Ry6
	 fz4IgRvY3CSJirkqPQdencT9Qovxkanq/CPzwNNcynU6V+IgBgffzPt8Imby5PThQY
	 n76JFTKIBgwIw==
Message-ID: <sashiko-outbox-213263@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 17/21] perf config: Add __guarded_by and __must_hold
 annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113164152.2095566-18-irogers@google.com>
References: <20261113164152.2095566-1-irogers@google.com>
 <20261113164152.2095566-18-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:01:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add __guarded_by() and __must_hold() annotations to static parser and
> config state in util/config.c.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113164152.2095=
566-1-irogers@google.com?part=3D17

