Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D701CC177;
	Mon,  4 Nov 2024 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752787; cv=none; b=i/QilvK79v/lYGecZUguQzGE9WFsmzpcgx49bJ5H1sY2pi8IGo6BRwOONHHkFhgju3FM2hXEixy8ONPA/JExtRFlfgn2MDtHffeLZ42yGipavhBfhwP+6nx1IyhVydQBzU+YExHzE8pc0Qhp+Kjtc3MCk5UB/h5YnNk8SaoveKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752787; c=relaxed/simple;
	bh=6gM3XdRQr6llsKWLWiuYpygeRwrLp4MTLa4RKpQrBQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8PAZRLPVIeNVo6+03sfAEtteFkoJ7k3lgFoubV7Va70RrM+lgCtuSMq+suJYavnbSp6KgM1ES6y+11uZInC+zIPlqz0s7HRfhzy/tW9FF9aEEcU59T59ZwNyONf8go3WodCK1gvJTyM/ZLpL3GRp8/+iU+E1eLd4B1qRVMonbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T92t7NCR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T92t7NCR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865DAC4CECE;
	Mon,  4 Nov 2024 20:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730752787;
	bh=6gM3XdRQr6llsKWLWiuYpygeRwrLp4MTLa4RKpQrBQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T92t7NCRMFhKtWKChKzEmx1s8v8rdBkQgoXX0mmvN+Y+f6cQcpexUrWoh9nvUWs5f
	 Me6t5KL3z2EQmLfaSTjhShB5PKGYV8jUwwjv+LMUvXkjZIThVoiWO4Vzuix8YErrdU
	 TPWCqrx2NSLLG5T3E4meqvnyrleETZke5glgRovg5xW9gsX4BYEmqKwWn2ZHSAvrQX
	 JqqnQQw0CUt3FTrnL07rT2kbHv3omnfnKJ9LSv2cKKoGWyk1zwslo/hgrSoMXwuKm+
	 i5a2oIxl6AgLcFYF0ei02VHgV8GFc26SmKz2bKNUElCgRTjzrPzK75Ii27d6IC6ENI
	 q2U+Hvrqwh34A==
Date: Mon, 4 Nov 2024 17:39:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
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
Message-ID: <ZykxD41c6gWQoIrQ@x1>
References: <20241031014252.753588-1-irogers@google.com>
 <20241031014252.753588-7-irogers@google.com>
 <ZyPX7ayIO4teziDX@x1>
 <CAP-5=fVgJu8BJWFVUkCy1Zsi3piTPdV-GXL1bTpWZeO=nm=jrg@mail.gmail.com>
 <Zykk2MJ4REGCaqVw@google.com>
 <CAP-5=fXQpej43wxEtMYFbxdofHtUi98X68W4AaR9UCfsbDir5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXQpej43wxEtMYFbxdofHtUi98X68W4AaR9UCfsbDir5A@mail.gmail.com>

On Mon, Nov 04, 2024 at 12:34:47PM -0800, Ian Rogers wrote:
> On Mon, Nov 4, 2024 at 11:47 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Oct 31, 2024 at 01:51:36PM -0700, Ian Rogers wrote:
> > > On Thu, Oct 31, 2024 at 12:18 PM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Wed, Oct 30, 2024 at 06:42:37PM -0700, Ian Rogers wrote:
> > > > > The only use of find_scripts is in browser/scripts.c but the
> > > > > definition in builtin causes linking problems requiring a stub in
> > > > > python.c. Move the function to allow the stub to be removed.
> > > > >
> > > > > Rewrite the directory iteration to use openat so that large character
> > > > > arrays aren't needed. The arrays are warned about potential buffer
> > > > > overflows by GCC now that all the code exists in a single C file.
> > > >
> > > > Introducing is_directory_at() should be done as a prep patch, as the
> > > > rest of the patch below could end up being reverted after some other
> > > > patch used it, making the process more difficult.
> > > >
> > > > I mentioned cases like this in the past, so doing it again just for the
> > > > record.
> > >
> > > This is highlighted in the commit message:
> > > ```
> > > Rewrite the directory iteration to use openat so that large character
> > > arrays aren't needed. The arrays are warned about potential buffer
> > > overflows by GCC now that all the code exists in a single C file.
> > > ```
> > > so without the change the code wouldn't build. The new is_directory_at
> > > function is effectively 2 statements fstatat and S_ISDIR on the
> > > result, it is put next to is_directory for consistency but could have
> > > been a static function in the only C file to use it.
> > >
> > > For the record, patches introducing 2 line long functions can be
> > > excessively noisy, especially in a 21 patch series. There is always
> > > the declared but not used build error to worry about - here things
> > > couldn't just be simply moved due to triggering a different build
> > > error. Given the simplicity of the function here I made a decision not
> > > to split up the work - the commit message would likely be longer than
> > > the function. The work never intended to introduce is_directory_at but
> > > was forced into it through a desire not to disable compiler warnings.
> >
> > This patch does more than just moving the code which can be easy to miss
> > something in the middle.  I think you can move the code as is without
> > introducing build errors and then add new changes like using openat() on
> > top (you may separate the change out of this series).  I think it's
> > ok to have a small change if it clearly has different semantics.
> 
> If you are trying to bisect to find something that broke a build,
> having commits that knowingly break the build will cause the bisect to
> fail. The bisect will falsely fail on the known to be broken commit.

I'm not understanding, AFAIK nobody is advocating for breaking
bisection, just to first instroduce a function, then use it to avoid:

1) Introduce function foo() and use it for feature bar()
2) Somebody else uses function foo()
3) We find a justification to revert 1) but can't, since it will break
   2) so we need to add 4) that removes bar() from 1).

- Arnaldo

> It should be unacceptable to knowingly break the build in a commit for
> this reason.
> 
> Thanks,
> Ian
