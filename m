Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693697;
	b=AQ1A3RoR7v+hdWxtYdK5sLGCN7vCQQQBfuVXOgDH8CrzNGVn6oDceKhyP4leb+LzRcsz
	 oLtRR4dAWrJt96ffh4upwvRJDdz7SA9jcQWFE9M7K1GJai/Ve2hE6vlz2dfcQU/xTBTYw
	 JhcO7SiKMLB11kTWl3fNsZ5/VlKRfdygUOEHjKhs9yUHW91gfAnB2WJsc5LKWoCEMQcp1
	 qRiAFz8ETTrKetFkmVmlGtk/NyRyykGWNR5+rfVUIE+B+4J5LopiQ6PMSzRUlPDOlQvwd
	 SxYOb4rTRdWgbXRLx/8qHGGTTpfivFGGKWB2L7W6friKqZXpxrbp7sqRVp/mQFWSAug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693697;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iOGMbXX3dNt7PnGRSv+MGRCjzv3sHLA4iYUuQ3vcKSg=;
	b=eQ4p/I050z0hBUQfLO/ygwptFolaQr+ySE2NMxXzS1UgZEEXW6LAx4X5Nw9kNA4WFqAT
	 /z0tSWPTxUn0ueoseib0S3rr8u7IcnCIC5SIQ1Xuo2k4d28LMVhuSQD+XOfU8NTnOaiDu
	 M7lvC2u2vUiRpqO/WlWzDNsm4uPn9WkQ8kD18tcWyPBEsIwOb6MPt4GO3YwjVuLqrJckq
	 coIz8TjORyfJGNAocqjVEjNPv5EBdSlWFASIULDyB7Dw217ulRHi8R1/VJPq4aH8ty/rB
	 DQLG0dL8w5EskGYmJ/otwho1harJM13XC0yD+DfYTq6Q3QbGXpJHZYAIQjy7WsTFWoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FpSZVP6a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D17606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FpSZVP6a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19201F031E3;
	Thu, 22 Oct 2026 18:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792693697;
	bh=iOGMbXX3dNt7PnGRSv+MGRCjzv3sHLA4iYUuQ3vcKSg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FpSZVP6aLdqkRU8bIh/kmKugmIGKfrwJwRSespJmhPN2aOMPNuQGf+oEUyxhL/SZN
	 4g5Xx5FZmQOVbW4alqxcHrIYiI98gozNTvuWpCkOsOWl2BVbEzvsDbLx8JxfbG2MYa
	 1tAs5VKNwsisBSR8AsrGeh+BTgTp/8R4vtWUzWhddo/yNQcPHqIn8T/1r/lb2hABXa
	 GnPlhbDQumRIdSDT8VObtC/jqkzPdWbXc7CZzTHbJhMTVnU+Jjqjwe4UpOvc3qq+Lt
	 B3SkdlVgTsKSf5dTgZL5OyrvNG0S+5CVdKzpTEhVbBxWxbb7Gh/8nvWXwEIZdJvYVA
	 DkpoWvsZbCZlQ==
Message-ID: <sashiko-outbox-181915@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/10] tools headers UAPI: Sync linux/if_addr.h with
 the kernel sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022182431.25673-3-acme@kernel.org>
References: <20261022182431.25673-1-acme@kernel.org>
 <20261022182431.25673-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 18:28:16 +0000
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
> To pick up the changes in:
>=20
>   7cb8198761e6 ("net: ipv4: report multicast group user count")
>=20
> That just rebuilds perf, silencing this build warning.
>=20
> This addresses this perf build warning:
>=20
>   Warning: Kernel ABI header differences:
>     diff -u tools/include/uapi/linux/if_addr.h include/uapi/linux/if_addr=
.h
>=20
> Please see tools/include/uapi/README for further details.
>=20
> Cc: Yuyang Huang <sigefriedhyy@gmail.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022182431.2567=
3-1-acme@kernel.org?part=3D2

