Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C658E2BF
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792172493; cv=none; b=HhaMIJguWRV4hYbO6yYZFqmvstrJ0k4p1m+PRYTlcslhxyS8w6cM/+6/2x1Avryxe6Bx35HwoQtdMuCQ4xbEl7v6zGfO4pOee/BjLOzA+GqvXnCfCpka8iLoUvtGXVIMl5ItOlb7FJmUr9q6NsWgp02E7BpQjqcZCj/wMHl+Ohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792172493; c=relaxed/simple;
	bh=pxTx0F2BUpUuEOKKfblz/Nt58EhaG9LO9KU7l+oV+1M=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=fUwqyYv372em7hsXMLBhY+lwgfmB4HO7eskhlJ/7dbfTJ4VsP3yQWl4iuc29ycxk3jojZK6gNqwI+gTxHxp079vn3anXyWSgwpjl/Wq94lVrgOosm2CbOGZo8NYtJJsqypCFDzPfu5hHf4MyBobZ8N8RK1LV34dYjBZScIui0Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgwLyHT6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgwLyHT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A8B1F000C4;
	Fri, 16 Oct 2026 17:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792172490;
	bh=pxTx0F2BUpUuEOKKfblz/Nt58EhaG9LO9KU7l+oV+1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lgwLyHT6GsUgjOyERkGAVEY1pPRdvWFxaMIwArFr6OjjrMLpNsuCwmBDoq07DGIHC
	 UqZ5YydMZxhv2PgYkB6VVxDXDqtUhH1Q5se+pnqrXBnyzJtqdICZwV1VKxYuDNlVmv
	 C/wmoO1mXosT6WFgB1+n3BuT2A+1kUEDPZ38GYxT54wo+PrIpLNH7wf8FHr0Tv34fs
	 BYyNXQ5V3HT1yhXzLwb13W/d1vP5QibtYDyJcYHPb2DQ7AKGCim60YEwx4wOxnTzMZ
	 8mZmfhc6dnTxyD9AOgN04w/8gXgl4uqvjoVPcYclar6z12kDWSkODofAzBboLQzvXA
	 L3fK9U+C3JUgQ==
Message-ID: <sashiko-outbox-174734@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/17] perf dsos: Use read lock fast path in
 dsos__findnew_id()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016173106.679725-11-irogers@google.com>
References: <20261013222622.1822619-1-irogers@google.com>
 <20261016173106.679725-1-irogers@google.com>
 <20261016173106.679725-11-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 17:41:29 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> In dsos__findnew_id(), try finding the DSO under the read lock first and
> only acquire the write lock when a new DSO must be inserted or an
> existing DSO needs its ID updated (checked via dso__needs_improve_id()).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016173106.6797=
25-1-irogers@google.com?part=3D10

