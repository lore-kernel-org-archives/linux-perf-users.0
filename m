Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D393D1A95;
	Thu, 14 May 2026 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778742071; cv=none; b=u7Zv4TJSDa+pEzN47G3H6DexyJqdYCDR9QS6WCA8hllShTBssoNZG/xNyMGzaiS2bii5bHM7pTWJ14PXNFcYjGUAcGrsX5KaULZGDLyfNa16Fp9GvNzyhHIZKz0NGViCbjujs9tiGctaSSGcj0G8TvYiZUrDd/29K69chb9yMiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778742071; c=relaxed/simple;
	bh=uHrx8SzunZGJpKBZPt6MTGRxOUoJM0biANuKfqgP/XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6Zz0axgoAISY7m2vXFISjXCeCzZXedPMo06EnnojfIkSBrEd1y+1JTUWUEA9eAa6AyWoCFb0x8o8AXOo5Y9fCP1eJk12fUBEVMYY2sEm8XHSw8N9lxSJ8vE9UZ+4TyDjE1YBlyTWUHIUFi1zL/tLeTE4Nna0DDEv9ev+17lCWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E/Pad0pc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E/Pad0pc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE54C2BCC7;
	Thu, 14 May 2026 07:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778742071;
	bh=uHrx8SzunZGJpKBZPt6MTGRxOUoJM0biANuKfqgP/XE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/Pad0pcD1toU+XQUyj/b7Gyep0t6XijuzJnganSWoAfjTyJ6jpciIm/LyrqKjfSN
	 e1NB94oWnTqoYqtWwg1/Y2VVxr+UfndLALhtPQUnuq+8gpOJ1g0Rv2jjhLx+M+2IpP
	 /2ExdhPgdxpzeIWlveRyZpmmNC3XO4bn7HPlMFDc=
Date: Thu, 14 May 2026 09:00:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jia He <justin.he@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Petr Mladek <pmladek@suse.com>, Kees Cook <kees@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH 5/7] misc: reject duplicate names in misc_register()
Message-ID: <2026051446-glitzy-quotable-c4b6@gregkh>
References: <20260514050455.2954509-1-justin.he@arm.com>
 <20260514050455.2954509-6-justin.he@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514050455.2954509-6-justin.he@arm.com>

On Thu, May 14, 2026 at 05:04:53AM +0000, Jia He wrote:
> The miscdev kunit suite registers two miscdevices with the same name
> and expects -EEXIST. The second call currently goes all the way to
> sysfs_create_dir_ns(), which prints "cannot create duplicate filename"
> with a backtrace on every run.
> 
> Walk misc_list under misc_mtx, return -EEXIST on a name collision and
> free the just-allocated minor before returning.
> 
> To: Arnd Bergmann <arnd@arndb.de>
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This should be Cc: right?

> 
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  drivers/char/misc.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> index 726516fb0a3b..d6ffa21ac495 100644
> --- a/drivers/char/misc.c
> +++ b/drivers/char/misc.c
> @@ -248,6 +248,28 @@ int misc_register(struct miscdevice *misc)
>  		}
>  	}
>  
> +	/*
> +	 * Detect duplicate names up-front so the subsequent
> +	 * device_create_with_groups() does not trip
> +	 * sysfs_create_dir_ns()->sysfs_warn_dup(), which unconditionally
> +	 * dumps a stack trace. Both the existing miscdev kunit suite
> +	 * (miscdev_test_duplicate_name) and any caller racing on the same
> +	 * name would otherwise pollute dmesg on every -EEXIST.
> +	 */
> +	{
> +		struct miscdevice *c;
> +
> +		list_for_each_entry(c, &misc_list, list) {
> +			if (strcmp(c->name, misc->name) == 0) {
> +				misc_minor_free(misc->minor);
> +				if (is_dynamic)
> +					misc->minor = MISC_DYNAMIC_MINOR;
> +				err = -EEXIST;
> +				goto out;
> +			}
> +		}
> +	}

Don't do additional {} where not needed.

And as the current code works properly, we are relying on sysfs for the
rejection, why do this now here?  The stack dump is good, it shows the
offending caller, so they can fix it up better.  So why change this?

thanks,

greg k-h
