Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E53374D9;
	Wed, 26 Jun 2024 03:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719373991; cv=none; b=EJYDXgah0eOKWu6Q3ZYCV7M43h52ZDC8OCbTjCEKhHE3eLwhVsRKIZQWI7JE8SliVqXvTDCXFuQEkhN+TeZv3oLal6zAjC1nwGkVcxGF3tITrwpRuiO+ArmPg3kYl1SunErMiNiOcmVMfNjYfItto7trqHlKARn0+5ouemQP/Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719373991; c=relaxed/simple;
	bh=U9pyu9yrz6dqp36FW3J9PLBA8l1JLbg9jGMFE4kDsEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OPC5dggH0ttFzy+AxRRR30flOP6Tx1i0NeD/6V+R3N+YlLSZt8t6lqUvA5Z13LI4SCAhxJHBcfwUl/6Wh80iA1Lay0OaVDSHoVD7NL43JYx6M1seRBw9poEjsWPe57VuFxfKdjH9kSwmlhQ0MZ1mpSQmbMBpVhsPekHg90Dz2Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikbWON6A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikbWON6A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6416C2BD10;
	Wed, 26 Jun 2024 03:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719373991;
	bh=U9pyu9yrz6dqp36FW3J9PLBA8l1JLbg9jGMFE4kDsEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ikbWON6AU/WppYVB27ag1hPlWGbugorL2dRBnAqR2nd9eD0g6oU3OPSybvwuLbMW7
	 h5VvROptHFw0vpovPBikzam2i/uONqIhTJEpuKnTSW1GW5X0CzQKWZSgxkmAppjuqm
	 72KfpW4qH2Gk6dTbOyaQLrmczEDbVBSzZTvyOMOwkA0PJy3tG0/Yo1JjQuKleO5j4f
	 QoIA2Zd558idBqlNQpeyDUS2I/TXG1k4V6OhmCctovjpSPahGTgXiP1A48A3pKVbvt
	 p5uj5SRISQG3J6aVEnqxaVEH4dTlyucblzVHLkc2X+p1mPCaXI9OgHWEDWqtc7rgGP
	 E59wdcXUsGN2g==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org,
	James Clark <james.clark@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Spoorthy S <spoorts2@in.ibm.com>,
	German Gomez <german.gomez@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: Make test_arm_callgraph_fp.sh more robust
Date: Tue, 25 Jun 2024 20:53:07 -0700
Message-ID: <171937396645.2856613.6564241960168759110.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240612140316.3006660-1-james.clark@arm.com>
References: <20240612140316.3006660-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 12 Jun 2024 15:03:14 +0100, James Clark wrote:

> The 2 second sleep can cause the test to fail on very slow network file
> systems because Perf ends up being killed before it finishes starting
> up.
> 
> Fix it by making the leafloop workload end after a fixed time like the
> other workloads so there is no need to kill it after 2 seconds.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
