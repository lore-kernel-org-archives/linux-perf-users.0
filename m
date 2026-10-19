Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8702229992B
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416896; cv=none; b=EabGU+EI39+FiWp3lySxVh1yV5XS+kE2OIR2u0lx7NIqtvhUab2hl9iNobQkTQnmxNwGtmXGOpDfdXCDZfIc6Fn7JMy1flVHL+9p1Hhx2fViSI+SzGJlv0uu7RwPhMwVSY7ON3l9/yx89f29/8s2z/cC3k4CD1f7k/IcYW7OEaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416896; c=relaxed/simple;
	bh=ChVgcZVMS/wESlyHvZkwp3pD8AHGcTzYJcSG1dRaFW4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BgTAd6LGZ0INDiLTvB5rHs8Sly7Euhu2c4JpFOVYnRhHAS9jNCfAywP7xGi8teIDLQrtPkzuvUqUm/6Tui4ovDi6WiRcJRFxbiYb9+tgs643LLoQ5/lS9FMNIABgSrnVKTlEvDHzH1RZ3sGclZvrf5ksHBT+Lwg6Cd/ObauB44Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hb1q1hXY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hb1q1hXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE4B1F000C4;
	Mon, 19 Oct 2026 13:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792416895;
	bh=ChVgcZVMS/wESlyHvZkwp3pD8AHGcTzYJcSG1dRaFW4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hb1q1hXYz0CAq1Z0Mq5dUjQZWGAkQUwb6mk3UBtTKAyAYc0siB4LLx9uCwrxGlMr7
	 ZroS/3+8TrxUh/MOryW+1f83btfBy5UZTQSRHDBY+M/oPSBVEGiVbnTlNqUWjJQN1Q
	 ZJIq2QsySdOQ8GI8FH3JOh3yVfzQOwo0hQtd5pReRAu3AjkIS9fREny1PguEm1sXDr
	 QT6scI4288luwhtr6re/als0h+OOInLdocA2mQPljXgpK2bYtBHNljNMlVOaNZycUs
	 g1u0pRw1R0m34Nd8QyMEN8mpykCoammAnREF5z108w9dsg8UVXwrCrSBpp6XViQX6m
	 5kpLs3HOem1og==
Message-ID: <sashiko-outbox-177167@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 19/49] perf/arm_pmu: Move CPUHP_AP_PERF_ARM_STARTING
 post stop_machine()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Frederic Weisbecker" <frederic@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019130856.49711-20-frederic@kernel.org>
References: <20261019130856.49711-1-frederic@kernel.org>
 <20261019130856.49711-20-frederic@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 13:34:54 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Between CPUHP_TEARDOWN_CPU and CPUHP_AP_OFFLINE, stop_machine executes
> all the teardown callbacks while stopping all CPUs in the system. This
> doesn't mix-up well with running RT or isolated tasks.
>=20
> In order to transition smoothly from global stop_machine to finer
> grained synchronization between teardown callbacks and the other CPUs,
> a new stop machine post function has been introduced to be executed
> after the main one with IRQs still disabled while other CPUs can exit
> stop_machine().
>=20
> The teardown callback here just disables the IRQs for each PMUs, which
> shouldn't expose any specific race while other CPUs are running.
>=20
> Move it to post stop_machine() accordingly.
>=20
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019130856.4971=
1-1-frederic@kernel.org?part=3D19

