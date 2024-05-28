Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2FB178395
	for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925362; cv=none; b=Q4tUG+uzf+WxshIh45XPPvpzR7OoreJNawubMlKKQ9cvAYZWBBH5jiHstRO5iekd8zKOzB7hpfdWmW9i+kMXaWRao05E/4FXtJ5IAJ9wmRxsXMrS2HpLU4uYh+pVpECzD3PQL2NcihjP+72MQfnSJ5awIh5akrYjRZ5KgVoXyHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925362; c=relaxed/simple;
	bh=k581Cx2OkQB8gaY0y6bcYlk/ITECUZ+zQX57Yhe7gKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X67W250l6DcMlZjMCvPVu3tDVmbx+H/lZq+NmJoY0kjOT7AifP2MN1sxi5pwdx1+fYJLgvXa4LvoE8tq9gDoC356SzahtfBWVShQpaEioiyJt9fQje0e2md7UO9rUmyRP4rKXhPm+oD5PbK4DgEtlGB/N3SLhk1cuOnYD+cO9Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EAETErDe; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EAETErDe"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-529614b8c29so2101685e87.2
        for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 12:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716925358; x=1717530158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tnSiUD2gH9HDmHjSHl2kkucSe6ethci8IQ5VxoD7g98=;
        b=EAETErDeIiu0AwukksuwSmvvM7DVwA4v654m0eNwhfYsMrLQHpIL++T39SxQOVNCrU
         FIp/aNVPHQhiegArwuKpuJykF9evu9wVZQk6v9dtM53DIBJnuV2ZZfswP1hnaC+zk0/D
         fMIZt6wLb5HVZscMT5UX2WIKp1/VJSsj9bWzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716925358; x=1717530158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnSiUD2gH9HDmHjSHl2kkucSe6ethci8IQ5VxoD7g98=;
        b=BluejmNf7ev78TDxgTl8Oaox7ngaRJDxqiI9s43cfcNrv/ZkGL58od7+OcfCn6Fjcu
         pbndBvFaqpAcMSQvgP9K+ie7cBe+ArwHy2tRPWmtPp8f+xYd1aF62tHgUv94KfI1AUCI
         xqGzquSwxLRJ/gDjkz+OHrbaR8X2fzW4RV9MsTAM+91s5OKfOwJ7tw+BDMX8pNm8W98L
         LcZoumEAKQfOo8y/MiGPs7wojS1o4wNsa9o4iOi4VqnjJFxMpEhKuai9EELSYgIsjjse
         5Lh7H4g6cj/NTqaeDTNBcPaaq/5w2Q/DMWah1iTSoBdrJ9C2W2qYpj8EjhPWx7KYtiKy
         Epxw==
X-Forwarded-Encrypted: i=1; AJvYcCW6D6FhcU+atK2K5dFdaXFDzAIu8av2XB81OyR7dimbxeGS2gE7OPsK4HtZHbF5LkECzmFNl3cifh+19RXFUQRGv+pd9uMjIho8oqLmixWJhg==
X-Gm-Message-State: AOJu0Yza826HEAPXrr9WVpnZpqe1d9oJYkmXJr4uEOl1HULndi+GgdVl
	cdknkorPtP84hO3AaMIkOy59BdW8DwEvhNUfQq5m8W4j0jfpHbW8DYxOXUVJeNxfp92lKn4nTZa
	Z2A+zMA==
X-Google-Smtp-Source: AGHT+IFc2oMIbOs41Dam54EY2xdL1gNVJDdyVmfZXwxxnM3B6duqe5bvFQmFVgyP6tF7P9oTmncR1g==
X-Received: by 2002:a05:6512:2521:b0:52a:39aa:7767 with SMTP id 2adb3069b0e04-52a39aa7a66mr139803e87.3.1716925358361;
        Tue, 28 May 2024 12:42:38 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066bb25sm1025265e87.154.2024.05.28.12.42.37
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 12:42:38 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-529644ec0ebso2034524e87.3
        for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 12:42:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOQ75g5omsIkZJe1//xeGmkTGjYmIzOQxWyPcnc2qRyoxQfHzGvPEtI1Gx7a7DKGe/ZLIaKGK6wrFolmEGF0uKEXHd75M0ZVoBIylTwevgAw==
X-Received: by 2002:a19:6a05:0:b0:52a:7d01:84cd with SMTP id
 2adb3069b0e04-52a7d0185c6mr39607e87.30.1716925357626; Tue, 28 May 2024
 12:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525152927.665498-1-irogers@google.com> <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
 <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
 <20240527105842.GB33806@debian-dev> <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
 <CAHk-=wgcoODsCbba423uZwQqOjJ8r29GZyCd472K6L6Dt-NbPg@mail.gmail.com>
 <CAP-5=fUp+gSoLC90vT50X7So_SyAC9OprAMvh_Jj_8NTuO6j_w@mail.gmail.com>
 <CAHk-=wiDheOd3pdZ4vdLwrMbbVs3LUcSD=afASEWbND-HZhuPA@mail.gmail.com> <CAP-5=fVGF6A7fwZyF8o0Sz5nNhtXb0007JoCxaiL2XHCKS3=0A@mail.gmail.com>
In-Reply-To: <CAP-5=fVGF6A7fwZyF8o0Sz5nNhtXb0007JoCxaiL2XHCKS3=0A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 May 2024 12:42:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2yboV-UtCO_NFV2TsbbMeHTw0Fqn4rnovbGQzkZLCJg@mail.gmail.com>
Message-ID: <CAHk-=wh2yboV-UtCO_NFV2TsbbMeHTw0Fqn4rnovbGQzkZLCJg@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core PMUs
To: Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 11:59, Ian Rogers <irogers@google.com> wrote:
>
> But nobody else ever reported the issue, even ARM who maintain the PMU
> driver whose event name conflicts. This hasn't been a problem for
> anybody else.

I'm not blaming you for having had a bug.

I'm blaming you for NOT DEALING WITH THE BUG APPROPRIATELY.

I reported the bug and bisected it four days ago.

Taking some time to fix the bug is fine.

But that's not what you've been doing.

Since then, pretty much ALL you have done is argue about irrelevant
thingas that weren't about the regression in question.

The fact that you still don't agree, having broken documented
behavior, and still argue against just having it fixed, I can't do
anything about.

> So I think the revert is a real regression for a larger user base.

I didn't have much choice, did I? You refuse to even acknowledge the
bug I hit. I'd have been happy if you had just fixed the bug. You
didn't.  You just argued.

> There is a testing issue here, not least I don't possess an Apple ARM
> machine.

This is not an Apple ARM machine. I have one of those too, but this
isn't it. It's an Ampere Computing system, based on an ARM Neoverse N1
(and the ARM PMU's both for the core and for the interconnect).

But that is pretty much irrelevant by now.

The issue is that you don't fix bugs you leave behind, forcing the revert.

I'm happy to test any patches. But I'm done arguing. The "cycles"
thing needs to work. This is not a "pretty please".

This is a "if you can't understand that and acknowledge that without
arguing, just work on something else, ok?"

                  Linus
