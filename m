Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8723A6;
	Mon,  4 Nov 2024 19:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730749659; cv=none; b=RZnrPvz7ITbvz14XqgPaeiIaQkGUXuSmZvyF4DePa1xGoHblHzwesHdJA7WkfkN9Qr/pY/C5UzOKXR71cRGvncIcZaUnY5P1tlbYxSjlGFLQfMBYfImS8WmbOE7bT5u0997gl679Zl9rZsRWDT9Mosy9Y7HriKh1bCXJ3pmCad4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730749659; c=relaxed/simple;
	bh=i17H9M/iiBGemD1DQucLp1BewH56A334xN5xMh6KFes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jakyMdXBYjIE+SbDRhWvzX8i2FqdyI6hQvQNP+1SBZjKOtA90Y33qgVtJJY/rVo9iDD2vsjqEwvvCIcvZ7TChToPI86gFVBv2V0LZN11U+WUzW6CApct9/1GgWt0IZnPtnhbi3N4elPPY7TlX3AJaQFMzGwo+FSLb0T4V3y///c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udHXCplV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udHXCplV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C60BC4CECE;
	Mon,  4 Nov 2024 19:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730749659;
	bh=i17H9M/iiBGemD1DQucLp1BewH56A334xN5xMh6KFes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=udHXCplVtZYX7NAbj3+fqN6B/yqhEpflhqyanCizCxbJJpRvy2kDQd93ScwrcqHYo
	 StUReLRnAIkXWYOJ+rOv1Cp6cXHubJ8/BI3SKiRWP77XSsCUxJaq4b8E7YA+7jO7yW
	 FtWtzLgqCEbvwaPV8/2ohw6cpCA8ouy/pt29o53n/0l7VJtMDhS8kwHdsc6aMwJYsB
	 FVVFRzYMGYGL1g4VG67TwPCLFcpnV+xvNxT7tALastQC9uOWK2AlMWkq1J4lMSc88p
	 FpodFIm9+wdoXVAc/ZQv+ShHOHFWnuAtlzSribP1qX8LTwb7cFCWeTPGRkpmRFpvAS
	 t/mWzBsP6cmNA==
Date: Mon, 4 Nov 2024 11:47:36 -0800
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
Message-ID: <Zykk2MJ4REGCaqVw@google.com>
References: <20241031014252.753588-1-irogers@google.com>
 <20241031014252.753588-7-irogers@google.com>
 <ZyPX7ayIO4teziDX@x1>
 <CAP-5=fVgJu8BJWFVUkCy1Zsi3piTPdV-GXL1bTpWZeO=nm=jrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVgJu8BJWFVUkCy1Zsi3piTPdV-GXL1bTpWZeO=nm=jrg@mail.gmail.com>

On Thu, Oct 31, 2024 at 01:51:36PM -0700, Ian Rogers wrote:
> On Thu, Oct 31, 2024 at 12:18 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Wed, Oct 30, 2024 at 06:42:37PM -0700, Ian Rogers wrote:
> > > The only use of find_scripts is in browser/scripts.c but the
> > > definition in builtin causes linking problems requiring a stub in
> > > python.c. Move the function to allow the stub to be removed.
> > >
> > > Rewrite the directory iteration to use openat so that large character
> > > arrays aren't needed. The arrays are warned about potential buffer
> > > overflows by GCC now that all the code exists in a single C file.
> >
> > Introducing is_directory_at() should be done as a prep patch, as the
> > rest of the patch below could end up being reverted after some other
> > patch used it, making the process more difficult.
> >
> > I mentioned cases like this in the past, so doing it again just for the
> > record.
> 
> This is highlighted in the commit message:
> ```
> Rewrite the directory iteration to use openat so that large character
> arrays aren't needed. The arrays are warned about potential buffer
> overflows by GCC now that all the code exists in a single C file.
> ```
> so without the change the code wouldn't build. The new is_directory_at
> function is effectively 2 statements fstatat and S_ISDIR on the
> result, it is put next to is_directory for consistency but could have
> been a static function in the only C file to use it.
> 
> For the record, patches introducing 2 line long functions can be
> excessively noisy, especially in a 21 patch series. There is always
> the declared but not used build error to worry about - here things
> couldn't just be simply moved due to triggering a different build
> error. Given the simplicity of the function here I made a decision not
> to split up the work - the commit message would likely be longer than
> the function. The work never intended to introduce is_directory_at but
> was forced into it through a desire not to disable compiler warnings.

This patch does more than just moving the code which can be easy to miss
something in the middle.  I think you can move the code as is without
introducing build errors and then add new changes like using openat() on
top (you may separate the change out of this series).  I think it's
ok to have a small change if it clearly has different semantics.

Thanks,
Namhyung

