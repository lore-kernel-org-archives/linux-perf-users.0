Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE64C51A745;
	Tue,  8 Sep 2026 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788878159; cv=none; b=cAX1mg1wXDLc6Qhlosv3NrQzAtRc9ZwoIycBWDPGZCM5H6zi8nuzzGefQL3j7n+5rnMsEjdM2ap/MAPKkZkDHsXnf2TlUoYQQdKr0EjMog3dsdxcS8JgcnBB6uIjBNfkWhPqbZ/K6LjVecvOviQH/dMM6xBJnwGy5VayUc9ZZGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788878159; c=relaxed/simple;
	bh=cEsYdjpPDbyI7gZdeRN0jNUla0oV3utG3+gnbFND7UM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oYK3127lpwBC++VHxN5oaiDk6JHcnvN2kexIR4dPJH1g6QOpIRe5zLVys8tXsKE1TgdOhAFKgTrrHcws8XDu/bhOXCZq1kGvMA8pMUd0OC9bYsLRn3+fmIaGZEc59S3RL35/U1IzpltJHYVa3bq9i6i1IjE+Hs47ly+S86X/G3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/JCtw0P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/JCtw0P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37851F00AC4;
	Tue,  8 Sep 2026 14:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788878146;
	bh=cEsYdjpPDbyI7gZdeRN0jNUla0oV3utG3+gnbFND7UM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L/JCtw0POKPVhHpvQHAsJCugRVDiA76hnZMYKl3WZvcgN+nIlJtuK46oUS7UaHe1h
	 fNsty7ACKJ3ysUR5LNGmldG5SIuJ4z6eOB+b07vCmE/dl7qZ8J2wZl1CGfljVoBiXC
	 YkxeVFbu4PKUxWfijIbM2geTsUTHbbXMH94XpAHF4gSs/5mx9If36WvQyZM2c4zxnG
	 TbY9dLiUHvG3F/GxmmOynCj5zSnhOulNv4kjIoswsGe+B1WcOMkuyDO7rfh0m+tWSg
	 rlTgflFJsXWxm/ylzqtDh1fvTKWMwnw7iTa1cCxrkc7dbhTxnFvnsp6kCDrhQTR9ul
	 JPOpRqI4qrEOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/3] bpftool: Track perf counter snapshot
 state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260908-bpftool_cyles_per_run-v3-1-60e86f325c35@meta.com>
References: <20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com>
 <20260908-bpftool_cyles_per_run-v3-1-60e86f325c35@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:35:45 +0000
Message-Id: <20260908143546.C37851F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> A perf counter can be zero at fentry. PMU multiplexing can schedule the
> event during the BPF program. The old counter check then drops a valid
> sample.
>=20
> Use an armed flag to track each successful fentry snapshot. Reset all
> flags before new reads. The fexit path clears each flag when it consumes
> the snapshot.
>=20
> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-bpftool_cy=
les_per_run-v3-0-60e86f325c35@meta.com?part=3D1

