Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C86737F32E
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882218; cv=none; b=FpWPrqniXUqf0nnXZoiw1XcSxuWs3sc7POgb8vjkBX8AbvepwQwYmjoT881Ms+z3IxvRZIkDi0Jkb4cUbQHtqtn4t+NuCIMFaCKwSwMgt+qB6Ip3i38Mc0mT9B5ktYzKoTur3jkwHd7+MoEOEh8+bTFivamiOPYkzIWfSrQy4m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882218; c=relaxed/simple;
	bh=Tnca4OjQKVhGHl+TZfuRejUn+RRZutUTKwug5P35W38=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FLwfd7tQoVJ0aYpjkxfSuMVsd5IOqpxp6Z/dr2tVUom2YqNzWxv2USG0acVxjPyBx7HakCN3my63WtDIuIxCarTnvsIaVzjFzhwXh3s3kX4ktVjp8q8CxUmVXc7guLljTNZ6xoCgbAZpxnl0c4SBaarvBgwaiiErLff9mzR8ixs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWI5U31z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWI5U31z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5F51F000FF;
	Sun, 20 Sep 2026 05:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882217;
	bh=VjFHrQPikgvV5LXiERPApgsUlPohNoroBmi2t+2Xvlw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HWI5U31zmBBnN12hMyTRPIgc3txaYQHULUQUFVk58Zeyitxz9XnR26BVEZBO+tVv8
	 hcKHansYajIKhUga3wCiuhhxYILlFbnkT50GKJRKkvYMcGJRMfl3OXionI5yYwqDKv
	 Y7TclFyknVVGbI5R+AlnfFy2E/6HrXH5z6aVqjJeDrM0HXyu2Q07lWQSLlMvH/6jdF
	 11mM6AKEnhl/Th7ijCzOJ89Rr82pe5ueUnAJAmQ49/rts8n3tCywKmSAaS3W6L1ALp
	 vXegijcgooqpcIMlLlydsD6yMIVCDG/tS1sN4+wR9DrvGTY7od/AkCJTZdSL8KYLuQ
	 dvJKGZED/+sYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 02/49] perf python: Update callchain stubs and
 session thread lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <621ab9b3227a1845f5c2d8819ad84e4cf494f50a.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <621ab9b3227a1845f5c2d8819ad84e4cf494f50a.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:30:16 +0000
Message-Id: <20260920053016.EC5F51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Update pyrf_session__find_thread() in util/python.c to accept an
> optional tid parameter (defaulting to pid) and return None instead of
> raising TypeError when a thread is not found in the session machines.
>=20
> Update perf.pyi to match:
> - Set session.find_thread() signature to (pid: int, tid: int =3D -1) ->
>   Optional[thread].
> - Update callchain_node.symbol and callchain_node.dso to str (the C
>   getters return "[unknown]" fallback strings rather than None) and add
>   __iter__() to callchain.
>=20
> Also update treport.py to handle Optional[thread] returned by
> session.find_thread().
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D2

