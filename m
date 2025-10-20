Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936B022538F;
	Mon, 20 Oct 2025 02:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760926332; cv=none; b=KYn8zRWY8wpFIIT2lHEnauN1p6Wggy7mr0lc7BWMxdo3cSXMoJxRsKJe/ZeIrdXxERaz2B46MI8/nTDZ4OylYZhdd2N9U2JK9Phdv3iftpRAgYz5irwi5YXLqfG9yi/VmnMshZkvsH0gHA7+p+9HGY2OMM7n9YXd0MQs0lWBZMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760926332; c=relaxed/simple;
	bh=dzyiYzo7zyk4OhvzaY3sm75ruiUQRzzjAMeJO3aQS78=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DptDG7eCeemFgcgPaDVJTKkuThIL3SG8farQ991MgfmPt5UE4qOyXx890TT5w376PsQALgf4NzsO3A07i/zdBYnR21xn7eyWISjNANVwvHTTEggilF/zciNeOS2e5XJp5aKlseDrj8yexDpUIeJ2RQwvlIKzgo+5qXh9SuMr8Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQ5zem+E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQ5zem+E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7878DC4CEF1;
	Mon, 20 Oct 2025 02:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760926332;
	bh=dzyiYzo7zyk4OhvzaY3sm75ruiUQRzzjAMeJO3aQS78=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aQ5zem+ETPt3uuqBXbHe8wMPVLqqMpUsM9KhLgPmp6+qUrO807dgHuCTPau9g/bM3
	 6VNvpI7yh+kCGpzLC/tGDh+lnYLslNASSzSmO97gcfoXxIbz4sQ03ypvuC7OxKt5xo
	 M9Ise1AULQebT3A1Qz+CaKEweZQ4Om3/9s++hVWpVqMRx8v9+ttIUQRZBGy4xNMSqm
	 pS9NRWNDUW/nCsSyCCniLnqhjcFfdo3M/0gy3aJsKHZIZhcn7rMVAE/0JEnDs+FhFJ
	 oWwrHMlhcqUdHFPAUryh0vAiFonRVM5ZhNoPLNsrAMFNezVLjciWBqEOJU3cuD46IU
	 /4zd18Issemnw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Tianyou Li <tianyou.li@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, 
 Ravi Bangoria <ravi.bangoria@amd.com>, wangyang.guo@intel.com, 
 pan.deng@intel.com, zhiguo.zhou@intel.com, jiebin.sun@intel.com, 
 thomas.falcon@intel.com, dapeng1.mi@intel.com, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251013144811.2021337-1-tianyou.li@intel.com>
References: <660c8ba1-635b-4acc-8824-d195f1b133a0@amd.com>
 <20251013144811.2021337-1-tianyou.li@intel.com>
Subject: Re: [PATCH v8 1/2] perf tools c2c: Add annotation support to perf
 c2c report
Message-Id: <176092632717.143093.8542782129366209269.b4-ty@kernel.org>
Date: Mon, 20 Oct 2025 11:12:07 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Mon, 13 Oct 2025 22:48:10 +0800, Tianyou Li wrote:

> Perf c2c report currently specified the code address and source:line
> information in the cacheline browser, while it is lack of annotation
> support like perf report to directly show the disassembly code for
> the particular symbol shared that same cacheline. This patches add
> a key 'a' binding to the cacheline browser which reuse the annotation
> browser to show the disassembly view for easier analysis of cacheline
> contentions.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

