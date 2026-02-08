Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840B9215F5C
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Feb 2026 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770553472; cv=none; b=JxCZZkkkPYooLUj6On7epfc2zctYl+HI2O440ejE+AcmdBWSj43E2pDZ3tUi6IQUA20xgwrc+URT3SzHpXdIzKVnK6J3MW1EaDO07vrlgbyAbdUsAvfw4TSRQOUTXtNumAKICSKYOb5VTHsFJSjTgwazPSX5kapp0MnVhIZN0jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770553472; c=relaxed/simple;
	bh=qK8oPxF5DZgb44N5Jdgxeu96w96j9ASmKN0zvtmsV2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bk7khYzbPGjBHd3FuxBPs1BMw3vM1NwfzlC4uslDSSsFUIpZQz5zudG8LfgY1n0n0VhlYD6AuymGNXuoDISVHymuRV5U7TzzKdDyQ2tOUZrzbkJ3occ0vknc5Ctqx9zZHl3DcmyPiqjdZgsjQEIXjyqxcQmYC+cT6H0Y9MfaciU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBr6nqVV; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBr6nqVV"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b885e8c6700so607781166b.0
        for <linux-perf-users@vger.kernel.org>; Sun, 08 Feb 2026 04:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770553471; x=1771158271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LGu8LCK4A2gMp8pD8OCZgLNtI3jXYnH9Iv5mV7DcTVA=;
        b=dBr6nqVVL4uY3E0YwyAcEhgVX2KpeU5HKnqPIqPsNowx20RlgSMHTTLAjS2YJNTQ7w
         9etUk65l8UuX8a2Z33qajbSG6P2AxP6SmK+5Zj99gb0I7r/eHhXVw4rdxhYNhKFSoFSX
         JkPcrqAx7ycblFshvq422INUNfF/NWxs76S0unI8KwdR9eBPpOYwflVaUhhZ7CHH8Tml
         4BgCufm587ZbgtXhOpuAfph7KvBcfqYIwswO77m0e5r94CwrzRdctBENfPV4bGTDOUUD
         mQ1zJcKh5PiZxU4lIDkzvt3ZOksQTKc8FRca9LPuINIPM6sk/wUAoB3Rf4GmHqp1CVKy
         pQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770553471; x=1771158271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGu8LCK4A2gMp8pD8OCZgLNtI3jXYnH9Iv5mV7DcTVA=;
        b=RgGmpAGQW1y7IdhuS2nev0k+WuNcL2gcKqGN5OJ4FB9c+dj8JGDC3QZcAyPaO0aTEe
         IOnWARcFsMoAPI5Iq6jocdKfGsiBGvB/kfjD5GLF9Onvw5p/a4xtq2MDniWOFNd9qCez
         4i6rxbPbG9ridXg/XivVP/gYUHakMjfRBV9TWQvMkvlEc94ndQn0fV+PpJNzX4V+1bC+
         UOTDFV649uRijv2Xp3BymekUurED4qZxvKYE6l2xZumO4bZNiCZiiOYZr/DO2QnLRFSU
         eWMj+RIrMVUcOrOdijgmi+ZvwOGVuzu1STEnPG5WBxBxeeP6OgCWxcnl961VVWJl8IH8
         j1RA==
X-Forwarded-Encrypted: i=1; AJvYcCUTVSHKuQ+UyE3Qj9EC0t3KJRUOG9uNPrK6MqFTOSctS29ac3mrnbvzr6vEyxKyCtkI1neQ4sXaUU/dv98OtTbr@vger.kernel.org
X-Gm-Message-State: AOJu0YyjgRnR5T1o1L7Yt0Qeqmb4xTE8YYSgTSJFeae+SVdGRZFMq4FL
	P/rzP675oZ9C/5o6q0g0ior9y8rrj4eEDTSa1btZpogk+2TMyEJrGPoU
X-Gm-Gg: AZuq6aIcQ0pSlICY6/KrTDMZlyQjSOIOW4J0LHDWeCii3gHNjONQo9ugq7Pk5aKzp3j
	7NY6j7VkV1i8/MOWlSxiCPDYX1GLM4EtzaEL0PzuIz/rjz85kxgp2oASMynbwVtOHyG2OkhmRUr
	n/v9KHEHtKtIV8K7EZcAU1CYsIPVEDVNMgYNvf2rdb/NARXmMWYKB/nzsBTFOaagf8BVBQO/6Rs
	tUoUNuvmV2ImjE/PKaqper4jCURo+HCIfMXAX2A+Ct6LglvLto916X9nyMUlW2pk3LKt9/xtSLn
	j9JbNr5E9b5t8decqnCFyhR2NrcWTF0Bz6+oOM+D3hEuxVx5Ukzg/wEEYcXX5+sfGj2V6yWVf+Q
	w1UYU0JCM0e3dSjeUXJOJfsQC32pbRO4ES7r8cseMllayY6HQN8lNntThozbGDgReKavwTm0d06
	GiciQgCU1qbrP2XG7ETwWtx8yThCVavlgXq7ZiyDkzuVi0StcULEklLyd4eU/yenKjmAckA5Ksx
	10NLAscME64XVXV1rRzUIO6
X-Received: by 2002:a17:907:98a:b0:b87:365d:26b8 with SMTP id a640c23a62f3a-b8edf308da0mr463574166b.35.1770553470663;
        Sun, 08 Feb 2026 04:24:30 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb (dslb-002-207-075-089.002.207.pools.vodafone-ip.de. [2.207.75.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8eda7e6577sm266380266b.30.2026.02.08.04.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 04:24:30 -0800 (PST)
Date: Sun, 8 Feb 2026 13:24:27 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Zecheng Li <zli94@ncsu.edu>
Subject: Re: [PATCH] perf annotate: Fix register usage in data type profiling
Message-ID: <pvavzfl6u5a2ofnzn7hkwv7kmto6coshps7fbfa5bzsuajq2jw@qulvbcmhumta>
References: <20260206012743.2617945-1-namhyung@kernel.org>
 <CAP-5=fXn2jaPPBHfFLvZy-O2OXZbjOFHatDGdVm4b5q3C8jmnA@mail.gmail.com>
 <qncykxscahgsit26ctsja4jox4353uburbfoehfcuneycbgnvg@jvgs3twjn2rq>
 <aYZa7Z32z_WlQrsh@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYZa7Z32z_WlQrsh@x1>

> On Fri, Feb 06, 2026 at 06:19:41PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Feb 06, 2026 at 10:08:55AM +0100, Dmitry Dolgov wrote:
> > > On Thu, Feb 05, 2026 at 09:00:43PM -0800, Ian Rogers wrote:
> > > It'd be nice to have a test on this to avoid a regression. Dmitrii's patch:
> > > https://lore.kernel.org/linux-perf-users/20260127083030.5909-1-9erthalion6@gmail.com/
> > > does that for a Rust struct Buf, but it'd be nice to do something similar for C.
>  
> > Agree, and I was planning to extend the tests in the patch above with a
> > C workload as well.
> 
> Hey, did you test the patch? Having a Tested-by you in addition to the
> Reported-by would be nice.

Yep, I did some testing, all looked fine.
