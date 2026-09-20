Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C5D3D45C3
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881993; cv=none; b=t77n/D8GZAJJ4I0anQPiDHdtUHU7zpLVxM6mJVDZmLb8bxn/oyuGJ2WrLw8SjOwklSYA7r2ttlxPI6kPIQkgwXK4iG0yMNbya/RQl7DMeIJyDdAryJUluoZTTWRY4lzJlVPyUbKZTPFhS+hdvL4L2kwf8iv5zd73JNqvZZymt8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881993; c=relaxed/simple;
	bh=2nmXqKlGFS9HJuH8+Bm11YhBawLPnpRLd0mIBVpx8tE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HvqzKR5bOfaej0Ilqmg5NOxQs91ZHdwv91nuAjtAaT6M+UV99DIoo502yFIAGAjBbbjNY/FCnXpgJrJ2fbzLRdwvzd7O9gXviRM1GZvL9HGh+fkAuRXE+u6C+wXG2N3S9fnzr7q1arxr7LVM3SwOb+jK7EceTmcQx1ou0lmTK0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kql1LqNR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kql1LqNR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD16E1F000FF;
	Sun, 20 Sep 2026 05:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789881992;
	bh=lQx6UqHZD3uMSkgM3OB7XdwGNx/ata+ItfP8gAcX/tU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kql1LqNREFr2r/bkWz5eMqWd6tWTd5zyxLBpD+R/WF3iLqYtVwgDAHXaCB/yA7geV
	 WCZ/xWJdr60dFzO5qyBnB+5zGKIwZyuxe3w3PEv7+OC0skfz7FgUHXS87voHqQx1bb
	 C+SXapNZOroUItgFYPS86Upa1HEVEJ5CdxcYC0Nu1I/OwYfF/cZjw7Og3Cu+rBP3Fa
	 6tOFU8Rn52jz3TKgFiNHIlf1CzPEetVRi74x7W9b/y830V6hhEM0XOeiFXwZ0uTMXK
	 QtWV7p6FhTP94U3oaUPqQHn5kY8OoEbHPpT9KmzpAphFPF5ioh4rGtV55bdKvKVNr8
	 irYBwAaiQnRYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 05/49] perf python: Clean up pylint warnings in
 tracepoint.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <962060eb0320dfe958df4c20d23ab6c075f48498.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <962060eb0320dfe958df4c20d23ab6c075f48498.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:26:31 +0000
Message-Id: <20260920052631.CD16E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Clean up pylint warnings in tracepoint.py so that it passes pylint
> without warning suppression comments:
> - Catch ImportError instead of bare 'except:' (W0702: bare-except) when
>   importing setproctitle.
> - Remove unnecessary trailing semicolon (W0301: unnecessary-semicolon)
>   after evlist.enable().
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D5

