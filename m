Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3190B2620DE;
	Sun, 30 Aug 2026 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100438; cv=none; b=kgNZCViIFjzBxrDtlIhbNUfvnKo5gDQR5TgNtJyFbZC+H5vxOhfItxQnC4XHsnkUj+cevn1hMbSYhQmQds1zXrVwWgd4M2B6+pHlqURuH7zBW1TGdn8Z96AnzRw0yMlET3TLkbc/n6zdvhbrLWSwpbMX7FGEYwKU6Wv/cmucEq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100438; c=relaxed/simple;
	bh=oq29wJQMyyAwCFUwaYhXCI/d9/hV//EcG8927xk+1Aw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cm02Oa/4Elrmfc6P6Vp7XDerPziuMq53LuCK229mWv0dByoF5pcKzgu3lZsJUVmzStG4g5dkuMCl4S1WJTkwuYI3xgnkcT47qQCPLmxFzjxSWnRW7ET5+ZLWosJAV87fN2U1NqBolnO8XK2tQWWpTUyDBGrtN3kylCe7n2gHhqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbEJTKU9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbEJTKU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900021F000E9;
	Sun, 30 Aug 2026 14:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100436;
	bh=oq29wJQMyyAwCFUwaYhXCI/d9/hV//EcG8927xk+1Aw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FbEJTKU9capH5Y9hjJHWDFCGRlBA9mvTt4FPncAidNOYXARc4VPRtKNjfknxhGUzc
	 6KbeNdsBfHN+urMpvCGPTKSagdFF2Xy1sTl81aA8sA8yuj0Os5/4UwM7byKYIvy7U4
	 O9OctWOJxbBlS3vEVWbzAXZ3p+eLKXN48B/qoFxNqjRYn2nNLi21rLR5Vmc8bq8NxZ
	 ukXDzXho17fg17nlNEn9EI18tgPvWYKkyc4NWfo/9Yv1+RdBs1iaL0eZV25ogd/eKR
	 mTl73hbmDqAFNzai43tfBPnWgtFrnSYlEXZuCxHPHVmKxV8TmRC6jSOuIFcy3lMr35
	 R56f1azthsebw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 03/14] kprobes: Protect kprobe_blacklist with RCU
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <178810004323.64882.16493230858653316962.stgit@devnote2>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
 <178810004323.64882.16493230858653316962.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 14:33:56 +0000
Message-Id: <20260830143356.900021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> __within_kprobe_blacklist() traverses kprobe_blacklist without holding
> kprobe_mutex. When a module is unloaded, kprobe_remove_area_blacklist()
> removes blacklist entries and immediately frees them with kfree().
> A concurrent call to within_kprobe_blacklist() can therefore dereference
> freed memory.
>=20
> Furthermore, within_kprobe_blacklist() can be called in atomic or
> non-preemptible contexts where the sleeping kprobe_mutex cannot be taken.
>=20
> Protect kprobe_blacklist with RCU. Use guard(rcu)() and
> list_for_each_entry_rcu() for traversal, list_add_tail_rcu() for
> insertions, list_del_rcu() for deletions, and kfree_rcu() to reclaim
> entries safely after a grace period.
>=20
> Assisted-by: Antigravity:gemini-3.7-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178810001186.64882.=
2161016469449127450.stgit@devnote2?part=3D3

