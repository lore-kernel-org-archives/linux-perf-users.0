Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAB83B0583;
	Sat,  3 Oct 2026 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791018930; cv=none; b=gJmkCuYFR1LKh2JOTToe7wfTq6QNzHOYUKy/PpuxMruX8iW4SajqpFlmk1w7CuSGvjTV5eWrjWvTo79dVq/bX//6n3/ZjJpAsIhSXLjLlpiEOU6tdrvDWIF9Zuwwyy42/KZ9dfTFkF8NGCfiilFQ/4S1pCsFD/fntHl9EZ7dI14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791018930; c=relaxed/simple;
	bh=K8GmayE6g10SoT6eoCaqLkqKB1d8JHC79L2j+0+jX+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mupkt0HpruDxmEvErzagA945VS6L4BuE/GLPHIoJQILH4hH+Ks8H+vdPNJ2SW35CJwOmwt8hDMendaShu+uqHU9XW4FsBC8Cz+aKeJHqk3/YompDxfxH+8zMqZ6MNR2ne29KUuPED3IfelEx+av7Pn5ibFN1czV4PHq+Ay6/G4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkM/AKu6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkM/AKu6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5416C1F0089B;
	Sat,  3 Oct 2026 09:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791018928;
	bh=dX+CVOnLfx7LepqKXHzDbspbQiu7gCKbNWR2HCxhkD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RkM/AKu6iYp+JeJx8TNb/pz+3fi1VdE/nQgI3fpC3rup/2hLvC+ItHsLk1zDgKkgZ
	 o3rvjjj/6zLYoIjcYL2CPH+nH6F2EMYtKW1pWydnzEl5byUTybai9O8rr6MOzIwPLr
	 L1VdXhvjbze9dSF3U+TgzwrmlvI+c/14WSFkv2RLpY4ONwoJEQe/1JkIqp4p2RHkyU
	 zopYL6bxxQ+NCckYmkGMjuf1G90F9x1qjxX4E068SJ9AzKR5mp+HtjAwmM8NiasVO9
	 RfcqWnlgiWsN2qXrZFfwgTeGu6tPmD2jlgYCBZhY9O9H05s99oKczn4y8vcBx6eQ63
	 kwDRo2PZbz2pg==
Date: Sat, 3 Oct 2026 11:15:21 +0200
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
Message-ID: <asDHqdVt4CKq_EoL@x2>
References: <20261002182624.3259797-1-irogers@google.com>
 <asDGb6qOgJzXDpNo@x2>
 <asDHBIbfvCUbPT2A@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asDHBIbfvCUbPT2A@x2>

On Sat, Oct 03, 2026 at 11:12:44AM +0200, Arnaldo Carvalho de Melo wrote:
> On Sat, Oct 03, 2026 at 11:10:16AM +0200, Arnaldo Carvalho de Melo wrote:
> > On Fri, Oct 02, 2026 at 11:26:09AM -0700, Ian Rogers wrote:
> > > 2. 'perf list --tui' and ilist test (patches 6-7):
> > >    - Add 'perf list --tui' to launch the interactive ilist script via
> > >      'perf script', and add a shell test driving ilist headlessly.
> > 
> > Applied and tested
>  
> 
>  This one seems to be pre-existent:
> 
> root@x2:/home/acme/git/perf-tools-next# tools/perf/python/sctop.py
>  syscall events:
> 
> event                                     count
> ----------------------------------------  ----------
> Traceback (most recent call last):
>   File "/home/acme/git/perf-tools-next/tools/perf/python/sctop.py", line 253, in <module>
>     main()
>     ~~~~^^

Nevermind, root was finding some old python binding, after:

root@x2:/home/acme/git/perf-tools-next# export PYTHONPATH=/tmp/build/perf-tools-next/

it works,

- Arnaldo

