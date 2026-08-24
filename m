Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D472E8B64
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578715; cv=none; b=de+aAWjMEvAhL1I6cRPtyoQ1pjwHvX7WEURBTGh1nGWLBqId9mTqZf8hOY/MiAsf0WO1Dz/buY/hzEnoyn9hcALYeRxN5Qa4h0fT73i4SgCLNweNMMnOL5FPmBgNIHkESf0Xp5Zc7K8v5p3CfiT1QCavlJ+eaeDO+/cRpnQ90eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578715; c=relaxed/simple;
	bh=0A0YYWeFUOobRHStZnxaHCnThEpo/7cN4OdEUbVlmqs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T2511gsPLejCB0uBZtzhUjBrH1rzFFOr2SJiuIDZK/x4VebEg35ynHcvcwOoGCRN8PTA9yYMuUtz1B3pB0pQ+UVH0eXpBLAG8jWBrroROkKhuMYcrL2CgNF3twi7oinqq1Yh8GQt4feHWNN9fGfHNQhbBknOXMYjjcmAqCbvy14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6zh4me0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6zh4me0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B7E1F000E9;
	Mon, 24 Aug 2026 13:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787578714;
	bh=0A0YYWeFUOobRHStZnxaHCnThEpo/7cN4OdEUbVlmqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y6zh4me09fUi738lELKVoc/+ChP5vxD/tyuxrpLNnlYjUPc4UIKNAqvvqHLbzMHZM
	 V26JR9QdtFlqwHZo4cUaeIJ8ds2gem86siBo00r32JOCYjOrgRsURoGzphbkFbrbBM
	 +zlIefzJhy0ImIXfg986vxvS+YYgkdaSPK1Q6LBhIF3z8/npe3Y2rDdBgHSsg1YxDJ
	 HN5Eu7ol4Bf6C08nuDNXdkNvctrlDUoPi1V/sYMnsOPVNLoOCpz/6CiCClz5kSd+U8
	 1g5bmhW/B0l1rwmVl/eBG5wrpK4IC/5Q2Ukzc3F4Dclmyun1bMhMlobXCMTEhDlJim
	 Ae2FsO6wpk4Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v6 2/5] perf trace: Introduce kernel
 symbol beautifier for virtual addresses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824133122.751733-3-atomlin@atomlin.com>
References: <20260824133122.751733-1-atomlin@atomlin.com>
 <20260824133122.751733-3-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 13:38:33 +0000
Message-Id: <20260824133834.19B7E1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824133122.7517=
33-1-atomlin@atomlin.com?part=3D2

