Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC9F27466
	for <linux-perf-users@vger.kernel.org>; Sun, 27 Oct 2024 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730049887; cv=none; b=o4xqKDx4oSRrckfHVnTqTUYp1CyY4RE6Tig2Kg0kBCYno87W23mlLTE5NYwqPpF2CeoHKPo4ZZEaKHDTu+MqX7o45BbDIJ0cqv336TlnU7OStkYgwroiulXcOLu4DeD34CtFukJ6FOYqJM8aihQZJlZdq0rQs2n65DtFpLSw7fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730049887; c=relaxed/simple;
	bh=zhVGBVUvdv5n44mB2wEPT5OL2UEmLnnvAOHar/u2w1c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWjFKUpagihqejHMKa4Z0uTzjIRkGMzalDMGLG7XcKuM7W6RKBKoQ2qwYvL0KG+zTompJZ0OHGbh95Nm2X4eT8m69z6vL3ZsT7i4WpA9Ufb1qwYaIRoRIyHlzEyRYQhwNxtpVhCEJ3ILj2KvBHFaeOAabeLQ6wE5/5S0YryBdQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYUxIMk+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYUxIMk+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730049884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oKr50uLSi3qbyn6NnQwGUQ1OqmR3FtuQutM4PWASyVU=;
	b=bYUxIMk+R2gf9SI3IBYzA+baZRGk37NEvsIn/mgOVvk67p8g4PPwARPzray7jKQiJF9zOu
	41nQyzj+LWAiP+tY47TD10CdQh2kr8pLDRiCZyDH0c80p66N8fm7IyKPI2S5oxqIQkR3K5
	iG3cWOXMOryifcCW2IJmTt2MQhb9xuY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-m-wiLxF3OkWjr2qEmipN7A-1; Sun, 27 Oct 2024 13:24:36 -0400
X-MC-Unique: m-wiLxF3OkWjr2qEmipN7A-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e2eba0efc6so3636456a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Oct 2024 10:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730049875; x=1730654675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKr50uLSi3qbyn6NnQwGUQ1OqmR3FtuQutM4PWASyVU=;
        b=JMuaLP/WPWm92ps/uxEgyL6LvFeK7rwMlNS0+0X/1h+y+qUlGjhyzr7fj1RzFcV/Ad
         S8KE7DQD5c5fq/htx274SRezzqA0FmZFUF96wy8zyGOrO/QYKE8W4Bek8nfkZxN09Cl5
         PLIsQEFZHfwOJW9qZJ67xK8Mw6zP9vi48jKjzd2vu9DIhbhW5Tw9/FFsvWSbA3s7St/l
         N9/Fh6J+LBDG4p7UlVgO+c0erIjixcscNluLgD8V6EP+Bx5CZSvBm3N9WGtFimk13LDZ
         4P5O6J5IBi/cTm8lO0HBCDpcR5wMpTP5w9ZVfS7S0uQ2tnaW6OIsCnbzP0DNvEMFoZkE
         1cOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnFRhdGbjGwrOX52WcIkTS/0aGBP7ikkwBy0Asv9lSyPWBloTMpu7k2ShzPZBnx3l1MkPdGph8hdZGM6On7oFp@vger.kernel.org
X-Gm-Message-State: AOJu0YwEO7EIpwOhQzjpLe1uCpCtGoyXRnigjidgCLrDsZ5R9bGji1ke
	aW25PqJ7fDTTS/vIPJekViqX4bXx/erYMkvQhwYe9iEUJd1cJ1elsZMfwdJpqak55i/86V7+CzP
	qLwSDpwTb0hwEbiJdSdDydsGQzZVNe76k7cuE/g7/rGpUzzY/U5PjOeVEpzrkzouogss=
X-Received: by 2002:a17:90b:1d89:b0:2d8:3fe8:a195 with SMTP id 98e67ed59e1d1-2e8f0f53d9dmr7801781a91.4.1730049874825;
        Sun, 27 Oct 2024 10:24:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe+3d9HBdJOxMCmo51cWugL7SDRTWmCgDMsRin/SjlPT/YU/GdVOSAVPjeVeYYGsQojJUnHQ==
X-Received: by 2002:a17:90b:1d89:b0:2d8:3fe8:a195 with SMTP id 98e67ed59e1d1-2e8f0f53d9dmr7801761a91.4.1730049874473;
        Sun, 27 Oct 2024 10:24:34 -0700 (PDT)
Received: from treble.attlocal.net ([2600:1700:6e32:6c00::3e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e56f468sm7388597a91.41.2024.10.27.10.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 10:24:33 -0700 (PDT)
From: Josh Poimboeuf <jpoimboe@redhat.com>
X-Google-Original-From: Josh Poimboeuf <jpoimboe@kernel.org>
Date: Sun, 27 Oct 2024 10:24:30 -0700
To: Jens Remus <jremus@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, x86@kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2 00/11] unwind, perf: sframe user space unwinding,
 deferred perf callchains
Message-ID: <20241027172430.h6xvamrauxmwccx7@treble.attlocal.net>
References: <cover.1726268190.git.jpoimboe@kernel.org>
 <a5c67047-94d9-482b-892b-ef1662d2fe65@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a5c67047-94d9-482b-892b-ef1662d2fe65@linux.ibm.com>

On Wed, Oct 23, 2024 at 03:22:35PM +0200, Jens Remus wrote:
> We are looking forward to implement support for unwinding of user space
> using SFrame in kernel/perf on s390. One major concern is that your x86
> implementation currently relies on a fallback to unwinding using frame
> pointer. On s390 unwinding using frame pointer is unsupported, because
> of lack of proper s390x ABI [1] specification and compiler support. In
> theory there would be a s390-specific alternative of unwinding using
> backchain (compiler option -mbackchain), but this has limitations and
> there is currently no distribution where user space is built with
> backchain.
> 
> How much of an issue would it be if s390 could not provide an unwinding
> fallback implementation? Do you see the possibility to get away without?

No problem, I'll make the fallback dependent on CONFIG_HAVE_UNWIND_USER_FP.

> For s390 support of unwinding using SFrame we would need to make a few
> changes to your generic unwinding framework in the kernel:

Also no problem, I'm sure there will need to be tweaks going forward.

Thanks for looking at it!  v3 will be posted soon.

-- 
Josh

