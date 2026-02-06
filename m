Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADA43451D4
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770368941; cv=none; b=M+11e6idIDYBrVqOx7rGYHBtBCKwOPDglQ5xYaZ10cy3LD1E6kvgGfw3JI65DXNEbpZmPwawY/YnRyFyFCWuhiCu/s1+nGE6HgYPOWp9GGfSm3BbUxCyydICDO1aaUOI35mPAiirDqy8KoLr+8I5yPIFoQLVw4D8qqLcdNlsbg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770368941; c=relaxed/simple;
	bh=oMVx4P6c6URC7MBhmYUuUPLSASkPw1nrq3AtFxSRZvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRncq2ymijDIEvV+nb/BQQYNxTXEQRx0IDeFKQuo7qisWeajprunOB5nYa6um0+9V/FpaqhaKsnCEE0DIGBAhSD4jrT3aTbtZCpPgYjyDkmEJNB7tzhoskPV3IfstK1J7nkSxWRr4jFyawAPKDg+4Dtl8TplgaouUSJSukPzjkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3iLDfDM; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3iLDfDM"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8870ac4c4eso71977966b.2
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 01:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770368939; x=1770973739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oMVx4P6c6URC7MBhmYUuUPLSASkPw1nrq3AtFxSRZvQ=;
        b=E3iLDfDMsBCXWjDvNZLtd+FGuy45iSFMmwLtMi03eb4cktlbptFzYkDe2MAgKvxcrD
         YXnPYlyiRUuuE6uf4jJ2Q+LNj5iW8+jETMetWtMTxmKRQXJ21Gt45MjOpApwGQ0iNapR
         E0yPPJSwBSayirTPoeIKnQxqFDKJXwgw2sc2fG9ikC5Zcz0nwfu2gmRSFuPPmSKZggkm
         bAXQw/Igw//wJLAAYSga4Cdg528FQdg++u8spuwRCT2iyQb2O82JRxUx0VT5naAoKLjy
         cX3zg9bEhWNfU4w3pv+pPAlhCXct0BtJIIw13Vb41TigrnHadsjRfHzh+9jcyE4s5U5O
         n6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770368939; x=1770973739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMVx4P6c6URC7MBhmYUuUPLSASkPw1nrq3AtFxSRZvQ=;
        b=qdnW5KYXBGIi9Bs2vAchwTbmyGkyygFdrzvupRKBDmzbD0e5HtIFZfOg6S/3AquDz8
         uqNoKBYyLhU+W9fncdU5NjAsg1imrl3zW03Vyr6ImsluhcN0uHIyHtOjfmUfJXU5PHgb
         d5NomQzUZn88MoppREKsCtuXygShTRpIfjodWqyIRiN4wgPOnN3gbQfZaynO59TtBZZ8
         NeI13X42lKjBaYqRald+zIewSOVSzfQhKCh0ndYc0QBIfI4SKPAGaqH4YiGpiANP/3Zu
         B4cUaVm57pHp+lRaezlSrYUNmbGxY23XmIQhplFJs5Nte2g+fKx9VmXUPs3Hnbpx13PN
         Gb9g==
X-Forwarded-Encrypted: i=1; AJvYcCUUL9kwRD7bZWIIq+1zo2WByozQ/nUvZZa7RpeLJNq3hyPpWpqgMtlAwL1cK/SqYBpLvSVh/VpehMmv8tO/E2PX@vger.kernel.org
X-Gm-Message-State: AOJu0YzOYyETb8Nu2BaP9dezr+s0dCHS4qryOXmWxEcOacGRCJMZ4Fc0
	IFSTMcemyA3WlFd2NeVsse+Efz8But0gT8sfZVmOgruMX9WnkeZR5MLc
X-Gm-Gg: AZuq6aIl1GhTUFPELIcKsGW0lDspQdC34tZk5mBhb3jM2RDgnu06DmkzUv4htIigDz7
	6mzrvyKFD0OiGLi9MsjxcIe9Siuh75Q0t2uCVLECyj8+S39IMTHvsiIXm2da7TRyvM/lK22/YGa
	6FMNDuA+OLps20TjbMh4vFXPOH0/bQFe41mLYAmamoPZM8RhMzBDWvS8KYF9sqMsOfs3enaZCi+
	/RmxqAPVd65hyAyYLeGmV0mcK8KuiCirOerG9QtYt/+/HE68znQijJdypQ+loiMp5DqPCM2XDo7
	EdcoMdhitdwiQHa2TsY7rHXW6syWWnNHmsFbIFSJfLPboe9P6Y1+lagO6s5vl5vnXjQa0kt6bZH
	xmGVafPk1yhIt1N0clf1PvdNS89bY/GvMpxdB72Mc+Vk6pvpf1+M9i3ab41/q0h2vM3WcxwKQSo
	FJI3QJtGntd+bP62wGw57D0HEOMqqwTS+yo1AWsRUIDB46pMXW2H+2Eme5AY3a8l40djJ3I+1Q1
	uGJdP91m+JnCvSwsv22y4fhOE7WszjNmJk=
X-Received: by 2002:a17:907:970b:b0:b87:2780:1b35 with SMTP id a640c23a62f3a-b8edf383b98mr108367766b.45.1770368938713;
        Fri, 06 Feb 2026 01:08:58 -0800 (PST)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb (dslb-002-207-075-089.002.207.pools.vodafone-ip.de. [2.207.75.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8eda748aa6sm64632266b.1.2026.02.06.01.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 01:08:58 -0800 (PST)
Date: Fri, 6 Feb 2026 10:08:55 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Zecheng Li <zli94@ncsu.edu>
Subject: Re: [PATCH] perf annotate: Fix register usage in data type profiling
Message-ID: <qncykxscahgsit26ctsja4jox4353uburbfoehfcuneycbgnvg@jvgs3twjn2rq>
References: <20260206012743.2617945-1-namhyung@kernel.org>
 <CAP-5=fXn2jaPPBHfFLvZy-O2OXZbjOFHatDGdVm4b5q3C8jmnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXn2jaPPBHfFLvZy-O2OXZbjOFHatDGdVm4b5q3C8jmnA@mail.gmail.com>

> On Thu, Feb 05, 2026 at 09:00:43PM -0800, Ian Rogers wrote:
> It'd be nice to have a test on this to avoid a regression. Dmitrii's patch:
> https://lore.kernel.org/linux-perf-users/20260127083030.5909-1-9erthalion6@gmail.com/
> does that for a Rust struct Buf, but it'd be nice to do something similar for C.

Agree, and I was planning to extend the tests in the patch above with a
C workload as well.
