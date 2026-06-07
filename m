Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3678F30FF36
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jun 2026 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780869159; cv=none; b=YBpPQrpoHU63GHz4itiofWi6XZf7OiQvEBzF0YXg2mVk3sNuaAp7MkscflTYQQypT38t1PHYSDJcpyDO9mX0dFbq5RuqvxUANfNMQ04KGbo+0jhyK3gyQnlBbJuG/CIh+K372rNLWQkWGSl+q81BoBQDXlcsRwYw1DoxpcysLsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780869159; c=relaxed/simple;
	bh=7OViPi3t6N89GELy4aT3dHCLbhGoBmbEkiDsJc0uXOE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RXBWgJgdayFbld4jxCxPb5i3cx2cSaaP4t+t9Ngzj0mJFyTFuoLu3aWu2UMY4DQYxPowV8VT4S+HjVQeKPeYMUjG+xU2XWnZIsFTPWBlIq5Ct5d7VFhwRvDrHnLvNR3wU6srivbm5fEo2Mih4a0H0JQ5ttVgOTBSOWoaE/Vs+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoPFLH75; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoPFLH75"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81E21F00893;
	Sun,  7 Jun 2026 21:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780869157;
	bh=0zjzmQTNq8MBeixKywao1JORthxc9Tima9MW7vlONDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aoPFLH75Sd1aHP+UPN3Qqb4vs8xd/OzNc5yYP32LdwaBT8IPSDSxu5Jcttgaw8udS
	 1H6PyguYwWHGhBytSRdlSopgAmFmqaN97lSWS/rm4lBtXZq6BJtUcjFMzA8wydA1iC
	 4H5KMp/W3AdTyQm6pxa7WAnH7Yh/1QoD007c8DuPIyTUEAnMeXoltUf6SfPhKY2Uyq
	 bEbZ55R9JAle5d/4MyOKOZbrYdM5XB/XJEeiNFwYnki/dJbJQNxG6fDLmHXhHaJRap
	 PL05AgfhHMaq1nxRVADXNTwFQVTedzj5SoS5PdCelhFKaKCpPa3+5A/fugxK/jsHan
	 CahRq5zqC/eBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 4/5] perf aslr: Strip sample registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260607213700.3563842-5-irogers@google.com>
References: <20260607213700.3563842-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 21:52:37 +0000
Message-Id: <20260607215237.B81E21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] aslr_tool__strip_attr_event corrupts the trailing ID array for eve=
nts with smaller ABIs by improperly verifying bounds via event->header.size=
 instead of event->attr.attr.size.
--

commit e1654455a52059659d22e581a3b84d7f361f3820
Author: Ian Rogers <irogers@google.com>
Subject: perf aslr: Strip sample registers

Extend the ASLR tool stripping helpers to drop register dump payloads
by masking out the relevant perf_event_attr fields (sample_regs_user,
sample_regs_intr) when the delegated tool is handling the data.

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> index 03944677ddfcc..912efd111bb3f 100644
> --- a/tools/perf/util/aslr.c
> +++ b/tools/perf/util/aslr.c
[ ... ]
> @@ -1108,43 +1188,30 @@ static int aslr_tool__process_auxtrace_error(cons=
t struct perf_tool *tool __mayb
>  	return 0;
>  }
> =20
> -
> -void aslr_tool__strip_attr_event(union perf_event *event, struct evlist =
**pevlist)
> +void aslr_tool__strip_attr_event(union perf_event *event, struct evlist =
*evlist)
>  {
> -	struct evsel *evsel;
> -	bool needs_swap =3D false;
> -
> -	if (pevlist && *pevlist) {
> -		evsel =3D evlist__last(*pevlist);
> -		if (evsel)
> -			needs_swap =3D evsel->needs_swap;
> -	}
> +	if (!evlist)
> +		return;
> =20
>  	if (event->header.size >=3D (offsetof(struct perf_record_header_attr,
>  					    attr.sample_type) + sizeof(u64))) {
> -		u64 st =3D event->attr.attr.sample_type;
> -
> -		if (needs_swap)
> -			st =3D bswap_64(st);
> -
> -		st &=3D ASLR_SUPPORTED_SAMPLE_TYPE;
> -
> -		if (needs_swap)
> -			st =3D bswap_64(st);
> -
> -		event->attr.attr.sample_type =3D st;
> +		event->attr.attr.sample_type &=3D ASLR_SUPPORTED_SAMPLE_TYPE;
> +
> +		if (event->header.size >=3D
> +		    (offsetof(struct perf_record_header_attr, attr.sample_regs_user) +=
 sizeof(u64)))
> +			event->attr.attr.sample_regs_user =3D 0;
> +		if (event->header.size >=3D
> +		    (offsetof(struct perf_record_header_attr, attr.sample_regs_intr) +=
 sizeof(u64)))
> +			event->attr.attr.sample_regs_intr =3D 0;

[Severity: High]
Can this corrupt the trailing ID array for events with smaller ABIs?

Since event->header.size represents the total size of the record, it includ=
es
both the attr payload and the dynamically appended array of u64 IDs.

If an older perf.data file uses an ABI where attr.size is smaller than the
offset of sample_regs_user (such as ABI 0) but contains multiple appended I=
Ds,
event->header.size will still easily exceed this offset check.

In this scenario, writing 0 to event->attr.attr.sample_regs_user would write
past the end of the actual attr struct and silently overwrite the trailing
ID array, causing downstream tools to fail to match events to their IDs.

Should this bounds verification check against event->attr.attr.size (falling
back to PERF_ATTR_SIZE_VER0 if zero) instead of event->header.size?

>  	}
> =20
>  	if (event->header.size >=3D (offsetof(struct perf_record_header_attr,
>  					    attr.type) + sizeof(u32))) {
>  		u32 type =3D event->attr.attr.type;
> =20
> -		if (needs_swap)
> -			type =3D bswap_32(type);
> -
>  		if (type =3D=3D PERF_TYPE_BREAKPOINT &&

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607213700.3563=
842-1-irogers@google.com?part=3D4
