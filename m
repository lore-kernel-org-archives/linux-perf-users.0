Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098D72931F4;
	Sun, 30 Aug 2026 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100969; cv=none; b=Ea8IyfXMtEjjnRkB+Pxt/y/cI6GguW7R5lBlAEOi8POng9sp/hMCnhrQbZvvLExga0tpHHmqn+PajpcYHQMShsE9LTT91Yox0BeRAzv7p3if8C35fPsmST/Dkx2WfkedCpSSeM0QkpCZ+LPCcPx7eoPKneMW+g1fMsn2FPjWRPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100969; c=relaxed/simple;
	bh=Y5fgfvY81fbl6BUv4Z29CpM7ftpVUacyhXBZh2NW+mw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t1ghusv8sIflS2sjHTCqT+SnoTi+NTU94VXmgmie+oQwpZKGEz9cGSPpXx38byECIHLgyavdJXD3pLeE3pVhcenVKHtVCC+mlfv1oxZsxmhd1+WP88ySmOTRf7BM8ju18NOb6VSjyGLDRWDozJthieoWTBBTkxNx6EKbERTJwHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmbK+hNH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmbK+hNH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77111F000E9;
	Sun, 30 Aug 2026 14:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100967;
	bh=Y5fgfvY81fbl6BUv4Z29CpM7ftpVUacyhXBZh2NW+mw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LmbK+hNHYGc9BHD2m1uM5PpPpxO5Yy1qDhOgo4o+q7ITtMXdp6dU+cKv4NHOo1ONL
	 GgEd/qDMioXZNMnli87pAwsVW6HViEIw9AswoewYYWVf0npL3OhlzxjVUoVK5lVX+k
	 MI4lQnHrFQZH0x3NH7oHWECD1ZF71AD4uu/Ns2qoKzZzZDAxBc2QJMGDevLfkCTHcV
	 G8TWI8rtp9C3lhh7D7TjnipRiEydgA8fz1kXcDgBlYziZGeV0vBoj6tnF/wlnbakVK
	 D11idORicZY2xlR4SDmBpv/SuOiTflspu6NbiwzAYmlub1T39rkqT4yK4raLRfzc6p
	 yXbKIW86KhNQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 07/14] tracing/wprobe: Add wprobe (watchpoint probe)
 trace event support
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <178810008805.64882.16330647170622284314.stgit@devnote2>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
 <178810008805.64882.16330647170622284314.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 14:42:47 +0000
Message-Id: <20260830144247.B77111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add hardware-breakpoint-based dynamic trace event support (wprobe).
> Wprobe creates a dynamic event on data read/write accesses using
> hardware breakpoints and logs the access context and fetchargs.
>=20
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c=
2.1785067572.git.wangjinchao600@gmail.com/
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178810001186.64882.=
2161016469449127450.stgit@devnote2?part=3D7

