Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCA9377AAA
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991215; cv=none; b=XccdLHv6Vm5ttzJi1cpIYUsZhl16IyfQPFOnVpKN48uxRy4BPreHupIbPuHOTHG1W0odN85RxkAjSDeXBHpHO9iV+YuULFecQUP8SjY2eAza774nO3vPcFo0W1I1taclTwpLu1v3kpS7mpJqjRF9Bp++SXs9XHoXYgiMgTp8mDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991215; c=relaxed/simple;
	bh=a0y1t5hpPfip/L6tJ6UCj8g5ahWsIZIGHJrSy/mdvWE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HCDRaOVcgEQgU6khp08oK6FbpnpseOqKIiX+DO9PHmEfiA4GWBhcW01vH4R6eq326q6xtamP2fX8Y6ZYqaf70JyjAOHBWh4fSwWywIYPCco2664gJwhZvTXxQZj8gRSNjfYUkb1Zr7gGUcHJYIo7aaj3DHg8bHHKKT8zd44Vay0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz12FPTA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz12FPTA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6D71F00898;
	Sat,  3 Oct 2026 01:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991214;
	bh=a0y1t5hpPfip/L6tJ6UCj8g5ahWsIZIGHJrSy/mdvWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sz12FPTAXFOTT9RL21R0w1CJ8J2szQyKW862iNyNmrAxl3OLGEt67E6TWubRUqRJY
	 rPnVrudyDT2x/LlJ+BeMbY66Ma6qa1zkZn8d2i5tzpqsIyJIABewRvmOZ7WVr4YUms
	 kJnPoV9nbdR15iIcP2yCFDqfo4c//Ezx9ZteynBKMluWxqUuLVo9MbzcvzDyMRHPKd
	 GZ2DdQZnnc5uWHJLo8o9iizWQndiIeHop7R+slKSirqXbwiTIVQFwjiOh4yLqwKlsW
	 Fvve/RiYrMzQKSm7YmnHpyp+BjUzKWdKqaT7lTVm02Cp3fy82FkoCaQmG9F+izryi4
	 SwI5s0xBGFTDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 13/13] perf test: Test perf timechart --live
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002182624.3259797-14-irogers@google.com>
References: <20261002182624.3259797-1-irogers@google.com>
 <20261002182624.3259797-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:33 +0000
Message-Id: <20261003013334.1A6D71F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Alice Rogers <alice.mei.rogers@gmail.com>
>=20
> Extend test_ttimechart_python.sh to cover --live option validation,
> LiveRecorder's perf record subprocess, control pipe and -o output file,
> a synthetic live UI test exercising the rolling window, pruning,
> pause/resume and zoom following, and a live workload recording test when
> scheduler tracepoints are accessible.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
> Co-developed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002182624.3259=
797-1-irogers@google.com?part=3D13

