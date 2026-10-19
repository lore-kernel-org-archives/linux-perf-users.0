Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389844E36EF
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416875; cv=none; b=WU3QV/zjNcRet2yIDtG63grGSu6HFVXAneSnS8SZx+YeA4mpriG7zSw1zwcNmOe0T6b27GY39gwloAqxLBw8YJenUBqPunH+5d7Gteg1QQk5Or6kiAd7nNC4e10hUhfynTt1emvb2Tz5rqNtVZZv+VlkZYwpJb/NMT3tYx1RABw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416875; c=relaxed/simple;
	bh=MWxaae39WpacfBXQM6aGPKPsMovmW7LfVY3IunT46TQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=k70SEukWFpqO0fyqgLjdhi1PtKL5rs3HxPHeAFwZiJZZ+9lKQTpMC+H3Hl+iEzKis+QS6RTaBV/yPuvR1egwxo3BkKc/VlXracMBtn77AuOfskiQaYsHOT+9sHdWSpSzWcIwEPgxl2aXdmqeAyRcx5K4S6VrJuZjo3K6Par9lAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSFQ2Ek1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSFQ2Ek1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3641F000C4;
	Mon, 19 Oct 2026 13:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792416874;
	bh=AKvEnItM2m8WwTj/LT+h5DrQ5UB5SUsLoB6A1RqS/QY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RSFQ2Ek1UpZS4gQJoSkCFzi8PxD6XJSh/5jTyG6KCdIy+7YuOhWZM5f+lnzP8oHxM
	 qMb675r30a+oFyrBjKHH7NHUBgCIQm37M96D5F3DaPHHP25N1obJ391q7a2N1YNf8u
	 znhlpLH2vaY8SzGKY54I8cR4S95SmQs1CmdfIC7vL+ktItwnU8hjt/wHX52zc8cw+Q
	 f/I9ZI9Ahi86mywDOkq12yn42EoGq2h8LlKpA0uoBJizVWq3gZtk4QOjM41U6ETdfd
	 8Xm9RKav3QAEa43rK1SrZL2zMKNMvYMVQV+ZEgtpdVsve02BoeZzi+xB8frm7yD8Jg
	 BDE8fLHzjfZyw==
Message-ID: <sashiko-outbox-177165@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 14/49] perf/x86: Move CPUHP_AP_PERF_X86_STARTING
 post stop_machine()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Frederic Weisbecker" <frederic@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019130856.49711-15-frederic@kernel.org>
References: <20261019130856.49711-1-frederic@kernel.org>
 <20261019130856.49711-15-frederic@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 13:34:33 +0000
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
> Here only intel has a dying callback (intel_pmu_cpu_dying()) which does:
>=20
> * Deallocate the per CPU DS structure on the MSR_IA32_DS_AREA. This is
>   already racy against offlining CPUs because all possible CPUs's MSR
>   are written on a hardware event initialization, which still can happen
>   before the CPU actually goes off.
>=20
> * Deallocate PEBS buffer. This is already well synchronized against
>   hotplug up callback.
>=20
> Therefore the related teardwown callback can run concurrently with other
> CPUs.
>=20
> Move it to post stop_machine() accordingly.
>=20
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019130856.4971=
1-1-frederic@kernel.org?part=3D14

