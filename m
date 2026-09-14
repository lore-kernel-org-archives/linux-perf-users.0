Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B9043DEAC
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789382859; cv=none; b=DTCB2O51UVlPNgxVEyN/IIjY07Skfi2xdDHcZdTkfeTGBVFgdZKjv7JtHH9rj58hw475dgFL1bDK5mM7nR9GrcYP8VHvcH2CYv9f/DE/CFAnFWPt/wmlhLQjY7j7lobxgh2l6qCEsRe+GSi+yxDy6zpkIVmtsKDGHOpUZNUPuYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789382859; c=relaxed/simple;
	bh=wb8HonF3oeTphIQSArY1o2gV3MtKzQV+bbd4/Mi+Stk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L+nR3rj4CJdcUWw1iKvV3uhkJ+cQI0AMiSR0vVvknNhO2UOTf1KQ4zQeCmLbeqn7q1NjksV3dQphg9wnPudRMKIUnp0WbGJUKNG6cM4LuFyT6GiyN1LVk/1GFeu312AABYKLfxfnfYCMp3MqWQKQTzjy2AhnXMXvbT7AlYAQTqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBGQA360; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBGQA360"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD681F00893;
	Mon, 14 Sep 2026 10:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789382854;
	bh=wb8HonF3oeTphIQSArY1o2gV3MtKzQV+bbd4/Mi+Stk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OBGQA360dBFh0J1VORYWO/hpN5T3cBvEpJ60m3f1l+I0tzeRw2SYd13zSjLJ8HrRp
	 OWVIAEmZtjIeix/GPKAswIa4yG4fNC7EBtXLGIR9PDzR+UtBviihYUImCs5lxh8FkU
	 31NP0P/69srWpP0vb4rBEXsYlKAuc+UbPsALx2nnQ1I7SRfWLdNMUb2nt9N7qaMp/2
	 2/5Y83idUREJtgyfhk/y7zu+S84eJWWjbVznB+0Pn1S5MWF1KLz4Ew8wSTJ+vok9Fq
	 I0WekZO1Zk3v5z5SCWLtGtsWgWFPv6H2KZ8HKRnd5/pKwulZPfVMYeyj246cV7+BcI
	 mkJGyNkbswrPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: Fix refcount leak on perf_cgroup_ensure_storage
 error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jann Horn" <jannh@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914-perf-cgroup-refleak-v1-1-eac12ba28be6@google.com>
References: <20260914-perf-cgroup-refleak-v1-1-eac12ba28be6@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 10:47:34 +0000
Message-Id: <20260914104734.ADD681F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> If perf_cgroup_ensure_storage() fails, perf_cgroup_connect() has already
> acquired a reference on the cgroup_subsys_state.
> Drop that reference before returning.
>=20
> This probably doesn't matter in practice - it only makes a difference if
> a kmalloc allocation fails, with allocation size depending on the cgroup
> nesting depth.
>=20
> Fixes: c2283c9368d4 ("perf/cgroup: Grow per perf_cpu_context heap storage=
")
> Signed-off-by: Jann Horn <jannh@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-perf-cgrou=
p-refleak-v1-1-eac12ba28be6@google.com?part=3D1

