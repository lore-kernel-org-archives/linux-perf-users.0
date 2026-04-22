Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2003736B044;
	Wed, 22 Apr 2026 07:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776841961; cv=none; b=QQCp0iwoSG6anEjPgZcFb1K7MSy2Y7PwbownD2PSGJVfMdxbEvrcn2z3ykn5mdEwZT2hdrLx7wRXMEYt+PS48f0NTThUOXNnSxGvsMsjDZrZj4AYj5IJkbfAr4u94vmK5Yxjsn2e0InXRtaYPgqqr59TYKQ8+AaKNjTUo+9bVQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776841961; c=relaxed/simple;
	bh=r2hDqGz+4tfYw9UMLtpNDeVaHUrcpNklZbUb9y9DTt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDhAR1V4qmwmPn1teDV/QT3J01ji38hlRooFV8dHHj3RQGRc4j+FKjx8TjwT7DyA7ewX/E5TDyDbDOhWq73im3giqLv6Q22ZmGHN7Pf62eDQ6Izb5M+CaRR4OWq1wEpj/dgSJiAb3Up4Ak4ykDdb3bGXUI2V9no1DAM4LR8EEnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfOBc0D+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfOBc0D+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4A4C19425;
	Wed, 22 Apr 2026 07:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776841960;
	bh=r2hDqGz+4tfYw9UMLtpNDeVaHUrcpNklZbUb9y9DTt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jfOBc0D+HWmbe3SMW2k1LP0C6pCxlQITYanOpZXrB67sv4Q1CQoNK9j5f/0R9NxZ9
	 zDaemFyK5p/uorDQstkOXdJn/47Pjr75CCNRpIMBj00wFBEyR+XhZwpBhSGebIWavb
	 FUNn0aRxCupRFnEQJdTu3n7bd2ld35Lpcls0WPX+d9fkFGaokoI0Xr6SaQOxJNAC5o
	 Ri9GuW5psAH8H1QdYp0g3dtCImHRr1CH2QdYYXMtDLlWf0QZHrKDTVoGqTCKOWlshy
	 hL613Ehf5LMeJYKfbIq257myHVGAi5W2bsDAB5qxgRqSXkLVMT5G/aiCXQgkbxpcyB
	 UgMZDMHFNCd4g==
Date: Wed, 22 Apr 2026 00:12:39 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf build-id: Fix wrong return value checking
Message-ID: <aeh05xy0gnlk33PN@google.com>
References: <20260420180858.129075-1-namhyung@kernel.org>
 <20260421003005.38E7CC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260421003005.38E7CC19425@smtp.kernel.org>

It's annoying that sashiko removes all recipients.

On Tue, Apr 21, 2026 at 12:30:04AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 2 potential issue(s):
> - [High] Missing O_NONBLOCK during build-ID extraction enables indefinite hangs on FIFOs via TOCTOU race.
> - [Medium] The strict length check rejects valid 16-byte build IDs (e.g., MD5/UUID), causing `perf buildid-list` to fail for them.
> --
> 
> commit 7e5fc011b65e40f9f999c08196173059dcbc7f79
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf build-id: Fix wrong return value checking
> 
> This commit adjusts the return value checks of the build-id snprintf
> functions to correctly account for the terminating NUL byte when comparing
> lengths. This ensures perf buildid-list properly displays build IDs instead
> of returning errors.
> 
> > diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
> > --- a/tools/perf/builtin-buildid-list.c
> > +++ b/tools/perf/builtin-buildid-list.c
> > @@ -60,8 +60,8 @@ static int sysfs__fprintf_build_id(FILE *fp)
> >  	char sbuild_id[SBUILD_ID_SIZE];
> >  	int ret;
> >  
> >  	ret = sysfs__snprintf_build_id("/", sbuild_id, sizeof(sbuild_id));
> > -	if (ret != sizeof(sbuild_id))
> > +	if (ret != sizeof(sbuild_id) - 1)
> 
> Could this strict length check reject valid 16-byte build IDs?
> 
> The kernel and perf subsystem natively support shorter 16-byte build IDs
> like MD5 or UUID. For these, sysfs__snprintf_build_id() would correctly
> return 32.
> 
> Since 32 does not equal sizeof(sbuild_id) - 1 (which evaluates to 40), will
> this erroneously return -EINVAL and cause perf buildid-list to silently
> ignore valid kernel maps and binaries?

I'm not sure about this but I guess it's supported (by padding zeros at
the end?) as we've been using this for a while.

Also this is not related to this patch anyway.

> 
> >  		return ret < 0 ? ret : -EINVAL;
> >  
> >  	return fprintf(fp, "%s\n", sbuild_id);
> >  }
> 
> [ ... ]
> 
> > @@ -72,8 +72,8 @@ static int filename__fprintf_build_id(const char *name, FILE *fp)
> >  	char sbuild_id[SBUILD_ID_SIZE];
> >  	int ret;
> >  
> >  	ret = filename__snprintf_build_id(name, sbuild_id, sizeof(sbuild_id));
> 
> Does the underlying build-ID extraction sequence miss an O_NONBLOCK flag,
> potentially allowing indefinite hangs?
> 
> When filename__snprintf_build_id() processes user-supplied file paths, the
> underlying open() call happens without O_NONBLOCK. 
> 
> While there is an is_regular_file() check beforehand, could a time-of-check
> to time-of-use race allow swapping the file with a FIFO or blocking device
> immediately after the check, causing the tool to hang indefinitely?

Well, I think that's technically possible but I'm not sure how practical
it is.  Maybe it's ok to add O_NONBLOCK anyway.

And again, this is not from this patch.

Thanks,
Namhyung

> 
> > -	if (ret != sizeof(sbuild_id))
> > +	if (ret != sizeof(sbuild_id) - 1)
> >  		return ret < 0 ? ret : -EINVAL;
> >  
> >  	return fprintf(fp, "%s\n", sbuild_id);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260420180858.129075-1-namhyung@kernel.org?part=1
