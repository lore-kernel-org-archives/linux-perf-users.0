Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794857720;
	b=X70tzzX1XXP24Z3gh6eXMouBbigdNksCChv2/eFYsHyapm+b1qHWS0GUlk9VFTGJH1Fo
	 /jMZ3sF4DCEndMKAyegPQSs1xWpmN+MYjenfOOfAHHV/zrdj0WgAFoxalq6wfNHthwk27
	 aTEx9WFX6NQewQj5UBL8CUJj2vDgMMr19/ThXdXYimtq2WK8LBwMgoIpNN/TL4sFcfW6i
	 HU6fVbRhhF/+kU4VADefWueIex2byaSy4dOEDUhG0mU5hwJVo3Gp6YjXzUbm4xwfwvdAp
	 v59qlBlKZOt6H3lkoFZXyM7F8GYPAFwR7z5t8nyYykxJVe9REockiugYC89FgT8BB2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794857720;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KVx0HA0roWURnnBDHsvqSQeW78VRnmxDdAQEbPbEj0A=;
	b=wbzk5G8Mi9rBvSNabZK+yws9pwdGTv083njFybAJLXWzwgTijZ06d66gqrKHVuHCGjlC
	 Uj7FVZKXGjEmIca7sgJFrJO5DwpZ5YdE3fBlW6OTQkBMaih26hFS+HlpiYs3mmVDgVKyK
	 QXU3a+R1NBu8nMJg+IZTI75CjR4kCYYZhFufJdwHs2jd3mtsYCAmFhoWXIq2l1IE3KV9/
	 BhVs0rrxTyO51UcCUbHN7s8ZQqnHcSkdZz6JRC96KgmWr+zCZ4Z0SO9yXNFeL1prPkhzh
	 H+5JwA/0jGXv7gAIDN5Rw+pJCtx2a/yj35Xu95ih8fj697Y94Rz29Jq1i5qjhGFoWdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BiUErlqD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3AC606A31C;
	Mon, 16 Nov 2026 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BiUErlqD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677621F000C5;
	Mon, 16 Nov 2026 19:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794857720;
	bh=KVx0HA0roWURnnBDHsvqSQeW78VRnmxDdAQEbPbEj0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BiUErlqDgaKqzqpnLNxc40McUXBILQ+7ejZlWQnkqRvGU2sQh0eAH7Ijkn1VqaFHk
	 luWXCQPlnjIPgkChdbMczh7grwtAmKDvgIBJ6WEAgbTpqI2AJhYraU1w8sq9Jol4GZ
	 t7hZAk3CjHcbownKmfsIvbAoa3gB+CKXtoP4nyk+CfeJtjibnhgE9OHEa6X9vjM44n
	 R1wmaDfSeycprA1FiLhLWJOwqwYw4jJATrz+Uunhh+jhl++4LNi4wOI8YtNpTIS5Pu
	 Xgf5Jsy5aIhd/Yw4OICKU4zGOoumvjjP42CXKUnaDVCAltfc4AR3lUkuGinWk48nsN
	 7SW1F6ei5RZcg==
Date: Mon, 16 Nov 2026 12:35:13 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] kbuild: build the userspace tools in tools/ with
 the kernel
Message-ID: <20261116193513.GA1037705@ax162>
References: <20261112195427.3411746-1-sashal@kernel.org>
 <20261116182426.3440056-1-sashal@kernel.org>
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
In-Reply-To: <20261116182426.3440056-1-sashal@kernel.org>

Hi Sasha,

On Mon, Nov 16, 2026 at 01:24:26PM -0500, Sasha Levin wrote:
> Will you be picking this up through the kbuild tree?
> 
> 3/7 has acks from Arnaldo and Namhyung, 4/7 from Namhyung, and Shuah and
> Thomas reviewed 5/7 and 1/7. What's left without a review is the kbuild
> side: 2/7, 6/7 and 7/7.
> 
> If you'd rather see it go in some other way, or want something done
> differently, let me know.

I intend to take a look at this either this week or next. I assume we
will want to take this via the Kbuild if/when we are happy with the
implementation but I cannot make any guarantee. I totally empathize with
the reasons for wanting this listed in the commit message but it is a
big commitment on both Kbuild's part and other maintainers to integrate
tools/ into the build in this manner.

-- 
Cheers,
Nathan
