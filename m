Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523C83537FF
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 21:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789075086; cv=none; b=in6lyzaDh6kZL8ClSSGEB0Cht2hxo4grQ8VP8iTioC1j3PUiHOLlEzVmKASCqnR2+5v6dKOTZRZ8w9RKXLZKVg66qI1jNEXzxdP1QNCvey70xwPyDq+48kATpM0gEEZlpli12+qiwp9pAKNujwRq5lXhx7HIfbugR6EpD23hv/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789075086; c=relaxed/simple;
	bh=ZjRTFfMLfo1hT06q3zAL1yT6fwx6jFGnaJ7KA0CQqeU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iT3yuuvEeyx2bjG51vtCo3xs645N+VGUxC1PbPDDIX5dUNS/GYHPI6dBO1wJq924S/z4E6T6j6cxHxdyujxNFg1IV+gnhIZaBmkAuALO47Nv6U4lQKVKwhwELkIWwZjvBH2yixLKbCMIoSD+PswmH83OVo6rfOxpQNbux3zZiNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btGSpV53; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btGSpV53"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0631F00898;
	Thu, 10 Sep 2026 21:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789075081;
	bh=ZjRTFfMLfo1hT06q3zAL1yT6fwx6jFGnaJ7KA0CQqeU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=btGSpV53KT5Xy6wuzdyTzyyz4HDD2kiLDXEe6mfA9Ev0u2GfiAOEevnRfMk695fPy
	 SlqC6AZM3hwB6sW7N4ErhgKSme3yr82Qq/1D8i4LIH2/tJETum4l2aXKNUmpWbk2O+
	 OTnNRvfSHmkGAUFtddr25zkZCzTqLdI3OTfMrHvKCSarIEIfTCLyZ+lu5NTFKru5lm
	 LWSEenwKyZQ2JZ/V84wjB70EHyGje+vdjgN6iYioowNLAqGIKeqpaf+DZgJ1rd3FZU
	 lEzQaijcHxKfZDFnvIMn1fE899B+sMr/kxUhtkb9lrJugfcJRgkEYoCGvXBSa0GBmn
	 tCbgUTI/M3xAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] perf header: Transition WARN macros to debug.h
 equivalents
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260910211221.3154261-4-irogers@google.com>
References: <20260910175634.3014018-1-irogers@google.com>
 <20260910211221.3154261-1-irogers@google.com>
 <20260910211221.3154261-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 21:18:00 +0000
Message-Id: <20260910211801.1C0631F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Avoid a checkpatch.pl warning on the use of asm/bug.h by switching the
> use of WARN macros to explicit tests and then using pr_warning from
> debug.h.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910211221.3154=
261-1-irogers@google.com?part=3D3

