Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB11C511E6E;
	Fri, 18 Sep 2026 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789747921; cv=none; b=CJgG3mxhfGL98oH/oPqc4ogG6J1asdBgQvgA2dQGEJS8Z9Yi9ccNg1Tx5mhzSftZlbtjG8SMRRsd6rhb0GCEem1A/vq2GtIvW07XvBqI3ajd6eBCxhTEf3JmObiaRG9LP24RTs1gPXOisue+CSddHYA2787NLtd2nqtjUZK7wcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789747921; c=relaxed/simple;
	bh=gzmtYWgWadIDC31W2ejDQZ7S46kME5Pt9JmeIsg+sxQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k04brOlYJIJ+3EgYl5m0NsUQQ4WsOZPDV1gtNgwE/9kd9zZBr7+Exg225PiTNArn2sLTAt0a993AhZVDADWlLvHhMeT6wMiePfyRDDxRbGHFPuDoPa71vk9Fj+iCFgQm8iXRy5msBWiDqW9PB4r13izZ9U5mcZned2fE1PduFnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrlMAfeh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrlMAfeh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BE21F000FF;
	Fri, 18 Sep 2026 16:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789747917;
	bh=1S4LOWej9Oxv4Crxz3SMYa4g87mQImBv0lXDJriHrJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mrlMAfeh+Ez7lU9qezHRZdE40n8LmkVdTkJyt70LYGMFjTMByYSXd/2SyQV1tBA85
	 o+3K9PVaLnPxV0JFzvJPw75qGJLcl+HytPz0X9Bq0tCtY5avFvKH2U81hizqBXTazZ
	 knZjrX4a1oR9DsAiOdmEEIDuTz3o24xlMYlsF8xqgtsh8J/M89d2pBUdFpVvvnck6a
	 nAk+sKbxp6fa1txG1Vhfhl4bUb3osU2VFsR/Jo4LfiorZA+VrwqgsKs3JewOdtncxY
	 p1nOGcHUajk5MhnFBQA49PvsADK1SG0HJzrCGKDSJrh5fElowzd1d3aiap0mbCw7dQ
	 2riyMyOW6SYJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: x86/pmu: Don't retry a counter whose config was
 rejected
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luka Absandze" <absandze@amazon.de>
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260918160006.61816-1-absandze@amazon.de>
References: <20260918160006.61816-1-absandze@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 16:11:56 +0000
Message-Id: <20260918161156.D9BE21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: pmu: incomplete error check leaves retry loop for non-EINVAL =
errors
--

commit c902c2e2a69841996cdfa4c9e356844d36d6b770
Author: Luka Absandze <absandze@amazon.de>

KVM: x86/pmu: Don't retry a counter whose config was rejected

This commit prevents KVM from infinitely retrying PMU reprogramming when the
host PMU driver rejects a configuration outright by skipping the re-arm for
-EINVAL.

Link: https://lore.kernel.org/all/20260916123315.89042-1-absandze@amazon.de/

> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index d2fd47ee5ec80..ef229faafd1e1 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -680,8 +680,14 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
>  		 * reprogram bit, i.e. opportunistically try again on the next
>  		 * PMU refresh.  Don't make a new request as doing so can stall
>  		 * the guest if reprogramming repeatedly fails.
> +		 *
> +		 * -EINVAL means the event's config was rejected outright and
> +		 * can never succeed on retry, so don't re-arm; the guest can
> +		 * still do so itself by rewriting the event selector.
>  		 */
> -		if (reprogram_counter(pmc))
> +		int r =3D reprogram_counter(pmc);
> +
> +		if (r && r !=3D -EINVAL)
>  			set_bit(pmc->idx, pmu->reprogram_pmi);

[Severity: High]
Does this condition fail to exclude other permanent error codes like
-EOPNOTSUPP or -ENOENT?

If a guest programs an invalid configuration (such as a PEBS precise_ip lev=
el
that the host hardware does not support), x86_pmu_hw_config() can return
-EOPNOTSUPP.=20

In that scenario, reprogram_counter() will propagate this error, the condit=
ion
here evaluates to true, and KVM will incorrectly re-arm the reprogram_pmi b=
it.
On subsequent PMU refreshes, KVM will repeatedly retry the heavy
perf_event_create_kernel_counter() path.

Could this leave the retry loop open for other error codes, allowing an
unprivileged guest to cause high CPU overhead on the host?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918160006.6181=
6-1-absandze@amazon.de?part=3D1
