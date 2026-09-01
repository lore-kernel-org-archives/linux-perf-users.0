Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBB442980B
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Sep 2026 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788281226; cv=none; b=T6NKiuWMiFh73LSKcZrVYXIyvAwp/5gq/yMCe/y+2z0Qb3HWOl7YQLyR7DZW6jU8JqlLG6TRwjh5zlsLBPQt84xhlmRWLzIicbCPXqhTzQuoNeUPQF6ZoH1Ak3I64LTxVuKYzWOf/1i/UUdhAv6JagIeK06JUNq698KkgJtlQTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788281226; c=relaxed/simple;
	bh=167TCXbkjQEjTJuV7CBB+8EbsLTAO48KVgbkzg+wuSE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PFXiwkw1S0wUih29CTQ0vUcvialwrxT+B6JveTRW3YCWzR/aC/lhy6ga3UuhgntDYdlozI3esJW1eoC1S8aapiOWftenUN/BtagtPF8xyZLdjw4ElvYReCW6P2Tnvr335FhOuPQDn9qnNdbJwj1wTiZ6ZUUZdaByiClxq+kUFlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHHsmDG+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHHsmDG+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042781F000E9;
	Tue,  1 Sep 2026 16:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788281225;
	bh=ZvknHMHDtf7PnYXkr/4FcJMt9ieDF++jfkbe/cLYmyE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nHHsmDG+w2yDUFYWdDs9Ejnmw+EtNdPC9E160XW2QOLCCV4GtMbIk/C6DSRg3wIOx
	 FjzrFfbolb+lBBLRkPsJjqs4SUMiGtHZt6rBokFkqkrJ9jXmHrZ2Km0eqyhg/vZt3a
	 hbPyOZ8Xmv5x3lFZ+/6+u3InjIRB9O29R0Ln9Z7ZLyOSplMYwzwW2xMKxDYpM3fezY
	 Svr7WUXkz3wv+xsp7uz/CegDCngLmRllnQcxhDH1/S2wPjYfQ/pbPTQe+MAT5Lg6Fd
	 +i0SlsdsMpbMyDL6elvlui/TAI/g+tLsm3TeNzXpZFlU8vSJ6fJiXH3kQBGZbIZINZ
	 B1INbEQkZhDCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] perf: arm_spe: Suppress redundant ITRACE start
 records
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260901-perf_suppress_itrace_start_records-v1-2-c4fbc6860859@arm.com>
References: <20260901-perf_suppress_itrace_start_records-v1-0-c4fbc6860859@arm.com>
 <20260901-perf_suppress_itrace_start_records-v1-2-c4fbc6860859@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 16:47:04 +0000
Message-Id: <20260901164705.042781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] ITRACE_START records are not suppressed for inherited events due=
 to a child/parent event state mismatch.
--

commit 0683c3b2471a719bb066f5dd9a93d7a7f192399a
Author: Leo Yan <leo.yan@arm.com>

perf: arm_spe: Suppress redundant ITRACE start records

This commit calls perf_event_itrace_started() at the start of an event to
prevent the perf core from emitting redundant PERF_RECORD_ITRACE_START
records on subsequent schedule-ins.

> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index b70f3fedf0282..40314ef8b731e 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -890,6 +890,8 @@ static void arm_spe_pmu_start(struct perf_event *even=
t, int flags)
>  		return;
>  	}
> =20
> +	perf_event_itrace_started(event);
> +

[Severity: Medium]
Does this correctly suppress redundant records for inherited events?

The core event scheduling path in perf_log_itrace_start() internally resolv=
es
to event->parent before checking for the PERF_ATTACH_ITRACE flag.=20

Since perf_event_itrace_started() only mutates the local child event's
attach_state, the parent event's flag remains permanently unset.=20

Won't this cause the perf core to continue emitting redundant ITRACE_START
records on every subsequent schedule-in for inherited events, negating the
intended fix?

>  	reg =3D arm_spe_event_to_pmsfcr(event);
>  	write_sysreg_s(reg, SYS_PMSFCR_EL1);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-perf_suppr=
ess_itrace_start_records-v1-0-c4fbc6860859@arm.com?part=3D2
