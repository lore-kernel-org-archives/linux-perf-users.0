Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88892B67A
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730247166; cv=none; b=P415n0dnBAWLWv1iYb5dwkOTbXdlFMwdZm5b2viFBAfq0B/WMTSgilB8iSYSinZoihJYcWs0wxd8gF/BNVJydxngtTFyC7hulLAeYdj0bzxLOcj9ZXpEFqipY6DD2Fk8RbLTsMQbErOGtvq/JYhh4U3HjnoP0n15f3uBIwUSa90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730247166; c=relaxed/simple;
	bh=6FSxSs0N+w0IMw2J1BVVzx5+kbX2qhypm+vHthERTN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxfNB3xeD4V0Gr5cMjT/ZHcDdsYpiQ2zUPDustQmynhZOgnRdd3Z3bUU58+aUgp1/g4UW+kQqGPR/n0iA0Qck4qT+3yIQpP3LGYiF7uxm1JZw4KnIODfDMGlX5BcG196dISrMiyPEb6CEddhjDNWarMAISMuuR2OXRMqaeFaim0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MY6o99ky; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MY6o99ky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E72AC4CECD;
	Wed, 30 Oct 2024 00:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730247166;
	bh=6FSxSs0N+w0IMw2J1BVVzx5+kbX2qhypm+vHthERTN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MY6o99kycNF/pEiS5TknFJjy6LHWDWheWlVOuj/y3KeogeOfJ2bMnSX0QztsIsFOW
	 AOmLn4CHJzgJ70U+hmT0rnvQUeJ40JeXxC9EhzZFADUuLo0hy1QNAvuIkmqvaUTM2g
	 Vo1gzvxdAE8roQfZ2PueUgz5sIkPCyLvnND4m1mPqj+SFtPjr8VXNcc2rZavu1E3jP
	 BnUy3HfE9K7v8tsYSMvyqiObTkInsCmOzvimpVDYu27+/xJIjO9o79BCzPtUFU2LSa
	 0jBrMXpcoJLNJmfyV/lGXR3H09Id+jrIkmeYjQvzB1v8suoPIZV5e/HGxd3MslYysu
	 LW8engkiyEhrA==
Date: Tue, 29 Oct 2024 17:12:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Yicong Yang <yangyicong@huawei.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, leo.yan@arm.com, amadio@gentoo.org,
	linuxarm@huawei.com, yangyicong@hisilicon.com
Subject: Re: [PATCH] perf build: Add missing cflags when building with custom
 libtraceevent
Message-ID: <ZyF5_Hf1iL01kldE@google.com>
References: <20241024133236.31016-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241024133236.31016-1-yangyicong@huawei.com>

Hello,

On Thu, Oct 24, 2024 at 09:32:36PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> When building with custom libtraceevent, below errors occur:
> $ make -C tools/perf NO_LIBPYTHON=1 PKG_CONFIG_PATH=<custom libtraceevent>
> In file included from util/session.h:5,
>                  from builtin-buildid-list.c:17:
> util/trace-event.h:153:10: fatal error: traceevent/event-parse.h: No such file or directory
>   153 | #include <traceevent/event-parse.h>
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~
> <snip similar errors of missing headers>
> 
> This is because the include path is missed in the cflags. Add it.
> 
> Fixes: 0f0e1f445690 ("perf build: Use pkg-config for feature check for libtrace{event,fs}")
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
> Another problem occurs when building on my old Ubuntu 18.04.1 (4.15 kernel)
> is that linux/mount.h (which is introduced in the later kernel version) is
> missing. It's included in tools/include/uapi/linux/fs.h which header is
> introduced recently. Does it make sense to have a copy of mount.h in tools/include?
> 
>  tools/perf/Makefile.config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 4ddb27a48eed..53fc5f787a77 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1194,7 +1194,7 @@ endif
>  ifneq ($(NO_LIBTRACEEVENT),1)
>    $(call feature_check,libtraceevent)
>    ifeq ($(feature-libtraceevent), 1)
> -    CFLAGS += -DHAVE_LIBTRACEEVENT
> +    CFLAGS += -DHAVE_LIBTRACEEVENT $(shell $(PKG_CONFIG) --cflags libtraceevent)

Does this solve the problem?  On my machine, it returns this:

  $ pkg-config --cflags libtraceevent
  -I/usr/include/traceevent 

  $ ls /usr/include/traceevent/
  event-parse.h  event-utils.h  kbuffer.h  trace-seq.h

So the include path should be "/usr/include" or we should include
<event-parse.h> directly.  We may update the every include statements
but just curious how it solved your problem.

Thanks,
Namhyung


>      LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libtraceevent)
>      EXTLIBS += $(shell $(PKG_CONFIG) --libs-only-l libtraceevent)
>      LIBTRACEEVENT_VERSION := $(shell $(PKG_CONFIG) --modversion libtraceevent).0.0
> -- 
> 2.24.0
> 
