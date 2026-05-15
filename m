Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B4A3CF664
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778889177; cv=pass; b=FWah1xsoARdZd3tFU/pafGS2vgCkZ3R15YfeVF0KDg+r6tYk8DncJl9spaE1QvmFEk5mzmGlWMBhf0qiSNLw/+aN+L/1fWNUKokeYX4+wP1/JBRCOBNpzv2BdiNbXuUt8TnwJXhIMf37TggFOXaGqk6fewOdlinurE0cbA6v68w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778889177; c=relaxed/simple;
	bh=rYfVRQCqy+ntKybgB4KrAPodHzYEqCc9foYwItW3sj0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=m3w6iCxKjryh+c6rcAIl7ZVyIhKiRe8y+IAhTMnUllabG2zWe0lpouQNHHFbW87foB2tzG7RTX0UklY7wJh5epBxbkWYCEkSv0P7lwp/0plwu9CB8p5hrYW6kHLMY9PaJvi6TCzlX2/9Ppy64tzINF7hFeSMzqVkWM+VdFd9U3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nCDm9LXm; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nCDm9LXm"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so615ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 16:52:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778889176; cv=none;
        d=google.com; s=arc-20240605;
        b=CMCSUELnlWcjOyE5QvepR6zrGzTephPxPnYK8L0AOFomLeob1Ui46KrsjpT9ltdptu
         aaoOs71aYOMCM11XOKpiTfsGHH0zqjJzdVtO2gZt6OZqBlrhmMBmTFwqvd56KzV8zgfo
         v4vSLepLCiva1RT72cBnJIl11KHwyZiaLJDaTLBaNiuQFMP0EzhLj7bCOuBxw/MpwkPo
         XzbUN1G9FOZI9UU/qyxSQSEkdve2tc8CHBp4IatNOQYp3EsN+5v/xCIuO884vDuD85JP
         Z9L3RA/iEe6Gq84pwwoofTw+KDD2oT/3kkw1WGrDHrX2JsmrF0TwgCR1bulIVxDM55mo
         4UAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=rYfVRQCqy+ntKybgB4KrAPodHzYEqCc9foYwItW3sj0=;
        fh=HiiQEoUnRYPFHimLsJkv/tq/zAZI+zHjvvyqqUXt+oI=;
        b=JNh1BAW8kwWEZ+CziOfEcr1GdGVUSUrogVWcTj0dhlAkzTU6B7iIDASrb/W7/UFrPz
         mP6BF3eDZhpuX/P4sOSgWLLHdchlVMk1ZsQj5o8etQPpXzC8xbjBL664PMoURwE7oRQ+
         2z9/bhT1xkOChXUENh0wTQmGYvtnuNieh8TATY0lRPCsV57RZZ8z2Hg2Xja9OltFgf/y
         hBvYcUKC/aktKeJrFJj3YzBMXJfX1OAkHWbvut+kxZdWSWxc4bKKQyRz2xn/2e5pJTsb
         MTY5IfeUpN3HlpLT3hwVM69bzDnaWBVvshLbVPMonzbFR1L8ykg2rl/HG1fkl29RFBHO
         jKxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778889176; x=1779493976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rYfVRQCqy+ntKybgB4KrAPodHzYEqCc9foYwItW3sj0=;
        b=nCDm9LXmmNZN6rU9BmergS6ARl0529cgj0zbHeSAxCWA/HfG2P+V35nRVFieycwQ2b
         Y1ZwSmpH8W5Qmd3TGu1ss9esNH1Cb2OeDVmShCYEFR1SBVyQ4uLWUJxTmD6qZWv3sRwU
         8XwRjPJ6Dvyv720KGunYRXKcNLje+II9RuOpPHEzTij1HAo0gHWt2qqqd+/3siwdG12V
         K8kCTC4xJUM/Zk6mGlZSgsR6HInpyHkVFaxTNgxhgS3rH623BlWC/VX3dglRJXMfFlb2
         LbEtW3H33bLVOI1pXDl78czTr8uwHoVtJE42JK9pc1BkkRM8aGGZBJC+c1TuPJy6ZMF2
         LSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778889176; x=1779493976;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYfVRQCqy+ntKybgB4KrAPodHzYEqCc9foYwItW3sj0=;
        b=frcjw43j3a2V+bTWWpfwmzzhAQlbmMfsJ3Vr6KnJHDy0wlwpbnBv+0qGCdWJU3fNsj
         XFIPJMDl0vPy2o+QIxtCMcb2lRzc9vbMK1M9VL/PTv0o3EkmlEY74l3UOVG5XSN0RVpK
         LgERR2jSHCXqR+ZKdC+rSAo6pu+ulhjXrkvIFo8IIhnSrh3ZBKlT7V+fKmYKVmYOoS6+
         WX3eCdUqYKIV9Rj//SzhLH0/4pKm0uV7RaR8hOAh3zMHuyR4vpD8VVABQ2zpKuABarlV
         PsMnpeMEbAMI5YC9CXEKUjfoas/iWszMOunfvmmPsrjLuh2+0CQujSe5pppi4r5NHjeE
         z/fA==
X-Gm-Message-State: AOJu0YyVXbfkXUAD5rR+gjX1zEPkCwPLK2526XsH27LZGN5Rt2sgEwAO
	fNnBSKjadGue6Km9E2KykfrGPOyTvqorhpFxQcOM+HlICqHuy3fr4EQHlzKxwKyvqW3O9p0nWfz
	6uKY3SgwtyQfnoM4d2GRLPRcXg30m8fq5dGOMNP1C8HNHj+MQ4Ti0k3lmF6A=
X-Gm-Gg: Acq92OFNCOd3qZLs+fnGHbshP/GY2zKOlK9OQsHifXYFmMWNEA9q0G/mupXV2YdJOR2
	4Q1UpGEWtrKEXEUmbsgr/Az9EpTxc3ierqkJPTHCh/cnGzBRi66G85YkJEVpqCoyyxUIGV1ozJ/
	L0FoePChZ2iOmD5x5bOzt+6Txeeh5Q3mJ4VkfOc43pSEs5YbwI3xy8fCc9LhavH1emSjZFQ8vfB
	i9ebRemb1u99xEAY40HVFD9GLGROYVNT3ILz3EjXJ4R3H4wcrcg5FP5XCOLF2RDWuRt4w2tpDwC
	g0NPHmWf2VSKivbyjWk=
X-Received: by 2002:a17:903:2f90:b0:2b2:70ba:305c with SMTP id
 d9443c01a7336-2bda0deedfemr1114145ad.8.1778889174866; Fri, 15 May 2026
 16:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Rogers <irogers@google.com>
Date: Fri, 15 May 2026 16:52:43 -0700
X-Gm-Features: AVHnY4Kqr6QiHhJFwLhCHIJLyvGMWUpwICLDyAeOna8rLRdxoqE_SQk4jPNAWAY
Message-ID: <CAP-5=fW5Wozj=F2dnXoLTWmUjudNWLyjjg95CuP3Jk9bLcYwww@mail.gmail.com>
Subject: Perf review prompts
To: linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

I think we can improve the review prompts for Sashiko and others, so I
sent out this PR:
https://github.com/masoncl/review-prompts/pull/62
I wanted to advertise this and suggest that others contribute similarly.

Thanks,
Ian
