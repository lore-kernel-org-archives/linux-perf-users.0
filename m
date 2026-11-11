Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384190;
	b=dgvBRJrBuQ+wiivXWNjjACy+oDUp587j5WAoLJmn2PArdNvu6L08WJDWVwFWDRGrGC7K
	 Nf94EdiAIU7sFNfhybi8EK8n2mq+8sWvKDUN0fHJIsDz6rjPGSxzXEe5PRQX0mFmtTIxi
	 tvnKswCvUK4zke5cwDYPJQ6PnEWAvCuuKOgHgQgu5qSGe4/53WdC56Cm9ZuxYe0l7cwEO
	 zb2uO6c6CXpD8AAZKyjHZ74ISZS9VaAXQF8vP4aKEdK59J9mGr89f3bwNFEJUct4DwLKH
	 fz0NJroYFBTsAotUoaLt/deOyGfHYm5t81uuP7VkSpeMAdg1hNw66TT5Ybus8R7e8oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384190;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K4p4oa8MyxoOGqCmfrdsMIaq83CL/GRaLpVlfFbp3BI=;
	b=gpYZiRpf+ZyrOnMTrJLBasQBEOHn/vz55xiTTk378Txz+3w2ow8WTeJJ6o4XTDZivZMT
	 L60JDQIJvPqct6sHu6cdkCwqO2ioeIkziWQUhCpw6zswuHtmE1gp8DPZ0CYBdFg796z1s
	 EPsnTcb+YK87ZfZR6SNXPSqUVHHpo8LTMJ9g6bVAmz76KYIA6jfHrNAWGgL5ZM0MFUbpI
	 tsCLYr4dR/Lu1xWMsu52s7SLrxIPjWnnhv2cYaLL3C/fJYg+gvmpr4fB6SiGunYTcsyMc
	 g+ZWeWDYSCkVi5wx9Uwg7J7YBBSDQVhRer9IH+EmsrhpBl5xDPFvi2uGfMBBeY31P9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezxRBmyT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A342D606A321
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ezxRBmyT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1611B1F00A05;
	Wed, 11 Nov 2026 08:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794384190;
	bh=K4p4oa8MyxoOGqCmfrdsMIaq83CL/GRaLpVlfFbp3BI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ezxRBmyTansAOYAyDAMcWrd0faxRE4gqbeZTX/vFAifi/J4GWU1I/M4Bj8WHXAGV7
	 bjr+RAsHuU3Kwjd7UuusVHqrfRwkKvd6CbqbRB6euJvrkjH1xqJfsVnlTHB8a3DYx+
	 2WHITaTJLqvk68dnHCTqIWOlmYnJQCrRns0S+7CS7kQqoND/0Cvc8ePsT33v6bn25e
	 w4N44mwp1ltzoKZgoHipaUKvWmcUsJzobWbcXwInaeDlDrQUmb3dAChNP4ACxVWdr0
	 QQnT9UEs/R/deeImPUpqmHmi2M7aqH0Uy0wWci1ribuGlkjMG/HlBvfTCsFBdExoOw
	 yNMfryM1klxdQ==
Message-ID: <sashiko-outbox-208560@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] cpuidle: Use cpumask_intersects_and where
 applicable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shrikanth Hegde" <sshegde@linux.ibm.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261111075945.3930230-5-sshegde@linux.ibm.com>
References: <20261111075945.3930230-1-sshegde@linux.ibm.com>
 <20261111075945.3930230-5-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 08:03:09 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> cpumask_first_and_and returns, usually the first CPU in the intersection
> of the three cpumasks. However, if the returned CPU is not used or
> only to check it against nr_cpu_ids, that implies to check whether the
> three cpumasks have a bit in common. I.e use cpumask_intersects_and.
>=20
> cpumask_first_and_and uses ffs on (addr1[idx] & addr2[idx] & addr3[idx])
> whereas cpumask_intersects_and checks only
> (addr1[idx] & addr2[idx] & addr3[idx]).
>=20
> So replace such an occurrence.
>=20
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111075945.3930=
230-1-sshegde@linux.ibm.com?part=3D4

