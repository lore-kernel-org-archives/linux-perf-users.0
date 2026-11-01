Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793563947;
	b=W+ADIbyyQtw92ztwq43VyeSRjVDe2wzG2D8tpk0JE1OIOvX3brlgC4uh/USpRYLKDfaA
	 w+eg0NMnLK9Ga/g+T+xfDaJ4zdPHBlSe7I8hL/Hc6tuzn8urFebj9dl/64JfseW1Mgj4Y
	 vcedcDTzkvxg6OxzGnO9oxdoFWYwdM7OiJXgZeGQM53QrcEfannxObjyS4agxQzVEUSvd
	 sXQ1KvKluafyyvg60VAkwCkgSKIx8wrjzYIplnksSsUywtDqmR/aF7+XDrEfPUWvMW9Gg
	 mKeLd0K3JtvJ+A5ZE98mC/ca0Q/SlF0b+aAbQzO1yrbz+A1X2gsDYg4wgq3XvuSuyLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793563947;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VocMc75OJsqg09kADb82kK+56yqomlCH4rWFFiLJ5kc=;
	b=F+Amcv0LoKOKxr4qAnUvGt03zvWfS5TJtEGZ1zC0iru0m3p03JtsgiGrX6Qk97BRXndc
	 AyBI+81sQyj3Q+hQzvOOfI6X2vq9qHTXYolv69xT5ejjeaZl9R8XVyprUYKlIC1C7LXYu
	 Ep+3Y2X8tJIdtkuqPZmo3c+bBDLa9E6GCieYZjIXMvmM/b2scl2t2zb+XudOkR58t9soU
	 njvVtCtnA0PqwcmT7+6W6lWehn0wFgR/8rthAqjuofTanrAuRA0jsKKv0Wlu+8tJWgmNI
	 Bv9HO6j1Dt6BC/BKq42Z4pb7MVNc3vo853l8+G4YLR1/LaXZp+DHIXw33HQb4zBL4ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLnCKbRr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412FA606A324
	for <linux-perf-users@vger.kernel.org>; Sun,  1 Nov 2026 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLnCKbRr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82001F000C1;
	Sun,  1 Nov 2026 20:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793563947;
	bh=VocMc75OJsqg09kADb82kK+56yqomlCH4rWFFiLJ5kc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZLnCKbRrI+DEVqgTjr/Tp/uSh0NFOtCDYhJhJcLLnSpEFsBv7aU9DPSNf4fVmVqHB
	 e62nUNjms71XD+F1jqx8kzsPaa/McoZK/JXX5oKSK1UfcHn4TmBue6LvCjPUHWwAIz
	 /iaU9NQQOLN+jWcEo01uzlTHLLoyp3VG58Fn2nPbhtPFtZ1i+LwR30F/GbckqDOjbF
	 UKW6rOeC/NbYSH5pD+cLRxuJTfwhpDR9XuW2Xce+lhzxHyJhqDCWAqjKh5J07Pnw8b
	 h3W0ZabvuaetYVAfNcXBZ7zJF2sPiBwjM2X762R03F3hJiiB0flKi4VEhgsZZrXlp2
	 k3x6iTVfUkmCQ==
Message-ID: <sashiko-outbox-192656@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/7] alpha/perf: implement ProfileMe sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261101-alpha-profileme-v3-5-92d511b5a044@gmail.com>
References: <20261101-alpha-profileme-v3-0-92d511b5a044@gmail.com>
 <20261101-alpha-profileme-v3-5-92d511b5a044@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 20:12:26 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] alpha/perf: perf_get_regs_user() checks PMPC instead of interrup=
ted PC
--

commit b49acea08699ec26b74c2c7c29ccc098435ea611
Author: Matt Turner <mattst88@gmail.com>

alpha/perf: implement ProfileMe sampling

This commit implements ProfileMe sampling mode on Alpha EV67 and later
processors, selectable via the profileme config attribute or precise_ip. It
attributes samples to the instruction address latched in PMPC, adjusts for
I_STAT instruction overcount, and works around PALcode counter overflow
restrictions when stopping or rearming counters.

> diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_even=
t.c
> index ecec78c355cd3..f55ddab7478e0 100644
> --- a/arch/alpha/kernel/perf_event.c
> +++ b/arch/alpha/kernel/perf_event.c
[ ... ]
> @@ -835,6 +939,131 @@ void perf_event_print_debug(void)
[ ... ]
> +static void alpha_perf_event_profileme(struct perf_event *event,
> +				       struct hw_perf_event *hwc,
> +				       struct pt_regs *regs)
> +{
[ ... ]
> +	pm_regs =3D regs;
> +	pc =3D pmpc & EV67_PMPC_PC_MASK;
> +	if (pmpc & EV67_PMPC_PAL) {
> +		pc =3D regs->pc;
> +	} else if (pc < TASK_SIZE && !user_mode(regs)) {
> +		if (is_user_task(current)) {
> +			pc_only =3D true;
> +			pm_regs =3D this_cpu_ptr(&alpha_profileme_regs);
> +			memset(pm_regs, 0, sizeof(*pm_regs));
> +			/* PS bit 3 is the mode bit that user_mode() tests. */
> +			pm_regs->ps =3D 8;
> +		} else {
> +			pc =3D regs->pc;
> +		}
> +	} else if (pc >=3D TASK_SIZE && user_mode(regs)) {
> +		pm_regs =3D this_cpu_ptr(&alpha_profileme_regs);
> +		memset(pm_regs, 0, sizeof(*pm_regs));
> +	}
> +
> +	perf_sample_data_init(&data, 0, hwc->last_period);
> +	if (pc_only)
> +		alpha_profileme_drop_regs(event, &data, PERF_SAMPLE_REGS_USER |
> +							PERF_SAMPLE_REGS_INTR);
> +	/*
> +	 * perf_get_regs_user() has the same check, but it will find the PMPC
> +	 * in regs->pc rather than where the interrupt was taken.
> +	 */
> +	else if (!user_mode(regs) && in_entry_save_code(regs->pc))
> +		alpha_profileme_drop_regs(event, &data, PERF_SAMPLE_REGS_USER);
> +
> +	if (!alpha_perf_event_set_period(event, hwc, 0))
> +		return;
> +
> +	saved_pc =3D pm_regs->pc;
> +	saved_ps =3D pm_regs->ps;
> +	pm_regs->pc =3D pc;
> +	/* PS bit 3 is the mode bit that user_mode() tests. */
> +	if (pc >=3D TASK_SIZE)
> +		pm_regs->ps &=3D ~8UL;
> +
> +	perf_event_overflow(event, &data, pm_regs);

[Severity: Medium]
When a ProfileMe sample has a kernel PMPC inside the entry save range
(in_entry_save_code(pc) is true), but the performance counter interrupt its=
elf
is taken after leaving that range=E2=80=94either later in kernel mode after=
 SAVE_ALL
has populated task_pt_regs(current), or after returning to user mode where
user_mode(regs) is true=E2=80=94alpha_perf_event_profileme() does not call
alpha_profileme_drop_regs() because in_entry_save_code(regs->pc) is false.

It then sets pm_regs->pc =3D pc and clears the user mode bit in pm_regs->ps=
 (or
uses the zeroed per-CPU alpha_profileme_regs when user_mode(regs) is true)
before calling perf_event_overflow().

During sample preparation, perf_event_overflow() -> __perf_event_overflow()=
 ->
perf_prepare_sample() -> perf_sample_regs_user() sees !user_mode(pm_regs) a=
nd
calls perf_get_regs_user():

arch/alpha/kernel/perf_regs.c:perf_get_regs_user() {
	if (in_entry_save_code(regs->pc)) {
		regs_user->regs =3D NULL;
		regs_user->abi =3D PERF_SAMPLE_REGS_ABI_NONE;
		return;
	}

	regs_user->regs =3D task_pt_regs(current);
	regs_user->abi =3D perf_reg_abi(current);
}

Because perf_get_regs_user() checks in_entry_save_code(pm_regs->pc), which =
is
now the PMPC rather than the interrupted PC regs->pc, won't it falsely disc=
ard
valid PERF_SAMPLE_REGS_USER and PERF_SAMPLE_STACK_USER data whenever the
profiled instruction is in __entry_save_start..__entry_save_end even though
the interrupt was delivered after the user frame was completely saved (or
after returning to user mode)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101-alpha-prof=
ileme-v3-0-92d511b5a044@gmail.com?part=3D5
