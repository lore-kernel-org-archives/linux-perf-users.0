Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="YzYZO/nZ"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5142737
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 06:26:34 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0B94340DB0
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 14:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1701699993;
	bh=yrj69QBqcJ2/0+no6KMFGYnNPrNFydkA4S5q1Y5aJZw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
	b=YzYZO/nZrN7evCwH2gqh6dFDYtSNNx0lGCqz7aoFK66l4KGN2YIBv6J3MKJfbSyDM
	 gyGdm+17y0/vOsKbM5JSKkLN6D4YtB0W1t1/flMABCmYuZVg+5EbHU+Vy/mBcrYEEN
	 zazjXjQ2+NByjRY6MYwdiXuzN38J21ufbC711LBdg2GK8NYxgeQAI336YatNzeGzDw
	 6eCp8Q12g33ujgjsgJ6ZebH6p1vDqAgyUH13ZS/2XIC74jCrA2tlyxZylRyz6CJqOl
	 0iD00oq2JOSWYskME+udau4KHgFuSDximYgR1VBSNvJCHAJQyjVv5ONpi3BJUerxhf
	 fhUXfNc18lUwQ==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b32faeb7eso35110565e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Dec 2023 06:26:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701699992; x=1702304792;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yrj69QBqcJ2/0+no6KMFGYnNPrNFydkA4S5q1Y5aJZw=;
        b=TrgzfqB64POTQz4kpHTroQi9629upN8Ipn7elBB+7rUFDU9vjlz9CTud/JCLbD+1da
         1JQxy3O8E3kOURPBmhemCjWYdBKRoLzOHiiYhK7u9BM5zcxqjMEXarTWg7fROwfEADBQ
         X3BCseHuyAd8h6B8dF/z+mxQZlrYTF2OwDnFjxFd4cpFc+dy7lhWIofwi1UtigvBr/J/
         jZxx3Z9d3VqNRPml43gQXMWoZ36LiurSwHmkii9YsOVqY5loAdsZBdmaume0o1v/1QnK
         YEcq5jsoZCElpcqmZzQwJzw178ND/R/hcY5L3mkaNHTik4CqvZhbsTiosXKcyFMLzY7p
         1E0w==
X-Gm-Message-State: AOJu0YynVg3XFe+0iC5jiqMvRjJlvfjFP3k60YS1pXyjqMbJ3Y7eLfDs
	YaIsOliu6UkQ63OFBqc1US/ai+SyUiuL95CdQd5lvKxlAun4X6or8tzJSQHoaDATHlJIkSvL4Ab
	P23dRxHW69kJJ9GMrEWv6wHGc0GqqwQ8gzHZJtkL6eYICOpI4YWyVsr+ojSV9joZJGCh1e6g5MA
	==
X-Received: by 2002:a05:600c:54ef:b0:40c:33d:9b92 with SMTP id jb15-20020a05600c54ef00b0040c033d9b92mr1375219wmb.62.1701699992499;
        Mon, 04 Dec 2023 06:26:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvLlHhcU3Gc7h3Rn17LrfqyAPp8cApuaxpodpxOeyeSvrgZgV4xsXZkpEJttjlTW+azdLXQTQw0bYhJ6MkzM0=
X-Received: by 2002:a05:600c:54ef:b0:40c:33d:9b92 with SMTP id
 jb15-20020a05600c54ef00b0040c033d9b92mr1375215wmb.62.1701699992188; Mon, 04
 Dec 2023 06:26:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date: Mon, 4 Dec 2023 14:25:56 +0000
Message-ID: <CADWks+Z=kLTohq_3pk_PdXs54B6tLn25u6avn_Q1FyXN2-sVDQ@mail.gmail.com>
Subject: Converting manpages from asciidoc to rst2man ?
To: linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

I was going through build-depends on linux kernel in Ubuntu and I
noticed that whilst most documentation and man-pages are written in
Rst format, there are a few that require asciidoc.

$ git grep -l asciidoc -- '*Makefile*'
tools/kvm/kvm_stat/Makefile
tools/lib/perf/Documentation/Makefile
tools/perf/Documentation/Makefile
tools/perf/Makefile.perf

$ git grep -l rst2man -- '*Makefile*'
Documentation/tools/rtla/Makefile
Documentation/tools/rv/Makefile
tools/bpf/bpftool/Documentation/Makefile
tools/testing/selftests/bpf/Makefile.docs

Are both Rst and asciidoc preferred in the kernel Documentation? Or
should we upgrade kvm_stat & perf manpages from asciidoc to rst2man?

-- 
Dimitri
