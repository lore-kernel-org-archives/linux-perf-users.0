Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0945237705;
	Mon,  3 Mar 2025 20:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034723; cv=none; b=NxlVnc3GHkiErz4DXvLh0032HeHx8Tmu7I0PV0R2HpdVbb2HoM/kCLv81tyhoA3RMjHsphQj4jPwXsmm1/uyNkPLnbfc8IQp9sqV5MXc4yhn5G/74jWwsFToqbziQ6J4jXppqtHKzX4ucDAGGB4LoKe01MoHGuMWniwaaKEGPvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034723; c=relaxed/simple;
	bh=zLprHZq5avyt9DJrNuzSzQVWZHBCh3vTz5OEK52Y8+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9k4SSO7f5z3RWLVG/AgatpLCvHCnUD/29hvnHwFQRAR56vTEfYBa8WUPhoBuHMDjgWsL5WYCR6VroXDnpp+8EPCqpHNt/YG/F2DC3duJx0NxhSsqwyE6tpBaF+9Re9lCx4xYw/Qsl/5iN8OIejm5OCaUXK2wd+gPfpStsETmCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NI2VeT3O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NI2VeT3O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FAEC4CED6;
	Mon,  3 Mar 2025 20:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741034723;
	bh=zLprHZq5avyt9DJrNuzSzQVWZHBCh3vTz5OEK52Y8+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NI2VeT3OALm/vkngxe0+KlC+z7YHkyz9iAHigcV8C+CztwECIGVt1lRxRRXYJDSZ5
	 38Osgu9fVNZc19F7kx1kQRz89dFfp+A7BtADVV8pe+3LwBusAlACbMB5oDkBXB93uT
	 SzzvpwQLr9Le867OQjUWJvzEwKNabMGDyQYbsyT0XGkaHL7rDXHmGYf/l7cIz36bi5
	 6p0oQHLTb78qeIfQzvFE80eivGnY4/rRjr4RlC0wpKXSlEvv8CJ0qXQl0DaViWtywv
	 UE0LUoHbhalNG6hZB/7efrq4w9G5mRA7/LDNC3/aqcr5uToxjRojaytS//R8TbafDb
	 peThm3rYa/7kQ==
Date: Mon, 3 Mar 2025 12:45:21 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 0/6 v2] Fixups for kernel maps insertion
Message-ID: <Z8YU4egMWtSi_lPQ@google.com>
References: <20250228211734.33781-1-acme@kernel.org>
 <Z8JO5Jp2b4OyHImx@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8JO5Jp2b4OyHImx@google.com>

On Fri, Feb 28, 2025 at 04:03:48PM -0800, Namhyung Kim wrote:
> On Fri, Feb 28, 2025 at 06:17:28PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > Hi Namhyung,
> > 
> >         Here are the patches from the recent session on fixing the build
> > when DEBUG=1 is used, please take a look.
> 
> Looks good.  It's more fine-grained than I expected. :)
> 
> > 
> >         I think that since there are no reported problems and ended up
> > being a sizeable series, we better apply it to perf-tools-next,
> 
> Sure, will add there.

Ian, are you ok with this now?

Thanks,
Namhyung

