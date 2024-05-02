Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FA022EF0
	for <linux-perf-users@vger.kernel.org>; Thu,  2 May 2024 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667693; cv=none; b=QKOXAfDSqB+DtOIbjVw9rjT2F+PtM8k8bipHwsEDH8HG1Vzw6zS3CCciYC3vC6UNHGsf4GP2uZHxoGjIHsDRGorKdX3gRZ9e2JgSs5dWCLd8tcumg4GzzJ+NHQ4zUTBHD4nFFFpw/autk6QDZ1Ymyzkoy4lU6+oBEUxVCwusqVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667693; c=relaxed/simple;
	bh=jrSH2V7P12JWwZ6nyVI64M5FJoPI6SANAXibqtFo+ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUEvnubxo/1aa+k1zTURKxKCnqhuqJTAm4A/dqp5MJ3EUOmUCQhJ1ruj+Y1X7IpbhzjEr9+IgD1FUh25lUQv0/GN6o10BAdaF7PF5aC6wQBZmvmVfNA9TUfiCVFmCiwu8FG65jTonhb9c+9tFRhYe05d7pRkTXonwrYHoIT04qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoCgW5c6; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoCgW5c6"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51f3a49ff7dso891270e87.2
        for <linux-perf-users@vger.kernel.org>; Thu, 02 May 2024 09:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714667690; x=1715272490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j69fnkw73Jj/8uwUv3zymb+61FtNr7hRBA50kByEZ3o=;
        b=OoCgW5c6o6qTNkVpjzUMXYADQKvN0as8XYKrtt2Sj6sfBQYdQs1guqu5UVBIuEIjcc
         JQcHiaTPnXdlzltVTPko9IAxwzdsJgJMsabXtmhWhig4RbswJ/BMVxa6kiLpY7/rMPJz
         z8yWFw+fk0wkLe6qkiDcF8McYVl0sDID7YlyVqLV2nxi4f8RjbFsVrDIjj88xHRC9htP
         VUMh7vYm17hR1J2oZzput1oIgNg2OOktUJf3XAA1xHgnobgwaoMHrfkVR5KBCIckJLIe
         yWFNJSBbJ/qUdn+cG1NUkXnE63h+TF7YmnFJFCAbZOJzntUubamapUeLbVlp/Vt3tfqE
         gTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714667690; x=1715272490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j69fnkw73Jj/8uwUv3zymb+61FtNr7hRBA50kByEZ3o=;
        b=jgjBwiI0Gxzh/cJ18XWGuklKIpsjU0uvFbtvTUMGZJpD9Y101dnMM72G8gSbzRO7r/
         73vKouC00o6V2pWen/KFpCy3Eb+hJp+MMR89KEqPoR0K9iOszuHFuxHSYFQ3bDVh3xSE
         HJlDP6XpXqYvD77YKD8iSTiB7NPfIxDK4ugkII63jbQ+pBdVa63bG2dXNbO441bqzIkG
         Hop7rZ979kB1YlZLrlOu69GI1MJxWBmCCNijFYxdBizUK+IBJ2OkZM87BGOsOHQfTwoU
         pBzgoGhwDcEI9l1BmqFmyvYknIs7Y9fUik3DW2BiYG6nPFCn8ZMEzZmvG2t0nPK6QtwV
         wgNQ==
X-Gm-Message-State: AOJu0Yw9B2XBI0ssEtYq0/SvlzIaYFYLSf3mIqFKaXGe0mL1GNca+0ms
	QIp91WwH7Q3GNIJ9OwxxwkchgTyCi2vLCO+OBbIb7Cc/2590JRI=
X-Google-Smtp-Source: AGHT+IGibzDkKJPOjL8Z/XgsxPgpKbTpmwdSUXHF5ZX5GT7/tY1cOmRTYbCm7lEwaIYaGeK/TvUBAA==
X-Received: by 2002:ac2:5e81:0:b0:51d:9ac6:568 with SMTP id b1-20020ac25e81000000b0051d9ac60568mr218870lfq.36.1714667689179;
        Thu, 02 May 2024 09:34:49 -0700 (PDT)
Received: from octinomon.home (182.179.147.147.dyn.plus.net. [147.147.179.182])
        by smtp.gmail.com with ESMTPSA id p20-20020a05600c469400b0041bc41287cesm2491285wmo.16.2024.05.02.09.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 09:34:48 -0700 (PDT)
Date: Thu, 2 May 2024 17:34:46 +0100
From: Jules Bashizi Irenge <jbi.octave@gmail.com>
To: David Laight <David.Laight@aculab.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf/x86/amd/power: Use div64_u64 onstead of do_div()
Message-ID: <ZjPApuDc0gL9Pchm@octinomon.home>
References: <Zi57-TMgU19puaQM@octinomon.home>
 <41180245c6e94a06b789cd44b8aebd62@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41180245c6e94a06b789cd44b8aebd62@AcuMS.aculab.com>

On Thu, May 02, 2024 at 04:25:58PM +0000, David Laight wrote:
> From: Jules Irenge <jbi.octave@gmail.com>
> > Sent: 28 April 2024 17:40
> > 
> > do_div() truncates a u64 divisor to 32 bit.
> > This can lead to non-zero being truncated to zero for division.
> > 
> > Fix coccinelle warning
> > WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead
> > 
> > Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> > ---
> >  arch/x86/events/amd/power.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/events/amd/power.c b/arch/x86/events/amd/power.c
> > index 37d5b380516e..ff003c1a645b 100644
> > --- a/arch/x86/events/amd/power.c
> > +++ b/arch/x86/events/amd/power.c
> > @@ -64,7 +64,7 @@ static void event_update(struct perf_event *event)
> >  	delta *= cpu_pwr_sample_ratio * 1000;
> >  	tdelta = new_ptsc - prev_ptsc;
> > 
> > -	do_div(delta, tdelta);
> > +	div64_u64(delta, tdelta);
> 
> Nak - you've not tested it.
> 
> 	David
> 
No, I later realised it's for 32bit here. It may be very expensive for
a 32bit.
I think I got it wrong here.

Thanks for reply.
Jules
