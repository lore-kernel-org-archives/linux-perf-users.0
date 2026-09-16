Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DC03EDE7E
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542279; cv=none; b=MZV7TeZwiP3zfIt8VgXGYfkY356oxO7lFY1u8KZ5FSuIHaaumxvqmXxAr84KJR71LLznTS/91QLHyuIpShXZRjGu/0Zg7UEtLihm5U+FtRVPQnXMIEStJ7szw5pK6MiKR+3zopqihiOTix/oPX1BN+j2/8x2o0W5ethhutokopA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542279; c=relaxed/simple;
	bh=yXbS9vn9J2lGIcO4uLieluuJR2CM943WPmYVECsg2Rg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q2+bsWsSuIiE1+/c+Sn9At/aZmYCkJNlQcGyeC2q7RpZyrSnKhaZJz3TtZOoM5WQPpfp2U3Y/TPGCxgqTU/uzhTgJ66cGQ6D77d/Qryor2fKCft3I+jpkuFC+qBQhwb2R2A+IxPtbrDMooPn6GmlxsRf4y2MR9QIwZij4g/Sh3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuqD/WiK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuqD/WiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48391F000FF;
	Wed, 16 Sep 2026 07:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789542278;
	bh=yXbS9vn9J2lGIcO4uLieluuJR2CM943WPmYVECsg2Rg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UuqD/WiKaZ/yu1Fsnue99ge1Q9pDne6ZwBOnL/TNFCjYdnULfH/3H3JXR70lz3aPo
	 ++WRyuZ8RWV745HylCzH1lWwWRxrlblaY+lZXZCg4UD5F4y5zm3WjAk2gjtjrE68gs
	 inqM9KoGHNy8i85EWsGJqdraDyaQ0e7McYRbyRaeRSfNMyWuWM8+gQolsvUT1a2Ig4
	 qtFVSosq6iHrjStXzmUde+smjbsU0ynwuGbyAgd+yDWZvcCqOXUh6f2vtQKpcmGmY5
	 LIYhnykX4dUymwVkYy8b1VawU3mE/2Fbt80MkYJGzE3sCW+Ky5Ng2a/mk/uI4OC4wQ
	 86Ow3QkFHaGKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/9] perf test: Expand tests for --hybrid-merge
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916065248.3153556-9-irogers@google.com>
References: <20260916065248.3153556-1-irogers@google.com>
 <20260916065248.3153556-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 07:04:37 +0000
Message-Id: <20260916070437.C48391F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add a "Hybrid event merging" test that checks evlist__can_merge_hybrid()
> and evlist__merge_hybrid() directly, covering the events a wildcard
> expanded to over two core PMUs, the same over three, and events that
> must not be merged.
>=20
> Add a report_hybrid_merge.sh shell test that records and then reports
> with --hybrid-merge, and extend top.sh to cover perf top with it.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916065248.3153=
556-1-irogers@google.com?part=3D8

