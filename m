Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048851;
	b=1BMStc5AiWdqEPFk7vszdTXd94Sxqeuq4zHQb80PFQHS62Y/pr3jYDejnp8fOKs5f9BF
	 htvTTQezduaY/wND1DNWb7iEMAuLgTVwpwKEqgMogPw8feN56+fOe1auWY0b6Gkn73L+O
	 FCXdr5/MI20s+XPCslicmkJkKWXj5WF8VQjNuVpUtR+kjdtle0g91hDktIdGH78yfLLIE
	 31PCwmWVwV9P2Ld5u4KbU/7M+TTY0yCFhV8soUl0gYWRop6cOuYfDa46CxIcW7o18Px1d
	 tpv8kpDC89OikyntBOzUjy8erELzyo5tu/ESPWxCP4zEAyCHIeWKzlofKui/BxZd9xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048851;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gfSAUD9uJY+YDfVq+Q6PpejS/TXVIhkpdlDZkhIWdf0=;
	b=ZchSlZ2z7EVCF/tIQ21qEGxrF6Jbk60Oit0MmKyADzib2WulDKUvoqbVaer5vaLf/oyR
	 8IFBp5E6ZBsq1uyc/6VXg+M0a1glomZJEItuCw1f8DAYvOEjBZUU4P+WZsMgFbLnhRwtF
	 ur1a9etz1oks9rqNAs5HLpMAdqgJ5QqlSQB4SABySvMc3ZUnLfnNUMfnR31MpOag5XBVA
	 rgFeJgT/0OnNt0JqZgyk22qwlkgrioCAECJzQXIsetXoB5MxQ3L5l8aDxIs+jAADHX+hi
	 ipbim6yQGn1xGH74P8+v/HAWlLXlBKOmwa7KeO2BIBKhaLkQvSr+YSLxYUHV7ZOpc+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CkCzPtWn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A15606A32D;
	Sat,  7 Nov 2026 10:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CkCzPtWn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8351F0089F;
	Sat,  7 Nov 2026 10:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048850;
	bh=gfSAUD9uJY+YDfVq+Q6PpejS/TXVIhkpdlDZkhIWdf0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CkCzPtWnrWt1bxT8ppDQCbbtw5F8AiOZJZ4DTnwPllIujqA3bWhQjzX+iY4zz/DT1
	 BIRVGyn3kZIk1BmSgHluFUyNQRwTVmnshUDYn4jBLfNRV4Gp8LUplVSgjFHA25egAi
	 Tt4UcTYEH1aBQBsoXqRKNBldLarWW7FnlhO1XJBoO8EYIAH+VvjQRDsQhEe72ssbAG
	 MS1vJrrGqxoMs+EaMOBRC+bMygDaTgB2Fut91IgXFtIzvOIjF8lmtOojGVrsRAOFFj
	 7Dh2YHjrn4/pxLFAHiwVaDtcOsa30akQQtz2kLS7z9Sru3gTbRSrCx3TPDNwKphkgt
	 eGbzZoc1hr27g==
Message-ID: <sashiko-outbox-202829@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/15] drivers/perf: apple_m1: Remove unused
 variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myria Sarvay" <myrialsarvay@gmail.com>
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261107-m3-plus-pmu-events-v2-2-acf1e78da039@gmail.com>
References: <20261107-m3-plus-pmu-events-v2-0-acf1e78da039@gmail.com>
 <20261107-m3-plus-pmu-events-v2-2-acf1e78da039@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 10:54:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drivers/perf: apple_m1: wrong Fixes commit for
  m1_pmu_enable_event()
--

commit 46e6058673421fd04a6bec454dd88350e27b9540
Author: Myria Sarvay <myrialsarvay@gmail.com>

> drivers/perf: apple_m1: Remove unused variables
>
> These variables are calculated elsewhere as well, remove the extra dead
> code.
>
> Signed-off-by: Myria Sarvay <myrialsarvay@gmail.com>
> Fixes: a639027a1be1 ("drivers/perf: Add Apple icestorm/firestorm CPU PMU =
driver")

[Severity: Low]
In commit a639027a1be1 ("drivers/perf: Add Apple icestorm/firestorm CPU PMU
driver"), m1_pmu_enable_event() passed evt, user, and kernel to
m1_pmu_configure_counter().  Commit 75ecffc361bb ("drivers/perf: apple_m1:
Refactor event select/filter configuration") changed
m1_pmu_configure_counter() to take event->hw.config_base directly, leaving
those local variables unused.

Should the Fixes tag reference 75ecffc361bb ("drivers/perf: apple_m1:
Refactor event select/filter configuration") instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107-m3-plus-pm=
u-events-v2-0-acf1e78da039@gmail.com?part=3D2
