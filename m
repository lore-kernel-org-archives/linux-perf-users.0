Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B2A1A38F9
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769177002; cv=none; b=CK+A2rCsYjPRpE0MLawfF/1gJi1JOSm9gtaJlTNAyN1eMI7zJfzG5lgs5q/C+vefha1eyUIqlyVHV8jjyNKzSMdZWN4LmaC2nP8g945JYHhaebXyYQLRjhtVT5TZJhIbgPJQiLlHJMrBljZeMM7u6cAezQxtFzqYoSgpehIazT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769177002; c=relaxed/simple;
	bh=NQCeoHQjMPAF3JY+lHnBjng/gItcqZenN+9wm7CI+JE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gn0y5D0D51XfTMuI/KKmUmRuuJYhe6VTy2Z6rMk0vSwdBW+QSb8oYyOPBWVwegsx4EtEBE9vFydbKsdHA4ND4OI247fk01j5Wh1Ts4RQnOOsyduHASLFMlf6LDPDQxTeJRAKEDBxZX/xm2ZcFe5S738CmhpowCgqXGVKPL10ajs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ME45Km4W; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME45Km4W"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43591b55727so2041069f8f.3
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 06:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769176999; x=1769781799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eflxrySSouHFZK8Z+UVBaTlYFEPw4EIIlMLqk/MN/DQ=;
        b=ME45Km4WghgS8PIe3yv0+X+Zod73n18blTMe6y/hPilAYUGcPjZhR3mjGaxHcfHhPp
         LUrzCqNxdr7BfolGghq1h+0/lxgDxXWrdJ3GiQVKtGPKksMW3dMpdOnQAf0H5JJO28+Z
         lwiUV9vpsG7alRZ3BH6ZwjddzOeAUvb5/ZCAUXg6GMCaFgj3CXJLBy6Y1md9iSWbqG6z
         4zKt4xL5Vdpfvh7OjarkgaOiFJzj+0FKC5PI9u8nDF8SvarzMIARixUeeROg4+v7OgRJ
         g+lypIYrI+LC1un1dKwyUsVxFgMcPXrS6Y5JpC7Cg+/fy4t8EEHto34UFlMdkrOQTn33
         9ekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769176999; x=1769781799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eflxrySSouHFZK8Z+UVBaTlYFEPw4EIIlMLqk/MN/DQ=;
        b=mZf6FSa18+wfNTb4IG1TFGS+0a0qsq1IPLiBXzRMVAMXFjhpT0WeAqFLx3DwUwSjo0
         8cvfaFJpB67D9JWcyN0I0mzIBB2VX1n2nA1lpSt8/DORNVzpOMTAT73SXvDcBwaBNrP3
         rHujNYc7REJcsta/WxFYpEwWEIeNa89oc1IJmBQPKhqnUgY5bEobtuQAnFHIup/p9PEh
         V6UEPwqjCgLklUlIj0iLxrDeUzAwomnEzptLr36nx41CTdNx+dpdeCa4V5RvE3/AJyip
         6jBo9J42m/17R0x6OyDhvlUWAzQOLttLk14bwopaX8Glk1E1L1RmS6DdJayueAwST3Kb
         ooyw==
X-Forwarded-Encrypted: i=1; AJvYcCV/b/WPd7/UEfbPJrCq3ED1f8XK9wyWHYgEAvU9HHDum9/r0ZJ9uGy4DmheTiUj4QBtsOm9NMlmNvAgjuoDKMbd@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw6kVwSdV4/QGa3cunesSVkyXZTvlheMn1THCeoAJO3aH9DGQx
	1GQYlwgfzlcwOvFzLgkTgTaV67T77XvBdp9hY4wkWFF62I+AtLgGMrvE
