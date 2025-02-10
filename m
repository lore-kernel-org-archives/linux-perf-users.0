Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295F21C2DA2;
	Mon, 10 Feb 2025 22:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739227998; cv=none; b=CmSinVPlG1t5IwH9Jl0mG5naIiLNHZNBB7Fki9jCFUPooIQeB29hseWgPfP0rHJEnCNsUEHQ85PFEbnddiVojR5ai6mWAduS1FnN75wo5PBEsvck6q6vjNWqFu6WxUHRDeZuHx2sU3lvR5K9r0VsQ9TWoOmA7q4NNZzU+HbNyKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739227998; c=relaxed/simple;
	bh=Ti5D3L7xPBlXSUbXtfzn95u+P4NW+jleJ2mO4P9rbb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuWTAyLDioRdL9kx/oaH0MnLCOlKNgN9Qa8+fq2LZV7cMJuJLVNcf22UmFysqxyuHxSb3XT4J5xuzR/jiY5Ko1nCCXqvC3XNR4ahiJdsfuKCXXeaX86b4O4agJctTQ0VLsFireE1xMVSTeqFIJDKf+XQmeiyIt1qtAoLM/G5Lbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3jzJBsS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3jzJBsS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EBDC4CED1;
	Mon, 10 Feb 2025 22:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739227997;
	bh=Ti5D3L7xPBlXSUbXtfzn95u+P4NW+jleJ2mO4P9rbb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o3jzJBsSQAImlJJSLT2Drw97OvB16ck4/Bg9z6z8KkRCNxgIkGyhEpCKZ0e68jchE
	 2mWHC0eQbw4Y8VZ4HdSsBcaq5B9n3h4kZXKU42+HeE6vzPDIY3bCmWhd6NCAJvee97
	 swn4wYRWmCAmGp2M17uApYdlFND7N+1eUkHK/gpFDG9t57DFp3RwAdiYmkUVO3h9SU
	 IJ3vO+a0rUi2PWfM1eoLQYVkKTS+2IUeEqfGFmmus3hsydmkbEvXVT5iHJkGKgJd8r
	 DO4yK+QV+LQX5FNTpLtlbbFo1SRumk1is35JuorXb68bKbXPC27mdCshMFItIZbp8V
	 7HbJ7Mnqpf5Ag==
Date: Mon, 10 Feb 2025 14:53:16 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, irogers@google.com
Subject: Re: [PATCH] perf report: Fix input reload/switch functionality
Message-ID: <Z6qDXAjJBISQmvGA@google.com>
References: <20250108063628.215577-1-dvyukov@google.com>
 <384d6c4b-d2ce-47f8-9030-6225758b5923@linaro.org>
 <CACT4Y+bUrZHD5H+z5-+dKGbtBPO9EQNzBoOwYGhp7zHGrHYrQg@mail.gmail.com>
 <89e678bc-f0af-4929-a8a6-a2666f1294a4@linaro.org>
 <CACT4Y+ayg0oo0sX54DuJ9n+L4MJJU5LsEJtEDS13Zu7ifOyq3g@mail.gmail.com>
 <20d97acb-bcf8-481e-a898-a13580c566b0@linaro.org>
 <CACT4Y+b8X7PnUwQtuU2QXSqumNDbN8pWDm8EX+wnvgNAKbW0xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+b8X7PnUwQtuU2QXSqumNDbN8pWDm8EX+wnvgNAKbW0xw@mail.gmail.com>

Hello,

On Mon, Jan 13, 2025 at 04:39:57PM +0100, Dmitry Vyukov wrote:
> On Mon, 13 Jan 2025 at 16:19, James Clark <james.clark@linaro.org> wrote:
> >
> > On 10/01/2025 12:19 pm, Dmitry Vyukov wrote:
> > > On Thu, 9 Jan 2025 at 15:50, James Clark <james.clark@linaro.org> wrote:
> > >> On 08/01/2025 3:35 pm, Dmitry Vyukov wrote:
> > >>> On Wed, 8 Jan 2025 at 16:23, James Clark <james.clark@linaro.org> wrote:
> > >>>>
> > >>>> On 08/01/2025 6:36 am, Dmitry Vyukov wrote:
> > >>>>> Currently the code checks that there is no "ipc" in the sort order
> > >>>>> and add an ipc string. This will always error out on the second pass
> > >>>>> after input reload/switch, since the sort order already contains "ipc".
> > >>>>> Do the ipc check/fixup only on the first pass.
> > >>>>>
> > >>>>
> > >>>> Hi Dmitry,
> > >>>>
> > >>>> A reproducer with before and after behavior might be helpful for the review.
> > >>>>
> > >>>> It might be unrelated to your change here, but the input switch thing
> > >>>> didn't seem to do anything for me. If I record two files, open the first
> > >>>> one, press S and select the second file nothing seems to change. I
> > >>>> assumed it would show the other file but nothing changes?
> > >>>>
> > >>>>     $ perf record -- true
> > >>>>     $ perf record -o 2.data -- ls
> > >>>>     $ perf report
> > >>>>     S key
> > >>>>     load 2.data
> > >>>
> > >>> Yes, sure. This needs "--sort symbol":
> > >>>
> > >>> perf report --sort symbol
> > >>>
> > >>> then press 's', select file, and it terminates.
> > >>>
> > >>> Affects fewer cases then I initially assumed, since I happened to run
> > >>> with "--sort symbol" when I discovered it.
> > >>>
> > >>>
> > >>
> > >> Ah yeah I can reproduce the bug with --sort, which is fixed by the
> > >> patch. But 's' doesn't actually reload a new histogram for me, I just
> > >> get the original file again. Maybe I'm misunderstanding what 's' is
> > >> supposed to do?
> > >
> > > As far as I understand, 's' allows you to select and load a new
> > > profile w/o existing (fwiw, if you select a different file). If the
> >
> > By 'without existing' do you mean running perf report with no perf.data
> > file? It won't run like that it just says "failed to open perf.data"
> >
> > > file has changed, I guess you can also reload it and see the changes.
> > >
> >
> > I wasn't able to make that work. How do you reload? If I change screen
> > between different events I still get the old file and I didn't see
> > 'reload' mentioned in the keybinding popup.
> >
> > I suppose my point is maybe it's not worth fixing the sort order bug if
> > we can just remove input file switching. The behavior doesn't seem any
> > different to v5.8 in case its a regression. Maybe I'm just doing
> > something wrong though.
> 
> 
> Humm... indeed, it does not seem to actually reload anything (even
> though the "Processing events..." progress bar progresses again).
> 
> I tried to use the reloading feature while implementing:
> 
> perf report: Add wall-clock and parallelism profiling
> https://lore.kernel.org/linux-perf-users/20250113134022.2545894-1-dvyukov@google.com/
> 
> to change some of the flags that can't be changed otherwise, but then
> dropped this idea since it was too messy, but decided to fix the
> failure I discovered.
> 
> So, yes, I guess we can drop this patch (I don't need it anymore).

Sorry for the long delay but I think we need this fix anyway.  I'll take
a look at the reload issue later.

Thanks,
Namhyung

