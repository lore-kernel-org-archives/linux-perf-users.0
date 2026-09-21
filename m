Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389AB38330B;
	Mon, 21 Sep 2026 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018582; cv=none; b=HfA3DiT9tkHI0cuWndEd+0gPl9vj91rF8b9iUodG3FUBhqMNgMpnhM+3zumKr0kbFVT4gkUkTEq1gQNx+V+2a+EzaUigqHtNPESfmxzNqX5zvBJC3xSfM5gZvI+jM3I6V8W4mP/PHt5lmz26S8tcrDxyYNnSlqPutFRsO9w3hWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018582; c=relaxed/simple;
	bh=EE2viBmbmAnNIHPOaL2wlhA92EQWxSTWM3MonEsPwt8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oX1Js7xhJzHx96rXh2m0z9zgsdinnVwX+ovlM0sMDDIqSQ1oqyWbB4qeE8U06nP41mRRKZuogit6Z5S//IlekXog9hzF5sJmChMk6GUtixMBE4vO+1MKwNSIwlafSAqsj6aNi4eMzwCJR2VlCi2ScHX/Lsf2mQz2t2ZpZ9yDN1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GihfZxQs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GihfZxQs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9652D1F00898;
	Mon, 21 Sep 2026 19:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790018580;
	bh=nd/1agHfPQNYUZorbwm+xwbB4Jxbre/JLVLJg/YlrOw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GihfZxQsWtLLHiscEymaZFkscgRDHT5sQgeVQ9xFytb2nCHBTuVFDFRXqmSZ+Xlws
	 g0XjRgeqWMlbiST5J8MzyKlXMUs+RDVh/32tuhz2pjELNpCGI87GXDr6jhDi4qSX2X
	 PrVMDs0WhL9aJOHRmT+m0O3SAVlxYBkEKBwvIdIEc1HqWI1TtEUZmhRCs6GDclizc8
	 xWrli7OOG8jFoSzLSLx25nLTAdBsMOTiyJi/6j2knzqtBpweupi1O77iSGY7SM48lD
	 pvYZ6cvVbUlH/u8LY2wkYVdbM62QVdU7hu5VxZH9QF0VAo6z4Ah6Ig4pqILhP19DA2
	 zPWOO51glinbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/10] perf/x86: KVM: Have perf define a dedicated
 struct for getting guest PEBS data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260921191418.950933-7-seanjc@google.com>
References: <20260921191418.950933-1-seanjc@google.com>
 <20260921191418.950933-7-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 19:23:00 +0000
Message-Id: <20260921192300.9652D1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Have perf define a struct for getting guest PEBS data from KVM instead of
> poking into the kvm_pmu structure.  Passing in an entire "struct kvm_pmu"
> _as an opaque pointer_ to get at four fields is silly, especially since
> one of the fields exists purely to convey information to perf, i.e. isn't
> used by KVM.
>=20
> Perf should also own its APIs, i.e. define what fields/data it needs, not
> rely on KVM to throw fields into data structures that effectively hold
> KVM-internal state.
>=20
> Opportunistically rephrase the comment about cross-mapped counters to
> explain *why* PEBS needs to be disabled.
>=20
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921191418.9509=
33-1-seanjc@google.com?part=3D6

