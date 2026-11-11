Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370621;
	b=z41yz2vDU5W5ODDStz9i/HAcia0eoy8dFgFL/PiAJu9UF8QMWq4Jr4yfut8PerycIZE4
	 7KSo2ZdBSO4BOJMgO7Su+1YSArEXicB68hnskA2MRa2AlLiR25yJNELb6XYun/+8mUncT
	 /cPTvWmQyTleZcb4AptZ9d5jyMzskrI0q5tG3R200jMzyW8wUlYDiyQ30zTsZECCrZZBD
	 UxXA7+4pSEJAWSYMinx2JgYWNp5RQnMp7cWsVCO7Gqbp1Se6AO+oamVC/WQpMMwSII0Ky
	 AIaWCb82Bio21BoDx6HA3/Mb9Wza50kWwK4i0MzUxdmeW8CjKRArc0LaTeERw31eEoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370621;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kpi5NDnQ6xjgKVWbQU7ISJdVKjPmqqoR2uQdsLU3b3U=;
	b=0Ouv2QRcM34RSl/O3haTbBzysTylmgBte08mzKSIsXlkCTzV92nkUqbFeNd1OhN/21zJ
	 J7jlgJu3oEhD6TjteCXTK5JAB+kRi1Sds1BrudEc1CznmRmuAitpAWDWYZ0zRjRwx93YL
	 KkB0TO4wi6uFGcT22fLQbaqtaxpWNXlujdBJxfuOxPItiYt/Vai+KLH0mReS75cLfW6Mv
	 JPNTVH6ViH0lWOJIOsykA8La4hzkDef8zGzJ1JGZwVuqp5o5NFrTHt3ounl3g/zwj9q6U
	 6M11TZg/5dEKVivTv4KXkAo4oXJgxIxZloQHM6mg5JBQcMQ11KO1gTRjggDTZGh+yFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B7hoKeCb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047E2606A333
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 04:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B7hoKeCb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6EB1F0089F;
	Wed, 11 Nov 2026 04:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794370620;
	bh=kpi5NDnQ6xjgKVWbQU7ISJdVKjPmqqoR2uQdsLU3b3U=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=B7hoKeCbWbIY7BuZp5bONxgV56e+8fFQnNwKYsVVoIfzxH3rkaWjDVLuLNbwiELnP
	 b1KkDUgeLnFciNdnavSzkWC+HCeCm3GfmlCRBZsQvBEDHlfUe0zQGOpz6AXQugrkdW
	 NZHDp8aYfaaaL1kl/8tTYJ9bGiO0MEE/q/6QrEE6vk3+eQv7Y+gjJzdYyffpa1ESBJ
	 HyP8QStwEfJv+Uw1aA3AVUDn8XvaMPWQAmIUdTM1NtLVH+l758fmBBcaylFFHx/OQF
	 pUBBXYcAZgvNtFsJ7iKPGeEjCQAK6Efx7kFQgSb4k69VOvrZZgrUAea9QGuWs3/Nc7
	 DAy9v2lysdjzA==
Message-ID: <sashiko-outbox-208266@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] perf jevents: Make the model argument optional
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261111041045.2031464-3-takano32@gmail.com>
References: <20261111034333.2019831-1-takano32@gmail.com>
 <20261111041045.2031464-1-takano32@gmail.com>
 <20261111041045.2031464-3-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 04:16:59 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The model argument carries a default of "all", but a positional argument
> with a default and no nargs is still required: "jevents.py x86 <dir>" exi=
ts
> with "the following arguments are required: model", and so does any caller
> that only wants the tables for an architecture.
>=20
> Make it nargs=3D'?' so the default is reachable and an omitted model means
> "all".  Builds pass it explicitly, so the generated tables do not change.
>=20
> Fixes: 5a09b1fd1b1f ("perf jevents: Add model list option")
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111041045.2031=
464-1-takano32@gmail.com?part=3D2

