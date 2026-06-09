Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E099A4C9007;
	Tue,  9 Jun 2026 18:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030816; cv=none; b=TVQ7JYInohcBrByBNRQPooGVHLfYuqkHLRryreykjGJm9qZMqWit6j1H9b+T0pUfv7L0QrUXB7P2k7sqW7XY09SHEbJdJqbJE2/qpMzU8xv9HXIZ4lbKwtFLkc5J64Kj0Th4oe3FLglhUn3NxBAVm1azY9lhY6K/JyXAvonJONw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030816; c=relaxed/simple;
	bh=+0FkhnALWz8WMUEEI3k68e+prEu/rRg29mrvOlLdPAI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=svL8UCreyzg2xWSg2gigvkLwe6jzN607UvDyEXj0GMCtCz82MrHd+KN+8KhLGH/3Sxus1ezphtzvKL5SfnNQ77WzjwkXclri/uy5tt9z+0a8nifLpPmeZ9v4uNAPIqUBirUEvnMBVQ1A0RSjKCZh+KqEHNF6CunvgDIsCCJ+ZFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpUnAhQU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpUnAhQU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7D71F00893;
	Tue,  9 Jun 2026 18:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781030813;
	bh=21H/0/6OMFbFgxy/xOdMemobgG3IvocYHOD2Ps0TDks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EpUnAhQUVmcZka7SgDoH0qQAmvrkc+mK8Q4adPxDbYTc0g76xHtNrFYUK4m5hrqWs
	 OcXXftfRqd4wP/Ze84HG7d2aeUHp7EVaDVlZNERdDYhp0r9fEsSGD2pRV5w7ye9JSL
	 xCR6ERMRvfHzLIUX501lqfvPtWtANOSnkzeJlDr8+1mGGck4/brNHZ87Z0jByt+x+K
	 gC0zywZvqhqUrTSCqtV/u2NBxAcsjBjDIv42+PVJobNJxE9EPxNadOpGeKsG5mN7rE
	 Xdbc3fRNrfZRgeZBS1llGQbeypdQGlWBRG8jFC0vnoUlEs28AlkvS+Luc40IS9g3bR
	 h/eGinCWUINZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/7] perf test: Enhance annotate test coverage and
 isolate config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260609182108.975586-6-irogers@google.com>
References: <20260609182108.975586-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 18:46:52 +0000
Message-Id: <20260609184653.5F7D71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch adds a test for a non-existent 'libasm' disassembler back=
end and feature, resulting in permanently skipped dead code due to AI hallu=
cination.
--

commit a204be6f7db310b7e87e271b24c42730bafc0573
Author: Ian Rogers <irogers@google.com>

perf test: Enhance annotate test coverage and isolate config

This commit updates the annotate.sh test to verify different disassembler=20
backends like objdump, llvm, and capstone. It also isolates the test script=
=20
from host environment pollution by exporting PERF_CONFIG=3D/dev/null.

> diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/=
annotate.sh
> index 689de58e92384..eae6a46a247b4 100755
> --- a/tools/perf/tests/shell/annotate.sh
> +++ b/tools/perf/tests/shell/annotate.sh
[ ... ]
> @@ -106,8 +108,66 @@ test_basic() {
[ ... ]
> +# Restore perfdata to a regular format for disassembler tests
> +perf record -o "${perfdata}" ${testprog} > /dev/null 2>&1
> +
> +if [ "${err}" -eq 0 ]
> +then
> +  test_disassembler "objdump" ""
> +  test_disassembler "llvm" "libLLVM"
> +  test_disassembler "capstone" "libcapstone"
> +  test_disassembler "libasm" "libasm"

[Severity: Low]
Is "libasm" a supported feature in perf?

It does not appear to be defined in the supported_features array or as a va=
lid
disassembler backend in perf. Because of this, the check in test_disassembl=
er():

    if ! perf check feature "${feature}" > /dev/null 2>&1
    then
      echo "Skip test for ${disassembler} (feature ${feature} not supported=
)"
      return 0
    fi

will always fail, causing this subtest to silently print the skip message a=
nd
return 0 on every execution.=20

Should this test case be removed?

> +fi
> +
>  cleanup
>  exit $err

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609182108.9755=
86-1-irogers@google.com?part=3D5
