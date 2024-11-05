Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66252383;
	Tue,  5 Nov 2024 06:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787281; cv=none; b=mE/Pwt1SZIbWWs70PE1ZTmMaXP+lVJeYhHi292t6QlGj4IVgG582EgP/5Ib25cZj+lf5yNn2HFf99ShhDaIbBCWJb1ysbjJubitSQ1vAcxDpzJYMBoGnK1YKpt+G0kTjwNcnmxweRJbU0YBDdo66SqEB0Iqx/0s4vYpM12sKYYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787281; c=relaxed/simple;
	bh=agzzbpp7l8r9gGcWt4SGJOxi/C1Sf+mXADljyim46VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0yy1ZoZQKoBVAMt4bR2x8hTMhUawsyO76MonlBXuHcgl1kwi3xZtR5/AXyE0INcEU90/x9c0n4PRou4UYBaT17aqDQJmD5Ni6t+0enKScjv0+Gp1U82P4Ayf9vOC5A+S4iNRQxwXg5BX6w/mHcP6XH7f8u07Jr/rNdIQhi8cLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKJlsJok; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKJlsJok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B85CC4CECF;
	Tue,  5 Nov 2024 06:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730787280;
	bh=agzzbpp7l8r9gGcWt4SGJOxi/C1Sf+mXADljyim46VQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eKJlsJokCI5+XRBJmK2E4ik4ypZ52jwZWoVjsftqMn4OMgBFqZAw7w08YWhJNHBiP
	 xGzRnyKKnScXTJYX+gNUa953mywFaFERWfumWdhgGYOm9vuAcSvC9RGGpFSEWOEI+K
	 EZaqho7oz7/kWN9kxjGrKv+Iq0qBxoBjZRkMtaSAfPDO1xo6u0YERC+H5ugxbWpqTC
	 CqqSx/Tzg/Wgv5epAl0yYm98G/Gy27IohxdxIuMjvADfzJPftWpyGyHA8GSsjfiwa/
	 MpVL5Nt5WzeUJq9QbN4R+1ukrdyANhkMI4QYeN16Wuf8AaQEpaR9INzGSxD6FE4jNT
	 7SO1/r51m7QcQ==
Date: Mon, 4 Nov 2024 22:14:36 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 06/21] perf script: Move find_scripts to
 browser/scripts.c
Message-ID: <Zym3zLDMY2eBuXg5@google.com>
References: <Zykk2MJ4REGCaqVw@google.com>
 <CAP-5=fXQpej43wxEtMYFbxdofHtUi98X68W4AaR9UCfsbDir5A@mail.gmail.com>
 <ZykxD41c6gWQoIrQ@x1>
 <CAP-5=fWf8guTgqwfrrct3AGYDC=Lb1Oxo7kXU_x1yEr5urFSkQ@mail.gmail.com>
 <Zyk19KgzI7ybPkQ4@google.com>
 <CAP-5=fXj1-wqt+Bs-0ZypRsaZw2VP0qyKdeeRHpjUD5BwO9OBg@mail.gmail.com>
 <ZylGJF7Ux3JdJllo@google.com>
 <CAP-5=fUz_LSJ4v4aaAWoLMQRXAtsqeQSjcyRun2kBVXUHTzvUA@mail.gmail.com>
 <ZylXI4zj7Hs8Uvov@google.com>
 <CAP-5=fVK96t3-TKwqRQ1bfH2sOJHLhtVvDdJQ9U539Z1rd3kfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVK96t3-TKwqRQ1bfH2sOJHLhtVvDdJQ9U539Z1rd3kfg@mail.gmail.com>

On Mon, Nov 04, 2024 at 03:28:15PM -0800, Ian Rogers wrote:
> On Mon, Nov 4, 2024 at 3:22 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Nov 04, 2024 at 02:20:30PM -0800, Ian Rogers wrote:
> > > On Mon, Nov 4, 2024 at 2:09 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Mon, Nov 04, 2024 at 01:06:35PM -0800, Ian Rogers wrote:
> > > > > On Mon, Nov 4, 2024 at 1:00 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > >
> > > > > > On Mon, Nov 04, 2024 at 12:48:01PM -0800, Ian Rogers wrote:
> > > > > > > Namhyung was asking that the c&p of code be 1 patch then "add new
> > > > > > > changes like using openat() on top". That is:
> > > > > > >
> > > > > > > patch 1: add is_directory_at - introduce the 2 line helper function
> > > > > > > patch 2: move the code
> > > > > > > patch 3: update the code to use is_directory_at
> > > > > > >
> > > > > > > patch 2 is known broken as patch 3 is fixing it.
> > > > > > >
> > > > > > > Hopefully this is clear.
> > > > > >
> > > > > > Actually I don't care about the patch ordering.  My request is not
> > > > > > to break build and just to separate different changes out. :)
> > > > >
> > > > > So, patch 2 can't be separated from patch 3 - are we agreed? So we
> > > > > squash patch 2 with patch 3. Patch 1 is trivial and fails to meet the
> > > > > bar of a meaningful change, so we squash that. We end up with this
> > > > > patch. If there's a later revert and a dependence of the 2 liner, just
> > > > > don't revert that part of the change. We've never had such a revert so
> > > > > it is hard to see why we need to generate so much churn because of it.
> > > >
> > > > As I said the patch 1 should be the c&p and no need to introduce
> > > > is_directory_at() before that.  Why not doing
> > > >
> > > >  patch1: move the code
> > > >  patch2: add and use is_directory_at() + openat()
> > > >
> > > > ?
> > >
> > > Because placing all the code in 1 file expands GCC's analysis and the
> > > build fails. In the commit message I describe this:
> > > "The arrays are warned about potential buffer overflows by GCC now
> > > that all the code exists in a single C file."
> > > A standard unsound workaround to this is to change "sizeof(...)" to
> > > "sizeof(...) - 1", as it is ugly I added is_directory_at to not suffer
> > > the problem as the arrays are gone.
> >
> > Ok, it's strange that this type of analysis depends on the placement.
> > Anyway it seems there's a problem in the code already.  Then we can fix
> > it first and then move.  How about this?
> >
> >  patch1: add and use is_directory_at() + openat()
> >  patch2: move the code
> 
> I'm happy if the maintainers do that.

It's probably not gonna happen anytime soon and I'd be happy if you
could do that.

Thanks,
Namhyung

