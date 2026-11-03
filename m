Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793675418;
	b=jfCrVrVP2CAskDJ2YuZU8z4wggvkEJYnOzIrUDcp0C4gpH+0xlmQ5z+Msu0fNQxX/X/U
	 c+WZilsABzhUfXa48MLNny1NsUdZkVwkWi4mCcnB2c80Ww9E9XN2pmU3IEko+yHxTWQ09
	 zEpURePQEz35FqBCYXiI0ZiWMp0McKtF8HTpD9vJY3PCd0q7Cif3W1SBDFujizkJc3GRn
	 SXQ6/bxB90FsQCXnpu/7TZR6rAgxGAfSb1mCkxVqQl9ILujV+E3ZAcrCNxT3rzQLibFCa
	 rxGO+3AJBORKWH/DppMzsMoNkUeNe3QyTKGp8Zm5d1ujxrILz2O2tzMp483KO7kcBqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793675418;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4FoRRtrxp0vctppTKPVp2pGmiClu1gihgdC2MkLIjrI=;
	b=lP+q4GVqxnYZ3mHN1669iczinzVjzJDTJW0nlqA8h+WVvK4vy9Rjawkg8p+RFUh00kGV
	 65M75ri3l1iQGhajO/erFXXynq4Nu6mNjo8hKiPy0epNAENu0N9Pqfj8jFndvFaby/rN/
	 99T4RvviQd3YbzsQ+UreR2zcIPEszr4tCsoFtM+g4oxSG7wRERRGgSVoSMN5o+zLsTU6v
	 RWzSAptU86RIAE0BqVjWyOCemPDnNNWVUzBcKuN3xQTubfqJu1p7gG6zkQXwct63O0IdK
	 5X5dXMIXq0HaE60PZ9iGUgzF3wl4NwiY2VB5saPyed4RzfR9Rv9dEzc0qBn3oRl9UfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dD6IMQoV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42893606A326
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 03:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dD6IMQoV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C1A1F000C1;
	Tue,  3 Nov 2026 03:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793675417;
	bh=4FoRRtrxp0vctppTKPVp2pGmiClu1gihgdC2MkLIjrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dD6IMQoVWNZE38j97dgTifI45tONSnguZVJEI7K2U3kcjOCmwUGDUWtOvAEFY9PtE
	 v2fMvpfQaeybP80GBvMmzNlX4L7bHpJRoDaOQcLWsjIlzKMHZfjJVF4INZDjwJMHC7
	 LqbhiXOBBjfm7QVntARaNHsMK5tNObAGh+97RnuD/Op1XyXREKYk5fdLhc/EnhjtKv
	 I62E/5VqCZFhCEvF6tAC+rw3K4foZeG0Enf8s1aA+uA0XxfryS/IE7AJJNruwWV/Uj
	 hrnuSkaPIw/cYzZsYW479WAdN7uJTB6tU+pVFia9OGPTfNYkLbx2Zxc7SgM648P2Ww
	 3uwNn+YggZVhg==
Message-ID: <sashiko-outbox-194493@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/7] alpha/perf: attach ProfileMe status as
 PERF_SAMPLE_RAW data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-alpha-profileme-v4-6-61e00f5e1da8@gmail.com>
References: <20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com>
 <20261102-alpha-profileme-v4-6-61e00f5e1da8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 03:10:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A ProfileMe sample's PC alone does not say what happened to the profiled
> instruction. I_STAT and PCTR_CTL do: whether it trapped and why, was
> mispredicted, stalled, or was killed on a wrong path, and what PCTR1
> counted during the window.
>=20
> With PERF_SAMPLE_RAW, attach PMPC, I_STAT and PCTR_CTL to each ProfileMe
> sample in a versioned struct alpha_profileme_sample. PMPC is included
> because a PALmode PMPC is not the sample's IP. Killed instructions can be
> told apart by PM_KILLED_BM and VAL. The 64-bit fields are packed after
> the 32-bit version, since the payload follows the 32-bit raw size in the
> sample record: they are then 8-byte aligned in the record, which needs
> no padding.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-alpha-prof=
ileme-v4-0-61e00f5e1da8@gmail.com?part=3D6

