Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E49D3207
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Feb 2024 01:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708480733; cv=none; b=tJCrqWlbtLZn5hklLx25g306kG2B6QiSjmc9lBVk4jmyXWdkta1XvfaQm6XALEvNpvlFta8PSivMUcP35PI8eibX+6tIZv2vYj4KmYPC1cvSukNhsUyWva9uU5acvZm2yMArHgkWY+PxHvBFr1NcEYev1w+CXULRd2jk5G1z+Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708480733; c=relaxed/simple;
	bh=xW0fQ01mst+fvg1mHKrHcLsI0nhbNPQoNwnfdkLFSI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQ9TLJfreq5Wwqd2UBX6GiboXE6AjjaOCgIvHs4nZ6J+FjbqH7tdT1kd1E+xoTqKJwAX/b93DyRAxDMZMKaiBz619TX1YMOJKvYKp+ydq//6iEUWg/GEvf5nlxvu62RFBmmXTmrdW/j7871axiXG+nsyWhpd9LR9kahPlQt3cs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBFwXJZO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBFwXJZO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D3BC433F1;
	Wed, 21 Feb 2024 01:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708480732;
	bh=xW0fQ01mst+fvg1mHKrHcLsI0nhbNPQoNwnfdkLFSI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mBFwXJZOikT1BjYRPIsqiJTLaG+vSi00vqM9oCffMM5sWrylSbpIdpiql2bcURr4T
	 fZCIKs33dj0I0fYjWWDnZI6y9lnP3aHAXiv0SoYSf4ZniGB/Mmqf3FYU1CfRV5OjYL
	 qXhoV++vzX3AqL/9jDaQ7dtfrdD+A7SnARqlZ9wWu9M9MAN+UZLrjk44Jvh3pT8g7w
	 WlHGgOCdq3HiUl9BoceF8ewKcEN+vBPCtpyuzEmRLOWsmfItyD8A58oKQbwpn2B6pb
	 jBKkFDkPVxE/Mqelw1lSXLjDHchmQWTSmQeIks0ivPGrCf+XBU6wTNubvL51bVujNm
	 1qvJekuvo2cCg==
From: Namhyung Kim <namhyung@kernel.org>
To: Michael Petlan <mpetlan@redhat.com>,
	linux-perf-users@vger.kernel.org,
	acme@redhat.com
Cc: mingo@redhat.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	peterz@infradead.org,
	mark.rutland@arm.com,
	atrajeev@linux.vnet.ibm.com,
	kjain@linux.ibm.com,
	irogers@google.com,
	acme@kernel.org
Subject: Re: [PATCH v2 0/7] Add perf testsuite into perf-test
Date: Tue, 20 Feb 2024 17:58:49 -0800
Message-ID: <170848061720.1313505.9675212976046086736.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240215110231.15385-1-mpetlan@redhat.com>
References: <20240131113951.17077-1-mpetlan@redhat.com> <20240215110231.15385-1-mpetlan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 15 Feb 2024 12:02:24 +0100, Michael Petlan wrote:
> as Arnaldo said, this is a first patchset of an effort to upstream
> the external perftool-testsuite [1] and merge it into perf-test.
> 
> The perftool-testsuite originates back to 2015, when there were no
> shell-based testcases for perf. At that point, perf-test contained
> rather "unit-tests" and there was a need to test perf as a tool too.
> 
> [...]

Applied to perf-tools-next.  Looking forward to seeing more tests!

Thanks,
Namhyung
