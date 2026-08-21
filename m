Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D2D45D182
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306413; cv=none; b=DChDPhjTSRpxf/47vza4TcuYIUPjMQX/O65+53jfVXb4hVdXdGLYnoZiYxK7KZ0qGHKhqVGuD+xYjICHPVtjK5/Vzk3fcbVUhBbEh8KMDq4ulp3DP0JLlIgDy5ZIdJBkHlcVaJeKpuiHQjLqHjgJUIQ9D5LC/ylFVh39+tgsuoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306413; c=relaxed/simple;
	bh=dTdILvHzvoV6EtxteKX/gUgAFJ+F/WOwUtAKf4Hyuag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JrZ7nM6eATglwAjBNGYQEoG0qH57tDrzen62jX5DUUrBOIIBtoZTjbYPTLk/XOUKvbiUsFXTsdd6s/ucT0KDMASsE83jtcH2GiJy7IsuisNKwomt5JKGX12+PX+ry3eCILKqTnqpgCf43IOj9pzTA3AwJfbWozzWeZsoV/DrdpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnIz/hUw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnIz/hUw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CE01F00A3A;
	Fri, 21 Aug 2026 10:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787306403;
	bh=dTdILvHzvoV6EtxteKX/gUgAFJ+F/WOwUtAKf4Hyuag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VnIz/hUwQJeD6Uc+yKYPjwQd9fReJ0/H4KfbJswPRIOT1Q6XicV9McR24yaeW5haV
	 qApC3LmXkEHaa1i85MiGVvBtWmu2Ptn48Ac/4s2j7iuWNcVI69kRSLboiJAHfDldIh
	 AqUCf2ZGSVMJQh/R1XayBYpNk8BJKZVKeAQEN25NJxk9vpYd8re5dU+RcpQ3lTstoe
	 NvebVTpkilONTgRPZptdJIGalReGJlcXe/8AOuQu4ftsHjAiRKFwsv4c4iAApcUYye
	 5DeIcpWu2HuUczVcyDgjnpuj6XQ5MPVHt1/+Bq6O5t+3lO7SgH+h/uU7vLbg3NUPke
	 2bZ4/AqGHwGpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/14] perf auxtrace: intel-pt: Use new
 snapshot_has_wrapped callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-8-00c4fd0701b4@linaro.org>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-8-00c4fd0701b4@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:00:02 +0000
Message-Id: <20260821100003.27CE01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The new callback is only for the search, and auxtrace.c fixes up the
> pointers after a wrap is found. Update Intel PT to use the new callback
> and finish removal of the old one now that there are no more users.
>=20
> No functional changes intended.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-james-cs-u=
nformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org?part=3D8

