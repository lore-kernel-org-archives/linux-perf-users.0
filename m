Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793943857;
	b=FPpYW+/1YVXeKd3182Q7UiFhJUvRfytVtxfaN4sF86r+APlzqNXlfL0pcijD+0eJs+oN
	 gxt5iZXsTcOTZEdBtN40wiYN7QzWvjK7c5ovxbZpfkbTN1irVlgyWCNU1xIuDeTn+mbe7
	 b8dEf2InbP6xVdg9B3nIV+v/+Ud1+tzL+ofYW+4DJmA4DqUBRZ1tNpJayL5b6cOXdPx01
	 n94hEJ6wrx6XfcS3gJe3Uy3qKtxmsGKyvcdUc8Mtssq8EqrTQBD8DKjysIwBSKNR16RPr
	 Qpgy5kyZcMJX0rcX0y6i0LnDERZ6l9QRxxX+5p8APIpAm12bj5QpTNYihKxJnxp5yIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943857;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MbT5hfIgqocq0MwQi05WOfF5j6FeoIpT7xe1Kt8tkJ0=;
	b=Tuhis5MC7no85MiXeCbF9TxME2h4WA6cxtSCEKgW7vK5zaR1ifzBi4KzoVKD1GlQ/6yb
	 EV8NF6wAr8Jqa7TEP9PCdR8yRWtX5vVwe5wwFyFz2+eaVq5i3IsQQsowjiHW5ZC6sbDGV
	 InlFbZZTSE9v14UntwMjBQmZJtMpur15t3MvYiPyZvg2Wu5DUi0wCdfR8L9yHJFfh9JQb
	 /8LM0G0oKDAnmJXk8kqmqkyl5+DjMg4I6gWsde+L0g1aU3yIjWgmsL3DGGh72dWmAZadd
	 a0PIso3RBqg8/vGYeGB+cWyh9CN3je6LGLSHoNNEMk9Xc4DY3HJYrZLJq68L+Jp4d3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NUGYYoR/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51347606A328
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 05:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NUGYYoR/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92111F0089F;
	Fri,  6 Nov 2026 05:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793943856;
	bh=MbT5hfIgqocq0MwQi05WOfF5j6FeoIpT7xe1Kt8tkJ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NUGYYoR/hBHVepDzUOegRQC3ikBLalZOd9YHL2o1YSs84K133XvyTHsBSfJ2U4i4r
	 lK/dt3R59JTmPqfUgq3QX6UHDKqQUmUKU6qW/1zB1SsmmmBsS+dfnkRjvON6Kj+3xl
	 E3s9Xe4ycIZc+1jzg3VaT0YazFx1h9z2fMRtiTBKVDKXULALNw0jhay5qvb5AdxDHW
	 oUCp5JG5nxpQ4Dd+XkbVGIBaS9nbkCtqEE1JfZ06RN/oPYrfaS/Mv1THrulNY32kjW
	 TSlh1b3ycPm0OEkY3A1oLhVGdn9TKuWGlu4q3vXxUjRmcN1W6KHv3SBz2vg2TbSa9J
	 srEeQGpQ5ROBg==
Message-ID: <sashiko-outbox-200850@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] perf dwarf-aux: Support DW_OP_addrx locations for
 global variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-james-perf-test-fixes-v1-2-0b279bee5830@linaro.org>
References: <20261105-james-perf-test-fixes-v1-0-0b279bee5830@linaro.org>
 <20261105-james-perf-test-fixes-v1-2-0b279bee5830@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 05:44:16 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> die_find_variable_by_addr() and die_collect_global_vars() only accept
> global variables with a DW_OP_addr location. DWARF 5 producers like
> clang use DW_OP_addrx instead, which is an index into .debug_addr, so
> global variables are never found when Perf is built with LLVM=3D1.
>=20
> Add a helper that also resolves DW_OP_addrx and DW_OP_GNU_addr_index
> through dwarf_getlocation_attr() and dwarf_formaddr(), and use it in
> both places. This fixes the "perf data type profiling tests" test:
>=20
>   $ perf test -vvv "perf data type profiling tests"
>   ...
>   Basic C perf annotate test
>   Basic annotate [Failed: missing target data type]
>   ...
>   Pipe C perf annotate test
>   Pipe annotate [Failed: missing target data type]
>   ...
>   Basic FS perf annotate test
>   Basic annotate [Failed: missing target data type]
>   ...
>   Pipe FS perf annotate test
>   Pipe annotate [Failed: missing target data type]
>   ---- end(-1) ----
>    88: perf data type profiling tests : FAILED!
>=20
> Fixes: d60469d7c0e5 ("perf dwarf-aux: Add die_find_variable_by_addr()")
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-james-perf=
-test-fixes-v1-0-0b279bee5830@linaro.org?part=3D2

