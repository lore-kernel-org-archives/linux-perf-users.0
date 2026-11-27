Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795744398;
	b=qxcUIKuGOBz2mpn2jcDc9avKQW+KNMgwSuPjHAKa4nKTgBjI/7IfvLwTmpYZiSZc/mhk
	 agkP6ueMoqYCZOE4mSZ+WIrWalujnlAqrXe0Uea4fW92f5VdPMrkXQhe4HujHLo1DpXwy
	 81GBKT31xhEWFNkEs5lLaK3t3kqRgu5H5HpWQEtzJPux/BZdYejCwVO8XI3PCZCI0RShY
	 iMjq9WIITruv1c0gL4sGfg+1ze1UNAfxJ2fpTENXJaFVpe0pCP/g69oGidR4RyO+JCrI3
	 VsLUXZtgm40Y1ZviBwcBaysKT9BbT7w3EqVo1v42fQXRt1XZahRRcD1ctX4q49thAMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795744398;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4zzkWeT8tn6eWMjbMZMzIR50TlMRa2DY9XUuB2IlMQk=;
	b=zZSwZs5lAAWzFF7YOvJFKFbaUADO0ulOz6isMIEvJvalfvASLSieP8KkYqlaRFyj7pv+
	 BhQ/4GmwyyaR7P35VV4vnO14GLAELjEgEu+iKVb7IWIBLur05vgmuEkGPwQ/dZMhpYUSz
	 xIaLfjy98XLQKUlrFVqYvY0+gd/SpL9lYIEKqV563owEDbOQSU1KHzEe0Txqs6P8tbDU8
	 iRVmr2rqAayYBWIteV2Fkj/H2fpcFULQu2gjcYsSDiPREXEqmOGpZWzrVyjBJAX3zjGGh
	 AO9jmlQ1zF6kPlcWJFCCTk5RFhBtuF94L02uDTkL2zhgKRHkZur12oG3QXZgQmzU8BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cojUW7n1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07475606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Nov 2026 01:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cojUW7n1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7444F1F00893;
	Fri, 27 Nov 2026 01:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795744397;
	bh=4zzkWeT8tn6eWMjbMZMzIR50TlMRa2DY9XUuB2IlMQk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cojUW7n1rBrtSJR4vCBhcn31pQ6R5lU8YCjiRLeCtsuckZy2ScGvOLF8daa+cBVXs
	 egkJ/6db1xVIr82KVGKRhbSxwXOK8Z2wdy59eakW7aPE+OldnBikjNF4h5nkxGqwmN
	 nkhU8h3y0eBQC0RJ6vX7TEAsYCgzLf1oZZS2KAkowaZz2ex6gUkIW0K3+JCDcW6Ulh
	 7XMPYB9RD0EXhsnYi8RR9hDSdy8he+YqbvSiVI4zxgaM/ABSwJ4xNvM/aEce63Rq14
	 uq/c07TrUx1oWBK2VKpN6Ms0NCABeZf31cIqz2vpKBHjMeWMh4Ve6ofuAcVf4xQNNl
	 E/UA6UeOrYt2g==
Message-ID: <sashiko-outbox-236421@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 00/18] perf tests: Add coverage for the untested perf
 subcommands
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261127013801.14841-1-acme@kernel.org>
References: <20261127013801.14841-1-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 01:53:16 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 18-patch series:

- Patches 2-10 and 12-18: no issues found.
- Patch 1 ("perf kmem: Use the allocation order when matching pa..."): 3
  potential issues (2 Medium, 1 Low)
- Patch 11 ("perf tests record: Exercise more record options"): 2
  potential issues (2 Medium)

Detailed reviews have been sent as separate replies to patches 1 and 11.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127013801.1484=
1-1-acme@kernel.org
