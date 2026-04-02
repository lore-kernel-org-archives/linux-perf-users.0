Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A853890E9;
	Thu,  2 Apr 2026 21:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775167050; cv=none; b=jNunQF1ovMKUUkSZAuRoQEmhOgOAjjV0ffLR+ZSEfhRpJb65giEoP+79Vt7hjaYm0GLPJQE5vDVZtyxcti93XLcy01dOzJJ8h/cyQZR7QURynpl9WnArkX/2oJKvPzwEdAyw1WtmqC9bMMeAWz4iCoV+Gr4Ir+ifWCOH8Zo+zNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775167050; c=relaxed/simple;
	bh=ZrsJ9F6sX7cwQXbsBXR8KinvwNUV3f3wHBmQl0CCZnM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S6Jw1Rorr9+uFCL6bMIdTfAe8koYVFoaOjNUp+4ZWubl7iZGcN7s4+7Z1xUBVf23U9pQo00BQUCBbp+42W6807FmK43/b93VZ1FM86ZWxAUc6HzNgpMZF9kliEivWOYKnXkjv1Q0NddItcxR15VNBLCCAHifvu4fn9rxjsK7ssg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4Tnx0f4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4Tnx0f4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE01C2BCAF;
	Thu,  2 Apr 2026 21:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775167050;
	bh=ZrsJ9F6sX7cwQXbsBXR8KinvwNUV3f3wHBmQl0CCZnM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=D4Tnx0f4I3DgyFjPxjWcag/AkAscsRYPqF4AjK0xEgtcDwMJ9SRXtqNtJTwTsbplu
	 91rTvC71oeK7266/LA6phc3Xlq0UB8T6r9Fg0SuIlxp25wb3gMvwnnNfRKDz4a33j1
	 l6k/UfrhVj3FI4e/BX7n28Y0Z1LuCgWJCDdbzgcXMpBFzw6Y+RHByEQEfiBOBkyI60
	 8xqorAFVrkvnakhX9xKqrW+yFFLgefuw+MK+Ow4bGePk9E+GfcP3ShlESmZL8hgGe0
	 HegDwegzU7M6t+qpPsP8cGRdXzxFd0cZGqAvFlsVw/mxBVk4onvkuyiu6Wp9aA5JFG
	 dO1qOsWlEa2qw==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, 
 Dapeng Mi <dapeng1.mi@linux.intel.com>, 
 Thomas Falcon <thomas.falcon@intel.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
In-Reply-To: <20260327015927.223999-1-thomas.falcon@intel.com>
References: <CAP-5=fUFGevUhRROdybtDCXZgWgxYzfLrq_0f8r5_Yv_VfxP+A@mail.gmail.com>
 <20260327015927.223999-1-thomas.falcon@intel.com>
Subject: Re: [PATCH v3] tools/perf: Fix ratio_to_prev event parsing test
Message-Id: <177516705013.1014987.6817395144471651362.b4-ty@kernel.org>
Date: Thu, 02 Apr 2026 14:57:30 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 26 Mar 2026 20:59:27 -0500, Thomas Falcon wrote:
> test__ratio_to_prev() assumed the first event in a group is the leader,
> which is not the case when the event is expanded into two event groups
> on hybrid PMU's with auto counter reload support. Instead, iterate over the
> event group generated for each core PMU. Also update "wrong leader" test to
> check that the subordinate event has the correct leader instead of checking
> that it is not the group leader. Finally, do not exit immediately if a PMU
> without auto counter reload support is found.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


