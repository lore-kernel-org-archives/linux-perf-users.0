Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794699880;
	b=H9JPPql9/eq/JvIeuqx9hBOcGY1GtYcH3jzT8mwatOuaUkDqR9B0RVTap+RquHFF996J
	 uFpJzGsikOI5c8X8jwHnzYAmSqRe3C4QgtFCKedeoYBcM97Mm4HKufdbozR57Q6ZKUhAD
	 BK2hAB4BlNnobkVSGXihkZVl4NrGMhFfUicgGDTwS27dBSaacXppSHPevthIEAHT582BU
	 zG9VzPXhGxVIdKNp3A3xFVEN+yc6eaE3grzBo1rWpv0K4iCFi9qoENkwsmmU/hgDK4cSR
	 20HIDQzYXheqtz5Ujh/w3U4qm4W20JDQoudmyArf4ryL3URuyxKdEm9cHWw5IHYeGzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794699880;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oQU1vzKMg0YbIflet+6cpHIP46avjjoheiwEEumXL8A=;
	b=fAqiGIkzqDIrFXp3HgU+i8PkLOTJej3JtmM5UC+V47hf6fkGDQkc9+iAwFkLO80WkDiv
	 WrTUVEOhRXbo7n0nLeN/R+TbS/vxmk3bv/UTBb62nQOUHxo77IbWDvcA9u+icb8H5M6eI
	 wERdpHocktbkH3m2Lz8ECykYYEpULRVSFHICxzZTjFNY0/JmAsQCdatyvCALpp7NMKhUu
	 a7LkWoh06i+FRn68DX7rWVqq8GIb5l9WQoFdNgL9VE9N7YcyvrY55OvRkczcHDi4Szd6z
	 ihDLvhPn7aYyjjvb9k/3pr5+eqAG1ICnhCrq7AGSxqRxuxlsAM+nzt+Pwvf9ZW+G07Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPGoKBIV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F360606A32C
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 23:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPGoKBIV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182381F000C4;
	Sat, 14 Nov 2026 23:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794699880;
	bh=oQU1vzKMg0YbIflet+6cpHIP46avjjoheiwEEumXL8A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gPGoKBIVq0Q/NZl4RiKsN2Bgd2wx3X5ALDVCdlM5Y4r8Is1yRwzO8ISfP8eb94NQv
	 d7hbR4c4UoSAbekh1zZIJkLAGc17Z6NB/YokFtLsfd2iPTd6rFyA0g2B//yKsJpQfa
	 hvt2LtrzVZLvAEid3cD918JIrsB8dsDY9V33gzFvXPPZ/xAws3OeBicrbG+GDKMMLH
	 +ORJg29UtUcnd+VwCbjpi8wUcZHc9ggT/DRvJ5UN+GzGZfnAUwToTFjsBbI7s3VY/6
	 kJ+XmYxUyMJfdYltv+bcZJffaM2xSqyDfathHM7FXYJ6ykwCdT1huvRsFFiLHo+jmq
	 9fQ3X+02FdhPA==
Message-ID: <sashiko-outbox-215119@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] irqchip/ath79-misc: allow COMPILE_TEST builds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261114233718.86520-5-rosenp@gmail.com>
References: <20261114233718.86520-1-rosenp@gmail.com>
 <20261114233718.86520-5-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 23:44:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The driver is only built with ATH79, so only ath79 kernels build it. As
> a platform driver, its only MIPS-specific parts are the performance
> counter hook and the call to spurious_interrupt().
>=20
> Add a Kconfig symbol that defaults to ATH79 and can be enabled with
> COMPILE_TEST. Build the performance counter hook only with ATH79, as
> other MIPS platforms provide their own. Drop the call to
> spurious_interrupt(), which only exists on MIPS: a cascaded interrupt
> with nothing pending only bumped the error count in /proc/interrupts,
> and the handler now just returns.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114233718.8652=
0-1-rosenp@gmail.com?part=3D4

