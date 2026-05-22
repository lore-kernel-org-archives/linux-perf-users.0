Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF0538332F
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779481539; cv=none; b=mTAwQ62OIdtgqc15e5fcoEDMxmtibJu2LfRu/UFKVCF7Xg+uE77aXn5Pbs1IpFKwGcoMNDNPGCB4+MbKfQZxxJqjv3fnAXAIoKX9rnqW+rh87u8Du9PUtesW3xFAsE4ZHyJFvM46i75UzENZwfRqNOFG6l9kc5vB6JjIk3hme28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779481539; c=relaxed/simple;
	bh=dKRTWRvNlh0qKWxccwkhAGNuVWUXKHGnUq76tzCwTO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkxXmfZqPDkp2DLfyJ1xQ82EaV5APBdvGZOQ1KuvfrU5Qzckx55UiqZFKaGhl2Ce4pX4KzgnXX5R67bpzeaEItbX6sKyqcmGO1bq7N2NXjxIlsHB5aLNB/UrrQjO9W3DFqQtLrXfbGapdMywKSOdptEqcq8AL2Zporj5Fo5TH6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJj88RQq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJj88RQq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DB41F000E9;
	Fri, 22 May 2026 20:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779481538;
	bh=9nxHL+dpNVPGZUBDBUXFYl6vXx4fl3HBF7JiuHj9ZWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RJj88RQqzPirVnVxS3pf4WWqxnE4otculxLw+I0GxbKuZwQWMI9P3s8EFadeXpTua
	 QHQF6QlqG3lo+JMA7LaesTbISbkZYHNgVk1PZY4RJrpExzL0dz6qfQFUZPGyl06sTa
	 pQRTrvucbuZA8tKg4T/IwjqUfDRoEW2GwIBXMxU8VKxTD1S74o7qB3op/n6waNmhbi
	 2xmIzPXluaBqXJdCmv2irv/jpr8un4bA1PO7vGA2hYpetiSfF8ZwNSJq1VRmRZLPXs
	 8P0AACQySY68B0T7fCLy4I2fwZlEG+vjkx5AIA6TkB3taMPJHTIl3QAtJRnd3OPRH7
	 6tBeb+RJFfWVA==
Date: Fri, 22 May 2026 17:25:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Andi Kleen <ak@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf stat: Make metric only column line up with header
Message-ID: <ahC7vhJiLN6C8EQx@x1>
References: <20260513144906.557896-1-ak@linux.intel.com>
 <CAP-5=fXhi9W-T1BLJVvQ4DRN6EpxtZQduev0fVXNJTmrF6idSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXhi9W-T1BLJVvQ4DRN6EpxtZQduev0fVXNJTmrF6idSw@mail.gmail.com>

On Wed, May 13, 2026 at 09:23:38AM -0700, Ian Rogers wrote:
> On Wed, May 13, 2026 at 7:55 AM Andi Kleen <ak@linux.intel.com> wrote:
> > Before:

> > % perf stat --topdown -a -I 1000
> > +           time %  tma_backend_bound %  tma_frontend_bound %  tma_bad_speculation      %  tma_retiring
> >      1.000190386                                         45.5                   40.0                     5.3                     9.2
> >      2.005185654                                         45.3                   40.1                     5.6                     9.0
> >      3.009193207                                         45.4                   39.9                     5.6                     9.1

> > After:

> > % perf stat --topdown -a -I 1000
> > +          time %  tma_backend_bound %  tma_frontend_bound %  tma_bad_speculation      %  tma_retiring
> >      1.000810024                 46.3                 39.7                   5.3                 8.7
> >      2.004800656                 45.8                 39.8                   5.4                 8.9
> >      3.008804783                 46.0                 39.6                   5.4                 9.0

> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.2.
 
> I dislike the spaghetti code in stat-display.c :-) One day it would be
> great to throw an LLM at doing a clean implementation. Having tests
> for formatting would be useful :-)

:-)

- Arnaldo
