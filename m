Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E2A1F5FA
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Dec 2024 00:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733360256; cv=none; b=Dm4OHzqck3nAs0kLBI/xHxwFi3xxgZ5imJMKmi2hr6tsp55ftJ4ohsiQ7GaWffIX8f3gDsbVbURhwAfIuEQvqROQlYg5nLTAqpWF6lsKp3Cdtq+VrOA93W0aUpevF8T9VCLO/oeA/vbzb9AKM/XeZyRd7Zz8IsVNsbAApKr83CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733360256; c=relaxed/simple;
	bh=tvW8G9XUS5PrRQV0BFwRykuF8YFYEBlIxGfEIOMfZ04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNbPLU+iZd8gZJRMRE+d/kCyrcwgMOM/R1fn7+mUsNQ5giOhiCLjIt6DAnfbCkSg6LkKWsVx7QAT4nU2IeWRWW0c6A+dxkBofFUCrqVp0ypl5kPapb0cLccgU7PSDthKs1nGZIWRhNgfrPf7wLNYxXnOlgDEN8OOm6HQxHN5x/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b04sxVL9; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b04sxVL9"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso32445ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Dec 2024 16:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733360253; x=1733965053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvW8G9XUS5PrRQV0BFwRykuF8YFYEBlIxGfEIOMfZ04=;
        b=b04sxVL9riYtfaMEPRMXAg+Sqmz4jB3p7qMivQfRGWKrgUb/2BvLl8QioPCeic0r+R
         PNhIr2HgIcveGxTTOkUGM1KjfDj9yuvKMIl+CMkG4uZ1z/aAXDdXSXwYwy6kixjcA2Z7
         Oq5Cs2UX9jNh3Q8DL0tPjVGVfsGehxnO180zlaGRzzIGEz6dTG4YNPyqMQYuebzUR8D0
         6wMJmdeKEBybNGRaWgCZCLuVFVnps7vXl8F+HsiW4J74kWJSZEb27tbZrJuznGOXr96H
         rEETKLISMbLGQc/XKnwn5cgn1pt2T5ibTggNrJo/0kUrZHEUrE1IdQxpIm71p6/Al/2d
         1+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733360253; x=1733965053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvW8G9XUS5PrRQV0BFwRykuF8YFYEBlIxGfEIOMfZ04=;
        b=ZNO+wnMM5UgnaipfpkxHArE+EyDeSffJcnZnHPosc2T6bzXriRl4rlZRTZ3s4gIT8+
         Eo4DBl2e8qP5ZWv6d8Ii06tD7cmOEj9fPnl8IeBF92dmLddn1OZbYlaojQUBeGVtKwsj
         g+TsMoMSOJG9vDvoBIYCeoRPoqVnhQfMJrCg3O3E7gBwMAID96J8ANfQ/jmz9RG2i5YU
         Z9wZU2ugNZ/nQKTNPqubATAFHWLlskkUC1wHlodNJffyBiC0nY8H0I9CJeVfc8fWKysm
         ttfEcwhkHUWbOpui2dKAlwL1Th7vuweRwjyr4eTF4sO+jg/icSAuQqgAmefuuRZC+9eP
         3Hhg==
X-Gm-Message-State: AOJu0YzkFM55MvIxlG2YhtIyD3z2glVUfTORaaxuSXUWmUAfEnZDn9Vk
	JkPmKzE46QclmaGUxeOtoVxZLDwO/+knTNS0spfDyGbmSkRtiYZTgwqVLZsjpCQghsk+gmpW/Je
	ckr85SI79MSWWnDaByGlkgs5XnFBMrKdSgGZn
X-Gm-Gg: ASbGncvJaskIHLrjmG7rxFLPkh5Df9kcFj4H1neT1mjHRSL8EECfAnsO0AU04vRqs2N
	Z6YDGbqyp5xLO5LYQOlq6lnvOg2arSdK7
X-Google-Smtp-Source: AGHT+IHFHxoXNbMc2rj/mBfZ9mhOg7BdRw6phAQZ/DS+WC2hrk70KdU4HwysjDmNM3NgiXRqfvJ8ZFuTmpuaucxLuuw=
X-Received: by 2002:a05:6e02:3f86:b0:3a7:c733:1c63 with SMTP id
 e9e14a558f8ab-3a80901b9acmr797465ab.5.1733360253226; Wed, 04 Dec 2024
 16:57:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b0b0ae91-785e-64f6-348a-ca6edd448b74@maine.edu>
In-Reply-To: <b0b0ae91-785e-64f6-348a-ca6edd448b74@maine.edu>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Dec 2024 16:57:22 -0800
Message-ID: <CAP-5=fVivxz-TPVap6-+6U=ueU9W9fdZSH3w5F7e-h=uN--8kA@mail.gmail.com>
Subject: Re: perf_event: avoiding gpf on rdpmc for top-down-events on hybrid
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 2:06=E2=80=AFPM Vince Weaver <vincent.weaver@maine.e=
du> wrote:
>
> Hello
>
> so the PAPI team is working on trying to get Intel top-down event support
> working.
>
> We ran into a problem where on hybrid machines (Alder/Raptor Lake) topdow=
n
> events are only supported on P-cores but not E-cores.
>
> So you have code that is happily using rdpmc to read the data on P-cores
> but if you have bad luck and get rescheduled to an E-core then the rdpmc
> instruction will segfault/gpf the whole program.
>
> Is there any way, short of setting up a complex segfault signal handler,
> to avoid this happening?
>
> In theory you could try to check what core type you are on before doing
> the rdpmc but there's a race there if you get rescheduled after the check
> but before the actual rdpmc instruction.

Perhaps this is a use-case for restartable sequences? The current
logic in libperf doesn't handle this, nor hybrid:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/lib/perf/tests/test-evsel.c?h=3Dperf-tools-next#n127
which is a shame.

Thanks,
Ian
