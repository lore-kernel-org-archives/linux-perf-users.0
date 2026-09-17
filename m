Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0244F390F
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664042; cv=none; b=Hq++bkL3ybhPbAM10qytLEEO1oZ6Kdr0f2UXZ0w3JWfhrefO2jmLbiDOIphdlEuzv6si2I8Gj6SDgDDrXYSBc96+m1R2qsjI/xUeGJZcIWx1TijPW2ls6OUdRgxR/b2OeBdtnM8xrfKf0xHEPquM9a0XI1ShQufVsjXMaApUOpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664042; c=relaxed/simple;
	bh=/KlTATYMjg+tu/Qc4qOZ/ieWnrP9H4C1MlyRfBtN4tE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QSqYvHbGPABgM/+XrgWC0RjBtpsRggeY5ArK1Rik7C043Jo/Yg3XUG5ApisYM7TEqKZXMoj5apdZ/BFJ/9KnqnvrxUmuAmcbB+MKuK5gZqg5gelMjnjfDKZhU0uUTAa/8BqVA6wtyfP+bnsXQFct8GyZKUqaJC2DtSW7lFk0Rbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFii/gQO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFii/gQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCF01F000FF;
	Thu, 17 Sep 2026 16:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789664041;
	bh=28axG5Z0jWZ8ji0K99k2mdG6650ZZcTCq+mt7XNPKlA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EFii/gQO6TxwisFF7zROLM77kUa4NqVbJlkf2NYcSoHO4kXmZSRNpb+dyZTQK0fEx
	 nQ7Aay97G42AmlS1Gbut/woObGUAqkt/5pgELdDpBCtzR++C7Bl0YqEKPL67WlKXyW
	 iWz3hEoNGEGzXp1ekO8Vpbe+Mwj6W64JBw5MhNfHSBQp/GmXamU16B0+S+7DYWh6QQ
	 DbYp4ii6LHBIZiHHXaQib8lseqGVN02wtiyF1x/BsvjZ94fJ41O92hDKRdkZtJpNw4
	 WvCxUq5LBAKs3GrM/u8mRqAghFlSjfkZioxLria0TKM2VuNTOPe9989mMTFRdBUMnk
	 Kh4ZYJBgkLH0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/14] perf trace: Do not set unaugmented BPF program
 on sys_exit map
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <ff6b4ac0b85c13aa3dd8c0e60f89253669c661ff.1789662556.git.irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <ff6b4ac0b85c13aa3dd8c0e60f89253669c661ff.1789662556.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:54:00 +0000
Message-Id: <20260917165401.4CCF01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> In trace__init_syscalls_bpf_prog_array_maps(), the BPF program array map
> for sys_exit (syscalls_sys_exit) was populated with the result of
> trace__bpf_prog_sys_exit_fd().
>=20
> When a syscall had no specific exit augmenter,
> trace__find_syscall_bpf_prog() fell back to unaugmented_prog
> (syscall_unaugmented). However, syscall_unaugmented is a sys_enter
> program that outputs enter arguments to __augmented_syscalls__.
>=20
> As a consequence, when an unaugmented syscall exited, sys_exit
> tail-called syscall_unaugmented, which interpreted the exit arguments as
> enter arguments and emitted a duplicate, corrupt sys_enter event into
> __augmented_syscalls__ right as the syscall completed.
>=20
> Fix this by:
> 1. Returning NULL from trace__find_syscall_bpf_prog() when looking up exit
>    augmenters and none is found.
> 2. Returning -1 from trace__bpf_prog_sys_exit_fd() when no exit program
>    is present.
> 3. Only updating map_exit_fd when prog_fd >=3D 0.
> 4. Clearing err =3D 0 when trace__bpf_sys_enter_beauty_map() returns
>    non-zero (indicating the syscall has no augmentable pointer arguments)
>    before continuing the loop, so a trailing run of such syscalls (e.g.
>    'perf trace -e close') does not leave err non-zero on return and abort
>    the session.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789662556.gi=
t.irogers@google.com?part=3D4

