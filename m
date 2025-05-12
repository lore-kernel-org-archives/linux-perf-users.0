Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C5A1A08CA;
	Mon, 12 May 2025 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072347; cv=none; b=PPW91oqz7EgH5eOQALowlzTtg1KVb1H+wxk8FiGK+f78CGP5hAJ5PPT5RRUScHo2fmnxlKjqYYaQZL8Z2DRvMXlx59qehATmjB8n5spmM5FZwN7ltTLbH/gUcZLdzGhTNGkUvjoCehNQajGde8X+8nJ2OBFZo2Ero3Cp3zkNfQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072347; c=relaxed/simple;
	bh=++CgEg+MfaNUTMcBWmgLqTXtI9BuhzQacGDIAVYESS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbqBy+5RQnM4p0FRiJYHa7Ji9J3JLcNlZDvfuARkqPHGLBfDS43DyjnIA9oaVku7+shEjuATjgh430bYjJPTHzNOMEDX70cndRfbAf0trP85vKpbeL5AZwjmeDjZvkFAur51djdv65bF6bQWVEiYI9BAKtGrwOgmjZUHFS9eqAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X67Wc3Z1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X67Wc3Z1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C21AC4CEE7;
	Mon, 12 May 2025 17:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747072347;
	bh=++CgEg+MfaNUTMcBWmgLqTXtI9BuhzQacGDIAVYESS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X67Wc3Z198yQFeWreYOg8rQLEYBW56ibr+bYAyAL1t+t691KdnGJBpDdopc/IgS95
	 sJ0dagfpF5ckpLdnAjQHNCi1gINYe0wqVR02ztlCtRk53OV8fgdRM8J6+/m4MrJoLH
	 uJIyY6JAV8DPos7KnQ9NYsUpzVqw8WTHjvZspny+5Nn4YGbFDW/Dvigyae2iVY65Sq
	 ONffLztIlaqUtF7vSoGpq9aXsA2azB/MU7REnsN4V3x8fKG9kMNQ+jzb9A1ZlZ6UjW
	 2rA6VzUzN/soeVfLItYePbfQHiXtY6VTkhm4WvhP8YoH8f52dLzpgzyb1JHGr/C09L
	 Xy2S1y22p8tjA==
Date: Mon, 12 May 2025 14:52:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>,
	peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, howardchu95@gmail.com,
	yeoreum.yun@arm.com, linux@treblig.org, james.clark@linaro.org,
	ak@linux.intel.com, weilin.wang@intel.com, asmadeus@codewreck.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/3] perf evlist: Make uniquifying counter names
 consistent
Message-ID: <aCI1WKq1ZmUUpMzt@x1>
References: <20250327225651.642965-1-ctshao@google.com>
 <20250327225651.642965-2-ctshao@google.com>
 <aCI1JRjBBINe0set@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCI1JRjBBINe0set@x1>

On Mon, May 12, 2025 at 02:51:37PM -0300, Arnaldo Carvalho de Melo wrote:
> Can you please refresh this series?

I mean to what is in:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git

branch tmp.perf-tools-next

- Arnaldo
