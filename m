Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B013D75C6;
	Tue,  8 Sep 2026 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788902525; cv=none; b=kPO9LgG8VDNy+PjNEowCeswxIX9UPH7deWlXwof2m1NrQFrbEs3hAbB7bmUzPOa7FpNGB340KvnC2u+q/TbtsquYWEeaIbAXWLiUq5NkA3UwzZCGygU1HfZHJtNkYHTWjTBejbPMpppxC1KeMNJ7PQJpBEEZPtmDRbvH0ernC6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788902525; c=relaxed/simple;
	bh=ZhZcWFiMh0zqBYnZZrhbXQQgqRUbwk0OsE0nCAUgs48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IviExj5HHfDVaABCCxeJl/519xYpWIx38nrzqZmxw5r9OdvWdY5axSKE9xfZDnf2sSKmxnU58+1Q9yZOYHx0UFTH+ZvpjBTpxYrX4zuLxsrBRNheptyUaLl6q+SNMVdIc44F+MXtk34LFfvSzNtfv3dCBNJd4yOzgmd8Zx3+K4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFYQlLoe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFYQlLoe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7F41F00A3A;
	Tue,  8 Sep 2026 21:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788902524;
	bh=oPPJtP4UwGEWcRBBkaopIzxcAKRPIc35SSqfw35Skwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mFYQlLoedCMxkGxRsTBK9Anat1zu76QJZryCAXRYONevHSYOmnq30ROJEOfi+zf6Y
	 wTgTRHIWDL1L/AOmYFsUu7W7zgheSWJGAEa6fKf6VJ44m8dE8uTnCI4+AVbI8N0QI9
	 ku7MWyEmT6WeE+ZEbM6At57xmRE3/EpaWdncqH8b17QQnq3aL7k+MlkAdqJi0lVeu0
	 O5lUfMoKl2jYD5ii99uanM7kT4xIIa74VVg1Y3tPubHlDr5wRgVtOCcs+TGeQ2FeVR
	 h5pO50HfHJQVcEvr5JABhpEen44yUprpb1RAXD3Bn5hTuOQaNS5OH9TnYb2ECC7pdp
	 DBisTaaVomR3Q==
Date: Tue, 8 Sep 2026 18:22:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Jiebin Sun <jiebin.sun@intel.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/4] perf tests c2c: Add function view stdio coverage
Message-ID: <aqB8eNXwAvKoiMMR@x2>
References: <cover.1787283281.git.jiebin.sun@intel.com>
 <9bd7a313c9c1d71058e857c320c6d5c30cf4cbfa.1787283281.git.jiebin.sun@intel.com>
 <20260821055803.74B191F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260821055803.74B191F00A3A@smtp.kernel.org>

On Fri, Aug 21, 2026 at 05:58:03AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly added `test_c2c_function_report` test fails spuriously because it incorrectly assumes `perfdata` is valid when `err` is 0. If the workload in `test_c2c_record_report` fails, it returns early but leaves `err=0`. This causes `test_c2c_function_report` to process an invalid or missing `perfdata` file, failing its diagnostic checks and setting `err=1` (test failure).
> --

Can you please take a look at this one? Namhyung Acked the series and
the other patches are clean so after this gets addressed I'll merge it.

Thanks,

- Arnaldo
 
> --- Patch [4]: [PATCH 4/4] perf tests c2c: Add function view stdio coverage ---
> commit 32c977aa30c2c6186f39077056298ef3b53307dd
> Author: Jiebin Sun <jiebin.sun@intel.com>
> 
> perf tests c2c: Add function view stdio coverage
> 
> Exercise the function view without driving a terminal now that it has
> a stdio path. Keep the existing datasym record/report coverage and make a
> separate recording of the contended locks used by the futex hash benchmark.
> 
> > diff --git a/tools/perf/tests/shell/c2c.sh b/tools/perf/tests/shell/c2c.sh
> > index f5f223cbf9cc7..cf76359d19ccd 100755
> > --- a/tools/perf/tests/shell/c2c.sh
> > +++ b/tools/perf/tests/shell/c2c.sh
> [ ... ]
> > @@ -58,6 +63,114 @@ test_c2c_record_report() {
> >  	echo "c2c record and report test [Success]"
> >  }
> >  
> > +test_c2c_function_report() {
> > +	echo "c2c function stdio report test"
> > +
> > +	if perf c2c report -i "${perfdata}" --function -c pid > "${perfout}" 2>&1 ; then
> > +		echo "c2c function stdio report test [Failed: report accepted missing iaddr]"
> > +		err=1
> > +		return
> > +	fi
> [ ... ]
> >  test_c2c_record_report
> > +if [ "${err}" -eq 0 ]; then
> > +	test_c2c_function_report
> > +fi
> >  cleanup
> >  exit $err
> 
> [Severity: Medium]
> Will this lead to a spurious test failure if the record workload fails?
> 
> In test_c2c_record_report(), if the 'perf test -w datasym 1' workload fails,
> it returns early without modifying err, leaving err=0:
> 
> 	if ! perf c2c record -o "${perfdata}" -- perf test -w datasym 1 > /dev/null 2>&1 ; then
> 		echo "c2c record and report test [Skipped: perf c2c record failed during workload]"
> 		return
> 	fi
> 
> Because err remains 0, test_c2c_function_report() will conditionally execute
> and attempt to use the missing or invalid perfdata file. This will cause
> test_c2c_function_report() to fail its diagnostic checks and set err=1.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1787283281.git.jiebin.sun@intel.com?part=4
