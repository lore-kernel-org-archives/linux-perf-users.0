Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D633E3DAB;
	Mon,  7 Sep 2026 03:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788753182; cv=none; b=nu2YD0EZ6mQ8Tc6UTOrNjkU2/zA7aoPdZt6IskBFWIaInARI7FdF5Ssi7yEFp6lo2AboP9O9Z96eFqk8qJ93jRQUE5nEaQYfaWlhqfyZ93pzbmXhLuBMSk05oi+UBFngW5jPJ1WMztAn/0c2MvG0XWgxQKXP3154NrMc5AjnGTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788753182; c=relaxed/simple;
	bh=2kGfiwryzGB18xWFMrPASH1xOSrLS/UD2JZ6jfs9ZJo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IwNFCULDbGTc7ZmEitJ9sSRLiha78FNxtaM2/3AthZ0A9VWnk8tnvjhUbYZhQqCgiuVk6BFvHKmoF+VYdCASfcIkoM2Oqdbfqj0243tbKQE4ViaUdAnujRdGej3m9XcmVkICURNe9Wrf9P4PEYdNR69JWNwBhRKzfSA4dcwb1iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUwUXka/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUwUXka/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41571F00A3A;
	Mon,  7 Sep 2026 03:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788753180;
	bh=2kGfiwryzGB18xWFMrPASH1xOSrLS/UD2JZ6jfs9ZJo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VUwUXka/BKkfsMh0X0QWCdLWVbUADbkTrLFQrdfO2xYArOz0oDOZWl38svv6+g5IP
	 fQhCCh43xXbFrKcUdxqSfaYJSZOqDPCbOR0rbl7opahUTgDy+u9MHBkXDId0YzPd+f
	 lqDLerS5AU2tXKw3rOVlXiw8JW3VjM4Or+RpgHyUv3H6P+Sh1FQkx9Gcl87a7CPqul
	 PBv5G0aBCGwTMPYVxKxlHhapG2gJpf7SL25xW8tnppMHF7EppjKktDWc38LxRlP6pH
	 VT+O62QKbeMCcibTf/zHRuPPzLihcY7SLyU1yP62TivSQTH1v0wShFhl+CqxmBbqtM
	 NoQc1HyxhDOEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 06/12] x86: hw_breakpoint: Add a kconfig to clarify
 when a breakpoint fires
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <178875284616.93794.3461261498789544150.stgit@devnote2>
References: <178875277830.93794.14247844688761142429.stgit@devnote2>
 <178875284616.93794.3461261498789544150.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 03:52:59 +0000
Message-Id: <20260907035259.C41571F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add CONFIG_HAVE_POST_BREAKPOINT_HOOK which indicates the hw_breakpoint
> on that architecture fires after the target memory has been modified.
> This is currently x86 only behavior.
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178875277830.93794.=
14247844688761142429.stgit@devnote2?part=3D6

