Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1505630E853;
	Fri, 20 Jun 2025 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750448980; cv=none; b=a1EA5odBIE90Zj37p/j9iCr6cCbG0lcup99gEW983NcDV+ZTOvhr/VoyIFL1svFE/CNhJBPOZcWEtwT/tnYa1PtUIuMY9NpWD0LvG0kEvFwOPX+vsoxeeGl88F1WxMTqAeJo/sBBkhJNu6tq4nFrLJVhe7ZC/B1mmUh+6iZmRHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750448980; c=relaxed/simple;
	bh=5aeRSISf8T2KpdIT6VWtcBAh1mivh6uTlAYZbJUNV4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaKLxu8aflqbxQZx7VdS70GbIQ2NDYUyEHeo4ahktbWSvkoPH7YI850EyLFXLTKgNlp099rVieK2zIF9hGmwsGnOD6afeF1R9F7xfV8Eg1UGz4WYFW0J8F39jlyNGkJEPjf5UHxPD/wQlisAJYbFBx3rOqdpTI2VKHdjNrWZ+a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGciXiIZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGciXiIZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFEFC4CEE3;
	Fri, 20 Jun 2025 19:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750448977;
	bh=5aeRSISf8T2KpdIT6VWtcBAh1mivh6uTlAYZbJUNV4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iGciXiIZO9MuMOUYidbxt24x1Wf6GsNYR9ZTwenAo0h7FHZ7t3tJXyZEcWFFv67Hu
	 0dAhhIpBxVnCREs3782l840LxmOfGhKtj0G2XW0BPzWDav8Vg5iOkb4OVD9hN3ZpRg
	 dDpBRrFQjvYoWZ08h3EhHCa5jZCQq3nZQ0vYjIy+iajjogyI2fjaIHCXfZzhU+uNWT
	 pCefnFHda7u8y1U4e+UoeBX14ON2HUDHgxylj4wWbYh07G0FY+Af3QPde9gEyupoS5
	 bNdcrHdMbDwTUwGtMBTaKZsckro7V1Lde/Vc4i9P/8B0UQC671x882owbHTIH1i9y3
	 lE1MZ36QKgI6g==
Date: Fri, 20 Jun 2025 12:49:35 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Collin Funk <collin.funk1@gmail.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH] perf build: Specify that spellcheck should use the bash
 dialect.
Message-ID: <aFW7T9DH9WrjtgJ-@google.com>
References: <e3751a74be34bbf3781c4644f518702a7270220b.1749785642.git.collin.funk1@gmail.com>
 <20cce2b1-eaad-4565-817b-b094aecee0a5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20cce2b1-eaad-4565-817b-b094aecee0a5@linaro.org>

Hello,

On Thu, Jun 19, 2025 at 11:28:46AM +0100, James Clark wrote:
> 
> 
> On 13/06/2025 4:36 am, Collin Funk wrote:
> > When someone has a global shellcheckrc file, for example at
> > ~/.config/shellcheckrc, with the directive 'shell=sh', building perf
> > will fail with many shellcheck errors like:
> > 
> >      In tests/shell/base_probe/test_adding_kernel.sh line 294:
> >      (( TEST_RESULT += $? ))
> >      ^---------------------^ SC3006 (warning): In POSIX sh, standalone ((..)) is undefined.
> > 
> >      For more information:
> >        https://www.shellcheck.net/wiki/SC3006 -- In POSIX sh, standalone ((..)) is...
> >      make[5]: *** [tests/Build:91: tests/shell/base_probe/test_adding_kernel.sh.shellcheck_log] Error 1
> > 
> > Passing the '-s bash' option ensures that it runs correctly regardless
> > of a developers global configuration.
> > 
> > Signed-off-by: Collin Funk <collin.funk1@gmail.com>
> > ---
> >   tools/perf/tests/Build | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> > index 2181f5a92148..26efc5d20f6c 100644
> > --- a/tools/perf/tests/Build
> > +++ b/tools/perf/tests/Build
> > @@ -89,7 +89,7 @@ endif
> >   $(OUTPUT)%.shellcheck_log: %
> >   	$(call rule_mkdir)
> > -	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
> > +	$(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
> >   perf-test-y += $(SHELL_TEST_LOGS)
> 
> If we're enforcing bash style with static analysis shouldn't we also change
> all the hashbangs to bash? Recently there have been changes to change sh to
> bash in some of the tests so presumably the hard rule for sh is no more?
> 
> In the past I've had to replace bashisms that didn't work in sh but it would
> be nice to have only one language to write tests in. I doubt anyone running
> the tests today is running somewhere without bash, or that changing it will
> break anything. If anything it will fix more bashisms that have already been
> written.
> 
> Just for reference there are 34 #!/bin/bash and 42 #!/bin/sh in
> tools/perf/tests

Thanks for raising the concern.  I agree that having one standard is a
way to go but I really don't have preference between those shells.

Thanks,
Namhyung

