Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5E923E320;
	Thu, 16 Apr 2026 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776358013; cv=none; b=iV1Jiu54jRq8TAVn2vu1nP+Hby12J6hhkwdMoxDZS8LyyZ2g9uvMWC4/3WoIBVGn4FrN3imlQ/xffRCWlGNucVw8IBRxwQ1PVxT8kDcB9DhCXZ9a6E02uOrJSqPOSjCgXQ13WdmrN5QziFOTkM7gsPFENc/dvrQ0jrQy7Vr7s3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776358013; c=relaxed/simple;
	bh=zoC0/f8p5PDRd2frZwxw/b4R/QsJ0LXfJceDIcwgKgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwAGi5d8lk4i+5APErQ+filpWHCR7ZHodGKnAG8kH2nbZ3+Aou8UQRb3mbciuQ5dMLcTGE6OHu7xgyrEfwyftyoWoJ7KhEobSaBjIXkHfX1C6xBrudYjXY9VBaOV51biBmZF7HU3/rbNctr/paPx2OrS+17nJzVg3JelZS8SMQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwDieI5Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwDieI5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FB1C2BCAF;
	Thu, 16 Apr 2026 16:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776358012;
	bh=zoC0/f8p5PDRd2frZwxw/b4R/QsJ0LXfJceDIcwgKgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwDieI5Q3UkvKA6HVjTsB2C/3Gk46ZhS2Gqmh1qNlelEn3/1AfCWTeuu/Sdcq/8hq
	 UBcQLh8YLK2GGkh2V72xvaPzyes+QAYgYZ/hrandl2/ZHPHn6avYIY0wAiR8OUNa5S
	 njgG5iVCXN4H/0Z58aWqpAiQriJFrDLvVJKBF+4ZUc6s3lvfzSeTlatHh4AuZxxFu6
	 344hWtzLszqUW0gOOghH+QFKTlAip6sNMEhqRV/zm/d9j4OBZ9fVcN8dDyVF1L7DUi
	 DUgL5dX9vI943LjPMxXjj1B+AImKeAPJ9VS9bhEiL6ceKAWXxXbkNQcsguDisoXDIh
	 hXo1S/DOct08A==
Date: Thu, 16 Apr 2026 09:46:47 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHES 0/5 v2] More perf.data header validation
Message-ID: <aeESd1KY7NqC5sYH@google.com>
References: <20260416001424.362797-1-acme@kernel.org>
 <2231f14c-0467-41d7-8774-5f720edc0e18@linaro.org>
 <aeEAG2F3ERbSv94-@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeEAG2F3ERbSv94-@x1>

Hi guys,

On Thu, Apr 16, 2026 at 12:28:27PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Apr 16, 2026 at 02:17:37PM +0100, James Clark wrote:
> > On 16/04/2026 01:14, Arnaldo Carvalho de Melo wrote:
> > > Hi,
> > > 
> > > 	This is picking up from what was reported in the previous
> > > series, pre-existing lack of perf.data file validation, processing files
> > > and buffers in header.c in a similar fashion.
> > > 
> > > 	There is more to process in the trace data, but that is a
> > > different can of worms that needs to be dealt with in a similar,
> > > upcoming patch series,
> > > 
> > > 	This is probably 7.2 material, but if feeling this can still
> > > sneak into 7.1, feel free to do it :-)

Right, I don't want to add non-urgent changes to 7.1 at this point.
I'll work on finalizing the PR message.

Thanks,
Namhyung

