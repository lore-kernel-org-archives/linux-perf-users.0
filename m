Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794707194;
	b=zmbaE7943kPKs252syNIKyA2B77oAqTjARDwjvourboGvAu2i+iyIUgkriZP40CyK2HZ
	 h7WWXPGfx2WCFqj86ado6AWNOWh82ajFLk0IV7QdoUSC/IGKpKaYolkbkwnk8xRmHezZ4
	 H4hDSDX1zeREube+UAzsZET/FXE4ye5KlgVzyuVNHZ1ZCZ0mZa4FOMFUu1tWlmeGqRXAY
	 wVxIEMsMysJUXrggU4O/1PaTQ5vaGYDOgTTHxxbDcDq0k9A8nEGVz+kYk0mtqIeC+eQHk
	 4VZkOvhRo2G60srLbCs3pKWCpA7dPYKd1hF4w/KGGJDJC1nNxu/XJKiALq/cY5vtgQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794707194;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rZtd6evuD2Jp33miS2FgwTFqLHwYG+zZmqU2Z8+iGbc=;
	b=QEFsXza+w2Gad1gNMBM5wbA4/7K97Iv3Z3NsDWUzhWbRUIhPGffxldfFneJWpuGJJTEV
	 EUSLAiwUeUWECZeHC5WEQw6/SGVONTrjXKJ4/pjNk813tiIcuz0vNjE+alummSRYeBKBy
	 7kCZi1aq2ObBO2FdDcljuhoGgCh9t0A7JhAPN2od83RXudfe5Qy+Qh6jC3ODTSQoKPJUV
	 lGy1UoMW9HG4gv4hUzFHGaxNlmKu2rKv2A/DG2gn6COd03pViZq9gxl67MyuhL5ARYWSu
	 RiNm2ONsz6N0+w+hp0HaVLR9XzsFbquQRzX0zjI29hyP1zplGWMX3/oVPRXHmPvQi6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MvlSVHZp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA872606A327
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 01:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MvlSVHZp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696081F000C4;
	Sun, 15 Nov 2026 01:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794707194;
	bh=rZtd6evuD2Jp33miS2FgwTFqLHwYG+zZmqU2Z8+iGbc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MvlSVHZpnnNAEZvMbokVzWuxGgSCAWXmWII7tp/YKdMIrfuL9mMxiUaFLI0u3cxJM
	 cJoplrnDFzRGCROCl3tJimbcVq9SG6J5PA7x+e17gazRnkhd+bo4emPgb22OmTC5dc
	 e1UiqqrzJXxioYCKfjICdHRbP0VofEkc2qi4lHdebLZRVY0xkhU7Ks+O86WD3eLLzp
	 M9So782FVyOy+1qS3Vg261xGzvAiXqJ6l6wWQ/5Pzbae3ajJAa8VrsHOSQfytJv6Yp
	 nPtmyWDm+0pfXU+qUKC8G+cVjOX+yXpgYhT8r8y+Nwa1U9I8uwml/fl25RS4gzPPK2
	 Puck+pj2wMJ6w==
Message-ID: <sashiko-outbox-215168@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/12] perf annotate: Print the stats after the
 annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261115014102.2879372-8-acme@kernel.org>
References: <20261115014102.2879372-1-acme@kernel.org>
 <20261115014102.2879372-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 01:46:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115014102.2879=
372-1-acme@kernel.org?part=3D7

