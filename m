Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0256F3A6B89;
	Sat,  3 Oct 2026 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791018765; cv=none; b=elPuhpQNOrMK4zSam/eMBLWTse3Q6Qwyu8m9vZCnuEUbjcve6jbMk4DQVGTdMunwTX2wHAIb5gBy3ioaBO9TA80Ww7Rwl9qed7TVfEgucxbMz1a+mpVV3JwNawLoajeke9qLKQloW96ACHuPmChPhEovbFaVxViBbfX/z9ZhLqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791018765; c=relaxed/simple;
	bh=fTPr0Wm1T0EsfVlg/2TK5dAwyS+uRq9T6OVI3cmuhLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Grs6tt3JKrHy5Q8NA28TBpn4k87/JQfufZgp8/CWIHAX6IpAK8JhujsH2ptYv6PmBzUQB0VtdX5f3L0xrcnR22NQcKZPY0AK4U75qvW1VP7R7q+p0NA+cEw9Oth4+8/+6d6yGnxJi/LIV4bXNYLUTSH4kL4NhyRKMjF0C7m+fXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Px2HHYuy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Px2HHYuy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E4E1F0089B;
	Sat,  3 Oct 2026 09:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791018763;
	bh=SEbbbWZq8jxWso5TrFnPCZokEGwvWdJt0Hd9jFYVfx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Px2HHYuylUwFaJZbXcNotO0Hqrafj68EH7BF+/W9f1b8vdy+eO2QJV08e3R4rvfTO
	 vCBy2qUybArd/+vD8yP65UHwKs/mTCDWEhzNDfjEEiTIPB3iWsDGpOUjCeP+RSLTXG
	 xOtdeUy6QxlV9BNo5VSdGFob22j1EQbY2bDjejv2njWztolq5TC7RlaqjVHcEt/8N6
	 SNs8LneCS2F1k5nIc1hrFZIJrfDgv8UuZdwhVo8vSgQE2P7dpCn3LDj6uh3h2xBKpw
	 XAdQYwh7H1CYghKs0ivjuinBEH3NISLzeMEXvojAzLpsilPuoWcbuq8/qCWTKq8ZEc
	 gYCQU9qVhsQ9w==
Date: Sat, 3 Oct 2026 11:12:36 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Alice Rogers <alice.mei.rogers@gmail.com>,
	Changbin Du <changbin.du@huawei.com>,
	Tengda Wu <wutengda@huaweicloud.com>, tanze <tanze@kylinos.cn>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 00/13] perf timechart/list/treport: Interactive
 Textual TUIs and perf python session improvements
Message-ID: <asDHBIbfvCUbPT2A@x2>
References: <20261002182624.3259797-1-irogers@google.com>
 <asDGb6qOgJzXDpNo@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asDGb6qOgJzXDpNo@x2>

On Sat, Oct 03, 2026 at 11:10:16AM +0200, Arnaldo Carvalho de Melo wrote:
> On Fri, Oct 02, 2026 at 11:26:09AM -0700, Ian Rogers wrote:
> > 2. 'perf list --tui' and ilist test (patches 6-7):
> >    - Add 'perf list --tui' to launch the interactive ilist script via
> >      'perf script', and add a shell test driving ilist headlessly.
> 
> Applied and tested
 

 This one seems to be pre-existent:

root@x2:/home/acme/git/perf-tools-next# tools/perf/python/sctop.py
 syscall events:

event                                     count
----------------------------------------  ----------
Traceback (most recent call last):
  File "/home/acme/git/perf-tools-next/tools/perf/python/sctop.py", line 253, in <module>
    main()
    ~~~~^^
  File "/home/acme/git/perf-tools-next/tools/perf/python/sctop.py", line 234, in main
    live_session.run()
    ~~~~~~~~~~~~~~~~^^
  File "/home/acme/git/perf-tools-next/tools/perf/python/perf_live.py", line 61, in run
    self.sample_callback(event)
    ~~~~~~~~~~~~~~~~~~~~^^^^^^^
  File "/home/acme/git/perf-tools-next/tools/perf/python/sctop.py", line 66, in process_event
    name = str(sample.evsel)
               ^^^^^^^^^^^^
AttributeError: 'perf.sample_event' object has no attribute 'evsel'
root@x2:/home/acme/git/perf-tools-next#
