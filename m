Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974012210E7;
	Wed, 11 Dec 2024 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733947128; cv=none; b=sC2/FjsvWx4R0K434AvzQle5pIjMO1L9xVy6+vkd5WrtOrnXexHfCC0yCFE4WvcIC3r+pNDqAdj7c5XfpUMyWHqhGJVUNRhShiRdOqXNXKDmiZgcf1u5bMzqm/z2I1R1mJ/1hD6yCp4gsrfpcQpza9bOlIGemqWUY1XXe63QK5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733947128; c=relaxed/simple;
	bh=dhLFDG8yhxG4Jz28wmbrWEiDXkkGBh8V42fyrS9Ci8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKwzHS0nVjqqK5C+iMXq/bKQlkyhCUnIprvbfFKav+qRanu+V6r/9zuv2x849+XP7YKTRF5Kh5fCkqaKzDnr8yMN/EJ9+S2WLKegh2x8VIvODgumW0r+QeEURPf6ZXzoMJ9gH9anAnR/+DWVETlfQs2HiSdvjAiIc1Ped6xtAnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0FsqjMZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0FsqjMZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26A6C4CED2;
	Wed, 11 Dec 2024 19:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733947128;
	bh=dhLFDG8yhxG4Jz28wmbrWEiDXkkGBh8V42fyrS9Ci8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0FsqjMZefJtHCXTWW8x1cxaP4vuvcHbqmNgetOTatNlTMZg0RPgISAFs6dEOZdm6
	 jty+hShHdy4AcrokqAAU9xELgSjmOC4UkQ7lEsTff7VmQ/hkoq/KgYqv1s/8NmEGI9
	 j4qlxJSrr4MtgOK8DzDLSSsHz5AT2IWXDT1T4MB81o3akTZglCQ46x473KiCBfmngF
	 zTXwCd8cng+EmCAt6x7HmeNC/SCWSVLWn5Ezy0NM4uJec/p3Qbvn3fcoj3FpP0mX+a
	 lmROB+h1WTUbyHPys76oqsMl8kSWohler/wBH3HoJsRk3K0tW095KXmNXIEPkRl1yG
	 fMtjZEPbzOpDA==
Date: Wed, 11 Dec 2024 11:58:46 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH 0/4 perf-tools-next] perf ftrace latency linear buckets
Message-ID: <Z1nu9vcKEdGS0gb_@google.com>
References: <20241112181214.1171244-1-acme@kernel.org>
 <Z1iFsz-Jis6rgpjb@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z1iFsz-Jis6rgpjb@x1>

On Tue, Dec 10, 2024 at 03:17:23PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Nov 12, 2024 at 03:12:10PM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > Hi,
> > 
> > 	Gabriele has been using 'perf ftrace latency' in some
> > investigations at work and wanted to have an alternative way of
> > populating the buckets, so we came up with this series, please take a
> > look at the examples provided in the changesets.
> > 
> > Thanks,
> 
> Applied to perf-tools-next,

Sorry for the late reply, I forgot about this.  I have a couple of
issues but they can be handled later.

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

