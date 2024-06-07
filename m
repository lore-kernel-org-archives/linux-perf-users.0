Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB061DFEB;
	Fri,  7 Jun 2024 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717784339; cv=none; b=iBuDjpmMilQfYfd/deBIVi4spjWVbxrOf+37LGEzR2hZ8kYg4Y62n0O9XJAQxebUGMzcWqo2QNEKqvMYxrak6rFCO9Mv9G8T7lZEEkRtzAJ+e04HetT7Ftug0tMZs5KUGLRoH37Ym5Q56Fbvkmr2xEgl8sPa+21oLSD4JtheKtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717784339; c=relaxed/simple;
	bh=7JYVFmwVoYI/lP50oTlJEVeX/T08uLhbxMC9TIDM7nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQe2wvTZJTW1MeUAaGc/xweIuJ7YPP8xIy4PWT5X7qwrCRCA3tJBjfjqV1nILqSrvUKJdVrrVVJJTXHRNts/JT5gDbPuCaEIKXe/cviRSJHdViLvEoSxQZe0PPWu/GqR+UAk2mN0xAPNtUQA8+b0ECsAutqauUJ5vhKfCDod+l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWCPrez7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWCPrez7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98E5C2BBFC;
	Fri,  7 Jun 2024 18:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717784339;
	bh=7JYVFmwVoYI/lP50oTlJEVeX/T08uLhbxMC9TIDM7nE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MWCPrez7FGeAkANPGfxIeYmx07QUAwFyhD8vh/L/HTocNCr437ymHdYqQioBUAuvL
	 S3MG1Krb85pg3dzrx7ZQ4T8p+1W60XilMuXi377zvTX+8R5UEQeSB4PifTPKxi8JNg
	 3kLda/jmf4d8k12u527coaQMM4g4zRvfqYcJr7eDwpiMYYExwPHlitF8rB8SnCq5OI
	 JS9XlMNGAv3DIFmrNN0DBmSaici4mEuuTsGM8HUUBPsMh4hpX9vkB0DYi3fiTheLA8
	 Z9Op9H5dNqvW2eDt5WpIKomyElnM9fb2q8Ya+4pD1CfnNY2ZhLIBYdZfEgk58Ugrdz
	 BEti3c9OCtw8Q==
Date: Fri, 7 Jun 2024 11:18:57 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>, Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Changbin Du <changbin.du@huawei.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1] perf top: Make zeroing histogram on refresh the
 default
Message-ID: <ZmNPETT8oxWSpg72@google.com>
References: <20240516222159.3710131-1-irogers@google.com>
 <86136e0d-45e9-4bf4-826b-359e4993488f@amd.com>
 <ZmHDmrLCoYPUCv3n@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmHDmrLCoYPUCv3n@x1>

On Thu, Jun 06, 2024 at 11:11:38AM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jun 06, 2024 at 10:15:00AM +0530, Ravi Bangoria wrote:
> > On 5/17/2024 3:51 AM, Ian Rogers wrote:
> > > Instead of decaying histograms over time change it so that they are
> > > zero-ed on each perf top refresh. Previously the option '-z', or
> > > pressing 'z' in tui mode, would enable this behavior. Decaying samples
> > > is non-intuitive as it isn't how "top" works. Make zeroing on refresh
> > > the default and rename the command line options from 'z' to 'Z' and
> > > 'zero' to 'decay'.
> 
> > I've also felt `perf top` decay as non-intuitive. Esp. when system becomes
> > idle after some heavy workload, even decayed samples are far more compared
> > to samples from currently running processes and thus `perf top` keeps
> > showing already finished processes at the top, which is kind of confusing.
> > fwiw:
>  
> > Acked-by: Ravi Bangoria <ravi.bangoria@amd.com>
> 
> Thanks for voicing your opinion, that is really helpful.
> 
> Changing tool behaviour can have unintended consequences even when done
> with the best intentions and analysis, that is why I'm wary of doing it.
> 
> The --children case generated complaints when we made it the default, so
> we ended up with a ~/.perfconfig option to disable it:
> 
> root@number:~# perf config top.children=false
> root@number:~# perf top -g
> 
> Or enable explicitely:
> 
> root@number:~# perf config top.children=true
> root@number:~# perf top -g
> 
> Same thing with the build id cache, where one can disable it using 'perf
> config', etc.
> 
> So I'd do this initially with a 'perf config top.refresh=zero' instead
> of changing something so few people complained as not being intuitive
> after all those years of having that default.

This kind of thing happens periodically, I guess we can add some message
to help users to set the default config when it's not set.  In TUI, it
can even set the config directly according to the users response.

Thanks,
Namhyung

