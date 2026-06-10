Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A48829C328;
	Wed, 10 Jun 2026 18:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781116087; cv=none; b=T7XEmE3eZ439DYf9+mGw8nDDNJmz8SnZzT0wMr7o3EYnJMxx9iQRKvhTjy6cJRoDMj4SsmktsL/oTHHseZcgIQj+E2LlvymyGKVhCvPOKDqF1RZ/wOkIua8nsJVPlGFIoCmFcCgnt330QJyFSY+D+Ca1jIlraN6709CvmM86Krw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781116087; c=relaxed/simple;
	bh=LQMoWoVksnkFllqaCsGvrEV9KrxZuQ5A08D/MNSUGYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEwlULBvr8Tpa+RdcPm/Iiy4zWKuiA4HKFZQYY3Ol5UumC8sz31Qm8WAmOfoJh6ekfpvvcVAihXH10VIE3uVjHSvLaaK++6ZWyHhcXP42aRhQFdjtnkKnvwNPmxzNp9fsqGRAlJVrmqwO6u5lLOvTyedHlUCmU8YVEfJvvliQvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Syco/DdV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Syco/DdV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF3D1F00893;
	Wed, 10 Jun 2026 18:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781116085;
	bh=6mwDDkamQC7TNW5CKmpG9XSWcIcf1yy0lxFIvVkvUSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Syco/DdVmroDrrciiA1rsgGSbgYKBFeSrMSB3NncIivNYhIjuZu7NbkioAYH939IS
	 LgZQ/AcxD4e6Lq4ngAtTcJxSkVwCyDDa/JW3meAlQ89tE+esjEravxylxD73gpRWCc
	 lvEtc9bXP1j04bglffg9eRAay9//aFQ/PIsXOHNwtnX7g3aFUmYYRHH+bq613Al6oB
	 LSi++wwcyHeJJG/QBU+XSew++LiKR4abZDURc8wNaVLEYWWePcIDQFoQuMPsQACu/i
	 mJuQ5iwEQzD0OLvJyxb1WUt1Nw7IatLJOWLWgjrkiDChQgXKvujfilbMWSo6dPV9i8
	 4fWc7LqCNuGBA==
Date: Wed, 10 Jun 2026 15:28:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 05/11] perf sched: Bounds-check prio before test_bit() in
 timehist
Message-ID: <aimssBwELS-gZjlc@x1>
References: <20260610165207.2077258-6-acme@kernel.org>
 <20260610170401.1B5091F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260610170401.1B5091F00893@smtp.kernel.org>

On Wed, Jun 10, 2026 at 05:04:00PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The patch introduces a logic error that causes invalid negative priorities (<-1) to bypass the `--prio` filter.
> --
> 
> commit 3165982942697d89513b8b104d95d745a4412391
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> perf sched: Bounds-check prio before test_bit() in timehist
> 
> This commit adds a bounds check to timehist_skip_sample() to ensure that
> priority values from untrusted tracepoint data do not exceed MAX_PRIO before
> calling test_bit(). It also updates the sentinel check from != -1 to >= 0.
> 
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index 1ff01f03d2ad1..ded511d851880 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> > @@ -2645,7 +2645,9 @@ static bool timehist_skip_sample(struct perf_sched *sched,
> >  		else if (evsel__name_is(sample->evsel, "sched:sched_switch"))
> >  			prio = perf_sample__intval(sample, "prev_prio");
> >  
> > -		if (prio != -1 && !test_bit(prio, sched->prio_bitmap)) {
> > +		/* prio comes from untrusted tracepoint data — bounds-check before test_bit */

Updated the comment to:

-               /* prio comes from untrusted tracepoint data — bounds-check before test_bit */
+               /* negative prio means no info; out-of-range prio can't match the filter */

To address the comment below.

- Arnaldo

> > +		if (prio >= 0 &&
> > +		    (prio >= MAX_PRIO || !test_bit(prio, sched->prio_bitmap))) {
> 
> [Severity: Low]
> Does this logic inadvertently allow invalid negative priorities (less than -1)
> to bypass the --prio filter?
> 
> By explicitly replacing the prio != -1 sentinel check with prio >= 0, the new
> logic evaluates to false for any priority less than -1. This causes the block
> to be bypassed, meaning rc remains false and the invalid negative priority is
> not skipped by the filter.
> 
> Should the check be restructured to ensure that invalid negative priorities
> from crafted or corrupted perf.data files are also properly skipped?
> 
> >  			rc = true;
> >  			sched->skipped_samples++;
> >  		}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260610165207.2077258-1-acme@kernel.org?part=5
