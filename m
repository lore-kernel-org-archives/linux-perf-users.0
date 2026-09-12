Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD55E4582D8;
	Sat, 12 Sep 2026 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244398; cv=none; b=RB40+uMbcnCk3+3vq8zbJXzpBOaPIt6nH2wkXFYe1zRSCvaBh15z6jqWdW8tEe0dyH+uZRzQIwB+sLkfMJavfmeThohN6/MVmvMKQiWVa2jf+irC2RlBDeVWkoLoc1QwVSa9nK7J9T241+QfXNoPQErPiK+mYq3xDIOVHjQNdPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244398; c=relaxed/simple;
	bh=TDDviIxPePbD1vbCKoLwtFi8NWJtfKn/V93iaaI1HQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOWeL7CLVb427JrMsQkCC7dr858aSlN2HEgaP8EsklFhmZsfHnzKrDk0NrRUehyTtIuQhfL5MN1hwD32YhuFbj8eHDQrw3+pnC00Uk+HHYUrrXmLDVymi0crxT76y/NIK3BH2BlNfr2a08Hjv69N1C0j/acbhL7xy73niB/B3Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkQmIva5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkQmIva5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9524F1F00893;
	Sat, 12 Sep 2026 20:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789244395;
	bh=1T4QFQZeOWdnIpR2NWliG9gJ8mPsZ4w02tmAoDbkj5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gkQmIva5wlgJQYopZ/FWXALUevlvw6oAGHYhC/FE3zpJLRI4lCPUQ5ibZdQAzogEO
	 u0VI/eD3rTXJl6K8VC5Q8e3xe7m1E4GY4pB39Txj6XHTDtZurqrLAkPJKsH8jlmQ/I
	 K+F9E62WsnLyT+1lIQFi0k9bvQhQWy58l7Ra2NE9LEjRQOicw+pJ8mdjBAseLtYvA5
	 fCRvAaVcoHEtWMCqFA2fwSEXVm8v4g4T0xYcK21zyPFgn5HUm+ahFk1cuIzeniVquk
	 R/9SvUsGEyDYU+0fEfPpWf2bqIohrDxVrJf0YlLDUU7NNcvcsF9M5DIuyMqklKDNed
	 WUiz3KOFNEdYA==
Date: Sat, 12 Sep 2026 17:19:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] perf python: Fix ilist TreeNode string type drift
Message-ID: <aqWz6HTIzoMmnLP-@x2>
References: <20260910174420.3002597-1-irogers@google.com>
 <20260910175151.A0C8F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260910175151.A0C8F1F000FF@smtp.kernel.org>

On Thu, Sep 10, 2026 at 05:51:51PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The use of PEP 604 union type syntax `int | float` in function parameters breaks runtime compatibility with Python 3.9.
> --

Waiting for v2,

- Arnaldo
 
> commit 79e3c05b8663765b4c4ea91366e2819e32834d75
> Author: Ian Rogers <irogers@google.com>
> Subject: perf python: Fix ilist TreeNode string type drift
> 
> This commit updates Tree type hints across the perf python ilist module to
> prevent mypy strictness mismatches. It also addresses minor stylistic issues
> reported by mypy, pylint, and Sashiko.
> 
> > diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
> > --- a/tools/perf/python/ilist.py
> > +++ b/tools/perf/python/ilist.py
> [ ... ]
> > @@ -343,31 +343,34 @@ class IListApp(App):
> >          if not self.selected or not self.evlist:
> >              return
> >  
> > -        def update_count(cpu: int, count: int):
> > +        def update_count(cpu: int, count: int | float):
> 
> [Severity: Medium]
> Does this new type hint syntax break compatibility with Python 3.9?
> 
> Evaluating the PEP 604 union type syntax int | float as a function parameter
> annotation in Python 3.9 (without from __future__ import annotations) raises
> a TypeError at runtime. 
> 
> Since Python 3.9 is the minimum supported version for kernel auxiliary
> scripts, this will crash the perf userspace tool immediately on startup when
> IListApp.on_mount() calls update_counts(), which defines the update_count
> inner function.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260910174420.3002597-1-irogers@google.com?part=1
