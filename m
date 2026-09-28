Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D703370ADB
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620547; cv=none; b=HD8Wy8x+PPXD2MbTyic6iR8eyXIyWJWXzsXkwyGkM0tSUWUMgA9QDOiX/QMzQkas0h/zsGO8fwvJ02+zOg2iRdIjGzc23K8IzUFwD5w3mSLyOS6HPGv2LGINEsq60uTefQRXKBaGQUoR1lNXnKriGIr7XIQjujwIJfoZXXKFQCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620547; c=relaxed/simple;
	bh=t/fH6gE/nNDrA92CzAHEKZnGBIwzwmfEO5UrwBY/FPA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iZ0FmzOgLYJetim8iIX0kWct6M9NcQ/YOp4Op7DFZV1xEtpuLijR7PIRXf0cjYbMyozGhrkiclzrY854P3fI64k/mAH0nT0EEH47icyvlNdMxO+7Vncwx1ye4C9lPHAdmfanz/3ZzpRzVUoS9nMM2NQ47SDBZXcCkvva4T4aHRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqt87EPH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqt87EPH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D491F000FF;
	Mon, 28 Sep 2026 18:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620545;
	bh=0mzhrgPiWRja7BinvMl0YNFZcSGGtk9sKYqVT7fuuC0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nqt87EPHfT3ZCJrqMmWqPszrC4SYRzGk5Jd4Rd+Xiv7x8+XuTXfNwGSr5mVKTJs3f
	 yh4K0zNYh6il0YJkccyCVHbj87r/Fi6SSkT1PTWrfkI+tlhKckj+4XdMcXI3jk5QoK
	 1CEC9bEhqQi5MhXe0cKejwZ4JpTM6ccrWFOoAIRxhNhgFbHRaHNN78BNkeMEIfGrR5
	 NhZzjGEJO4bhDmbBY7EUPiUuM6XEQfysnaO+XHdBoxqwDAHb28JVXXRnLKKwy5KI2S
	 eFb/WibYe/nBhGOHjQkgKh5GpzIMOzRfRECc+xe2UhoRDTc5zTn6rmuYgZygR7Dl49
	 KVZ1Oy82G5VYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/26] perf trace: Split unaugmented sys_exit program
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-12-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:35:44 +0000
Message-Id: <20260928183545.75D491F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Namhyung Kim <namhyung@kernel.org>
>=20
> We want to handle syscall exit path differently so let's split the
> unaugmented exit BPF program.  Currently it does nothing (same as
> sys_enter).
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/r/20250814071754.193265-3-namhyung@kernel.o=
rg
> [ irogers: Use struct syscall_{enter,exit}_args and make
>   trace__find_syscall_bpf_prog() fall back to the exit program for
>   exits ]
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D11

