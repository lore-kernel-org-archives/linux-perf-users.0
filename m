Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C0D2EB87F;
	Mon,  6 Jul 2026 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783364941; cv=none; b=qalOiFo60Dhw/dGKlFJuOQpFuSZ5XQt0PpsKL/VITz2MBhEwhQNOPiZiKkRuGYaAY4C90VsN35ExxDy9Uvz9sgRjVbdGczU90SmDmkIMPt7f523nawO3hPlg3lgecDEOLxq4QSQooqNud3GDGAiEJt77BmlesV263oBTXb0Qc9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783364941; c=relaxed/simple;
	bh=IRxpKgcUvBsScRM1pNk+QcDvVDcANKL0AzXqwqNtqt8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HBpvjpBBLLoX88utRN/z69hSY1nzHUpIIID+Cclpm1T87CCFpMbqwb3uHGcRbpz0Taf0Kud2UTPJKegZf0nrjF5vzWGPVKZQ+xzEs9b0/c3MN/Uh5/uyo7JQvtFwZ+W7J0r9g2jCeLfI+ntEydvAAmIVsadFfrWHsEhHqvv6/MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=Rk8piPVl; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="Rk8piPVl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To; bh=sLBi1mLjuOsmCbXKulThbAcmQe2EjXxytN83eJmdsDU=; b=Rk8piPVlEX4cA2jt
	mniFWAtbN7zkyftv/0YB53rbjIQhExe4W8ECeDV5x+aQLK2fFc0FFdgF7hJRt5Eed8qePyHWQDgGq
	KA0Nr6lEQSocl7kwoS2IkcVR5Pa9XuCOF9XZMixB3oDVaa+HumQRWqcizec0CCxx/Pxsy+zlFOX6d
	9AWuJ1iy5gt9/gF4HkTNqHRSBgF7pJd6dTWBl8RdGKUoeE497r3vpz1RzDVlsBUhouWmHU9uHFIGe
	+3Rd9GaRyfa2LceRI/jApq0os3450yq+Z5SICIDFICmZlQzoqccZLB+gG9jI//jjDtIeozIzFI0KS
	zrdDAAZ/GveR5Q4UYQ==;
Received: from ipa12.colo.codethink.co.uk ([78.40.148.178] helo=webmail.codethink.co.uk)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wgogE-00GsMg-HT; Mon, 06 Jul 2026 20:08:34 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 06 Jul 2026 20:08:34 +0100
From: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH] perf jevents: make events order more deterministic
In-Reply-To: <CAP-5=fWm8q6EX29hY33xoDNFJYoGOB4GnsLkXarUFzsoUZVEqg@mail.gmail.com>
References: <20260706175624.692736-1-nazar.kazakov@codethink.co.uk>
 <CAP-5=fWXhESb=4TMyt2X9oM64h5xwpNf7VGqXCs+NbPr8zeuGA@mail.gmail.com>
 <9871da36895a05e0ca5646ba6edf4a52@codethink.co.uk>
 <CAP-5=fWm8q6EX29hY33xoDNFJYoGOB4GnsLkXarUFzsoUZVEqg@mail.gmail.com>
Message-ID: <33e2fcf9b93f39e9e75e80b1af1bdb1c@codethink.co.uk>
X-Sender: nazar.kazakov@codethink.co.uk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: nazar.kazakov@codethink.co.uk

On 2026-07-06 19:48, Ian Rogers wrote:

> I see the problem from your example. I wonder a more complete fix
> would be something like:
> ```
>    def __lt__(self, other):
>      """Sort order."""
>     if self.name != other.name:
>         return self.name < other.name
>     if not self.expr.Equals(other.expr):
>         return self.expr.ToPerfJson() < other.expr.ToPerfJson()
>     return self.description < other.description
> ```
> wdyt?

Yep, your code looks better. Also Sashiko AI tool found an embarrasing
bug in mine 
https://sashiko.dev/#/patchset/20260706175624.692736-1-nazar.kazakov@codethink.co.uk?part=1

So let's go with yours :)

Thanks,
Nazar Kazakov
