Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4971A3A80;
	Mon,  2 Sep 2024 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725303229; cv=none; b=fKLeoY+2+dQ7m/Bq+BHJ46Wm/o8AWB+ZmEyuLQG/YRD9cf8xOh34u9j9PcGJ1N7O8OvED7O2LlxkIQoeQl8bjcD/awUsylg/w//dR3TbqaZ0akj24iZdK+QZgZISrMZV7N0A/8yA1/aXuoqzValP1vTJl4PCC4bmsrAoT4bl6b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725303229; c=relaxed/simple;
	bh=6TV4CZzcc9S1jXCBjpCp5jq37IukydqYrt9uRs7zaOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmz0dPzamzgpTOCJbO8iJRqIh7Fgkw4XWRMmdyWR8EUSIqDgkU/kyr2WRHAku6aj+7/GU3SyFvF9Jm9tKFpId4OQiCJCOUrPczibGRUqQzavTh/X3vwNOw+eVuEzognJBUGappitpAgcpEfRcJ79P7x2wBPa0qPYGamsBG59k94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgSkU6Xd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgSkU6Xd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05678C4CEC2;
	Mon,  2 Sep 2024 18:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725303229;
	bh=6TV4CZzcc9S1jXCBjpCp5jq37IukydqYrt9uRs7zaOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LgSkU6XdYTGXDq2d1Ejbqn6I73I8e0YPj9hmS65oWN6volk88NexybAIULfFymvVJ
	 44AAb/hmCoSXMVD+WZ6KukafleKH5/Bm2iYyI0v8j62AyZpxXK2ckFh+c7OOS1Fo+j
	 jIdr32ybFbqZZVtgDQ/G7pIU41Nm+IjqCydM1ZsXHYUugfSyEqEirWbIhqVJvD1a5T
	 2ZTox7ZkrtgVJPQy1s1eSOOwr4ovc8kQAHuWxsOx5xqXKKesT3vBNbAEut3p5ZTBU8
	 f8ZgaQu+q9M12jZYPPuFBEX5j+C8ioPyq6wI6cJOiDupUStOVxkmF0cpEcOuSNe5n6
	 syffRYvik3bCg==
Date: Mon, 2 Sep 2024 15:53:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Howard Chu <howardchu95@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH/RFT] Re: [PATCH v5 1/8] perf trace: Fix iteration of
 syscall ids in syscalltbl->entries
Message-ID: <ZtYJutp0CfRYXONf@x1>
References: <20240705132059.853205-1-howardchu95@gmail.com>
 <20240705132059.853205-2-howardchu95@gmail.com>
 <6fe63fa3-6c63-4b75-ac09-884d26f6fb95@kernel.org>
 <ZtJWEVn8-w07Wm0q@x1>
 <CAP-5=fWyPN48AcVZ3jdDnDdg4t2Q6fMXFV9HVymk0ynZnKcj+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWyPN48AcVZ3jdDnDdg4t2Q6fMXFV9HVymk0ynZnKcj+A@mail.gmail.com>

On Fri, Aug 30, 2024 at 05:35:32PM -0700, Ian Rogers wrote:
> On Fri, Aug 30, 2024 at 4:30 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > The script used to generate the 64-bit syscall table was already
> > parametrized to generate for both 64-bit and 32-bit, so just use it and
> > wire the generated table to the syscalltbl.c routines.

> > Reported-by: Jiri Slaby <jirislaby@kernel.org>
> > Suggested-by: Ian Rogers <irogers@google.com>

> This looks great!
> Reviewed-by: Ian Rogers <irogers@google.com>
> It seems strange to me that the 64-bit binary doesn't need a 32-bit
> syscall table given it could start a 32-bit binary, but that's a
> problem for another day.

Just one in a list of things TODO, how to get info about specific
binaries issuing syscalls and then use the right syscall table on a
system wide/CPU list/cgroup/whatever 'perf trace' session?

Yeah, a problem for another day, but at least now we have both syscall
tables (32 and 64 bit) available.

Thanks for reviewing it, added to the cset,

- Arnaldo
