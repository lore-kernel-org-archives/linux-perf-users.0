Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739C8558201
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881268; cv=none; b=lNvOzLQTkSvZ9S33PmK83RMYAlvxZlUAWzKeTXwPw4+3BSZQlQKHmX3ErzDTiPA/OfUadre6Vt8iZCdaFluHbfzqQ8TYzx6w1nNbC3dCFg9+FO9fKBWdqchq2Jw8Vp9h/C+Oo/U9QfS7T+R8cbKGzLbkb+NiwTXPyfk2Jnf/9Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881268; c=relaxed/simple;
	bh=m04pnCMD253XYf1RWr6jbtkTx5ZeTwdbNFM3OEW+Pks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jt5w2RFteQXYchz57dfKGlKRIy00OsGkNiIG6+canrCKA38Nz15+tsp10xIUBFnEMVxTUPf/yS0FSkRG02L1ZbUvcuiU+317aj8EMH3m8QymyYFkMd5L1nDozxb3Joyd/xGCnbF8xNBN6qTReg3/dS9pMZxNIbmHdnbQOtVUtXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41481F00A3E;
	Tue,  8 Sep 2026 15:27:35 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf test: waiting.sh: Replace timestamp polling with
 sleep
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260908152053.192830-1-adrian.hunter@intel.com>
References: <20260908152053.192830-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 15:27:35 +0000
Message-Id: <20260908152735.A41481F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The waiting helpers implement timeouts using:
>=20
>   date +%s%1N
>=20
> This relies on GNU coreutils date truncating %N to the specified width,
> so %1N yields tenths of a second.
>=20
> Rust coreutils (uutils) interprets the width differently and does not
> truncate the nanoseconds field.  Consequently "date +%1N" returns all
> nine nanosecond digits, causing the elapsed-time calculation to be done
> in nanoseconds while timeout values remain in tenths of a second.
>=20
> As a result, timeout comparisons succeed immediately and the waiting
> helpers time out on their first iteration.  This causes
> test_intel_pt.sh to fail on systems using uutils "date".
>=20
> Avoid implementation-specific date formatting entirely.  Instead, wait
> for 100 ms on each iteration and count the timeout down.  Besides fixing
> the portability issue, this removes the busy-waiting behaviour in
> wait_for_perf_to_start(), which could otherwise consume CPU while
> waiting for perf record to start.
>=20
> Since the timeout is now based on repeated sleeps, it is only
> approximate.  Update the comments accordingly.  Also make is_running()
> wait for exactly the documented number of tenths by changing its timeout
> test from -gt to the new logic, and quote tm_out in the modified code.
>=20
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908152053.1928=
30-1-adrian.hunter@intel.com?part=3D1

