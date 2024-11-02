Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF97A14F9F3
	for <linux-perf-users@vger.kernel.org>; Sat,  2 Nov 2024 06:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730528610; cv=none; b=gDaLriyy4lH+Uxrc1rtmvqDQMDuhjIvGQqjCV0i3E9fCA7oMRwnYImVP/G78l6LsySwSuepc37EBjzNQAe09OF5tiUGcPukQZ81h+td2VMJwDt2wl/beoDfxrj0VrCDXRi6D7aDVQTCf/OkacFLwqODbaFCiwqoxPrRiPvQNttE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730528610; c=relaxed/simple;
	bh=6qMfm1Igm5g8xce9OHi7DEBI7PQb098KGLNCmOwTp8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YynpKhWoX+7hMFF9Fsoee8KAI7tpB0k0R0kr5Mv2i5aCu9xVMx6QpiubRBzNYCC40OecSdwqnu/jq99nz3Cu+13UFFbTUCvI7njzNLVFfvkS1zQHbBC7zpkErVp89HoW2Q25mfDtDsDCSbpvU+rG/Gxs1i+j8SjjPURN8hpkL+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpvapweS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpvapweS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10767C4CEC3;
	Sat,  2 Nov 2024 06:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730528609;
	bh=6qMfm1Igm5g8xce9OHi7DEBI7PQb098KGLNCmOwTp8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WpvapweS4n+bofjei2NhqtllCciAGwhDRxzFOsBeNDSNE2j6Wo5Q5Trn558lND6l9
	 WQ3Ru2DHu4Yjf1AYo3Md6uyKu/ed+qky4W4CaSEP5OIVorxt9ktRYQs5GzMBIpMojk
	 EOXO/ks/6+ly32qbhRqZ/f9gURRZTwBEqqToOOUhzg3zn6skFdPGndndeYa17LApKf
	 g0gtA0yXH1fEhpv6jgwEzafeAduNJFi8BdPWr05uOLqJ9mZh8hzP9mOw92bFPdElFs
	 +eXmsJkkmJJ1ikgTOB4PFMb1uawQb4ry8+IxVruACI4Rlay6f4odguzTfvkFYx16CE
	 NdurYeLWcI4mw==
Date: Fri, 1 Nov 2024 23:23:27 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Yicong Yang <yangyicong@huawei.com>, yangyicong@hisilicon.com,
	acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, amadio@gentoo.org, linuxarm@huawei.com
Subject: Re: [PATCH] perf build: Add missing cflags when building with custom
 libtraceevent
Message-ID: <ZyXFX-8SnakeuZrl@google.com>
References: <20241024133236.31016-1-yangyicong@huawei.com>
 <ZyF5_Hf1iL01kldE@google.com>
 <a8143fa2-d7e2-48d7-5c9b-2c00e2adbe9c@huawei.com>
 <20241030110458.GD24446@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241030110458.GD24446@e132581.arm.com>

On Wed, Oct 30, 2024 at 11:04:58AM +0000, Leo Yan wrote:
> On Wed, Oct 30, 2024 at 10:45:47AM +0800, Yicong Yang wrote:
> 
> [...]
> 
> > >> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > >> index 4ddb27a48eed..53fc5f787a77 100644
> > >> --- a/tools/perf/Makefile.config
> > >> +++ b/tools/perf/Makefile.config
> > >> @@ -1194,7 +1194,7 @@ endif
> > >>  ifneq ($(NO_LIBTRACEEVENT),1)
> > >>    $(call feature_check,libtraceevent)
> > >>    ifeq ($(feature-libtraceevent), 1)
> > >> -    CFLAGS += -DHAVE_LIBTRACEEVENT
> > >> +    CFLAGS += -DHAVE_LIBTRACEEVENT $(shell $(PKG_CONFIG) --cflags libtraceevent)
> > >
> > > Does this solve the problem?  On my machine, it returns this:
> > >
> > >   $ pkg-config --cflags libtraceevent
> > >   -I/usr/include/traceevent
> > >
> > >   $ ls /usr/include/traceevent/
> > >   event-parse.h  event-utils.h  kbuffer.h  trace-seq.h
> > >
> > > So the include path should be "/usr/include" or we should include
> > > <event-parse.h> directly.  We may update the every include statements
> > > but just curious how it solved your problem.
> > >
> > 
> > I think you're right, we should use the path according to the pkg-config outputs.
> > But it's a different problem, for me it's due to the missing of the include path
> > (my libtraceevent is not under the system path). With the fix you proposed and drop
> > the change in my patch:
> > 
> > $ PKG_CONFIG_PATH=/home/yangyicong/Community/libtraceevent/install/usr/local/lib/aarch64-linux-gnu/pkgconfig/ pkg-config --cflags-only-I libtraceevent
> > -I/home/yangyicong/Community/libtraceevent/install/usr/local/include/traceevent
> > $ PKG_CONFIG_PATH=/home/yangyicong/Community/libtraceevent/install/usr/local/lib/aarch64-linux-gnu/pkgconfig/ make -C tools/perf NO_LIBPYTHON=1
> > In file included from bench/../util/session.h:5,
> >                  from bench/synthesize.c:12:
> > bench/../util/trace-event.h:153:10: fatal error: event-parse.h: No such file or directory
> >   153 | #include <event-parse.h>
> >       |
> > [...]
> > 
> > Checked how we handle with libtracefs currently:
> >  ifeq ($(feature-libtracefs), 1)
> >     CFLAGS +=  $(shell $(PKG_CONFIG) --cflags libtracefs) # we've added the cflags from pkg-config
> >     LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libtracefs)
> 
> The libtracefs.pc file claims requesting libtraceevent, as a result, it
> returns the header paths for both libtraceevent and libtracefs:
> 
>   $ pkg-config --cflags libtracefs
>   -I/usr/local/include/tracefs -I/usr/local/include/traceevent
> 
> I checked the packages libtraceevent-dev and libtracefs-dev and either
> can be installed independently. Therefore, it seems to me that this
> patch is correct for finding the traceevent header path, with no
> dependency on tracefs.

I'm ok with the patch itself.  Can I get your Acked-by, Leo?

Thanks,
Namhyung

