Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F062BD09;
	Mon, 12 Oct 2026 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791796713; cv=none; b=hpMi+x9azWyVqt5xSfhOM7QJroJSuOkqFrWPulNHUjk9tVyuN/XTkH6whOEjXdVnniTpZDPc3t1GtzSRi9cvZPKdCsQYDMiHToQR5AHlUybS6h8ftRPP04IY7uA4JLUuEOB+UyxGiJcK7k7486prIE38Pyt+FRaOSoFbDGp5bjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791796713; c=relaxed/simple;
	bh=vqjizv+JTC7L8G/nTAjgrqUUHGL6gFbVw2GUatial3k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Jzjb2EHFHMmGnI5JaJ8Xa6JGnBcXeb5in3fFjsMeURGisEVwSnQ1zfTL3AtbvwBSLgE21FeZbvMyiGYTIasQvaUrYPFQvrna2lOEQj7MAyjXEeTJGvLaOin+p3Z8XdsNe0WBL5i9vcsGaN4q2RNKF1vlYG89cUtyXtdkGdFmaYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXQ6xZX1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXQ6xZX1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7D71F0089B;
	Mon, 12 Oct 2026 09:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791796711;
	bh=zGiNKDai4F6KNR5S5mdzaymXVKj523hVp03egq68vWs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RXQ6xZX1mXThb4Wy/oQJz5UDOVOTTwUQDsYNgwXF2M/PumWhspPe36mN1Y5y8PYD0
	 qr4DXzmNaFnVOghtixRfh6vVCzw9zXa9QQXz+7qAR8AlBcE1ax7b04YjLV1U/sPBiz
	 rLYCCrFAQJUJlGFEBFEK7W+q2xhFNnZWTJxgNwsiz91DxZJWwT95/OTln/MKXVsBkg
	 X1iq2VOqKOmxXtgkfH4D06kRWAmJ0ftOke0OZwImbxLQTK6OXYfV5jwQl5SF+Z8u3j
	 eaypGH2e7yjS4/+WADplnAVx2Ps4p2W45+gTojcdduNs+RV33t1LbZgnlktuOkADxx
	 rMysso0fKYNlQ==
Message-ID: <sashiko-outbox-167891@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] ARM, ARM64, LONGARCH, XTENSA: Delay HW BP
 notification to task_work()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20261012090431.TF3iVDsk@linutronix.de>
References: <20261012090431.TF3iVDsk@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 09:18:30 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] perf: ODR violation and ABI mismatch in struct perf_event due =
to unexported macro
--

commit fc15e8519a12261f55ee613e302041c25e4218d0
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

ARM, ARM64, LONGARCH, XTENSA: Delay HW BP notification to task_work()

This commit delays the hardware event delivery callback to task_work() to
fix sleeping while atomic warnings on PREEMPT_RT. It implements a generic
perf callback perf_hwbp_notify() and adds ARCH_NEED_PERF_HW_NOTIFY to
supported architectures.

Closes: https://lore.kernel.org/all/aho0eqjMESuHxECr@redhat.com/

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -215,6 +215,10 @@ struct hw_perf_event {
> =20
>  	/* Last sync'ed generation of filters */
>  	unsigned long			addr_filters_gen;
> +#ifdef ARCH_NEED_PERF_HW_NOTIFY
> +	struct callback_head		arch_hw_notif;
> +	int				arch_hw_notif_busy;
> +#endif

[Severity: Critical]
Does this cause an ABI mismatch and One Definition Rule violation across
the kernel?

The ARCH_NEED_PERF_HW_NOTIFY macro is defined in architecture-specific
headers like arch/arm64/include/asm/hw_breakpoint.h, but it is used here
in the generic include/linux/perf_event.h header.

Because linux/perf_event.h does not universally include asm/hw_breakpoint.h,
translation units that include linux/perf_event.h without previously
including the architecture hardware breakpoint header will evaluate
struct hw_perf_event without these fields. Since struct hw_perf_event
is embedded in struct perf_event, this alters the size and member offsets
of struct perf_event across different subsystems.

Can this lead to memory corruption when perf_event objects are passed
between translation units with mismatched struct definitions? Should these
conditional fields be driven by a globally visible Kconfig symbol instead?

> =20
>  /*
>   * hw_perf_event::state flags; used to track the PERF_EF_* state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012090431.TF3i=
VDsk@linutronix.de?part=3D1
