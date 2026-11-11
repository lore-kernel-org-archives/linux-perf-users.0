Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392886;
	b=KrkDqBY0rXbG55hXFasj+9Tw8J0BjWP0eoqkVAA3Ot843Ltw4Hfv4KeHBPKRgrhaQopG
	 QtC8FFNwehoJFLPFh+sbyVLqcRN+0kbOx4xj4eEvCi2Rivpz2tukmZlbMpGHxeugfyiSp
	 lmNf6psUotTE4JdHTeJz6qhrPHQhDwFViRDH5m9OqFjeZ9y2jRVh0PcKK4K2Jfp7d0f4r
	 2pNtrLw32Ra/DZ992qlpUErbxeZl2dQ7u9CnEJbH6PWyr8ZjyLhMELteCP19E8G10/533
	 jbOj3mP9yPwq708y6TRjMeTFE2RKDv7w8ANHzDZNButmP7Y7LjTAtTQO8FiJ2vH0TjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392886;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Sv8OzmVB494Fb0qJTn/PGjAqQl/rbXgQ4IJLJrhIBVQ=;
	b=I99oxVTcP1+KixJZOpvrDlX9QCizV2T4OMixWjcws+ARelLBgtlnJz62g5XTPxjDeh6j
	 l5pd+SN3/JefJqODNymApblFku0KDA/1RivjRGthb/3+j2EzSDxubD+DC+0gceNecYrY+
	 uPJvNhTElBfXYoiiZQgFRrlTFcyWzkm9JixH5GD09UpVVGWp9QmhzKfTAm24yFweWMDJA
	 BD2+/BJUWVfFtnA3QCW2Gn2H5gW9c/ffE8dl38nEDrI2Jr22FHyUinB3lpQcSkqHSl27F
	 nWyowL96RzDEggokRwWrRsps6IvO+bHO6MTj4/X8A8GiWmWzrnJsGI++/0BKnDu751g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKPOHsgM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6E9606A33E
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKPOHsgM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE8E1F00A05;
	Wed, 11 Nov 2026 10:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794392886;
	bh=Sv8OzmVB494Fb0qJTn/PGjAqQl/rbXgQ4IJLJrhIBVQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BKPOHsgMB5s+RLiBxpWnVhN0OZavEkxRgxDJKchoTnVI84/GRvSxw+8FAB8Mk25tb
	 YZz6s8XWd6894j906tmCoQDNZsFO46P1+OqAWMdc0UeDRbP0lYO2aW6dBHczPznm+C
	 0phafH/t6tOxR5gyQybaxaqOO5PuXWb5vJHp+DNcSDIx0ldA5JRYSV33X3iGRTpKHS
	 PoKF51hpYw5cyGBL2jmJ8rSbZ4q4tDOGgOmGxtSJMQy3yD5w/o+1+evKlese/LW1yG
	 d87Omzw4tmHB6h7ZO+xFeVaZZqyC3K92VtExRRToTLWSCzM3mDsDkqQi0Ozw3SOooS
	 iwqmXwKmWgEeA==
Message-ID: <sashiko-outbox-208809@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] libperf: Handle an evsel without an fd array in
 enable/disable
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261111101625.2204836-1-takano32@gmail.com>
References: <20261023085629.1694941-1-takano32@gmail.com>
 <20261111101625.2204836-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 10:28:05 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> A group led by a tool PMU event is opened with the members' group_fd set
> to the leader's file descriptor.  For a tool event that descriptor comes
> from open("/proc/stat"), not from perf_event_open(), so a member the
> kernel refuses is marked unsupported; perf stat then releases the fd
> array of that member while the evsel stays in the group.
>=20
> Enabling the group goes through evsel__enable_cpu(), which enables the
> members of a mixed PMU group from userspace because the kernel does not
> do it along with the leader.  The member has no fd array left, so
> perf_evsel__run_ioctl() reads its loop bound through xyarray__max_y()
> and dereferences a NULL pointer:
>=20
>   $ perf stat -a -e '{user_time,cycles}' -- sleep 0.05
>   Segmentation fault
>=20
> [ ... ]
> Fixes: 0b18bced5444 ("perf tool_pmu: Make tool PMU events respect enable/=
disable")
> Link: https://lore.kernel.org/avQIOtt7Y67oXQem@z2
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111101625.2204=
836-1-takano32@gmail.com?part=3D1

