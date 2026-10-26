Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793004101;
	b=S3uznsZExo7X8Ls5xZo8WcUr54EZCIz2buKqmi6D9CyQBbueDXiqLutR72r9SvpWb5RK
	 3+O1qPwhABJnFbsDM4lZSK4cs1iVOIlqyiu8TfFYo1mq4dU8Xz2EGKaxdRZYSvORSGFmk
	 Jnf8boUloyYdfJ0/wnL99/0weOPF+KRIt+HrBUPscnuj72A43bXy56xw8FZaqfbzCqVIA
	 27J+2S2xERT4/3vRnzjvOz3yXOSwxzdIr4L4B1GWhnLP2u6YpUhw6fP2o2IqZRN6bOnpw
	 rNnFj1zr04qcBLAjuB/vGZIHSRXCCkD+6oZYZFBrdY+rM8gB8Bnkz6Mq+Lkpex5jv1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004101;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3rqQTuftO+hOnVMeyhV8E4CSIekHeTdwByXyO6oJnVg=;
	b=WlOnGSwTm5j3Y4rkB1KhEad02pgpWe37udlJg6GU9R01wIXs7Erc/BZWSCxNKcVWLEYc
	 jTqS+ccl5pt0ShdE5FiUMIwIYStYFTFlwNCyGs/BWM8/eG1Q1kQwoCJbIB93p+CJiedq/
	 VlG70yg5wTPLJIHCsXwZNMaXKh5uTD9KStUIRfOe998G7lpQ33tK/LHYmfY78IpUI/9bh
	 iqJz3G/JHsK2QwLi9FuaR5YR1G2+Lt6NjqKidT/nuHY0/wZ47eKULnv3uRZhPnsHrLAxO
	 rJzpMJvq2sYgH0bqqvxEnlgP3noJATZwCX1FuS1LQ3PPledLZm940IiR3muNR9vtQaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OfRRqP6F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D607606A31B
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OfRRqP6F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E4D1F01825;
	Mon, 26 Oct 2026 08:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793004101;
	bh=3rqQTuftO+hOnVMeyhV8E4CSIekHeTdwByXyO6oJnVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OfRRqP6F+gtUlH07vnPzvRnpvnaCE0EF7b/ajCeEnXzDnjbrT/nlF0qzSTlkygiYn
	 atQaZBKQ1ywLUgsmBsshLOjIl0LqhaQ97HOiWaDK1XEH73SdstLs8X5JbVif3tTguf
	 7q9eSmlKkfsuaxL+SELojzFntONZF/byqmKyiV1aXsbh83+k3ug8j32XcS1HyiXV4a
	 w3e8nJG9lAsgjGZi4ltOtXWPVWX47SdFVKGPr1nuVeHTk41dtq/eu+ad79n9Za1YLr
	 5FmlhMMuxuROhysgvQf1fJyiNmQN8opYHez1c+0Dv1QHyV+H5GGm8gcMODfBXfstYI
	 NyOsUKqm2ZCkw==
Message-ID: <sashiko-outbox-184682@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/7] coresight: syscfg: Remove unused
 CS_CFG_MATCH_INST_ANY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <52b3c337cbf4a8460e399b084c6f854eb3beee89.1792989860.git.aaupov@fb.com>
References: <cover.1792907332.git.aaupov@fb.com>
 <cover.1792989860.git.aaupov@fb.com>
 <52b3c337cbf4a8460e399b084c6f854eb3beee89.1792989860.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 08:41:40 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> CS_CFG_MATCH_INST_ANY has been defined since the system configuration was
> introduced but is not used by any configuration, feature or device.
> Remove it.
>=20
> Suggested-by: Leo Yan <leo.yan@arm.com>
> Assisted-by: Devmate:Opus-5.5
> Signed-off-by: Amir Ayupov <aaupov@fb.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792989860.gi=
t.aaupov@fb.com?part=3D4

