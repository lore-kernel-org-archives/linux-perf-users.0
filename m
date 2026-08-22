Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C1B2F9D85;
	Sat, 22 Aug 2026 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787391643; cv=none; b=fpkA/7DFYMu0KsceDwMbLdlrfT2HNYp74GW4Xa2ESFx+cWomotOQIy6fLllYunQW4ynsigcMfOx9Zm1zLBbTgqgv16ZAkN0uU8GHrIwINDPFxzdfrrqHaNJNCfVw+TCbZUqKnk811VQkqkOpuKWvdTEf73/06GBiO7yUq7UWBdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787391643; c=relaxed/simple;
	bh=HCCg502uN0QfLaS1iV+LGstzM+4VOKox4V7uvPKLM0s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fsFDNwFtnIF9SDwKgoJV/Rvb/PASMZOIzS2eMqLJlBZbSmaAXMo+UkO0xnpc/0+jIPjgS6amAf7xjofcRQ8w+XIbJjE7+DYvjBIv3NRTz+Goy061IumLJjErEklvu5zFazSoYGJnklzaR8SzYdVmHzyIwOc1ypyXUkXNDEZn1+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUyMzQau; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUyMzQau"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C07E1F000E9;
	Sat, 22 Aug 2026 09:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787391641;
	bh=8Fzcagv0OSrm72TjG9JD2KcrI34kesSSRYJnPNRxIaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cUyMzQauOtwM+W+55oSThF3uxfyB6PsWI0aQtPIb4YT6KUTab512FxUmm2kNXynTP
	 YAoSOIp7FwwHIbf+h0D94rwbjbdq4uNmu+Zk6PiLlZb1g35HVmjEy2i2619nQHDA/2
	 AhGAiCYCQB2M48/YChnZ3f+lK2p9MfebAwO/3sbE3oyaosNMm0jlFDPpTyShIH2ku8
	 EZBOo2b/ML8y20pBVZmsacPMGK+cFBQqvKkWIK4WPXGME2tSEwm1+jDyMp0pF1LxJT
	 DAUxVf4mlPoiAMtGsT6yYA4znRqfdN3eH2p9esl1SNj4VamS5/XimalL/aCtkkudzG
	 9eh54uPCD0gAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 11/12] tracing/wprobe: Support BTF typecast in
 fetchargs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <178739071567.1520941.13040906773998632325.stgit@devnote2>
References: <178739053919.1520941.17662338993878200834.stgit@devnote2>
 <178739071567.1520941.13040906773998632325.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 09:40:41 +0000
Message-Id: <20260822094041.7C07E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Allow BTF typecast syntax (STRUCT)FETCHARG->MEMBER in wprobe event
> fetchargs. Previously, handle_typecast() rejected any probe context
> that was not a function entry/return or tracepoint event probe.
>=20
> Wprobe events use $addr (the accessed address) and $value (the value
> at that address). By enabling BTF typecast, users can now cast these
> to a concrete struct type and access its fields directly. For example:
>=20
>   echo 'w:watch rw@0:8 dflag=3D(dentry)$addr->d_flags' >> dynamic_events
>=20
> With a set_wprobe trigger pointing the watchpoint at a dentry address,
> the resulting trace shows d_flags being accessed at that location.
>=20
> Note that $addr and $value are restricted to kernel-space memory,
> which is consistent with the existing TPARG_FL_KERNEL flag used when
> parsing wprobe fetchargs.
>=20
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178739053919.152094=
1.17662338993878200834.stgit@devnote2?part=3D11

