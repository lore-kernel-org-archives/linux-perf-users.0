Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D3C37E2FC
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776654621; cv=none; b=TKC1rkMZ+tqfUdJujObWLH3bcPJ8UPS+3o1qb+NvKAH1S72YcjZn8qX0W/nh+875YsRvyotg+OBoamH0P6hIxIbl0YCSKVUWcauzYXlyJ98CvVPmslQAMSHZfitnDuhVNkTa5tNDGWVqjiyTDIDNLE0vXhyNXHYEYBN0ONkDCLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776654621; c=relaxed/simple;
	bh=z8Zb40UpxI/OUCICFPFQIGmUA1D5FQUYGoyhWaii9co=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cWTLXB56q1jBwY5arMC6eHmcJlJ9lkwT+tF1FK9CPNVOinKmcgcxoAoU5W+TeYQGtPqzcWY4v338BUL6JOxIYQFvuFUTrZ4+lcJ7ATxrYTn5Blkr18Aotpw04zRT5Sh/C65vH4tQ7w1JU5bVqN/pVHI9vX2iO9tGmLleaMbipto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f90ei3zh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f90ei3zh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDE8C2BCAF;
	Mon, 20 Apr 2026 03:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776654620;
	bh=z8Zb40UpxI/OUCICFPFQIGmUA1D5FQUYGoyhWaii9co=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=f90ei3zhFSfIHxTLLQRvHpDABeY0ALRKUaVYvye3m4gZDhFcVENovv+34feRnuHdp
	 7A3cE+AiuJ3s0I1H5jEryNJ1xi5LWcIHMsLh1tgy559jsFOjFyyLLVClXxS20hjfRb
	 n3Ka88DrvmprqTpY6zHf9sxFK+WQPJSMHjURMVZ59+hm5yY1wgl99R11DB++zpoe6p
	 mkyBRvYkLcdQqm/C5LFHAToWM/fzQ3fedl8zkDNqACF3JnP9CIuzWy1Z9Rzdq0t4WF
	 /o0Et3OKieIYQrEq11WcS1iRgQxZH2j48tEhVHv3qyxE7FJygPRQ4IJGgzgH3JAcdm
	 OhOq8JGTPdw5Q==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v2] perf tests: Add auto counter reload (ACR) sampling
 test
Reply-To: sashiko@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260420025501.2133495-1-dapeng1.mi@linux.intel.com>
References: <20260420025501.2133495-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 03:10:20 +0000
Message-Id: <20260420031020.CFDE8C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Early return in the PEBS support check unintentionally skips sub=
sequent ratio-to-prev tests and the final success message.
--

commit 4863d01ec678cdb7aeb26a69a3ff812dd0a8e16c
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf tests: Add auto counter reload (ACR) sampling test

This commit adds an auto counter reload sampling test to verify that the
intended event records can be captured and that self-reloaded events
won't generate any records.

> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> index 7cb81cf3444a7..a05b0c8b6d6b6 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -402,6 +402,94 @@ test_callgraph() {

[ ... ]

> +  if ! perf record -o "${perfdata}" -e "${pebs_events}" ${testprog} 2> /=
dev/null
> +  then
> +    echo "Auto counter reload PEBS sampling [Skipped not supported]"
> +    return
> +  fi

If PEBS is not supported, this early return exits the entire function. Does
this unintentionally skip the subsequent ratio-to-prev tests and prevent the
script from printing the final "Auto counter reload sampling [Success]"
message?

The ratio-to-prev tests use the u modifier rather than the p modifier, so it
appears they should be allowed to run even if PEBS is not supported.

> +  if ! perf script -i "${perfdata}" -F event | grep -q "instructions"
> +  then
> +    echo "Auto counter reload PEBS sampling [Failed missing instructions=
 event]"
> +    err=3D1
> +    return
> +  fi

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420025501.2133=
495-1-dapeng1.mi@linux.intel.com?part=3D1
