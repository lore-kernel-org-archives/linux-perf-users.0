Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F24CBA42;
	Fri, 26 Jul 2024 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003249; cv=none; b=XOo/t4adRXPEmf/AcYRzBHf3KWmbyAjDwclXSUvvAJoNFD+ecGnhNklxfTJhvpy4x0CD9pSOChP1sGuhdbuHtXUnz8GURMdIZWYs+yXNAmonOOMeq53lPwWbreBv7GUiAaKsZrEisMvHoLf+JRA7shgT+KAnFNufaxdrKrXXgQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003249; c=relaxed/simple;
	bh=UD0Y5X0HmGg9Qa1BGCzeSnrqaz9RX9vb7SdG5vxKuvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSD5+qhCp82lVe9t2aqqU5ler+eOCSjzdfe22BRbt2q0h6X4jRofleNjMKv8vQjNlDmkldkK4cwIE+YeUJQSNvtZasgBNweSSwpdN2sXMyOqOXc533kda8e/K1Inabi+hwxz5kwpNiD8vwyTQc773PtLkrt+bvQ7eshK0tEb2wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCiASHnN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCiASHnN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847E8C4AF07;
	Fri, 26 Jul 2024 14:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722003248;
	bh=UD0Y5X0HmGg9Qa1BGCzeSnrqaz9RX9vb7SdG5vxKuvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCiASHnN8zmDLPLaD+cIqK7Bm1GExvIC/UYrHPz4Xc8OhJC+t3QzXI6iajY+RwIWV
	 Fq65ixy7TkGWGLOaFjNGpO4ItioOTOmFoldIPpLSzqE2NBNAyvHCt1FJ6XefaiIGMi
	 deGkOC2g6e6gKKU9mbKtCpcKMjxGJvVOybPRqDu8yXwYLxvCTA7axKwzQoOayFUBH1
	 TOVQlDmitgLMIx9WBjorRz6fa2Gg9LJ9sp017818JlWOHXN1O/ATM0kv3EQocIujVZ
	 AI05jzMIIklYoibUdMbG2E+oA9trS+JZGlPlGKhWu6V4oW2nfxi0m3brbDKjD0BUEr
	 jyRa8+QpqRE6w==
Date: Fri, 26 Jul 2024 11:14:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Chen Ni <nichen@iscas.ac.cn>, peterz@infradead.org, mingo@redhat.com,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf daemon: Convert comma to semicolon
Message-ID: <ZqOvLekXEZgu6Hqo@x1>
References: <20240716074340.968909-1-nichen@iscas.ac.cn>
 <CAP-5=fXn_0oudWiVgJ7pgi7GW65HrNOVaAg71c+JjfDnkK1cAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXn_0oudWiVgJ7pgi7GW65HrNOVaAg71c+JjfDnkK1cAw@mail.gmail.com>

On Tue, Jul 16, 2024 at 06:33:34AM -0700, Ian Rogers wrote:
> On Tue, Jul 16, 2024 at 12:46 AM Chen Ni <nichen@iscas.ac.cn> wrote:
> >
> > Replace a comma between expression statements by a semicolon.
> >
> > Fixes: 2d6914cd59ff ("perf daemon: Add 'signal' command")
> > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to tmp.perf-tools-next, and also removed the fixes tag.

- Arnaldo
 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/builtin-daemon.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> > index de76bbc50bfb..18f7f417ba11 100644
> > --- a/tools/perf/builtin-daemon.c
> > +++ b/tools/perf/builtin-daemon.c
> > @@ -1433,7 +1433,7 @@ static int __cmd_signal(struct daemon *daemon, struct option parent_options[],
> >         }
> >
> >         memset(&cmd, 0, sizeof(cmd));
> > -       cmd.signal.cmd = CMD_SIGNAL,
> > +       cmd.signal.cmd = CMD_SIGNAL;
> >         cmd.signal.sig = SIGUSR2;
> >         strncpy(cmd.signal.name, name, sizeof(cmd.signal.name) - 1);
> >
> > --
> > 2.25.1
> >
