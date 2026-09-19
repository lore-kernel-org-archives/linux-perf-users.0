Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AB9547042
	for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 06:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789800202; cv=none; b=gAsPDLRLPHtvVzEOyjhwY3aIlfmaHq8jNMuM2Ljsfz1OWGxMSQjXcSVkIYR10i4SraojkSDhhAP2KKDT+pLA+O2Ebql87U7E5l+MmoZjt4VRELLgnAuwVY8c3piv5BXB0tlLT9L/oSqDb5j7/tx6jqQOv5a9Q6rcAB23atMy4AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789800202; c=relaxed/simple;
	bh=UjKVZl1Nhcf/XY4p61o3SXx+Fh8F5N5WuxJQ4a5udnk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lfe/JHMQWxUHQA2B7XCmvT2qlfKaLl0fthVxj6aZOUjE3DzqJA+UvjOh2tSC9PgopdjfTas78c12qK3oiQa8ouZqsriGaRtksvK5wIGERrHCtep8cew7jkPTVd7RfEA0xeig8Ci3CvpQxKBdo2vUa43fGd4Qiirf/YS0a3GvLQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjAcc6AO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjAcc6AO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FED01F000FF;
	Sat, 19 Sep 2026 06:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789800201;
	bh=UjKVZl1Nhcf/XY4p61o3SXx+Fh8F5N5WuxJQ4a5udnk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AjAcc6AOU3n5v9ETPcd9AGcS34ZWLmCB6JH42IqVtd83KR3X3v9N9eNQojOWiNYY0
	 Y/72+0ditJ2v6423HpyRhWnhwT9yw3u2upFb5pymPfwMYvjmHxZtFRTPwyFAQVHRL9
	 IM8iLPXPCz4+VlUOJa2AyJxn+7+s60xrJrOcCulZtPJeVtZ+VI4/qX0BXbqyfu754C
	 6J279tgl4rwbZGtzAi92F9OmUvCf+yg+d2vWjdsrHXBmOEzUL229S1jwFuWo9SNO5K
	 1iT3Cs2tSVE79Jvtv+RamuP4sqhRXOpZhh8uoV/vrogbqTJJpLNPzElLLxDH+J6FRV
	 U5M+zFwYf04oA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/4] perf annotate-data: A small cleanup in
 __add_member_cb()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260919063745.48444-3-namhyung@kernel.org>
References: <20260919063745.48444-1-namhyung@kernel.org>
 <20260919063745.48444-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 06:43:20 +0000
Message-Id: <20260919064321.0FED01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Check return value of strbuf_init() and die_get_typename() to make sure
> if typename of a member gets never NULL.
>=20
> Also remove the check for typedef by just using die_get_real_type().
> It can get rid of member_type variable as well.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919063745.4844=
4-1-namhyung@kernel.org?part=3D2

