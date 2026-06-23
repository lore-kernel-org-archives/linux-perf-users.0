Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C0831F985;
	Tue, 23 Jun 2026 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233549; cv=none; b=Zs7Lff63Yk0v8TVpAXXrx3N06S0ra/MGkPUDHG9L1KrnFQFqarLaAv/KnOsZWn8Y9VeDiGKWE+d6tY+wUOJ5xKnBu8Ue7qY5jUphQgK4AXoqTPZCNkuh4JmDUHlCPkBW67bp4E7z2I9erVHSTO+qi7cQU5uXOEmNe8MW0qCmfts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233549; c=relaxed/simple;
	bh=UYWOptM37JOqNL1tejgv4fbtap5pycxkgQPycqdZQBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5y4mHX3ul4jkgpR1nD9uXzyZOoLEQxL2YXYZff+PIqugvTki10DUQEqVw5Xnb6jFuz+8GJW3Bly7XaXA55PtQNBqdd6wvU1vX8fV9f2FIVWoEo71LfuT4XQqDrHbWzrLxGjfKpP+4CPJz2p4TfN8iGByznWW99CaId+/vL+R2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdboKwUX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdboKwUX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7B21F000E9;
	Tue, 23 Jun 2026 16:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782233548;
	bh=xIHwRB2oKcXUGAkVZTMiCM8TWyMtXCzCtm8mb1pouSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HdboKwUXIzMH7Ta7dsrJSwDf0HBUVsDw299CtxA8qdYjp0MTIj5XXyNk+IhQW2p/1
	 T6kVJDfb1XuX+6Pjha1DkRQp55Yv2IRVlc+JQbs+VGH0CwF4Y4bK1PqX1wN7iDhZZd
	 8mcMPjuJdblIH3GUKIPm514db7DTf1q+/FH0Y9qAITdxStBz3H6+fu0K1A16J0L8tz
	 u8QllWXvZd2sYeF+96Y3Z62O+8LLnZL3HYbEmdTEtOVNDd/njXDrNEAOhT3ql3LqfU
	 kAz6WzAwGkI2YoV9JUz3ukh1gHadYtO48A8kQlzP5uq4KGZtJ12eatS/o4wZJ+Q67x
	 m1Kk8mEOE5YBA==
Date: Tue, 23 Jun 2026 09:52:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/4] perf test: Simplify perf kvm record/report tests
Message-ID: <ajq5ykK0tdf4vqlo@google.com>
References: <20260623070313.55225-1-namhyung@kernel.org>
 <20260623070313.55225-5-namhyung@kernel.org>
 <20260623070915.16B291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260623070915.16B291F000E9@smtp.kernel.org>

On Tue, Jun 23, 2026 at 07:09:14AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The synchronous `perf kvm record` command is not wrapped in an error-checking conditional, causing the script to unexpectedly abort via `set -e` upon failure.
> --
> 
> commit a940fab65237cd8e4c37035fe66af932fcd3f955
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf test: Simplify perf kvm record/report tests
> 
> This commit simplifies the perf kvm tests by passing sleep directly as a
> command line argument to perf kvm record, rather than running it in the
> background and manually killing it.
> 
> > diff --git a/tools/perf/tests/shell/kvm.sh b/tools/perf/tests/shell/kvm.sh
> > index f88e859025c42..4ca10388748de 100755
> > --- a/tools/perf/tests/shell/kvm.sh
> > +++ b/tools/perf/tests/shell/kvm.sh
> [ ... ]
> > @@ -63,13 +63,7 @@ test_kvm_record_report() {
> >  	echo "Recording kvm profile for pid ${qemu_pid}..."
> >  	# Use --host to avoid needing guest symbols/mounts for this simple test
> >  	# We just want to verify the command runs and produces data
> > -	# We run in background and kill it because 'perf kvm record' appends options
> > -	# after the command, which breaks 'sleep' (e.g. it gets '-e cycles').
> > -	perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" &
> > -	rec_pid=$!
> > -	sleep 1
> > -	kill -INT "${rec_pid}"
> > -	wait "${rec_pid}" || true
> > +	perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" sleep 1
> 
> [Severity: Medium]
> If this command fails, will the script abort immediately due to set -e being
> enabled globally?
> 
> The previous implementation guarded against non-zero exit codes by using
> wait "${rec_pid}" || true. Without an error-checking conditional or an
> appended || true, a failure during this synchronous execution could cause the
> script to instantly terminate.
> 
> Would this bypass the test's intended logic of recording the failure (err=1)
> and accidentally skip subsequent tests like test_kvm_buildid_list?

I think it's ok to fail when the record command failed.

Thanks,
Namhyung

> 
> >  
> >  	echo "Reporting kvm profile..."
> >  	# Check for some standard output from report
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260623070313.55225-1-namhyung@kernel.org?part=4
