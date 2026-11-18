Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794995898;
	b=pkKiT8u7WcU/VmnXNO7AW8FqMaJZqiz7gQMRojN85KOt8xEsrGK6LQAEE3MreaRkv1nn
	 wmbLacKgMNnVJi0NP4eCyg7MPhLqO12ToDKWet4J7jBA9YE6nlieaH0t3b9wE2NuE4wzR
	 jGQCIFEga3lyGmj6UXz6mt6LpuQzSM2ArM5vT0kalW43wsC3L2LIMCcchOG8pN/IYmMys
	 RDbI+1jY4JVPv3M5DS2UQrrXeajZ05xzxxqrX6YnsHncrsHj6Zppb+etBJ8zYTAYyIadx
	 ExHnEH9fcSHn2dksX1LuSrkNZgNcysMbnXNoUIPrE4jfryWPFcyAz+Oo6abjAUhi4TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995898;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9JQg/GLoJxU3NfHLfOfAQY3aajxf/yEpDRficg+P8XE=;
	b=X0q0/0cLxjSPbeLbvploymbx/H0+ANM937rAJtWr8jT/D5DxtaGekjBe9ypcPAbD6Ur+
	 PsXE1AZweBPXUamhJcNMIZiqesUD6L3SyvJN8tLNEDusMggTHu3rY+p0vQKWOWhct7ubb
	 EVwtzoFaxHBBWiNSBnKjSYBBSWm30AwykzeLEyLYpBfPEWS97FX2cGBZE67gdXwsh2fDt
	 ow5/rXqKKDzyBRW0PXOSd1hY6Jv556S/EOgxww3W0RhgvEEDQeD1HtbhpElAfzV1alO8l
	 fED3amS+W2epCTUVTmw6i1PICYyOFxDkKNwt1azZjteeJmbsXKMjZxRi/56HPFLJPCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m2QkTGSQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713F9606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m2QkTGSQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57C61F000C4;
	Wed, 18 Nov 2026 09:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794995897;
	bh=9JQg/GLoJxU3NfHLfOfAQY3aajxf/yEpDRficg+P8XE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m2QkTGSQF5mbsgCFbS5AGvxcT+7ThFojifgvxMAy4Qre7ZyOBRLa9xLL5wLwV0+er
	 TqstHYqpGvCzHSV5UYukrfTIQLE44YrJY+kNKyzHdH7pFOJkVD8wQYDHKBRUVIgEMp
	 D0kO/ByRL3EWYbAy2L318uvD8LKpbC3DK8H0DhXNw9T8fKBygEM0sWXzG6ntq60OBK
	 wS1e8dI5JcTmyT04B9i80644SGE+AZbJ4S5jhKM45ykqgpxe6JQEY7C3EpS9T7ebKB
	 IUzw27JJ/UK9BQdVQ2ycnKQZi/aQimTbdLp+jlAh6AQogEpOS9b11MVVe6zmsg6deZ
	 6YaEurKyjcKEQ==
Message-ID: <sashiko-outbox-220639@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/7] perf: Increase the maximum number of branches
 remove_loops() can process.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vikram Singh" <vikram.singh3@oss.qualcomm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118095053.3871267-2-vikram.singh3@oss.qualcomm.com>
References: <20261118095053.3871267-1-vikram.singh3@oss.qualcomm.com>
 <20261118095053.3871267-2-vikram.singh3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 09:58:17 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> RISCV CTR extension supports a maximum depth of 256 last branch records.
> Currently remove_loops() can only process 127 entries at max. This leads
> to samples with more than 127 entries being skipped. This change simply
> updates the remove_loops() logic to be able to process 256 entries.
>=20
> Co-developed-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
> Signed-off-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
> Signed-off-by: Vikram Singh <vikram.singh3@oss.qualcomm.com>
> Link: https://lore.kernel.org/r/20261106173942.3175069-2-vikram.singh3@os=
s.qualcomm.com
> Signed-off-by: Anup Patel <anup@brainfault.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118095053.3871=
267-1-vikram.singh3@oss.qualcomm.com?part=3D1

