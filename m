Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E2B146588;
	Mon, 17 Mar 2025 20:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742243725; cv=none; b=ciwX1bdN1VKk3GHA/qu7lU7Woaz3tW0Cl9Kw8laoy/5MDBO0p14r1BlK5wyoMQ/x6PpL14YM83/+j0K4sLCpIbTdgAJMYu97pqKjtPKl2ldFKTLIUdgJf3IYIuyZjVbItj2r0lr8YppqFSiVVIqOOT6MmoRyHum7FnmZX4Ll8GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742243725; c=relaxed/simple;
	bh=NKJYAkIZDxXhDP9Ari+OGv8/tGpqa0M90wdkx19V/Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zl4Rme8EgSmTz7HrUxdGJAsCyGnsc2lTJzAyD+L/1FhVaeXs9k/acgid58NizGzhAWC3IDcLbmw/jgsUehwEiNa6zYpGGnhRBsZbYfnQ7buFNc1CJU2niKUrZDjlSkYC8s9BnhX0nhP/83r506DUda9ceD4yqfXXchyQTk8khNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIiKH6HW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIiKH6HW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12915C4CEE3;
	Mon, 17 Mar 2025 20:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742243724;
	bh=NKJYAkIZDxXhDP9Ari+OGv8/tGpqa0M90wdkx19V/Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vIiKH6HWmjE9qye0KVlZps/HQ7x2hveWYe1DIWK6dQD0b9B8TSDnXdb2vN8sgVK0d
	 zCnYT+kUT6v07xIAlQXMohx2KUDUJXQjDbSJZ68a7pHIwDL9upaYQXGjH6PqG3hBtP
	 2l4GSShCekynenWgG1L8aWzWPodKheGD//4CqbsUDE2SUa9IBXdN6B2QdoD1LRChaN
	 BqX7lf712U/42KKogqU+Y98ISsT6JVfcVN+7geFwn/DWxgkwvqjhD8iAXUgI+BXIqE
	 4Or7kFgzcJ/unYu6skJ0YhrhUw4XNubHMZuGSLO7H47V++UiH8BfdkrmvAeAkqL2LF
	 B10uZe3zVsv+w==
Date: Mon, 17 Mar 2025 17:35:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, terrelln@fb.com, leo.yan@arm.com,
	james.clark@linaro.org, christophe.leroy@csgroup.eu,
	ben.gainey@arm.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf record: Add 8-byte aligned event type
 PERF_RECORD_COMPRESSED2
Message-ID: <Z9iHiTv_ud6GEhJh@x1>
References: <20250303183646.327510-1-ctshao@google.com>
 <Z9TXabugl374M3bA@google.com>
 <Z9hFJtEKfsGGUDMg@x1>
 <Z9hLKsZOfouM3K7H@x1>
 <Z9hR8M-SQ5TD2qMX@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9hR8M-SQ5TD2qMX@google.com>

On Mon, Mar 17, 2025 at 09:46:40AM -0700, Namhyung Kim wrote:
> On Mon, Mar 17, 2025 at 01:17:46PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Mar 17, 2025 at 12:52:09PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Checking the discussion and the patch.
> > 
> > My first impression yesterday when I saw this on the smartphone was: how
> > will an old perf binary handle the new PERF_RECORD_COMPRESSED2? Will it
> > ignore it while emitting a warning, since it can be skipped and then
> > what we will get a partial view?
> > 
> > Having some session output showing how an older perf binary handles
> > PERF_RECORD_COMPRESS2 would be informative.
> 
> I think it'll show the below warning:
> 
>   <offset> [<size>]: failed to process type: 83

Right that is what I got:

⬢ [acme@toolbox perf-tools-next]$ perf.old script -i /tmp/perf.data.ck8 
0xbf0 [0x250]: failed to process type: 83 [Invalid argument]
⬢ [acme@toolbox perf-tools-next]$

I think we should change that to something more informative, like:

0xbf0 [0x250]: failed to process unknown type 83, please update perf.

And then does it stop at that record it doesn't grok?

        if ((skip = perf_session__process_event(session, event, head, "pipe")) < 0) {
                pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
                       head, event->header.size, event->header.type);
                err = -EINVAL;
                goto out_err;
        }

        head += size;

So we're stopping there.

Maybe we can just warn and skip?

Anyway, the series as is seems ok.

I'll test a bit more and send my Tested-by

- Arnaldo
