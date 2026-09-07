Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B953E6DD9;
	Mon,  7 Sep 2026 04:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788753982; cv=none; b=R67sG2JMe/crHwI99GoA50JKJw4Wi767qmdwduO5nhNcytAHMfR/7lklYbSHwiYjl+SfFZwVW1iz01kZYn45oNkCFuEOTiYpe05SL8Dv7mP7ARsa9EAX/pJ4uy3eHXLTEYv90R9Wmf59HsxoHcdFGn/jLilunB3vGg2nICj1UsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788753982; c=relaxed/simple;
	bh=O5+jJVlTIvz9IIMki+e4jhe+MbUp3XedryVjU/Pzgi8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NS6s6h+PZlaFopA0qyz8e1CF4MQYW7Oh7EsoGgwZBFR93OB2WSwNeWr496vWOsoyfNcNYIKTymRL1qKBN8/yvJanDrYXo5vnf22KpQ2u1ALx1LM4/yiHU+wQYR2ZVdS/085fsXBDQVenY7CtU6Xnp9JkoO7x0iNQ1XsjHtPQn4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktq9rX/O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktq9rX/O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6981F00A3A;
	Mon,  7 Sep 2026 04:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788753978;
	bh=O5+jJVlTIvz9IIMki+e4jhe+MbUp3XedryVjU/Pzgi8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ktq9rX/OEgNdt/E220SNDtldyI/lJccuVwg8lYTdc3RD5jUiKEBY4iX96Dy0jjVq9
	 XiNrBHNgpCfvY6KqFVQCnZHhE4JNWMH+YPHQmyJRpkfFeKpgskti8SPqaC4RwpeY/I
	 PPnFhEeY/illynuK8YpgV9kcsXivXWkzZHxqJf1byGIUBW2SXwUB6ecmrRrAGcjjm2
	 ddPiIo7k+IKvWM698ahj3JHs25/HfI9pY4CpLkw8tKiVmp7NmccDki1spZa9nf8xxo
	 s6Hg9IXUJ305PQ9m2wzzYRoa/sJdBrKTARBIiBujiFs3cPMyfenqiAn7LAp4vu9qmu
	 eHVvzs+dISQZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 12/12] tracing/wprobe: Support BTF struct offset
 resolution in set_wprobe trigger
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <178875291323.93794.16645737472750929830.stgit@devnote2>
References: <178875277830.93794.14247844688761142429.stgit@devnote2>
 <178875291323.93794.16645737472750929830.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 04:06:17 +0000
Message-Id: <20260907040618.7A6981F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Allow set_wprobe trigger to use BTF struct offset resolution to specify
> the target address field.
>=20
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c=
2.1785067572.git.wangjinchao600@gmail.com/
>=20
> Assisted-by: Antigravity:gemini-3.8-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178875277830.93794.=
14247844688761142429.stgit@devnote2?part=3D12

