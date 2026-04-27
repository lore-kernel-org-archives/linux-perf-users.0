Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285422F7AAB;
	Mon, 27 Apr 2026 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777329435; cv=none; b=sLaCihoYF9KIyX1vXzhB1ZHoTdbhiKb8nBLBPtDaz0KYaFlW62SnC/hCSrJ/nKTUwoXkojN2vX6iQGeEWTJryk33x5rTv1XtrFdHtLUNBYJ3XbjHWBRkHfv/9evmiY48+msjDMmuYRoiF6SL5bXW73WYKUelwRWAfTrnsqHeVpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777329435; c=relaxed/simple;
	bh=ryrHemj4nOF0weS/tOp1X99viaJDpuCxT2dgtUL7CZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCS+B63ahuboRCuJygP7k1ysYyuEoDbaTRypylQ8x8Z06F1Q1/oFdVu+u5EOXcy3g9XC04kmMufyU1rM+bRnSDGxtUNBnS1Mne9c4w/U7wh/qBXbtcQqCFjyBMgnUhcQTgqERFKx+bZj0wm1e9/7mBFQkDrlMQUOrN3btnP2vTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghpVuuO6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghpVuuO6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB2BC19425;
	Mon, 27 Apr 2026 22:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777329434;
	bh=ryrHemj4nOF0weS/tOp1X99viaJDpuCxT2dgtUL7CZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ghpVuuO6pH3nFWtkO3Zr9gIAxJFg9MK+YMkniTinn+/apo0zIP4+Kd0zhCMAXGmtO
	 N0U4RGynTOLDVF8TatgOiYY24pksKMmsMrpQ6erfr9pTNFagYWSHylrYgzTcvGOMKD
	 C9BwwzXVwetdPE/3YRfJ2Vughe7OLYajjsMkoeBMb2IUNc2lrSxjQl0LSI0jufrsMp
	 7MRWpmT0UfeSOefurnF7f95gc3htoL28usg3k2tVuIy2CBmGxg2LRyEp2Fz+jiZfc2
	 jEwwS3WfIZl1h/O1DhKekS8ebldPgpx+BRYyvSGS8qWBoZDjONFcL57c1+ddrlvSKf
	 6acfpU1bzyoDA==
Date: Mon, 27 Apr 2026 15:37:13 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko@lists.linux.dev
Cc: Martin Kaiser <martin@kaiser.cx>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/3] perf test: fix "trace summary" test for musl-based
 systems
Message-ID: <ae_lGcA28pUIfczJ@google.com>
References: <20260427090225.794482-4-martin@kaiser.cx>
 <20260427095745.D6D11C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427095745.D6D11C2BCB8@smtp.kernel.org>

On Mon, Apr 27, 2026 at 09:57:44AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Medium] The `ps --help` test workload is brittle and will continue to fail on many musl-based systems that use BusyBox.
> --
> 
> commit 41e18297314ee059526c7fb6d14d02d61ba92d64
> Author: Martin Kaiser <martin@kaiser.cx>
> 
> perf test: fix "trace summary" test for musl-based systems
> 
> This commit updates the trace summary test to use ps --help instead
> of true. The goal is to ensure the test workload triggers open, read,
> and close events from dynamic library loading on musl-based systems.
> 
> > diff --git a/tools/perf/tests/shell/trace_summary.sh b/tools/perf/tests/shell/trace_summary.sh
> > --- a/tools/perf/tests/shell/trace_summary.sh
> > +++ b/tools/perf/tests/shell/trace_summary.sh
> > @@ -14,7 +14,7 @@ OUTPUT=$(mktemp /tmp/perf_trace_test.XXXXX)
> >  
> >  test_perf_trace() {
> >      args=$1
> > -    workload="true"
> > +    workload="ps --help"
> 
> Will this workload still fail on musl-based systems that use BusyBox?
> 
> Many musl-based distributions, such as Alpine Linux or OpenWrt, frequently
> use BusyBox to provide standard utilities. BusyBox's ps is typically
> statically linked or links only to libc, without depending on libprocps.
> 
> Furthermore, running ps --help in BusyBox generally prints the usage string
> and exits without performing file I/O, which means no open, read, or close
> events will be generated.
> 
> Would a command that natively performs file I/O, such as cat /dev/null or
> dd if=/dev/null of=/dev/null, be more robust here?

Sounds right, it'd be nice if the workload doesn't print anything like
above.

Thanks,
Namhyung

> 
> >      search="^\s*(open|read|close).*[0-9]+%$"
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260427090225.794482-1-martin@kaiser.cx?part=3
