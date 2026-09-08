Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC12559CA3
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874020; cv=none; b=PeX3T8KWmf/fu4wLCmS89nbiGnWqLSJ5kU53GVUkQeCN+htYZZjFfQAXps0B09jhPqY1mlGeiZj03wEuV+fR+4dnwKCARvOxXlpg+x1Gd6nEVvI6aGP4gnFcJre7QKegzXQrimYXzafThVYsobk5gRyS5U1LkNwncW6RbcoyqfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874020; c=relaxed/simple;
	bh=jtM2pj99rPU864NNP/mPOmNNXcoRJGZ3mUCYgvTrxGE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XwfiCz5dvfz5aRzEYQYErylCOMI2F/rpZAwrwFN2fMSho6+6a8KB333/7DB3/Fu+rq0XVpfm4tSCgGnVhDI02ZfWWMSug8fR2Av02kLvsN2uTCB0dAL/c7PxY11jmEMkbu62jknFvRCWnZBIv3NVG4JuGxixVXNY8BTWJX3BQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCko24Vm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCko24Vm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1941F00ACA;
	Tue,  8 Sep 2026 13:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873996;
	bh=jtM2pj99rPU864NNP/mPOmNNXcoRJGZ3mUCYgvTrxGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LCko24VmOvpoRjh503JwFXKKH/2Yh6r/L4AxgnjuvdKPlrQaxIi7eZOZtKjWySpWz
	 na5Zg3/7Nj5m5OhNhOw3btiG2CDO2osm/hURecVYCMu4/C2hnIcHmRujYrvXut39e+
	 GCrJcaO0FCOIQRW1MCJHE6mmXOMPo5r7pYb1FAK5/dr3vunYEPmFHhodAisvgkiaBj
	 D/2SOupo6EYOUssvwTRzPvPH7C5nLhlkR6L2cd/j5BHI8Q1A1wH2WakEjWeyY867pa
	 GiND3cmnX7B87EZBUHZkaO/gxZqQH5QaL4BFbooQpUMSlDmW0nKY/bT1O1AMzhKNpx
	 237IWHNXDMnNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 18/26] perf annotate-data: Expand type_state_reg
 imm_value to u64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <288e59160bf51e04ba6112676bf8315279635d13.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <288e59160bf51e04ba6112676bf8315279635d13.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:26:35 +0000
Message-Id: <20260908132636.4C1941F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The arm64 'adrp + add/ldr' instruction pair involves global variable addr=
ess
> calculation and passing, which requires storing the 64-bit address in
> type_state_reg. Currently, there is no field in type_state_reg that can
> hold such an address. The most likely candidate for reuse is imm_value,
> but it is defined as u32, which limits the size of values it can carry.
>=20
> To address this, expand imm_value from u32 to u64. Also update related
> compilation warnings and fix the sign-extension issue introduced by this
> change.
>=20
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D18

