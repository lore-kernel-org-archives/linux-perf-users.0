Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD6A78F36;
	Tue, 10 Dec 2024 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839639; cv=none; b=Fme2AHg0jNufV7933RV4Z2+S4qGZQXYTseY4yvXpJ+JSf3idRU3QYYYLEk3u4UdUuj/NIOC33b0t462VQY3ebvtizA+r4LRe+2OivkBhoTDxHam3bEwM1bbmnYUzIvjKj72bd6AlAi1eWRVFkYS0HiMlALNIBKdqIWRS6GYTuWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839639; c=relaxed/simple;
	bh=i9G83b35R57ZrkD9ceAYPAVQmGkZPFS0wVEM8ZlFXYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjvA9X7pigHHjY89rmvf1ufMz96yy5DIPsYMwKNo9XDs2sf173kogza4569aenV7Ub9CYfW7a+muxc/lGfatILM45VHuR6aqMD5yoOOmc0mNnGB6RvMVQWpgWBsQ/9ZSJcCrKibAIMFYylYYjfzVxL1Ex4IotOvdbqn5gAtJOcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hohfcpAy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hohfcpAy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E97EC4CED6;
	Tue, 10 Dec 2024 14:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733839639;
	bh=i9G83b35R57ZrkD9ceAYPAVQmGkZPFS0wVEM8ZlFXYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hohfcpAyEew2WhwjL/IXEsWcOQ1wPbUTqBid2L4cshcjM0Aw4txRyHGB1Z8BNpMrM
	 QPP0xt9M14fNvbLveRyNL6V8DluRM47cjV5QqleTeRSPW+YFjl030nux9D4YLqTW6b
	 8KyH4ua5GWQKX+Bj+ubiw3ygSuU2JAV6//3YptawVKzcs9TXxAtJiubhaDNNINqhb9
	 d+q80jUFvbF++IjIswb2u1C4tpogbtzOq4iXubRSQLe+y1gQql1NprEl0uHbu4TOjK
	 dJJNk1G1/FLlPTeynuv4xIE1Fa8zMNEbbfaqfUxemb0WtEnDH3a/AQlZJHxVp/EsEo
	 028/7g8PIIR8Q==
Date: Tue, 10 Dec 2024 11:07:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>, thomas.falcon@intel.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] libperf: evlist: Fix --cpu argument on hybrid
 platform
Message-ID: <Z1hLEQwYE3ymbrIr@x1>
References: <20241114160450.295844-1-james.clark@linaro.org>
 <20241114160450.295844-2-james.clark@linaro.org>
 <Z1hHc-Q-TKgagORu@x1>
 <eb8301ec-50af-4414-89e7-5d49585bda47@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb8301ec-50af-4414-89e7-5d49585bda47@linaro.org>

On Tue, Dec 10, 2024 at 01:56:21PM +0000, James Clark wrote:
> On 10/12/2024 1:51 pm, Arnaldo Carvalho de Melo wrote:
> > James, the second patch isn't applying to perf-tools/perf-tools.
 
> The second one applies on
> https://lore.kernel.org/linux-perf-users/20241113011956.402096-1-irogers@google.com/T/#m2a3587fb83e6ab2d970bae25982ae9d6c8d9e5cd
> because that also does an evlist__remove() which gets fixed up.

Right, I have to test that series on the ARM machines I have access to,
but there is a question from a tester that is waiting for a reply, I'll
see if I can reproduce that problem as well.

> But the first one is ok to go in on its own.
 
Agreed.

- Arnaldo
