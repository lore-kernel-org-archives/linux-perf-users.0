Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793333304;
	b=PKfyMoO+sKJTxlte2xVa1tdzmnsFpQM45n6+71TziXJFm0UNUIC9buM+mvaEVozpLY2M
	 fw9KkF5CgDH0om0uh5czFsxM6CKMwCa7NJ6OUXClzcAKDcvd/IE0KIaAZpcFGAo6KmUgA
	 22j3OfSS/5SI3YEcY90c1SsHbsst12tRZvZzKUJzKpNtvXLLWvjkIvDn+jvzMKLPXuz1o
	 NBngL9X/YJV4IJSyGxEIpVzlVC1Gn5mcML2quYwmIqvlCbmlbN/GevbTpeyjkERX7CQ7g
	 3orkW5LpXsRHhevHn/4J13DPg+OShQQRmyDJw70SMvSzaw1s226isNL1ircgtxx1Ohw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=vHMUyTfbM/pleWgtTWChHKF1U6veJ+wlhPLF+0Axq+g=;
	b=EK4BzbzmEAezxgf5NjlvuAerjIWZjeT7S7urWX67HgzL4GgLkYdkhtThrnwFmsDXfCsC
	 OgwqyD6iUeek5cZhF941HK1zD/zNsYu5pi7W5aYQNkxBfqsl4VfhVKoWhLa7Py1ueydRl
	 HOq47b88vQBW1Fe9LUe09SthU7aBCq4SuBuZMbq0icbLZBfR0jyW5V5CoTf8Gc4rE9azs
	 aaSpmQvCAQM8lEjPhOpaQPmPkS+ovBeX+RB8f3fCCUSdNgo5mmejk2GQ/EagUVh2Zbvy/
	 LsTMyNJHTQObaNVf8QUITt7KHWxxYPgPq3SoVy6aVXFQBYL3oUYG1pN4+y4p8PqtiYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uber.com;
	spf=fail smtp.mailfrom=uber.com;
	dkim=pass header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=g4Tvxtcy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA8B606A323
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 04:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DA8B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=g4Tvxtcy
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6774639a8a4so222389d50.0
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 21:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793333303; cv=none;
        d=google.com; s=arc-20260327;
        b=NhquyBDrV8cAXuOf8/Ha12Y4/KoTrqnvf7MQxU4NEaPAglQ4EqkIKgNHqpWvPBX40a
         LDpt41wLixZp3teoDw3+niHhTXP3EzC3aJ12xfJD9X78l5XSDeR06Ib2ZP9rZyhby0cJ
         fQdaZpYQol0z3HAGoMEattsBdQ5EMa2MXsK8KMMT904Svg2vPTR0bfevMr4Kj/aFyKIk
         O/aonf7ogfVWjDlLeW1zHwzejqy+oQVEe2uNUbqirIua/cGfHwqcwLzTue/dI6up2eP1
         Et6yQlK+gYNxWe/75RfD6awcIO+i44oZKoEkKUIIXJtL61fyuBKQcC0msiURO8fpLGJ5
         0XiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vHMUyTfbM/pleWgtTWChHKF1U6veJ+wlhPLF+0Axq+g=;
        fh=ONqG0dn0I6PxiOa4vBYjThfplq6jQ9KhRqWtxrnvsGA=;
        b=Lyw56M6k7GoH1EQrlcOV6YsRqV1b4Stv5l446t2+KINw9XGu98h4LAWnJ7j0yrlTtO
         jhbXqdH3lz6JpPFPwDV1RsAvA8RRV3poRnZgyP8Xtt+pxI+zsjAf50NzV3N7B3PJ+H73
         xFT3z27f/n693tbXIST2DqmYWnsYR/UVn8bEzKW9yNw/rQ9GQPQuKGFthOUXhraBksEE
         rjeB0f4GyoP0Oq2YXKI2n+IoFRqdVfW5rs2l7bX9eePFH+AIlyJ6gfHuF3JTU6AjVniG
         NctQ3/DiBjvfEr/M3SJeZzzQy1yZ65ProJHBmK3WEli8hM+4oP/iGYwdCls6ibE3gNwr
         g7wA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1793333303; x=1793938103; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vHMUyTfbM/pleWgtTWChHKF1U6veJ+wlhPLF+0Axq+g=;
        b=g4TvxtcyoKJVhMKVJToPT6eCXbfrGyZ+zJMiGDorDHvROnzFHIb/EQBjjGAvDGhSh5
         HEdxJlNceOWMaIpUOejZKnyoTkPkB40vBEh4JfeIuz0rttUuvWK1/R7f5t2DHSBqqNyt
         QkssSHpha8T4bR5vpwOQ7fCvVIEAKEdYPmwI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333303; x=1793938103;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vHMUyTfbM/pleWgtTWChHKF1U6veJ+wlhPLF+0Axq+g=;
        b=d/yx57OluHqnB7ldFSFRgSSrE7ZYCozN2sv2p7iyfaT1qLM+6p+7Ea7z3xke8eDTaO
         /ySUONX5bPORFXZY90LPEqMOwWgyzjnMZFFhcdlcVflhMUvoqNx62/ukJdZWaz3t9CK9
         pfCyQBRygDAvTR/nTSpJrIRmAewSbJLyyFJzuQvzDRAV3FrRXMQOrYDNtmMqW82+c8V1
         VCk7oE4EzA7ICMjS1KzslWoDG3IGX5dK92j93caLg2+QD4lQQ1l6AIKpxb4fIWfeKfZ8
         wydQfGXQQubS92lihEutkqafVB4YUdAzLygjp/YBwOv8Tb/qJ48Ki0hArIRtMOsi5H58
         yRXw==
