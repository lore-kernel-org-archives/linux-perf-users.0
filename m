Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607074;
	b=oZy0Cdip1NNMTijh1DK+E+zJpLTg2dXSbXgX3tNAuu6BnJSmR4H02X0IpRZAqFw+OHdC
	 ka6IygVOQHATqLmRhrIZhzBOk/gvBFFvL/Qrbj4SVYh/fJ5k7bMksqJfNVHOQ3Xq0xBA3
	 c33VN3RykYEYQZES85enDW/10P7XUHkFqGQsMN6c/+KtsUDxRZN5YE0nfIMsXqmRKhL6i
	 dcYv7/YF/EPU/caX6ulgG2O9o9eDP1Ri6eAuKriEnCz7vtaUE+uxTJlVg2H3BX7mvvJm7
	 unDBv1S6VLQ+7vhOE83eIYE6CGNs33kEzyTKB6C+Vd9kwynwtDM2RI5O1OZtTcWTFqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607074;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1UwDkTDm2ATpCEe8dEIY8JQZvUGo3rKV/9qkjf4JjqE=;
	b=OfRkpN4/bIjQttpQq9FHHZPZDoWhXk1y7llEeCgj0FXB8UhHm5nASDw2eJjgAT/++P7z
	 FrrUnjtLiQamF9gb+SKqZbC36tfGl0f59a/5F9csRNwD/PVJDoIZzJzXl5kc0A4aeTHPo
	 KCLRwOAr/zuvFUHxpiT2gDCM/hNVy62qdeoPwN8Bc5LME6ar4qW8Od6yx81h2vcWwQXQj
	 OMpkJv/6r+9o7QIPs1YFTfCKlKUmtca55brVRpGHCJt841XLsVgF0bOS2wept70Q9ulHE
	 6M2Fr5XyXh0WNdwSwhdy29nWW8h9Hd9vOsdNFZrGAGUQ/Sdh6RAd3CVTB/l8H1D557w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=apIk82vH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99B5606A323
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=apIk82vH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499191F000C4;
	Fri, 13 Nov 2026 21:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607074;
	bh=1UwDkTDm2ATpCEe8dEIY8JQZvUGo3rKV/9qkjf4JjqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=apIk82vHOOSaQy46O1OVMqSbaEmQbHQ1s6B8cXFfN4CRRNJNHpS910l4CVxwFHgWB
	 xvXppmpDAptyPDg32LFhFpTKUmUI1QZjStlOyNfr7OAbxPjjAOxxrG/+LGvj/vVuIq
	 0VI4JAT8BvxmZ8qWWkaUZdUkvMQ226VxidVzJUwMcpZj9y4UDat6Pa5++0h0C+Z+TF
	 JmSIN90zpZpHkV2kpKt43WP15EZYu/kloufsbpoZLW12Dmv9WqSapuJE0QQnOzFjfX
	 Q4tB26fOgqoXfLBBlXlgB6pHblIz/vf1uIDvuSOhCcyYeOwm9iIFu5RHf7K9wlRYoL
	 ihFow1YaFXnBQ==
Message-ID: <sashiko-outbox-213754@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 13/26] perf lock: Use generic hashmap for slab_hash
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-14-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:57:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Convert slab_hash in util/bpf_lock_contention.c to
> DECLARE_HASHMAP(slab_cache_map, u32, struct slab_cache_data *) and use
> hashmap__for_each() during cleanup.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D13

