Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9064318039;
	Mon, 24 Jun 2024 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251419; cv=none; b=aQ1F4KVs1lojd/yaUqP1zYp0H5vZCDDU1Ay9eM+uhrpasx3rH3d0mtt3LQzs1ziy8z9cvwDRnly/8FehjgLwJapNLcUSxVwnJiZEe4e3LGc2REq/R2N3cj6JvbFC6eC9S6nXlyAJTeatyOmJbgIdaHZ5uJsea5HBJ9/jYgEqIK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251419; c=relaxed/simple;
	bh=ogYUbuNQL5BXM2EOP0LvbHFudJK478Qsv5RWsROTs8o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZ4ZEGIS/2TeDwyc6d6VVW0R+xzwaiOb54egZjXcosXZmykkrMQKXNfReAncWhUGS7kcG3hZKdxJMmLrfriYt8pHsiIvn/BwRVbkLAXOQuqmvjdx0XCie3JiwNQopE/Zqs2McWa+A/NiLtx+px7IHTHUJEwvf3UpH2ij4I1xsGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqV7PdY9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqV7PdY9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72ACC2BBFC;
	Mon, 24 Jun 2024 17:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719251419;
	bh=ogYUbuNQL5BXM2EOP0LvbHFudJK478Qsv5RWsROTs8o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EqV7PdY97hcSM2SbHZIVtyfR9WNG860yRT5S9ybCYHPjIIpfGgGLLdpYp/wYxuzPE
	 6/gZIKqSc2DxM/LeOG1ZbKumXhNoJ8D0Ls8k/7TotqXe6zDkn9Q85yRLYS2E6tjU3S
	 b1Yvnaq4MpaRMllwUqJGDZbz56/ROkDnzGtrE/mWhUYn4Vi0vbZr68wRou+FQLEWYR
	 Ca6Na+YXOM+N2roSO87OulpobuXNsZUQCS95SaGv1oW1H4RbYtcnJ7MLTibKIfJP9k
	 E+9hhEijEVta4LTa1yWJzytUvlMTSae3Cy4biLAzvEdmZl8hudpt7QQZzvYQVuDd7+
	 yXf7TZ5iZtu1w==
From: Namhyung Kim <namhyung@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yicong Yang <yangyicong@huawei.com>,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v1] perf arm: Workaround ARM PMUs cpu maps having offline cpus
Date: Mon, 24 Jun 2024 10:50:17 -0700
Message-ID: <171925138897.1926472.5821855651002898264.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240607065343.695369-1-irogers@google.com>
References: <20240607065343.695369-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 06 Jun 2024 23:53:43 -0700, Ian Rogers wrote:

> When PMUs have a cpu map in the 'cpus' or 'cpumask' file, perf will
> try to open events on those CPUs. ARM doesn't remove offline CPUs
> meaning taking a CPU offline will cause perf commands to fail unless a
> CPU map is passed on the command line.
> 
> More context in:
> https://lore.kernel.org/lkml/20240603092812.46616-1-yangyicong@huawei.com/
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
