Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795280460;
	b=jeGKCS7LJpsnbzJIHbasCX/YwdAXcYlhqRmdHzjebKBXxCJ+te+LLx5TNZwKyHpU+Ya+
	 VlbYqJcR/d5thfvzkwMkhED5OUSW1M0qcvIpl1fL4mQcw0JEehH1AspfUl6bvUJhuKKNo
	 tOSphPiuJTybPticl6mhP0tPZccWlCqKDecoL0HrL5VpgimedoNbPMODHdDDBecA5P/fz
	 YJWVFa0QISYiR3QuBN6FW9HuL5IRXdAl8MlbfOqjZQAhRce6bO430z7yrp7ym7wxaJoNW
	 Slq939aUgWyvKJHxnoggjRPH9tnRahQYqFZaYYL65ooIXCXfC/ME4zdl5WC7HZS78uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795280460;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0DjUZbUx9I5KWMY5ot8zfWxvyeE8N2xbo7OOB7cAUks=;
	b=2brE4nzLvXZ9QD/kho+TFg6yMesKsYCGVrwgz2BbKXkZHQ5sh43cQ0UsKrADdTYh8ok7
	 gPNzxmUDHkiS7NLWsrRpewdF/2WKSjg7xpi7pozGY33euOyaGGVSjegSapuq9+Dxwrls9
	 SgJcg7+bGm+DUrqmTd4XfFn9V2jCggm6JPfy1j/k32UhibBs2kKagzOLhOsFo/m1F4ZGX
	 x8drl2XYvfX9OK1oOyvrzCI7FK3z0aUFUxqqHPl/DB0BattD5QzBsrrX373uCNOtEtVOQ
	 Jw9v+iWTjTVsMmpGYCQD6kD2o/JcsL5MTZhMP9QUKStUykhGEWrVM/Wo0hPAmmNlXdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mMWqEjlb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9EC606A332
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mMWqEjlb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD721F000C0;
	Sat, 21 Nov 2026 17:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795280460;
	bh=0DjUZbUx9I5KWMY5ot8zfWxvyeE8N2xbo7OOB7cAUks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mMWqEjlbXXAgeXjoH6utH5GJUFG2ERaHEZvU5GGWZx6FpHsCwRauaPlthtYTRni+M
	 o0KARctImTOw4uk3BCWNNpAfyM1Lca5ErcTpdbYg85quTm0UtAue0yL0oggTCUhSpd
	 TdFHSUnluYu6NCkaJ2wLBGYVaJs1gKOimiD8kUP9aInikA+t+CUTSPG+7HWAyTQk9m
	 QCo6b5UGW2kIgvTflrVqEjvN/z5wNyHLlLCdugr/JMkdoMS4N/KmJ5gxRM9JbGX0zp
	 mQJIf9XBcNLiCuzwG9buca/f3lWG8kJGrsa+1Wfo/DDGfb0QrGF7iQ6EUVqcf2wcQL
	 gJtn00FJZvAhA==
Message-ID: <sashiko-outbox-227188@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 0/7] perf script: Lazy symbol loading
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261121-perf-symbol-memory-send-v8-0-370561cbb5a7@uber.com>
References: <20261121-perf-symbol-memory-send-v8-0-370561cbb5a7@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 17:00:58 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 7-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-perf-symbo=
l-memory-send-v8-0-370561cbb5a7@uber.com
