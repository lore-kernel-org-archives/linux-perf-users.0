Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ACC157A5A;
	Sat,  3 Oct 2026 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791014503; cv=none; b=pZSTj5VGdUa4E25CGbwGwwRdwucCIJi2DBXHkAFC21ulL5ORI4iJPebqUqb9T/vo7VToCoVdaWjvPqALE7hHHyrk5lC6cBHEbaDLWRiQkymM0V1lqY5ApdZkvKpzyC3q2g35o9Cwbenr9HUsppHTARTQFmOpO3wg+ZRWoKoWjao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791014503; c=relaxed/simple;
	bh=dJXJcEnOYoVwpzsmP9BPPc79CXPjjBo8yslZwpf9Nk0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N5s0+suRfCX37QA2c8Vj+Mq0kYQxXWZq94124zcxTqKh/pX8Iibjlio0ls7TnlbL9p/ZNV3zt6Bp4CI+AdOqHe0/pEczJjG28f/s2e0THq7AJF8G75NU9Oef4ux5UMRLcdbKvpMjNO0z8A+xGgej/m3q4j/xdZFs/2y3BRyoPOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIMj7tCv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIMj7tCv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E941F0089B;
	Sat,  3 Oct 2026 08:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791014502;
	bh=+oYBnsLXVgfju2ptg1BeQDYZuo+x3eoyqQhMJs5tpyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OIMj7tCvnaPeN88DDZys+WHYiewrUZgYRQw0ekn2jjuJjoo/lHfor2vOKuy4h9zay
	 WA3kl+o8wbYZeNG1GMju+aG6uM6KnNqtzVs5o564T6ErOKmrBImnwTfBI77ZwogYmS
	 nNlXYpsr7i2Ia+UsSMi12jb499/UzbkKBQnsPm5d+rSYsCX6Aq6J/74A6jh8Nfc20W
	 AcRsRJSJeybxUAtWV217PFscDVNYfKoUSqjNl1HXfAdJgPWpABt4U82FWOnEDtjB+T
	 vmDDalty21Hc8sEeEIRCf3oz6aSl8hxqAto1LgattDbdyffY6zYVr8m4CKgx33RX0/
	 vNlPGa/3EqPww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 10/11] tracing/wprobe: Support BTF typecast in
 fetchargs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <179101404802.22872.12326020752976128889.stgit@devnote2>
References: <179101393469.22872.5895666191299551553.stgit@devnote2>
 <179101404802.22872.12326020752976128889.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 08:01:41 +0000
Message-Id: <20261003080142.31E941F0089B@smtp.kernel.org>
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
> Assisted-by: LLM
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179101393469.22872.=
5895666191299551553.stgit@devnote2?part=3D10

