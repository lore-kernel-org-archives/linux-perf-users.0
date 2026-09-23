Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B053B27FB
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180686; cv=none; b=nM4brOP2ez5d8NmoBxz7tvQ2rqcJXKNgEiwdTonGjEFcrVP7v/Oo4m4lbmkxRwN0dXrpsm0iWZajIQCdS0LhnM8QjQJMndEpU1T41Vt++slI961+Kas+bCBZZTSfI5lxEV72J/p+9usiu/ndYQMQ/gQCMIaNThEui9IiBHEmj9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180686; c=relaxed/simple;
	bh=ShLOO0HF1JUUX3dSkKujkffrkh/N86oPMbKTgo1ZJF8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sJm6YQk09gtPT3EoYJVtczdrf0XFHijWLrpvKtO98GqMYo1yqHwd/Z1nu34+OPvACzSTzWyi06utCvT1uQLdsDDtZ2Zz3RTmEzykaWatuK2wiIN46ATHaH7qoE/YpCLvonjCTzDlqnGIAuxTtPbnAZA1piFVui511IaCkX1SlUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASFXMe0R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASFXMe0R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D9C1F000FF;
	Wed, 23 Sep 2026 16:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790180684;
	bh=ShLOO0HF1JUUX3dSkKujkffrkh/N86oPMbKTgo1ZJF8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ASFXMe0RB0jTvyj1XoRD+AqD8NHlXJOwWbZoH8vkRlyodGZtTOVeaQ3FBzT4+c9cX
	 mr4xg9+oPnjdWpz7TBGW+vWyKy1Dc1BqJ7w1X7QxwVdSM2v55pyiQhXrYFNs4I+xul
	 vUmtaKalOGqBqLVs5YApbWLScZgkiFKQYKAT75kYAcpww1RDVwW7zp1heDFTciA/18
	 XaPIK2E1TuL/XhF3C1nBuyiwHssxl3YvAl9tDRO5WHjhNRd0aceegIXF1umFiwViKc
	 KKPlYg0t2KDImalHdleG3BdxzifzlcWRpnBXMsUW8X+4bkC8wwseC5mGm/EWeLKqY2
	 ZN4HUHdwNOrIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/14] perf cs-etm: Classify exception calls using
 the exception packet
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-9-6ab8c07a5455@arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
 <20260923-perf_cs_etm_fix_non_taken-v2-9-6ab8c07a5455@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:24:43 +0000
Message-Id: <20260923162443.D6D9C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> ETMv4 and ETE use the same exception number for SVC, HVC and SMC.
> Identify SVC by inspecting the instruction before the preferred return
> address in the exception packet.
>=20
> Preserve the exception level and preferred return address from OpenCSD,
> and use them with the packet's ISA in cs_etm__is_syscall() and
> cs_etm__is_sync_exception(). This makes exception call classification
> independent of the preceding instruction range.
>=20
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-perf_cs_et=
m_fix_non_taken-v2-0-6ab8c07a5455@arm.com?part=3D9

