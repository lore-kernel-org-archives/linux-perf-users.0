Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020167;
	b=PQk7J5CrK2FpJuCKUcG44xRBTJYZWK8R5GnJheT1J83ih6diV85UtsIz0QJ+uqQXcA1g
	 GAOhLb+NmDOJkcqpQeEkGrF1wbvWPXa/ozKpqXy1PX3wiV7WoyeESKPAb6RQ80R4SYant
	 KNOoTIDKFLOe8+lEMZdfIpDoiBh3jjw1LbQBJMAWXtO4R01E8S6nJ5qvYFJOhMPQazlsh
	 7+ftPrBI8Cygi8pk6wVABDfnuB0FJhaJuJ3GiK2zUdu0ZwCn8YIwfcWyqZ39Ikc8DK6dR
	 /Y+rc1MN/UXLhkZZl+rMR/k5XOboKW2XbS8Xi2K4pA4rUOk9YXKt8wXbFszU0mZRl6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020167;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UQm3Ux2gOWGSLyXOXkcPqGjpLo3B+oTBY9W8HipE6+Y=;
	b=XRXZQuEFbRC4mVOc7aJCaVScjiDr65VyyA6fmlqtpeaEwdRvDy+qEDPT4/jNdGUVkmXT
	 OOk7xZfWjdL92You+cwx8eJ0HK9550L1Rs+vvZ7CT1otq4FaQkVzYQ8vvKIAA8PXZpQOp
	 9lhEvQcOBgPYli7Bcb0dpjwaXrr9+1AZ+4LhGB83+7Jo6IqKdTD6cqkTDUqeARfdT5Ddf
	 vNAQyuOFBV4jgmpC1gfqoH3yDKXfLpuiiq940OIl1e+jgsTDoOFn4dypGZbj+5FHIsRg9
	 sRyIODplI1ehB6iLrO+F4U9y3RrX/2vbYSiYpS88a0yP64HU78Fswldxq2DhACz6t3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=io8gaM4C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22C4606A335
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=io8gaM4C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736A51F000C4;
	Wed, 18 Nov 2026 16:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020167;
	bh=UQm3Ux2gOWGSLyXOXkcPqGjpLo3B+oTBY9W8HipE6+Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=io8gaM4CWcv41YRrsrkGNffLSvQtWsFl5CQguhPfb3cE5KJZFHk5Z2df92bu6c73H
	 7I3Kir0NEJ+dHk5gFG7Z7ZA+tgFw+acogjqANVMYfVcDeWq/Rk7C0DDfnYgfN9e6t1
	 M9PJLqE1Wqtp6MUkFmmFeYO/tvP/cxLikd7wYYMR3HT6CKZdSvOwcii6NxdPFgEfsM
	 Td/3W0GtL8meRYVYcESyXNy7HrQTNVnZhisATy1pyrA8c6Y785PDlfK08bb+I6ML8n
	 mL5FW4S9v7iXqmJwdNzOtvp3IFM1+EcUbO5KE3mpra2+n+cKBdm0HQay5q3N/lTeDU
	 SEcU5D52Rp83g==
Message-ID: <sashiko-outbox-221537@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/34] perf cs-etm: arm-spe: Use arch timestamp in HW
 tracers
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-8-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-8-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:42:47 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> To allow the JIT dump records to be correlated with the HW timestamp in
> trace, set JITDUMP_USE_ARCH_TIMESTAMP.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D8

