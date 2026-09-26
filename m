Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D4835A387
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 06:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404326; cv=none; b=AL8ieHo7vOCkkesvUvWEtpXy0S4Rq7eo2L9KTk8v+GsuDSAI3QTuOvwKYfvEAIb/QWW7B4bbrjQxyaQsSBqh1gRhl5MJN9T3ZB354TlWhebtlWz0PgFtUBCaiYZaE9jQFbq6UrRc0IGVbbTjQDozG3iW+lwHEFjeNigbBgqywBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404326; c=relaxed/simple;
	bh=Z+hYXCwal3yUE4jyDXROd0UACU4g6Uo7qiU4oIJNqa0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PQkvW8PYnqk8kM8IZpZjJ6GG/N3IC1dQEa3sAnCgKlVAieCOFg1dR6l4Q6gtGP3FXXG+dZ+DSnVY6u2BrFQJe5+1+UnjFswXhYNrNGswjTlGI6FZDHxoHhojfSo65CVEIBcS+PN9OZb9Hbjv41jQ3rAjODsWqPiXp8uopCX1qhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HddiCPZZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HddiCPZZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7400F1F000FF;
	Sat, 26 Sep 2026 06:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790404324;
	bh=5VsHVheJFMF/Wq30oWtUuaTF0+P0Xh6w8QSqQ8lCIiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HddiCPZZgxtqNqxrYcullZh7dt5GcskqnzG5fLIBB3+NI7ghuusmPwjM/rZhJYyIA
	 OIxBC89SnSuB5IKQPjpva1jhkRU4HlSEJa8SiRywbKmSi/p+LBjVVlfVeeAWpH0FKu
	 6XGgh6BWFrW6x9jjPQ2I8XcxvWO/Cc7FszZ/ogy9PC0hIDV2B54A5YiPVoPNGSNzRN
	 hiDiriXAaxsbp7er/FC4rCqhbe/kPyH2LcrGUJUL2l9KUkFQtRRjxiKa3MrFFOzMvV
	 yXzOgYcEGO00w0fRYR6EsVS9Dg+CQKcqQWh6njxcwEYprj/yuDYxp4m2wQt6ZLLxSg
	 V3noOGGje0jLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/49] perf python: Update callchain stubs and
 session thread lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260926062029.800743-3-irogers@google.com>
References: <20260923181213.3032038-1-irogers@google.com>
 <20260926062029.800743-1-irogers@google.com>
 <20260926062029.800743-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 06:32:04 +0000
Message-Id: <20260926063204.7400F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Update pyrf_session__find_thread() in util/python.c to accept an
> optional tid parameter (defaulting to pid) and return None instead of
> raising TypeError when a thread is not found in the session machines.
>=20
> Update perf.pyi to match:
> - Set session.find_thread() signature to (pid: int, tid: int =3D -1) ->
>   Optional[thread].
> - Update callchain_node.symbol and callchain_node.dso to str (the C
>   getters return "[unknown]" fallback strings rather than None) and add
>   __iter__() to callchain.
>=20
> Also update treport.py to handle Optional[thread] returned by
> session.find_thread().
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926062029.8007=
43-1-irogers@google.com?part=3D2

