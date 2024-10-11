Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077761CEE86
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 22:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728686351; cv=none; b=MA+ZN9VY2xuruv1LPTZe4sOWwMMUtPSgxEt3WJOyM9RUk8aOMrSmrMZRwrFPT/cVuIt8bmFLF5JeqN6JZTo/lkofQwKjnGFww0fFqxYO5g0aYRoftBriKJF6xUWGAcYMwOOPyObfxlhjsqIrsdd1wAGje4u2Ir50OlMoT60ICHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728686351; c=relaxed/simple;
	bh=eGXnfMjgVVO+tmSq1LvsdPOd4a4f/adlFS0cuK2fu5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0PlklNNmcemhhjGciHSgWHfB7zzPLQzZVOpUtDj6Qlfeu61o1bbHbEoqthwOwB3oEub9OgPEIZLNYn+MaznoZSJi7IUEVwYyLzqVrVZ0xluM61Tgtu0LDfcK2U+rvRETkVhPZLUJJ5YtBQJTb+3Z6LzmOST0N5upq/9UvlOb+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T8OOWQNy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T8OOWQNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C07C4CEC3;
	Fri, 11 Oct 2024 22:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728686350;
	bh=eGXnfMjgVVO+tmSq1LvsdPOd4a4f/adlFS0cuK2fu5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T8OOWQNyxlWtxi2yUfOdEyUMJOqDXywmgg19kmD0AJ8Qamt74Hi+n0UeD6qszJ3I/
	 SlGmY7hUUL63PcDxgO7N9b8mRHA5shHdLkaravUeBjOJgVafw7obDE2Zpg+jYj+EOj
	 savw8z7jYq0we9JOvefnb+yQIfCbpnUOM/AuDrZg=
Date: Fri, 11 Oct 2024 18:39:09 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Ian Rogers <irogers@google.com>
Cc: Yunseong Kim <yskelg@gmail.com>, linux-perf-users@vger.kernel.org
Subject: Re: Migrating from perf.wiki.kernel.org to RTD
Message-ID: <20241011-uncovered-original-vole-cda87d@meerkat>
References: <20241011-quiet-chowchow-of-temperance-d0e205@meerkat>
 <CAP-5=fUz5CFEL8D1L+UATsNqs4MBb6rNeYtZ26+pFC4NgRYt6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP-5=fUz5CFEL8D1L+UATsNqs4MBb6rNeYtZ26+pFC4NgRYt6w@mail.gmail.com>

On Fri, Oct 11, 2024 at 02:37:24PM GMT, Ian Rogers wrote:
> Hi Konstantin,
> 
> Yunseong created:
> https://perfwiki.github.io/main/

Oh, I wasn't aware of this effort. Would have saved me a good few hours. :)

> which looks superior to:
> https://git.kernel.org/pub/scm/docs/docsko/perf.git/
> as it is using markdown. Compare:
> https://git.kernel.org/pub/scm/docs/docsko/perf.git/tree/source/top_down_analysis.rst
> with:
> https://github.com/perfwiki/main/blob/main/docs/top-down-analysis.md

Well, this is just the github renderer. Github will happily render rst files
as well as markdown files. The reason I chose rst is because:

1. it's a better defined standard than markdown, which has as many flavours as
   there are forges, pretty much
2. the kernel already uses rst, so it's an easier switch for most kernel devs

> Perhaps the solution here is to make perf.wiki.kernel.org a redirect
> to https://perfwiki.github.io/main/

I'm happy to go either way, I just need the wiki to be gone. If this decision
is final, let me know and I will set the redirects.

-K
