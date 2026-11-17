Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942033;
	b=lNK4DdFCt75cL0WeH/lDX0v3KpaeAg7BNLeZVvv9dUtMmjhx7NcpKhDjIvmq6oWgkULV
	 ewFD9WsuUi8dTzDKxgHH3eoDjNE4s6Ht8stCz8kIJgPdyXuWComvAbeBJ/BGAo9VvEqUp
	 n2s2mE5IywZiqLTXAZwcoP5+G9JO2hMWMxXm2tDBfwi15zQhTF/Vf/aLuCJnkPWehhcSP
	 Cea6Noql3NO33kt8tYULWNc1j+WYFLcPVYZvRwf767L/JdoJHo08eYrnLcLbK8TsiH6Pv
	 ozFDVXQ5LI9oxn19VOYtoCLtYD7cV5NUIFajzWWBcvuALwd5/uT6Q6rm9Ovss+PXQJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942033;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6T2hoh1ssrbKMj04ji9a5uA5IA/NdkwPpGnBpH425MU=;
	b=BjTnFAOCLeqPK+d662K0WNSTPGVAth5UCWeCAxKuScWeAiHOneDpfp4kPHC8lTvgdM/5
	 DIY4JyhUuMMM8r7rkU4ZEM8jFGUSDJEJhKJf41Oklzu8TsWdEBzYvSwQnKYWp3RQxwHfk
	 YUBZb0yrwqjY6D4PmGXNNA53c/3nBidp4PXZG2X0hWbRNv/0UXXCeSLlCcM0csBR6zBdM
	 QBVY8ct9GZJHEFJYmgaIVWHj33plsf2dAUGZSv4+p4J+xN+FXTX9W00pHQV/aS+nyLuPX
	 7zpilvWzQ1KpMP2IanhsU24CX/dqNUspxHVs7C5tlN6Q3eUh4vRiT++HVDwpyu+sOKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F4sZ8VvM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795AB606A334
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F4sZ8VvM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C14E1F000C7;
	Tue, 17 Nov 2026 19:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942033;
	bh=6T2hoh1ssrbKMj04ji9a5uA5IA/NdkwPpGnBpH425MU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F4sZ8VvM0DuVP7CmV5RDnH7nheyLrLIwpYS6BqAtVkM5T9Wy58FUAxQy4qVKFqIPY
	 xP2GgH9fSaoMs8GxtI6l5xFLX4QvmRn020xHNUwyb+8fI5h82HUvWd5OvjDtI65ET2
	 uRk8z/YcnHtZAPEN2U+ks17DGPTM9ZUHTjyi2K5BOEUB+j7MZgjquvtX7YuT3Pxbgb
	 e5gZko83Y88EeNsZ6JZnV6xZGEVaK/UIQkzM0+emyuxD1biPN7zMi9YnP6xYtriLKf
	 NGmTLGLFBQkhNfoGIJDt0hu/PNf9ggBE/rLA906mGivfr2gwycLBMgYZeJfBINREkl
	 Yp6fqcP1oMIKA==
Message-ID: <sashiko-outbox-219415@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 23/23] perf machine: Add __guarded_by annotation to
 machines->guests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261117184844.99889-24-irogers@google.com>
References: <20261117184844.99889-1-irogers@google.com>
 <20261117184844.99889-24-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:00:32 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Annotate guests in struct machines with __guarded_by(&lock) and mark
> machines__init() with __context_unsafe().
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117184844.9988=
9-1-irogers@google.com?part=3D23

