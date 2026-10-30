Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333228;
	b=le/+3k7/DgbXMFBVf2tu089yFGnYaHJVaGogfWmOYHJxzTbfLHVrx33MYyTM/Goit+6b
	 auDcCkeYWP7JJ0eyps09daS7JbpPK6/7zpJPhKwr727bjb1Hr8+lNk67EH4UDWjpTFLN5
	 O73N5xvdV/SrVg2l5KzUAZdrAbUa/s6WPqYH8x6Heh/PoQlllGtM2gvX7H1uQ8HB9RYvH
	 BnJErR3kf0bbcc+6YfB9CME34I63M+zroH2LWNbrxWZXNxmeb+Cq81mKfpEty4Zzj/FPF
	 syUlZNn6xi4LI0nueIhNBP91Q7+WvK5lEpZgBnz3jvwAYBEGMo8Sie0pVxzTmTAf1/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333228;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fJMbjZEqLhRXd+4yMV6HpR0WIK7cMfC0Wnu3QHwuXH8=;
	b=QMjS1XexSu2ox7dCxepLqxBoXxwBME/V3o7F8TY2a8YkODlgsKvthOodKuF+oYs1P3F+
	 yjHDyE16djXzcRAuTj0j+yK97vQHIbxwIaeNVVkqptG3GfXfHt11Jl0mRzNtWVz3+1/td
	 rp6sf4R/ujX7m1jQy/hUcwBLpkRymsvvMQia23P/vxsyBNG0XDoz+0B13T/zfwejN6gIc
	 FLnKKfvsWy8E99fStODjZEmenySTUaQzNYdQIlN/WDKEQd35KFInoGbc06JzjHJNtxvW8
	 aduy4R6GmRZXjtmVTIaU/G+1kTnuJeZIhYOQSZ0wmEueM6cZQPYq/31LEIXhgDnUjzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hxwxjoef;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA7E606A31E
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 04:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hxwxjoef
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A831F000C1;
	Fri, 30 Oct 2026 04:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793333228;
	bh=fJMbjZEqLhRXd+4yMV6HpR0WIK7cMfC0Wnu3QHwuXH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HxwxjoefoP2J+LnDFc9XE2OQBI5y3zcvsx8dciao9n/sg2TN61muBmuEL+lRiZaTj
	 CNkymM+1ddFlDYBe9FIUaMmrb7qsJ27BBiCkVeEMIowdbJJjfnPfp9pMDcqqOapW0s
	 BEg6iDLIW+EyXekNvyEmh1CEQ+VMsSnMLhfG2h+ZVRbS/Sv+GbE5GpDV9RGrnYQF8/
	 Eyovd8nAdrf3RjBU6JHNZNHc0G2LDhWmjwAN1sua1vvUh7jphJd84Ie91YFJgZs4wg
	 7aTWrs+n12iC6CHiZ7MViZfmdvxgMVil8EUV/v8BuIbrFJeBohQS/EIiwcKe9FCOQg
	 BYYiEi7WX0ZrA==
Message-ID: <sashiko-outbox-190284@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] alpha/perf: pass PERFMON_CMD_LOGGING_ALL to the
 logging options call
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030-alpha-profileme-v2-1-c702f1c65272@gmail.com>
References: <20261030-alpha-profileme-v2-0-c702f1c65272@gmail.com>
 <20261030-alpha-profileme-v2-1-c702f1c65272@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:07:07 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> alpha_pmu_enable() passes EV67_PCTR_MODE_AGGREGATE to
> PERFMON_CMD_LOGGING_OPTIONS. That constant is the counting mode bit for
> PCTR_CTL, which belongs in the PERFMON_CMD_DESIRED_EVENTS argument. The
> logging options call takes a flag in bit 0 where 0 means "count all
> processes". It works only because EV67_PCTR_MODE_AGGREGATE happens to be
> 0.
>=20
> Table E-18 of the Alpha Architecture Reference Manual gives bit 0 the
> opposite sense, but the PALcode in the ES40 and ES47 firmware agrees
> with the above: it sets I_CTL[SPCE], which enables counting for all
> processes, unless bit 0 is set. Linux never sets the PME bit in the
> PCB, so if 0 meant "selected processes only", nothing would be counted.
>=20
> Add a name for that argument and pass it instead. No functional change.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-alpha-prof=
ileme-v2-0-c702f1c65272@gmail.com?part=3D1

