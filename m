Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1744231728
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbHHOFAX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1F5C433C8;
	Mon, 27 Nov 2023 14:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701095792;
	bh=5N67lpXP0UXrwirahbaaTbVq0pEySLEa1Tt53l6PZbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GbHHOFAX5vx0F9KRJMO9Ub3UUJ/dGoCPDf89NIm3Oe/S/jDu6w223ca4Ud0G4iwy2
	 PZdW8vn8kjxd425MvPWC9c/Gc63WMoto3YseB4KtKZAn1LL+CQSC0z/PPTBg42SOYL
	 sVPuMjwzpmxpVXYlacSxyrNzDVWB9l9e9BFSkSVFtu5QsG4e8gT8d0I+yqopsK1QK8
	 +9HFMaqwpNajG3o5xzGE09WeAtDd0Zl4Tnl3hRiRxEV3KbCDvyZZz2OO3skbWKs8+B
	 m8OV5hWDh8DgHwGiiALiSQB9KE7nE2tR2UmLrXqe3gL+UiUj8/zDr7k1/GISUSOmKv
	 CHBttdGt/gePA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id CF23440094; Mon, 27 Nov 2023 11:36:29 -0300 (-03)
Date: Mon, 27 Nov 2023 11:36:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: zhujun2 <zhujun2@cmss.chinamobile.com>, suzuki.poulose@arm.com,
	mike.leach@linaro.org, leo.yan@linaro.org, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf/tests:coresight:remove unused variables
Message-ID: <ZWSpbVglhX0T0/o+@kernel.org>
References: <20231115064255.11057-1-zhujun2@cmss.chinamobile.com>
 <a7f2715f-a47a-c619-329f-668f8c7b6b12@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7f2715f-a47a-c619-329f-668f8c7b6b12@arm.com>
X-Url: http://acmel.wordpress.com

Em Wed, Nov 15, 2023 at 02:00:21PM +0000, James Clark escreveu:
> On 15/11/2023 06:42, zhujun2 wrote:
> > These variables are never referenced in the code, just remove them.
> > 
> > Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
> > ---
> >  tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c   | 1 -
> >  tools/perf/tests/shell/coresight/thread_loop/thread_loop.c       | 1 -
> >  .../shell/coresight/unroll_loop_thread/unroll_loop_thread.c      | 1 -
> >  3 files changed, 3 deletions(-)

> > +++ b/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
> > @@ -42,7 +42,6 @@ static pthread_t new_thr(void *(*fn) (void *arg), void *arg)
> >  int main(int argc, char **argv)
> >  {
> >  	unsigned long i, len, size, thr;
> > -	pthread_t threads[256];
> >  	struct args args[256];
> >  	long long v;

<SNIP>

> Reviewed-by: James Clark <james.clark@arm.com>

Thanks, applied to perf-tools-next.

- Arnaldo

