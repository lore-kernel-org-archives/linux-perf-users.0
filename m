Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FA43B9931
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Aug 2026 02:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787108333; cv=pass; b=TEd8zcgi0cW42SP0tBFnMQrDu0EKmr5/9MiW8wj4TQdl6InA+xb5y+sYTkd/Be6sXoAy6RxZafv+YdJlzonPDST8le41YyQVA7+f/o7kq3vlaYHO4pYRN/JIG+ZSytMtnGtQXTSuadaREtQbJlD4Ihcsy2A0dPKW09cSIRpOd90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787108333; c=relaxed/simple;
	bh=wFWAbd/yzlBnfV8KE4nnKxK+fwi+Hj6jWRnneO8eGZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BE2B72uj9CuU2uMBieHijsreCdO2U8l19VAwAXeFR7SMBfd/ICEoUSYA50LdhT33z1sP33FTQE7msU3M23RCb8vQ158xVOcH6yzZbDuYd617Y9B+mBu5mmbI4JBFrk6OhOkFccLcZSmsRvNIPNWOmfjsblZybSsb0aam7SSs5Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IBm4u+M1; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IBm4u+M1"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c01c79467so123801cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 19:58:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787108321; cv=none;
        d=google.com; s=arc-20260327;
        b=gch0Ca4qtwKfowB3LsmXjLS2PXFPxtQdj6UCWeBacUugwI70roamOyqRn1X+fxLq6R
         rBTiVQLxaW6T40iDtSGSUuj/IB5R6vSVr1aZpig+Yy/U3erLCxeBOlhM7F1RMUoDyni8
         kwfp7TZDgAKehzSQxrvnpgee9C1z47qn7Z2WjeBggG2mh2qeSsQ0ZhflqBAWLYBGdC5u
         ztOvaxCGuJuFzmJ1XdcabYIMWTxmukkZhtz05ol/oTQpZohtinPrpPi7exUzk1C6n9B4
         21YswNfsRSSxVx864QsHg5iQkLHK0Wp97Mt3TVZbJvoT8n9lwAJxu+ZlGE3yjmIk9+cN
         0VBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wFWAbd/yzlBnfV8KE4nnKxK+fwi+Hj6jWRnneO8eGZw=;
        fh=GPQL0iDfyVRVY7WtPmhE5DHWj6jnrBzm/LRph0t0TZs=;
        b=galTLHX5G4pL6oSqZqwSIbOZrs8S4JnW1xLWKcUclP5QOgT169mgzb2YvgTxJO7wrz
         1U9c4knra5pJ3PfhYjrCb3URDfbQqFKIiPx7zWK8qMfdIRHwT/stvO/qUdxnj50Ln2nK
         om3AbpdWwT+KXeRx/SFfW74OUeWFHZwZDupXQ48edRd8x9j1xFbYPdhyt24sPGVVcBoG
         f5Geg/QUDlJd5lB1D/Gk6aL+LJAAE0DaBpMXsMrtgVMwsNz9n1C2OlWyBFdFmzfuTeyK
         sUPwNdBMEK9rBiuf1Fqmk/8//Ms2DTCI/D4+aW1/B/tz5/hWxBw4PvBfk+gjfhxwjnl2
         1ggw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787108321; x=1787713121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wFWAbd/yzlBnfV8KE4nnKxK+fwi+Hj6jWRnneO8eGZw=;
        b=IBm4u+M1SK3ncwLOYuy1dDQAoSxuidU5ZOjXM4MDSfXnKknykuZOJgygrw0Nx/G5ko
         n44CgAbGVZ80z5gk41+xt9nG8JGu9wgxVKGDCtOGdijGhbj/Q2jZTYiMi3HEVMpPy2tC
         XnYJLLvE24CRG0vZlBET71OuC3h2ikOLfSesGpKN7e2iB4HWuAaeuJbNvhHIQmg2pbrd
         qA29k9PPX8ZycwGItnnhfZrLWKyRfju/iLME14xazW2oFB6SMVBjI41poiOx2gVdxeCn
         y3gBE1+gxDo0tJMk7RyYtDOVRMxU4owNuK0xzg98Yhwy3Fw1TuqospHQXZPk+X/TY4W7
         W/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787108321; x=1787713121;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wFWAbd/yzlBnfV8KE4nnKxK+fwi+Hj6jWRnneO8eGZw=;
        b=X3d/LAx/cmkhJsebdvzUDPSebmcd8oUmIP57ZsuYs3g8MsOFr8s7xP47DkT+yFUy3Q
         wwyvy4uVv8ppMqZLliwDEBoGue/yfZ++a0mgc1p6LP4dpXqeqvE/md7fVSt9ScfSrHEu
         h6mF5TpUYYBmK4YW/twD7H6T49xvZuPQoCSPybKl0XrQjpLB44vmJjDsoAs7UFm3BoJB
         PXbs2MGsFzZDuzt0qNl/KS1kAx0yizgmuG7GFCT6Zp6HuhSdryKv3KxfJmEDXaxrOrBD
         kNl/wE4TY8ybMB8zfvqm+PUbKU4tIcWyjnVgXofnPoSpKVbZUhB2UqSDRofDlJdbw0Iv
         qpag==
