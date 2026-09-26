Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E8E352FA5
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404362; cv=none; b=fe8Kj76mgOHyzFOiWJRkXJH8TYQvKegeT6wqxQKWuGF9bJmKqiBNReKSsTK1eap2sSJPNHLqeSvar3DSvSZK0dOtja7oGs2yZHyFcFX8SSnzTDqe4kSxeOaBhSJlbyw85GJQGQjoXiJznptzanv9X8vgrIih0finGoOrBW1hKTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404362; c=relaxed/simple;
	bh=I4u3pvrs1p5R8ZOr9242+m9kpo6o2TsfvDkoZEp7g9k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ThTJlFN1WCId/ANH83ydJiAyhOUuxWeplR7Xzu+zZILVpLgoz9NSdWVKj2LQVZQcc/d/LLaDy7kojpthSfK/AblWUiGdiF8mSy7aa9XN6SjT/QrwfaZbyMRa94jS/cK7KB7Fjoqd4XPEtxsgcq/vjgOj2VhvlMVrUw8cOLzWGfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Frv9cymB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Frv9cymB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4291F000FF;
	Sat, 26 Sep 2026 06:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404361;
	bh=I4u3pvrs1p5R8ZOr9242+m9kpo6o2TsfvDkoZEp7g9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Frv9cymBqvs0AJByix+QIJb3Bznbp14vZh7MgDmeoU5pd+ktD9y71ogAXf5BBLdu2
	 auImObxK6XuD5SAbq4PVFlWvJWOAe9LiTYiOIo3RvYo2AgTrAjY9Ed0UwQNTJfO1tq
	 S08w36vkBVPlSHAfU+kQY/cv+9voDu7k1CTkzLFHvoaBUpCir772vAb8RMVQbxhzBS
	 vnU138Q2wLBMYRxIFUCOTJw+I+5p3Pvx/dJZBhPz4Klq3S4JhW5Iol0oWcHX7u7oPo
	 /mB6E+7X1G/ZTqmO8n1h23aJLQ8Oo99RFpOeoCwvzcXRm31RqXYh+K/rV9RB9FlOgE
	 6ufErfSJ0Oy/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/49] perf python: Clean up pylint warnings in
 ilist.py
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-4-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:32:40 +0000
Message-Id: <20260926063240.CB4291F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace bare 'except:' clauses (pylint W0702: bare-except) in ilist.py
> with specific exception tuples (OSError, ValueError, RuntimeError,
> TypeError, KeyError) and use a safe '.get("name", "")' sort key in
> IListApp.compose() so that ilist.py passes pylint without warning
> suppression comments and handles unnamed PMU events gracefully.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D3

