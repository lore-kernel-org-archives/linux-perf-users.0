Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433C41C8602
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Feb 2025 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440454; cv=none; b=mHNZQqC8BOKRQCWZZAJpURV7xaDJd4GbNYnhmDdwXladOc+2O+HsuyngFmApKECrltA+Xs/J7rh1v4IoKMyWv3o05F/mIS1hS0L2Re6m6t7P5YCkyEKBx1aEP8GJ4yUvQICpaewuGMjm3M31kIBaEmEZwkeq+mDvcLO/+OY6vtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440454; c=relaxed/simple;
	bh=fLBZ35LKVaapc+TT0avTTYKkOJBnCBfPxSL9R9WbquU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1m/vxigoCUiEm9ZdyiafOd4jdRE2cCLk7+SVRQydlBf0dWbNMKTAG7Qzt6Jw0aG2RcLjGSbd8pzuvgHwmkP9JoAzZBTuOwzhmrbJemNgPD4SzRM+aiMAmdomO6vHmQ+bNciSLcUJtdrgI8+bOLrebzxZrBBhUzkY+lP9eEXGeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLTDchHE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLTDchHE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E61BC4CED6;
	Mon, 24 Feb 2025 23:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740440453;
	bh=fLBZ35LKVaapc+TT0avTTYKkOJBnCBfPxSL9R9WbquU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLTDchHECRKm3Z5lDeVr7rp82nJWV4s0Rj/2XTxdWxSAdQ/IPA3akgRl8Un/DLOKo
	 3mF0sUEU4BkRyXxFlS2jeXbMxnbzOjyt/O0uK13+xk+gYOtRr3vqWmhq69aMf2bORP
	 xsshQMOJIp2XyyrIU6AJMVtYTsgLBmJhSM1qOnUSLyPUAEizTNqScalDYhIzwqSuVy
	 ngJYKX+TLNWtOMVJI61qKDTaFmbUAMN4X9hpt6F0pk/P6H+0fPbSn0woie4sijMkjQ
	 eu/ldP4as+cqij0xolZMyL7F9aOQJvI2Rz8p2v2yBvJ44DHTA4YBSt7CiSdSrJ7QRl
	 5PWJO2AljnmAA==
Date: Mon, 24 Feb 2025 15:40:50 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Qiao Zhao <qzhao@redhat.com>
Cc: Veronika Molnarova <vmolnaro@redhat.com>, irogers@google.com,
	linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
	mpetlan@redhat.com, peterz@infradead.org, mingo@redhat.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, kan.liang@linux.intel.com
Subject: Re: [PATCH] perf test stat_all_pmu.sh: Correctly check 'perf stat'
 result
Message-ID: <Z70DgrMlgS_nqYHM@google.com>
References: <20241122231233.79509-1-vmolnaro@redhat.com>
 <1eeb7a39-8c75-4bc3-8be6-d3d1fc0e1a61@redhat.com>
 <8f62887e-f3c5-4b43-8c77-897564dc971e@redhat.com>
 <Z4vv0_-GP5bbNPAj@google.com>
 <CAATMXfkOjMoaOP0LTD58+R0LikpEXi+Sa7g86=6y8EWX5WBZVA@mail.gmail.com>
 <CAATMXfmtSghSj1J91SVimNTLWdi-=--xpyhFn6RwY2b12y+UmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAATMXfmtSghSj1J91SVimNTLWdi-=--xpyhFn6RwY2b12y+UmQ@mail.gmail.com>

Hello,

On Mon, Feb 24, 2025 at 05:34:15PM +0800, Qiao Zhao wrote:
> On Mon, Feb 24, 2025 at 2:59 PM Qiao Zhao <qzhao@redhat.com> wrote:
> >
> > On Sun, Jan 19, 2025 at 2:15 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hello,
> > >
> > > On Thu, Jan 16, 2025 at 01:31:21PM +0100, Veronika Molnarova wrote:
> > > >
> > > >
> > > > On 12/10/24 16:20, Veronika Molnarova wrote:
> > > > >
> > > > >
> > > > > On 11/23/24 00:12, vmolnaro@redhat.com wrote:
> > > > >> From: Veronika Molnarova <vmolnaro@redhat.com>
> > > > >>
> > > > >> Test case "stat_all_pmu.sh" is not correctly checking 'perf stat' output
> > > > >> due to a poor design. Firstly, having the 'set -e' option with a trap
> > > > >> catching the sigexit causes the shell to exit immediately if 'perf stat' ends
> > > > >> with any non-zero value, which is then caught by the trap reporting an
> > > > >> unexpected signal. This causes events that should be parsed by the if-else
> > > > >> statement to be caught by the trap handler and are reported as errors:
> > > > >>
> > > > >>     $ perf test -vv "perf all pmu"
> > > > >>     Testing i915/actual-frequency/
> > > > >>     Unexpected signal in main
> > > > >>     Error:
> > > > >>     Access to performance monitoring and observability operations is limited.
> > > > >>
> > > > >> Secondly, the if-else branches are not exclusive as the checking if the
> > > > >> event is present in the output log covers also the "<not supported>"
> > > > >> events, which should be accepted, and also the "Bad name events", which
> > > > >> should be rejected.
> > > > >>
> > > > >> Remove the "set -e" option from the test case, correctly parse the
> > > > >> "perf stat" output log and check its return value. Add the missing
> > > > >> outputs for the 'perf stat' result and also add logs messages to
> > > > >> report the branch that parsed the event for more info.
> > > > >
> > > > > Hi Ian,
> > > > >
> > > > > is there anything that I am missing? If so would be great to know the idea
> > > > > of your patch. This issue is getting quite old so would be great to get a proper
> > > > > fix together.
> > > > >
> > > > > Thanks,
> > > > > Veronika
> > > >
> > > > Hello,
> > > >
> > > > just wanted to ping the patch. Would be great to sort it out and close the issue.
> > >
> > > Ian, are you ok with this?
> > >
> >
> > Just ping again for this patch, can this fix be acked?
> >
> > And I already tested this patch and it works well on the ppc64le system.
> >
> > Tested-by: Qiao Zhao <qzhao@redhat.com>
> 
> Revert the Tested-by, and when more tests on Intel EMR system, and show other
> "Bad event name" and " value too big for format (umask)" errors.
> This patch needs more tests and rewrites.

Thanks for the test, though!
Namhyung

