Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BFE3112B6
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369806; cv=none; b=dE3Op70BucSfTkNcCDIKKRvwwghxM4jKaeG6dCQKfjoP5lUd8qAG5qaHfTfxk02xskbiAqNaoRiuhjei0jobJhdYI0hpkESdfh1iJ5viJ814r7KjqLcph1zpT8/hLglnRXFU8IV9rPpVFoxvU+/F6iKiyYCHT9qa4rHWlcriWv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369806; c=relaxed/simple;
	bh=MeqC6i69hnBHqaLxtRCJF88WnNOpB53dXS9cvaGAylI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMsjhukhC7sHRr7YLgnLeFLulVOdZ77I2LeSdYHY6VGjX4e17+alsNMpXGDU42J+ULZX0iiaHfRf/Kf9u5Qz2SjaK6bJlo16cRFG6KLovDHuNuFnYbz2rWF3yD4qWQcJ4iRke+JGkml0ycjBonEMT1SCdou5OIbj9R2NuueNMdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBCtd4Kd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBCtd4Kd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D052FC4CEE7;
	Mon, 13 Oct 2025 15:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760369806;
	bh=MeqC6i69hnBHqaLxtRCJF88WnNOpB53dXS9cvaGAylI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RBCtd4KdlDzRFuYkcgCyw3uBFog5+xN2+EA0mLfJKkb9v9JJZgNC8IpW9htEbHWPx
	 MtsNGBoO2sLCUsPOFAd1OWqEgoMIEiAtq2fcWzZb6Iq3hIBYql0OeVPs6Rg9b8Frj/
	 tQmr8/g5dwn2zx7Iy4pWTRkfWnnOFrcpNoxL38CMYzcv314UtZ1Vm8CfAI/4AH/gHM
	 16gbXkSyhtpk7tjZHw9z5iRQ4JCeEjRPnSL6rh1c1mL0VDp9hFap8DOuYy7agtwUz9
	 OGmCeSXwESrAejzB1ev9vUWyFBlogIdQPObRgtKCQfkOZqBB+7ym5in8uzpHGz2JEI
	 fwj2Jso3fVRCw==
Date: Mon, 13 Oct 2025 12:36:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Anubhav Shelat <ashelat@redhat.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Namhyung Kim <namhyung@kernel.org>, mpetlan@redhat.com,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	dapeng1.mi@linux.intel.com
Subject: Re: [PATCH] perf tests record: allow for some difference in cycle
 count in leader sampling test on aarch64
Message-ID: <aO0ci1wX-J3au0-p@x1>
References: <CA+G8DhL49FWD47bkbcXYeb9T=AbxNhC-ypqjkNxRnW0JqmYnPw@mail.gmail.com>
 <901d2d1d-647a-4a76-a0ee-d8a687ed3f85@linux.ibm.com>
 <ff157071-e241-4b81-8241-cfd15e5705ef@linaro.org>
 <7a03fb30-87f9-4737-b59a-9f977acc7549@linux.ibm.com>
 <296700d2-878b-4eeb-b8cd-0252b2f92479@linaro.org>
 <CA+G8Dh+Odf40jdY4h1knjU+3sSjZokMx6OdzRT3o9v1=ndKORQ@mail.gmail.com>
 <CA+G8DhKDvkojDnwxXKe1iiLWwJ0uwD62-qc4_sJgBDdS+qLu-g@mail.gmail.com>
 <f4eba834-e45c-4eba-9650-5b6720fcd30f@linaro.org>
 <CA+G8DhKQkTKoNer5GfZedPUj4xMizWVJUWFocP2eQ_cmPJtBOQ@mail.gmail.com>
 <58801744-44e4-4182-ab4e-bfcf8e2bfc69@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58801744-44e4-4182-ab4e-bfcf8e2bfc69@linaro.org>

On Thu, Oct 09, 2025 at 03:59:54PM +0100, James Clark wrote:
> 
> 
> On 09/10/2025 3:43 pm, Anubhav Shelat wrote:
> > The first machine was running kernel 6.12.0-55.37.1.el10_0.aarch64 on a KVM
> > virtual machine.
> > The second machine was running kernel 6.12.0-119.el10.aarch64 also on a KVM.
 
> That's quite old. Make sure you test on the latest kernel before sending

While I agree with you I think that 6.12 is not really that 6.12ish, as
its a disto kernel, an enterprise one at that, so tons of backports.

Having said that, yeah, the right thing is to build the latest upstream
kernel and see if it works, if it works, try to identify backports, and
only when its determined that it is something present on upstream,
report it publicly.

> patches. The tests in mainline should be targeting the latest kernel,
> especially in this case because the throttling fix didn't have a fixes tag
> so won't be backported.

Right.
 
> That change to fix throttling and group sampling is only from v6.16.
 
> Also what hardware is the VM running on?

Anubhav, please provide this info,

Thanks,

- Arnaldo
 
> > On Thu, Oct 9, 2025 at 3:17 PM James Clark <james.clark@linaro.org> wrote:
> > > After reading that patch it seems like we should actually be removing
> > > the 80% tolerance from the leader sampling test. Both instances of the
> > > cycles counts should be the same now.

> > If there's no tolerance then the leader sampling test would fail much more
> > often. In most of the runs there's at least one case where the leader event
> > has much fewer cycles.
 
> That's assuming that we've agreed that any difference in cycle counts is
> expected and valid. I don't agree that's the case yet and I think it's a
> bug. I only see identical counts, and the commit message in Kan's fix
> describes that the values should be the same for all architectures.
 
> > > (Excluding s390) I'm starting to think you were hitting this bug on an
> > > older kernel? Or something else is going wrong that we should  get to
> > > the bottom of. The test could have found something and we shouldn't
> > > ignore it yet.

> > I agree that the first bug I mentioned might be from an older kernel, but
> > there's still the case here where the cycle counts don't match. I'll keep
> > looking into it.
