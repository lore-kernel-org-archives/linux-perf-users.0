Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8F43B9608
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 01:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789522735; cv=none; b=WtfRWQyMCMd7krNFJiBcVqhV7J8CERSembDYZanWcoYR8HdQC2ne4siLSCuQxEkkKBBvIzIVwYcA/oYdwdJaaBn3Zr8uow5OW9rw88IOJDlfAczbsGbxE7rUJI4DTTH+0qcBlkXC0ytPcwVZKV0fEC+9a3QqY91osi7o//XN4F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789522735; c=relaxed/simple;
	bh=90YJmGhuwlivXFcIPg8sh+F+/Xv30ArWGCnWpERRjHI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H2pIPOT6pEUcdJ6IH5LYJCugaiPJAVuwN+IpIt5uHkdM1xKpnGPmH/vtVA9zL7Wy9PACp8ErIenma7ibfSwISsIistzQA4dWcd/XHdc9x33U8wWYaCc8FCjIggVWVTYT0z8jaR4AnxDh4BGOtfNWhDWwL7DYv5h5n+UHbpx7JFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDyKnHiY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDyKnHiY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205E31F000FF;
	Wed, 16 Sep 2026 01:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789522722;
	bh=/gm+QK3oy+GHcWj+fiTxd4S2XlcNxd4DtyqQ8QL/+Ig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iDyKnHiYqx9RPmgUAKCdEG5jKYM2OwSnRFUi8GeQ8YiMAbC56I8zZDFcsepMzSLl1
	 eQ2QVFShtdVAl2dW2xZzNIwmSBwcMQ2n+GpwiRM2ImF7od+EPlZj9QNfyjQtIYlzcv
	 NlCYBkWF/uRGcTlARR4Woj5W7Y2W6bcwv7B9S49c1H0dLNYb7mD+8fLRIqfgLIX+k5
	 QiNFd5EI/2YHqbX5kJm4trVrUH5HBLq8el88q1HAHZdNa6nQuPb6dkzwE1ROe10tWN
	 sFECrSZyPqtFZFaSbL+kBltca9dFSJWCc+XJSU+yJC0rxS0b8n2rw3pxeK3/8UMt1O
	 GHB5o+QUP8OfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/26] perf annotate-arm64: Implement
 extract_op_location() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <7d425a8afe73f5684cf7baaffd2d5398f89f32a3.1789521520.git.wutengda@huaweicloud.com>
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <7d425a8afe73f5684cf7baaffd2d5398f89f32a3.1789521520.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:38:41 +0000
Message-Id: <20260916013842.205E31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Implement the extract_op_location() callback for the arm64 architecture
> to handle its specific assembly syntax and addressing modes.
>=20
> The extractor handles:
> 1. Immediate operands (e.g., '#0x10' or '#0xc600, lsl #16').
> 2. Memory references with diverse addressing modes:
>    - Signed offset: [base{, #imm|reg}]
>    - Pre-index: [base, #imm]!
>    - Post-index: [base], #imm|reg
> 3. Multi-register operands and primary/secondary register extraction.
> 4. Register extension specifiers (e.g., uxtw, sxtx) and shift amounts
>    for shifted/extended operands.
>=20
> With this callback in place, 'perf annotate' can now resolve memory
> locations and register types on arm64, marking the initial enablement
> of data type profiling for this architecture.
>=20
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789521520.gi=
t.wutengda@huaweicloud.com?part=3D9

