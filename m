Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CA73B8130
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285689; cv=none; b=t9UKCn29FWXzR2EAuXUGXb25nsf6XskDvz6dF1hUT3TROGP+9mJe0sLxWc7UXDSyFvphxE1OFmOyVHrvoISuPUlVI5QuAHtABLJumO073YbReOKlK89Dwbb8fbtniW6+6TskOFoDQyDfBDxr1MmOOE2w8AIlxOR+Gk4JJe4+klM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285689; c=relaxed/simple;
	bh=7JqpkvuD3k7o2vQfc+2fj35tzvMgYlT3YLgwVWXu/Uc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q4ck1n3atqkCq2AqmNB2mfNS4S90RpzqOhwbzWr+ir1jfAPebJuKEuHjtf9maFfXNGUG4x3Hu0gVcRQeUmUKK3VBqxsOyO5wrv0ZgSMNh19AUSuHZ+KhBK53ueTBzGQ+7MhCyamtnmsMAPc8egugRQ/y3KHyzQRiDdJPKcqPWaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqnEFNck; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqnEFNck"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FB71F00893;
	Thu, 24 Sep 2026 21:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790285687;
	bh=sg7bSdP4EFqpYyY4Fnn5YWOu7XNKGaXYVcUzZuevwxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cqnEFNckCBe04y8c2mheQ+Dhp2QIQEwm+f4jafZvei17ZjWMl9hfM0qbY2/5nQpIC
	 Mrvs1am6g+6rpiNKfH4dvg2OSaPLTDwCdWV/3iJotOLPC7qHiggJuI5gIUTTqO0mLQ
	 auykeU3VcJzqDRx90bI2SJdcCnaTJ3K2/vnD8OYPLvUkvIu6EakgZ1tLsTFJ8Qa0r+
	 idS8pzCUUjdVk9kxJFIlUzYAlYSbMFyzz2IouDvkX1Oufbv5d9LgkinYgGUHumcPGe
	 MKRn2Pg7UNnkqGhAvXYdJFkIEAt0/TFzJDRlqT6Tji2k/9ev45KiYTyysNxih6hfdR
	 iFXwMv6+jiWSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/6] perf dwarf-aux: Add die_same_file() and
 die_get_type_die()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924212809.1733663-3-acme@kernel.org>
References: <20260924212809.1733663-1-acme@kernel.org>
 <20260924212809.1733663-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 21:34:46 +0000
Message-Id: <20260924213447.09FB71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> dwarf_dieoffset() is relative to the file the DIE is in, so an offset
> saved by die_collect_vars()/die_collect_global_vars() is only
> meaningful in that file: add die_same_file(), comparing the Dwarf each
> DIE's CU belongs to, and die_get_type_die(), resolving the offset in it
> with the saved tag as a sanity check.  Resolving the offset in the main
> file instead parses whatever is at it when it came from the dwz common
> file.
>=20
> dwarf_cu_getdwarf() is new in elfutils 0.160, so the libdw feature test
> probes for it and Makefile.config says 0.160.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924212809.1733=
663-1-acme@kernel.org?part=3D2

