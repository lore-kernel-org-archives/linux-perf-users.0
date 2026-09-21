Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D7637F303;
	Mon, 21 Sep 2026 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018429; cv=none; b=YorsZ82L6vUM76CHXAAtiFK+Ay2jmaN86QK4OYpc3lOa3rDwXyLXI8Q4iXC4dp6xAmxcipXhGNJ3egdzLOZa2G/Ml8sK5mTjNqJ9afbYeeoF161/J5X1f1NLIeLeogi3ERiv/ockQnuOOYDkfyqcG9C/KhToDP8aHCEVzFZ9UAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018429; c=relaxed/simple;
	bh=OMgA16csXwjj5+7Rk06iBT2PE9G00GnjDLTXZOAcSBk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dlj8v5wudZhZZ0ogfuHX16jEaKcXiF2Ft09ePYNjy5i6i4ZRizHAAG7JOWHxrbDIZATbEG1zL8WkP80P5JI7+aOjhiUrhyi8owzZO0NoNJCilN94BbN+RQs0BogPZO40I+MoUUtz8ML2yL4kxiT1WgD/JSO4LskBbmHIHsJGRdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYl9gzE6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYl9gzE6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9150F1F00898;
	Mon, 21 Sep 2026 19:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790018427;
	bh=hZliraz7Y6CLwSXG6ciA11BRh6gy7OXL9Hrbd1v1Q3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bYl9gzE6i92XVsTuT1loqA6yFUlxoha4qdsGOS2NUwZCjGLNpVX3eRAilbDQskGst
	 gRK38HOWcEyzjlVLSfReg/taVbj1MRVqi+h0s6j2zHaSky3mQecXRkmUrEHLcdVsWb
	 4qIzrxAuXUmedQR/Ja/WHlz6hr7+UUSItmFp9ecYf3qOjcWdOHV7S4Iv0+S5i/SDYE
	 v0GVSLlaQ0gkubLwd2f4PKxlaUxuVQnAS8ZmEEYjfPhVxEK7UxMY2VT5b9rw8RqMfA
	 894gm3s1tUr5b4I/Z4ljtLZXU6IeA51zTuElkIugmtx2so8IS3sGI/OMjCRZqwmoJb
	 6HxusLJv6gAxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/10] perf/x86/intel: Make @data a mandatory param
 for intel_guest_get_msrs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260921191418.950933-5-seanjc@google.com>
References: <20260921191418.950933-1-seanjc@google.com>
 <20260921191418.950933-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 19:20:27 +0000
Message-Id: <20260921192027.9150F1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Drop "support" for passing a NULL @data/@kvm_pmu param when getting guest
> MSRs.  KVM, the only in-tree user, unconditionally passes a non-NULL
> pointer, and carrying code that suggests @data may be NULL is confusing,
> e.g. incorrectly implies that there are scenarios where KVM doesn't pass
> a PMU context.
>=20
> Fixes: 8183a538cd95 ("KVM: x86/pmu: Add IA32_DS_AREA MSR emulation to sup=
port guest DS")
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Mingwei Zhang <mizhang@google.com>
> Cc: Stephane Eranian <eranian@google.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921191418.9509=
33-1-seanjc@google.com?part=3D4

