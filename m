Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06853254B8;
	Mon, 14 Sep 2026 06:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789368424; cv=none; b=iHCVEXOBUCHMCWSywX+tiLcc90EeUr+MgdSXFy+r8gwOhO1odxx2fze64x8BManJtGjuM5ICJAnbyD9jsDqObBZE23PRAmUndYPuYcVuTfWp6VrwwS2PWnw2JZdKp48kvMSopg0pNwLLbNvjwoofmVtd4316+EPWFp36NGp9gRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789368424; c=relaxed/simple;
	bh=GsM2sKVClOmdLocloEDcVfy6zdabm6ArlTrzAiz4mKA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=A7pD2zSjL7uFNRt9fzTy1CTz0kGmI2mlOZvvMZP5tPAIAYGfno8d/CZ/D4mT6kpZx3chdc4kNrlQzkpwXq1BbiKIfb80o3oNGA0pOQvtPlsgD38CTTyqH6Lk4r1r33Xqj/Ve4ysPbm7ixJXrSqdH6DnQu/LO1iscAt2Jf79hFc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb+bdOGf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb+bdOGf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F50B1F000FF;
	Mon, 14 Sep 2026 06:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789368422;
	bh=AGecsELHer1cwJ6XhKKoT8iLLK8IskJV9xUG9sEWX6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Tb+bdOGfgaW+kYxO4dCyOy08/XLmQC2um9WyLgG34hfCitDt3Vrw9twzwQZj2Nyfb
	 o4NxxongO/MZb+wRkJBIJzjN6sibrQk5ex5+Q/pCt7aaeyRs20cqU6OF1Jvpy4Rtn/
	 s1dcxW7hHIBBu5fOGp4hpidHJFA5RNq9ubPIgIMPWKcuWUrojO03tqqq6j91ODtjxO
	 WDdN+SBdvxeFxdDW2cZNjsfn1wfQu5Y8EvQ9bGVyi1Z3ZjKPu00V8k/CJHUrJLcfGz
	 DZDl04O8nCet/m0O5VSbJJ9UYl2uGc9cDOmLqGTlOQ3lb7srVSC0NIMyIX12AU9+aO
	 5HywGIo3SD18A==
Date: Mon, 14 Sep 2026 15:46:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v15 09/12] tracing/wprobe: Add set_wprobe and
 clear_wprobe event triggers
Message-Id: <20260914154658.a43ec4fc877c9fa873d0550a@kernel.org>
In-Reply-To: <20260907041036.DA9C41F00A3A@smtp.kernel.org>
References: <178875277830.93794.14247844688761142429.stgit@devnote2>
	<178875287944.93794.8914114071047199197.stgit@devnote2>
	<20260907041036.DA9C41F00A3A@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Sep 2026 04:10:36 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] clear_wprobe incorrectly rejects legitimate fields starting with "unlimited"
> --
> 
> commit f87f4797ae7a52cd2de4840afea59fb8bb8bbaf6
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> tracing/wprobe: Add set_wprobe and clear_wprobe event triggers
> 
> This commit adds the set_wprobe and clear_wprobe event triggers to dynamically
> attach and detach hardware breakpoint address monitoring based on event field
> contents.
> 
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.1785067572.git.wangjinchao600@gmail.com/
> 
> > diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> > --- a/kernel/trace/trace_wprobe.c
> > +++ b/kernel/trace/trace_wprobe.c
> 
> [ ... ]
> 
> > +static int wprobe_trigger_cmd_parse(struct event_command *cmd_ops,
> > +				    struct trace_event_file *file,
> > +				    char *glob, char *cmd,
> > +				    char *param_and_filter)
> > +{
> 
> [ ... ]
> 
> > +	/* clear_wprobe does not need field, but can have optional field. */
> > +	if (!clear) {
> 
> [ ... ]
> 
> > +	} else if (param && (isalpha(param[0]) || param[0] == '_')) {
> > +		if (strncmp(param, "count=", 6) != 0 &&
> > +		    strncmp(param, "unlimited", 9) != 0) {
> [Severity: Medium]
> Will this substring comparison mistakenly intercept legitimate C-identifier
> field names that start with "unlimited"?

Ah, yes. I understand it. Maybe we can use strcmp(param, "unlimited") so that
it will pass the field name that starts with "unlimited".

> 
> If a user passes a legitimate event field name like "unlimited_size" to
> clear_wprobe, the strncmp(param, "unlimited", 9) != 0 check will evaluate
> to false. The parsing logic in wprobe_trigger_cmd_parse() will mistakenly
> assume it is a count parameter, skip the field parsing, and pass the string
> to event_trigger_parse_num().
> 
> Since event_trigger_parse_num() attempts to parse "unlimited_size" using
> kstrtoul(), it will fail and return -EINVAL. Could this prevent users from
> using clear_wprobe on any valid field beginning with "unlimited"?

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
