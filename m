Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0344A55C336
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 21:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791927821; cv=none; b=XCtQzh5I9Abz8VX+g4B88osJvAeMdNjzj8fi1YAML/jcdH6pEYHanV8wEOard499CuzGpT3FxF00Nb3jPligwNWhl9U+9spk5k4RARgegom6NzHsgTrO1fl5lo0mWKXUr5WWb2DEhtsmNdv9WIZrJR6CBlEsJjZMWLR5+JErKAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791927821; c=relaxed/simple;
	bh=5F9BjAA+Rx1pAo6/tJI6LJBrrVV/VYMlVwqCpeqjzJc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WmIYyWGgNpufkmtTLkrwRzR9bIwaTTzF4MunVVXsmyG5EneSO4X6m/cHdL1LXd99jPHvlYIkJFPFBg67qPfxkQ6QCOKwtPsyWES92z69hknqbRbO6Tt+fRceiEzt3uuHX6zwsMRVOozvLy+0LwI3B0F68DWqJkC4K6go6Y3Q9S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrZp/2GT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrZp/2GT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F721F000FF;
	Tue, 13 Oct 2026 21:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791927819;
	bh=5F9BjAA+Rx1pAo6/tJI6LJBrrVV/VYMlVwqCpeqjzJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YrZp/2GTwGtUTM07MHuHPWVvOXUJgNzZrO6Brh/sm6TZQENPlI+IXO8gQXsp2kceN
	 UYpM2a0WFRyADMZ+nNrIONeZre+vfNDuEDVocEZtiCN1bTHj13sBe43CvsN1EQlRJG
	 HyZfH2xgFXUCXeEfr2iAwfa8hex8jnVszRj9VCKOihpuFgrguNhqB8bkaUjQr0BtEe
	 UtyBaKMR3fXwxJ85aTiu0iGu2dYhIVpEZIOKKw0MDJ6RwuhxsQAkmbn8GlAdCav0Ff
	 VRizhXbfkQp8LBQf+8uNvGgV+inDUl2u3y7EpGaLfXn4Sj+SI+cRnk5DDK/fo04npa
	 VPe4nRZeB4+sQ==
Message-ID: <sashiko-outbox-170548@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tools: perf: allow opt-in "no-dso." files in /dev/shm
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stephen Brennan" <stephen.s.brennan@oracle.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013213842.1870582-1-stephen.s.brennan@oracle.com>
References: <20261013213842.1870582-1-stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 21:43:38 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Applications can place JIT-compiled code in POSIX shared memory so that
> multiple processes can execute the same code. On Linux, these shared
> memory objects appear as file mappings under /dev/shm.
>=20
> Perf uses /tmp/perf-$pid.map to resolve symbols for executable SysV
> shared memory mappings, but it treats /dev/shm mappings as ordinary
> DSOs. As a result, applications which provide perf-map symbols for JIT
> code in POSIX shared memory don't get those symbols resolved, while they
> do with SysV shared memory.
>=20
> It would be incorrect to classify every /dev/shm mapping as no-DSO
> memory though, because /dev/shm is just a tmpfs mount, and it can
> contain ELF files.
>=20
> Add a filename prefix "/dev/shm/no-dso." which is recognized by
> is_no_dso_memory(). Applications can opt-in by naming their shared
> memory objects "no-dso.<name>". Executable mappings with this prefix
> will use the perf-map file, while other /dev/shm mappings will keep the
> existing behavior. This allows applications that already emit perf maps
> to use POSIX shared memory for JIT code, without needing to implement
> jitdump support.
>=20
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013213842.1870=
582-1-stephen.s.brennan@oracle.com?part=3D1

