Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550634;
	b=ds3757i7aJLxmHq4sBecAPgLU7P64cGwSAXkVGZRzrWWqDpivYck46zDAoRlcuLTzBER
	 WZoS1ly5ojvxrv1xcqKW89/t0C1t3BngWMIEkfgTP4skQYDhC7SUVmF+ZA4urAczyzu9k
	 ux4Nw4/FMx3Lj4kQLUsX9+bObeDzwgg8OdwTL3ZdKNqn5CVonKr1jO1rbR1W6VhOFNSi8
	 ltY9NINzQqQygOEMXftunS+EafCPteVz5p+wCqZPnDKqlsAu5IYfsWuD1Y6EcTMAsaPux
	 9Y4tZob2cHdfNew984CEJ8zPHU1VAJdJ/nKK0EhAZyTHlCvJ/sQSGCGkP9b5zftJkOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550634;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BQ5wgnGKfFh3+vzQB4m2jYm/naG7XdFVFAxoEgbH1Qg=;
	b=2rncMQSFert4aKNo22UTmwdn5ew38sldUbUKsDSQBxwdVzKnW1jgSs9bGrjShCK9zeOn
	 dA370j2MIfpugp9pg9aBRMo3Rii6QRznY8Wa65WmhvSwrBgnOzZYXrHx/gHQauM39ze2d
	 4Qyxo9bjyEFD4u6F+p0t5jzg4P9BVAbBeqDQPPT/ziM5etx6VMTmyUh0yTi4V9cMLG5A2
	 2LZEb/J/bO07tdMxdO+5thv8Jfq4/TbWGauqAcHT3R2/hIxMPlvu+tPVx+z0AjtfCEVN9
	 q4Uehuehlq+XS4m/eidKLTrizguSKyW6UC33nJpxITpHzeXRR/C9lxSAJPWai4+MGJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FXGSpq3b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585F7606A319
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 02:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FXGSpq3b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42C01F000C9;
	Wed, 21 Oct 2026 02:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792550633;
	bh=BQ5wgnGKfFh3+vzQB4m2jYm/naG7XdFVFAxoEgbH1Qg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FXGSpq3bq53ENx46gDzHNNtck2MrrCCwzUD+4u9pbwBnTCp5+cVb4ia2Bka7eJhZI
	 W+HEyOpXrKUmLlo1Qsu+2W4ft5b2q74vyUmkkzIS0LXi/M+LHernO72YIwRfeQ4CFE
	 1IJ5bJQx/6VxAlIwTqFfqRW76I8CpAtz1ArwzC5NGFcM/Goq7zATvbokIXYOfOAtTZ
	 CPMaIfsaoM4gRf35i1Hk+zWiXO6AGrYF0R2dvVmWsO3Bqw5zueZN3T4xcpOp5SDUkF
	 2Rg3KJ24/dO3zdxWVgdWT6U2yv21fuRl6tjsEX2HEb5dd6h0b1qFEk2+QkquRji07h
	 3s2TmOnSs//Kw==
Message-ID: <sashiko-outbox-179712@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v9 6/6] perf ftrace: Filter extraneous
 functions in function graph tracer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261021023337.809936-7-atomlin@atomlin.com>
References: <20261021023337.809936-1-atomlin@atomlin.com>
 <20261021023337.809936-7-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 02:43:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> When tracing with the function graph tracer using a targeted filter
> (-G or --graph-funcs), users occasionally observe unrelated functions in
> the trace output:
>=20
>     1. Top-level functions (e.g. most notably
>        finish_task_switch.isra.0()) appearing before or alongside the
>        requested target function. This occurs because clearing and
>        rewriting set_graph_function creates a transient window where
>        remote CPUs still observe an empty filter (tracing all
>        functions) before RCU synchronisation completes, coupled with
>        perf ftrace sleeping in poll() on trace_pipe right as tracing
>        starts.
>=20
>     2. Detached/orphan calls inside the target callgraph
>        (e.g. housekeeping_any_cpu() and arch_irq_work_raise())
> [ ... ]
>        detached orphan suppression, glob matching, deep stack
>        traversal, dropped-orphan recovery, and orphan exit collision
>        prevention.
>=20
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021023337.8099=
36-1-atomlin@atomlin.com?part=3D6

