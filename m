Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EE74F5E18
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664133; cv=none; b=i8bj6SL4psXF5SARpC/CGPZHTcwlEmh+sz+J1qqJ86wO3OoNwPXDDUqWARseQm9OrlOT7xac+bplAVsQqOIe44rBXhKMQKj63Zcq38w5zezX06GEgdnPujzBWPqQDo/5jgW/L0TflzmRH42Do3Q59a6U0gxRRxYnLgZgD+9hxJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664133; c=relaxed/simple;
	bh=nJOfH0A2dvD69XXi9zAiNoLKQZ4CB7mcW0tVTD8ERiQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r3eQ68vsVVFIPuWFCX66SPHytnxmARr75Ii3kwsk+TrYbVmmVjHjEeJsU8sqQ3GMFln3i33jDhvRC5ilrjrhYbuEpUXeUEJLJu1qoHd3kWfX4wKIC9c8oHltQPHx17HVVRJqml/V36qHV8it61f8hmRZqWVy2frvHR83ajUnjpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eL+E+bT6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eL+E+bT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B261F000FF;
	Thu, 17 Sep 2026 16:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789664131;
	bh=nJOfH0A2dvD69XXi9zAiNoLKQZ4CB7mcW0tVTD8ERiQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eL+E+bT68hQJ3S77mQ6T1jQWCd8dXmkGefxNZVeIoFIJm+P085wfuJeW7wJQ/p3aC
	 tVQ7dzgCUiiDWulT7BU9sTaCBUKeqXccbo8c9P76DGY6IokKNBYl7haYXoCCamtvh5
	 aJEsUUYFHbhyL/mXuvfee7DHVxuXlAwu+TLDAkC3VBaxIh+fdWJu6YNMKUyz/LOEDX
	 NY5PQ2ZsK3tmxd4HEnfmX4OQg2nYd5g6cxcnbQ61YpIcSa+yFSn3MlFgEarlusPR0I
	 1rRI8SFQ6X2zp5I3cFUMyVYkZg98KB0Q2k99JV8j5pL+tH6yTM7Aq4KGj2YoYE+bej
	 kgAjlION7kcPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/14] perf test trace_summary: Make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <f889a6e06cc80f612cf741e403ce2acd136f2fec.1789662556.git.irogers@google.com>
References: <cover.1789662556.git.irogers@google.com>
 <f889a6e06cc80f612cf741e403ce2acd136f2fec.1789662556.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:55:30 +0000
Message-Id: <20260917165531.28B261F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> trace_summary.sh tests various summary modes of `perf trace`. It already
> directs output to a unique temporary file without polluting the current
> working directory.
>=20
> Remove the (exclusive) tag so it can run concurrently in parallel test
> runs.
>=20
> Running perf trace in parallel is only safe now that the probe tests no
> longer name their probes "vfs_getname...": perf trace opens everything
> matching a hardcoded "probe:vfs_getname*" wildcard, which used to pin
> those probes and make their cleanup fail with -EBUSY.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789662556.gi=
t.irogers@google.com?part=3D13

