Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0596838758D
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330667; cv=none; b=b0w3qqKd6MW/NMS/1EOy2pw2kvsD7bK6bYaElR+pjzhAGC6JK3mKYESpvbzpfv8Z6YjeJT4pc8th76Ql6ItL3p8HSceeiRl1W0+Q6nnFe/B8JjdjimZbDEAJmBHcanhIFPyfPFXCDJzVmwUhg6trayCf1nHcAFfIEE9ZX+dZmxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330667; c=relaxed/simple;
	bh=8mF+D79GMafanJwldhi7pU2PDhQOaM51O1g6lS0m5E4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZJ9adZzMldx+1yzx/Y5kladkTIPfbUICfsHa21PPhcyab+/TIip4YU0+yPKFTLFq5AOwTVMj7UxThZzwF1aRdNin4GkiMwxs2zHyy4nKuNxAsBGGLexjMX6AirJNva8fStjj21ifL73qbx9oPZOpxXhY7cCkKKunRVXz15juf8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYnWGLLC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYnWGLLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820851F0089B;
	Tue,  6 Oct 2026 23:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791330666;
	bh=RNmca/mqn0A9fMR/ELu4OCRHfMS23Miy1ioXP0D5FD0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XYnWGLLCjTBVUCv9+X51iKQGazSGx0BwLbVgPQbWAdE4nks05HH5EfarNmJlCQaeo
	 4HoOxCZ/Fdh995n3ayNaDuHMZrcMmvNdIicFEBvbAwODkbMtCE4oGr6wnTScwvjWKU
	 nZ5ZGASni4q/BZ6iUWniRwKDeokLfGV5OmOctBguGnQu1erhnlHd18D5pWt+MH+7sX
	 9dVD5Aw4iqBQjeRDV4uLJCR4sJYmjVUxTFn8+L9GHocDJhIsnywplhxJrm1NiO/JxO
	 xykp4p+GTLQpbxQ2Q6AHjwlcKtnnjRysYbRK0AOyoSlYOG+KUBoj80mW8eaDTPnWHn
	 Pak0BrcKnDc4A==
Message-ID: <sashiko-outbox-162528@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/10] perf symbol: Set binary type for JIT map DSOs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006234315.920817-8-namhyung@kernel.org>
References: <20261006234315.920817-1-namhyung@kernel.org>
 <20261006234315.920817-8-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 23:51:06 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The perf-<pid>.map files contain symbol name of JIT functions.
> As they don't have the binary data (instructions) no need to try
> for dso_data.  Let's set the binary type regardless of the result
> of symbol loading so that it can be ignored.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006234315.9208=
17-1-namhyung@kernel.org?part=3D7

