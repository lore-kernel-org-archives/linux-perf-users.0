Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BAC3839B9
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 23:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330899; cv=none; b=m/8ALjQfrtS3odzjvf4BMUlfr4gX/oVb4lQpAef1qxXvDS0wRsp0C0VePKSPG3jexjT0ThalJXkC/ZJNvXy7HzKXEld/+BZXCqECB0QdT/+1m9eLBA8V7e4f8NJ/bG+C2uqGyvJGGK1vyA5wldQzP2omlqW1LfMb9mDwCFjFzzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330899; c=relaxed/simple;
	bh=dbLIOhDmZy1Q36XREGHyQxudLxaYHlISfH/dO30MpM8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QhswmHRVCxvgL94kcRuFbi7ORmoogiswCRrKakMh9iR+H3UNgNHKRBftE8rCZR1Y2KC66dRbbjYtdgtkOKECD//PtrkpJqw+KxLW0LR7rrZ5oGgXutqZKiP7n5vNxAqeFHE2AKXdGtHDCagGHLJPADq2YuGn2lk99suUecSA9Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6n1vDZD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6n1vDZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C5B1F0089B;
	Tue,  6 Oct 2026 23:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791330897;
	bh=+OoHZ3JYQJ/EK6e+HerGZ6R32X036OzbbRdqu7Y8z+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B6n1vDZDCf+MNM317GTf2tPUDSfihWsr2EQ+Ni03kuUtYs7oSdcKzqpQKp3WQCXqZ
	 RZwBg7F59A4XzNHL8Yv0bgRSqs9svwAWvnMYoqMg/6q6t50PzGLUyN+nDxoIT+pl3/
	 /NUDG2GfniIF58OAOvJbTKqRF+YiuK3xCxqpge9EGzGrk0CpRxn/5+wxWFXQvUVFAE
	 8KrOnBJ0KXLI+xpheDFpLtxBZPa7cSHWuy/yHqZPZFfm/SyJWCNk9S47h1OtdMXX7+
	 VafZN7SH9FIncsOZXCRBIszQs49dIiZQTW68J/o83/mnrDgguQz9NvPjrtxSYZ5SqU
	 DYq6EpNSXoHMg==
Message-ID: <sashiko-outbox-162538@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/10] perf symbol: Update symtab type of vmlinux
 from build-id cache
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006234315.920817-4-namhyung@kernel.org>
References: <20261006234315.920817-1-namhyung@kernel.org>
 <20261006234315.920817-4-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 23:54:57 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Currently dso__load_vmlinux() sets both binary type and symtab type to
> VMLINUX.  To precisely track the symtab type of the kernel dso, update
> the type to build-id cache if it's loaded from there.  It won't have
> any functional difference though.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006234315.9208=
17-1-namhyung@kernel.org?part=3D3

