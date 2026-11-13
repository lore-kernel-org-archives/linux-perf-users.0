Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607176;
	b=nlw3oYjySxInToATv8E/h9NQV//XG4Fo8QvqacjfcXeEHsJc2uy8PZZtn4iDh+8QFS6u
	 v57J8Gp+9S3VWZdFPxQ6wnioKWQCWJncWqQjbGjOXy/EaZp/jCCkudwJwDJC+3Fc2nK+o
	 JyknvA56gvYtg1yOGcf0dB6j8z4VNV/QIYKtvwgfU+ot2y1M3uEbof5/DM+Fg03nC7WaF
	 mpA5Pn8eeOCABmXqjVkUMsm3b0ItSVumE70ef/9Qx5/+OnRyyCmZzgmo1dv87opdZwlBv
	 qy+Ih7kHP4oAGWS1FjTDoZ0iq/UMGlKSOo2I4PBgdoMF/5EAKuCu+8b4b8eRE1LZsOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607176;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eG/Eg33dqtfWK13pomcOvdb+XkSBl0eREylMkpWkU+w=;
	b=xRAytrjgfBpVZ2ZRdtmw5OUdhInjaK31bJrlsnQhwbsBKk/lPeDjimeO6u9dNulYa5wj
	 rY7w98F2jM+UtHeafyye1hR4OnSdbDK9SWRpfohVpIIg6BOoKTj6iXIKJVEsyPW/0dsQt
	 TN+Mkqk0Geqv0gNNr4RI42uEPjwdxKI2mPXgS9ZT77aexn+LhlUMpizcQPG2gfuaodoO3
	 X3zu7g3dLDcHYv2YOwwCxw/LIqaWiUa/ZF1N2iJ5APFbV+lahIw4Kl+yNKx/vfgfOQ1C+
	 /xQie8f6OEkMwOw8iZmzaNYqp1Bc39GUjIP/2NYWsLGLVq8Pyv5Y00FDUNXc/SRlPaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mWfJialB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD66606A334
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mWfJialB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDAA1F000C4;
	Fri, 13 Nov 2026 21:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794607176;
	bh=eG/Eg33dqtfWK13pomcOvdb+XkSBl0eREylMkpWkU+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mWfJialB7lwpP0iQDMm4TAyRne21WkxS5xfiw0tlOCOOMqnxYcOBa1/u3qHp25W0p
	 x5fabDR3RIWGpXEhtoF7lBgHSftvNySmZ+l2Efzuy3pf2Q2QnoPXqPur+pKVfBXtYh
	 8zyujRtTYKniac/qFTIMo6HryYWptBzQ5W9WN2Eyfd1s3irW0kyfkM2sFktG8a4sNQ
	 3ft/WVfQHnttLUCY1uuHYeS/ejDIhJ43uzbtL431HtQJ0HYX/3JQ0dHTVon0uKAvgV
	 MNdHMHNeL5tnI5JbHw4pfXEYwou/I8zK655tb+4nRifSNlifk2pznC2WWlBSRWI/Dx
	 8m3iDWK37tWhQ==
Message-ID: <sashiko-outbox-213760@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 18/26] perf s390: Use generic hashmap for counter
 name cache
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113214850.3329699-19-irogers@google.com>
References: <20261113214850.3329699-1-irogers@google.com>
 <20261113214850.3329699-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:59:36 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Convert the counter name cache in util/s390-sample-raw.c to
> DECLARE_HASHMAP(s390_counter_name_map, long, char *).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113214850.3329=
699-1-irogers@google.com?part=3D18

