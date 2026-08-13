Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37C638F929
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 05:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786600004; cv=none; b=P1gUohPZepxH23RNRm7PaWldd7zd5U7XXKghtVjSobZXtRrdScLGxO4DCnzm3DLj7XB3Je/uujbdCj406pvxVTEPoQwjcfhcQCvYHjv5hNm6u6N1ONvKvRtyaU9DqBjk6ScO6Szj6MfOFGdZVICUWVuRzouIiuWN9K1FyYs3iRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786600004; c=relaxed/simple;
	bh=3mFZi3CQSLzmAwWMqT9NEpPN6xaNjdpUllSSEUyxYZI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RM3+wVf9CVhY+3KJ2np6rg1vawpoNXBhYeDYTcMe/pQkVflOoeNDNv3K3xZeJxOUC7jtsTfzflgdl2UyMWrWk9XqHmSKzKPbrSt2eS9PZq08svom9AJSg/0bLcNVF9V2MCe6Ch+BrqIs9aN7u4lCh70rHLcDdPOVCdwyygjnlkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMJLSrSX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMJLSrSX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8EB1F000E9;
	Thu, 13 Aug 2026 05:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786600002;
	bh=3mFZi3CQSLzmAwWMqT9NEpPN6xaNjdpUllSSEUyxYZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AMJLSrSXbGfGNS+LJVsX/3dFWnpOMa7G4ekFS4+FvVhmUasDYhP66Psa51CRAdetB
	 kkLU0tZwatW7peldCyafQd2l1k8QcEIdHNdcBdbHBieBu+YjAT7lIUj/lIVbYPgI8I
	 GblFUV9vC3ik2s1Akxz0y0Q6OaszkxKsH61aJ/yQiTxiKaWKBI3qzGsfnesPO8K7JU
	 etMxbtCHiXyIofhVopz0jYndysqRzWpZxGDs919K+bXyJ1Uxgo1tnEcWl0hU1yC+UK
	 doQ5LYpqC6h87nDZ2jLRJvo0fimyOSXyjwLfOsat0+wIKV44BI5MVBctQlu2ZdvNTF
	 jKcUJKMBGazxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/2] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813052419.2770841-3-irogers@google.com>
References: <20260813043533.2744442-1-irogers@google.com>
 <20260813052419.2770841-1-irogers@google.com>
 <20260813052419.2770841-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 05:46:41 +0000
Message-Id: <20260813054642.3D8EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813052419.2770=
841-1-irogers@google.com?part=3D2

