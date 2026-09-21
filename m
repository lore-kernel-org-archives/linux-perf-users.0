Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15417382F10;
	Mon, 21 Sep 2026 19:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018561; cv=none; b=NoYSz0RBUTg2Pitq1q575a7kV9wZpN3TqI/TNziHG2Hrjshzi5oBiXvrGC4ByNMd3AXTAeXmWy/2YZ1+IWohLS7F7P9TrTagbGOHAHXK9PWE5sDAPh/0exvAaHSXJDC0YOVgWep4IuLPA8JdDybyMG1tZ/T5dzRxZh8ZR6xFMwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018561; c=relaxed/simple;
	bh=VmG7H5H3is/IQokDGjItWcK58IMTy/T4Kns2ZKP27Xk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bqgmbWUqeWc454J6Z9hoFEBQPAGcu0rbMbez/Q4prdQ3ew+bMY0eGKsvFRhS0Uez1PX+ymMKXomMTAfhyzLLQT/bDmai/5edlLkf4MrfohMoI9d53LFHGE7f/h5z/k8FG1w//DY/nLTPMfALFJrqQB39vuvnXBpthynai7A6PSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0PfZ6kr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0PfZ6kr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C151F000FF;
	Mon, 21 Sep 2026 19:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790018560;
	bh=uM9F/TKRyfu5MrU+LQGL8EAYAtmbuUMqPDKdM3g8m9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d0PfZ6krU5skgzNGZqdpQzcftlskJJ/etPaVdrzJ+MCc6I33npRKcmnrFxs0vkY/v
	 WvvpIdMSQhmncjwMMoBF3/V2I920v0oKONNZEWvtNETtmHZFiuobqsM1mCWV026kVH
	 TOG65xHzXCSq7dPm+fZJ9iEGlGAzrpeTZfSHc7pp/bXIFdl82rqAve92qDhPSZ7NEG
	 G/asAgFC5+8mOcpcWOz+yZUdkTwnPRpmEAaaJUMDiuFE7ahLndcgtx/eUvFzt6LtUh
	 qWqk+xo8XR3wHIZGcxhUcSXi0rl0uyKUm8pvupeKbt8wiupZ15Cb3wKkKtjVaAGvEw
	 mIJpSYT4NydYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/10] perf/x86/intel: Ensure guest PEBS path doesn't
 set unwanted PERF_GLOBAL_CTRL bits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260921191418.950933-2-seanjc@google.com>
References: <20260921191418.950933-1-seanjc@google.com>
 <20260921191418.950933-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 19:22:39 +0000
Message-Id: <20260921192239.C1C151F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When reinstating PEBS counters into PERF_GLOBAL_CTRL for a KVM guest, mask
> the value with perf's desired/original PERF_GLOBAL_CTRL value to ensure
> KVM doesn't unintentionally set reserved bits in PERF_GLOBAL_CTRL.  E.g.
> if the guest's PEBS_ENABLE value had bit 63, "Enable Precise Store", set,
> then using the raw guest PEBS value would propagate bit 63 to the guest's
> PERF_GLOBAL_CTRL value (which thankfully would be a failed VM-Entry, not
> a VMX Abort).
>=20
> The only reason this bug isn't reachable is because KVM doesn't support
> "Enable Precise Store" (which is probably a KVM bug?), i.e. bit 63 can't
> be set in kvm_pmu->pebs_enable and thus not in arr[pebs_enable].guest.  In
> other words, this _should_ be a glorified nop in the current code base.
>=20
> Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation fo=
r extended PEBS")
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921191418.9509=
33-1-seanjc@google.com?part=3D1

