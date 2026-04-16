Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAB8283C82;
	Thu, 16 Apr 2026 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776368142; cv=none; b=IvpCKRe03HJnp0zRo6jm2lz8p8bxC4Hp1FfsPdMCFiFWOwlyjDFCxEjmlWZcl0X+CcfriCeY8WBh9e+l89mnvoQQrNSj3hnebV5F0oYUhWqOFDu/JJHfEYuxlUw6z1mANUA0C+l+5s2DmS0gxkhQs/TGdFMrfoq+Zc/aaeDT9Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776368142; c=relaxed/simple;
	bh=gBlWVg+IPb8Kd75Wg1wM2Qt9jfUoi72p10vM1ry0jCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJMiBUwgH8KOZkXIPnc17N2N82Y27Oupx6Hbn/TeZoqQ+62/RLqVAGEViQurgqTJeNwo6h0N82rwZ+RWwD1fauTr2uluNOT5k29RSGIbdI3obX2PAuoC3IZWrIlrR9sdI20/L2o1Ldr1qqpl8dsmhSZeEnK4Hz10hIKJrLnYd2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4GNIpBN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4GNIpBN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3865BC2BCAF;
	Thu, 16 Apr 2026 19:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776368141;
	bh=gBlWVg+IPb8Kd75Wg1wM2Qt9jfUoi72p10vM1ry0jCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R4GNIpBNd4xetC2h0JWKFo7LIEgrrsoSagktffgljmC0tkL/QTzr0uqvaCKIFluRW
	 uMpXU6FyMoDC72gDoW2095ier8Q3CJxY+y/5ZluR4BP2yiBr4VS981A5wgTnoOSCJw
	 QngU1A2ea8CBeL1buZsvs239W++2vfiL84cBouMVFhEbNi6pOXS0KvvmHOB6fNOQeI
	 syFhgRjdCOr0Rjbacr/T+yhXK4ZAs+gg8XnrEHuxCEA6eYOwP4OQj1oGfQWbq7cOri
	 61BiJfCgGC0ftkn3JE1Fuib8HCu/btq58K5aHL71BPICSCAktyf4ML5KWY/GxGDoKP
	 Jiy+apJUgFDSQ==
Date: Thu, 16 Apr 2026 16:35:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@linaro.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHES 0/5 v2] More perf.data header validation
Message-ID: <aeE6CSp4zafjAUNR@x1>
References: <20260416001424.362797-1-acme@kernel.org>
 <2231f14c-0467-41d7-8774-5f720edc0e18@linaro.org>
 <aeEAG2F3ERbSv94-@x1>
 <aeESd1KY7NqC5sYH@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeESd1KY7NqC5sYH@google.com>

On Thu, Apr 16, 2026 at 09:46:47AM -0700, Namhyung Kim wrote:
> On Thu, Apr 16, 2026 at 12:28:27PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, Apr 16, 2026 at 02:17:37PM +0100, James Clark wrote:
> > > On 16/04/2026 01:14, Arnaldo Carvalho de Melo wrote:
> > > > 	This is probably 7.2 material, but if feeling this can still
> > > > sneak into 7.1, feel free to do it :-)
 
> Right, I don't want to add non-urgent changes to 7.1 at this point.
> I'll work on finalizing the PR message.

Agreed, I'm addressing some more Sashiko review comments and trying to
run it locally before sending a new version for this series.

- Arnaldo
