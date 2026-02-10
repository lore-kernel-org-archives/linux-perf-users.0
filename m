Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870A032A3FF
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770754584; cv=none; b=J5Ztb6cKFZ8mdhYuox33CSoOhcXrtJoUK5/jvGgD8D5nVmsePzh/UeNHQ4e3KGpj+gj0qXdsrSM2NdfFcGsHt6ly+QCDNdKce4zSOQAnrFUP2G/91DJfe6kTZDx4umdnh3bHY9GCgX6ITYElEUAQ73glyMkSolDNBjHQ5AfSQNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770754584; c=relaxed/simple;
	bh=aMz+Y2yLyV69NmE1eKUO3h7B/jczlOEB9AVLaP8DC4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kW53yFLK+UMgFl8GN+Ru8oTnzOG3YTxL/rTCXmJrWpIPqJXl6Pfeihb+A61qzqx0rMCuyjCGj2BZ0ojEPEiZLS0oUlQBGohq3RyHZdlbeut/NLxyhlyETkeVFfrgLJJNVFSqOpm6H2egFUR9fEnzcKAZuYJEi6QYZm03oHmG1P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbJuqK4Q; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbJuqK4Q"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b885a18f620so927165566b.3
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 12:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770754582; x=1771359382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M6P59CP8cqGfdvtYAmvy5rzhRCmi4qyR5mguURTlI7U=;
        b=dbJuqK4Q0pk3yQDK3m8+bQPf1ZGGQGbDcXUDfBgGHn+y1k3J3lnXv+jRLJw1QJp+WP
         eLy6/GvpS9kPvBJC7+OpRc7wAsmmI67qocVWookNkW8Dzl7WcbyRLcWxzN2nA8t+qg1O
         1lCiH6J88TfHARm3RNZSBzDSbVW0Rmq81DRH1TzVKT9Lxt7qQr3RR1XWLLhqse6tfBQ5
         Tzxp6pqnLPUW4snYqkzDJJ4+jlBdSINjGDjzZytbolOxtc5fzXqiDvT7vqJYCPBEgudY
         Rp99ZD4LtpmbD6OrUpKZawSz1b5pyPg9OM3fAQTq1w652CPTs7JtSENEeUfsvCiYKoEZ
         3LEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770754582; x=1771359382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6P59CP8cqGfdvtYAmvy5rzhRCmi4qyR5mguURTlI7U=;
        b=DWnOS5hW5k2kcPede0zelK06CSQilw25pmvjd5Fwu9bjz30SrsuyYQvDNw98CqvOPe
         MlnGG8K6q9UqLyvSELldLU87ikr0AFPh8l2rN93cCZ0wpuFtqpMl9IERCZb+ghun5+st
         k7GSplE3YG3z+/Yq/bpeqhXRT+qXxC+iXEnmHWgN+SWjHkfcjtXgxLjgFvXN34/Pqvvc
         ArDQMYKXei5CqNhn+peSLKoDoFuduKpim/Jz90/ATmPF3NypUnV1jMfBAzec3p1qzxK5
         yFQUZze2gSQ9C7y2u8J6e3j5OtPJeEED/ErQ/1gSQcll7bAm4gV6D/laUwwXJdrgP0Dg
         QSJA==
X-Forwarded-Encrypted: i=1; AJvYcCW6B4mr04kxGqcvqAaBtyFscS4dDBL3kxIcFkUuGnHJGYKV+7pYFuDbxYhiZztVMIioOl6kQhQei2xxgcAi8uID@vger.kernel.org
X-Gm-Message-State: AOJu0YzoAOCMTZcs3u65J4VC9p2wY1KUrF6FDFIZF6s2jiS5YjwEv9Gm
	Hr7Ci9J4mSNntMGVwCPItDRMbu95p+nc5Lmn9qBl+oINMIzzdG8Zs+ZV
X-Gm-Gg: AZuq6aJmn+pXYLbtQ2bmeSM+eDns30lI384/PM/jaadoY+NctE3VV5213U/Vb9BR9vt
	pprscuWTUiYrhk68szigX+tMW15JFdbhGNYoeoxxnYwoH0DTKdilgFMA4oJWUDET+zCKW5eMc4b
	bJuxqPKF0QE3A+G9dgaFIX3ehJzNNKpmv49UZwGEaQDtFCFZVfZbNYpFz65BMCxbzL88Gvk/vU9
	aRyENlSiCzmOjmteVBn5mM5H4wi2GWsvKWrK17EaeZ138FVOCM0PFrh2FwdquvTqJjG9Ib3R5+N
	Df3yHzhb4je2sstcm9h5IdO+mxOvzRFdesPrMgwR6hw9hXb4fl4d4hq2EQANqAti4hY4Phu+trC
	AHS3znuEv6JUBeSNP3r3SAIUOf/LGLHPw4PPKiJ/SU6Yj7QTLRQJx2El4WBKKUlM/2AA+Ifsmtg
	IwAliiPjiM7Z5wHmJB3eXtL1N7/2kJowObV4JfG5LXHto0JaWcwaBFFuMrCRDs/6dbradMD7OY8
	ZWbFfDv8BU9O6quabfeLuSFVUZ9AtebDE3q
X-Received: by 2002:a17:907:fdc1:b0:b75:7b39:88bc with SMTP id a640c23a62f3a-b8f546a3a03mr228745866b.58.1770754581616;
        Tue, 10 Feb 2026 12:16:21 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb (dslb-002-207-075-089.002.207.pools.vodafone-ip.de. [2.207.75.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8eda7e6577sm542779566b.30.2026.02.10.12.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 12:16:20 -0800 (PST)
Date: Tue, 10 Feb 2026 21:16:18 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] tools build: Fix rust feature detection
Message-ID: <hox364wgs57bv7hvscvvtbkl5yerur55iz7un3gsu3ozpbnba5@haqvngx6jy4n>
References: <aYoZD1onJLsnlrV3@x1>
 <sc2w3tcjcle4zhz72b2jdnyfnhzl6atiecium2dwcmrlvn6syb@n573cdtyldne>
 <aYsj7vV2Lh8wV-ZR@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYsj7vV2Lh8wV-ZR@x1>

> On Tue, Feb 10, 2026 at 09:26:22AM -0300, Arnaldo Carvalho de Melo wrote:
> I tried here building it with rust installed, it detected, ok, then I
> removed and tried to rebuild, it still thinks rust is there:
> 
> [...]
>
> I.e. it doesn't rebuild perf and thus doesn't notice that it doesn't
> have what is needed, if I touch some other file and thus it triggers a
> rebuild, it still manages to build it...

Yeah, looks like the problem is due to rust not adding any actual depedencies
into the dep-info file, when compiling the feature test file:

	/perf/feature/test-rust.d: test-rust.rs

	/perf/feature/test-rust.bin: test-rust.rs

	test-rust.rs:

To fix that I've tried to add an extra dependency on the rust binary on top of
that after the compilation is finished. While hacky, it worked just fine, and
perf catched it when rust was removed. Haven't faced any issues after few
rounds of installing/removing rust either. If this approach sound fine, I can
post the patch tomorrow.
