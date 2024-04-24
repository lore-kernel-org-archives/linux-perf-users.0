Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D407915ECE0;
	Wed, 24 Apr 2024 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968533; cv=none; b=Ai9jQA35XlUwEFFWk5dBjgbavkMSxfsoa22InZkT7aV9c/VzivmUtkUv4W8XlpKmeJnFBxssTyGkSZ+jPD6KVAEglMGg8b+YT1ZpUjpIJTpKPy3XAcozR7WYxVD7AgeAONUeGSqtuxNjkIaF/rjlPb+cpwYmvaPLsEaYMStfTwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968533; c=relaxed/simple;
	bh=QZRJE5hVa7buLPtBvGZMtfK+GD2VOPSMNFvav2I9TOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjYz098R5lYuI1Fy05bP0DRgz2PtbY3VMg9UAwG7TjFeoTg0bE/AMmmVnC2VUf+XvyA5owDtLb6R1QyfNi/vytYVdUbc3OZlCaM00oyBsdxNgxhxt9S+zNgU68rHQTm7eE3T44UcRR51I3xqisXUu6RD4LIfwLMNHK8THMyRO90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8iHUpHq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8iHUpHq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E00C4AF0B;
	Wed, 24 Apr 2024 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713968533;
	bh=QZRJE5hVa7buLPtBvGZMtfK+GD2VOPSMNFvav2I9TOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e8iHUpHqJll+OXgjNeScGK2pnnmcVF2uMpeqF0Hamhjs47+NuXBy9cmyL2XOSvrX9
	 tjqeLFQ9SmeOjKwfvSo9bxqWAWe2tVThu1e8aG4G2LafzLf4IddmsSn02V3tzczZAg
	 4ycF0U9YFmWfpyJGInXlowcrsZWiLkS7Tknt3a5rm6vbm90geGr0xs8j8S3nqhhLDB
	 rhAR/AHAcBSZWnU980ttdlnnWuFrkRaUzPUxzu5+WJdjpVZ9fwYTwC0UtZwIbFWZpk
	 xeG9LEzSuggd6h4vZThEHmZqX92EEmOGayeO41WBPPrBA9a68VH8wZk753TWHf+buR
	 r7b0QA4WUqm2A==
Date: Wed, 24 Apr 2024 11:22:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Veronika Molnarova <vmolnaro@redhat.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Jiri Olsa <jolsa@kernel.org>, Kajol Jain <kjain@linux.ibm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf tests shell kprobes: Add missing description as
 used by 'perf test' output
Message-ID: <ZikVkavNI221xroG@x1>
References: <ZigRDKUGkcDqD-yW@x1>
 <CAP-5=fV0sX2V5+yjTymzDFXakxZxFxKvokCOqobOFgZHn6eVsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV0sX2V5+yjTymzDFXakxZxFxKvokCOqobOFgZHn6eVsw@mail.gmail.com>

On Tue, Apr 23, 2024 at 02:48:00PM -0700, Ian Rogers wrote:
> On Tue, Apr 23, 2024 at 12:50 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Before:
> >
> >   root@x1:~# perf test 76
> >    76: SPDX-License-Identifier: GPL-2.0                                : Ok
> >   root@x1:~#
> >
> > After:
> >
> >   root@x1:~# perf test 76
> >    76: Add 'perf probe's, list and remove them.                        : Ok
> >   root@x1:~#
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kajol Jain <kjain@linux.ibm.com>
> > Cc: Michael Petlan <mpetlan@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Veronika Molnarova <vmolnaro@redhat.com>
> > Link: https://lore.kernel.org/lkml/
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, added to the cset.

- Arnaldo
