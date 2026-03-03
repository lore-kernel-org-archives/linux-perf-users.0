Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE77370D66
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Mar 2026 22:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772578046; cv=pass; b=jVhb2wFJaJYrxs1GE6S3eRODPUCcAqGlSzPxNa8Hb0Qcuf9OWiA/tRH15gVp9ncDmlYuUtfqDK72/xeELRfvJNAsSMoNYBV+8QuDvWs3ZHRd+x2hrtikq3X94aO9LRscDIdvqcy36KAF/NsjtWdsYCBXe1yor/vYrLNyLjN0rN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772578046; c=relaxed/simple;
	bh=Srsjrzd2Vvwc42GE8+NOblGI12/zMb1VzJVW5VvuW3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LxJSwi05gP56WH6vFD1NFvtBDxzsMnzHEcawBS5JEwLacFp010v3nHWB5Aljkedj/j5FGF3UBcUcZ6bVGxIprcxELUMZ4jzMLCYAKRw8XW0EBBW/OVuz7xXOunnIb6l9eSMdMxZ8sfZVxAQoVFPtg6l65CNZJ/C/RFs6c9EGkd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YN+raGJI; arc=pass smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YN+raGJI"
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-7947cf097c1so59775037b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2026 14:47:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772578044; x=1773182844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rnQ8nGrJj4oz92oAw7Q8Q1yW1r1fbYQWDht9jAisIM0=;
        b=b3XFj4mri0msupj8ES02PyVnCLKyzyphkK3jUP7fVL7ew+Om8hc/R4g5GNIE69uzEu
         ehvoqcq53EFs6TMn0NmvCTJPKN4zqSrqcsyFRZo966/DLArTD4kn42uUTkjKqIMx+MuE
         uGFQeFpeeJnZmYwhb4tTqaKLw9cZK+1IEt61fznFgoubNgijUuaE59xK7TtKUDjfLYLC
         hzzGUbHbmBaPGQamT6xP+Daqp5nrfdadAl5ybZuXacBBSeS+fLGohEKXQ0WckaXLNEHi
         D8b+mgAU28GfVMJbDdSCeSEOHQPue9KJhC1Jl4LFB6u8SJJzM2TkDOX+YkZ2rOtIes4C
         j0kg==
X-Forwarded-Encrypted: i=2; AJvYcCVE4qMlQvxRHMxr3LGdKSqX9vpYEE66LptMUSpIjKV13x5zKdW9Dmsmk1DT2JyfoFD7zR/Eayzi2kcsyNFR7gnO@vger.kernel.org
X-Gm-Message-State: AOJu0YwhtCCHw8fcU0YN4d9ebQ1gMVE2dAeJF/hCclcqqRQlJte3iU05
	7tTJO5t9mQdxpfIGlWncnDPWBWwOLc7R41c3rFAm2ybCzTf7NI+VgbDSmPJmR958ORQJdwQOgAI
	0UlufVngcn7hTVh55n7W3cyA7Jr2UxBGlZn1CA8BNHtUi+LYYSFxd5uQHIPkzFfg5lQ4oAUlQUb
	oMHGuTOiOO8iezkvbaMRdxoHRsxykyhOLzqphpGoFiDVmyAMNtjQjb3xTdRG6hfazauJxyH8+M4
	JeZ02xFtxLCsceqyOi3XaFIMY0=
X-Gm-Gg: ATEYQzyPb0vev8slOetn+AtKMI24EQdRZKzoKqCnxykxp6WyHh4LBRQWZ6CvywMMp9z
	1YpN2A+sT0z3g+3/DRBeVjtyO7Nh9cEN21NNNFWt0Cr+DKYp5hQKcKhbUeejye06SbF6aD8r8LA
	oEzPW1FFV8d/x3gPfSKCXuZkSty5KqnvdviNQO4AocXx36tKXLLbfqSiGfO8C9Q8cfXyXtfM1c1
	4uoEXwybE99S8klqne7XS1hRfZ4ME72Po0qrO0ueQ5+REnoqnOuAnPyTJxz83aNMTaXfEWGNS4e
	MJL6L+m19X41L3i1AuGtn1bn3/t/K+Yi7Dcr6MpVjZEOwSj5MXNVcwUNFDvJiOqZ6KwPrDNUP04
	XIRnF+dpt11DnARVhW2xBXDFYLFnyIojW47lWSg5uVQsURktBKXS+RI4puBAbtCqQAkjDMUUbub
	gLkVFVco36Ual9U4Uw3HyLkHJF1oasjNlm1p0fYtyynch82RntcLocRDU4xmo=
