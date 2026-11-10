Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355068;
	b=2r3kFWLun/cFnjwSGuTIKHxMI3kNvU2HL03Gi7uRNMCHjQDxiuRhPR8QvaXHHtsnXurP
	 uEQSdp7+rF/YkRAfU5yVTs1hFpLieLX3J0Fjn4ynJMdfXFHU4V3wavhZIj8tqnINhm6jc
	 EQPIaqJyQ9qlHwk6t/cpWigq4hfbcJhEh8DIOHw2Y1Dbx2oGPxZt9I7vDrdcFXjtKfAtV
	 nMAnWobzqBPxAFHNygApijZBuUrrv/nVUn71enub77Wtw3G0qqDKBhg4IUilom1/M/xQa
	 uY7m87u3gd6ygbuyD1nmEn9CwFgum3ne5ke1xRVv9RulKLa++2frq/qDbf+6UopK2FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355068;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7CuXkXncTxwb4tAUZHU5A30WSbf2rwfQDg+U4AfKtes=;
	b=Ti4Ld3ntZtkTHwrFCjwRM7up30Gxj/pHMmG0cB8yXio3+fZvmnjE1sjkPpkbkOOGzEdN
	 U9g7894UlWVOjFkoedJlDek5H3QqMmjW2p0rNQ/9uHULKVXNvyByw1cdeU2tY2Tr3xXja
	 lGuk6UXsWuqriEkSWYU+s7VM4s6O/fKExbBDj0YPQOz8RKNJcV5w8gDmGPcf6cQbVnG/W
	 yh3Y639Vxj+XFE4JhFRVUupZCjZwahUCP7kg5M7NY52xco30iR0XugyguFihQe7Anw/em
	 79jtcr/MgeYsmwRjA4K/nj4z/5fx4Hb4XDjLH3xZb8tiym0A4sE/A/7tpNPIjcofGoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXo1NsIZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D58606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 23:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXo1NsIZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6E61F0093C;
	Tue, 10 Nov 2026 23:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794355068;
	bh=7CuXkXncTxwb4tAUZHU5A30WSbf2rwfQDg+U4AfKtes=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RXo1NsIZy8yx8No566KMPyTq39+qthJ3lWx1ydhoFjU5Ul6SNoM/LyZXksYFKpNNR
	 /3Mv0ML1/11euHH2srlT4BXmEqbZvqwcScm9fGcSKCPLXeoL3fgibQszyeulyvzMWj
	 ctPaHiLudDsiZKN8mmRf4X5q9YfOhZFDpOlKbjkc/F6hK3dZsvEpnK6TCODJm7vEpy
	 Tjsl8kVgPGRdJpV8G2wcChgT/XlDTgm7Yu+cYhYiH3ClTQhkSBLid73RwIUPt69MKF
	 jUjcNjcxc7dxGrb71JFJp4ihSdZlyj8vP2BSQncER00LrJCAneGR5Z4XuVeElN+zyz
	 v0cWhQl1KLi1g==
Message-ID: <sashiko-outbox-207971@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v8 01/15] ibmveth: Add MQ RX hypercall wrappers
 and call definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mingming Cao" <mmc@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261109235556.60604-2-mmc@linux.ibm.com>
References: <20261109235556.60604-1-mmc@linux.ibm.com>
 <20261109235556.60604-2-mmc@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 23:57:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Single-queue ibmveth only needs h_register_logical_lan() plus legacy
> buffer add/free calls. MQ RX uses per-queue handles, so the driver must
> also be able to register/deregister subordinate queues and post
> buffers against a specific queue handle.
>=20
> Add the PHYP call IDs for:
>=20
>   H_REG_LOGICAL_LAN_QUEUE (0x49C)
>   H_ADD_LOGICAL_LAN_BUFFERS_QUEUE (0x4A0)
>   H_FREE_LOGICAL_LAN_QUEUE (0x4A8)
>=20
> as defined in PAPR 11.20.00. The gaps at 0x498 (reserved) and 0x4A4
> (reserved for H_FREE_LOGICAL_LAN_BUFFER_QUEUE) are intentional; this
> series tears queues down with H_FREE_LOGICAL_LAN_QUEUE and does not add
> the buffer-queue free hcall.
> [ ... ]
> yet. Legacy firmware keeps H_REGISTER_LOGICAL_LAN and the existing
> buffer hcalls. The new wrappers are used only when a later commit sets
> multi_queue from H_ILLAN_ATTRIBUTES.
>=20
> Signed-off-by: Mingming Cao <mmc@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109235556.6060=
4-1-mmc@linux.ibm.com?part=3D1

