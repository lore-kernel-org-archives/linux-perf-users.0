Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7711FBC93;
	Wed, 12 Feb 2025 18:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739386007; cv=none; b=TlyTqQmOW0aC7ikSNddvjuB7684wG1GqfRyIt0BqrglqJKwXmqW8LoCfMVAsl/HnRCq6i7GgiozJNE489RmEPGIfHXCgUrn9YVOqXk8vut4tCPQZnZ/vU4qMcmWLNvewULT5sV0qSxbIVNtSRxcRu0vvLgUoC9cJgTDS7YpxklE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739386007; c=relaxed/simple;
	bh=mXUx/Su0ni4gs9IkbRbwq74MoOPQS+NIqIcKQLmjdas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPKwhpXWU9sA64RHPW1IE6ooOXCffUAqFjZySDVj5d7FheFBCr/TloBTmWqJXpw5DGWGTzwyoz2xEdtcPRS6VKDPLnfRNYzKr5l/9i/UFZCsYAOyfePuFUYT2Ao3G9foGsYtUjSZhwBH8ETN+gOKBJbTBtFoB9pLqK0//Kl57Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecgqAQQw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecgqAQQw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8FFC4CEDF;
	Wed, 12 Feb 2025 18:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739386006;
	bh=mXUx/Su0ni4gs9IkbRbwq74MoOPQS+NIqIcKQLmjdas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ecgqAQQwLEl4rB4SbIESqHg7i/JSNEcwxBLTC5FHSKnpbo6EkvQMZinHkcOxEtzmx
	 Olx18momsCe+29R53kH5zLtp2uK0thPNaGxDzrvh6ap89fRGAmQa8iQatq0UqNBsYx
	 6S7OoWKHIjzHn7rEWdyZJ8cfxI5iyfq+3+oU0sXSilV7/LblJRHC/905p3nRDnDWn4
	 310NCzuMvGCLnMNksMZ5BkCVSWzo7Azxpdx0S5tAVN1tLKt+A3k8Az7CkmqdDWpEbL
	 PlPa8D3UDOmf98Pw08bk1gLGYD7+VWmNStBSp8xwfq0m+8xSVQJ2EeBtZAmAqvpV8j
	 8FEaR2O1q80Qw==
Date: Wed, 12 Feb 2025 10:46:44 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, Hao Ge <gehao@kylinos.cn>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Levi Yun <yeoreum.yun@arm.com>, Xu Yang <xu.yang_2@nxp.com>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/10] Move uid filtering to BPF filters
Message-ID: <Z6zslLa8XM1ubwXj@google.com>
References: <20250111190143.1029906-1-irogers@google.com>
 <Z6panMzNSm1op8Di@google.com>
 <CAP-5=fUY83gifsMZA0Q45kiQQbAKp2uJxkuwrwGtHK2hiUFRDA@mail.gmail.com>
 <Z6rAHhAIdlkAryGJ@google.com>
 <CAP-5=fXjmJ+Rr7ejL6fCMeu6PZSit7n84hQkjh=0jQhkr1on3Q@mail.gmail.com>
 <Z6uOGNO6p7i9Fese@google.com>
 <CAP-5=fVxFe4nMS_dHmO=6-ddA40XbVdvouPLuOxj5cenjUr8ng@mail.gmail.com>
 <Z6v-mPJq6m61pFA4@google.com>
 <CAP-5=fU+-4igQomO4Q41=7xo6YWyDdVqJdZd34dcMUS-Ua=N1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU+-4igQomO4Q41=7xo6YWyDdVqJdZd34dcMUS-Ua=N1Q@mail.gmail.com>

On Tue, Feb 11, 2025 at 09:41:04PM -0800, Ian Rogers wrote:
> On Tue, Feb 11, 2025 at 5:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > But you removed non-BPF and non-root (w/o pinning BPF) use cases.
> 
> I didn't think this was a hard series to understand. It moves the -u
> options of perf top and perf record to using BPF filters. The many
> reasons for this I already explained:
> https://lore.kernel.org/lkml/CAP-5=fUY83gifsMZA0Q45kiQQbAKp2uJxkuwrwGtHK2hiUFRDA@mail.gmail.com/
> 
> Your case is a user that isn't exiting and starting processes and
> wants to process themself or some other user they some how have
> permissions for? They need to not be starting and exiting processes as
> new processes are ignored and exiting processes cause the
> perf_event_open to fail. What stops such a user passing the list of
> processes they have that aren't starting and exiting as a -p option?
> 
> If you try something like:
> $ perf top -p $(ps --no-headers -u $USER -o pid | awk '{printf "%s%s",
> sep, $1; sep=","}')
> this is exactly what you get. Does it work? No, the ps and awk
> processes terminating but being in the list of processes causes the
> perf_event_open for those pids to fail. This is exactly the same
> problem as the -u option that you want to keep for this case. The
> approach just doesn't work.
> 
> Why not make failing to add a -u option fallback on doing the /proc
> scan and pretend the processes are a -p option? So now there's a
> silent fallback to a broken behavior. New processes won't be profiled
> and the data race between the scan and the perf_event_open will cause
> failures with non-obvious causes/solutions - mainly, use sudo to run
> as root. I'd say this isn't ideal.
> 
> This series fixes an option on two commands so that it works in the
> sensible use-case, perf running with privileges trying to filter
> samples belonging to a specific user. We can say the patch series
> doesn't work for the case you give, I don't think anybody cares about
> that case, they can get near identical behavior from -p, the behavior
> from -p will be clearer than just having -u doing something similar,
> namely failing to open for a process and terminate.
> 
> You may hate and ignore every point I make and still want to keep the
> existing broken behavior. As I've already tried to make clear, you're
> adding to the maintenance burden to everyone working in the code base
> as the notion of target is fundamental and because you are insisting
> on keeping a broken behavior you are also making it untestable. Given
> the -u option doesn't work, I strongly suspect nobody uses it. Do I
> worry about this series causing harm to the people who aren't using
> the option? No I don't as there is a better opportunity in having an
> option that (1) does work and (2) results in a simpler code base.

It's not completely broken and works sometimes.  And it seems we have an
issue with BPF sideband events.  But it worked when you ran it as root.

  $ sudo perf record -u $(id -u) --no-bpf-event -- sleep 1
  WARNING: Ignored open failure for pid 404758
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 2.754 MB perf.data (3638 samples) ]

  $ sudo perf report -s sym --stdio -q | head
       1.43%  [k] audit_filter_rules.isra.0
       1.33%  [.] pthread_mutex_lock@@GLIBC_2.2.5
       1.06%  [k] __audit_filter_op
       1.05%  [.] __vdso_clock_gettime
       0.94%  [.] _dbus_type_reader_get_current_type
       0.82%  [.] pthread_mutex_trylock@@GLIBC_2.34
       0.76%  [k] __fdget
       0.72%  [.] _dbus_first_type_in_signature
       0.61%  [.] __GI___pthread_mutex_unlock_usercnt
       0.56%  [k] native_sched_clock
  
Thanks,
Namhyung

