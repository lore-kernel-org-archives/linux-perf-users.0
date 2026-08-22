Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91D536D9E9
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Aug 2026 21:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787435108; cv=none; b=E4Ill98R9fS+AuhL8GVF/D90tz6fMQtCAzIyEYrwL+mgNisPYPpmUCDjtCzPm/Lw+aRKjiD/1YRxdACoK7YvIA+jzwvu0O5aBeJTOP4HXBvTcMBPfzfQHImLxGkkaDNDq8WcQgpNgNv0k8w5RTGueG3b11jhbFMWw6DfupI++a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787435108; c=relaxed/simple;
	bh=/M91FiZc42tNZLeoK3LPkJydm9UjBJuCCOAbK6Pwt1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oFhth+kx0Vq8zSxspDRdOV601D12agdpJrXOx9b2/rL6ps3R0KvMqHtwIHOjLX1uQNIkN04kDiX1tL+hKZrYKwxczr8c3IDr3rhSSc0zjZRRukvo7iOaDJ28/0BbLqY4wRzeEhrnmQCc010Md5madLa2b9uqyf4Mz9FC9VFblEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUDR8mEC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUDR8mEC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5054D1F000E9;
	Sat, 22 Aug 2026 21:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787435106;
	bh=/M91FiZc42tNZLeoK3LPkJydm9UjBJuCCOAbK6Pwt1o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YUDR8mECiHiYSibAr574L0G1GH232//nxXBNnXSu2ACDnenlQ4cJXsL1q6SkbXsti
	 TuIuFld7QJ+zC3axJmQiyDu407fOF1f9J9R/hw+dExyWMUWZMMslXrIXJRmKwSWnrS
	 cEy0DANI9mQxkmIr5zX80i8I1xByNCkQBf54x0H6FQbxnCXiL7j1UfWRjWk61PtL0a
	 mnytQlcG7RkDyzhWF7NHzLAxuS07om7wRvzneBwaE/iJI8AucFdt4SDXA3KRBo7VKO
	 GtPTzIg0Snzg1f7tZh6+tOmer69rAYqIPW0I5nDpReNMune7eAKy0UWMxaRngsDyYh
	 n+Uk8Gf+ODXgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v5 1/4] perf trace: Introduce kernel
 symbol beautifier for virtual addresses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260822213558.704018-2-atomlin@atomlin.com>
References: <20260822213558.704018-1-atomlin@atomlin.com>
 <20260822213558.704018-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 21:45:05 +0000
Message-Id: <20260822214506.5054D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Currently, when 'perf trace' formats tracepoint payloads or system call
> arguments containing raw kernel virtual addresses (e.g., a work item
> function pointer work_func_t in workqueue:workqueue_execute_start),
> it prints them as raw hexadecimal values (e.g., 0xffffffff81234567).
> This impairs readability when tracing kernel execution flows.
>=20
> Introduce a dedicated kernel symbol beautifier,
> syscall_arg__scnprintf_ksym (i.e., SCA_KSYM), to resolve kernel
> virtual addresses to human-readable symbol names and offsets
> (e.g., "flush_to_ldisc").
>=20
> The beautifier looks up the virtual address in the machine kernel maps via
> machine__find_kernel_symbol(). If a valid kernel symbol is found, the
> symbol name and offset are printed without requiring --libtraceevent; if
> the address is zero, "NULL" is rendered; otherwise, it gracefully falls
> back to hexadecimal formatting.
>=20
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822213558.7040=
18-1-atomlin@atomlin.com?part=3D1

