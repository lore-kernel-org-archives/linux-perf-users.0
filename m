Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D54483BFB
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260789; cv=none; b=AwCBi1spu5Vz+aKfpnvoz86mT4SJPT02BbIFwXFiieFGtzoorGYjV0uThuzJEwhBdsekNBy3Ai3buUL8abKH58Qi88rtHMP0ui3tf8J6iuwV0nLSrOAIWk5IatuAs+FHG80zz5FYm/lcLemQRqs4SDL4j1yUwnGegQPhIrgui3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260789; c=relaxed/simple;
	bh=iraGwbCnafUKwPKNwbTm0Qge2eCDKBPgzsb51Ms/PsE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kYsJTDYoeEK28Zw3JPHzQ0m7rPkrpWDi1HF2Gz7rgT/yJ+YbOkT7186C8Pi3eX4wnLz4rzIfDRh8gFxVRq+vn9ZSALbJypyxq0LjFRh5g3wMoi7IQnmAazKFxwuOpxBpsngo2p4Glo/wGOOdnzbDHwS9GBea/X2eEr0Xg3HZr+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NraG+wfm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NraG+wfm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66BA1F000E9;
	Thu, 20 Aug 2026 21:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787260785;
	bh=iraGwbCnafUKwPKNwbTm0Qge2eCDKBPgzsb51Ms/PsE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NraG+wfm72XZHMiEEz39ko/Zh97jmkh7iU7DBZZ8FAWEeDZw4P8HAbypWNNyu3yNs
	 ff5mmLk7jPtN2vlTjfCOFOa1BbDMuBy4V2xGC0uX6ZvWTs0LW8al2FF+wZNLAheM69
	 8IkYrV8wTj6j4FYhvvvqpT+E69PMBiKFOPi1Qv0kcjMjQFcluIU2RYfr9qGPQtvB45
	 VFTn7aHI9tscqU/EZwye6QDLEuxsMDv+bbNafbuqXNMRvSmLr5a3kzJMP4BzdPGm4m
	 po6cHq/pobi4v5lsztyUbX3sIhFBMH+m/dU3cMARlOZxLs2j50Fphy5rE+KEXnRjdE
	 l3PxGb+ti/7Aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v3 1/4] perf trace: Introduce kernel
 symbol beautifier for virtual addresses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260820211100.649142-2-atomlin@atomlin.com>
References: <20260820211100.649142-1-atomlin@atomlin.com>
 <20260820211100.649142-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 21:19:45 +0000
Message-Id: <20260820211945.A66BA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Currently, when 'perf trace' formats tracepoint payloads or system call
> arguments containing raw kernel virtual addresses (e.g., a work item
> function pointer work_func_t in workqueue:workqueue_execute_start),
> it prints them as raw hexadecimal values (e.g., 0xffffffff81234567).
> This impairs readability when tracing kernel execution flows.
>=20
> Introduce a dedicated kernel symbol beautifier,
> syscall_arg__scnprintf_ksym (i.e., SCA_KSYM), to resolve kernel
> virtual addresses to human-readable symbol names and offsets
> (e.g., "flush_to_ldisc").
>=20
> The beautifier looks up the virtual address in the machine kernel maps via
> machine__find_kernel_symbol(). If a valid kernel symbol is found, the
> symbol name and offset are printed without requiring --libtraceevent; if
> the address is zero, "NULL" is rendered; otherwise, it gracefully falls
> back to hexadecimal formatting.
>=20
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820211100.6491=
42-1-atomlin@atomlin.com?part=3D1

