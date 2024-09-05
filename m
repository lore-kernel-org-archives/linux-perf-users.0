Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2AA19E7F0;
	Thu,  5 Sep 2024 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549089; cv=none; b=QY9jAKHQag6PbGHK1LcSJ1H1dOYM0aQ7os8NehY/ezYvsMdN07RKDnmLWVGq1uUuEo1S/2H633llF/8RM+YYHtQCz+fSHjMCgcbSfoejLAeH4K2tCy1yJDtJZu+564VISmuaOAY3qpj/7zQ7FKEvUuzeUPxguTFws5G5b6eVY8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549089; c=relaxed/simple;
	bh=+Y94aJbrJdD5TlvV3AaONKscPppVhnDQVzMYJeVKXI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjToQ3KT3I8uzISroKR0rq4KuJxy3kJZ4S/fvMsL3MrIhqsfgxpHzdndMg3gHuO6j5tfu7750mA9cSQ/pABWUYmtw22Z6dfjiBX4nnJoqkbochA17JIP4e6ePekOVPt9gAUDFTiwhu8fBKrhXZugTb036wgFH+mFy0yeWUOvVyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esv+yTeJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esv+yTeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A44C4CEC3;
	Thu,  5 Sep 2024 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725549089;
	bh=+Y94aJbrJdD5TlvV3AaONKscPppVhnDQVzMYJeVKXI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=esv+yTeJgiHHveUrVLepL69Y2eW44Asf64fEZ5MgzCl2ZtOYSCZ/mQbqNR6W73ryz
	 15y+No8y8K+lwYEqtNckFlPnaGWj2wtqOlt7Q2JQN1F6F4KqatwoQ1znXO9UfSjwMK
	 LxyuYZadG8TrdThPdA0p/sp5u1GUlWel/B5i97m01xWMX6iTj0FcnnZgn5pNEMFt8J
	 kPROxQVk8Uv/NBQT5H8UMkwI6RxJ0MHmEnA7XhtqGwS7xuuuhLgEaGmb1//pW2zYJV
	 WWXpnyolrT+fuboiLH0R0bgXgsfdUYNJeSwS86PvRuvS/GsdFnVxFGMeLXqRpstUfs
	 C5frHn8zAUjCA==
Date: Thu, 5 Sep 2024 12:11:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Xu Yang <xu.yang_2@nxp.com>, Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1] perf jevents: Ignore sys when determining a model
 directory
Message-ID: <ZtnKHsXiZDGbz6l8@x1>
References: <20240904211705.915101-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904211705.915101-1-irogers@google.com>

On Wed, Sep 04, 2024 at 02:17:05PM -0700, Ian Rogers wrote:
> Existing sys directories aren't placed under a model directory like
> skylake. Placing a sys directory there causes the `is_leaf_dir` test
> to fail and consequently no events or metrics are generated for the
> model. Ignore sys directories in this case and update the comments to
> reflect why.
> 
> This change has no affect, but when testing with a sys directory for a
> model people have reported running into the no event/metric issue.

Thanks, applied, if Stephan is satisfied with the fix and have tested
it, please consider providing a Tested-by,

Thanks,

- Arnaldo
 
> Reported-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/jevents.py | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 1d96b2204e52..bb0a5d92df4a 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -635,14 +635,17 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
>  
>  def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
>    """Process a JSON file during the main walk."""
> -  def is_leaf_dir(path: str) -> bool:
> +  def is_leaf_dir_ignoring_sys(path: str) -> bool:
>      for item in os.scandir(path):
> -      if item.is_dir():
> +      if item.is_dir() and item.name != 'sys':
>          return False
>      return True
>  
> -  # model directory, reset topic
> -  if item.is_dir() and is_leaf_dir(item.path):
> +  # Model directories are leaves (ignoring possible sys
> +  # directories). The FTW will walk into the directory next. Flush
> +  # pending events and metrics and update the table names for the new
> +  # model directory.
> +  if item.is_dir() and is_leaf_dir_ignoring_sys(item.path):
>      print_pending_events()
>      print_pending_metrics()
>  
> -- 
> 2.46.0.469.g59c65b2a67-goog