X-Received: by 2002:a05:690c:60c6:b0:798:5951:f465 with SMTP id 00721157ae682-798c6b89ee2mr524157b3.9.1772578044366;
        Tue, 03 Mar 2026 14:47:24 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-79876c38505sm21888487b3.21.2026.03.03.14.47.23
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2026 14:47:24 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b8f9292d84bso188464866b.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2026 14:47:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772578043; cv=none;
        d=google.com; s=arc-20240605;
        b=MxgAMZmwrIw2bWns69qoxUndt8ZwCNVuGzWSq8SN7IbLgZEt5JnnSL6LNzV/jN/kk4
         P8+ocLY/hYhJO/Nxgr2YayeYPTp6nRiz1TEOjcMrP1X30HiHf9PKohkhqrkoo3WgX1C7
         Kg9xXgXeYIIH2r6HDeQAtKWaJl2zWoSFvmLRcRHnnA4XlyveoFtJxl1eBdXSfWbY/UtC
         3K6b7B2Bwtslf8oJxmnD90cSG6pTcaC4ix8Q8RYQlMOTb2lxYs4WE+7v17qCnTll3NHj
         5knVCSlvaBUuncDWyzCiozTM0vFAwU1Wu7W9vPT5K8wBv912rVWgXwiTLjLFq8omTXel
         1PnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rnQ8nGrJj4oz92oAw7Q8Q1yW1r1fbYQWDht9jAisIM0=;
        fh=8/fpJ+jk38O9GpEC3Vn9Fw1t2/u5jbEtUxV9Opls70k=;
        b=OiQFF9DA22xma4bpIcnVsuN7aMJ5X0ouGsqN3xwGN04jyrIqB6xMvffh+aCf73A1nN
         kr/L4SzZPVdbXryM3xwltFOAzhMpiK20XkdV47kN4MPfoAF2vLDsJFXAEUzJYlTw22++
         XiCIDNTGNBOPS2j2tDmm488OBwNS1L8t1PZIyMQlLigsbIQ3PQ1fYrkGB4XurwZZ7gXX
         7jjTm4uWhy4LzShfK+P5BdMyDrXe55ruzDOVL242o2sYbFUmIG5DhGwqFi50JDB3wI1n
         pvzcEKr/dCb6bn6HB2YikLQCxYwoykuXOjm1s7LsFij87ytySvS2q8no1icBEJ6q2+SF
         hgVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772578043; x=1773182843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnQ8nGrJj4oz92oAw7Q8Q1yW1r1fbYQWDht9jAisIM0=;
        b=YN+raGJIt6znXxLxha0Eg5gHrUR4gXSOlf0mscQDes8CqO3zNSWx/0t9IKe0Nn3p4J
         hC8Ve8Uyno+KshUVBhgmTqp2Lct9FjQ32VBjgUOpFGu/2EnCHKm9dm8dDgeqde7DmGGR
         FJk76eXL09fHHLs7auiPDnWr95MxWUpNe6ctI=
X-Forwarded-Encrypted: i=1; AJvYcCV2NDn+PE6tk5b5ouJ0Qu8UM/GRVJwE/yyk2t/TEnkqSicKamTEhCXh9NpJ8O0m3Q3f/Po8wrwTMr3SdCo3cGVw@vger.kernel.org
X-Received: by 2002:a17:907:1c9a:b0:b90:35c8:d01b with SMTP id a640c23a62f3a-b93764d2343mr1193385966b.36.1772578042809;
        Tue, 03 Mar 2026 14:47:22 -0800 (PST)
X-Received: by 2002:a17:907:1c9a:b0:b90:35c8:d01b with SMTP id
 a640c23a62f3a-b93764d2343mr1193384166b.36.1772578042237; Tue, 03 Mar 2026
 14:47:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303211503.165337-1-mmayer@broadcom.com> <CAP-5=fV5yQGGL3q9KB-3-bc+T0ZyW6robVLhskb7aSQ7HV=a5Q@mail.gmail.com>
In-Reply-To: <CAP-5=fV5yQGGL3q9KB-3-bc+T0ZyW6robVLhskb7aSQ7HV=a5Q@mail.gmail.com>
From: Markus Mayer <mmayer@broadcom.com>
Date: Tue, 3 Mar 2026 14:47:10 -0800
X-Gm-Features: AaiRm51Xf86wxMqM4XLQyJtQlq_mA7RdoRn7gpqWMbDpk0hgJrZgOGFuNZVkoAc
Message-ID: <CAGt4E5t_VXxnYHJhvWCwhfap5=tnFLHHvhaPafru0A+XcZmiXA@mail.gmail.com>
Subject: Re: [PATCH] perf build: prevent "argument list too long" error
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Perf Mailing List <linux-perf-users@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Tue, 3 Mar 2026 at 14:35, Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Mar 3, 2026 at 1:16=E2=80=AFPM Markus Mayer <mmayer@broadcom.com>=
 wrote:
> >
> >   TEST    [...]/arm64/build/linux-custom/tools/perf/pmu-events/metric_t=
est.log
> > make[5]: /bin/sh: Argument list too long
> > make[5]: *** [pmu-events/Build:217: prune_orphans] Error 127
> > make[5]: *** Waiting for unfinished jobs....
> > make[4]: *** [Makefile.perf:773: [...]/tools/perf/pmu-events/pmu-events=
-in.o] Error 2
> > make[4]: *** Waiting for unfinished jobs....
> > make[3]: *** [Makefile.perf:289: sub-make] Error 2
>
> As with:
> https://lore.kernel.org/lkml/20250728093153.2330009-1-changqing.li@windri=
ver.com/
> I'm not able to reproduce the problem but the change makes sense.
>
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for the review. Not sure what makes my setup different from
yours. FWIW, it's an ARM64 cross-compile. I had the build system dump
the contents of $(ORPHAN_FILES) into a file for me. This is how many
files it was trying to pass via the shell:

$ wc -l json_files.txt
634 json_files.txt

Maybe you have fewer orphans to prune or your shell has a higher the
argument limit. Whatever the case, both our automated nightly builds
and manual builds have been running into this issue.

Regards,
-Markus
