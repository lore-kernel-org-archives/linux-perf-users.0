Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F6D384231
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776055338; cv=none; b=QC4Ipy+eOYZKh1guUrTN0LpXZXEaI/3SKl+lNu3m5EN9pWSbgMpjFAsr9c8O/2qTHbS5+9PGowNuGzebYIxCPKr0D3rbrYZFdeaa3/L2KRoG+ummCvcx7vSXBAf8twyuQDTtUPH3yWaKPnm0bftPDFWFQRa3J6sEcE+P7pOjz60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776055338; c=relaxed/simple;
	bh=hfm7y3XvTQpnme1nrqEYkFSCy05ItGm6pduAsuCpFiU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Or8HPK9nK6jbQ7vRz7UeBZg31W7MkW1FqkvsxgrELRZXWSD1/j4SXwvYkcE+4UNVb7W2kOWxJgX1XBTD/9dEl6nTBQiO7oHc+JtE2K9i6kvF7r0O+L2v63st+XKNh/Jm/wwtmfqKkBYQHIRMs6mtmhcF2R3dQ7T7eOCk8Xa5/U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETTpllys; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETTpllys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1686C116C6;
	Mon, 13 Apr 2026 04:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776055337;
	bh=hfm7y3XvTQpnme1nrqEYkFSCy05ItGm6pduAsuCpFiU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ETTpllysLe9f8n1//B8tTfwRfk7Aq9LFY37htH7VcPjbsDn/4AH73apMa3inq7FWk
	 34Jli/SRwPC3pPxcnHlioTF0HbA5hBxLwAyqS+389k8hgdcosLXdWecOrn6QiFIGh4
	 G4mRZoiEiHs9IvGIZsQUOblSfbidczJPPXm2zqgqWV11KofV6a/6DfPbNOSdc+cim1
	 mCaWCgKYvhu1+edDE8ycwGzxaHxWEWfscSsKWP2OlxrMvxje4VvpTNBkANxKv6jUcp
	 IVNkgXfauScGnyjswQeSxCT+85i8U/iDyu91SQ3NLh9PnhUicWJ0vmxvZpdgLe01aU
	 Tnp5VkKaqbX8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 22/33] perf evsel: Don't pass evsel with sample
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413041143.1736055-23-irogers@google.com>
References: <20260413041143.1736055-23-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 04:42:17 +0000
Message-Id: <20260413044217.A1686C116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Integer Underflow and TOCTOU in `perf_evsel__parse_id_sample` Bo=
unds Check
--

commit 763d668507b0088255a55ce64fb44fde670bed7b
Author: Ian Rogers <irogers@google.com>

perf evsel: Don't pass evsel with sample

This commit arranges for the sample to contain the evsel, making it unneces=
sary
to pass the evsel separately. It also adds bound checks in
perf_evsel__parse_id_sample by switching to using an index and checking that
it doesn't become negative.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ee30e15af054c..bb48568b8101a 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3003,52 +3003,62 @@ int evsel__open_per_thread(struct evsel *evsel, s=
truct perf_thread_map *threads)
>  	return ret;
>  }
> =20
> -static int perf_evsel__parse_id_sample(const struct evsel *evsel,
> -				       const union perf_event *event,
> +static int perf_evsel__parse_id_sample(const union perf_event *event,
>  				       struct perf_sample *sample)
>  {
> +	const struct evsel *evsel =3D sample->evsel;
>  	u64 type =3D evsel->core.attr.sample_type;
>  	const __u64 *array =3D event->sample.array;
>  	bool swapped =3D evsel->needs_swap;
>  	union u64_swap u;
> -
> -	array +=3D ((event->header.size -
> -		   sizeof(event->header)) / sizeof(u64)) - 1;
> +	int i =3D ((event->header.size - sizeof(event->header)) / sizeof(u64)) =
- 1;

Does this calculation properly protect against underflow on 32-bit platform=
s?

Since sizeof(event->header) evaluates to an unsigned size_t, the subtraction
could underflow if event->header.size is less than 8.

On 32-bit platforms, this would result in a large positive integer (0x1FFFF=
FFE).
When assigned to the signed 32-bit int i, the value would remain positive,
bypassing the i < 0 check.

If a local attacker modifies the size field to 0 via a Time-of-Check to
Time-of-Use (TOCTOU) race condition when the file is mapped with MAP_SHARED,
could this regression still lead to an out-of-bounds array access?

> =20
>  	if (type & PERF_SAMPLE_IDENTIFIER) {
> -		sample->id =3D *array;
> -		array--;
> +		if (i < 0)
> +			return -EFAULT;
> +
> +		sample->id =3D array[i--];
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413041143.1736=
055-1-irogers@google.com?part=3D22
