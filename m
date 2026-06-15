Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7654540E8D8
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543167; cv=none; b=PWlXxij5PCKZo9/Mmx2pOrAjKYp3ofsfmr53Pp6HmkPUq3irYujRSeCuzxoyz1QaXMpdk93MdlLTH2aj98H2kNzTGwQho3zv4HculylSVAQv2wANjXZT1iKpzQTrZUbe71oC6zRE15HjrqFwWtGq2jLQMrOSGhOi182wE+hMbvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543167; c=relaxed/simple;
	bh=IMvAOOZWYlzFdBNgq5cM/CJdUkKlILXVgpUw1RrxXBQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=REaAvFaXWkot6A6Sb64KVj9oYcYkVVoVd0DvX8Vg9GakjKv6ErHI/jfYarqTPaE1WPghqrrDZVLMY7YoeEUgAX+hWkp1TLkqhLZT9hOzGL3KRpCzJfEQxB/R42/9ojRbQMFn5b8SD1zXo999g058iE1wclq6WJua8T0XsbTWgxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgkzkItT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgkzkItT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9011F00A3A;
	Mon, 15 Jun 2026 17:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781543166;
	bh=mcBOVA4g1aInPBvRifvKroNErBP8TZmT+twVclKTWGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IgkzkItTuB54Ml/bVCCJobogj0gTh6LX+nU21zDmJtI1pmlR83yljZJtUtTzhuyZq
	 ZDbF4nozxOgz+9wm84Pr2WcCinHhxXnR2wrODuBOnW6wZwvZ8Pv3E4OIzRBV13/36C
	 BkB3f+QaSaCGU8Qjklv1nc0iBOAXU+IgmHWbEPkzvlW0y6pJxaxYzNMFs/zXpO5J5J
	 rSZe7ye9nK8TWddgWyt8j1Ow8gfS6IksTSMEpTdrsmgH0RFnFzgPRn5PSNvQRs/nSn
	 iRe+HWibZQuMc/uR8XwxsrpvoEE5h1YaHchzo9Zv6a0rHtiptc/M8mhTofEjb4GUKb
	 sraKGSgwJtRug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 04/20] perf data: Add open flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615165010.2724690-5-irogers@google.com>
References: <20260615165010.2724690-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 17:06:05 +0000
Message-Id: <20260615170605.EB9011F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] File rotation (`perf_data__switch`) is broken for directory mode, =
failing to rotate per-thread files and continuing to write to the archived =
directory.
--

commit b53fa235d65914b23c6c35938cbfa5872c128e34
Author: Ian Rogers <irogers@google.com>

perf data: Add open flag

Avoid double opens and ensure only open files are closed. This
addresses some issues with python integration where the data file
wants to be opened before being given to a session.

> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
[ ... ]
> @@ -457,6 +473,7 @@ int perf_data__switch(struct perf_data *data,
> =20
>  	if (!at_exit) {
>  		perf_data_file__close(&data->file);
> +		data->open =3D false;
>  		ret =3D perf_data__open(data);

[Severity: High]
This isn't a bug introduced by this patch, but does this logic break file
rotation for directory mode when using multiple threads?

If perf record --switch-output is used with parallel threads (--threads),
this block only closes the main header file via perf_data_file__close(). It
completely ignores the per-thread data files stored in data->dir.files and
doesn't invoke perf_data__close_dir().

As a result, wouldn't the file descriptors for the thread data remain open
and point to the newly renamed (archived) directory, causing threads to
continue writing their profiling data to the old directory instead of the
newly rotated one?

>  		if (ret < 0)
>  			goto out;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615165010.2724=
690-1-irogers@google.com?part=3D4
