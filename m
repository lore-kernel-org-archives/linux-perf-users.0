Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8426B20127D
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jul 2024 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719955690; cv=none; b=rDSqtNadMbH72e/ox7lI8ZTOSTeksKYweUXwULKLt+1xPgPbAIxVjgBidraO9V0OvoEB6+IprEW4hJcsQxsY1SrDbLKdA0PJFBkWcGNpV0bogcmzWThOEZAhvhiPqwtSUO1Ja16UiV+uHbY5iKTFay/RxfX2TXh9maZvXPBoI88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719955690; c=relaxed/simple;
	bh=nJuvymqxCQ9VX7ho8BXx17AyyYrIBHMj4KHTlENoANE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWHRPsWHf4I5vD/yKotIP8BAYVk6Whgi45M6BJ3w9kBCWeBqlSjhtvnvlb6lyOU0iM9NhWSC4+0pEQjweCmd3H89mVmiS7siqsb82vbVuWAmAyHdKAA3++MskMDbU5qWirWI9Al+mEtRM+XaFq6k7UX05/t5bdzFB7kCvcS1Ujc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsPZJD+X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsPZJD+X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D7EC116B1;
	Tue,  2 Jul 2024 21:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719955690;
	bh=nJuvymqxCQ9VX7ho8BXx17AyyYrIBHMj4KHTlENoANE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UsPZJD+X9K4jK5qkrflFHQs0GiBQg7yejVnEKIF83s1UOPnZxMatil5TsCo+Dtq+x
	 OOzQKGvJ9FoP+6NFfCp6Virm6xerSMcV7QXhOl3n5cKRFNQb6Vg+jSEZPlo5G1P3uU
	 IoSzjvZKsZWRZSNNUwkQfySDbdA0OAQIgJaLX4oNkNI3oxZonObghsDTcn3Q7CWjAr
	 hkoupN5h9f6EBQSTYHjNUFD1bJ/I+PYgpUa7Y9CdsBHGNOkCHACt6H/K34IAJ/FdzA
	 sTg0Xpktwi7W5CabcyxlBoSfM3puAplbUN3G2tQPVRCvVx9qIuJDzYFIzMCQEap5Zp
	 AJ2MZT2tpF6Sg==
Date: Tue, 2 Jul 2024 18:28:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, jolsa@kernel.org,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
	kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v11 1/4] perf check: introduce check subcommand
Message-ID: <ZoRw5we4HLSTZND6@x1>
References: <20240627100644.772219-1-adityag@linux.ibm.com>
 <20240627100644.772219-2-adityag@linux.ibm.com>
 <Zn7EvDbsnlbLXj4g@x1>
 <Zn7FmltYgUzi6YvV@x1>
 <Zn7GsEKwLxn5bMyN@x1>
 <Zn7HtaJb3NL2k5YG@x1>
 <Zn8AvuvyjXFGa90c@google.com>
 <Zn8OxjRgFlPduRKh@x1>
 <70a883b0-11ba-4d68-bf0d-977af60cc32e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70a883b0-11ba-4d68-bf0d-977af60cc32e@linux.ibm.com>

On Sun, Jun 30, 2024 at 07:38:44PM +0530, Aditya Gupta wrote:
> Hi Arnaldo,
> 
> 
> On 29/06/24 00:58, Arnaldo Carvalho de Melo wrote:
> > On Fri, Jun 28, 2024 at 11:28:14AM -0700, Namhyung Kim wrote:
> > > On Fri, Jun 28, 2024 at 11:24:53AM -0300, Arnaldo Carvalho de Melo wrote:
> > > 
> > > > And while looking at it:
> > > > 
> > > >               get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
> > > > 
> > > > This looks wrong, no? Or at least confusing, have to check the source
> > > > code...
> > > We have this in Makefile.config
> > > 
> > > ifndef NO_AUXTRACE
> > >    ifeq ($(SRCARCH),x86)
> > >      ifeq ($(feature-get_cpuid), 0)
> > >        $(warning Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc)
> > >        NO_AUXTRACE := 1
> > >      endif
> > >    endif
> > The complete sequence is:
> > 
> > ifndef NO_AUXTRACE
> >    ifeq ($(SRCARCH),x86)
> >      ifeq ($(feature-get_cpuid), 0)
> >        $(warning Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc)
> >        NO_AUXTRACE := 1
> >      endif
> >    endif
> >    ifndef NO_AUXTRACE
> >      $(call detected,CONFIG_AUXTRACE)
> >      CFLAGS += -DHAVE_AUXTRACE_SUPPORT
> >      ifeq ($(feature-reallocarray), 0)
> >        CFLAGS += -DCOMPAT_NEED_REALLOCARRAY
> >      endif
> >    endif
> > endif
> > 
> > The most descriptive would be to HAVE_GET_CPUID_SUPPORT and have it used
> > in the source code.
> > 
> > That or have:
> > 
> > diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> > index 44ffde6f8dbe51f3..ae4a686ff4f265be 100644
> > --- a/tools/perf/builtin-check.c
> > +++ b/tools/perf/builtin-check.c
> > @@ -33,7 +33,7 @@ struct feature_status supported_features[] = {
> >   	FEATURE_STATUS("dwarf", HAVE_DWARF_SUPPORT),
> >   	FEATURE_STATUS("dwarf_getlocations", HAVE_DWARF_GETLOCATIONS_SUPPORT),
> >   	FEATURE_STATUS("dwarf-unwind-support", HAVE_DWARF_UNWIND_SUPPORT),
> > -	FEATURE_STATUS("get_cpuid", HAVE_AUXTRACE_SUPPORT),
> > +	FEATURE_STATUS("auxtrace", HAVE_AUXTRACE_SUPPORT),
> >   	FEATURE_STATUS("libaudit", HAVE_LIBAUDIT_SUPPORT),
> >   	FEATURE_STATUS("libbfd", HAVE_LIBBFD_SUPPORT),
> >   	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
> 
> 
> Looks better. Went through all instances of 'HAVE_AUXTRACE_SUPPORT', it's
> mostly been used to conditionally define perf_*_auxtrace functions.
> 
> No one seems to depend on the feature 'name' 'get_cpuid'.
> 
> Any comments ?

So I think its better to go with HAVE_AUXTRACE_SUPPORT to cover this
feature, i.e. whatever is needed to have auxtrace support gets checked
and if all is in place, HAVE_AUXTRACE_SUPPORT is set up.

This in fact is what is being done, its just when reporting using
supported_features[] that we end up using the string "get_cpuid", right?

So it makes sense to use:

FEATURE_STATUS("auxtrace", HAVE_AUXTRACE_SUPPORT),
 
> > That:
> > 
> >          FEATURE_STATUS("dwarf-unwind-support", HAVE_DWARF_UNWIND_SUPPORT),
> > 
> > Should also really be:
> > 
> >          FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
> 
> Will do it in v13.

Thanks, put that in a separate patch, as it is only barely related to
the other patches, we only are correcting an inconsistency we found
while writing/reviewing your patch kit.

Thanks,

- Arnaldo
 
> 
> Thanks,
> 
> Aditya Gupta
> 
> > For consistency, the get_cpuid/auxtrace also for consistency, I think.
> > 
> > - Arnaldo
