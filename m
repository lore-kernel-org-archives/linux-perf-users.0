Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B042F1E7C2E
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 05:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389570; cv=none; b=M0RXAN0ro5Nz+jdjrwhAClmX0017m5gmZWqqyFHzrEg/9ACoKXPE4RZ9nexKP+Ru9ELqhL46KdbdoR1wIYStOJbqe8OVTs8KBAnv/kswImqagyfc6pHb2BbP7wt0YcCRroe7M04AZ+MUr4H8uRAoqCaFeX9LhwRADE07SYDSLfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389570; c=relaxed/simple;
	bh=bBelH7cn9wkvWnN5Nfr+TlJd5SUa6DkjWwpm0NJyz30=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ccwgCJ+pq5mr5E47s4R4immE9KG/G7z31S4jS/wDTcXQJgFZFDBoe/CPQJ8l6rK9By86zUoS9h7bkqSCZ5UwlzxGLVWchJd7bqq7yap88Yr+zYTtThKV7Xsit1WZ/rIqwlnyHHEZxzjibRJpjXyvjcPZfeHyUwWfQ3M5RVyBCYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrCwBhL6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrCwBhL6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E671F000C4;
	Mon, 19 Oct 2026 05:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792389569;
	bh=aBBp8NHRwBB+r0W04UL40Vapx19jDisBtp/s6AvxP5w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YrCwBhL6GKyyZku1rUyjw1mAbPVFFaYFHZUxJyptfNEIcto+qmRJu8TATF7ERw4Zc
	 g14UbS9+UTSBBsRMzCdyrF0zsNHV4QClp3P4UpPSbsXdhGGnRLxxUTk4MPpXIgh2bq
	 9zyfvs1v0gYw1NtqMJkPWMt03mUdqTrAiMeu0rnAQiqUgasx7Gai5uT4xRngl6Brhw
	 OytPEAVG9sQwm2AGTjIhbieQP6cpySuysDrRt6F9oorHNt1PRkbRd6lri9ThfqVIqo
	 gw6le+0VFiivmvn8hhS2zUiPOH8suRRJy/liu3LbT/W+Vp5b+gVKh5jXme7vpAStj0
	 oumIo3gGnacUQ==
Message-ID: <sashiko-outbox-176679@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] perf tools: Remove NULL check for
 maps__machine()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019055207.39325-4-namhyung@kernel.org>
References: <20261019055207.39325-1-namhyung@kernel.org>
 <20261019055207.39325-4-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 05:59:28 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Now maps should have a machine, let's get rid of checks for the return
> value.  There are already many places to assume it returns non-NULL,
> so having this kind of check could give confusion that it can return
> NULL (which is not true anymore).
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019055207.3932=
5-1-namhyung@kernel.org?part=3D3

