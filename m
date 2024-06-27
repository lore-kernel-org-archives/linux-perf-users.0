Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFEF19DF67;
	Thu, 27 Jun 2024 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520346; cv=none; b=GPC0O3wmyKlJybRPxRWO2BSOHxGA3mSGh9skLjWLkczxLAnJUcqXp/KuaoPkL7UkKzjQpqmGQqvIyb47EtE2rWA8rzWF8YJ3bVbS8fryheeWyKSqvMcA8k9uWUixqHuCu1AFn+KeMyly2TMQtFA0L8Rl00uxf/FoH2uPurNZN9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520346; c=relaxed/simple;
	bh=v6U7Qf4ZNBZGR0sBVEB+RZMiGfFORW+AzZdlVFXhePM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ys7x2/kt/7pd2hf6QQEg8FwHwET8G5wyT2CCg33r2Gl7mkT3LDdoCjllJ5whtOjXgMNKCF60ZTDKbDrEpdp1KT+IvUpw5/oCY0xr7wraOa1uQyK5aLpJuT0hsPc/IqdpVh4GyniV5zlBJS01xoVH8rX9HQJK20Al/Lb+gy/dOIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEu9W/17; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEu9W/17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B179C2BBFC;
	Thu, 27 Jun 2024 20:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719520345;
	bh=v6U7Qf4ZNBZGR0sBVEB+RZMiGfFORW+AzZdlVFXhePM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eEu9W/17qO5p6tqRNHnuzs911pd34uqlX/oQjgnxI7pQfssfxm6Txbad3UslLcHQH
	 ufVQISz7PGX0K857yk+5nOYHXFQQli5AIup5JWNsstxl3vjRtHpSb/KCvL9Ks5rcDh
	 Fv9ekqHfXfypX1L3U4yKfK7VKBFmUVzwtxsq86BXV9LNe9pFMmAUkoFDKvO0ugr3sh
	 WYaAVwxn+JjVT9g/4OLj9TiIoRwmVl4BGccXXd5UeFDOC4lkIZLu8KBfMm9t2ORMfQ
	 /VJjPj7oJtVzHS4tZncT/w2hmwiZKy1USTIkaCHam7ztT59XrmQCannVH/ALdl0KZU
	 k6NCAWJAp8qvQ==
Date: Thu, 27 Jun 2024 13:32:23 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Wang, Weilin" <weilin.wang@intel.com>
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>,
	"Biggers, Caleb" <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v14 0/8] TPEBS counting mode support
Message-ID: <Zn3MV8lCSHLEEXDG@google.com>
References: <20240624222026.229401-1-weilin.wang@intel.com>
 <ZnxW4u_TB5agiFJT@google.com>
 <CO6PR11MB563505F0D97C0E2D5949F583EED62@CO6PR11MB5635.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CO6PR11MB563505F0D97C0E2D5949F583EED62@CO6PR11MB5635.namprd11.prod.outlook.com>

On Wed, Jun 26, 2024 at 06:17:22PM +0000, Wang, Weilin wrote:
> 
> 
> > -----Original Message-----
> > From: Namhyung Kim <namhyung@kernel.org>
> > Sent: Wednesday, June 26, 2024 10:59 AM
> > To: Wang, Weilin <weilin.wang@intel.com>
> > Cc: Ian Rogers <irogers@google.com>; Arnaldo Carvalho de Melo
> > <acme@kernel.org>; Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
> > <mingo@redhat.com>; Alexander Shishkin
> > <alexander.shishkin@linux.intel.com>; Jiri Olsa <jolsa@kernel.org>; Hunter,
> > Adrian <adrian.hunter@intel.com>; Kan Liang <kan.liang@linux.intel.com>;
> > linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org; Taylor, Perry
> > <perry.taylor@intel.com>; Alt, Samantha <samantha.alt@intel.com>; Biggers,
> > Caleb <caleb.biggers@intel.com>
> > Subject: Re: [RFC PATCH v14 0/8] TPEBS counting mode support
> > 
> > On Mon, Jun 24, 2024 at 06:20:16PM -0400, weilin.wang@intel.com wrote:
> > > From: Weilin Wang <weilin.wang@intel.com>
> > >
> > > Changes in v14:
> > >  - Fix the python import test failure. We cannot support PYTHON_PERF
> > because it
> > >  will trigger a chain of dependency issues if we add intel-tpebs.c to it. So,
> > >  only enable tpebs functions in evsel and evlist when PYTHON_PERF is not
> > >  defined.
> > 
> > I think it's easier if we have Ian's python build cleanup first.
> > 
> >   https://lore.kernel.org/linux-perf-users/20240625214117.953777-1-
> > irogers@google.com
> > 
> > Let me take a look at it..
> 
> Ok, I will hold the cmd option name update until we conclude on this one. 
> Thanks a lot!

Please take a look at the current perf-tools-next branch.

Thanks,
Namhyung


