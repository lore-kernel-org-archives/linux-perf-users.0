Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B696438DC5D;
	Mon, 21 Sep 2026 19:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018708; cv=none; b=Q72BrOwXbKM2snG/9D8JI0CIRqa51SHR74lEqT5TmwxS0w1IDm8zlXmSuZ+j2YTCm28KA6+IrZ1zuCbWFSmZ1Wv7t4ZV38ZwSlQJ7VEwLl00e2RUwES1XnVXBr3Nso6QCJmeG7egMrh4ur0mtRHK4N14/Sm2Hg/gPU2G03ma/tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018708; c=relaxed/simple;
	bh=PkT+ReiVOLPvVpDSiKudmbYrahaKPm0gYAiz5tbWZgE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g8Wwh7xjaAvD59QLqRXxQa+5p6KBlGE/aQR07hhX7X2EXaU7O7+wYmsgBh4Q3SYyuiiSWLNS3VIqZiw95vfsPpb+TQfggDwDBUyyAHTKABO0s7gD200wC9GqegU/gkIt8fYploI5yqAztvBe4regO+Bzcn/cwlfQyioNnWrm50k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XohH25s7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XohH25s7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBC21F00893;
	Mon, 21 Sep 2026 19:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790018707;
	bh=mvfUYnqpNXdlkOFPTlMQVuPO5lAKzfXiH8Vrt3yDm/Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XohH25s7K67QHzWN6+arb+xeDspJCDWsdi+nk1IobY74T4cosg88+8HfzIutVwg7Z
	 6xRqJ9c5g0cAPlGSD3X/mAI3h2n97aSKtrdVAErfFWQN6UIXIZXRh1cZRyTpAIojY6
	 RIZENtW0l3FS0uE1zPbHQNu2fkjd0FgVyfy2czPFznjst5ketCFtwjxyoQwYFl/bIs
	 1KMFlwRRxjjZnczAs4XwLZXQAjQMaPfem37A9x7JzC7Op9fib/hDKQI5llL5MFGXow
	 ocdNw6Sp+gexLK4ibyV/QSO62M9ICIJC3y3rC8FOR1wiH6sSDGhjt1ikuujfrkUvvu
	 uN5rmCHeGnGZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/10] perf/x86/intel: Check only PMC bits in
 PEBS_ENABLED when detecting host PEBS usage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260921191418.950933-11-seanjc@google.com>
References: <20260921191418.950933-1-seanjc@google.com>
 <20260921191418.950933-11-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 19:25:06 +0000
Message-Id: <20260921192507.6DBC21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When checking to see if guest PEBS usage should be disabled due to host
> PEBS usage, filter out non-counter bits in PEBS_ENABLE to avoid getting
> false positives in the unlikely scenario that "Enable Precise Store" is
> enabled without PEBS actually being active for any PMCs.
>=20
> Note, the other "hidden" usage of pebs_mask is already explicitly masked
> with intel_ctrl:
>=20
>   .guest =3D intel_ctrl & ~cpuc->intel_ctrl_exclude_guest_mask & ~pebs_ma=
sk,
>=20
> I.e. removing the non-counter bits from pebs_mask doesn't change the value
> that is loaded into arr[global_ctrl].guest.
>=20
> Fixes: 854250329c02 ("KVM: x86/pmu: Disable guest PEBS temporarily in two=
 rare situations")
> Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260508234018.F06AEC2BCB0@smtp.kerne=
l.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921191418.9509=
33-1-seanjc@google.com?part=3D10

