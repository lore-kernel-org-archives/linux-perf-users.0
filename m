Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB21F3D669A
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882549; cv=none; b=nwV7oVgWSqsOJ/aI5hSbv7+RZFcoaQYWN9rZdWIJaQJpvk7+VML4oVfNEs+ePABXCo8qr8HNyUgOaNf0R5tcvys3JDEUN5PO+ODs2J1Jx/omymSGRofGJVgbXBkA4ytRQgRyiHh4pUXlaV4GEvsaqWE7gY6uckdm5udhjVmsv7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882549; c=relaxed/simple;
	bh=1X7HA4ABL8dXQBx8Jf4U0Kffdpskg/XxNyZA2boNkEU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mslMKGbQBLdlvtYqeyosV2rY+pveJWs72l7xUaBuXuIEX0XRmBDkoSSB6aLJ0aGcQSpyXBD/Ct08DLT/kUTEbYTUwzO3aYv7oMSyPYfG6EhU/qZ0fp4gAXLHFaeAsqEXlR+KcXbbXJzXZUF+SwSv/phjIFhcmsVocmBJNLW/7J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqA4TLtN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqA4TLtN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967E11F000FF;
	Sun, 20 Sep 2026 05:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882547;
	bh=/mfZwHeGO4EVFqA4E20fBohm6V4MUdS2yO1cMEt4gVY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bqA4TLtN6x2gmat6m6YveMHYQIasXVRcqejchxVTH4r5twL6GfzSjjRLtFEayAP8y
	 eAZuz4D6XSTNeptbDkXMkkoXxd1c7t7uN7vReP+0jn2Sdtkw8tBhq1qglk9mMBwZgb
	 DzKBMpbRKYnp57vALgN4ZHuPqtDqPxX+HfKtHUUO/ycjkQ1+3fq7riUCdgig2uzLM2
	 z4O0rY671XIvBx3eVJzUkkKpE8MHXeLmHf/uNDJCckUgdKSoXyaf7bG4s9NK/KamON
	 0Y1y2EoDQT/GDDxRsh1iEoMCedTP8djekBRk7rrE03BIIsKnPlhSMjnvhjQwNm0yPX
	 N7e5Is9fax49w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 07/49] perf python: Improve perf script -l
 descriptions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <03a0ba15a5d53b66d6ec2202ceb5d422e3e9432c.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <03a0ba15a5d53b66d6ec2202ceb5d422e3e9432c.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:35:47 +0000
Message-Id: <20260920053547.967E11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add module docstrings to counting.py, tracepoint.py, and twatch.py so
> that 'perf script -l' displays concise descriptions for all available
> standalone scripts:
>=20
> ```
> $ perf script -l
> List of available scripts:
> ...
>   counting
>     Example for counting perf events.
> ...
>   tracepoint
>     Example showing how to enable a tracepoint and access its fields.
>   twatch
>     Example to show how to enable a software event and track
>     context switches.
> ...
> ```
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D7

