Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEF837A82E;
	Wed,  7 Oct 2026 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397188; cv=none; b=F3sl1JEQvPqFJX1msRg36G3E+mfKaCWDESJ7hg86PV/N3NZCrk8BzKzba6r+JCn380gsmgqkMY+Bfrol1xlJpx7t63slb80vSpr/mySZSJdhAo3Q/VQL4I+wLqy99DreOaNUadQi02MCSrXYyr3Nr0ZPHW2gKuevYAKag3v/wMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397188; c=relaxed/simple;
	bh=mQWLG8EcUn9rp3N8qH/PyrT7D1WSn40KsnAxp4I24DQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=E6xVge9lOV1hzXX6e+KGDEdLp2tzTWjhUbpW+ipa5QX04RfneIBc/rwf7+Q2Zv/fUxISFgZJ6o7qytqJ9knJ/TxYFOyunKtqWv3bcVSdLr8HohBy7KHzG2vDrQOeOuW5u4YDQKtA25kbiQgdjKRJM/qJK0puQc1m1Q/JMy/f8V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=he5EXmwG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="he5EXmwG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009C51F000FF;
	Wed,  7 Oct 2026 18:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791397177;
	bh=mQWLG8EcUn9rp3N8qH/PyrT7D1WSn40KsnAxp4I24DQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=he5EXmwGY4Ogbz8AYsCS9+zEHVFO6C2V8BcmzgPUrJNY5YRW3VoscHkdbnWWmhNyO
	 yKAe+MniyprGYfnUE5gPwHlXc7Wvi2AEpw76nPm4jGJUdpsmCZYANuxQ9IjB6Jc//u
	 84Qk5HwMnUkIRqwScRiuBb+whh3hW7aBMpJJ4QOd7lnf5+bK3RSYk3m/Qe6RRs8pFd
	 TmRiWqu1LJfsDjO93HgljeWOSVRU+jp+oiS6Gwte4xIskJD8PLaH3WmTe26x7ubhfi
	 uMeLEx8BXLeG1eIqm+UGu1u/XlG1WdUNgqxVDqgfvz1BG5N1KZrDyUnwarKZ7hreQ1
	 pcCYpf8ZyW6Hw==
Message-ID: <sashiko-outbox-163284@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86/amd/lbr: Limit branch snapshots to valid
 entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261007181002.4005262-1-sandipan.das@amd.com>
References: <20261007181002.4005262-1-sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 18:19:36 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The branch snapshot callback used by bpf_get_branch_snapshot() copies
> up to x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
> last LBR read kept fewer branches. The entries past lbr_stack.nr are
> invalid, but they end up reaching BPF programs.
>=20
> Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
> amd_pmu_lbr_read() skips reading the registers, so that a stale count
> is never reused.
>=20
> Fixes: a4d18112e531 ("perf/x86/amd: Support capturing LBR from software e=
vents")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007181002.4005=
262-1-sandipan.das@amd.com?part=3D1

