Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ECE1C1AA2;
	Fri, 27 Sep 2024 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727456402; cv=none; b=ML1Poi8gvUEBdTWkFppDw0UZdYVEzpkFTMMiLtbAoFXZtXkxGC4cH6EwJMy1H86VG8SoScQBG4Z3j7MSVWjKrEWfjvKJJAQw2VxGPfGE2PrHghlaKgmr4WGVmx22uhSItJS+fYetNqVyTCBXCOjY343JyivvFz1sXcyOnF7agH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727456402; c=relaxed/simple;
	bh=2ApnVOpy3phuG2Yl6/xKeNiOdwIr7PHbwb1uUNWV3Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8ALWqfCoZhwSukh3MqVho7+A5pWe5Bum46NjaHZqnuFFq4fiJ+5SiUab5XKa0kQlrrWpq9ZOKPTeVDz1HwKqTFa9LkZkhAIKXmX7uEpsMBSxPCtZ9G9vJitFLFeBYr4gvdczjnFUJO/mS68bNVKGYDzLIJkRWlWlM4rmUVAvBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sp4lDaXh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sp4lDaXh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FFDC4CEC4;
	Fri, 27 Sep 2024 17:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727456402;
	bh=2ApnVOpy3phuG2Yl6/xKeNiOdwIr7PHbwb1uUNWV3Ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sp4lDaXhYOW/ZY4+SO/sT2KX+HqwkS8DSVU0d3Xty+9CiIpBG6W6m+zl70HAZm3fe
	 9+1mFqYEwKk3m6HckbEtwxVsCZemxJuHoIaSJsWZye9vsvT7x/fEx2oOZySdxSQOqD
	 t3nC9XK+XYl8Q7hwVtEYhfbdXbYqQwseF7Awwm1lc+eIa/YfkYp3dFjv0ymKZRtWAl
	 3oE4Sd4OpZ3+5o+gcy3blskDS81ZXMl9uG5H+KeXjSc3y8NOr/iU3Ehg3agnzhojWu
	 rYwzf+c7jqs1Ox0hGNYbP5P9doYXdFJNNSNUtQMlokUknlSsoJwUcychUoSog1qgHV
	 UtmF6xqv8lOVQ==
From: Namhyung Kim <namhyung@kernel.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com,
	ak@linux.intel.com,
	James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yanteng Si <siyanteng@loongson.cn>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/7] Event parsing fixes
Date: Fri, 27 Sep 2024 09:59:57 -0700
Message-ID: <172745636991.248403.11015785931495275902.b4-ty@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240926144851.245903-1-james.clark@linaro.org>
References: <20240926144851.245903-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 26 Sep 2024 15:48:31 +0100, James Clark wrote:

> I rebased this one and made some other fixes so that I could test it,
> so I thought I'd repost it here in case it's helpful. I also added a
> new test.
> 
> But for the testing it all looks ok.
> 
> There is one small difference where it now hides _all_ default
> <not supported> events, when previously it would only hide some
> selected subset of events like "stalled-cycles-frontend". I think
> this is now more consistent across platforms because, for example,
> Apple M only has cycles and instructions, and the rest of the
> default events would always show as <not supported> there.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
