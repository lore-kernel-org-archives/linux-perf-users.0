Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505637;
	b=Nx5Id13HcKGawpUcBWOE5IVFbfywMoeHZE+w2M6Z/vrM7TzGASY3QdJiByiD/6Qi/Om4
	 qou1JxY0psjIeyi+ZFNrTrphAADUppNTN8lAxn/aY/mhjL51znPIkTz4/MPqnKbQcSmfB
	 jleH3/mdAkhnSwS4xiXRs3/e6eefdoUcTwLiQW5B0sAegLbuDZRtfeWwlA/lkQSd8aBWr
	 vNyjWB2Nsd0JN2H0+uBjUGTVkFAWErRQwCbrX1BhFpAWdPtetT1kEWsuJFXyzk81P/AUW
	 ax/loi6zM1PgJ+IC8FvcPX1NESOWA/WchqYURlS907Oy6tGhHI0u3L9XkKW2gpjQSiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505637;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fyojp1Tj9YpzvwR7xY8eTAZV0id9pGSosGu1/Bhuk8I=;
	b=tcDPuE1FHsF40RdlzJ5ei1Nz9jB3VuE+6EPeCn5EkEpnPSjqyDcZzVqEaoMQPZfI37i4
	 7T7yT8EJthcD17jGZKSRBzu1LuROfZXz3v/FkDqPaVnwzCboM+pguucD/Gv4FcnxMdg72
	 pvJNHq4XoCG3w2BCZzZ/t43lHgF7ZT2w/NKOgrqfJgJmVfGX4WWPIemENF/ICKOvEEHt0
	 JMQZ2g4MchotGl5FXZxOEOAmoJzAQ+kCPhJMO6aoNeLZQQM9+Ea8d+B6cpM7hm7AkK/Ub
	 QVXQ8PL7stbjOCKHVHxnNZJtV5KFoO57oNEXstlTGYBES51uezcwZ01ZO0LTJKWnRKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BEaxxzHF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D09C606AA37
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BEaxxzHF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE441F000C4;
	Tue, 20 Oct 2026 14:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505637;
	bh=fyojp1Tj9YpzvwR7xY8eTAZV0id9pGSosGu1/Bhuk8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BEaxxzHFvF3ram28ucZRg4T+RRKVirN2IA1i+XkBh1HDqj8EPAc54W7ODrinMRZBl
	 sgItUfiTt/2/5jiuWulVDv7kZwRoQxN5B3v34JsYyeva4qU89ai65uB3KP6LhoTP51
	 67aLpsAuvqdGz/OAWKc8NjRtw/UdFBwX5gMrtd1Smdt93RFrBjJF2B67nsfVLbkhP1
	 S1cgBZF8Gd+kHhudNGiSFOF+RxbW5Pe3EkMzdlReRbbD98IQ0fYXu5Q5/TiGtZgc3u
	 ac6pWNjN8yOZdJNC9MOCebpvd0Al0OEO0+Ru0EgXNUu07vOxRm15PwcS93COKtywkU
	 YlHRJO/L+eRJQ==
Message-ID: <sashiko-outbox-179100@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/15] perf annotate-data: Add arch_get_reg_offset
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <f22d02ca275d647abfa459bdccd89cb23e63019f.1792411435.git.wutengda@huaweicloud.com>
References: <cover.1792411435.git.wutengda@huaweicloud.com>
 <f22d02ca275d647abfa459bdccd89cb23e63019f.1792411435.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:13:56 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add a helper to compute the effective offset from a base register
> for instruction operands. Currently handles arm64 addressing modes
> including post-indexed, single-register, SIB-style indexed with
> shift/extension, and constant-offset register pairs.
>=20
> Fallback to instruction's raw offset for other architectures.
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792411435.gi=
t.wutengda@huaweicloud.com?part=3D3

