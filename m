Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC245348477
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790451026; cv=none; b=EZrKIsGtMDhB6vYwiuvBZ0r9Q/g7obVwWZ/5mVQHrq4+mB7vi9MTsFmnCedb38GWmLpRG3QLJrqbgaNYnTjJ0U1UW/2FG5UkwCbgEK+QbgqNtcUNEkwMAQOl4UIHFqaJ9AP0cwsl5XlPfjbglOgpEjWfjLasX+3diPRpwupMXUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790451026; c=relaxed/simple;
	bh=ivjZNK/h95IUe1kieGMnBWi+NWFNBUcQdjxHjweCo+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiD2jrqA8DJY9m3DtnoR7bdrCHru7XjfkY/2ncYgDOSOb1j2PAK/odAdefoMUGW57bdY0u7wouO2cnjoq9Tok194vtPFwR13j7lo0OuNDwYmazxlCmjB61gC0yQBZCLYGNnjvc+muSQrwrXhYWahA4N1Fje8RnNV0ATqy63u8Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goIU/8+Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goIU/8+Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0B61F000FF;
	Sat, 26 Sep 2026 19:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790451024;
	bh=hPc+CGb73PQqgfLKOqa2Hm6rin58yMUwdmvb5+7mw1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=goIU/8+QcGeaEwj/+yE+Um1kHJkoT1Qe7QK2Mjyo8b1cOp3clIHjK6n6MhzjpP96w
	 za9gKF9S+3iE+5UwmsiejCemfmnjiVsIIJEsD0VFfv3/u3gyxqr6jsrbLmXMuEp4dp
	 KOMyjAe0v2I5pYYmn4OA0jkkkeeYWYqszo4GjlQTdyJv6eLH2Q5dBp/JylNfGLv0i7
	 RfVYP9So2k0Av1JZkpgZsU4PjulhiitC8C/LNazObrs0h2MKV/My+a/aiROnBcmev/
	 GFKxYJqQusGkfrnj32tjmd/DoZQ2UmYikIRt//xrRfAtwfsClEkKW1NTFJa0IuVxJR
	 vkgzDdwnCx1Rg==
Date: Sat, 26 Sep 2026 21:30:20 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf tools: Bump the minimum Python version to 3.9
Message-ID: <argdTItioePE5fKT@x2>
References: <arb9OMEQ8HCcw-9O@x2>
 <CAP-5=fX6+M8fKmSTzCy5HufEQf422h0vavTTb_RX3HYRYo8nfw@mail.gmail.com>
 <ard5fVHYXTckW18b@localhost>
 <CAP-5=fVn0gmD1EVkqEcqGfqnPtbHMFAmYXNs00RMUB_k5nNUYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVn0gmD1EVkqEcqGfqnPtbHMFAmYXNs00RMUB_k5nNUYA@mail.gmail.com>

On Sat, Sep 26, 2026 at 08:00:35AM -0700, Ian Rogers wrote:
> On Sat, Sep 26, 2026 at 12:51 AM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > On Fri, Sep 25, 2026 at 05:22:58PM -0700, Ian Rogers wrote:
> > > On Fri, Sep 25, 2026 at 4:01 PM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > > perf's build only refused interpreters older than 3.6, the check added
> > > > when jevents.py started using f-strings, and jevents.py carried a
> > > > removesuffix() shim to stay usable on them.
> >
> > > > Suggested-by: Ian Rogers <irogers@google.com>
> > > > Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > Assisted-by: LLM
> > > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > Hi,
> >
> >    I addressed a sashiko comment avoir the python binding in v2, does
> > your reviewed-by stands for v2 as well? Mauro?
> 
> Mine, yes. Thanks,
> Ian

Mauro, I'm keeping yours as well, as the change in v2 was just to disable
something else that requires python 3.9 when it is not present, so more of the same.

- Arnaldo
