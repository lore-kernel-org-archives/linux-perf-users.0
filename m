Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E320D40FD9B
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787291531; cv=none; b=tL+s4VaEwUKVM7BLqszP3ku1Z+BklqGnuKUp/uU6TH2TKeftrct4CYcMxV1Mq6Or+Wh+t4zfrphnS3vAjEX6XEoChs2kzN2As67I6DQr5en/UTo+FYmJRcOO+WU9Fpcbyx/OYoaAP6KP8q3WZe4m0fVn7eTrus1eN7VAEQ1p+N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787291531; c=relaxed/simple;
	bh=vZLsvuTZtuJwniF1g94NkaLD4C17hZyuoQAbcB8OE5w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FCnG9u2PZlDtdWcVPbIFTLQgXPHhQh+OjhWA3XNLwHGb46OR0KLIOmerPDqLw6ZbGuj6Ko9kDF6FwrqLrC7X6pC0I0XTCcVGT8X2TZlQ667u5hPu48EQJVdgXWavvvu1IutwlwXRpbAJ8zm4ZKbCtRondxazNYWhDfqP1lQBq6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElEYniit; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElEYniit"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB2F1F000E9;
	Fri, 21 Aug 2026 05:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787291530;
	bh=vZLsvuTZtuJwniF1g94NkaLD4C17hZyuoQAbcB8OE5w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ElEYniit3wuXUOuZMVedboZdTCoQtUyJ468LflLXP4XxCdVC15LWv9eigBbPPxyp1
	 eqKqxaGP8EPUE12lLH53qEP/SgdjR9/yxfb3YzUgu75CyWP0haVH8xylvz+aePUQLj
	 JWfSLLq91XPIaDvG+G9cxpSC/h+f/x/vPyd1Y33r6oWqhbXlxLKunPzuZfRO/rQeHU
	 YEHj5e270HOFeeMNIr89en3Gngji8ys8K4adc5xpUeGuB6G5KIVxoehThpD7o3FWeZ
	 7z6QiOh9huwYwp+2Nseosh/9W2NTNg+MCwGI1e/R5+/jryGw2UNHqN5YGJILIa3ZpD
	 kNXhuRUk6Qt9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] perf tests c2c: Report skip when the workload fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiebin Sun" <jiebin.sun@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <7d472dc1b51dbdbf68254535d608c4fb24b75274.1787283281.git.jiebin.sun@intel.com>
References: <cover.1787283281.git.jiebin.sun@intel.com>
 <7d472dc1b51dbdbf68254535d608c4fb24b75274.1787283281.git.jiebin.sun@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 05:52:09 +0000
Message-Id: <20260821055210.4AB2F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The workload path leaves err at 0 and returns, so the test exits 0 and is
> reported as a pass even though nothing was recorded and neither report
> invocation ran. The check_c2c_support() path above it already sets err=3D=
2.
>=20
> Set err=3D2 there as well so a failing workload is reported as a skip.
>=20
> Fixes: ac881007c4bf ("perf tests c2c: Add a basic c2c")
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787283281.gi=
t.jiebin.sun@intel.com?part=3D2

