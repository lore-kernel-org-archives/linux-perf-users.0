Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE9B1D89EF;
	Sun, 30 Aug 2026 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788101080; cv=none; b=nM1cClBtA+zdjUDKTgvxskUHmuwhAlRsYVFpcAMXgu3Qf9nYiRhRB0Zgd+q5ba6IVnHAclbgIqWVHCOB8WOAynDYmnGoZYb38uCAzeSXI64UC1h1nwTLFQ71zu3JrcPA2p9grnBblZsktkWXRZJoYZXWKpcDfvJ/rpwon0vG3TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788101080; c=relaxed/simple;
	bh=g0dbVWxDfbs3Lz0P0iKLvV7U4f9ohA2VrUsaQDOnN2Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=asZ35iCZMiUCtS7fqzvfXZ7jh0bNvRMVBmpMrP3w2EgqskGhxrHkSif9onX3k5geFZYEwtHaYDxwMlZVB7J80roGOyfRM4EuL+CoQUt72s3HF4+hcuAq2btRYcMTSL5J/3sGImhs1/kAHT2DeS2iIpOAViUQIE+VMww2J1a1XNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P36wgRtY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P36wgRtY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770101F000E9;
	Sun, 30 Aug 2026 14:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788101078;
	bh=eQfpT3EDEeA3Mku4k8nlPhgXPckaRXPnsTQAqHQxkfk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P36wgRtYpnF4Xhi0pzG4ueFJEfKCa5sd3IcbLV7cK22raFSM7aI1bQk9SScxX90cG
	 cC82wjxa9OB7G5gvOqNn+n0FEy4BoNil4kfsSXK7Hd8eBnSFGW7h5tagR30yqvkyxO
	 BXhMfv2rJ54lXxVDp2qDotxq59pgkLXm9hFT4CE3E/akyHrxIILZfuCCFhnVkVnkoS
	 1AnXRXiyB53lSLlj+XWBeg+7dZSF7jBjMplSycGCnscwzcJJ578G1nVmEpI5bU9iR0
	 ZRL0froNKuzwc/aI72bfwViQMYwH5PCQF/nvrxkmuWIDGxKYfp/ie5nBGuDw1L3BFW
	 XdWS0oM7jmERg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 13/14] tracing/wprobe: Support BTF typecast in
 fetchargs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178810015473.64882.1080115688388623008.stgit@devnote2>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
 <178810015473.64882.1080115688388623008.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 14:44:38 +0000
Message-Id: <20260830144438.770101F000E9@smtp.kernel.org>
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
>   echo 'w:watch rw@-1:8 dflag=3D(dentry)$addr->d_flags' >> dynamic_events
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178810001186.64882.=
2161016469449127450.stgit@devnote2?part=3D13

