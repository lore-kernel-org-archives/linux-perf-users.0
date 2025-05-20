Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DD8846F;
	Tue, 20 May 2025 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747774078; cv=none; b=icSEfwmxoeFxt+MaA/iuH9KYyqBiu7TJEnnp2SXdR++YsvI/CBOzUkjVuM1dCAYn0HabjBBR8fpeBbZkoNOwMUH3IpMd8hz/BHMnUrv2nTS7GuTPtYHuV0UffTl81BiwGqT3zMAx1ZcJLgkjsnkqwbocfhk4SAGyZbFf/BDwiLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747774078; c=relaxed/simple;
	bh=esWcjAZHZm91HrjZ2YAinWKjPxhlP8DKozv2RUCL+0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8qZbbVCDnLMtgeh0eHNbLwSmbMTC6OSB57IiHSESYlRw31gh80jX7naxTxjtLPWlEx9SQJsQETxB+haf143WXHXb96hssKCHCCuUowMRWpgYOI4bBcXdppWsDIqE8stBpfoh8LdeB/JDptdiZSvVdosXvSdHczB7G1cB9ue89M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbfcUmJP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbfcUmJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20427C4CEE9;
	Tue, 20 May 2025 20:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747774077;
	bh=esWcjAZHZm91HrjZ2YAinWKjPxhlP8DKozv2RUCL+0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CbfcUmJPMQrsfX3EKSHmzTp9OZVvQ5CwvSYrWHOljY6cTl7uGUA0SXeQQSGA/AUb9
	 R+etIbrOOKVBZPkwVVUjTU6wro0tCMDZtZgkV9zLSA6fY6VLF/epc12NRKpohjpybp
	 Ao0JVfb7D9zrzN5ZBZqAjV+Rc++gzXMNQIG5rruwh25R6zx7suCeg7SQ3dnfDngBaj
	 wYb/L5UWSB8/2oWPqlhff/VefHjRG8DUXfeOyjRM3p3qfMR0GR+KOeM9APOGVEGxWm
	 elKNQNKkZuoVrlK3QwoGbWCumHk1Fpyes3gW2qbNPVHe07YhoXV5nKYVXnlDSYWiMz
	 9NTXYYzKQcASw==
Date: Tue, 20 May 2025 17:47:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: IBS perf test failures on 9950x3d
Message-ID: <aCzqdn3AJji_yPpQ@x1>
References: <aCfuGXUnNIbnYo_r@x1>
 <33e86415-c90d-420a-b7a8-6a360769aea4@amd.com>
 <aColYM3RqE4T5t5c@google.com>
 <aCt4akGLsuuC4aLP@x1>
 <804ac0d6-22f7-40c3-9ff5-e5f9d863d37e@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <804ac0d6-22f7-40c3-9ff5-e5f9d863d37e@amd.com>

On Tue, May 20, 2025 at 04:31:29PM +0530, Ravi Bangoria wrote:
> > Telling that to the user and possibly skipping the test if viable using
> > uname to get the version and if less than v6.15-rc1 print "Skip (needs
> > v6.15-rc1 or newer)" may be an option.
 
> > Then if the bug somehow reappears, people running 'perf test' will flag
> > it.
 
> Sure. Attaching a patch at the end.

Thanks, I'm applying it.

But now that I think about it, it may well be the case that, say, RHEL
backports the fixes in v6.15 for an enterprise kernel that has an
"older" version, so probably the best is for execute the test, if it
fails, then do the version check to decide if it is an unexpected
failure.

But this can be done on top, lets make progress and apply your patch.

> > And I think having it in 'perf test' as well may make the feature to be
> > tested more widely, both by those who run selftests as well as by people
> > trying just 'perf test'.
> 
> Yeah, that was precisely the reason I did it in 'perf test'.

:-)

- Arnaldo
