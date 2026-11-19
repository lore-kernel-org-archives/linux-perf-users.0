Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082383;
	b=iS3R/soXdbmt0ZxqlNwPVq7Ws5NwtIivI+9ZUMAWL3dW8n2/VYGeNQI4GVx6YxmPQGnu
	 M/y12EWZZPLRhKA+te1C7rRXs+EK8FM75YeYiqJgMJOzV3m+qqpLpPsHt7d2h8Za0EDLB
	 qRZuItjaLnVtiZJ1u8yvy9A4oMP7OMJ11hCZY5hPQXdYQWPQhHZyAx7sSsZnahgF+CLbZ
	 Nl711zbZGs/+md3+c6xvtvc7Fghq/4bIbCoaCuL8h3tzgSK5hLsrP47+7FAwJgSQoQifu
	 T8Qcx9tPrO/3Xn626xDSKU1p/WKwN0UXmpEdxWQ1kPIb5OxY9zSESs4S2Wv0lV2tsRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082383;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cT2Qv9DPWT5bQZ+xZq3W18Gh4sejSkbZH/xOOuhQ/DE=;
	b=NL8D0B3u3Q/VcTQjtLeEO1O20hiDPl3mbSnLODpDW0vJXZ0F6/n15zi80AZ9EajscRdM
	 A6gpNr1ljKWbrwdkfXCi4ZA3ns7XBa5ybcMia8ZyaL075FMpqpeMIs6ua5jlN5PBt9yuM
	 otthDz+iDX7pOMS82DSDfpCopyW927rpYs1tMLiKzCKSKnNpr7XKrrqoXrsT7jnOwberb
	 btPDazI5IWETDMF9oCz5/7Bw+bPiBi4CFkSDDjhyrC5fzio7EhxBPLsMnSqn+svDCqEYb
	 eiiPREwBTscAwDWUz2k/LFO5YdOFRWhQP4rGi6YitrvurNlGgzzO8HrYTEMQhjvQpaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMEyUeGU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7FB606A325
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMEyUeGU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41181F000CB;
	Thu, 19 Nov 2026 09:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795082383;
	bh=cT2Qv9DPWT5bQZ+xZq3W18Gh4sejSkbZH/xOOuhQ/DE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nMEyUeGU0kwFVSxaWfIwUcpC1HUkZZ9Ng4TuOZKVcBquhmLErBd96bVIaOsenXSYN
	 ZVpX8mNAjSNzGxrlgBoPr17FehUYXmZyMJ+7BsOnryUEbMIlf0qxtceK+t/j4qiIwO
	 BJ9gUItn6ixK/YsOZmgL83IguFaj+frI2pcz4M+c2VWuFey+m9CGj0ckUjVIV+xfWv
	 Ex4sLp39uCizn2cfHsgx1/3dWzEBeg2yz8LC0UJCOwp8TagC8kZb2SKAAQOJ5RHjxv
	 h442HFjLhmd7FXAYnT/FJLg9atNDzvKRSIuwEQcrFG53QXDypqj3PdbEP0pmjYcei8
	 oeJvkGX9zV6uw==
Message-ID: <sashiko-outbox-222893@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] perf/core: Prevent duplicate sigtrap task work
 enqueue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 09:59:42 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The sigtrap handling in __perf_event_overflow() checks
> event->pending_work before calling task_work_add(), but only sets
> pending_work after the task work has been queued.
>=20
> This leaves a window where an NMI can interrupt task_work_add()
> and re-enter __perf_event_overflow() for the same event. Since
> pending_work is still zero, the nested invocation can enqueue
> the same pending_task again.
>=20
> The re-entrant call path looks like this:
>=20
>   __perf_event_overflow()
>     task_work_add()
>       kasan_record_aux_stack()
>         <NMI>
> [ ... ]
> the exclude_kernel warning path to ensure the read is properly
> ordered.
>=20
> Fixes: c5d93d23a260 ("perf: Enqueue SIGTRAP always via task_work.")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795053619.gi=
t.wutengda@huaweicloud.com?part=3D1

