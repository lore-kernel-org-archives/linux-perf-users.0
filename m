Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1CE3AA1AE
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787345800; cv=none; b=ZlNhGyVdb2J/wXfGMGL9gKf2gWyBBgnO2r+IGxXeE7Okw7u5MJwRHD+UyDysx0wRru6pepEPG6TopW7pkcxgBFBMihsXGWs4OL110gJLUayxRtB6KlMXULVuI07SNMb5sMoTLPjsT8dV0Z2hTz7K0DyXbynMSen/ldmF9kwV8LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787345800; c=relaxed/simple;
	bh=d/8I65uzJW+5VP//ayEuBzchhM2sbYOeT1LGpudNetE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uYgUoPIVfqDjoHiKnq7PtnP/WCq4KZ1p/juCQ/v8gxJznG+8bkqkk4f73sI/9V26a3YzFNizzWgv7hjL65RuvExf4Eq4N5b02tPL3cFwYjhAyJiMd+z4wAy/dI1v35msFAcQ+ek4RXpjGgTciftE3bCsWK01xQ2Ni8wzfNI6VaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYiHCsLR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYiHCsLR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6DA1F000E9;
	Fri, 21 Aug 2026 20:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787345798;
	bh=d/8I65uzJW+5VP//ayEuBzchhM2sbYOeT1LGpudNetE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LYiHCsLRloJ46AQRe4E32MvyHK5OO/EnYCeF/dalFQUOqMd4hNAgnDeItc8cy5obg
	 rvVIaNe6Kr/P+/R5lahOd7tSET7CmVZ2LUfE5ponUaKfEWJLkFwmJcPVLJxqTlMmMI
	 EuS+cg2UYMPkvExDsrIJNxkWM4nqPdxkmX51/LZv3B4uvWzH/r0XVHlePM5sGip6nk
	 UHqWhKgs1KD9gHHvNrkKtZ/psQgzMXLsDP54L4DBSNwsP1DQd5CWxq5wXbFUk0jP3X
	 HqlsAFfNRM5nCgeA7cb+jI1+2bz8CCdcLRrpywVOROa5cLCf05H8ZL0NljKGcivyfE
	 EcoAHRb3uj95g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v4 1/4] perf trace: Introduce kernel
 symbol beautifier for virtual addresses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821204930.679027-2-atomlin@atomlin.com>
References: <20260821204930.679027-1-atomlin@atomlin.com>
 <20260821204930.679027-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:56:38 +0000
Message-Id: <20260821205638.BE6DA1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821204930.6790=
27-1-atomlin@atomlin.com?part=3D1

