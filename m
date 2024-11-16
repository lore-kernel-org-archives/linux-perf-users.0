Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5F316419;
	Sat, 16 Nov 2024 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731785161; cv=none; b=oN4o/c6ax7u0emkbZ9jdfgXASngoppHYCDbpmjDBM34aqnl3lPDmW7j5d/wyMhJeloT7LRzNQ4k42dPXicRh4ilm92Z7QG9Zx6eAGND37xZec+5ZT7n6xpXN7WBVe2JOiXys8RYKw4ZyaEQT09ymUCFqb7K7W6JIvC16pvoJfyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731785161; c=relaxed/simple;
	bh=kSAxhjtR5pLE+SU6IJ1SezBvqEgOiWHg3DExa2hKbCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBvpJo6bXPWpUUJdqK4gAgQwbZu31F+6KthWwDkW2xQ81SkwGDRvov/kbWIm8x28+VBuJPkjlMXJ5gavaN+m3kB6fT6ONvkiyruYiREzQSHDsDyJ9cKooUBrhkpPFxdbIZ++R4EXoFI/El8dTsuywhdwAAUvWYSu00xZ2WF7cUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RChUPxFQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RChUPxFQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59443C4CEC3;
	Sat, 16 Nov 2024 19:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731785160;
	bh=kSAxhjtR5pLE+SU6IJ1SezBvqEgOiWHg3DExa2hKbCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RChUPxFQCcwyp5VevaIDow7tS+NvmwA8mCjwsxL6iFfkRTpmFNvhjHZ3UgBVOmoUn
	 eyFHRknlHrNSVcur0nFAOOB6HPy4foO7XDRDSQKhgyHlFQLl9zxJrmn7z2kazf2Vuw
	 8aoekDN5sKqOYrkLksznA/BXB7paN3Rus6UnXIhgNQJL0IHOSn22J+L9uawgcDrQBJ
	 voJjzfzSnIT+Lpa6Wxdv9JX129BvtsdIifKe3eAf8IE3iGglLs8ihdlKVus/EFbJp5
	 zjNgFHw9mWZk7CB2IHfftxH6LoL/MAF6BQUwGHVaTaIIqp76IJFYEDT8LLH8KS/7H9
	 P97SsgLIb4ukg==
Date: Sat, 16 Nov 2024 16:25:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: linux@treblig.org, namhyung@kernel.org, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf util: Remove kernel version deadcode
Message-ID: <ZzjxxCnicVIwAF5N@x1>
References: <20241116155850.113129-1-linux@treblig.org>
 <CAP-5=fXqig=qHAa26d5-8pHPCtS0ZyCNs4FJGr4c4BSjFe+-eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXqig=qHAa26d5-8pHPCtS0ZyCNs4FJGr4c4BSjFe+-eg@mail.gmail.com>

On Sat, Nov 16, 2024 at 10:37:32AM -0800, Ian Rogers wrote:
> On Sat, Nov 16, 2024 at 7:58 AM <linux@treblig.org> wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > fetch_kernel_version() has been unused since Ian's 2013

                                                       2023

> > commit 3d6dfae88917 ("perf parse-events: Remove BPF event support")
> >
> > Remove it, and it's helpers.
> > I noticed there are a bunch of kernel-version macros that are also
> > unused nearby.
> > Also remove them.
> >
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
