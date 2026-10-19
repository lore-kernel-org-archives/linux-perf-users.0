Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7C54F7998
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416889; cv=none; b=LrJW0u+LD3fKRrLGRUsYf6LUb2lTMDLCvFErvLGdvfXqAFyevrsG19wMjMIN/8PzIffIvjmnp3i+i+ExSERVKk9mbNUU6f4euD6QFxN4Cq1EEkUZdK4Z84JMWAQbTTVFVnL6J61hW34p9SMKclRWSk8E9WF5+s1Xi+LG2YMMw9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416889; c=relaxed/simple;
	bh=JBmQUOPFmEU8wEEBTXAmbKhHIQ63etfLwdP4ZzrBtgw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=NvArh0N22DuHQGCH/DQ4NBC5kSFYxPY7CdL0cbOFFA6LYFs7k9N0aTcK1vjytVTmoKz5LDGYpJAfHlUaFVJFzp7eTHwRarL9OET6IsIRqQdbUItPlEQMofhMU3QT3ConO3xmKxlO2Gcz6Ip3YfonX5cIu4XpYlaryCloNb3TsSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq9Drwbr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq9Drwbr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6CE1F000C4;
	Mon, 19 Oct 2026 13:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792416884;
	bh=JBmQUOPFmEU8wEEBTXAmbKhHIQ63etfLwdP4ZzrBtgw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lq9Drwbr4TNlT5Y24nOr5CoT8yLnvmp9xJmA9iNhlB3qgkxSE+K7KMtH/PB0gFB1J
	 6ipf5XaUKcnAHqlJQMFVc1UY0+huZKRZDEKMl2jG1i2FUIBuXb2580V3wrbuNIctgG
	 CUO3eLZGfMZv4tm4CDnlPPuT8hYM1eoG27Kc19EDANTalYyj7UyjRDaQfQMPHE1rPx
	 QmjOgsePAbQxb8jXvv8XFRRz0/ZXcoChika+L6cNueDJP7Zo1gMlt0bX5a97zEytLg
	 A77/fbSBjHQiodi3wrzBsD2fVifXBUbYKuoJNWqYj0fqcNmXZE3PhYarjRSKpIqUSM
	 D2Y3GXrSydC+A==
Message-ID: <sashiko-outbox-177166@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 20/49] perf: RISC-V: Move
 CPUHP_AP_PERF_RISCV_STARTING post stop_machine()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Frederic Weisbecker" <frederic@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019130856.49711-21-frederic@kernel.org>
References: <20261019130856.49711-1-frederic@kernel.org>
 <20261019130856.49711-21-frederic@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 13:34:44 +0000
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
> The teardown callback here:
>=20
> * Disables the per-cpu IRQ
> * Disables user-mode access to the CPU counter
> * Disables the shared memory snapshot of the CPU PMU.
>=20
> All these operations are local to the CPU and should be able to execute
> concurrently with other CPUs.
>=20
> Move this teardown callback to post stop_machine() accordingly.
>=20
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019130856.4971=
1-1-frederic@kernel.org?part=3D20

