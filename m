Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114689;
	b=2XLQ6oF40q/+vUv+Zol7is/DrP3kriTydN6GtE5GCdUVq8pnYmHdBQBtnniEqI7rebbQ
	 OcC4HIqWKX9HZzpFqs+qaczyWG2k8V7iyE7j2h5NVh/XmZauuDvrRoDzwUHPCFx6qthr1
	 Lfm363mt4SrJZP6PmtimSFb6Bwuf44BFp+425o7+TowiJritic2vpLSRoqZ9YnHJtJC7p
	 rrj3ZzzV6RZGNQA+PIbZ3Pe3Uxizofk1Kssq9vcecFNmrb+g4akKZ0dfjRxOo910PE23v
	 T7EiQeoMSsrxLjULcl0yo1nbRwyNi7KEiktY5vWapogPpBnuOZn9XIsgoHsYgzfqFTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114689;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GCkIvv7ojtCAA4hUMQJ9CV1RaeQCiQhjLCycGzn1oSg=;
	b=XDWAX3DNJ9vmkhV/6MM9A2iSdPbu5kPjyQA8I5mfYowSq+Ok6yLqAAgNL46/44IQHrg+
	 PYBLVap/iaEy0K6LVmxaF3ImaRnu8Mjp/wamrWP4/2VDQYLkn8jENGVO7YXEGv0R/feaX
	 eMGFkPd8YK80q0xx93nDNB5LDFhNVNtw5698dPuTNE/kFz5SKt5KIS/cJ1Mc2Qjbs8Hsr
	 NiI4Vo3WTnYYrshjTiQGrMgy8leZn0GotSwG1F2Eq10esvCZhHfteuDIVDTkZzxIbYKoM
	 lqSsolsfcfUBx0SFWj+WYgoz4TXh9LekulHnbxL2/8MkQOlkEbCbcorEyu/ET6uLqmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nCkQC0gI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FE3606A320
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nCkQC0gI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B957B1F000C5;
	Thu, 19 Nov 2026 18:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795114688;
	bh=GCkIvv7ojtCAA4hUMQJ9CV1RaeQCiQhjLCycGzn1oSg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nCkQC0gI7mt7lqjbI8b+e88CKogyxuMRrYf1U3ocDkmZMOVQTC1VRteU5TDS6WvHz
	 AiYzZIuN+gBWkIWqHA7DijcEGlpKRn3njeWLAWYCSp7fPYFJsCrAb5uP1x8AZA0OZp
	 iqQu1skGYhgA3PnnijCgKWHdZFQZs4hQESk/zmq5JDP/G7NBOwRta8V3Cij3FyrjsX
	 3TqAiY7o5iV0tSF3rRknWaebUoUmjHyWG9GXDf56k+yz6oqYRiHkj1XbxfJLlTAm9q
	 Ftk1POkWar/1IcrJ3TYB9f/uZ+KAErZzcqvf6LzSqOw8FaQob6pE9w6ILu0nDot55J
	 jlR7GjuUSN9wA==
Message-ID: <sashiko-outbox-223816@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 13/33] KVM: arm64: Make __vcpu_rmw_sys_reg() atomic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261119185215.632334-14-coltonlewis@google.com>
References: <20261119185215.632334-1-coltonlewis@google.com>
 <20261119185215.632334-14-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 18:58:08 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Use try_cmpxchg_local() in __vcpu_rmw_sys_reg() so read-modify-write
> updates to vCPU system registers are atomic with respect to local
> interrupts and GICv3 pseudo-NMIs. This prevents lost updates when a PMU
> overflow handler (which may run as a pseudo-NMI that is not masked by
> local_irq_save()) updates PMOVSSET_EL0 concurrently with vCPU register
> accesses.
>=20
> Signed-off-by: Colton Lewis <coltonlewis@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185215.6323=
34-1-coltonlewis@google.com?part=3D13

