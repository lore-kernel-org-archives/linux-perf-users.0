Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D907AEAC7
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775937263; cv=none; b=mHmP0dew9BtpapMshFngpgegoRxYbB7Lojkw5BSvfHv8y5rn43zA6SC7l+twooTH8Hy6tMCIaBbqhUmMcHruzXU5VpaKPk67i3K0rXhYOU3kCOmOFEATKaW/KoiX5rCfg2kvDMAkAj6+pY1mNqvuHX8w4WPqkVj2PvUvDAaLLMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775937263; c=relaxed/simple;
	bh=W98KEZEYfWyB9AXeDu7GC5Lc6qprLHv8rrrJr5W6a7E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b3Tj6aB0NOj8mCqviBOWoYnesxducai2HLQTC4zdI5P5in5xReplbP+jy4WsgL4/JS1xyYpEzqwX/O6YyzDCjBM3cWimdYI+nObBBYWXcLN6SHF06BoMB9/rHnj9Um5aDEVtpelYViZhur+QP2Fkv96A7lBOAmy5fBxRdE0tkI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHvCuGpW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHvCuGpW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C949C2BCAF;
	Sat, 11 Apr 2026 19:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775937263;
	bh=W98KEZEYfWyB9AXeDu7GC5Lc6qprLHv8rrrJr5W6a7E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oHvCuGpWZP9d00nzYyDTCpzMFxgRinoN7o2WJAppBuKO599c9Bo+szHYbB3Cto1PY
	 lIuii0BZq4b7DxunipYvbnVrKVLoWZ7u5KwPKE3tslciVfhfe8idE/ua1cu6T1mBWJ
	 lfzv3ZyaDGNtwUCNKdo6rGhxuulN521j7yBhDdd+n6ixhxAg6ukdhcOofkdZh7IpME
	 4A8giM+iGSIOX7PgU5eOwo4dK0N1p6JF2Rh5/eKxStQJbPWYzngrcQGvdUBf7DnQPQ
	 WjH3XSkLJif172WLlI5IH/+xZhV986oDg1Uas9kds/Rpsbfs6oGim9PcQGQ1MQ2dHS
	 /e1AJXXc+bczw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf test: Fix inet_pton probe failure and unroll
 call graph
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260411193705.735269-1-irogers@google.com>
References: <20260411193705.735269-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Apr 2026 19:54:22 +0000
Message-Id: <20260411195423.4C949C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Unconditionally requiring DWARF call-graphs causes the test to f=
alsely fail on perf builds lacking DWARF support.
--

commit dbec7073d294917f7866e8ea3a6b39004a7407ad
Author: Ian Rogers <irogers@google.com>

perf test: Fix inet_pton probe failure and unroll call graph

This commit fixes an issue where multiple identical event names were output
by perf probe when creating multiple probe points, which broke subsequent
commands. It also updates the backtrace collection to explicitly request
dwarf call-graphs and increases max-stack to 8 for all architectures.

> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tool=
s/perf/tests/shell/record+probe_libc_inet_pton.sh
> index ab99bef556bf0..eca629ee83f03 100755
> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
[ ... ]
> @@ -40,12 +40,12 @@ trace_libc_inet_pton_backtrace() {
>  	echo ".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $ex=
pected
>  	case "$(uname -m)" in
>  	s390x)
> -		eventattr=3D'call-graph=3Ddwarf,max-stack=3D4'
> +		eventattr=3D'call-graph=3Ddwarf,max-stack=3D8'
>  		echo "((__GI_)?getaddrinfo|text_to_binary_address)\+0x[[:xdigit:]]+[[:=
space:]]\($libc|inlined\)$" >> $expected
>  		echo "(gaih_inet|main)\+0x[[:xdigit:]]+[[:space:]]\(inlined|.*/bin/pin=
g.*\)$" >> $expected
>  		;;
>  	*)
> -		eventattr=3D'max-stack=3D4'
> +		eventattr=3D'call-graph=3Ddwarf,max-stack=3D8'

Will this cause the test to falsely fail on perf builds lacking DWARF suppo=
rt?

If perf is compiled without libunwind or libdw, running perf record with
call-graph=3Ddwarf will exit with an error. Since the test script doesn't
appear to verify DWARF support before running, the test will report a hard
failure rather than gracefully skipping on minimal perf builds.

>  		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" =
>> $expected
>  		;;
>  	esac

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260411193705.7352=
69-1-irogers@google.com?part=3D1
