Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C8A395ACE;
	Mon,  3 Aug 2026 19:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785786075; cv=none; b=eBiRShO/ZNR438wF7SPoFEa05Essz0aoglKkS+7Ma2o5yZv3rILMBrqD0kh+BBYLa+RP0FsHq6rOGGQCOlJvqreGil5YzoqF4sitVCfj9U3csTWhjAIu+reqsd9Dwgp51+bfqhwtpNttLfvIRGrfs2LnyPqXx1VbmLhTDzkinxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785786075; c=relaxed/simple;
	bh=CPtj9XhX/DA5+tyd2YbLS7P82CrstM6C58vR5oY39ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaM1YTdUezIO/wYiL6ksFC87NjY0qmZJZQoTHOiw0NT3u+6kCM2zY+vJ6KiQEDlr1A1xyLA8+UP3fMpp6HaIvj1yRibM3K53K+Y3zE7i+SvYw/cQ6jEug8uCEaLOHTKBo53VqpAEshDyUZNDJXvgcm0EfkCMvJSxq8bXTlKdJ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fl0lASVE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fl0lASVE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A092D1F00A3A;
	Mon,  3 Aug 2026 19:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785786074;
	bh=0pyGujRJRCddKKZw0Iv3C7ObVgNJVVxCn5uwJQ00JOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fl0lASVESkwjHZVo3JKlpnttSUKUYILm4xX/QE/7MTuPdzUgRte5/3IleSleondch
	 fHtlOiSYv5yIxDP2PD1P2iZScTbKiAdcwWA38X8gKk+56ao3sy0tdDnGTLn8iiA/sd
	 T/GQ8comiqeW/xhY/O7eEGip4ldcea7uJ3GOebqyWTigUIMougi5N4wp1pFTwkP1r0
	 dqbC76S9i8aV9TlL4Z9V1HFeXrMbWs8r/LewdsZEiNZzhXyZ/AaQPgAvQk3/gsgJKK
	 eoQsRA4eIqObbn/bx28WIUEHkIK/aqyYNBiHW0MT7AcvKs/QmYn6asdgWGRZwASKKF
	 /TEjPdKqu+glQ==
Date: Mon, 3 Aug 2026 12:41:12 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>, Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH 5/5] perf arm-spe: Reject zero nr_cpu in metadata to
 prevent division by zero
Message-ID: <anDu2L-yfpUFES-h@google.com>
References: <20260727161705.64807-1-acme@kernel.org>
 <20260727161705.64807-6-acme@kernel.org>
 <df7bf01f-b0f6-403c-8415-305f3ea63fdb@intel.com>
 <anDlvtOEBK4QRS9P@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anDlvtOEBK4QRS9P@x1>

On Mon, Aug 03, 2026 at 04:02:22PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Aug 03, 2026 at 09:46:49PM +0300, Adrian Hunter wrote:
> > On 27/07/2026 19:17, Arnaldo Carvalho de Melo wrote:
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > 
> > > arm_spe__alloc_metadata() reads nr_cpu from the auxtrace_info priv
> > > array without validation.  When a crafted perf.data provides nr_cpu=0,
> > > the per_cpu_sz calculation divides by zero:
> > > 
> > >   per_cpu_sz = (metadata_size - (hdr_sz * sizeof(u64))) / (*nr_cpu);
> > > 
> > > Reject nr_cpu <= 0 early, before the division.  The caller already
> > > treats NULL return with metadata_ver != 1 as a parse failure.
> > > 
> > > Fixes: e52abceb4b6c2723 ("perf arm-spe: Dump metadata with version 2")
> > 
> > git blame shows 7842a4b6ff698 "perf arm-spe: Support metadata version 2"
> > for the relevant lines
> 
> That is right, Namhyung, can you please fix this Fixme tag while merging?

Sure, will do!

Thanks,
Namhyung

