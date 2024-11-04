Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12FF18DF8F;
	Mon,  4 Nov 2024 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754040; cv=none; b=TAAyzR5xrGtbe/vBHz+ePUXmsK5IVZVBUXtmeZ5iZ9ALpfyyUbXxpd52Q7iAJwnpGSkjaJTH5v8v04U2auUkyJEOjf68x9dtgAAOnKueXJC52q7l5dILYq7Aixg7y+iqo820J+JOhe3fDKPlGzq/6djP1ulCnq1lsJPIb3/KwiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754040; c=relaxed/simple;
	bh=+JnuYJJgahecdEeb1aApIjChwSEPKJ0iG6ZTn0zz9I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6g3DxnKuSWF4DFpnFFc2ZajItKQXUO7DO36vRIw0A/siF/wxt2i/AlzIAOiTcAuEVHA9ftplxKMrVYoH0zHPNKhe9RqkAqrmu+cUUiAQU++M2N4uBOS2l8FOV1RtMzYp0K0pgn4kXiEtKkHBWP3LR/cdk94gZJniu/7wVSzxFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4mevY+T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4mevY+T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC32FC4CECE;
	Mon,  4 Nov 2024 21:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730754039;
	bh=+JnuYJJgahecdEeb1aApIjChwSEPKJ0iG6ZTn0zz9I8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r4mevY+T/fi/gyAlN3rIuUjLExZmg5XdyI+cAIsOKBJ1e666rfkoBmxr69SAc0+ig
	 7GoOxfdVvLP8QdqEEqVnLCqwe/fcIrOhA5mkoZQglxGM21hB8m2Y9PjnbnI5EZKzjs
	 k9Zs2wKR6dkmwsk1ztZhauP2+CcbzauVInTRpHUp63KDIdkoLuQkhaZVVMW/T60cnh
	 Vmct/oj4YPADmwhn3QpgmGxJWL9RRVaCuGYSENM+NmlgZ7YtiRrRgbJuQRaluiAXPo
	 CPvydklNv7mcStai/SUIVxWonF4eJyZj35FL8/EI5rkoXQ25tdyF4YhXXBxMv8o93z
	 9Czwh8U/AW7lw==
Date: Mon, 4 Nov 2024 13:00:36 -0800
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
Message-ID: <Zyk19KgzI7ybPkQ4@google.com>
References: <20241031014252.753588-1-irogers@google.com>
 <20241031014252.753588-7-irogers@google.com>
 <ZyPX7ayIO4teziDX@x1>
 <CAP-5=fVgJu8BJWFVUkCy1Zsi3piTPdV-GXL1bTpWZeO=nm=jrg@mail.gmail.com>
 <Zykk2MJ4REGCaqVw@google.com>
 <CAP-5=fXQpej43wxEtMYFbxdofHtUi98X68W4AaR9UCfsbDir5A@mail.gmail.com>
 <ZykxD41c6gWQoIrQ@x1>
 <CAP-5=fWf8guTgqwfrrct3AGYDC=Lb1Oxo7kXU_x1yEr5urFSkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWf8guTgqwfrrct3AGYDC=Lb1Oxo7kXU_x1yEr5urFSkQ@mail.gmail.com>

On Mon, Nov 04, 2024 at 12:48:01PM -0800, Ian Rogers wrote:
> On Mon, Nov 4, 2024 at 12:39 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Mon, Nov 04, 2024 at 12:34:47PM -0800, Ian Rogers wrote:
> > > On Mon, Nov 4, 2024 at 11:47 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Thu, Oct 31, 2024 at 01:51:36PM -0700, Ian Rogers wrote:
> > > > > On Thu, Oct 31, 2024 at 12:18 PM Arnaldo Carvalho de Melo
> > > > > <acme@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, Oct 30, 2024 at 06:42:37PM -0700, Ian Rogers wrote:
> > > > > > > The only use of find_scripts is in browser/scripts.c but the
> > > > > > > definition in builtin causes linking problems requiring a stub in
> > > > > > > python.c. Move the function to allow the stub to be removed.
> > > > > > >
> > > > > > > Rewrite the directory iteration to use openat so that large character
> > > > > > > arrays aren't needed. The arrays are warned about potential buffer
> > > > > > > overflows by GCC now that all the code exists in a single C file.
> > > > > >
> > > > > > Introducing is_directory_at() should be done as a prep patch, as the
> > > > > > rest of the patch below could end up being reverted after some other
> > > > > > patch used it, making the process more difficult.
> > > > > >
> > > > > > I mentioned cases like this in the past, so doing it again just for the
> > > > > > record.
> > > > >
> > > > > This is highlighted in the commit message:
> > > > > ```
> > > > > Rewrite the directory iteration to use openat so that large character
> > > > > arrays aren't needed. The arrays are warned about potential buffer
> > > > > overflows by GCC now that all the code exists in a single C file.
> > > > > ```
> > > > > so without the change the code wouldn't build. The new is_directory_at
> > > > > function is effectively 2 statements fstatat and S_ISDIR on the
> > > > > result, it is put next to is_directory for consistency but could have
> > > > > been a static function in the only C file to use it.
> > > > >
> > > > > For the record, patches introducing 2 line long functions can be
> > > > > excessively noisy, especially in a 21 patch series. There is always
> > > > > the declared but not used build error to worry about - here things
> > > > > couldn't just be simply moved due to triggering a different build
> > > > > error. Given the simplicity of the function here I made a decision not
> > > > > to split up the work - the commit message would likely be longer than
> > > > > the function. The work never intended to introduce is_directory_at but
> > > > > was forced into it through a desire not to disable compiler warnings.
> > > >
> > > > This patch does more than just moving the code which can be easy to miss
> > > > something in the middle.  I think you can move the code as is without
> > > > introducing build errors and then add new changes like using openat() on
> > > > top (you may separate the change out of this series).  I think it's
> > > > ok to have a small change if it clearly has different semantics.
> > >
> > > If you are trying to bisect to find something that broke a build,
> > > having commits that knowingly break the build will cause the bisect to
> > > fail. The bisect will falsely fail on the known to be broken commit.
> >
> > I'm not understanding, AFAIK nobody is advocating for breaking
> > bisection, just to first instroduce a function, then use it to avoid:
> >
> > 1) Introduce function foo() and use it for feature bar()
> > 2) Somebody else uses function foo()
> > 3) We find a justification to revert 1) but can't, since it will break
> >    2) so we need to add 4) that removes bar() from 1).
> 
> Namhyung was asking that the c&p of code be 1 patch then "add new
> changes like using openat() on top". That is:
> 
> patch 1: add is_directory_at - introduce the 2 line helper function
> patch 2: move the code
> patch 3: update the code to use is_directory_at
> 
> patch 2 is known broken as patch 3 is fixing it.
> 
> Hopefully this is clear.

Actually I don't care about the patch ordering.  My request is not
to break build and just to separate different changes out. :)

Thanks,
Namhyung

