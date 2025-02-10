Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6550281749;
	Mon, 10 Feb 2025 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216530; cv=none; b=IuAN4BJLmUiDK4Bk6fwqYdjFP9SW1FMOpKhbmGNEU/G6VwXrN6cSRFPtpVA3xD8RHiRtB85wtRURuzlS5H31CXwbzAD435mQn95b9uT6wReWsczG0Hwwsd2tDz58R5wYijVG662GZoIJS+RT5hwjx6q9YM6DCOFBtlSwWoLJ968=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216530; c=relaxed/simple;
	bh=JFShJ9ZGyAHy3xlxdXCdQ322V3GPZdynAxbyqeMLCLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmQFWGosFWPPvN/XVsx6QkL6ioag7RTo8k1Ylue7Vmjyj3s8SeVCc/LBT/4CMqveBPPtEPz94oVv7IXvQ8dpE3vGtmlo7ag2tvifi6oMMC5IOM1CEwtOun8Eb8/HMzUp4EcqBnsl4ZlgA8ssQiJUVULsGMR+/YfjPN8NLHSuuxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW404WBE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW404WBE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C366C4CED1;
	Mon, 10 Feb 2025 19:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739216529;
	bh=JFShJ9ZGyAHy3xlxdXCdQ322V3GPZdynAxbyqeMLCLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NW404WBETvv9OB33hIsDbc7w1OJJmbh/FtbBxF1FTdyG95mzkgdMAQCKarzewDVrf
	 ndhETXLPvWp+Adukx8P2ZJW+n2ETyopbpofzznZZrkcgOZY2Wbj9TiEX5m5j6RPUeM
	 5vM35I5YwlQyZFoM7mV0U5X1YrQ1GtrFKC/Hy4w9oQUqz2eIqdmS7yA6OhlhoWNus3
	 ej7j2TsUOKS8pPtH9ZkXDzLGEQ5U95gLBm27K3WSw1KDk690GKRTjod0Imy7xM9HZk
	 ieVX6hztXhfDA4CHbOe7fdMWRE3q3sSh90vZJUcVNgWiWZftYBk5n+0/S0C28VdQrH
	 WpkUuQNOctlMQ==
Date: Mon, 10 Feb 2025 11:42:07 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/11] Python improvements for a real use of
 parse_events
Message-ID: <Z6pWj7jlH6ucKXDu@google.com>
References: <20250109075108.7651-1-irogers@google.com>
 <CAP-5=fXL=nS1-m1+gJsYfWfvyn0ouikX3=RvyKdiM7+ewS9-mg@mail.gmail.com>
 <CAP-5=fU3beskCJLQdKE8Mjdsx0wTiihh7Z9k7VQtZuJBZC5b6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU3beskCJLQdKE8Mjdsx0wTiihh7Z9k7VQtZuJBZC5b6Q@mail.gmail.com>

Hi Ian,

On Mon, Feb 10, 2025 at 08:06:34AM -0800, Ian Rogers wrote:
> On Tue, Feb 4, 2025 at 2:23 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, Jan 8, 2025 at 11:51 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > While parse_events access in python was added, it wasn't used by any
> > > python script. In enabling this for the tracepoint.py script a number
> > > of latent bugs and necessary improvements were discovered.
> >
> > Ping.
> 
> Ping.

Thanks for the reminder.  I'll review pending patches this week.

Arnaldo, can you please help reviewing this series?

Thanks,
Namhyung

