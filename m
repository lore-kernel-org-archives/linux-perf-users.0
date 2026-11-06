Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793943391;
	b=MYmzq3zlH/A+wxDEIQCbO4UvvwPSgK7PcVYXgKBtGoxi/MVkq+Zy1xh0gEBaUZG0tN0V
	 N/dlH+CQFquAqVOoqgIf1rLIq122JCbZeg0O5q//bVMky/D5QBiROEyXaWDPBkG5jSceX
	 L1ikGCm8vcGNsw7yoBFlZQHisD+f/AoNDI6TLg7SJ6Nc4qaDCG9TClYztmouHwdurLNuH
	 t2GSO+XmUu/ZPZj/dteMuILfGM+eOMNV+mPjrrbhWuiyD/MMAyg+SWs4zOYQtpvf2zRaU
	 SMV+6h9lKqvtiBd6ZA46hGoZdHG4D28sWrWN3fydK1GxoFSWinF/jpN0zScwFnmYyoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943391;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wcHxR7ctsrBN1TjtycOY4Tfb9D+dMKUOVKpXr3X87fo=;
	b=dG0Mu/TrF4M4/oF4GWktif98mVRkoPzrL0dxAD8oXuqTDBk8V/HjU276yyw7s9XvVfTj
	 8abJ3tKOXzeFmNqzgdNiVflyVLNb1CqDLTLSKQQZywcuombR6DQ18YzH4eYJv/YwYJ32e
	 2Wjk1Qk4AX1MqZecGCCDJX0CssrNuibGLpfRy9DTmG4G1MwrAIuImAwVs54Pi6reZ2/MD
	 Uz/w6Lq1+AWkntSU1zwcfF5Aymc0+ZG/gotBxC/opk6cPVIaqGpBPfMLaAIioZvl+7wyn
	 qj6sVlcrVkBwzrcF1OyXsb2OizYkFMnH59ZbsJ1SYpOKj4ygB+oznORL32G9O8oYigA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DS++An0l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E7F606A32E
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DS++An0l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B431F008A4;
	Fri,  6 Nov 2026 05:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793943391;
	bh=wcHxR7ctsrBN1TjtycOY4Tfb9D+dMKUOVKpXr3X87fo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DS++An0lQPxkARrASbXhR7eGrArzByhNPcQq63H0eyqBGdL1g3VR4kq/i+uktZfAn
	 QBCp2ZWvFpzS2QQoMbPT7ZhqqcxVV0CauD5r/OQn909LHeMlupdCfjKhze5q6TCClD
	 20Ke8Ib565kQGW+qMGup0ryF9xbBUKZ892aIOtF1vpfQWF0Yed+N+yBlraIX+cP3oY
	 CzfcuebFPVHJVJWsFRvBMx12xDmu4zMlq7DEADylTFaVqAfOkQ3oKXfrT5rWx3xqqj
	 ejJT15R7P2Cqn3PD3Lg+kWkfMQdP7TaM22wAwRg0W0wcJiyhQdmsWRlXKOGQZv0emj
	 fTn0qSJNTgtTA==
Message-ID: <sashiko-outbox-200834@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] perf libdw: Find the CU by iterating all CUs when
 aranges are missing
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-james-perf-test-fixes-v1-1-0b279bee5830@linaro.org>
References: <20261105-james-perf-test-fixes-v1-0-0b279bee5830@linaro.org>
 <20261105-james-perf-test-fixes-v1-1-0b279bee5830@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:36:30 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> libdw__addr2line() finds the CU with dwfl_module_getsrc() and
> dwfl_module_addrdie(), which use dwarf_getaranges(). In elfutils 0.190
> this only reads .debug_aranges, which can be partial. For example, when
> Perf is built with LLVM=3D1, clang doesn't emit .debug_aranges by default
> so the lookup then fails and no source lines are found for most of the
> Perf binary.
>=20
> This used to be hidden by falling back to the next addr2line style, but
> now missing information stops the fallback since commit (62d7cdc8d587
> "perf libdw: Optimize fallback logic for missing DWARF").
>=20
> find_cu_die() in annotate-data.c already handles partial aranges by
> iterating all CUs in .debug_info and checking them with dwarf_haspc().
> Move it to dwarf-aux.c, then look up the line in that CU with
> dwarf_getsrc_die() and use the same CU for unwinding inlines. While
> [ ... ]
>   ---- end(-1) ----
>    79: test addr2line inline unwinding : FAILED!
>=20
> Fixes: 88c51002d06f ("perf addr2line: Add a libdw implementation")
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-james-perf=
-test-fixes-v1-0-0b279bee5830@linaro.org?part=3D1

