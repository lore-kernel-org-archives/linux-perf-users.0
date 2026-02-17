Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B53D2D97AA
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Feb 2026 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771316578; cv=none; b=bFYFKV46frNts2XSZGKw3AcYEU08AFWUKNqVJndQWYuNrX2KFRBkwoB7oKrMYqfY/XhoFiAiLiAxXb3E9cbd264oZKeAWP0+rregJ2Pe00SmYhP94ueqxNOayrcZ42QxV63YZIrhcbPaS9MyoJ7boOjnKLqdDk/x3+ExBrCC1Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771316578; c=relaxed/simple;
	bh=j9YvxgBnTjVJotxsZaz59b64frSQ5OWTlyiLqZ4fyTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLK1jeAYcJqAMcaA9gMLAvgB6DWaUQq7h32fu48GcJ3IYA6lMuzaF3E4a1NHxxmc1MYcGzIhuOnJZGusRWs2Os5LgVzN98C0oIbLUWgo+HMDDsGW17kmdsg05IxntoCyGt0ZdziTRG1VIXkudBLOvLKP0osiKzwOmTBBCmEHVXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iETzEx0F; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iETzEx0F"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8fa7e3672eso528185666b.2
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Feb 2026 00:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771316576; x=1771921376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j9YvxgBnTjVJotxsZaz59b64frSQ5OWTlyiLqZ4fyTQ=;
        b=iETzEx0FcOsuVVzz8mVK1eDqkUxZyB5ytUJQuyQkplTJGVpUvyiLbQax0p9Tsbz7I5
         tywFAq2G2Jd9jaRPBvV+ipvpOkJxput82HpEV8dL0W2I6i+Z5SirXDHvhktQaWx6UYGW
         vVtTLqU9BmYTFlBGgRHcZyJXpTJ59Ei3M/CinQLa5ZU1X9vDpIgk6TLMOPxOac+abEAP
         5TECHq8jV/lCTGvxok3M5HesgJjLA7qqJHGInD5CQYz9pQY9OA+LQdQsSlQurioN59i9
         QH/LDeViMKabCHiy3p41867iBoVlX0zzicaSnDi7nc6YDp5902yggszVMR1hYUNPiBhN
         M1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771316576; x=1771921376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9YvxgBnTjVJotxsZaz59b64frSQ5OWTlyiLqZ4fyTQ=;
        b=I2+HEDM21J6hTdFEBrRE1RVLwtDyp4Q9wK41tRLTo0VNHr24tj+nGUFZUPGww4Nb10
         3Gg96SsDy09vQNwwQToojVZti5ygdWjPnNLbJx8h0eeyAETvE6ToMSDCGqXGdslFC7sY
         my8wObFaif+CyqDMo1Y9FE6zgAioJT5au2Y8uJtN5IjrP2zzFDjfCfw9eUTawdGDwXgX
         ZNd6eGalgXIFv2aTAtVLXO7e0maydLeUXxB+7bEh5jg1Kbi5v6leIZXADnnaQn6gSB6w
         h20Oq42ulwDE+ahp3GcY8BhptT2prVG0j8SGFl5rXMiKtBpHtC9Cfjbw+UPodp0ywtzQ
         3xbg==
X-Gm-Message-State: AOJu0YxrM8QwqIpBQb8I5H4BF9NMRAqAbO9Jh6Pxk2eisa2OanFC35PB
	f0Nv1EazGsZMyTpsbq3YNAPVEI9OVjfmGkb3EQ+6R8D60prJZplPhYP0z6zw3A==
X-Gm-Gg: AZuq6aJflxNjMslnHMsZjbTUn+FH4LBph+e3WsKd0Cj8FhwfOjqRvfooFhz4PcSsB41
	zhpO2nuDxfuj3zWE9QR2t9an333mmL1AZzvkxHgSj6qztbBUZhUEK2Pqh0zeVFItGHRZytCIJpK
	B8MqOM5R+P1PWGr6nxzDjczcz0zouXAlUIPRxhFwIUjoq015Bjz2s4g/znDtIBgny+sGdNfmC6E
	n1kutnyqn6+mbb0frLDiIm2lQbKF7NFF5aRaTv3AKNxfkEoI1gdbqzMBZtTfGtjh6xHJkspIyDa
	FAzysVXxnpWO0njvuDrgG32UX1T4KC8IY3GuSSpDpsWCskWpNHBpwwdNntLZ2jnPYe19rAQ4AG2
	wyNwrQiI6fb+e9/VVY/XpVZixjxx3BQiDbPXqu3ezPvQJSSikij/Bkn3YQ/tqNP3nCZncn5kY83
	zdAM/dv8E75dYpzA3T+osGCEudMfuileuycL2e1fJYQaHVDwHJVC54Nv48NuwLwWq7zcrxiDS3I
	IRpd+LzZEzuqe4oZKqp4aawExE4ra7T5s5X
X-Received: by 2002:a17:907:7fa4:b0:b88:241e:693c with SMTP id a640c23a62f3a-b8fc3c7fa23mr672213466b.31.1771316575433;
        Tue, 17 Feb 2026 00:22:55 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb (dslb-002-207-075-089.002.207.pools.vodafone-ip.de. [2.207.75.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7385d80sm325883366b.16.2026.02.17.00.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 00:22:54 -0800 (PST)
Date: Tue, 17 Feb 2026 09:22:52 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Subject: Re: [PATCH v1] tools build: Fix rust cross compilation
Message-ID: <nebqi6txwrsgztbsx5g7npptbsoyocbn6r2ebmzmwtigt2z27w@nh2xbmk3bp2e>
References: <20260213191212.33328-1-9erthalion6@gmail.com>
 <CANiq72n3FPOBVbR83-Vp6uetu8RnazMuu6MhzG_hA=_j18_BTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72n3FPOBVbR83-Vp6uetu8RnazMuu6MhzG_hA=_j18_BTA@mail.gmail.com>

> On Mon, Feb 16, 2026 at 09:41:34PM +0100, Miguel Ojeda wrote:
> I think this was meant to v2.

Yep, I forgot to change the version (it was a bad idea to send it out
Friday evenig).

> By the way, should this have a Fixes: tag? i.e. since it sounds like
> this fixes an issue. Perhaps to 6a32fa5ccd33 ("tools build: Add a
> feature test for rust compiler"), or something else? I also usually
> recommend showing the error message in the commit message.

Right, I can add an example what happens.

> (Also, you can use "Link: ... [1]" for the link.)

Got it, thanks!
