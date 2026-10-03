Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB93112F585;
	Sat,  3 Oct 2026 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791014763; cv=none; b=LxQivW+HcdleproKBy+wRMPWf9uXSWujyK0pBk8p0LP4vC1c+jEz47bTvI9vdT5sS+0G2F0/yw3ULvBlhvglO0F2hySmHOmF5tws4lWWPPrDxU7a9f2vhwlIbHvF1oJluxR0sX43FQJtT3lOckLuBxGpYBSaE8cY+fd1BOf1mrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791014763; c=relaxed/simple;
	bh=CEfOzd216IGSOQI1QzkcxIjXvuGTO2W2J5/4YCWUEq0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZX8rcTd84/CKRYj73dhYpMeErQo+CtQXLvME0WXpmiLTvhM63xC8KOah4YPApfE/eiZZb9+h9+Wmz4ROSpyb+AelC0oJcWoVESgsOSonxVOT8qwYRtEDTbDxO8Y/4LzEvRp+t61bqeto0tDp8GKF9yhIR39643i/OiVMzxw70NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYu+EzBX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYu+EzBX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4721E1F0089B;
	Sat,  3 Oct 2026 08:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791014761;
	bh=CEfOzd216IGSOQI1QzkcxIjXvuGTO2W2J5/4YCWUEq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FYu+EzBXIfJjU4R69JKgwSS4lqfir4w783+5oh9aCeSXHDU1NX5BJQsRvbs3uC3fU
	 cZiQeynsKC1HIJMBnk7/zBWopBhFEcNn6cM1mgvbp0ZVAUxPv4l+7htNtqXA9K/CVL
	 ZNJvhYxylWQ5ZPn0GGe5rtBl7IhW/dtbEhpEzdiIZdxAqJUY0EktkHuwyyw4ACGq+H
	 mPwpfanNJGpfbfLM+RDj9535KDBKc52/70Y+C/h9sRF0YbQqp3V1kGc9VQZtkwZykp
	 m/NjhyKmk/JMWYSBueiwnTs5nYjELsuuc6JCn89/9Xd/cgDOTLuMctLF+w7zqXDdta
	 Jg6AZZ71q/SvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 04/11] tracing/wprobe: Add wprobe (watchpoint probe)
 trace event support
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <179101398088.22872.14081308855446744398.stgit@devnote2>
References: <179101393469.22872.5895666191299551553.stgit@devnote2>
 <179101398088.22872.14081308855446744398.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 08:06:00 +0000
Message-Id: <20261003080601.4721E1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add hardware-breakpoint-based dynamic trace event support (wprobe).
> Wprobe creates a dynamic event on data read/write accesses using
> hardware breakpoints and logs the access context and fetchargs.
>=20
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c=
2.1785067572.git.wangjinchao600@gmail.com/
>=20
> Assisted-by: LLM
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179101393469.22872.=
5895666191299551553.stgit@devnote2?part=3D4

