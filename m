Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD50A1A683E;
	Wed, 10 Jun 2026 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108992; cv=none; b=pkGXQ5eEnKh6hqXihJCsFWVp1VY7c+ve4SD/ZwytL2re5Nk3QbmidpdCd35IG7MQj0rIXOLHiUEd63Yp1ox9oWO7NEuHFs5qNLmrfDx4Dp4fInOt2BLIlxSmH9ql1gtYnKVtBjcPdtACmDkhEKUaS5xfCAAyCyCLXJV+sx47h/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108992; c=relaxed/simple;
	bh=J9fDtTY/S1t42qKo8xW/SEJzVRf8B34wLgAeVLKfcDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZimlUQ3SDiZ3aAU4cLQwu/dfKnW3B4xJGlX9CFUzRa9RME3GEDQENiSJ7ZMY1Z3rpjDXjQT9Ww1b0NAKfXJKArL20Qzluf6tOy9My/iJLgwGiYvIek17tliEm3Wvo6H7mNPPehj0pmWYqo5+d1/a6fP5iycXnw2uYFI7C8cfRcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkDfUGmM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkDfUGmM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818D01F00893;
	Wed, 10 Jun 2026 16:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781108991;
	bh=5/nSBTrYlMpqaFGOlGvnc3S2H5d2hvsraiqd4mLdn1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jkDfUGmMRPohuH5BFCDS3lPPo/TWjpJafkJJGu1SM1elHmJxgl230qOKm+MOLCopA
	 0S2ruRysgD3bHiWzIRN+tkL9HkiQR8ZG1/OcYhQr7V+I6BDiUO/9SGt73jc5t30LOO
	 KTRH7aQofypYMGV5g67/yn8K3ibGDkWd7SqpHR5DPpJcqHjFvE7J8ZBBOsPfZRVVNS
	 IZOW1gLQnqXvDV7M5EuCd3vYfRdCvz9uo6Ai70+F5eBYCt+WDM3iaIAgFCSjP6t0H/
	 wO2Wpww2IXTLqEEU1JmKN+E3vnPdsPlgMW4isgAQiZK8eKcH5x9suZP9AWt8AX8a1f
	 /FDXxFfx+R6eg==
Date: Wed, 10 Jun 2026 13:29:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 10/11] perf tools: Use scnprintf() in
 build_id__snprintf() and hwmon read_events()
Message-ID: <aimQ-pXYUnPBmeqy@x1>
References: <20260609010526.1998472-11-acme@kernel.org>
 <20260609011717.79A371F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609011717.79A371F00893@smtp.kernel.org>

On Tue, Jun 09, 2026 at 01:17:17AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] build_id__snprintf() fails to null-terminate the output buffer when bf_size is 1.
> - [Low] hwmon_pmu__describe_items() spins doing useless sysfs operations once the output buffer fills.
> --
> 
> commit 0f670823c7b8e81b469db29dc89cf4b4de7e4cad
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> perf tools: Use scnprintf() in build_id__snprintf() and hwmon read_events()
> 
> This commit switches build_id__snprintf() and hwmon_pmu__describe_items()
> to use scnprintf() instead of snprintf() to prevent out-of-bounds length
> tracking. It also modifies the loop guard in build_id__snprintf() to
> prevent useless zero-byte writes once the buffer is full.
> 
> > diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> > index 8c0a9ae932aa5..82af3dca7e2fb 100644
> > --- a/tools/perf/util/build-id.c
> > +++ b/tools/perf/util/build-id.c
> > @@ -93,8 +93,8 @@ int build_id__snprintf(const struct build_id *build_id, char *bf, size_t bf_size
> >  		return 0;
> >  	}
> >  
> > -	for (size_t i = 0; i < build_id->size && offs < bf_size; ++i)
> > -		offs += snprintf(bf + offs, bf_size - offs, "%02x", build_id->data[i]);
> > +	for (size_t i = 0; i < build_id->size && offs + 1 < bf_size; ++i)
> > +		offs += scnprintf(bf + offs, bf_size - offs, "%02x", build_id->data[i]);
> 
> [Severity: Medium]
> If bf_size is 1, does this new loop condition skip execution entirely?
> 
> If build_id->size > 0 and bf_size == 1, the offs + 1 < bf_size condition
> is false on the first iteration. Because scnprintf is never called, would
> bf[0] be left un-null-terminated?

Addressing this one in v5.
> 
> > +++ b/tools/perf/util/hwmon_pmu.c
> [ ... ]
> > @@ -442,12 +442,12 @@ static size_t hwmon_pmu__describe_items(struct hwmon_pmu *hwm, char *out_buf, si
> >  
> >  				buf[read_len] = '\0';
> >  				val = strtoll(buf, /*endptr=*/NULL, 10);
> > -				len += snprintf(out_buf + len, out_buf_len - len, "%s%s%s=%g%s",
> > -						len == 0 ? " " : ", ",
> > -						hwmon_item_strs[bit],
> > -						is_alarm ? "_alarm" : "",
> > -						(double)val / 1000.0,
> > -						hwmon_units[key.type]);
> > +				len += scnprintf(out_buf + len, out_buf_len - len, "%s%s%s=%g%s",
> > +						 len == 0 ? " " : ", ",
> > +						 hwmon_item_strs[bit],
> > +						 is_alarm ? "_alarm" : "",
> > +						 (double)val / 1000.0,
> > +						 hwmon_units[key.type]);
> >  			}
> >  			close(fd);
> >  		}
> 
> [Severity: Low]
> Does this loop also need an early break condition once the buffer fills?
 
> The commit message notes that build_id__snprintf() was updated to avoid
> spinning doing zero-byte writes once the buffer fills. 
 
> In hwmon_pmu__describe_items(), once len reaches out_buf_len - 1, scnprintf
> will return 0. Does this mean the loop continues for all remaining hardware
> monitor items, performing unnecessary sysfs file open, read, and close
> operations only to do a 0-byte scnprintf write?

I've added this to a cleanups TODO file for future work, nice
observation, the same pattern may happen in other places, worth a
series.

- Arnaldo
