Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0970741A501
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 11:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435759; cv=none; b=lTBdryD+AL31h5DB0klAa/r7LWD2B3H9A7ai8LaG1Q75r1eJ6ls1A3vrSZNL/yEjjK26H8sKmmL0LYUogTJFC6JTAzi7OgFAU7WQS8Teip9MErfZsK2IaC2NVhgAPuoSJrw/okWMfK2IaNKehsNgXn+CV4rIgIO1oSADp4Af2NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435759; c=relaxed/simple;
	bh=IA56K7JK9C9fxxMUswadHRsL3p1jaQDWNFk9G5B1vBw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jgQY6MJdB9n75bHSw/hko5lT2cdLi12AG7RWuf7cZ3gYxU/VseBKEtfXNHOoqkrPwa7JPJRsvhbWaz6wW++VZBVCmnxFqzZNtXBrvnNu5gbFF4nQZaY4PnrscZaCiKrjk/nCp4s+e6wvc6RWrP2azE9ejGmVqJhqnHpHsAiZJtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2OwseZ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2OwseZ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E9D1F000E9;
	Thu,  3 Sep 2026 11:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788435743;
	bh=BAZNwoSQplg7RzUISs1lrAdbpeco2/5h0zxQcghTA+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F2OwseZ1Zxzcmcnalwm1C1lQsVBCKQG8O7/ZL+RtI3AKj5BT+BYLCNV3YK578z3le
	 ekPZ6lqOYwidko7MaC3CcK48jAPwV6YL7ooCblQmnPq5CEdhKldjb3hwGKHXbHdN52
	 iWEOWE/qIRZ4wfz7/S2Zx9lPfY1sldIzuYX0IjJj7t8QqxJ7V90qla5r9m92rV/x0X
	 +r5gebwK79ZkJM547ZbWE5b1zYhNW7pmXu+Zq3TgpiGjOcl5xsMn6zdbea+WpoDwbY
	 PwAJ+3gqqeePItLILg8ZHx9Fjx6Ahp4vRtaaGRcmVYzLqfVNy+kKY27XLwzoBVT3+H
	 +CYcy7LfdYcQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf sched: Make output_name variable static
Reply-To: sashiko-reviews@lists.linux.dev
To: nanshuaibo <nanshuaibo811@163.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260903112835.1694260-1-nanshuaibo811@163.com>
References: <20260903112835.1694260-1-nanshuaibo811@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 11:42:22 +0000
Message-Id: <20260903114223.56E9D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The output_name variable is only used within builtin-sched.c for the
> stats subcommand, so declare it static. This fixes a sparse warning:
>=20
>   builtin-sched.c:4140:12: warning: symbol 'output_name' was not
>   declared. Should it be static?
>=20
> Signed-off-by: nanshuaibo <nanshuaibo811@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903112835.1694=
260-1-nanshuaibo811@163.com?part=3D1

