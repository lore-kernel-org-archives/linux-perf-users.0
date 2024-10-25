Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE8B217F20;
	Fri, 25 Oct 2024 21:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890081; cv=none; b=LT1woBVR6RiCz3bNPvIrZaKgdbvRrD4tyETKHUKErCzmnEfE1Iy/l4S+jnXbItqC7truCZRFKWMRTIuF+9z0A8sFi4/15I3xHNW15LMlvZK0D0lnZ04KhFvkogARBrhK0xVfz8RCEsGt2+GHuEctoF1r71E8LJdrKYOnUr5vvbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890081; c=relaxed/simple;
	bh=4kC9OOPueuhcoavQfiVJBXmBpJ9Vh97ZcsIKWrDFl3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4EjNdKTanN+sT0akZ7VH7cu6b4JAEgmZC6TcFL1hjmayJnhDCd2qnQfaCgqttpN7LTlNDVg+vBLCJsQZkdRhCwkjOaFC5nV8miwqRBha5zR++GhAzos7L7CgpiXpoxkJrGEmttwICN5o6BNNb2t4w8XozeaueTzXQMdwDXjeqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJIK0yAO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJIK0yAO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616E2C4CEC3;
	Fri, 25 Oct 2024 21:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729890080;
	bh=4kC9OOPueuhcoavQfiVJBXmBpJ9Vh97ZcsIKWrDFl3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJIK0yAOyVUpB7AdPIbn7Nm8S0OE5ARwPNw36kNZHaXNbzXHUc9I0hHHR6pxyozKb
	 +PtMbNNqekurKCho7liH/xReD5+THr7tGLkoEVKlP1ghT2/jRXP5sT/SZstExp5njH
	 M7rt/SG953pfjb9zREth8QQTxHs9zeqiJH0hYuR0gVvCZtcccLV/TVUpvFdcJdned1
	 QpT7U73qAWwPix9JB1gKRifG9OHmjW6KXTruSF2zZtun56ufAhIeS5k1ll6J0BgpYG
	 1UMMG1o2X/CGeuj4zc00S4sDC2Q/YmkVE279SLQ++pxEawIKKnLvPfyXZaJm0pfOZU
	 lZwPRRnXpuliw==
Date: Fri, 25 Oct 2024 18:01:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	James Clark <james.clark@linaro.org>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>,
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Hwmon PMUs
Message-ID: <ZxwHHWbjIbGh1RU8@x1>
References: <20241022180623.463131-1-irogers@google.com>
 <Zxm5w6wXLxpbERZx@google.com>
 <CAP-5=fXfyd9b7Ns-SL5F+iffc7oy4NFHBsT3oj3CRMbBa1QCfg@mail.gmail.com>
 <Zxp4mbzsFyO5nUh7@google.com>
 <CAP-5=fWP-T57-Bb60eixhgO3m7f_v3y-tWmV=ypuR52iNSAQvQ@mail.gmail.com>
 <ZxvVuFqef2CLwtCs@google.com>
 <CAP-5=fVTU8nUfadXgpUd4my9emsY4c_7znMa9_RWD6VZbGYhZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVTU8nUfadXgpUd4my9emsY4c_7znMa9_RWD6VZbGYhZA@mail.gmail.com>

On Fri, Oct 25, 2024 at 11:26:26AM -0700, Ian Rogers wrote:
> On Fri, Oct 25, 2024 at 10:30 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > On Thu, Oct 24, 2024 at 06:33:27PM -0700, Ian Rogers wrote:
> > > So I think moving the enum declarations into one patch is okay. But as
> > > the enum values have no bearing on hardware constants, or something
> > > outside of the code that uses them it smells strange to me. Ultimately
> > > this is going to do little to the lines of code count but damage
> > > readability. I'm not sure why we're doing this given the kernel model
> > > for adding a driver is to add it as a large chunk. For example, here
> > > is adding the intel PT driver:
> > > https://lore.kernel.org/all/1422614392-114498-1-git-send-email-alexander.shishkin@linux.intel.com/T/#u

> > Maybe others can understand a big patch easily, but I'm not.
 
> My understanding is that we make small patches so that the codebase is
> more bisectable. When there is something new, like a driver or here a

That is super important, having patches being super small and doing just
one thing helps in bisecting problems.

If two things are done in one patch, and one of them causes a problem,
then bisection is a very effective way of finding out what exactly
caused a problem.

But bisection is not the only benefit from breaking down larger patches
into smaller ones.

We want to have more people joining our ranks, doing low level tooling
and kernel work.

Writing new functionality in a series of patches, growing in complexity
is a way to reduce the cognitive load on understantind how something
works.

As much as trying to emulate how the kernel community works is a good
model as that community has been producing a lot of good code in a
frantic, athletic pace, and as much as I can agree with you that adding
a new piece of code will not affect bisectability as its new code, I
think having it broken down in multiple patches benefits revieweing.

Reviewing is something we should do more, but its very taxing.

One would rather try to write as much code as possible, leaving to
others the reviewing part.

But its a balancing act.

Whatever we can do to help reviewers, like taking into account what they
say they would prefer as a way to submit our work, even if it isn't
exactly of our liking, is one such thing.

So if Namhyung says that it would be best for you to try to break down
your patches into smaller ones, like I did say to you in the past, even
taking the trouble to do it myself, in the process introducing problems,
later fixed, I think you should try to do what he says.

He is the maintainer, try to address his comments.

- Arnaldo
