Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A1745C6EA
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 09:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464236; cv=none; b=LlgSr7eg4aZNQt4l4iPPVpcz39nskUx85Boy1uG61E8fOW0dFopIfO08zyVTyiF9AyJSkgQkleDCncLZWqhJHyRKSJuO5nsjYQaEsLETZbrpcN7+m+Jd2t5NFP0ipiNPs8jjeqK68SHMNnEs7Q46Bca67+QXeukKZjUGb5wR5Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464236; c=relaxed/simple;
	bh=Gj11kpjOSKJEMdJxv/G8+8uSDQiGVks6PCcjaOTBOAw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UfQa2u4kImaMk+Zfj+COimr3cFk6cIBkZq35JGoP7Z3o3mbvc66QQ5J/DRtyiSjEkPbsUEx5uZMnAkb55rIR3YUXj5Z+jthi4yFAFmSGe4xeCwFldSGdNA2pzAYw7TX+SfwoyFyk8i5QdbUXQvGGcloxA7KcCQocqpSKep2Yfwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDYdjkTs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDYdjkTs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A411F000FF;
	Tue, 15 Sep 2026 09:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789464234;
	bh=Gj11kpjOSKJEMdJxv/G8+8uSDQiGVks6PCcjaOTBOAw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LDYdjkTs0rIGvUOIzyWU2qSMN2D7GhX/2N0sv11azvbNhrg/8ju9aOrpc6M/5xtQ/
	 C5yjzLUEd9XDmc5XxEewjfshtdCT+ysIAWjPVD8J2TQBKvOcU7aZQa9JVH9jKFLVvD
	 8yZPkXq/so578o/n7cY92MlcdR1+2ttJHwnnlFUFm93nY//qZnR0rDyZZ48pusf1Nt
	 PrEp3xlvhjnDmx05BJyiWCq3bQfIRTzx221uiaXQB5H2r55RgfUhtE197OWVr4pCCi
	 VmYI8UCig9bNHPMmbDP2GBDJl6ek5Ohx+Go4jL+fI4bvfxCwxcjJxvvMUSrOe0S0q1
	 3yhpKi+6TLkDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf util: Explicitly include required headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260915091112.333308-2-dapeng1.mi@linux.intel.com>
References: <20260915091112.333308-1-dapeng1.mi@linux.intel.com>
 <20260915091112.333308-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 09:23:54 +0000
Message-Id: <20260915092354.A1A411F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Sashiko complains "the perf tool can be compiled with musl libc, which
> enforces strict POSIX namespace separation and does not implicitly
> include headers. Relying on implicit header inclusion can cause build
> failures under musl."
>=20
> Include the required headers explicitly to avoid such failures.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915091112.3333=
08-1-dapeng1.mi@linux.intel.com?part=3D2

