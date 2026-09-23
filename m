Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF113264DD
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 02:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129246; cv=none; b=BHloo8FnpjgdIMnAUvrwcMDMCpfo4oSW7yvTJXkO9wx9qoodVpUg9qmdKWs2thcPhsvKr3MjupG6l+MiDW4dFASkWlCwWuk5dL4AfvF9ag1cJyeHzTPlv32oBTSvBIEFMdtrQysjHgKr7MocyBkrfAvQqK313pB74TXd2DjtHdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129246; c=relaxed/simple;
	bh=ixSV3Y+lfNg36t2wpQHpQW23XDTkwtshNIOgKj67dt8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=epknkrbq4uWOclK4LpVrTGQesKO/bxw4aB7GPUkHX0F2mPd2bAQ4qFRqGD+dj6Aed+ZbWtlTGEYwQGjoJQdjyqLa2JmfVVlEFx+73mtHbnPu/zoQzF+a/E4UlyckkFYjdYzWOvY+60XWQGTu2LhCa0oP5kQ7mBNTSc5/Y/T+afo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5U8mmet; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5U8mmet"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1A01F000FF;
	Wed, 23 Sep 2026 02:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790129244;
	bh=ixSV3Y+lfNg36t2wpQHpQW23XDTkwtshNIOgKj67dt8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L5U8mmetEnNZtL1Xmuwk2uD2BKd91dBsR46TyYdgusfHqcaw1QyR7MTBNAZAJZjGs
	 IqlKYzf4lOB9yr3ACa5oosRm3eZVQmpw8R1hUiB3PMowXlJ4deEaenrGsNkNm8nxq6
	 F8XGrV1UeCTHsj+GdBv7crv0JKxkvMAXkfUdPZGybl0RX7YUQHaXkg+OJ1/3cgir8i
	 SqL37rTl664pLux5/y4HVSGIw110oYNfSMdYUuZN/BjTIzWlVp811AZRpRUMtAy7lt
	 0ecPDRt3+4Sx8B+nj2wWi+wBexJIogYzu1tLGm5r2xrYuVWq6hl3uXomhSPboBCzrs
	 7/dZlht3VTotw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf jevents: Rename OMR offcore_rsp attribute to
 offmodule_rsp
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923015517.2665398-1-dapeng1.mi@linux.intel.com>
References: <20260923015517.2665398-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 02:07:23 +0000
Message-Id: <20260923020724.5A1A01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The kernel renamed the OMR data attribute from offcore_rsp to
> offmodule_rsp to avoid confusion and keep the naming consistent.
>=20
> So update the perf jevents msrmap accordingly.
>=20
> Link: https://lore.kernel.org/all/20260917015234.981153-12-dapeng1.mi@lin=
ux.intel.com/
> Link: https://lore.kernel.org/all/20260917015234.981153-13-dapeng1.mi@lin=
ux.intel.com/
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923015517.2665=
398-1-dapeng1.mi@linux.intel.com?part=3D1

