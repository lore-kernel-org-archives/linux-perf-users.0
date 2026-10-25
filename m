Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792910551;
	b=Fw6fySiMrkJcSgk6XZAjsXeAze1rha1D4bV4Owz709Yz/FWpnwqFJIzQIFfh6hty2jMg
	 qPC8ewieAPGaTaAW/t5Fyz6Id2/LYknET0eXbnTpJujztnZtDYJrgRAyaSS+lMODAPe7X
	 4lPKgs0JvG0yMb/6UsQVcIwed0/M1pW1vzAZasavXJxbfTLhP1560suH0lWxtpOw5p3Lw
	 gCmZ6PqQzKT/CkzzcVLNIMS/uuZr/hWVAggo0UMHH8A6JfrxOsmwcEDUxj+QSFzzxf26z
	 +NoDYg03mJCrAuXC1TEaVvpLKqheIRVFPqam426V9oeHwiI++Lq7CazlDlsYeu5chaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792910551;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D4WnJGciSmERh2Egg07h5LzSgZfrwIHb+kBO70nvb3M=;
	b=JqVGrzxUbEagt1aZPE1Td7CTTz2FST9YSyz5dXczzuy5kKO4PDeGmWeORd82AMcopW49
	 obuf195Iy8GbB1wr/hL4yllcqcLDg5Uy/S8lGT/wMhKp03Zp6Awfs3keHDqICZHFmKWGa
	 ai/YOv8MTTj+1cpJBZpneTgXyEfhoXhIOnd4t9V+3wRntLBCt0q91+mVqp+oG3WRIuDeV
	 2mrv/xnstjV1IKaDEZa5byJHyL9jYVvN/wQ2nm/mpF2EPOrAiDBpwaKTOY9ahHbjGp8vn
	 7YQjne91/q8KrNvPpDi2tfhffnuahX73motJ6OTOyVyRlL88kav4YtIRhmWKbDujjZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4Y0fgzT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2765606A31A
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 06:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N4Y0fgzT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256801F01825;
	Sun, 25 Oct 2026 06:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792910550;
	bh=D4WnJGciSmERh2Egg07h5LzSgZfrwIHb+kBO70nvb3M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N4Y0fgzT++XaHIhNlMfgyGrkzq7YzVc7xInppRDVJXHkQuOzwlbsnC7b8AUUFlwk6
	 UgOj0s5UT3iyQNQ9fWDsG1wr7ABjss6zNcLozfOtX6EcQOSvauLYZI6PwZZwyBK55C
	 8D0ni14ELWTAkBESaDstpG/yZu/jVOjPx/2psJg/nCpObMQJipCjU5rzhvM5m8mGgM
	 LBPGMSPR/kn3rjEwo+sQw+A1HMxL7BU9mPHXb54ql+/fT1SZL7MxaTkNKe4+ySHHW9
	 XRdj+KX6c2uoEjb3HK9ZLQec+6VYhTzZevfzyR1zCF3qMJ/EgZiUizESp0QTbdwLT0
	 YLW9DCaLJEiXQ==
Message-ID: <sashiko-outbox-184096@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/7] coresight: syscfg: Remove unused
 CS_CFG_MATCH_INST_ANY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amir Ayupov" <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <52b3c337cbf4a8460e399b084c6f854eb3beee89.1792907333.git.aaupov@fb.com>
References: <20261012230527.750567-1-aaupov@fb.com>
 <cover.1792907332.git.aaupov@fb.com>
 <52b3c337cbf4a8460e399b084c6f854eb3beee89.1792907333.git.aaupov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 06:42:29 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792907332.gi=
t.aaupov@fb.com?part=3D4

