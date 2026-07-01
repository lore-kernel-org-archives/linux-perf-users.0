Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86216431E5C
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936705; cv=none; b=ibUT4I0R8BFeVhY6vuHJvxZIaiCEsmB1O0cF6o21yDHwa9kWkFG6dWiHyXrH2ObBFQ4eKfhnF5VOpAqKzwKwwYlCJNniENnjEs0cXnIKE6s7ZSos1livP0/H1t7ST50FKpYDs+swsOxgQL05swkzP3qQq3FG1jYjjM2SriwySKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936705; c=relaxed/simple;
	bh=VsuhwVthg8K2/W4ecHewasIBhcW0LGnJ7s6jqkY4VwE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gEKTdmebW3eyFVTnmAcLtHHJQSipBsMjCu7OpRPtFdzvj0S2bsH2UUTXKzHwWTFzw89XYOwfZPLRKC9r+tWG6/gBfkMw+3FTiuuRtYuyrfg7W2VlQKRbcLUCoM8vBdpuqgk64eK+QrinJsacLYPrEFueV1C2fpF3NIiAc1p+Pc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bm3IGSlg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bm3IGSlg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F342C1F000E9;
	Wed,  1 Jul 2026 20:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782936703;
	bh=LVnwup+pkIsrt+rZ92ePj9jdPOD9XYqnVhEt1L1HBlg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bm3IGSlgkehtD+tFRynQbnQXT3NLalTDgBT3vdBJSPPxhjwtpAW4C/tIrk/s6q+8K
	 zvRxH0RlkZKsLW6WHjiioVx+5YWoO15FFJ09oFE8vufZdguPLPaFGaV6sZ4Do7O0wZ
	 U4/TzKzPBiBb3ImtqMeZOF6+EaTz93srGMm29PlBq4eyNuYQ9jOtd7wxOD+r7sGpdb
	 LSrwBDtcZtRoGk+TncGTzDIb80IezkXUWQMRgDI8NIZP7Y6pB4maY1PmeSIsH/r+He
	 x15w5Qmpa0WEv6wSaL3FBm8eLSQbvK8MqpXaEtW0PWV2+Cvj/jfsRjIDMZZQ7LItsf
	 dOyAQ9a09oALw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] perf test: Extend perf kvm tests to check
 default event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701194153.401218-7-namhyung@kernel.org>
References: <20260701194153.401218-1-namhyung@kernel.org>
 <20260701194153.401218-7-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 20:11:42 +0000
Message-Id: <20260701201142.F342C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing explicit error handling for the `perf kvm record` command i=
n `test_kvm_default_event` causes an ungraceful script abort on failure.
--

commit 0b371c3387f66fb432d87052c8a94cad8f1c734c
Author: Namhyung Kim <namhyung@kernel.org>

perf test: Extend perf kvm tests to check default event

This commit extends the perf kvm tests by adding a check to verify that
perf kvm record can successfully handle command line arguments like
'sleep 1'.

> diff --git a/tools/perf/tests/shell/kvm.sh b/tools/perf/tests/shell/kvm.sh
> index f88e859025c42..ad208abce0a99 100755
> --- a/tools/perf/tests/shell/kvm.sh
> +++ b/tools/perf/tests/shell/kvm.sh
[ ... ]
> @@ -123,6 +123,15 @@ test_kvm_stat_live() {
>  	echo "perf kvm stat live test [Success]"
>  }
> =20
> +test_kvm_default_event() {
> +	echo "Testing perf kvm record default event with command line"
> +
> +	# Check if kvm record with default events handle command line arguments
> +	perf kvm record -p "${qemu_pid}" -o /dev/null sleep 1

[Severity: Low]
Since this script runs with set -e enabled globally, could a failure in this
perf command cause an immediate script abort rather than a graceful test
failure?

Other tests in this file appear to use a conditional error check pattern
(if ! ...; then err=3D1; return; fi) to catch failures and report them prop=
erly
without triggering the EXIT trap prematurely. Would it be better to wrap th=
is
command with similar error handling?

> +
> +	echo "perf kvm record default event [Success]"
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701194153.4012=
18-1-namhyung@kernel.org?part=3D6
