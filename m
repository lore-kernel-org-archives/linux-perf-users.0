Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF22178378;
	Mon, 12 Aug 2024 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469297; cv=none; b=PHsPLkvY9tgYu40pKlsBlmttq6fzg7AQDbkUxbMrQ09QRuCjqAb95O8ojRWfUaJzk4SLUwtB3ywYPgyP7O6AKFkx+SRi7Ik7L0l0NtSwUoDiKnEIpBbRLYU4/O2CVzfpMOHO3pjSWlN5GiWRhvVVEcKhJcFcd54w1uOtlce+PSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469297; c=relaxed/simple;
	bh=oLYG42XDJsIF5OhNCfjLHyTVMQ0mMbUbjIGN+UZxMuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6Wr7n4O7jkhfHFVc0k4BmHwL3jrRl2sIJVdGAYCuO0So9NhWvDgIP0xZtZ6jrPwQ8om+ptScYdmnJcOBV+5VV8ZrrKT+XLNS/fzTCbSCHOdkB4raQz3M+Cnk2w3LHXo8/eUk8+gdmHkMP4wP+bxZrWk7gUT1A5+yXDKuFKcGQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npLltXVD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npLltXVD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F904C32782;
	Mon, 12 Aug 2024 13:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723469296;
	bh=oLYG42XDJsIF5OhNCfjLHyTVMQ0mMbUbjIGN+UZxMuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=npLltXVDPW4Avf+2R77/vKIv1ZgXL5WSs2sJveh9HnNuZIg3GsqgAqqEuOmRoeyuW
	 DBnFeR1IevmkpDwVBy2pYRdJ11V/6qfKCnZmQV0i5OyNNnc/ZXXr4j15J8FW9pzmwH
	 0j3TlJZIM/3JNb+jrUXOVI4WikqHkBwozS9keZ73CqiXVe+9zKwkSBoNpHEzIL2xsT
	 ekuC4qNxKLj5PDW6v/aYn56gCh4zEALsWuUU6+vSkPgFNabyb3WUdPGWeX+jDMyHdt
	 f+XvVG9rt6GDDIE0p0Jch1MS4SkvxCqBa67gswew4Q6MNoc3sUuHI+y0EYjeKxd5cn
	 FP7xBjbnXMSMg==
Date: Mon, 12 Aug 2024 10:28:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Martin =?utf-8?B?TGnFoWth?= <m.liska@foxlink.cz>
Cc: irogers@google.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf script: add --addr2line option
Message-ID: <ZroN7XhtSSbQs6m8@x1>
References: <CAP-5=fXPC+pXmJCpvkr5x2Ae1hdKeL7Cd6Uak+7mn+uG+R8yVQ@mail.gmail.com>
 <eadc3e36-029d-4848-9d69-272fe5a83a26@foxlink.cz>
 <c814c49f-fdd6-46cf-ba89-ca46ff7e64b9@foxlink.cz>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c814c49f-fdd6-46cf-ba89-ca46ff7e64b9@foxlink.cz>

On Mon, Aug 12, 2024 at 11:42:31AM +0200, Martin Liška wrote:
> @acme: May I please ping this patch?

Simple enough, merged, thanks for the ping.

- Arnaldo
 
> Thanks,
> Martin
> 
> On 7/19/24 12:57, Martin Liška wrote:
> > Similarly to other subcommands (like report, top), it would be handy to
> > provide a path for addr2line command.
> > 
> > Signed-off-by: Martin Liska <martin.liska@hey.com>
> > ---
> >  tools/perf/Documentation/perf-script.txt | 3 +++
> >  tools/perf/builtin-script.c              | 2 ++
> >  tools/perf/util/symbol_conf.h            | 2 +-
> >  3 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> > index ff086ef05a0c..5abb960c4960 100644
> > --- a/tools/perf/Documentation/perf-script.txt
> > +++ b/tools/perf/Documentation/perf-script.txt
> > @@ -369,6 +369,9 @@ OPTIONS
> >  --demangle-kernel::
> >  	Demangle kernel symbol names to human readable form (for C++ kernels).
> >  
> > +--addr2line=<path>::
> > +	Path to addr2line binary.
> > +
> >  --header
> >  	Show perf.data header.
> >  
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index c16224b1fef3..932167b2362b 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -4052,6 +4052,8 @@ int cmd_script(int argc, const char **argv)
> >  			"Enable symbol demangling"),
> >  	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
> >  			"Enable kernel symbol demangling"),
> > +	OPT_STRING(0, "addr2line", &symbol_conf.addr2line_path, "path",
> > +			"addr2line binary to use for line numbers"),
> >  	OPT_STRING(0, "time", &script.time_str, "str",
> >  		   "Time span of interest (start,stop)"),
> >  	OPT_BOOLEAN(0, "inline", &symbol_conf.inline_name,
> > diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> > index c114bbceef40..d41b25e10f1b 100644
> > --- a/tools/perf/util/symbol_conf.h
> > +++ b/tools/perf/util/symbol_conf.h
> > @@ -63,7 +63,7 @@ struct symbol_conf {
> >  			*sym_list_str,
> >  			*col_width_list_str,
> >  			*bt_stop_list_str;
> > -	char		*addr2line_path;
> > +	const char		*addr2line_path;
> >  	unsigned long	time_quantum;
> >         struct strlist	*dso_list,
> >  			*comm_list,
