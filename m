Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD1D1F5E4
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Oct 2023 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjahxqQV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82214C433C8;
	Fri, 27 Oct 2023 13:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698413761;
	bh=zr+piGqNha8SH1IgRkyvQsYXO7OF+ckvJNeJmO5jOgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sjahxqQVlenRUlHbdEbRVeGC1IIxhJZXdbkEzZB+2dJ4sI1mqDmg12r+yjOkvhZAE
	 8Toj5bz3pGv7l1ta8LJTF/zIVNf/6+LWyyCm/KN8THS85QDI2QoCLaHk1QouEWcSu0
	 TQXjiSE+KOiLPNb4O+dwyc5INnDIiuBJKDQoYxPUeO0vCLEGk6H+3rarxbwYDSK+7L
	 Grlb1msx2GIbUbFwNL/DWDZAS94G51BexlAaR1RGi/8I9NHLEH1SMXKusp3OLyUbOQ
	 f85jJP7riZKW9BuXiUPRt1PJsAlFMIwrO8gtR6vHca1WawHXRFBJAiqE5rKV67DipI
	 P4PzGMTdlNVdQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 8203F4035D; Fri, 27 Oct 2023 10:35:55 -0300 (-03)
Date: Fri, 27 Oct 2023 10:35:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yang Jihong <yangjihong1@huawei.com>
Cc: Namhyung Kim <namhyung@kernel.org>, peterz@infradead.org,
	mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf evsel: Rename evsel__increase_rlimit to
 rlimit__increase_nofile
Message-ID: <ZTu8u3bgNCOhTx8U@kernel.org>
References: <20231023033144.1011896-1-yangjihong1@huawei.com>
 <ZTrCS5Z3PZAmfPdV@kernel.org>
 <CAM9d7cjhSSV+18ZCHLdTFpMM+MmpoDkYSGjUa5JKZp02Kx9XRw@mail.gmail.com>
 <3458c302-8c43-51e5-f45b-c18657fa7015@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3458c302-8c43-51e5-f45b-c18657fa7015@huawei.com>
X-Url: http://acmel.wordpress.com

Em Fri, Oct 27, 2023 at 10:43:32AM +0800, Yang Jihong escreveu:
> Sorry, only rename helper and no function change.
> I didn't consider the scenario that might affect test python.
 
> I've submitted a fix that can be used if needed:
 
> https://lore.kernel.org/lkml/20231027023028.1106441-1-yangjihong1@huawei.com/
 
> Also, can we consider identifying this problem at the stage of compiling the
> perf tool?

Yes, I have:

$ alias m='rm -rf ~/libexec/perf-core/ ; make -k CORESIGHT=1 O=/tmp/build/$(basename $PWD) -C tools/perf install-bin && perf test python'
 
And use the 'm' alias to build perf.

I also run 'perf test' before sending patches upstream, in addition to:

make -C tools/perf build-test

I encourage everybody to do the same.

Additionally I run a long list of container tests on dozens of distros,
but those should really be running on some CI system :-\

- Arnaldo
