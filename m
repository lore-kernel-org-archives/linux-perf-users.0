Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1381D1312;
	Fri, 30 Aug 2024 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725020371; cv=none; b=ceocpKMhv7kNqOTUJKtYysfkW9wCvNVYsDm/4v0e2lHGDsJRJW7aPqEB/eRWjM/PwhZFDHlNXnqhMfFGxa75eusTrX4y/wt40ByvAtuhGp55EjHwStFGdYMlWR6zdgT1PJsgNtkD2dKpYtFIJj5WQwkTSukDQ/6qKbvBCI3DuV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725020371; c=relaxed/simple;
	bh=GYwcdTpZfkB/eg8RZ00QmtBiRQ1q3q5j/qKFwnlXm7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=im+EH2jHAVkfSNWDNcvMBmtH99tU4kW/jwcdhWwBIAE9kYl7IJL9yqJvoJJPYwkB1MtKYCk9XbYYAHcgw6zcw9kEdz1N4B9dhYtBG7aNB9bk4JcAqRruY6VlUB3gwGj5UdMqaQ/giLUK1xXvzw/z2GJmZPaz5oi2Nid95Nko6d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsYLY0cg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsYLY0cg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DA0C4CEC2;
	Fri, 30 Aug 2024 12:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725020370;
	bh=GYwcdTpZfkB/eg8RZ00QmtBiRQ1q3q5j/qKFwnlXm7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PsYLY0cg0EC69Ei/jFLhXSsiEl/O/fDYmSkncYrIk5fihN5IQX99pjcu4H4GHJbaG
	 EdE1fD492/+aLhGd3p784mVMZvWS1s6Mh4Ten2AMFov2huw2j1EWGr3D4SECLrMjXH
	 xDskfUILHJYP6rNAsaq4vZGh25H2AafPQ2AaGbD3TfusZP7lzK6+ROVaA6MxsjQnmz
	 fLAuerZLT8bS/B2qL7yLR0yfiyLLCxMvFSG9dHamIXNnNSfnG0noh4Wq+I3B4+oyor
	 4T203PuQu9FNBDw7p2IfT/nPS0F6CuhM/6fUr0XotIg6yXLnW8eQAkC4YCQlpJJ9cC
	 0jaP4wlDc3CGg==
Date: Fri, 30 Aug 2024 09:19:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>, Yanteng Si <siyanteng@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/8] perf header: Allow attributes to be written after
 data
Message-ID: <ZtG4z5qPtCBNDdXO@x1>
References: <20240829150154.37929-1-irogers@google.com>
 <20240829150154.37929-6-irogers@google.com>
 <ZtDMf886_1vXWt49@x1>
 <CAP-5=fURe7yVy6OGWdKn1eSzsdfZPyvvc5fRMPeNAjukaWOe1w@mail.gmail.com>
 <ZtDg2BAI0V5zKpjn@x1>
 <CAP-5=fXa0r7sD9xbtBVbJQFgnq=3i-cnj6gUX9tze0JyhLhvZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXa0r7sD9xbtBVbJQFgnq=3i-cnj6gUX9tze0JyhLhvZw@mail.gmail.com>

On Thu, Aug 29, 2024 at 02:42:38PM -0700, Ian Rogers wrote:
> On Thu, Aug 29, 2024 at 1:58 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > On Thu, Aug 29, 2024 at 01:12:32PM -0700, Ian Rogers wrote:
> > > On Thu, Aug 29, 2024 at 12:31 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > On Thu, Aug 29, 2024 at 08:01:51AM -0700, Ian Rogers wrote:
> > > I'm not seeing the difference. Before:

> > You noticed the difference: before we used lseek to get the current
> > offset to use, afterwards we moved to doing plain math.

> > So I had to check if we could assume that, and with the current code
> > structure, yes, we can assume that, so seems safe, but it is different
> > and if the assumption somehow breaks, as the code in __do_write_fd()
> > guard against (unneeded at the moment as ion has even a BUG_ON for that
> > not to happen), then the offset will not be where the data is.

> > Using lseek() is more costly (syscalls) but it is the ultimate answer to
> > get where in the file the current offset is.

> > So that is the difference I noticed.

> > Doing multiple things in the same patch causes these reviewing delays,
> > doubts, its something we discussed multiple times in the past, and that
> > continue to cause these discussions.

> Right, but it is something of an unfortunate coincidence of how the
> code is structured. The fact that writing the header updates
> data_offset which is a thing that other things depend upon while
> depending on its value itself, etc. - ie the function does more than
> just a write, it also sometimes computes the layout, has inbuilt
> assumptions on the values lseek will return, and so on. To get to this

I share your frustrations, code gets complex over time, that is why I at
least try to ask these questions, encourage more granular patches, that
do just one thing, etc, to avoid having this conversation again years
from now, when some other person tries to understand the codebase do
bisects, refactor it, etc, just like you're doing now.

> final structure took a fair few iterations and I've separated this
> change out from the bulk in the next change to keep the patch size
> down. I could have done a patch switching from lseeks to math, then a
> patch to add write_attrs_after_data.

> It probably would have yielded about 4 lines of shared code, more
> lines that would have been deleted, while creating quite a bit of work
> for me.

> Ideally when these functions were created there would have been far
> more liberal use of things like immutability, so side-effects are
> minimized. Yes I could refactor everything, but time..

As I said, I think your patch is safe as-is, its just that it took more
time than needed for reviewing, i.e. it will cost more one side or the
other, and as I have to review everything I merge, doing it on my side
slows things down the overall process of collecting patches from lots of
people.

So far I collected 234 patches for v6.12, and there are way more to
process, like Howard's perf trace BTF work, that I merged partially,
but where I'll have to do work on splitting patches as agreed with him
in another thread, etc.

- Arnaldo
