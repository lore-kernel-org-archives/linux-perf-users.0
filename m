Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCA9185B7A;
	Wed, 11 Sep 2024 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057866; cv=none; b=pK0Nfep2eeSMXFyDc8IJpuvc0xc5/vBIqQZ86B59XVPyKS6+VDHAZBRbtXfShtLu6zgd/TGzy+MfIodTmZ3+QyqnUDBgJ7YOzSlmTgNYZzZqsFcdl/C0O2fxUZKumHrdlYO2VDgaSW8Sc7lspUm7tpqWRgbQdwSE0ETxS9lNXTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057866; c=relaxed/simple;
	bh=TdLE2vBMs+5Qfi9f/RiD+O2JHdwSQcYDSs8Li6RI7dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCoZ2+2nuTtt1UKoUnf/k6lsFalNAYih69dualomrYLomYUDGuE5BMtmGN78kyfFhdKgfuHoFaZmUnWOLrEDXANsvcEAKiUSLB599sYE8GPLN4wsYSj5h8UQuLCpZNBYQLG4OBgoiE9hXpuTIhxkgHrI3G8/DbCUYghWgtEjMxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPElxw63; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPElxw63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243B0C4CEC5;
	Wed, 11 Sep 2024 12:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726057865;
	bh=TdLE2vBMs+5Qfi9f/RiD+O2JHdwSQcYDSs8Li6RI7dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HPElxw63joMZcQX3eAvKkzdyYDCCGQ68eQ0xlTWlVkpan837DkJW4J96botqS9HxQ
	 7W4jDPakiXYHHSLMFfh8WCvdn9v19vQpfKe1aTTh3Stg7I/QyVtu2zuX6+SjmC1887
	 El35I5jpuGXlCtEfu3PwikT4tXoy7jhcA6gDNyybC+RqI5TbkguJgPIGeIP4uXnDk0
	 z4Gxw/qY/kbwhXCyKlA0Id+ekYjT2Tz55IqgY4p9yEpH+AY4GibIqPr010K8Jg4l1N
	 +MVZCKPIS+tAuy+8Xe8a7WC+Wc8KPK+6de7SypvypwQBzuTMaf9zn6v/oEcVIW/3ZL
	 qWxseHS1m7s0A==
Date: Wed, 11 Sep 2024 09:31:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Changbin Du <changbin.du@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2] perf ftrace: Detect whether ftrace is enabled on
 system
Message-ID: <ZuGNhhzlTaAQaZXj@x1>
References: <20240911100126.900779-1-changbin.du@huawei.com>
 <c37492e5-6a1a-4506-810c-ec59056ee85b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c37492e5-6a1a-4506-810c-ec59056ee85b@linaro.org>

On Wed, Sep 11, 2024 at 11:15:19AM +0100, James Clark wrote:
> On 11/09/2024 11:01, Changbin Du wrote:
> > To make error messages more accurate, this change detects whether ftrace is
> > enabled on system by checking trace file "set_ftrace_pid".

<SNIP>

> > @@ -1583,6 +1601,11 @@ int cmd_ftrace(int argc, const char **argv)
> >   	if (!check_ftrace_capable())
> >   		return -1;
> > +	if (!is_ftrace_supported()) {
> > +		pr_err("ftrace is not supported on this system\n");
> > +		return -ENOTSUP;
> > +	}
> > +
> >   	ret = perf_config(perf_ftrace_config, &ftrace);
> >   	if (ret < 0)
> >   		return -1;
> 
> Reviewed-by: James Clark <james.clark@linaro.org>

Applied and added these comments:

Committer testing:

Doing it in an unprivileged toolbox container on Fedora 40:

Before:

  acme@number:~/git/perf-tools-next$ toolbox enter perf
  ⬢[acme@toolbox perf-tools-next]$ sudo su -
  ⬢[root@toolbox ~]# ~acme/bin/perf ftrace
  failed to reset ftrace
  ⬢[root@toolbox ~]#

After this patch:

  ⬢[root@toolbox ~]# ~acme/bin/perf ftrace
  ftrace is not supported on this system
  ⬢[root@toolbox ~]#

Maybe we could check if we are in such as situation, inside an
unprivileged container, and provide a HINT line?

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Changbin Du <changbin.du@huawei.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
