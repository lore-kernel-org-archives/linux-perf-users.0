Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792878181;
	b=OiR8drnMRuFDoIaxRCHDybb4Z8ffMByN4rgLOc8Xs+ARcbCCutApgcDSZOGXnUkNiLxW
	 0371ej+azpL5TJC3OpzvINPVQ6UbuK2nR5KyNN6vuV7SYClAWi0OoSE7UA7/DGWVGeCDn
	 cVlLTpBIP6rIhRvIA9Bkt3Pxploz51arDHOz4DsDo3RGn8pWMX61HrNkLlodTelvYVBOq
	 emPJI96MyQDcKjULmpWUicFqYikhbNN6Abud+pMr9TZvMXGiVGSZulOA7BHcExUiT6jZQ
	 pqePEpi+AyckoHsdBXEz69K6rjRq5KfcOw5YPsNenkQPH3b7KMfHOWrt7yee34ErX5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792878181;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nL5hiV1+SWG78u7+UXe0ystXqb/xVOZSy8Mlcjsf5SY=;
	b=p5WraDqup4AB2Mx//nKX1mwBxD66Pn8LZwlmv6OjHWz+fDhfaS7Vs2NXsR3NlWhVsHRg
	 Xg+l5si8tf7vAfH1qFMl0wBW+MsuSiyBMpo0lE965knAsB+8roY8zPUeOzxcwW36hAmZj
	 qxyTuHVU4qZ2bAGPtP8fakVAmUuUqiBi5TvWLzZ0/NgafNssGBNMRfCn1810UDKY+vUvw
	 bky4qAdntgHhiLL4rWMT0A+RKrIKLxtnvZxcMW/Ezj7tUZnpzF4frNu1FmMOsVKJLnGY/
	 7j6O++s0c3OkOLS7BSEo5juYXD/so02g18+DB1DlPpYrpyAuLSxK1DjY36RltNuCRgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XjnE0vA3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BE4606A31A
	for <linux-perf-users@vger.kernel.org>; Sat, 24 Oct 2026 21:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XjnE0vA3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D63B1F01825;
	Sat, 24 Oct 2026 21:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792878180;
	bh=nL5hiV1+SWG78u7+UXe0ystXqb/xVOZSy8Mlcjsf5SY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XjnE0vA3xbK1clyoLb0O7jDjD0ObYfUcBPt88/HGRRXqxDOQoLzdHGETbhhUfTMYm
	 7RGJC0FGVf7qbut2ko4QDaVoJNBz087QBL4nmxIwM/hCXVtm2l/8uuC2JwdPVjkQVo
	 cTJhM1At0datyVTWuJL3yJTEZXK2eEmFWw4Xc30u/aWZ8kNNFeg13TJVh60yVh3Gum
	 EgJENCWuU4VPE+aTf7pzanXh42eQUZ7+VyiC3/5/I+vG8mgBUvAHh6kwXjziMH9OyV
	 axLfPSDiA8EweXCXdLF3bcaPeJou9GB4pTIIhuAVkzUc4SeewTXDjdve1ZvWFP32Rc
	 i71ebChbEx3kQ==
Message-ID: <sashiko-outbox-183896@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v10 04/10] perf ftrace: Add basic task
 call stack management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261024212549.450634-5-atomlin@atomlin.com>
References: <20261024212549.450634-1-atomlin@atomlin.com>
 <20261024212549.450634-5-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 21:42:59 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The function_graph tracer records kernel function entries and exits with
> nested indentation. To perform call graph analysis and subsequent inlined
> function reconstruction, userspace must track the active call stack on a
> per-task and per-CPU basis.
>=20
> Introduce basic call stack management for the function graph tracer:
>=20
>     1.  Data structures
>=20
>         Define struct ftrace_stack_frame to track function names,
>         indentation, and inlined status.
>=20
>         Define struct ftrace_task_state with a dynamically resisable call
>         stack array, tracked in a hash table keyed by PID alongside per-C=
PU
>         active task bindings (ftrace_cpu_tasks).
> [ ... ]
>         Stream complete trace lines through ftrace_process_fgraph_line()
>         in __cmd_ftrace() and clean up allocated CPU states on exit via
>         ftrace_cpu_states__clear().
>=20
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024212549.4506=
34-1-atomlin@atomlin.com?part=3D4