X-Gm-Gg: AZuq6aJ16KPA6vMEjP3Y+pRzuSDaZ3b5fu/mto310Ll3PH0kQrds42I1spPsljzhbQd
	VBohv7V/DaQepq1i8bMm2BTl41NW1q+gunGnMzWClzw2g6vh+OzfFBRfL6QxQESWIC1MXOfEVVv
	jsZncA8Li1urRrC7vd8832yGxHxI2ugbZ6OiZNaY8IwSOihKOmtR+QJBBLEdrF0IuRADcpyiXfj
	BjaivNNvOWWkapdQ+t34Q5rPXRg1/4yGRiZxjRCjkdUTxteWF6QFDqh5zurdA/fUWIlvCLvxvCg
	y/rzX1zXF7La8MnT5B8bVeyICQgP3x98Fu4m1SxZKCvIb95JfuXxAgR4BzBuumcm4BVRHTpqLiH
	c+H1DYwF1JFcoO969O94BL84qI3PrBLqiLCXmQykn17FZ7FTJ89oqfgIPvrHzu/jRjJYjCxaRn4
	fRrF+/3S2Y+87+XYwCiSXok7wqMVlcyVWSfclAzmZZOyGDfvwqFUPf
X-Received: by 2002:a05:600c:548d:b0:47e:e78a:c832 with SMTP id 5b1f17b1804b1-4804c9cf942mr48475245e9.37.1769176998771;
        Fri, 23 Jan 2026 06:03:18 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24ac1sm6823141f8f.14.2026.01.23.06.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 06:03:18 -0800 (PST)
Date: Fri, 23 Jan 2026 14:03:17 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Leo Yan <leo.yan@arm.com>
Cc: James Clark <james.clark@linaro.org>, Thomas Voegtle <tv@lio96.de>,
 stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>, Greg KH
 <gregkh@linuxfoundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf arm_spe: Fix bitfield dependency failure
Message-ID: <20260123140317.4bd85cdb@pumpkin>
In-Reply-To: <20260123120847.GB40455@e132581.arm.com>
References: <20260123100218.233246-1-leo.yan@arm.com>
	<705c0889-ffb6-4758-941c-ccfdb367d9c8@linaro.org>
	<20260123120847.GB40455@e132581.arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jan 2026 12:08:47 +0000
Leo Yan <leo.yan@arm.com> wrote:

> On Fri, Jan 23, 2026 at 10:27:42AM +0000, James Clark wrote:
> 
> [...]
> 
> > > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > > index adf4cde320aa..8d16619cd098 100644
> > > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > > @@ -7,6 +7,7 @@
> > >   #ifndef INCLUDE__ARM_SPE_PKT_DECODER_H__
> > >   #define INCLUDE__ARM_SPE_PKT_DECODER_H__
> > > +#include <linux/kernel.h>
> > >   #include <linux/bitfield.h>  
> > 
> > This isn't the first time I've seen this issue. Isn't the real fix to
> > include kernel.h in bitfield.h if it depends on it?  
> 
> Good point!
> 
> bitfield.h is a common header so I did not change it.  I digged a bit
> and found diverage between kernel's bitfield.h and tool's bitfield.h.
> 
> 1) The kernel's bitfield.h includes asm/byteorder.h, and finally it
>    includes linux/byteorder/generic.h, cpu_to_le{16|32|64} are defined
>    in this file.
> 
> 2) The tool's bitfield.h will includes asm/byteorder.h, but this hooks
>    to the headers provided by the toolchain.  cpu_to_le{16|32|64} are
>    not C lib API, they are defined in tool's kernel.h.

Perhaps cpu_to_le16() and friends should be defined in the tools
asm/byteorder.h rather than its kernel.h.

	David

> 
>    As a result, we need to include kernel.h for perf build.
> 
> As you said, we can include kernel.h in bitfield.h, I will respin and
> send a new series.
> 
> > Usually you shouldn't
> > have to know what all the dependencies of a header are when you include it.
> > Or is there a reason it wasn't done that way in the first place? Maybe this
> > has been discussed before?  
> 
> This issue is for tools only, and only Arm modules in perf folder use
> this header, I don't expect this is widely spread issue.
> 
> Thanks,
> Leo
> 

