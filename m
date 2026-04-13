Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6790F20ED
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043597; cv=none; b=cK0oxsTGbr7y62Ofl5zOVCQ1cI5hRSkaOAIejtpC8w5HCj4tJdCsdh+KYpg/jyrl52b2mENl+pJDgQ55waTXYQz1F6zg64Hs3/q9d5guq9raWgBXB7SsiqJt6ff4e7ELQ7CbCthRdMhyM4Z4iC473Kwm289yQxP53FTgO5H6iro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043597; c=relaxed/simple;
	bh=mJgqOS4MX1YFcATuiGNJ//RoYVhrRwav42dRndoUGSI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fmw8PbgPPpotg+I80DUXvh6vHw/VaaDSSbXACscHTUfNwejv7O13SSDFiQvq9gtb5qmD6gzG07KXEt7lOIsFznoAYhFHSN0VA+SvBPXtoojYiwZegcWRxw639y/rneiuIoP/LgLDeHByyYxiqPh54jxJYI9bKl7ARKo6T96uEfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZYmoZqB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZYmoZqB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE18BC19424;
	Mon, 13 Apr 2026 01:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776043597;
	bh=mJgqOS4MX1YFcATuiGNJ//RoYVhrRwav42dRndoUGSI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=BZYmoZqBhyzEf1tH7m0WgBJ8KzlIysH3pOw5hCpevzM8hs17WjjSJntJkAqHdZlEl
	 ZTyq5Kvib1gR0eU3eRd1guV9S6NNb6oKvv+ygTR+EjHVzQkiasWWSs6KATuMNTSgca
	 yrpvCjzmIDWbsbs/21SFGyA2CLd6Tge1k4HHWTXJ3cGEhtxm84tb4x0BkWcLeWH/FL
	 QabtuXBK+Noh5arMzCDeMQWltseKt7uRCCL5Vlq+rQ0cICXmslDuQW471W8ynUiadp
	 jWuZcF1v/XxwZpVSAXIhqTdDW1diQyeH7HbAhR0j/xgMgDaRrRIoDfCYaruAOmgkSe
	 X/vAYRjKn36ZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf tests: Add auto counter reload (ACR) sampling test
Reply-To: sashiko@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413010920.546501-1-dapeng1.mi@linux.intel.com>
References: <20260413010920.546501-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 01:26:36 +0000
Message-Id: <20260413012636.EE18BC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The test fails to genuinely verify that self-reloaded events do =
not generate records because the chosen sample periods and workload ensure =
the self-reloaded event never actually overflows.
--

commit 5e7a7e069f4c078327e3d8166d7f74d9084ec8a4
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf tests: Add auto counter reload (ACR) sampling test

This commit adds an auto counter reload sampling test to verify that the
intended event records can be captured and self-reloaded events do not
generate any records.

> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> index 7cb81cf3444a7..1068843282f51 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
[ ... ]
> @@ -402,6 +402,47 @@ test_callgraph() {
>    echo "Callgraph test [Success]"
>  }
> =20
> +test_acr_sampling() {
> +  events=3D"{instructions/period=3D20000,acr_mask=3D0x2/u,cycles/period=
=3D40000,acr_mask=3D0x3/u}"
> +  pebs_events=3D"{instructions/period=3D20000,acr_mask=3D0x2/pu,cycles/p=
eriod=3D40000,acr_mask=3D0x3/u}"

Does this test configuration actually verify that self-reloaded events do n=
ot
generate records?

The test runs the thloop workload, which is a tight CPU loop with an inhere=
ntly
high IPC (typically > 0.5). With periods of 20000 for instructions and 40000
for cycles, the instructions event will always overflow first.

When the instructions event overflows, its acr_mask=3D0x2 triggers an auto-=
reload
of the cycles counter, resetting its progress toward overflow.

Because it is continually reset by the instructions event before reaching
40000, the cycles counter never overflows.

The test asserts that no records are generated for cycles and passes, but is
this simply because the event never fired rather than due to self-reloaded =
PMI
suppression working correctly?

If the hardware PMI suppression for self-reloaded events was broken, wouldn=
't
this test still pass?

Additionally, if the test ran on a system with IPC < 0.5, wouldn't the cycl=
es
event overflow first, resetting both itself and instructions (acr_mask=3D0x=
3)?
This would prevent instructions from generating a record, causing the test
to fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413010920.5465=
01-1-dapeng1.mi@linux.intel.com?part=3D1
