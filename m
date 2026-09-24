Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EBA4BE445;
	Thu, 24 Sep 2026 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272360; cv=none; b=Ge7ZeZh/iItA8Ml5fxYy0FXmvKtgjltsdpWRUxDwYs1U4Z1zoCzhHJMeOpBCl1EexM6izpyhGelK1W6QpwEirvuqEn2Vf/drOX/umz3h6XFm1zQoqb+pDp8Z7jSzyzdmlxhiHyghIegN7h2BmVSQNqIeIiGlY27GlpZ/916UY1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272360; c=relaxed/simple;
	bh=i79k6U+L9XmNQXwPW5KS9Z6Gcg7+vpVg8bBwYfD4V3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq43BWg08oJp9XfcxWiPgCE94PlR/VJ5nT+vmyNhoePUvVfy2R45u544sPRZTkbD2uL+B9ldir+CvIgC36HztD80BGsGfiaDAo06YEFDRbnj1RyO6PIbhZToJ15QAS2VOFzMC5F2hsghYU3Q63ic3W1pYP+RlaSZdmPE059IJQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdeJWJra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdeJWJra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21411F000FF;
	Thu, 24 Sep 2026 17:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790272359;
	bh=OkINFXz6xU9yuLQmb4zwHMO7aBPdxp0jx9EEkqHt9EU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fdeJWJraazo3+tmMym7ePO7SizkG/sOfxnWmtT8TjIt/bkM76s0R9z9vaZ3Aq6jfY
	 +r69vLk04mNwATu/OP4nQLS8lbf+eVCQWZrkSz0nhcJIhwB8B0ToLfquWj6nGkNRQW
	 gpQwJQ3uuWOkKQKcjDecJSWg8MAcYPG2cyFpHH9idKSc4KnUu2QFBaNjZFzKgh2QTK
	 /e8/6jHkcF8dBMSO9mxqYop+N4iah5xUCcX6pFqoQ5xo04D/rmkcUvxAhXIa1nIEgd
	 r9BMBGdIg6/sg+7zqTKxjzxiKEJh4mZ/+ylL1FG8IA12QRMRl6llO1gx1Zmt7H/3rq
	 z3XwVAik2cPLQ==
Date: Thu, 24 Sep 2026 19:52:36 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: WANG Rui <wangrui@loongson.cn>, Jianping Liu <frankljpliu@gmail.com>,
	peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	wangming01@loongson.cn, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jianping Liu <frankjpliu@tencent.com>
Subject: Re: [PATCH v2] perf annotate: Fix NULL pointer dereference in
 loongarch_call__parse
Message-ID: <arVjZFD8-amR8qFm@x2>
References: <20260423103530.3938202-1-frankljpliu@gmail.com>
 <CAHirt9hJ5tTnWhYFZM6TvaTyDxGcRa=zeta8iv0DqqxgfKUQFA@mail.gmail.com>
 <CAP-5=fX37WjSviuitD8vintyY+EERwB-GMPpitarBqPFk49A3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX37WjSviuitD8vintyY+EERwB-GMPpitarBqPFk49A3Q@mail.gmail.com>

On Tue, Sep 15, 2026 at 03:47:38PM -0700, Ian Rogers wrote:
> On Mon, Apr 27, 2026 at 8:53 PM WANG Rui <wangrui@loongson.cn> wrote:
> > On Thu, Apr 23, 2026 at 6:35 PM Jianping Liu <frankljpliu@gmail.com> wrote:
> > > Rather than aborting parse with -1 (which would clear dl->ins.ops and
> > > lose the is_call attribute, preventing the TUI from drawing branch
> > > arrows and navigating the call), follow the same pattern as the generic
> > > call__parse() in util/disasm.c: when the symbol name is absent, jump to
> > > the address-based symbol lookup so that ops->target.sym can still be
> > > resolved via maps__find_ams() using the already-parsed target address.
> > > This preserves is_call semantics and keeps TUI navigation working.

> > > - Link to v1: https://lore.kernel.org/all/20260423053102.3717015-1-frankljpliu@gmail.com/

> > > Fixes: 4ca0d340ce20 ("perf annotate: Fix instruction association and parsing for LoongArch")
> > > Signed-off-by: Jianping Liu <frankjpliu@tencent.com>
> > > Reviewed-by: Ming Wang <wangming01@loongson.cn>

> > Tested-by: WANG Rui <wangrui@loongson.cn>
 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
