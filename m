Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1333515884
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664085; cv=none; b=BuL0uZo2QzKSaAjoqiO5VWpKL0Q4vhYSnUvmVW4eo2a5/uoLb3nHvggGhgR0Ej3iG2FY3TGzn5ZIOBYPxmnpr3+Ur+zFgNfaq1xielHIvUdSUZr1vYLx2Sd3FYqDjtQSmVtEW5UQWE0lX2vJBdThAKh7IOxYi/bUEwE6H7dpG0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664085; c=relaxed/simple;
	bh=ILYxaEInSSlvem2GVTlXGQqeJjwq6k11wYu45qatTlI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BAOrsGD1z7YnyszrBPJHccSj21pQWCAXEOw/WFjgMxm0z4wfTJsmRR3K0p4Zy2Nt1KsVJz2F010j6XstjUevxH79KdoFUX82HjhBTkNW7eNntL75g0t0837mZf+dLtqx9FpUtxMlUnevhRpI/PO/29nUYEbOEWDi+5Fx6n1fABc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dj/+vDwY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dj/+vDwY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5114A1F00898;
	Thu, 17 Sep 2026 16:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789664084;
	bh=ILYxaEInSSlvem2GVTlXGQqeJjwq6k11wYu45qatTlI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dj/+vDwYLsCwgT7lPwTmZtsj39w/qdIRUwNSgmh5H/NAfYp3yFty9PTYc7XmOXJ5l
	 YFVm7+6BlQgFN4gxO0V1ExRVC0hfQOTAMdkOC1CV6uZkToJWYLg2wvimIBaIwZe2G+
	 BffdblF1n6w2/8QKJjKDmybyWo3QGisVEXEcYu0lmKpKcbo/OC8+Z4KoIxESTdqqOa
	 VrRgS6wMtwWznmxdOCjsIi6hvNNugPbou3jmZ+woDNHXfhQUV07urAbI78De6d2rM7
	 EgYw4Rxa6TAYG/CO7kXwLMX23sTTLAH0W8Kd6AIcSAvawO/qMBv3yNw/hFZFayVQnD
	 PPaekF0MWHbRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/14] perf test trace_btf_general: Drop
 --max-events=1 and make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <c031566fe3af02b978c7e7ae47c6f7d4a05515aa.1789662556.git.irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <c031566fe3af02b978c7e7ae47c6f7d4a05515aa.1789662556.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:54:43 +0000
Message-Id: <20260917165444.5114A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> trace_btf_general.sh used `--max-events=3D1` with `perf trace` on
> commands such as `mv`, `echo`, and `sleep`. When background activity
> occurs or tests run in parallel, `perf trace` can capture an event
> from an unrelated process and exit prematurely before recording the
> target command's syscalls.
>=20
> Drop `--max-events=3D1` and let tracing run until the command completes,
> checking for the expected output with grep (matching trace_btf_enum.sh).
> Remove the (exclusive) tag so the test runs in parallel.
>=20
> Running perf trace in parallel is only safe now that the probe tests no
> longer name their probes "vfs_getname...": perf trace opens everything
> matching a hardcoded "probe:vfs_getname*" wildcard, which used to pin
> those probes and make their cleanup fail with -EBUSY.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789662556.gi=
t.irogers@google.com?part=3D12

