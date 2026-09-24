Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC0F3AC0F0
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228463; cv=none; b=XE6wbLYFG8Q4bQ2v8tN1kYVRkKoBednb5hEyWFboJseXewGmpKWY55U6R6AvXedq970WmXVySXQX3N1bMVqxU8YEguzzisMHfKNZ6skpkiRr3ucMlgKttZchbYCO3IEge+YohzPvWGJhYtrTSChUrdHj7QK5pvpcieTLBV4owRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228463; c=relaxed/simple;
	bh=44uNN8+jSzhHuLk0TtNyZkgHjCfSYUKOxjdydLLNDdw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rFd7028eY1rNaAAgT5zgW6oMY2kKkhgWj6SeelCc2bj8J/7NMtrKPneHaUq7NZR8by2Cfj31crrg2nJaIj4jfkUpHIaWXC1Xgmahim9IXDbmF55AL0U9IoFAtEK5pxMxac3GSIp4S38T+/QsodMkMniIkYvvZ2pTq+FmQDZT7/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WO3G1VGe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WO3G1VGe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C481F000FF;
	Thu, 24 Sep 2026 05:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228462;
	bh=azjBjaRHRx+nguPpMUFpvcKbbwG0fwMU+PoeH5Zd4Jc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WO3G1VGePoW0GY9m80IlKWiKh0gOVGBZszM6hGzNzUbcG4JmMAiHKxbZcFbmCKa43
	 X4KHKFWcqSFvJUFxegb9MsAT/FAOL++kLfhCkkT6nsOUfeAjclysEQqArYuvQiHXAF
	 H0fjIqhEQ2i5lt1aS2O7usnDMA7CsPwJ7O7mB7f6HjU3BV02+pryx/cFNKkQtuhsbX
	 ISF3DHbk+fJ921zRHioYJia1apPfVYLTIb5rGccWebc+2w7hcMsAeCDt1PTOyE8/1L
	 d4LuPms5e6IJq2b/u5gBG6Wvg3V75FOiASJ65eG7JAn2iS+vOffXcHKq4aldn7WVRj
	 kzyfeEzz1NO8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 16/21] perf vendor events intel: Update pantherlake
 events from 1.07 to 1.08
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924053645.3555041-17-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924053645.3555041-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:41:01 +0000
Message-Id: <20260924054101.F2C481F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/f3bbfcf86d67948fc330d4b2cddb294=
087663da4
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924053645.3555=
041-1-irogers@google.com?part=3D16

