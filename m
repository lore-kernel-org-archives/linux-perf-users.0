Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA5F126BF1;
	Thu,  2 Oct 2025 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759433755; cv=none; b=egmmwNwoqJ+IMY6ZrPpUo2UtU1cyJgOuz3bAUN3wW8pbIiknYQVSeG87DhbPbbI3vgkGrPzka4FrjnLonA8UqG93W6kXNvn7uFEshounSvOMCAfX5hReXeraCEIKEyr+Tx5PFrxJV0sPR/bohTkRcTX/5Tq6aXyoEnprYsk2WZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759433755; c=relaxed/simple;
	bh=q7p/tifjFczA1gMFf63QPDiVETBbGwwp+q0TwAU9zOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Luyoh2rMuBa0jozwpjRxEoqV5FkJJ5fmffguHu/1/51Fu/bHb/oq/ou7No9UZey2P4mneuQ2+yIuBMn5GK57e9Km4UtdFv3ytkGwp9qs+jBjJEQaRXmvnyJsXg1H1RQ3TDzosos5FbHQslcdmPONW+J8SYMA0jEvPdhFUgscM7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iwx+QwM/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iwx+QwM/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C0AC4CEF4;
	Thu,  2 Oct 2025 19:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759433755;
	bh=q7p/tifjFczA1gMFf63QPDiVETBbGwwp+q0TwAU9zOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iwx+QwM/xkq5+1HT51UhAzy5/6hdAFX3ByPmHMmWIceCH1xe7YIMh8w4hI17gfpxS
	 JJO8WLoM66Te3uTuCS37pZuA6dNym9z/Z4AhfJ0g10pPLHLb29mg0YiokBOC0j+vl7
	 JNLwS7fT5oSiPCW3bV7d6yqPXrE3VKwTpBULH6zz6rBdJM6Zk6ZbMr1H6hBjIcRw/D
	 4cfYLftMg9ibP5fjtvKytcXfZGJb9y46rvHIl4aT1GDXYmmypbQMeTkNhnKDUEWd6t
	 3K8HrG0tXQw65U7kp5Ye8C010pp5PYgDycijqrvILcQiP8wmgwYz6dCFQQH3prw9wW
	 ifgUyJ4YopTCg==
Date: Thu, 2 Oct 2025 16:35:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [RESEND][PATCH v2 0/2] perf record: ratio-to-prev event term for
 auto counter reload
Message-ID: <aN7UF0MwmQnzk72W@x1>
References: <20250902164047.64261-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902164047.64261-1-thomas.falcon@intel.com>

On Tue, Sep 02, 2025 at 11:40:44AM -0500, Thomas Falcon wrote:
> The Auto Counter Reload (ACR)[1] feature is used to track the
> relative rates of two or more perf events, only sampling
> when a given threshold is exceeded. This helps reduce overhead
> and unnecessary samples. However, enabling this feature
> currently requires setting two parameters:

Can you please try to rebase to what is in tmp.perf-tools-next now?

- Arnaldo
