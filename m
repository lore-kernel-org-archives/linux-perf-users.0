Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795480279;
	b=B4ZeuC7LudjfL8ITXAozdg9x4HkhHuz0KnG3E89NErXCfD4hJohRNiueFQMZMppGvXgD
	 oaV3Af8GIwOK4GTeJwrMADJqQHK3WHt35FB/ediIbMEvKGtiPAfMsU4fzekS/8iZ3syKG
	 05M3+FSlhtr5J+swfJR6XKo9d1nyinxbvQS3pWnkNUUPGPtbojuZriQsgpS3s5q5Mf9e6
	 AwwEGdc5FAbh/udSN1vjdyqBU14h+lcFfZeoQoxwSJnn/BvqPaq/PAfnDgWkA2bn1I8UA
	 ElzZwfBvEF6C4P2vKk1uScEUs+sX8XawzV2oZcoicgal1D4bIMtNkSkGZPPmfbkcO5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795480279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=XBBRJhlZK91IRv9lRpTyJCctT8RJXhFRC51jo1VlnUo=;
	b=oVnHbxt+xU8YkALV7N5rQ6yJvODoArZLaP4iuR7IrcWOie5+qlAe7hygMqL7cAJOvxQX
	 E3h8mqOyiSYao1Ka2wUS2usKvFV7Hy09kd+6hEj81oVk7VswABtCWmAXknmER5N8LtRgt
	 6oWeFEjUScKGaEwPmAbCviMpIVHdMlcBwomsWoIBqfbRn58MOIP7r7GNaAdjgurUfyb2y
	 E9/j0OhzjzkdJO1/HYw2zmPe60bFUtLOLwO+WOD8mvkUJotI9SoKWlHgH20nH7vncNzQi
	 kT0nCOjgg661UXDYB43FLHojdyuzLYDmw8UHjfM+ZBxJHdU7gxJXXs+h+A2ICDzaO2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uber.com;
	spf=fail smtp.mailfrom=uber.com;
	dkim=pass header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=LBFiC2j+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF40606A322
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 00:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCF40606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=LBFiC2j+
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b4dd5cb4f6so25876907b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 16:31:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795480278; cv=none;
        d=google.com; s=arc-20260327;
        b=ODOgJPwbiRbhhSsm0tUpGt93nMq+6kcO7NFwVb4sAdXnKEVw5pa22OhgaRv1IdwLqK
         XiP4J5w2a5H9gr3yl/0z2Nokwbnfxa3OLyNZhsraE2YUmnWxK8fs1LAm6azRI9zfbrZ1
         ejrUoOHH6PalUDp409H/oAjm7TWhjsKArd1/l32xbtuKW6Fd8jxjE2szxI31AqGuxXWn
         d0+/blGfpzQsiVKQGSPN/Uyl74s9WYa32Js9SkVnsE0IUJsJlHRFHL0lc/LK+0nN2JzG
         ePN7APSYVhOxjwJhxuJo2DQvZVfk951i17EXfk5N0/cV4jb618dmC0XPmPxDGPufOM32
         KZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XBBRJhlZK91IRv9lRpTyJCctT8RJXhFRC51jo1VlnUo=;
        fh=7iI9HBBcwvbduiiajYVXWYqOZ34TRyoN9XyC+M1RlX8=;
        b=FchwdyMGcdxg7bdNa4ztPd+XC6zIipCShS/Uv2csjNkgq3XUwAFWaeaKXfzSXYVnf9
         Qzs9HaCdAMRqMXXe4nplHBPjedfBf9Do/i76f0ccn+2/nBI1g0etbyn7yeuCKr7AqnFS
         ktFCWE1xf7h8TgWQpcZbw1cMz8xG49KBl2tK6Ih5lG13v+ZWlxzFGFXp/PvI7ov0sSju
         kHpaJLyrt3ZJmuQEGCzwflYIdKOjwhTTus8TFUVK9YAbCJVx+mJC8bTq8LnJJsNHy5B7
         jYokTofA83zUpivOBCiHMUZn8GQyWH4I2ODLgPQUpE50j2xYnrAvsH/zV7TR70JIRcRP
         jALA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1795480278; x=1796085078; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XBBRJhlZK91IRv9lRpTyJCctT8RJXhFRC51jo1VlnUo=;
        b=LBFiC2j+bNqRr3AUvQgWzHe6jh7NRWpzgANTRV07wFyXobIXgKJT1JpIDGXsR7QRxX
         VE1zxJGgxZCSIv2v94gOuosdIk8+h8j4wA1bPDY9Ch4uq0GUd8u6Yd6qCzO61Bw6+7PQ
         s1AUw2pli8iaYqsrheSREKpuPrGMY2Ewek/bY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795480278; x=1796085078;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XBBRJhlZK91IRv9lRpTyJCctT8RJXhFRC51jo1VlnUo=;
        b=WCTluOIzHbY44zLhPZTHMBA3hzdke4+V8j+fJv81pH83Z+VcijrSnNUvp9CDy3dUSu
         OjhUCiNnnbqyCrVAn95f33w7T+HnznFfGWaUE7XpcHik+a6z7eXH12uMmEbPcE/f94WJ
         HJifnYRpD9j1MXPIR0DiidoRXE4zPRv4y4inqk1b2+OkJolmu9FekZ+KlADferCdtjPx
         NtEB59UXwVY5b9ouMhO2QUD5KBJ1uQUfviY8/5YUlOBD9m5IJfMp7K7VlZ68+C9MGJ00
         bDs7ykqB8hP3yPbtNnCSbjCGdlcc30XztpCA/Vo9W3YOpW68MCmvUSi0d0IA0YigExGr
         uscg==
