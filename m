Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEB43955E7;
	Mon, 21 Sep 2026 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018913; cv=none; b=RoqDsc+ZHCe59qTTtHY55VOwD6TRILNz3nmSVm2z/SVU0thiasDPiOcf7OXaRttAUiG51fGA+f6rCkJ2+QAJGfSicZAf+5gNvfNRxGSIDZOPrBKizMG+jFBkJ7oFOFkfSUFXXyD1Ma0RCtoQn+syWLMEh1ACZgcdUVnWaHY9rzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018913; c=relaxed/simple;
	bh=kMuWJ5u+mNaW1bE6Khu6lE+LKY66QgacnwOHpuAUMcU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZCkHPykaDG6H3UKSpQtyI+5Nkg5FH4V0EFnbN8N+8FTRM9abgD7wS7NlnoZsbYz+pE7lysctgh+n7VPTWn0A3FcL70zlJ89F7JUsUuHGPY4qoXU2bnH1E6OtatRM+1fFEW5KbPdP7BzaA3cW0QhSudO5dHJw2UMztGFANpqJNhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eR80ux9a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eR80ux9a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE601F00893;
	Mon, 21 Sep 2026 19:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790018911;
	bh=kMuWJ5u+mNaW1bE6Khu6lE+LKY66QgacnwOHpuAUMcU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eR80ux9ahPCzGABOyrTtkndzP1z/YwdmcsbCb9GIPPehkI151ZAHDLQRIpTxGuIi2
	 qH9nT+Ean6rTxVQLlS02MXsqf8KpF8bdslJrEzYxyXme5+rp1o+SXWhYOnYn0W6hxD
	 srWLga1bKm2ZeuaDzTm0glzYjkhDvtSvJHFfZ2sYhQNhGT2bTMlZg8jgLIxtzc658e
	 7NlG01YpFdkAC+S6LAX3cSkbRAo1YlLiTNnV+ogpveC3gaF/OtMsPJSCC6glbf3Qaj
	 oMy+m9HHNMpyKqK62dgS8PY1U9epQ6rZlnrFBhduro8yIbN4c6duzO5MUwEgIxjzqR
	 HFqmKq25+Wc+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/10] perf/x86/intel: KVM: Handle cross-mapped PEBS
 PMCs entirely within KVM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260921191418.950933-8-seanjc@google.com>
References: <20260921191418.950933-1-seanjc@google.com>
 <20260921191418.950933-8-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 19:28:30 +0000
Message-Id: <20260921192831.4CE601F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Now that perf operates on a KVM-provided snapshot of PMU state, handled
> cross-mapped PEBS counters entirely in KVM by clearing unusable counters
> from the to-be-enabled mask instead of foisting the work on perf.
>=20
> No functional change intended.
>=20
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921191418.9509=
33-1-seanjc@google.com?part=3D7

