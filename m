Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B541E47A4
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730286307; cv=none; b=c1kHZMJETzPzBgofiExMkUtn31ZD/PNBxEWLJ0sdHy9ne5Zt/MIwnDqaslWXQHIsFIBsdpvbA4QP/Liug1D1isr2S5CPHGKFz+Oj/YW6o8xCYa7DGhFGlQoI2rFPsA7oyaF6W1xcgtpuWgPHXkdI5lTCBGws3EBT14b1WADiyj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730286307; c=relaxed/simple;
	bh=cMyK6z4lp/Es8q2Pm1Fap39wAPmlrK9L1PD1veyZCIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9S+LUCcceoahnIfQuzLQqgPFeOp844gkMkgYcgkXKBFCI5xF27fqFcT7aO5/JImu0tnZtxRw8x/7cbtwdQPmsn/vwmk4DkcKlrNlMGLFG8jibZboXbq2ptJIcjCBtvDMkjLbf46TPxbw1+oLn37Lw0plI2LJNzw/3OqBuOtEJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17EA1169E;
	Wed, 30 Oct 2024 04:05:34 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E36643F66E;
	Wed, 30 Oct 2024 04:05:03 -0700 (PDT)
Date: Wed, 30 Oct 2024 11:04:58 +0000
From: Leo Yan <leo.yan@arm.com>
To: Yicong Yang <yangyicong@huawei.com>
Cc: Namhyung Kim <namhyung@kernel.org>, yangyicong@hisilicon.com,
	acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, amadio@gentoo.org, linuxarm@huawei.com
Subject: Re: [PATCH] perf build: Add missing cflags when building with custom
 libtraceevent
Message-ID: <20241030110458.GD24446@e132581.arm.com>
References: <20241024133236.31016-1-yangyicong@huawei.com>
 <ZyF5_Hf1iL01kldE@google.com>
 <a8143fa2-d7e2-48d7-5c9b-2c00e2adbe9c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8143fa2-d7e2-48d7-5c9b-2c00e2adbe9c@huawei.com>

On Wed, Oct 30, 2024 at 10:45:47AM +0800, Yicong Yang wrote:

[...]

> >> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> >> index 4ddb27a48eed..53fc5f787a77 100644
> >> --- a/tools/perf/Makefile.config
> >> +++ b/tools/perf/Makefile.config
> >> @@ -1194,7 +1194,7 @@ endif
> >>  ifneq ($(NO_LIBTRACEEVENT),1)
> >>    $(call feature_check,libtraceevent)
> >>    ifeq ($(feature-libtraceevent), 1)
> >> -    CFLAGS += -DHAVE_LIBTRACEEVENT
> >> +    CFLAGS += -DHAVE_LIBTRACEEVENT $(shell $(PKG_CONFIG) --cflags libtraceevent)
> >
> > Does this solve the problem?  On my machine, it returns this:
> >
> >   $ pkg-config --cflags libtraceevent
> >   -I/usr/include/traceevent
> >
> >   $ ls /usr/include/traceevent/
> >   event-parse.h  event-utils.h  kbuffer.h  trace-seq.h
> >
> > So the include path should be "/usr/include" or we should include
> > <event-parse.h> directly.  We may update the every include statements
> > but just curious how it solved your problem.
> >
> 
> I think you're right, we should use the path according to the pkg-config outputs.
> But it's a different problem, for me it's due to the missing of the include path
> (my libtraceevent is not under the system path). With the fix you proposed and drop
> the change in my patch:
> 
> $ PKG_CONFIG_PATH=/home/yangyicong/Community/libtraceevent/install/usr/local/lib/aarch64-linux-gnu/pkgconfig/ pkg-config --cflags-only-I libtraceevent
> -I/home/yangyicong/Community/libtraceevent/install/usr/local/include/traceevent
> $ PKG_CONFIG_PATH=/home/yangyicong/Community/libtraceevent/install/usr/local/lib/aarch64-linux-gnu/pkgconfig/ make -C tools/perf NO_LIBPYTHON=1
> In file included from bench/../util/session.h:5,
>                  from bench/synthesize.c:12:
> bench/../util/trace-event.h:153:10: fatal error: event-parse.h: No such file or directory
>   153 | #include <event-parse.h>
>       |
> [...]
> 
> Checked how we handle with libtracefs currently:
>  ifeq ($(feature-libtracefs), 1)
>     CFLAGS +=  $(shell $(PKG_CONFIG) --cflags libtracefs) # we've added the cflags from pkg-config
>     LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libtracefs)

The libtracefs.pc file claims requesting libtraceevent, as a result, it
returns the header paths for both libtraceevent and libtracefs:

  $ pkg-config --cflags libtracefs
  -I/usr/local/include/tracefs -I/usr/local/include/traceevent

I checked the packages libtraceevent-dev and libtracefs-dev and either
can be installed independently. Therefore, it seems to me that this
patch is correct for finding the traceevent header path, with no
dependency on tracefs.

Thanks,
Leo
