Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B26D288C10
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Jun 2025 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750102473; cv=none; b=ViKltD9ueXhTKuFPaBmvF3oFcswUYjgFnfWGM5u1V1EO7Xy5Ik9DVQ3Bg4D8EZLf8nxjjQwYXefDZXycxstckk2l21uRvAV5zmS2odfdgR3Ot34gcLfwkZVVdbZliIyYfPk9rPLJI9AwQjMNiKpv71pM7VnA29gs+ZVOoJ8z5y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750102473; c=relaxed/simple;
	bh=sQ6jbt/GbrfDGqLDdw+RMIi2JlAuzBIb99bLbVIEkZo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LMsD7GmtQqK99r9Z5nXb+E+fbkz7vca3l4mBEno1nr9kAGRqJxh64cNIpOujk7IBbuBX3itOiExXzZb5bxnPVa26qu8JUbvJcONrdejBwZn6BhFjWsx8m7L0op6cavLkAoUxgUfk7humUZtB4794H8tr9cQdf6VG/Fs3bLSOxn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=Op0tjBIf; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="Op0tjBIf"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d3939ecb7dso512785685a.3
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Jun 2025 12:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1750102470; x=1750707270; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jp8QwjnvhiN7BWIar/OR5LHou2I/BD+QY/JAWgn5h1U=;
        b=Op0tjBIfKgiNjk7ESk2V8BHn8Y8G5Hg2EXbN/IiPaUmiAeyLluv1tpK5yfVkaP5Ia/
         EJ/1ppqK8XyXJqoY8hv4u8J2YsJiUS1si+NRC1XRO3d+QBAKIbPdUsEv3Yctd/i8sgjl
         vQpsjLRgUxq58ZOuYNcrfJr5FvxSqCZbxEC7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750102470; x=1750707270;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jp8QwjnvhiN7BWIar/OR5LHou2I/BD+QY/JAWgn5h1U=;
        b=N/DWeLtJOSP4k1dthpPEJKVvlUVZYT30Rsfu1uTWIKpth3+UOqpLGNRqqozeq8oDMJ
         4w/PI5cu2cUSzPG3vLxiEzg8yxO0WokxH0NLKlIq0870Kxh/XDBXpevg4Oi1AVJ7+F7Z
         apl/5U0ztpyN4ioELdWFNijVJC4RCMNmxH8WZ9NTWiK8Ka3Pl2akBCHGnSPN0fkrYCnw
         1G/mCjwC4rfGmrdb5KY0KdPrjMac+UE4CSpbURFYwmtmAwEzlPhi+nScyTOQQEIz3zHu
         yIvfr+BGwk+F0fTt0VqBTAvtxWuTJU9r3f7apE2ootg5d2QdEVWyhqG/OF6Yw3wAygbE
         0PPA==
X-Forwarded-Encrypted: i=1; AJvYcCWVsUuSJpLc7iBuduqEwfTNVBSnO3D1crA7sZLSOSIHs/3zOt+CbAXZ9gqSp4RyjjewYpT8wVQJuGvrDaS5WwcJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2MCKd/7CNkNkCFTEe7G931omcMhB1slRYljBKD1tahb+g9boU
	AFB7CTxy+w0F77fJtokfLdnEGxVAk+ozgu0EUgjaKH0xRn58a9yOuHpinvdpHEQDag==
X-Gm-Gg: ASbGncuoa0XqVu8YSf+NqAkj3j77J2bA3HsQbT7IlOb5G0XXwGV22CWa5oG9YdRetze
	5e60nnf/ezb5kyaHGZXuTfESVTDY86HPcWHccnhFPOdbdhig76+01p8mK3UMZkqWvpyxn9i/6V3
	iINDmfGY8Q530cuUBwcmyU8b/iTc1wPZqPujl0StKO3otzbeHZKZEWHq1YUxUuhJaboj4bhhX7r
	JDTw6FuXGDCFsqN79xWE6+SmUr2jHQGJ7a84QwpVtM65QJWieoP3N5mvC0ZDNhg84b6yK0ZZCLy
	GB8Fjcj32VYgGXYkPHvDfwbZsM430E8f0mTLYGLgbDJq0ix97b0In2rZOq75bZ5zY5zwiH5G/Xv
	lSGRqVg==
X-Google-Smtp-Source: AGHT+IF6RYX1/HZCkAkYpKsqznvQyujC0QPUG+yPjtu9HtONE0H4NlQx12T0p3R4cy0C/X6u7Qe6Bg==
X-Received: by 2002:a05:620a:44d0:b0:7c5:60c7:339 with SMTP id af79cd13be357-7d3c6c0f7d5mr1604737985a.9.1750102470147;
        Mon, 16 Jun 2025 12:34:30 -0700 (PDT)
Received: from [192.168.8.146] (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8dffafdsm561499185a.43.2025.06.16.12.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 12:34:29 -0700 (PDT)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Mon, 16 Jun 2025 15:34:28 -0400 (EDT)
To: Ian Rogers <irogers@google.com>
cc: Vince Weaver <vincent.weaver@maine.edu>, 
    "Liang, Kan" <kan.liang@linux.intel.com>, 
    Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org
Subject: Re: perf_event: avoiding gpf on rdpmc for top-down-events on
 hybrid
In-Reply-To: <CAP-5=fVa14Y+0a=nrxo85uEOHfiEJRbQXt6fOV7E3dQJDf4fdQ@mail.gmail.com>
Message-ID: <2c759cfb-41b2-6f50-e893-1545a965d106@maine.edu>
References: <b0b0ae91-785e-64f6-348a-ca6edd448b74@maine.edu> <CAP-5=fVivxz-TPVap6-+6U=ueU9W9fdZSH3w5F7e-h=uN--8kA@mail.gmail.com> <CAP-5=fVa14Y+0a=nrxo85uEOHfiEJRbQXt6fOV7E3dQJDf4fdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 15 Jun 2025, Ian Rogers wrote:

> So I spoke to Kan and posted a revised perf test that works on hybrid:
> https://lore.kernel.org/lkml/20250614004528.1652860-1-irogers@google.com/
> Basically on hybrid before doing the rdpmc instruction the test now
> ensures the affinity matches that of the CPUs the perf event can be
> scheduled upon.

for PAPI we ended up using restartable sequences which more or less work 
for our case (though we had to get some fixes merged with the upstream 
rseq developers)

I don't always track the libperf code as its license makes it 
incompatible with PAPI (which is BSD licensed).  Does it handle the 
rdpmc case where by default on x86 you're supposed to sign-extend from 48 
bits (or whatever is in the mmap page) but some of the top-down event 
rdpmc registers use all 64-bits so the sign-extension corrupts the value?

Vince Weaver
vincent.weaver@maine.edu
