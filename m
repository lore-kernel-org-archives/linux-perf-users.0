Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04313F20EC
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542396; cv=none; b=sumDv6aZR9JNQKi4JA+NJYM/MPvSyp+fudpgHFTCgnTV1xjycjcLIPd0YHFNF4FWzT3/HH0FhMgUuIgJRDOursAp5GpFbXY6hD0ij8t6msTAS0Va7DTEphZuMmJxDOygEHdu8fRH3hf1yVshIT/4EfjCpQfWLZwbz4MQ/R51DQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542396; c=relaxed/simple;
	bh=OfJljdpUZ6W64p1uBUZvyLWhMyxbDrzguPpRnZK2oSc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uZUtg0TcfYYqoOkS4S9VKmG/sh4RQ7z3ooTN8zf8fT3DIliTIYf6sUBtoZXlKKZc/ibAuwxUVk5mmAbRusmuJmNZE1neD2IismO2hurZL6yg19b04DcTMOwwlVNtisvkjn9Twd7jd5BYipyBbOfTYW1tgquI0Hey7q0Mu6F/EA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPG5+2vI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPG5+2vI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D84C1F00899;
	Wed, 16 Sep 2026 07:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789542394;
	bh=9BjQlw8bJZqOAGxEYlTbyMvKi+d52c8TI7VX9SBn6q4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YPG5+2vI/xglfFTplYnzKNSwWUGoD0U30C8tQxALUvSpYOchGe724UTT89YKt0hXb
	 qjmLT0vwr5TmZM1CwGiaW+a3i6lRvUcvmTPxR5Glexx1KFda4bJBH+6F1DuQ6o1ZYH
	 zU60MZhN0I6PFBzR8EnkKovSND7LBs2oLPIWt26dF0reGuA+ghd0CO7ZE7C/O7TDeZ
	 fQEYS+yf7z9Tlff6ni8kt1kHoAXaxyOr4FhZIcEkIkkH5b62CnlMYBancTU7v0wYcM
	 zxpnc4Z1SR0f0aOrIEs67Xzl1r6xtpJBDScBtErhjkpJBAGc9ii5iuEAX1C0vDksHJ
	 0pPaAuPr4JhLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/9] perf evlist: Toggle merged_hybrid_group properly
 in enable/disable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916065248.3153556-6-irogers@google.com>
References: <20260916065248.3153556-1-irogers@google.com>
 <20260916065248.3153556-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 07:06:33 +0000
Message-Id: <20260916070634.4D84C1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: dead code in evlist enable/disable due to flag misundersta=
nding
--

commit a1c6041372bff09cc374228542c586fa596b3401
Author: Ian Rogers <irogers@google.com>

perf evlist: Toggle merged_hybrid_group properly in enable/disable

Merging makes the merged event the leader of the events of the other
core PMUs so their histograms can be linked, but the result isn't a
real event group. The commit treats an evsel with merged_hybrid_group
set as a leader so that it is enabled and disabled in its own right,
and updates the logic to avoid walking the members of a merged leader.

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 930efbb66bc8c..034032955d332 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
[ ... ]
> @@ -789,16 +796,21 @@ static void __evlist__disable(struct evlist *evlist=
, char *evsel_name, bool excl
>  	}
> =20
>  	evlist__for_each_entry(evlist, pos) {
> -		if (evsel__strcmp(pos, evsel_name))
> +		match =3D !evsel__strcmp(pos, evsel_name);
> +		if (!match && pos->merged_hybrid_group && evsel__leader(pos))
> +			match =3D !evsel__strcmp(evsel__leader(pos), evsel_name);
> +		if (!match)
>  			continue;
> -		if (!evsel__is_group_leader(pos) || !pos->core.fd)
> +		if ((!evsel__is_group_leader(pos) && !pos->merged_hybrid_group) || !po=
s->core.fd)
>  			continue;
>  		if (excl_dummy && evsel__is_dummy_event(pos))
>  			continue;
>  		pos->disabled =3D true;
> =20
> -		for_each_group_member(member, pos)
> -			member->disabled =3D true;
> +		if (!pos->merged_hybrid_group) {
> +			for_each_group_member(member, pos)
> +				member->disabled =3D true;
> +		}

[Severity: Medium]
Does this logic correctly prevent walking the members of a merged leader?

The commit message states "don't walk the members of a merged leader".
However, the merged_hybrid_group flag is only set on merged members, never =
on
the leader. When __evlist__disable() processes a merged leader,
pos->merged_hybrid_group is false, so this code will walk the members anywa=
y.

Conversely, when processing a merged member, the flag is true, skipping the
block. But since a member has no members of its own, the walk would have be=
en
empty anyway.

Does this check correctly match the intent, or should it be testing if the
current group leader is a merged leader instead?

>  	}
> =20
>  	/*
[ ... ]
> @@ -827,28 +839,37 @@ static void __evlist__enable(struct evlist *evlist,=
 char *evsel_name, bool excl_
[ ... ]
>  	evlist__for_each_entry(evlist, pos) {
> -		if (evsel__strcmp(pos, evsel_name))
> +		match =3D !evsel__strcmp(pos, evsel_name);
> +		if (!match && pos->merged_hybrid_group && evsel__leader(pos))
> +			match =3D !evsel__strcmp(evsel__leader(pos), evsel_name);
> +		if (!match)
>  			continue;
> -		if (!evsel__is_group_leader(pos) || !pos->core.fd)
> +		if ((!evsel__is_group_leader(pos) && !pos->merged_hybrid_group) || !po=
s->core.fd)
>  			continue;
>  		if (excl_dummy && evsel__is_dummy_event(pos))
>  			continue;
>  		pos->disabled =3D false;
> +		if (!pos->merged_hybrid_group) {
> +			for_each_group_member(member, pos)
> +				member->disabled =3D false;
> +		}

[Severity: Medium]
Does this code also suffer from the same flag misunderstanding in
__evlist__enable()?

If pos->merged_hybrid_group is only set on members, this check will similar=
ly
fail to prevent the merged leader from walking its members.

> =20
> -		for_each_group_member(member, pos)
> -			member->disabled =3D false;
>  	}
> =20
>  	/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916065248.3153=
556-1-irogers@google.com?part=3D5