X-Forwarded-Encrypted: i=1; AHgh+RoPXH4yiY0N0A0suSLBc8MYD+mQl0uKTo71wGIshJRNmP3jfmGMoI+IeegK4hKXi+VE9g/f05DL24OtX0YaDivf@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/y6XWFORp6Z4T/GDZ4qP7NDU5lnSvf1Z+2cAnOM3dgQMgKLlg
	iRpUgkHpnzaWquiQJ0KnGczl3ukgXXBbs2dr0DY1nIJ0yeEnZGdgcGYoSsihQ8NHHjHNbpdMS4M
	yJOKZoVbHD8bzah1l0mL7iBjjaDJTdIzHxkIHunRvpHYIsNMApCGFh552lzQ=
X-Gm-Gg: AR+sD10NjhpCd4XxL1jbEuq7HSGYQE7Xasr13z+XqKw+LKZMBojBSQSmsbaCEiv2fyv
	x3gdJjmQKN5eChtyQTf1RRCl2u0x9smV/nBFIWRxnADmOTk4Ti/cHp3psyOA5dlzKK3FiEtJneH
	EVFNiXwmeZMu8gHvGqhdrSaETjzwE5ogHPFPCgprhmuaYNg2/IaWfdneDRKWAS7P/86O+NKcycx
	HNNGMXezxS2JnzoiuOHRImBtnsgIVE7df4eW1ECGSGjXl6vkji8Ea8SCQG+gkE+0zgvf75DOERG
	HQbXN/xtkT9N3UyUX8Hl0MdrverHRgZPAdPtbzMerpAPqw==
X-Received: by 2002:a05:622a:8c5:b0:517:64f6:3365 with SMTP id
 d75a77b69052e-52dd6473c47mr5741351cf.4.1787108320794; Tue, 18 Aug 2026
 19:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813132519.4099508-1-andi@firstfloor.org> <CAP-5=fW112qVVdZGNpdRH0n-B2at4ENDjjNv4Hdehn5bEB9BSA@mail.gmail.com>
 <aoSWkMjxuz3hYr7C@tassilo>
In-Reply-To: <aoSWkMjxuz3hYr7C@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Tue, 18 Aug 2026 19:58:28 -0700
X-Gm-Features: AcwNN1XA7iSueAsdpqJ2vujUI_i_dlaOV4daQ8ACeIh8LX59ZBK8O29NwTgxl_4
Message-ID: <CAP-5=fXYPdVcdVQP0LW+ueLSWY11vFJq9GNVLA_yE=P_1_7giA@mail.gmail.com>
Subject: Re: [PATCH v1] perf top: Merge hybrid common events
To: Andi Kleen <ak@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>, namhyung@kernel.org, acme@kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 10:29=E2=80=AFAM Andi Kleen <ak@linux.intel.com> wr=
ote:
>
> > Thanks Andi, I agree with the frustration. For an event like
> > instructions I would like things merged. Does merging make sense for
> > cycles given the different clock frequencies of p-cores and e-cores?
>
> Frequencies are always per core anyways, even on non hybrid systems.
>
> > Should the e-core cycles be scaled for this reason as there are fewer
> > cycles within a second compared to a p-core?
>
> No.

Since we have frequency mode on events and the periods are aggregated,
I find it hard to fully think about the ramifications. Consider this
example: I have two identical loops, one loop runs on a p-core and the
other on an e-core, both accessing identical data that fits in the L1
cache. Since the IPC on the e-core is lower, the number of cycles it
spends in its loop should be higher. A user might mistakenly conclude
from the higher cycle count in one loop that cache/memory issues exist
in the e-core's loop, rather than realizing a scheduler issue caused
that loop to run on an e-core. If we detect a hybrid system we could
switch the default event to for all perf tools to instructions, as
instructions don't suffer from this problem.

> >
> > Perhaps we need a new json field to describe the hybrid merge-ability
> > of events, say enabled on events like instructions or cache misses.
> > Note the legacy events now have JSON descriptions:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/pmu-events/arch/common/common/legacy-hardware.json?h=
=3Dperf-tools-next
>
> Makes sense. At least for architectural events it's easy.
> But I'll also defer it for now.

How can we merge non-legacy events? On ARM there is no PMU with a type
number file with TYPE_HARDWARE. It's not clear to me how legacy event
merging works outside of x86, although the issue is worse on Intel
given the lack of architectural event encodings that exist on
platforms like ARM - so the e-core and p-core perf_event_attr have
quite different config values.

> >
> > It would be nice if this were a generic feature and not just for perf t=
op.
>
> Makes sense, but I would also defer that to a future version.
> The utility code is already partly factored out for reuse.

I think perf report should be easy given the overlap in code with perf
top. What about perf stat?

That reminds me: the enabled/running times are wrong with perf stat
and hybrid anyway. I posted this RFC that deserves more of my
attention:
https://lore.kernel.org/linux-perf-users/20250716223924.825772-1-irogers@go=
ogle.com/

Thanks,
Ian

> -Andi
