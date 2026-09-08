Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7ED3EDAC9;
	Tue,  8 Sep 2026 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901615; cv=none; b=bg1mSI30ubhZbM/HxUpUhAdm6tKFdg9bIKjHh/GfT+lJkv1I1VpXfb3oBJZUNmQUcB7XxxMUN1cNqGBQbiDmV9AreQxuitkmNbirwsHVnkHX5WQCsLspdJ0ZFUTqkLJqcC+1a7fJfYM+xIIKTSyyxXxxh2+A56ac+QXKtoYwwLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901615; c=relaxed/simple;
	bh=zZ6Z/qUM0TgpIAkIeVLBr/1QnUqVrTGy+JyOD2P5Xz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHWgcttWVk1gtfqb7M5OYcMSUt608CZUZYPIjkadHdKawU0oTUS0jww0dJO3hJShlBMeU9urCRHfK+6FjDjZ6pD85LpRwUYULo8K74x+zGuno0G1aBDOGnrfPLQkJpznUnoKELCrcZJzqLgVe068NoYazmGgNtIIIHZobgE3IJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4bwNbrv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4bwNbrv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32EF1F00A3A;
	Tue,  8 Sep 2026 21:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788901613;
	bh=bhyPABa8tAbMOzWfBEgk9TWMIlxGTmRbRFs/D7JU2zY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g4bwNbrvVuO7I6q6mYEVJaki4p+trGVbWiX2EVbdRKfeq11CcugGenGXbKu8XJwtO
	 Gm+3NF57GL9DBVDPRJQBp680Mq9oJ4HamMVq0IhW4VGPoE+T2CkpwLRRlNsldQjb/e
	 VqyH+sFvDQTSiOaoaVDgR0esvcLuqDDHAhFxFEGli+XK12+abL7a0ptnLiK+CeDEH5
	 gvSHO+wrhbfSwSicZgCmqtne5cPqt28x21nfyZBXVBYH5/EM5r2EZdIchZeCv38nHn
	 VvXSwgTbR6c+Be9A+t++Dmj0+IT6CrDH75kvR5OapJUMT663Jr4AQh7sgGDHnDTXx+
	 48vb+GozGNMCg==
Date: Tue, 8 Sep 2026 18:06:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf test: waiting.sh: Replace timestamp polling with
 sleep
Message-ID: <aqB46q7p5I_3G3DO@x2>
References: <20260908152053.192830-1-adrian.hunter@intel.com>
 <CAP-5=fUY9H-26_CAE6yLXr9ci6F4Wia3BsFJjeDqbPo1qcO7Eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUY9H-26_CAE6yLXr9ci6F4Wia3BsFJjeDqbPo1qcO7Eg@mail.gmail.com>

On Tue, Sep 08, 2026 at 10:14:29AM -0700, Ian Rogers wrote:
> On Tue, Sep 8, 2026 at 8:21 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > The waiting helpers implement timeouts using:
> >
> >   date +%s%1N
> >
> > This relies on GNU coreutils date truncating %N to the specified width,
> > so %1N yields tenths of a second.
> >
> > Rust coreutils (uutils) interprets the width differently and does not
> > truncate the nanoseconds field.  Consequently "date +%1N" returns all
> > nine nanosecond digits, causing the elapsed-time calculation to be done
> > in nanoseconds while timeout values remain in tenths of a second.
> >
> > As a result, timeout comparisons succeed immediately and the waiting
> > helpers time out on their first iteration.  This causes
> > test_intel_pt.sh to fail on systems using uutils "date".
> >
> > Avoid implementation-specific date formatting entirely.  Instead, wait
> > for 100 ms on each iteration and count the timeout down.  Besides fixing
> > the portability issue, this removes the busy-waiting behaviour in
> > wait_for_perf_to_start(), which could otherwise consume CPU while
> > waiting for perf record to start.
> >
> > Since the timeout is now based on repeated sleeps, it is only
> > approximate.  Update the comments accordingly.  Also make is_running()
> > wait for exactly the documented number of tenths by changing its timeout
> > test from -gt to the new logic, and quote tm_out in the modified code.
> >
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
