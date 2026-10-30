Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373429;
	b=4Bty8oMDFKkfdC5GoA21QHVja+WSjZUnoUVHPxutWo+MoR+k/NrEgR2yF+rkS9nFPqhJ
	 ujqgAO+4BnV7lYa33xJTHUUQOKXDkSkT4SrZNhNId9ua8hvYJucN/9K92uaKyENmURN/U
	 j2ukg6LeucfQMHx1RSV3y2CZNB90yV/JcnJwCbqmR6PBoQW8FBJhzDfD1aDgGoSeaK2p8
	 vUB/P6rZSdcVaexDsjdpvxyg/CmSaMe+ISfI7g1WsQuirmSDy13V0PkRn94l9f1f51Dk4
	 Oc6yLthUle+MjzuZEoW9Ns78cCoe59enyjQdGv+g+bSviplUPHGxskj5FJvY1DMwZGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373429;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2Y91tSxrY0GmFpIaigdYThXteRZgmSnbPsihE/5Q9vc=;
	b=SbMc0yy6DqL4jsfSR/bH58Ay0dcKXyohj0Nocg/0FuNY7p0yWFPUb9MGlKZjLBgFlA4E
	 eVKIyJmB1eAfA47nOj7iNDXf09M5Hgxzo9JAYEuyr2ieqlTm2waWOKnzKXF08LrAB+Q4N
	 jTcAxQPHu6lPgPOTM3iM0lWeC7OGcYDJKVlq92C8uOFWqs3D13MY/lxJspGmwDJL6ZE6j
	 nMhtrT3KTr1vadzqs0QyHwIiq2XMj7oVDZN5hvrVq2Hhu74JeGBI8jmidcQpunI81EjXl
	 B2/wxePnZwk5SL5Op11fIL0Kc2eqLbDAiEBsIbgTs/Svn51K5ESeMZPZ7qJrR7e1x/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDPEwhTp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08464606A322
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDPEwhTp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2491F0093A;
	Fri, 30 Oct 2026 15:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793373428;
	bh=2Y91tSxrY0GmFpIaigdYThXteRZgmSnbPsihE/5Q9vc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kDPEwhTpZpT3JTar+wsUkdzDAIAjHMV4a9MPB4TEzQ2AEQLV7gQvFtZAN7zc3WAzg
	 L36uCTnUHQqXYxzy9/ch7gxgxKi+UkxCkHokn0O8NQq9rwzRkDp/8iZodn3VTuIijO
	 oMCt28/EgbMccONyXnXKFQN+AC4IAiJGown9lM3Md4G4UjDjccRr+A1x+ZYRqY+f9g
	 bJgOzZcVdnYzig16RX/RQPTcye2GkHJWskU4jy6CiOtAhFSlFMSMf8ruCnG828jS6P
	 /qqdJi+AeHZEELJlohiDWaQbnA4/0rOpoxAtbNfamiBaImH1tfcsWb0bmdbOaRHb8p
	 9Vvm4H+wq6iLQ==
Message-ID: <sashiko-outbox-191147@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/14] perf cs-etm: Factor out final instruction
 sample synthesis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-7-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
 <20261030-perf_cs_etm_fix_non_taken-v3-7-7629b52ab047@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 15:17:08 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> cs_etm__flush() and cs_etm__end_block() duplicate the instruction sample
> used to report the remaining branch history at the end of a trace.
>=20
> Move this code into cs_etm__synth_last_instruction_sample(), preserving
> the sample generation and instruction period reset.
>=20
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-perf_cs_et=
m_fix_non_taken-v3-0-7629b52ab047@arm.com?part=3D7

