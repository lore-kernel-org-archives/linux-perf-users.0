Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A72355049
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085829; cv=none; b=gjlsaQbnB29Qd0wpFkKQec+3nakgjM8q3m9k5OG29n68GMR+ztW/ft9juuSy//ZAw57Gad2wBir96iHnF6XLJJxZZpfWf0j+MWS6Phw8HkSoB47FRDIM0lRKRCaKX360AGoyLPcV5/NdjYj6CJc47uUXWy0VnX7mCYdUW0Ffuo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085829; c=relaxed/simple;
	bh=ccNpprIl2tUoErSSWy33L81i2BHBHpmqhiegIR3q24M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jR6AP3J5UFvGeVkPjeexogWn7Xmpng1ifYlq2HXgo9SWybqUWoVau17TZNZO9P+T66gK1mtyTEGyFj6JL1FK81LZQHtVTSPwXKzoSzJPYc4h3KnC6mC5Lwco1+S5BYixo/xyqpRwFMYC/4Hh8SuH+K5GESQHZ5+TNShdNftJohA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0X5REO6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0X5REO6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C491F000FF;
	Tue, 22 Sep 2026 14:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790085828;
	bh=ccNpprIl2tUoErSSWy33L81i2BHBHpmqhiegIR3q24M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V0X5REO6mzFkKWnY6U9SmHB8+OnyRYVw4MAxnjKg8m3hslz0AfxfqLlFty3qV8uHm
	 WgsuMX6AegchHSDJcMjhL+x72F0WBLSlqppUbGV0j1S5hIGg6vpkCWV7qEhOW5bPYh
	 NyjMSLZBLxiIygu9DXlqxoRFyVvmEjjKNttY5ccxy8mVDb2csqfSk511AHamJT/9mu
	 vRE6uWndNHkDxc5brm6Pa632neD1jBcWeZz+9mSE+gGprbohdy6c6KFXXgS8/Br/6q
	 Irz6TpStUaMDzpUA2xjNo+GKFINSIplQ6Aip7g67/6MvPyaYZm2/g6tdUiofwO5WJ1
	 Riry8kIG11PWQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/2] perf/core: Let an arch prepare the user stack
 before it is dumped
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stian Halseth" <stian@itx.no>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260922135653.1622301-2-stian@itx.no>
References: <20260922135653.1622301-1-stian@itx.no>
 <20260922135653.1622301-2-stian@itx.no>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 14:03:47 +0000
Message-Id: <20260922140348.46C491F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> PERF_SAMPLE_STACK_USER copies the user stack as it is in memory, which
> assumes the whole call chain is there. On sparc the sampled window's
> %l and %i registers, including the frame pointer and return address an
> unwinder starts from, may still be in the register file: they only
> reach the stack when a window spills. perf_callchain_user() already
> handles this for the callchain by calling flushw_user() first; the user
> stack dump has no equivalent arch entry point.
>=20
> Add perf_arch_prepare_ustack(), a no-op by default, called from
> perf_prepare_sample() before the dump size is computed, so an arch can
> write back whatever part of the user's stack state it still holds in
> registers. Doing this in the arch PMU interrupt handler would not do:
> software events such as cpu-clock reach perf_event_overflow() without
> passing through it.
>=20
> Signed-off-by: Stian Halseth <stian@itx.no>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922135653.1622=
301-1-stian@itx.no?part=3D1

