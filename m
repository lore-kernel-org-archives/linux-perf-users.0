Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4E031AF07;
	Wed, 10 Jun 2026 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781115136; cv=none; b=bIv6L35koaBj03S2A4B1DAaMNvNDjfHcZ1m9EsItD7t30wca3A1pyKFC1cShApiyRJRnYGuyEg2tgsPU4zRRETBWvfpHgSrIY6yH10KeSXoImfGajKPGnI5MYcz2vjZVZ8+19KIpcRm1AzSiWYDBM89D6qYL+EAPu8Gwzdsra04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781115136; c=relaxed/simple;
	bh=lQDdqxaaOQg3Un6brDdu15WtZczLHshM7hDywgUBRMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1VdykK2T5e8Z90JiZC5yuNwn6PJ8yOG6UFv3GZcR/JmfBu8zYuw0zgtbqQUcTF3DbFEhkz2W4GGSlvR2NRlFpdJDqBbERaSHMxlcLo9YH5AlIWgcc+bU/jU9/1nb9dvYmZ4AyjSDEyc1l7ZKwt2AqLKjtl9H6Bv3+f0LVBQEME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qlgfw5W9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qlgfw5W9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8110F1F00893;
	Wed, 10 Jun 2026 18:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781115135;
	bh=sRVVUio2ofSz9c4VQ7KleR5VpQtUJIpCMjMpTWAjjcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qlgfw5W99zxpa0fa8dm5AsIU2sczonb0XyznE1WgTPusWqVlb1sTfUywWZvMQhbn2
	 ksWhCLL6IqroOOuweHtV+YvHcVSnRUCD75xXM4rss+apynZZOTktCd75wXmK+NdoEL
	 klaM6v52opquVFu8z+gklQumorREPKJajitYG/dmJRtB52OWT7vc0hYW/w5/HqSC4x
	 zXu+8GaRjYaU45FYerzKELxVnREYXd5Eepo19t/Q0AyH2ia9P+Mkqbb/UOXqwZeYLD
	 xLNxGfSBLH3iiVQpRpML0KtzfP9hoEUTJ07N32hAvbtV9JQz7uwrPsbQSPbvhrZ4po
	 YA9S0I9bxNIQA==
Date: Wed, 10 Jun 2026 15:12:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 10/11] perf tools: Use scnprintf() in
 build_id__snprintf() and hwmon read_events()
Message-ID: <aimo-19X5W24ttaf@x1>
References: <20260610165207.2077258-11-acme@kernel.org>
 <20260610171727.6AD111F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260610171727.6AD111F00893@smtp.kernel.org>

On Wed, Jun 10, 2026 at 05:17:26PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Off-by-one stack buffer overflow when reading sysfs files without reserving space for the null terminator.
> --
> 
> commit e6063aeb686d4d547e9272a51fc950e7a84f13a8
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> perf tools: Use scnprintf() in build_id__snprintf() and hwmon read_events()
> 
> build_id__snprintf() and hwmon_pmu__read_events() accumulate formatted
> output via snprintf(), which returns the would-have-been-written count
> on truncation.
> 
> > diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
> > index fb3ffa8d32ad2..dbf6a71af47f9 100644
> > --- a/tools/perf/util/hwmon_pmu.c
> > +++ b/tools/perf/util/hwmon_pmu.c
> > @@ -442,12 +442,12 @@ static size_t hwmon_pmu__describe_items(struct hwmon_pmu *hwm, char *out_buf, si
> >  
> >  				buf[read_len] = '\0';
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but could this lead to an
> off-by-one stack buffer overflow?
> 
> Looking at hwmon_pmu__describe_items() in tools/perf/util/hwmon_pmu.c, we
> read up to sizeof(buf) bytes:
> 
>     ssize_t read_len = read(fd, buf, sizeof(buf));
> 
> If the sysfs file contains exactly the capacity of the buffer (64 bytes) and
> does not end with a newline, read_len will be 64.
> 
> When terminating the string here:
> 
>     buf[read_len] = '\0';

This is fixed in the following series, acting on your comments.

- Arnaldo
 
> Does this write a null byte exactly one byte past the end of the buf array?
> It appears similar patterns exist in hwmon_pmu__read_events() and
> evsel__hwmon_pmu_read() as well, where reading the full buffer size
> leads to an out-of-bounds null termination.
> 
> Should we reserve space for the null terminator by reading sizeof(buf) - 1
> instead?
> 
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
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260610165207.2077258-1-acme@kernel.org?part=10