X-Forwarded-Encrypted: i=1; AKwUvBy6g2d88TWXcHeTaavyVqiE6wm34kXFLzGPtMulZmXFcFE7oYdo7mK3Th/XMJambrQKFgIyshUT3V0Dqtf/lerR@vger.kernel.org
X-Gm-Message-State: AFq9FYKyGV4Mz5ptesHkOeqfP2VY8JK6vADuY8bfCZyu5BMAkOem19n9
	oHeyVhqHJHgO09wa2pau67brYg08rRzTU0DBw/KFh+S32afABs8Wj2j0pueiKUacucYEwZdxqb/
	xhZ8RRfQlKHVUgfabhwTaskJRGkGdxlGzHzueTRSIAA==
X-Gm-Gg: AYBFou1HPXV0DEoJS/WQLMnukNzV5jOjJ0aWWoDIrbFIUhwKu7O1G7mGns4V1TxL3II
	4YVM/XzZ7EHeGkHXxmjGbVA5cKiy+WFzc4w6tlVuJvhGCmfChU/ypkEOKWGyVvdjTS6NQw0YawZ
	hZLYBHWoOu599o4AaqgS93MbOQNEkUb9gylrTC/rO1Op4eKTtwGhJJFrngn664BCSS3wEYEF8WC
	CbOnEgfM++msYj723I0qzElClyUPF+S8hFThYOlFaVqpXlwL2AKHcYCAvrH1hqNO8xzk2ohlT66
	j9lhG50uCgAol4QcMncVlVSeKl6KhQtqhSBL8ryb9rlQrhGMu2w+uaMF7pHCd8lgGruDgokT0Hj
	smkAo4eQ0lv9dMG153zDeK1nDdzEcHVeU2tVxHbipKjyjLIur13FclpEzhdQ9SVDoHF/RZQ==
X-Received: by 2002:a05:690e:801:20b0:679:9f7f:5674 with SMTP id
 956f58d0204a3-67ba4f6afddmr459057d50.55.1793333303121; Thu, 29 Oct 2026
 21:08:23 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928075237.3055101-1-irogers@google.com> <20261027231513.816148-1-irogers@google.com>
 <20261027231513.816148-4-irogers@google.com>
In-Reply-To: <20261027231513.816148-4-irogers@google.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Thu, 29 Oct 2026 21:08:07 -0700
X-Gm-Features: AclHuK_7rFAIqZE8MrjY4fMuzF8Cp5z6NDguzVop6O35qi4GKhK3Pu76Vhk8b8M
Message-ID: <CA+w=M=Ry_Ww4UsraLD_tgDo399GzFAQywR6xy_NHqdy_No5ORw@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] perf symbol: Add accessor functions for struct
 symbol fields
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 27, 2026 at 4:14 PM Ian Rogers <irogers@google.com> wrote:
> static void init_rem_hits(void)
> {
> - rem_sq_bracket = malloc(sizeof(*rem_sq_bracket) + 6);
> + rem_sq_bracket = symbol__new(0, 0, 0, 0, "[...]");

Doesn't this make hists__fprintf() pass an interior pointer to free()?

At this commit symbol__new() still returns calloc() +
symbol_conf.priv_size, but hists__fprintf() still frees rem_sq_bracket
with zfree(). Once symbol__annotation_init() has run, priv_size is not
zero and free() gets a pointer into the middle of the block.

Should we use symbol__delete(), which subtracts priv_size before freeing?
