Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619904;
	b=V9ixkaSbSrByArEw8fu38oOiyDU6xrEzaKbbt0c4WrseY3XK8d8QYA8Nx3YeMUG2MMJb
	 loVxpHnweVROQ82+iLw92TAfAxBuo0WrqD00idb2hP+M562KOEiTOQg3nS4c8Zd5pKElF
	 jlVRzcokvvzD5FThNt7ZBwE+y2bs9yrMrYLqu3GW0GBqAy6X8wwELjSVtPY+KH3K1tIsi
	 00U8b6DuDVCrWSHo6ZNFTF73O9ligtfhLTaZ2hpXiewrzAM3xA2AEu4Xnv/BnZgQp+HSW
	 6jadkfh6zPjJGvJANXKSPLQIMjm+zvfvTX+f2wleg+CA4h0bgJZLTm9IahzDeWhA8oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619904;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Mf4BboH5Fq9PduJnfuC6vwD8JLkvA6WY6G8cuK/iKps=;
	b=i0+nwxVL05BBkJCIxUEQot3JrtImvvA0WU0v1h3tyntUCmbthBKhgBJbxd7Dtd6mlrKm
	 nhf3R0tTiyhYKKzDrSXxGO7/kOaJXF38Grw/0ck2mHRdEAbRfVG//X/bhjoeaWqCuvNkw
	 BTQIPrf5qY3qGlKiXwbYWxxtYOZXWLYaDgrv/Tj/IzEgvprqFQFIinjUIBPGzF+/vug1Z
	 6nIzibEorG/RHX2gwSaC30g/eLcEFb6lWvsEQXIGARcdrb5bQ9ZmYJH508PJuRZOaHlbx
	 bWLGdUfmZVU0eAd+AJMS9n/gdKNPHrxdM+U5By3G9zSHFkgBv4vhO4fqbB42AFlK/Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WsOXt2ST;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D17C606A31E
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WsOXt2ST
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABD31F000D4;
	Wed, 25 Nov 2026 15:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795619904;
	bh=Mf4BboH5Fq9PduJnfuC6vwD8JLkvA6WY6G8cuK/iKps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WsOXt2STuUX9XwJZuC3APs2OO5ElqRToA2cWnzLUvbyEWnKDyAIXUSsutx/ZCqWeD
	 AfbwyexbbLAPyfGuoT3dvSmZL9C3nXh1RzBFy6nIJSFy6mbhpG5+SfpGApwAGiHp0O
	 yt3dVw34sVHoyG8+pPSD7L57qU3tfzJ62xbxL5ifSO+o0P9DW36bAl9R0QUiTnnY/D
	 LoCYB14wsO85L5V+3dkTfC69MoskdRBJTsKTGDnGbw5AVmkNIBxqXh1I0QGsGkX9lM
	 nDst0RiwKDcJGdoFPMGeFWqlfaPxftSCaq5iqw7yPrQfurxf0b1yB5xiI6PUeepYxj
	 x2YqRTE1mefQw==
Message-ID: <sashiko-outbox-233643@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 0/2] perf kvm: Don't create an empty perf.data in live
 mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261125-james-perf-kvm-live-file-v1-0-946f478ce2a1@linaro.org>
References: <20261125-james-perf-kvm-live-file-v1-0-946f478ce2a1@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 15:18:23 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 2-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-james-perf=
-kvm-live-file-v1-0-946f478ce2a1@linaro.org
