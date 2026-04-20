Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D8E192B75
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776644860; cv=none; b=JxRpJHR1WpTW/lqo+eUZ8UGG8cSvbP+xiVcoHvcxbcF22pCpnqv8S4NMhzOQYNj09dTgUgeW/C9Z/yEhmlrY4aFRaqwTpFQXgIHQEl87Qqn73M1zjeSnxfAHVdNzBL/mGjryAkWMwwaRj/7BW8oxhQ1tTahZw5yJF/nvOLE5jYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776644860; c=relaxed/simple;
	bh=a9q6BkQ3e7hUDeYOzrdKu23iiAsojj5JjRWJ2reXtdw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rd4K9lnj/Rm4ZNvWXJ6tMjfnYFzgJi2rq7aR/HgBoZSywGX76wdXIiW48B7o5khrSn5MmQUSOjoEhn67eOzYZSpjG/gxNOMQ6HHVwr8B5yr8Kch98XWv4QVcOKqLg7FrBIgxr+MXU3IAFvwzbCMTiO3eefCFfOgntag0A3O/FSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAyiK7r/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAyiK7r/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71011C2BCAF;
	Mon, 20 Apr 2026 00:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776644859;
	bh=a9q6BkQ3e7hUDeYOzrdKu23iiAsojj5JjRWJ2reXtdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sAyiK7r/kniIgYP3eGqSfUlq/HWA/oigQCxT+z+sVuD8bhBC06y1j979esr4JJLXu
	 SWnaQEliL5FeHok2I4nQV4cZtgESMIhVHkR3XSBnfTKw1aXzlq9p9+bEHmCMQmoX7W
	 usUF/qgExqD0MKFPvVMaKA/x0DbJ7uKXmuPPyefWBzEm1ctumpE7g6p5NsrXxLMEms
	 2MDWFPHqXsNs/gFV6hN+3OvIhYs5HWooRS5l0KomfdC+W4xm1IiXPAm34koEjQzkSg
	 qQ8cR9VJIibsS5HE/O6ZHpdfFDc3aVG35WYPjlfjqki5RVdYxIoTCnBuCdxKRZFYqB
	 XIG/zkaITt6vQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 19/58] perf python: Add config file access
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-20-irogers@google.com>
References: <20260419235911.2186050-20-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:27:38 +0000
Message-Id: <20260420002739.71011C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The commit message claims to implement 'lazy address resolution'=
, but the patch only implements `perf.config_get(name)`. The code for lazy =
address resolution is completely missing from this patch.
--

commit 1e6be9e1aea83e8101ab407cfa623b7a901ede2e
Author: Ian Rogers <irogers@google.com>

perf python: Add config file access

This commit enhances the perf Python module by exposing the configuration
system through a new perf.config_get() function.

>     Enhance the perf Python module by adding lazy address resolution and
>     Add perf.config_get(name) to expose the perf configuration system.

This isn't a bug, but the commit message mentions adding lazy address
resolution, while the patch only implements perf.config_get(name). Is the
code for lazy address resolution missing from this patch, or should the
commit message be updated to remove this reference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D19
