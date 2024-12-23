Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC341A8F83;
	Mon, 23 Dec 2024 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734972088; cv=none; b=cZDy5/XLWYedtsBze2nUIYcErYoRPp0rNEcCFQVtWOIUx9SwSLh/xhYiucC3uHoUqtno84lvc24PeS2sHYx050BARdv3Em2jOKy/AyTususwDiMjclAVlnbiLknmeFuuVsgEESDE7LEich7oV7tvqAs3azv2QwAcebB93Xv4vZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734972088; c=relaxed/simple;
	bh=HjB6wLSyLiTj2lwjl2TPxriL0U+ZMW5FXC2Ak9YSinQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ng25K6LNlkmLjAhsZ/nkiqEuouXAsHnopIVXqJdLrg6dM9uy2S+dI4gYmbpWXNbVoFjj12k6HMDQbu1i2tYc2/I6yKvrzCHDShsgccBuYbOLL7yAQtCOzf96JA1T2voPLh6R+kL8Q8ENFJCx2MPlH+Ug/DR6KofLmAQDbAWencc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=dfmfN5Q3; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="dfmfN5Q3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=Mr+P6kfbfUI/3ukImnvatiC+T2rngIi46bkm82WFobY=; b=dfmfN5Q3ucK7jWbk
	WH3cFb0bscPc3M5aDWeekGYnIifQBRujYPWLb8mAR3QL0vjO1YnBw/6O00pFlPTQrWZQ3kK+5c88v
	c/Or49F4OVcMUumTtT6RXAMGijqpuWpEbuNCrh0c2oDr815OsGtgO7p63a4V/mJiTONHRcC/P0c6m
	7QNadIpAiMhS0JZQyPiLTRB8v8GcxS8pg0ADaBJMszEJ47QiJcSdIHMPD1tg98yKp6IPYj2z6ox5+
	3SKe2lTVNqT7bIeoXDp4SajR1BdVXJH7mWN7E22RVZyAZPCpURTAqfmR80rzI/MP0s/xKf8/3dmnL
	IeWIim7GRZLJ+ZEtfg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tPlUZ-006tmg-2N;
	Mon, 23 Dec 2024 16:41:15 +0000
Date: Mon, 23 Dec 2024 16:41:15 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: irogers@google.com, peterz@infradead.org, mingo@redhat.com,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Remove unused is_executable_file
Message-ID: <Z2mSq4LuLgvF4MwZ@gallifrey>
References: <20241222215831.283248-1-linux@treblig.org>
 <Z2mQjAIwBcx4_Pm0@x1>
 <Z2mQ4RdSE_EfbGyO@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2mQ4RdSE_EfbGyO@x1>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 16:40:52 up 229 days,  3:54,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Arnaldo Carvalho de Melo (acme@kernel.org) wrote:
> On Mon, Dec 23, 2024 at 01:32:15PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Sun, Dec 22, 2024 at 09:58:31PM +0000, linux@treblig.org wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > is_executable_file()  has been unused since 2022's
> > > commit 7391db645938 ("perf test: Refactor shell tests allowing subdirs")
> > > 
> > > Remove it.
> > 
> > Did you patch this on:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
> > 
> > ?
> > 
> > That function is still there, so I'll fixup your patch, keep your
> > credits and test it all.
> 
> FYI, it fails on the .h file:

Ah, it's because of the new 'is_directory_at' is added just above.

Dave

> ⬢ [acme@toolbox perf-tools-next]$ patch -p1 < ./20241222_linux_perf_tools_remove_unused_is_executable_file.mbx
> patching file tools/perf/util/path.c
> Hunk #1 succeeded at 77 (offset 10 lines).
> patching file tools/perf/util/path.h
> Hunk #1 FAILED at 12.
> 1 out of 1 hunk FAILED -- saving rejects to file tools/perf/util/path.h.rej
> ⬢ [acme@toolbox perf-tools-next]$ git diff
> diff --git a/tools/perf/util/path.c b/tools/perf/util/path.c
> index 9712466c51e2f30e..2e62f272fda8671a 100644
> --- a/tools/perf/util/path.c
> +++ b/tools/perf/util/path.c
> @@ -77,15 +77,3 @@ bool is_directory_at(int dir_fd, const char *path)
>  
>         return S_ISDIR(st.st_mode);
>  }
> -
> -bool is_executable_file(const char *base_path, const struct dirent *dent)
> -{
> -       char path[PATH_MAX];
> -       struct stat st;
> -
> -       snprintf(path, sizeof(path), "%s/%s", base_path, dent->d_name);
> -       if (stat(path, &st))
> -               return false;
> -
> -       return !S_ISDIR(st.st_mode) && (st.st_mode & S_IXUSR);
> -}
> ⬢ [acme@toolbox perf-tools-next]$
> 
> ⬢ [acme@toolbox perf-tools-next]$ cat tools/perf/util/path.h.rej
> --- tools/perf/util/path.h
> +++ tools/perf/util/path.h
> @@ -12,6 +12,5 @@ int path__join3(char *bf, size_t size, const char *path1, const char *path2, con
>  
>  bool is_regular_file(const char *file);
>  bool is_directory(const char *base_path, const struct dirent *dent);
> -bool is_executable_file(const char *base_path, const struct dirent *dent);
>  
>  #endif /* _PERF_PATH_H */
> ⬢ [acme@toolbox perf-tools-next]$ 
> 
> Fixed up, thanks.
> 
> - Arnaldo
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
