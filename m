Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657C148F00C
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247533; cv=none; b=hl2l1TDcdwreNubj2kT4Rk8tcV6vxHk7WHhWYWxXyjH/Hj/p/GGHKkYIrCFDiAAqz6g0XiiT1Yvzp68ia68PxydellI71j5d9rOJVr45xgmVuuWiERx7WrawkYieihquJZ3/5HT5dhCtgiDEMRLWuxLJm6PK99+YvlqYGcaXn7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247533; c=relaxed/simple;
	bh=tKioBoPc5vy6WjBAexuwUdNYUIR1h35Sk3ytSDeqVQE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=mV8DfO1I3tX2gZNZ1yKZZ3EokCzlyo3JJP60ZMlKwBJAXVxeCF1fCa8htOfmcKtl+V+pG5/D8eBH32+O0mrDRM6YbPMtFLsM5h48EPb3azIUGr76o8u8YGNES4aQyKstwFC4ceMqp+KktPiWnVp2xuF0lFBr6zWZ2aq4Wiuolr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMIN2Ymh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMIN2Ymh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060421F000C6;
	Sat, 17 Oct 2026 14:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792247532;
	bh=tKioBoPc5vy6WjBAexuwUdNYUIR1h35Sk3ytSDeqVQE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gMIN2YmhuY3NPZsA/ih5EC3pGuGKn8P21VtplUOD2LlhOQIKVGYQ9/Smo1DJIVBmd
	 XATiPDYOIeu3h1u4jv2/Q5bRgk1oUfqitReyTE/0wh8NmzGtYypJPVV3TIaYpdA+8X
	 AC+lrRzftaJtd+bWI5Fwu5Pd6JjOJg0jc5KvqUKbRoxO9tnraB4QiTEx9wQHyh5Ehm
	 SJrG/H7MqfoDZNmmDrmIl9PGzPw6JebitZZ/PHNZBVEX/FfAK+cVv/tqfnMGmhzPNC
	 p599kdGO5dA/Y2ec0ihPSr3NA9JFq+dySfisIdkXx5ym6kZTAubN7Zwu7qKFxhzGSv
	 qkN1H2mjnRwMA==
Message-ID: <sashiko-outbox-175555@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 4/7] tools: build perf in tools_build
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016143143.3613501-5-sashal@kernel.org>
References: <20261016143143.3613501-1-sashal@kernel.org>
 <20261016143143.3613501-5-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 14:32:11 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add CONFIG_TOOLS_BUILD_PERF. perf is built as it is built standalone,
> with optional features enabled when their libraries are installed, and
> with perf's WERROR setting following CONFIG_WERROR. The feature table is
> left out of the kernel build log.
>=20
> CONFIG_TOOLS_BUILD_PERF_MINIMAL builds it with MINIMAL=3D1 instead, which
> turns every optional feature off, so the result does not depend on the
> build machine. allmodconfig and allyesconfig turn it on.
>=20
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016143143.3613=
501-1-sashal@kernel.org?part=3D4

