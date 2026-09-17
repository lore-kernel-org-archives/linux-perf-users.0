Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF0E4EE84B
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789650480; cv=none; b=VIu4FRCAbSo4fByWGno9oyLfNFi0lhJn5lIxR7gvHvn2ngyc6VKgQ5kcj96BsmnKbINnFASUTzX1xTWaagx/gV/3Ab0sKFYuIBMrUscXccqbTl/4ldRnwB0F56JKqXUfwE6Ze0r+rx+0XvjMI5BAkN37Jj0aQPjl7DaBO3WfX24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789650480; c=relaxed/simple;
	bh=YkGCVYI19mzIq8nbBEIAELusWsaxahZzaPX1Qxx4Ld0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P5sJbZPF6Z2YgFyI6N3yyGG1Eynl7xQSmN+WsoOcVVs91II26Tnu4mOy5HozhGw87QGwLAH5T5cWkkLUS0q2gDEGzjNHqXLJDyvmDligCmHAI5Oc9vx/QMkqsoyZQAlPDcXFi4B/l+OklGIpq3rCw21AnvgDWuJiH8MWRGKhsiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYJvV6cD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYJvV6cD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A741F000FF;
	Thu, 17 Sep 2026 13:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789650467;
	bh=YkGCVYI19mzIq8nbBEIAELusWsaxahZzaPX1Qxx4Ld0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IYJvV6cDOswjrDZJmHb1GEhx9VBouR4kuRveivtT8OZGfRRuKYbm5H1HApIBunZIV
	 rmtdYl/bHEF6uVoJ7VrB8SIYh6d6i6vsftjvzXhEyv1ktQPqf91aebESykRbHMETG7
	 MRW0ud6m32UyuGpKkmk9bgYiXy5lBwbZpYO1LRJe+r3ACoPQaIsF8h8Fvbpy9lO06M
	 XP7dO2VXXgy9XP0PurNn/avSviwnqKx/CXwYIhwgwY44qZ2eT5aQ3A5ARgLH+nvYX5
	 3pCirsMVaIaTPdhyBO236GAfXAjOawOtzZ47TrbeI0hbnJ/8YC4eFhnv8CObh8+Ea7
	 B5YlFdlpdVnEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf llvm: Fix memory leak of args->fileloc in
 symbol__disassemble_llvm()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917125802.1198419-1-wutengda@huaweicloud.com>
References: <20260917125802.1198419-1-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 13:07:47 +0000
Message-Id: <20260917130747.69A741F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> In symbol__disassemble_llvm(), after calling llvm_addr2line(), if the
> subsequent disasm_line__new() fails, the code directly jumps to 'err'
> without freeing args->fileloc, leading to a memory leak.
>=20
> Fix this by explicitly calling free(args->fileloc) before jumping to
> the error handling path when disasm_line__new() fails.
>=20
> Fixes: 048856817888 ("perf annotate: LLVM-based disassembler")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917125802.1198=
419-1-wutengda@huaweicloud.com?part=3D1

