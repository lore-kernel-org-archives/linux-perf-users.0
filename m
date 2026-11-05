Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876985;
	b=eacuDrhnq3Qp42EZkkikC14WUsJresqAdG1nI8psgCuXeq8AKQsIYuKJviNRYFR6KYWg
	 gjR2ijqrw0RDB9j28c2tPNpKSWHktH+AL9ELISY1Eqc4de9UJ4yns/TQEloTn24MoWUVO
	 ITHdd0m+HF5N63u4jWJ7T/9OrWgej5diAyE1fbCf2ecRbTh8bE2AahIK9nqIN5wIH6isw
	 t5Mf0yiHfCP/+XwwYYGKl2CcHiDd7UFrPPw3zYelrVmBDIVKGIRLAdh4Lkk68gTR7uWsH
	 4oxM01TSutjvMDzRj8EDpbCL5kkBuG47/TaFKwDXuGkLNSASix0LOfwQSh/eEV+KKsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876985;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=m8TYQDbBorP+Y8/mcxs1YV2SN8jaCkCbqjTXDq654Rc=;
	b=tOici0fefTpl48GFJXxhLGAW0Up48OMSXTEKbIPQZTBgDc7em2OZh2B4I43JYGbh8pnb
	 UJJsOHID9mGNi4k9iwS/R4/+k4OxJSBAhANRMzSGpryZ+VEOGGfw2QmNWB6GOaLZga3wX
	 mZFZihx7vHaF/ewe3EYzGMwxhANcwNIyLA7la6hr+Yb4jcOj6V9BrX7+Zt0uQemSEbFVL
	 RqZZiKa+GYGfZtqxRa6AntzeHY+LMnUnFzOx69C5rDj7+Avlj8J9yX6uSiu8qHUfEkfwy
	 MLfPJOuIHu2PJhaKwyLOM0MfxSWr4TbIxPUCR+r/ZRYfXOEBSwN3y5ImsGu1Y/E+PKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qLLZbdbJ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DC1606A33F;
	Thu,  5 Nov 2026 11:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43DC1606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=qLLZbdbJ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BA0E1516;
	Thu,  5 Nov 2026 03:09:40 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06F553F628;
	Thu,  5 Nov 2026 03:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793876983; bh=m8TYQDbBorP+Y8/mcxs1YV2SN8jaCkCbqjTXDq654Rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qLLZbdbJGO6z9X7cFqeJoqunE7s46fV2XtIwY9R2NmOr5bJ8IdJ5Jo+HO9AXWUouH
	 FsmCpRZ/vEb9kMNnp0+/M6PHzL2yLwp3xnR5GhEjKgQbLqKJf9Md0kiQ54kImSTdIw
	 aReu5CvCL+GmzcZMRW1V3+bFNBTyDm38QjynbuGc=
Date: Thu, 5 Nov 2026 11:09:41 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org, John Garry <john.garry@linux.dev>
Subject: Re: [PATCH v3 18/18] perf test: cs-etm: Test multiple per-thread
 threads
Message-ID: <20261105110941.GQ9176@e132581.arm.com>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-18-dbcb0c281b9b@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-18-dbcb0c281b9b@linaro.org>

On Mon, Nov 02, 2026 at 12:15:32PM +0000, James Clark wrote:

[...]

> +echo "Recording..."
> +perf record -o "$tmpdir/data" -e cs_etm//u --per-thread -Se -m,64K --pid $parent > /dev/null 2>&1 &
> +perf=$!

s/64K/128K/ for test on a machine with 64KiB page.

Reviewed-by: Leo Yan <leo.yan@arm.com>
