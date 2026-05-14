Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D9C38F925
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779757; cv=none; b=e2MPYSemwVPxabBQWy46zmk1Lhi31yE6CufkWrjy38AOFasafq1+GCFvuY34WdYxi26cbzng2EZTe3v6ZAy371c/QoDcHDgABNbUF17LE1mQsrjd1FXRDWvCfXDuJ2ODGJxL7GhKijykcLMim+D31E7cTIREmizd/n1oo26tXzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779757; c=relaxed/simple;
	bh=seQA3Gv95WJ6nycxWNYSQccFSi3c3wuAv69Pw07/FtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HRGmhrwglDWoUgLlPQHCICK/MbJw5mZRA1CJZZvsxSmrN+MLcEE2CLjJZ744PLICuebiQwOcdl14rM+hUF0yl/zTfJlDuxo0QEUbP/aBrWkC/HQBeg1kxylGq30cRjgrcR+gnQGgCFpvXQHgHPOshT2Lnfil7qVjr5luTxavMno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AF4mMZg1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AF4mMZg1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07FAC2BCB7;
	Thu, 14 May 2026 17:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778779757;
	bh=seQA3Gv95WJ6nycxWNYSQccFSi3c3wuAv69Pw07/FtM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AF4mMZg1rEGAABD2Ad4C27jOh0+lZ6+F4gc8QTrQ35Ne4wdWwIwAcXnYwDwRSppu6
	 g7Homf48e9cWEMQUgDT8LqaqEtR5nA9T3NJoGqbi9MELPAb21T95bhZwhdHhKFQGSm
	 bmB4jinGWQZfAEJIZzI/HbXCiklVoa48htGSBBSb1QzmsAhVjkE+hZKN+DMoH8TV82
	 mY9WoJlzyHNpK4SbAb31PZWw2agGtkB0Dsa7jlR+AfTteUP1EjqDsMzqU5ALabcg+p
	 XBGn1LqqtoNlPEDOwRvxZoXvrTDd61Pv5sHOFK+8SqVJLTkRKnlBFgsziRf5JC6R68
	 /UwZJDLirq/oQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 12/32] perf inject: Don't pass evsel with sample
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260512223001.2952848-13-irogers@google.com>
References: <20260512223001.2952848-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 17:29:16 +0000
Message-Id: <20260514172916.E07FAC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Stack buffer overflow when appending ID samples to synthetic e=
vents containing long filenames.
--

commit 9f534ae0f7b23daf64c88ff86d355ff80529a67b
Author: Ian Rogers <irogers@google.com>

perf inject: Don't pass evsel with sample

This commit removes the redundant evsel parameter from injection paths since
it is already present in the sample structure. It refactors the synthetic
event functions to read the sample_type directly from sample->evsel.

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index 85bee747f4cd2..de812a2befbc7 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2252,13 +2252,15 @@ int perf_event__synthesize_build_id(const struct =
perf_tool *tool,
>  				    struct perf_sample *sample,
>  				    struct machine *machine,
>  				    perf_event__handler_t process,
> -				    const struct evsel *evsel,
>  				    __u16 misc,
>  				    const struct build_id *bid,
>  				    const char *filename)
>  {
>  	union perf_event ev;
>  	size_t len;
> +	u64 sample_type =3D sample->evsel ? sample->evsel->core.attr.sample_typ=
e : 0;
> +	void *array =3D &ev;
> +	int ret;
> =20
>  	len =3D sizeof(ev.build_id) + strlen(filename) + 1;
>  	len =3D PERF_ALIGN(len, sizeof(u64));

[ ... ]

>  	ev.build_id.header.size =3D len;
>  	strcpy(ev.build_id.filename, filename);
> =20
> -	if (evsel) {
> -		void *array =3D &ev;
> -		int ret;
> -
> -		array +=3D ev.header.size;
> -		ret =3D perf_event__synthesize_id_sample(array, evsel->core.attr.sampl=
e_type, sample);
> -		if (ret < 0)
> -			return ret;
> -
> -		if (ret & 7) {
> -			pr_err("Bad id sample size %d\n", ret);
> -			return -EINVAL;
> -		}
> +	array +=3D ev.header.size;
> +	ret =3D perf_event__synthesize_id_sample(array, sample_type, sample);

Does appending the ID sample here risk a stack buffer overflow if the
filename is long?

The ev variable is allocated on the stack as a union perf_event. Its
size is bounded by its largest member (which is struct perf_record_mmap2,
totaling around 4168 bytes).

If the filename approaches PATH_MAX, ev.header.size will approach
4168 bytes. Appending an ID sample via perf_event__synthesize_id_sample()
writes up to 48 bytes to the array, which is positioned at the end of the
event. Would this write past the end of the ev union and corrupt the
stack?

A similar situation seems to exist in
perf_event__synthesize_mmap2_build_id() as well.

There is a subsequent patch in the series titled "perf synthetic-events:
Bound check when synthesizing mmap2 and build_id events" that appears to
target this. Is this overflow what that patch is addressing?

> +	if (ret < 0)
> +		return ret;
> =20
> -		ev.header.size +=3D ret;
> +	if (ret & 7) {
> +		pr_err("Bad id sample size %d\n", ret);
> +		return -EINVAL;
>  	}
> =20
> +	ev.header.size +=3D ret;
>  	return process(tool, &ev, sample, machine);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512223001.2952=
848-1-irogers@google.com?part=3D12
