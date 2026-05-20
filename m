Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E0426E173
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779318014; cv=none; b=rY5cgF8RFhk13ppkIb6OaRcLCqJgWiIb8KONyvpvoSxjqdTG2Q9xn+rQqhPQZlAG9qEg/v+9lS0Sl7eMQ+LCCaAJ+FDBL9IjQq8W0TLNaMVTYoP0VwoeD7DKi0ciDe8InP6uejn7ihb8s0pNPnuKGokrUgknbweVVVTVZ4LMmfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779318014; c=relaxed/simple;
	bh=f8czHysdd41mFeqJe5uJq6hM8CEP7Rxltw+PJrDvb5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoRdQdRYwFNSBjTWm/GScdbY1kANyvwAZqiDinLGLokMKv8jkJeeLmW1TvrnqXW0WCuR/U5A04LnMdZX4l98YjFU/58zN9tJbViGiammovWYmHCn9oVf2wx9Ajhlcy3JwpzDV5qVYpHcKtuhUhZbRWQ413c76l4xF/dkOjGQjlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQxw+nK4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQxw+nK4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCF21F000E9;
	Wed, 20 May 2026 23:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779318013;
	bh=nr8DBP/yN+bpH4VchYij/D3mXNYrXPoF6SoTt6Io+tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KQxw+nK4qw7+DHR6o4fUMjgD7Ye0scz9xYwcFtcplc5JSNpRlUZt+m/x+c7AnjZiu
	 wnvhC0xDbbuAZkBqVDRS9NALdF4ldeYjow8Qk+Jrsxgp3XrT9QgDHqcpI9Zdlo7RBc
	 186+11hRuel2ItBvolSD0EKkn9H2Qg1QNxf3XB7yS1cuaYiguPmE6xzYJPBdLyrcX4
	 zBR3JII2knZrubM1ozNLwrMCIaZOd3MMO5FXAk5xJAIKTUYivIYMPKWX8L7xHFCM7e
	 yFHicfCyXvKAB7NDczLD3viJZMcBZuvsgNaHjkdp6PhSKGLeq5fNJiJNlTmCB1XUC9
	 KJQ5rLXy7euMw==
Date: Wed, 20 May 2026 16:00:11 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Michael Petlan <mpetlan@redhat.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf build-id: Fix off-by-one bug when printing
 kernel/module build-id
Message-ID: <ag48-3abXn7ZGSSW@google.com>
References: <20260519223855.191637-1-mpetlan@redhat.com>
 <CAP-5=fV=ouJST+4Aww9gHBLSyag0mZsXM+HWYGLQNd1T3oH0Rg@mail.gmail.com>
 <ag4CoMSo8MMLoeTM@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ag4CoMSo8MMLoeTM@x1>

On Wed, May 20, 2026 at 03:51:12PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, May 20, 2026 at 08:55:51AM -0700, Ian Rogers wrote:
> > On Tue, May 19, 2026 at 3:39 PM Michael Petlan <mpetlan@redhat.com> wrote:
> > >
> > > When changing sprintf functions to snprintf, one byte got lost. Since
> > > snprintf ones do not handle the '\0' terminating character, the number
> > > of printed characters is 40, while sizeof(sbuild_id) is 41, including
> > > the terminating '\0' character. This makes the later check fail so that
> > > nothing is printed.
> > >
> > > Fix that.
> > >
> > > Before:
> > >     [Michael@Carbon ~]$ perf buildid-list -k
> > >     [Michael@Carbon ~]$
> > >
> > > After:
> > >     [Michael@Carbon ~]$ perf buildid-list -k
> > >     a527806324d543c4bc3ff2f9c9519d494fed5f68
> > >     [Michael@Carbon ~]$
> > >
> > > Fixes: fccaaf6fbbc5 ("perf build-id: Change sprintf functions to snprintf")
> > >
> > > Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> > 
> > Tested-by: Ian Rogers <irogers@google.com>
> > also Sashiko is green for this patch:
> > https://sashiko.dev/#/patchset/20260519223855.191637-1-mpetlan%40redhat.com
> 
> Thanks, applied to perf-tools-next, for v7.2.

I sent out this a month ago, but forgot to ping for inclusion.

https://lore.kernel.org/linux-perf-users/20260420180858.129075-1-namhyung@kernel.org/

Anyway, I'm ok with fixing it either way.

Thanks,
Namhyung

