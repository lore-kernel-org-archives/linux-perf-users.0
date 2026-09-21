Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03584378839;
	Mon, 21 Sep 2026 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018544; cv=none; b=R7x+HJ/d5XSxK6KL0Hp0UPMUFD+sGxYyAeoc5ZVxUodECMPrKSwFobOC67ij6YE6upV6zjOs6rPhJD0J1ZkIyilrZEPNZkTqadU5LPz0pOf62WT03NSmkjL+ymQtDCQn7Vn7MxAQZICfVxOuZxHt4A0Vo52LskDu1tYMsEeYKRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018544; c=relaxed/simple;
	bh=IP3wMXP3yGyVNq5NV68cimh01PXEWH7eEBUSMPixDL8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N1rY/RAPoIwR1ZLELEqCu7Teu5jXQyvM3C0CDyrlO8OzaKVrpyjEXpFDqa2hTrAgeJ/XXL9YGYqT8yGBiBojJZcclsgQodWWDKb6YXOaAuOIBK9EOJ1E3wv6kbCc5z3r7ru5kmXVFX7MkiFjHXyWYWnPM+rJ4vB/+5jVTBW3UZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjd7y/18; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjd7y/18"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2D71F00898;
	Mon, 21 Sep 2026 19:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790018539;
	bh=Nw2Rj5oIQLP6D9upqMGNSVfB1d1oGnTWo1m13B5Vf+8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gjd7y/18UHldrE3mwM1O4q8HFSGRpCTo6dmSi/Y/qwnxHd8dm1eX5EFX23JHqoF8c
	 GbAQUsbvkeCcBZHGpJU4sZmqeXVCI9/REgTHLqQLsjkXcGNCgPtAtm2DBdpe7FknAw
	 Pc3PAjY7wuezUSCuDrOVTC/Yu4jPy9wyKLnw9hHx5QBmvJjoYnARVD7WDmKhFIuXZc
	 m37QSiF2QaVeULWsXQguyr7pNyL/ZqRs9XA9zW8xuSfpzeCaJUQTEohCv+q7iFBhfI
	 HHuLDV4GhhSam+4iVB52cIA0GKM8Hk9tMkGnziu+EKw/riC4QuwfJS7wMYChOMN1Mh
	 2HFuWxVzn/Z+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/10] KVM: VMX: Drop a redundant pmu->global_ctrl
 check when processing pebs_enable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260921191418.950933-9-seanjc@google.com>
References: <20260921191418.950933-1-seanjc@google.com>
 <20260921191418.950933-9-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 19:22:18 +0000
Message-Id: <20260921192219.0C2D71F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Drop a redundant check that a PMC is globally enabled when looking for
> PEBS counters that are cross-mapped between the guest and the host.  The
> for-loop explicitly iterates over pmu->global_ctrl, and since PEBS requir=
es
> PMU v2+, kvm_pmu_has_perf_global_ctrl() must be true, and thus
> pmc_is_globally_enabled() is simply checking that the bit is set in
> pmu->global_ctrl.
>=20
> No functional change intended.
>=20
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921191418.9509=
33-1-seanjc@google.com?part=3D8

