Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD263C10A7
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006165; cv=none; b=NfJ05yteblxbQMk/+BXp3mvU16jAp/aFZ+wW+1M9SnjB80k8rfCc+ZctPvKKS0RiM30SV9l/DygcnPHpH+1EOrORyiWdDsU064p1bEBXU9ZYVPiUtfF+ssGwnrNhnWknNzCUMJu4GPGx5Q0quf0LsrN1HyxuCwh7hjBLjciPF6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006165; c=relaxed/simple;
	bh=RlZB8VEjgRc7LR3K2jy5DYyKEVskJoaSiP+tZH+DZng=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OQ2BOD5jdusOkhwsGw/8gh8A+vII/z1O9dFaOyT1+CzxiZP34H51iw4/pPpodZHUUjSKGOh2TztXrJmZ/uMqD4jupB2zamT4T2pCB0G5wMz3PqvXIVgdTwwHw0iso1IDxXNFd59yzod2mdZNSHOu9n1+W1qYRDyyAuTUNDeFfR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exJrPloZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exJrPloZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CE61F00893;
	Mon, 21 Sep 2026 15:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790006163;
	bh=RlZB8VEjgRc7LR3K2jy5DYyKEVskJoaSiP+tZH+DZng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=exJrPloZ6zgm3/p9YOuhLx6d6gf6vZdcAy/Uf2nLpJx1/pfr8AubCg3euZVQwftoZ
	 wczvDIfI7AqAqfmUwqOp8hFTkjX75mzvvgOcLAdL7oq/kh420h98BZ6E2JRejBVqod
	 kkFyP4NzbxMSftcTPRmnv6c88IzQg8vUM1wAnkKLB/GxNcPjXLrAIoXN8AQ+I3Il81
	 TIdQ6rqQ0aszGxuBVJ0TlBRvqr+I1HqJoPR42Mutgpdjp94INszHNshyqHSlbiYWVn
	 hPQPYJtYZqkOUyyZo1WAv/0PEewuMbuXo5/LefGWZqC8JkDsnr69dRBj7q6BugYdZf
	 Qf+hNMiHw9Qdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf build: Follow sourced files when running
 shellcheck
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260921-james-perf-shellcheck-source-v1-2-adcfc107c997@linaro.org>
References: <20260921-james-perf-shellcheck-source-v1-0-adcfc107c997@linaro.org>
 <20260921-james-perf-shellcheck-source-v1-2-adcfc107c997@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 15:56:03 +0000
Message-Id: <20260921155603.84CE61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Shellcheck follows sourced scripts when -a is provided, but only when
> that file is also provided on the command line along with the one being
> checked. We only ever provide one file at a time to shellcheck, so -a
> does nothing.
>=20
> Improve coverage by following sources using the script's directory as
> the base path.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-james-perf=
-shellcheck-source-v1-0-adcfc107c997@linaro.org?part=3D2

