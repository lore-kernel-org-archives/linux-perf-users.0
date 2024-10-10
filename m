Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06EA1CB301;
	Thu, 10 Oct 2024 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571704; cv=none; b=oIXE9HiX0pWE1r7EVeGAUVTNn4tVg5aFDuCHqCNfPHgXODf5TSOzoo/kZABfZjUWkApXMy88xNiiYonI/zA2NfpNslmhfJrklmefyCLaJK2uKQKgkYCWHP3xcYVkRaDuwu8wrUNNFOS3rg/yRp1Zp01EyTPU8STV008AKiA9NpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571704; c=relaxed/simple;
	bh=zihjJSEgqk+803gp0qkrmkT2DT2099l3r+BnmjzK/z8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FYKUUvid1pvultWmZEg12HfSDW1SFrFLJh6i7AqPvVZY8uyYNAS8R0DeLTxdWSDJ0QchBaLU4OErYOiNTh/l9DD+q6JF+JavHJ3PlTg32/lY77KF9eqUCAsGSWWnc+aw5cwX/hj2qTFMPRzg+jhvH/KEyHYWdA3kNvrjXa3ang4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p93GkPmB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p93GkPmB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FABC4CEC5;
	Thu, 10 Oct 2024 14:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728571704;
	bh=zihjJSEgqk+803gp0qkrmkT2DT2099l3r+BnmjzK/z8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p93GkPmB0lxl8MtDh/ktV50083tvRB8hL0IcuFvZOQzmPpwQ4knf8aNcHAbP2+IFe
	 YUAJje7LUFTOdti6ZOADgYj8ROrE+O3Qv4Vk91kRrz3yMHDnzT0iihP10OU6KDoygc
	 Fb008JGYpZrlikPDqyD+c2qROY1mTv5OCtaiJu751xo5hZkMIQ6EB4Mx5hQ0+FaSnr
	 kc79Daa6XFdW/93eSrtyXQpikrXgMtnqxKTD2M8o+BXWcLBwlx2Sc3rTHc7hDV2a+9
	 EOeuS1f8l+7cXOdtY2jpsviXGLf1T8Kdn2EkNDuA/JHvJXZWL2D30Hny6PRrHc3rkA
	 CHi+/niiayyzg==
Date: Thu, 10 Oct 2024 23:48:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Dima Kogan
 <dima@secretsauce.net>, james.clark@linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] perf probe: Support long symbol
Message-Id: <20241010234818.ab279974ef597f02b61ab850@kernel.org>
In-Reply-To: <ZwcqFA4IKbLZ7Cev@google.com>
References: <20241007141116.882450-1-leo.yan@arm.com>
	<ZwcqFA4IKbLZ7Cev@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Oct 2024 18:12:52 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> Hello Leo,
> 
> On Mon, Oct 07, 2024 at 03:11:13PM +0100, Leo Yan wrote:
> > Currently, a probe supports event name maximum to a 64-byte length. The
> > event name comes from the probed symbol name, otherwise, user can
> > specify an event name.
> > 
> > In the case when user tries to inject a probe for a long symbol, e.g.
> > mangled symbol name in a C++ program, the kernel buffer cannot
> > accommodate it if the symbol name is longer than 64 bytes.
> > 
> > On the other hand, this series relies on the perf tool to resolve the
> > issue. When the tool detects user doesn't specify event name and the
> > probed symbol is longer than 64 bytes, it will generate a hashed event
> > name with 64-byte length to avoid failure.
> 
> Please CC Masami for probe related changes in the future.

Thanks Namhyung,

Let me find the patches.

> 
> Thanks,
> Namhyung
> 
> > 
> > 
> > Leo Yan (3):
> >   perf: Dynamically allocate buffer for event string
> >   perf probe: Check group string length
> >   perf probe: Generate hash event for long symbol
> > 
> >  tools/perf/util/probe-event.c | 71 ++++++++++++++++++++++++++++++++---
> >  1 file changed, 65 insertions(+), 6 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
