Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56502463B7B
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 06:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792044913; cv=none; b=my9HtTAE9NxPfkttZeNmpmf0zRHBamXfjdOY9VhYUjmbbuN6UemjGttYL3hGukZRzlF2/UOxyXkWxYFZteHlrXmny2N8XH0VmqOTn+llva/1Ggn8E0ZsJ+gSbyoKR4t+M/j+WbyXydzc67B6RN9f+m2B50zjkjVoruQU1Qs7hT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792044913; c=relaxed/simple;
	bh=AtXvp3TsYjGXIVyN3rj6MmR61sOOIpPxSi7wCwppGj8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gNIyxJZimcKl+zz8EcPjiQXrFDElE0k4JfB1JisHuH6slX180SyXbKpsOO6kXGjecR/9usdKPT+kx7OLZx/NMDDCtyl+sLr5Uxjcn6f2imfUpg0aEFKvuXuQgsMvRE/+8JpKIkQQ8rSF91wHqnkcikElbDxqxo81qwr2730Ik5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhxdJFg0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhxdJFg0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD151F000C5;
	Thu, 15 Oct 2026 06:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792044904;
	bh=AtXvp3TsYjGXIVyN3rj6MmR61sOOIpPxSi7wCwppGj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PhxdJFg0mqHrQKGheflyopniwUZDDHr2KbuTpSPYN1u/s8E58R4ucUffsJzWXUalP
	 7I/a4VLJ6Uy4TdUcdLtXQUUNzKPKn95hycx5jYKzy/Uw2EXTTFHvaxO9WYOKN3GFLQ
	 qfak88nMzuPdQHoFtSDmksRIN1tndH3aB87qlo/PVZApcGgcDmuwS99S6C/ijsHV7G
	 Nkh+esEq8ad/eg0WpcNnTyoVVljB2Ps+OJKmEOmP6plY4Akvojdfzabpqk/974PjF3
	 2lx5CsAUkP5SxgEXleY0puB1FNgZcaAYVvkXrPqu50Z0qaXUwT0vH8N4sI0Iswfaqf
	 8Ix6fbnVo1/zg==
Message-ID: <sashiko-outbox-172335@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] perf/amd/ibs: Reset CPU0 IBS state on syscore
 resume
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Bangoria" <ravi.bangoria@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261015060430.5877-2-ravi.bangoria@amd.com>
References: <20261015060430.5877-1-ravi.bangoria@amd.com>
 <20261015060430.5877-2-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 06:15:04 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> During a suspend/resume cycle, all CPUs except CPU0 go through hotplug
> callbacks, which sets up IBS state. CPU0 bypasses this path, leaving its
> IBS state stale after resume. Fix this by explicitly setting CPU0's IBS
> state in the syscore ->resume() callback.
>=20
> Fixes: efa5700ec0da ("perf/amd/ibs: Support IBS_{FETCH|OP}_CTL2[Dis] to e=
liminate RMW race")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015060430.5877=
-1-ravi.bangoria@amd.com?part=3D1

