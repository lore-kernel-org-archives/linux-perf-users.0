Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED817219E42;
	Fri,  8 Nov 2024 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731087348; cv=none; b=ZdEE4GN24rwpbKvt3+97X3O9sNHY1TNl7w03O+CKn7siNsPRKZ7GQIA28qvbYMR5tEXpsMJGX8j+XjOuI+PJEYfp6ki+V+tip3fMZgXaDhuxOfbrVCddARwD2NU+CqcyNuPwcWTbFSBDp8wTK/g+5nhuU8FJsUQloucSoXxA888=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731087348; c=relaxed/simple;
	bh=nm3tZyz8yw8ax1S8KVN/nwnNSkyqjsJOfp5ZlBaJNMY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O4VKDWMQQWi4JtpupnTXZmUmmL+2Ru6oLxzluUCXyRfXtQ96SuulcyBBUJaJ1733MEB6XgtyAOkI9rJ/agodDARj7IV7hxbRHkHGLIQvHRUnFvfvBwY97J/DpLxHMPcIvHusp/Ph+r3OfOUtBbbN0kJd17iv461kEoHdBuh0bCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdTjujvu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdTjujvu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EF4C4CECD;
	Fri,  8 Nov 2024 17:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731087347;
	bh=nm3tZyz8yw8ax1S8KVN/nwnNSkyqjsJOfp5ZlBaJNMY=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=UdTjujvuQw7BDAp7QDw7RP6LHbp145V9eb+qtFneRdAk6+jOthGhQ5LTrTDX9GKFx
	 08vyPThGnY1YrJVepUt5L92jVPdCE2orgV89q1Is7/r6p+PHE/zR3g6Ag/Ow3vetCv
	 0oTwFsbCe9ZElmu3KDwfTe0xhS74kgfQ88PGGR7G+Ve8bweLfO3pdsT/T7q6AFsgIA
	 6ZouAEF4EJsZFp3GtFtcMSFFgitEeBF0T9LW+fTnZD+YndYyWaNrwUf0jM7/WGEa1i
	 WU+0lvQbYWWM00jmcMSE6plBDpQVEgbestX6fZdJJCpGdKCxOj/2LB2CDkNpzIneeu
	 h4jqVltoTgNWA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20241106004818.2174593-1-irogers@google.com>
References: <20241106004818.2174593-1-irogers@google.com>
Subject: Re: [PATCH v1] perf stat: Expand metric+unit buffer size
Message-Id: <173108734724.2649858.5846416268384949345.b4-ty@kernel.org>
Date: Fri, 08 Nov 2024 09:35:47 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 05 Nov 2024 16:48:18 -0800, Ian Rogers wrote:

> Long metric names combined with units may exceed the metric_bf and
> lead to truncation. Double metric_bf in size to avoid this.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