X-Forwarded-Encrypted: i=1; AL+hErFNqTwIckrH5tuxPPAzbnHmuOs89SO5LTkOuF8/Y5snQZayFeOu/aL0uBTlEEZ6qjOaXcMsc6NpBxz4hkVdiGl0@vger.kernel.org
X-Gm-Message-State: APuU4Z9SUh83/K5i1fo6dRAMAORYl8zWKOulG6m8QAbe5WBt9lhn4TVd
	0BUOUVa7Orcocbk3EOxKqG2BtIFdJgXlP6zTtmIKEjUqx7HtODasSB2xqbONvqgG94RRaWbb+qz
	ymOxvY7pR78PR1ABHjOQMyD27fSOXdR6b7byPFsk89w==
X-Gm-Gg: AZFdTZc2GPOLqGht0rW4SsblCDrytL8Mf5obzSb8xkErKFVF8N5UFphg7YwwxwhK0P5
	tU+Z08IsP9xYlofTMSv/gIBU8/AH2ukduIn9kWWHysOmFTiguGDz1t88f4ks0DEDxfshDewloqr
	pWHTqLR3Z3vcnKXc/0PsJS9tkJZDmUnLKARgiu5odWWco1cCRIXC/eWC6oeghGNQfAFDdEMaOeh
	7AVsmpX1+yEX8zRcP4cAVZjeBa1Vs8WHyiNF3Dpphh+v7Kjez5bEaxyse08bxBNapV6CLgX/OkU
	a+/vaqmLo2TumJrC2ZOggPFq0gVumfl3QhUKLN94lowGP6qe0d/v4j/+F/tffqp1Af4bKsgzMS1
	bAMOLu5HtyF/SUYbJufztihjGqZz1rNAn7hS5wTFubWC01pNTgYct03fVDpxubPwoBzhjmQ==
X-Received: by 2002:a05:690c:6a86:b0:87e:2404:6b45 with SMTP id
 00721157ae682-8b5204ecb30mr59678307b3.53.1795480277123; Mon, 23 Nov 2026
 16:31:17 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122050405.80335-1-irogers@google.com> <awS0QkL6JuMfC7Z0@google.com>
 <CAP-5=fX4-HqRbB8zWNSUFyCc4Lzz44iNmok5HJVj5O1+oqoWOA@mail.gmail.com>
In-Reply-To: <CAP-5=fX4-HqRbB8zWNSUFyCc4Lzz44iNmok5HJVj5O1+oqoWOA@mail.gmail.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Mon, 23 Nov 2026 16:31:01 -0800
X-Gm-Features: Aa3M54qz5MWiuh12iW5spvHAu_-ZVuYeTacDOMGL10nwbT3pFevtztiRCbhiN5M
Message-ID: <CA+w=M=TtEOjHR83QWYknCdSxAPxMNSmQ8yHdVJOXcecRgNEJNA@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] perf symbol: Sorted arrays, DSO-owned lifetimes,
 and memory shrinking
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ian, Namhyung,

> >
> > I've applied the first 6 patches to perf-tools-next.
> >
> > The patch 7 was bigger than I expected.  Can you simplify it more?
> >
> > Also I don't plan to merge the rest patches as of now.  Let's wait for
> > the lazy loading and try that for a while.
>
> Thanks for merging those ones. I will split patch 7 and rebase. Patch
> 8, shrinking DSOs, etc. is kind of the whole point of the series.
>
> Thanks,
> Ian
>

The lazy loading v9 is rebased onto perf-tools-next with the first six
patches, so it now works on the sorted symbol array instead of the
rb-tree. I'm going through review fixes and should post it later this
week.

Ian, it uses symbols__visit(), symbols__sort_read_lock() and the
symbols array directly, so if the split of patch 7 changes those, I'll
rebase on whichever lands first. I'm also happy to run your remaining
patches on top of v9 against the same profile as in the cover letter
and send the numbers, since the two should save memory in different
places.

Thanks,
Alireza
