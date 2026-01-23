Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D332D0C66;
	Fri, 23 Jan 2026 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769186869; cv=none; b=jscyuarNhlvF4J6UeaU27xOmmXT9Ikek7x4qsf4RQCGq2DPbX1ATe6Jht+a3QK/W3FOButrSD4oBDoWdgyxeH1BexYvWjvSxkcjqb80e9FdeqkTTZ1/PbHRnzb7p3LxIczsEqkmd83+pWlT6hIPdCq2VievtB6LiDuH2ObHdB7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769186869; c=relaxed/simple;
	bh=zveMAUf998ovbct5UpW7FmMJgR9EwAhf7mycVOrHXT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgeDTrekEVsQepxIAaRL0mC2b4zdxDb3takytIW0vkQF+nH9Sl9FasVrBjUy6BgqfcLl3JS5KXDz+y7BLVQRC1n3KaBxVLkbpDLW8IkxtfUyCXllSP+SnaKL+gNzYR57ndHswry6ptFTiwnX4UB+GeDpgx3bq5xTFbwTsVw+9a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpCvrKvl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpCvrKvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046ACC4CEF1;
	Fri, 23 Jan 2026 16:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769186868;
	bh=zveMAUf998ovbct5UpW7FmMJgR9EwAhf7mycVOrHXT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tpCvrKvle/wO3axQQk4cdWRkKypLm8st7IFY/YlpE8SKHScW1sSzzZR1zFMaANOQB
	 8K5ipExhGsMSuT+EMrydSDXe1a29fmQARcfM0SQrrYjxA6RvUuMtkYd/PwRasYADkO
	 FMVN1K53McrG3o1OnEFJOHZ8QK/2SDGXQTbGjlKjSa135KAqDoaHfmR402ZVpveUzv
	 9TtRI4qoddL8mVW7AUxFgF9Vui8WHHIWT5UoV+k1WXKsirGrhA6QkZqjEuzshYDYrF
	 X217jX9p4TVGQKEo/LKvtifEB/TSW+Ci6G5SGUh1TFuT3+Hrj94eMVSrxSjuRIYImK
	 Z26OO/WncgeBg==
Date: Fri, 23 Jan 2026 13:47:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Zecheng Li <zecheng@google.com>, Tianyou Li <tianyou.li@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Aditya Bodkhe <aditya.b1@linux.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Shimin Guo <shimin.guo@skydio.com>,
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 00/12] perf annotate arch clean up
Message-ID: <aXOmMc8W85u-AGxH@x1>
References: <20260122213516.671089-1-irogers@google.com>
 <1310a240-077a-49f6-b83a-a8a4fd52127b@linaro.org>
 <CAP-5=fWrJoej0XprvPmYg5qa7SRU2s3yeCF-hWgj+3MTdTZLzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWrJoej0XprvPmYg5qa7SRU2s3yeCF-hWgj+3MTdTZLzQ@mail.gmail.com>

On Fri, Jan 23, 2026 at 08:30:22AM -0800, Ian Rogers wrote:
> On Fri, Jan 23, 2026 at 3:02 AM James Clark <james.clark@linaro.org> wrote:
> > On 22/01/2026 9:35 pm, Ian Rogers wrote:
> >
> > Reviewed-by: James Clark <james.clark@linaro.org>
> 
> Thanks James!
> 
> Arnaldo, it'd be nice for this to land so I can look into addressing
> the missing e_flags issue - namely, we should optionally read the
> e_flags along with the e_machine so that we have a proper e_flags
> value to make csky work properly (not an issue on anything else). At
> the same time I think some of the e_machine should be made more robust
> like with:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/tools/perf?h=perf-tools-next&id=e99d544c7f3691eb321c88fdbadf04b777c114c4
> but here:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/thread.c?h=perf-tools-next#n452
> the code should probably be shared.
> Anyway, this series does enough without adding all that to it and
> waiting for more tags.

I just merged it and it is going on testing, I'll also check that fix
for the inject callchain on hybrid since I noticed it failing here as
well.

Thanks,

- Arnalod
