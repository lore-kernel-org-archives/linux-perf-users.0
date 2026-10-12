Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D79391517
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 05:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783858; cv=none; b=XKvg5Xtp8YGvUlDxtoJgnT61+F93p7Pb/pQabhBR/by/6M+/T/uKHyVCJtfujzKaylYPxsJTSh0NQ+ehq5a73NCszfLGgfbwNtwWXnZvzMwE7uTpIZn2RHdzDOvCadqcOkOqay6uR5bjtMutNAvZanpOujbBiqAu1eiBaUAHvQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783858; c=relaxed/simple;
	bh=a6wqjkHguvDgpnp23lBU56TZkcnMPyFxv6i42MU7d3Y=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Xh+/Y0PKbUZnvIureZJarPRFlRaETLz2WYXFY1AcFA1UuHKGDTHj47NAiFcaa+hpHLT40XvScU/c0X4yhYIkwpdx7cSOI7c76ivBPbJX00XLm+fmpxs+aTmGNxoaC9zDhjRouDcrs0YXa6wvWHoHuFibfaw1R4z2UFbpoiZgTKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3eyJ04s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3eyJ04s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2611F0089B;
	Mon, 12 Oct 2026 05:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791783857;
	bh=7F02IzMIJAO8MUkINAHBNtEusE3gJB0YChbFUTS6KMk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y3eyJ04s7hBE/57XttNgIz+v8yEBoe7m6s3Hf1O/MCQhxX7ueGT2TskPVnqi2jD88
	 nUz7EyCDO6tdfVEzRQXAZ4BJ+0Ayz6dv3J3J84of0Y8+VHATTPDqKAw3gd0wA6tcXP
	 6CZlZyHj7gTVCNkvitaDnIsVhSLfkSDhFqgzXvqzP0xjadKSqMKTYl5dmljhhfYsNF
	 Zuksz7vx7izdRwcJhHo8HmZBAJAmAwGoIJVs06b9HYiN52oN/90nW9DOq6WeLgrcri
	 AN9XRv63MSEfRRHLSRasgui24H5qJLTJY+zSYzF013xh0VwrVwkKKMXRPJXYW4mYFl
	 t1I2NpAPkaG5A==
Message-ID: <sashiko-outbox-167685@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/10] perf symbol: Get rid of
 machine_or_dso_e_machine()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012052601.13920-6-namhyung@kernel.org>
References: <20261012052601.13920-1-namhyung@kernel.org>
 <20261012052601.13920-6-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 05:44:16 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The function tries to get e_machine from a DSO (preferred) or env from
> the machine.  But currently it's only used for kernel DSO's during the
> load which refers to /proc/kallsyms most likely and it doesn't have an
> ELF header.
>=20
> Also machine->env would have proper information about the kernel so no
> need to check DSO in this case.  Actually check DSO's e_machine requires
> a correct binary type to be set but it'd cause a recursive locking
> problem.  I think it's ok to use machine->env info for the kernel.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012052601.1392=
0-1-namhyung@kernel.org?part=3D5

