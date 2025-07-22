Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD0F1E5B69;
	Tue, 22 Jul 2025 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200578; cv=none; b=YuL1Tt0JCZtFVpQ+CAYBCLFYcQwaM4nxq/KDwW9C53don4FkillKN5imnuAoeYhmOhQ6aT+JvkEPQSzqEKOkE6k/OlChml4yVRO9jqWkhUMK3Dc321c2Weq1pZ5keqp751yuz05ROaDeUi9rTHMV4A3F2bM6WjNtCpgJnhywjbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200578; c=relaxed/simple;
	bh=Xpmb9ROCj6DTOjSlYvPf5fHme0meNeJxpaM7AWv30SA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kj7rC4V2+RInR05MXt1OEJZ/JP6N1jrekXn7S0CoxR2hLjOotELxh+JRFcxQjUN2ATAHouO+MrESvSrmLJ8I1BNALQVQjWBkaQOXykqCKGw+ZPngGQqNtlmSNrbhtA+tx1xOeT742oSfLfPyk7sWd2mIgJqt1zgEnKyWWxZVjSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPCP24w6; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPCP24w6"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-301fb587dfeso1747193fac.3;
        Tue, 22 Jul 2025 09:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753200574; x=1753805374; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xpmb9ROCj6DTOjSlYvPf5fHme0meNeJxpaM7AWv30SA=;
        b=OPCP24w6O47dhJ0ysNSceUi4+Ztj6GLePSqBT8I8omYKZFgEE/aiOqhvo4hW20ISag
         ywD+LsMwAjc9gC+qVo8jnFWGgb5awiHCOZktTPydIS4AmTcp5w1MPcxwCPgrV/o5+KtD
         A8fnMTSDRzvr148sHUF8o/iRvNewLOAM9DZR5DMTPNzHwBpP+rbKYJbGgrO7gSfFjweT
         9rauQZaS0/Sk7m2dLQ/eCnjYs2VBn9UXSJUt6TDxcUJCdhT/GX32tf/YqAQzE8PsFMUR
         Lu0ic+jq0GDnpiSrkIt+tZ8lfeqGzndnVF8lUoWrrQrmZW51EkUYr1cdUWGlQvV74UwJ
         RZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753200574; x=1753805374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xpmb9ROCj6DTOjSlYvPf5fHme0meNeJxpaM7AWv30SA=;
        b=qr7a6QTRd/p53e1HkccD9a2ZeZu404ScsU+w99GRL9kuBRj4By7Kqt4lNsZgMu3bNm
         S5QX+TTL8g1AalVEfIJZDGLkLs3K2NXRbdsWGEgab3MU3Z4/he0+ZEVfUCy9xm0ammmt
         h537is1nQUtw9EUaZFQ5YJLEjTMsfZwTgTjVsSsJFHtfjsIzHN1hQwVue3uIZFPZBHM2
         xjFSqDlg6EV47qvcx0hWUtB/0znOvhFeLMoBNj8lAH984g+KQ7NyK/Ri4vShh4lZbljl
         xyTPrXFSs/LuwnQ/MZPq5t22LDYyV6zpC5oveDyRAluqjLAzkMANaUEirgx1+4gs/a2q
         3Chg==
X-Forwarded-Encrypted: i=1; AJvYcCVdDIkHtO+oq4mucD6RZE1xGvLJLBC3MfEbM3yrGM3oJniove7jE6TZ+SArLB9sLYgjQJr3a0afYq8VUAE=@vger.kernel.org, AJvYcCW8kDkiEyt7+gKp9A5L1DgnILlpt6e2cmCBgOPoiFzQYMvkEns1WhSAvNNR/bTAPYsNLay48CaB2zqWwD/6mNq5MA==@vger.kernel.org
X-Gm-Message-State: AOJu0YylZhih5QbRJzuoYqn8/v8GMcxhMoMGuEYJ6EZ7mXjKW9buoleN
	5ndhDotuw5F+R6E6tD+k8ZDMjYcMbLTTjtLNwgI5C3585ku1C+Z1f5V4QzQkGoFECD1xjJQ2Nyd
	hEM9a8xtcScNBSdt6NYQDcbcVpWVTW2M=
X-Gm-Gg: ASbGncsPXNjehnNoISvNmHCXZPnUdxOuU4Cv+INLza+w5lS9MA9duGbqrEgadWhA21W
	nCbOoO1KicIu5PJwikkyE7fgKSrw5B7bN7BCgPzEqLs9DzfTfgQzalIxca4RLBcrCDf8hCUsr4U
	Ey+c1elR8zBAzgy0sGk5GHJ5sj3uqIrU7Nl+3eJVLiy15zbEzp1h3MephdogkJVx9/6Axuj2orI
	PrZp5uBbmTdv6biWYc=
X-Google-Smtp-Source: AGHT+IEXX/MQb/klW4ioYjUPOHqvEZfTQrL6aML2ZjUm/97x2I8ijv8xRL9h1/TGGJ/ff8ffSELXChSXtnh1LZ1mDhg=
X-Received: by 2002:a05:6871:7c18:b0:2c2:3e24:9b54 with SMTP id
 586e51a60fabf-2ffb225ee4amr17171057fac.11.1753200574415; Tue, 22 Jul 2025
 09:09:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713151224.43764-1-suchitkarunakaran@gmail.com> <aHqMXz9KOpRuQNcj@google.com>
In-Reply-To: <aHqMXz9KOpRuQNcj@google.com>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Tue, 22 Jul 2025 21:39:23 +0530
X-Gm-Features: Ac12FXwUW2MtBwIhN0nWiSCW6-jxhnHHxg_7CDT_NF88DxEnFMN-yrxdBTqYNmA
Message-ID: <CAO9wTFgR6HPe28eVhXm7_CPPdiQqD-E3qarFu5xV3wg5E+Eh2g@mail.gmail.com>
Subject: Re: [PATCH v2] perf stat: Fix JSON output formatting in iostat_prefix()
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Jul 2025 at 23:33, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Sun, Jul 13, 2025 at 08:42:24PM +0530, Suchit Karunakaran wrote:
> > The iostat_prefix() function previously included a TODO noting that its output
> > format was incorrect in JSON mode. This patch corrects that by conditionally
> > formatting the prefix string based on the output mode specified in
> > perf_stat_config. Note, I didn't test it since my system doesn't support
> > it.
>
> Can any Intel folks verify this with combination of various options
> like -x/-j, -I and --metric-only?
>
> Thanks,
> Namhyung
>

Just following up on this patch to see if anyone had a chance to test it. Thanks
