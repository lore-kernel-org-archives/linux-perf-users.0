Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024193093DB
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 01:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350828; cv=none; b=A54bl3p8FxIRMvJlBFCGfIs+6j2Qo17B069SxmMjBbtp62izJgLhlL0C5iEz/YfvrMJGsSDLtCRLQX1kr45BHRWrpZmQjsVu0gFEekGdaWXMxErXrV/czeNaW+9oXkG8jogvWoAUPhAZMQvRf8ewBdvULfE8tIJ4ekmNEfPZhLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350828; c=relaxed/simple;
	bh=Tp2Wz/TUfDGRoq0Av44XkikYstnonNcsd8pOoccYr3o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aC0Fos12ZXFSm51F8pFOuqJM5SMfYho2Wg0USjHSXiOnDV2UuZKwmI4xFozQHskzNA224tdC6XJSnW0sbxf8kGuRaPuV/i7C9pPCtGcQJ3D5pwbEhbxjJ+mtamDyM3KLofky3pOOvFKCYQf1TT1zhr9UjNQi+yAFDeARQk0bYBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diHGBiVn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diHGBiVn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCE41F000FF;
	Mon, 14 Sep 2026 01:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789350825;
	bh=Tp2Wz/TUfDGRoq0Av44XkikYstnonNcsd8pOoccYr3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=diHGBiVnCPO/g2+dqBSm+PGgkkpbOBgtbzT0J8tWn7neIx7GdyXtNRZ5eTcfCp43w
	 1DQUUg7tEL1AtLCGx8mY084V8SfuWxJt8LLsJMCCV6P+kszl2r86suC/bQZ/yWjbbd
	 jZghzvhQoLIF+Zs4hgkXA9VHR2c82SMX9qqvVIPS8PwcEMmasYJG2gTnFtGrc07IkF
	 McvTgmqIAV5MklH3aLQgKXqH1h/PzeRfi6EjOw5Msm30yaxLlbNfWvd6PwFKSKKfbx
	 UlI81OtXc0rgphEtYEhJ42xiPiUx8lXoUHIncAgajccC0F4VDPkcDNYjweSO9U28l9
	 4R3Sd0DhE5ONg==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v11 02/10] perf util: Add missed fields in
 _attr__fprintf() and __attr_swap()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914014049.2061519-3-dapeng1.mi@linux.intel.com>
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
 <20260914014049.2061519-3-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 01:53:45 +0000
Message-Id: <20260914015345.9BCE41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Some new introduced perf_event_attr fields, like config3 and config4,
> are forgotten to add into perf_event_attr__fprintf() and
> perf_event__attr_swap() helpers. Add these missed fields into these 2
> helpers.
>=20
> The aux_action is an exception. aux_action aliases bitfields
> (e.g. aux_start_paused) in a union. Bitfields and plain u32 fields
> follow different endian rules, so both views cannot be swapped
> correctly at the same time. Leave aux_action unswapped until the ABI
> is represented in a byte-order-safe form.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914014049.2061=
519-1-dapeng1.mi@linux.intel.com?part=3D2

