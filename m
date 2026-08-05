Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E708922FE0E
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 23:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785974332; cv=pass; b=FC3ieIpuv4DcfCeWZZHfpYxqwq54V3MDztr0fxy0/U/j78bF0n6IbojMHd8rvv2PQJ/1wgvX2NzAWrmOq8+NvY952KYmuF7hfi18BqUiPRpjAuHb0UyhA7Aoy4+gD+7xd1JQTRG7UlnHnqUtf4UNsinBJoOTcHyXaHeHds1/jIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785974332; c=relaxed/simple;
	bh=hOpwPt5xGrGJG4Qw7NEDOPGOW/DTNvvV4pOeSlw0g/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYl37vJAMUvcu2xuysQRtFxGJIw3YqeHeqnJR2ii2fLR1J8IfiFQ/1hTaEzdV7meoRuP+2d/3pRs+qzq0lYGlmXZRbLed3arBxJj3HiYkaHhwi/OmGrNmEONGtgEyI7nBO0uJCIqhFvpEAz2PikZrb2sridaGqgmv8QhPaLfB20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d17U4P/j; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d17U4P/j"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c15a5b265so129931cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 16:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785974329; cv=none;
        d=google.com; s=arc-20260327;
        b=WQoiP7s2ev85GEROQCVz8WmtKMvugYKmJ596yc02wGe0q9cU5JYnNSnZAFuEe1WbDM
         i09foMgxMMvVL8ql70izZNFyt17IY/eXq6lAARAQqIsCwK/Itk4VNhasFYMVzATEoz/L
         /+bh93Rc/2/TlBZ4653gAqoIci43aRPr8UlRYdky8e0LLG7/WAJTVuSGajPYvCAjHWMo
         ZL3PkblwBZuFkRX2HLxRBdVoRke5BvaH5QXMMczaZyvjV5vunFmxsJXFmwjETbPOgv2L
         yvWT79szN3b3wkXawdzvpaVkCMcFkOQua0W0rKO+Bp1VpfE+VxXjL7QI9oPy75MWIMZD
         fS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PePWY/6PIWyyrB9SgDwqHOt+dBc+vzsaBzL5xWWfyzY=;
        fh=TKOOGrC6OYxhtyCJj3NlSbS9Bw9aJg92xhf/UUe+RWI=;
        b=GI2rYbDU3lYjEpSytwzdG6swdHX4mnuCSITgkLO0Nqi4pvfHo7SrC/xGG2jjuETyXJ
         rnIaxByz7ewnDzV7885UwBsBlIR3cG4deznggxfj1mwErz9NnpFWsh4irkJo4ybdDtLt
         jyJoHHCYL47wJmNoYUhmArySJIK8tTsw6PctPNou/U8nKQw2EzRLTYRZRvU4/hSQryi1
         mxJaMoLBOR2E2uzGwM673jLbJ85rXf4876R+D7ZtQ/8CarPsoWwD5B35p+7Cni+sAY1g
         NCP5lTYKcudFpT57KNyepmmIM7v3hRl541MiAj7eI/lvKYbsh4XUrStjDl72W/Dxn169
         JKlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785974329; x=1786579129; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PePWY/6PIWyyrB9SgDwqHOt+dBc+vzsaBzL5xWWfyzY=;
        b=d17U4P/jcAKxBqAc3/hqPeQsAxjAgZBPYeF7jPA8FNnPoRVtqlwph60tHrwPij7EYa
         R8ABnudUDgSS+zljiMhJk7MCHcrTqyFwioTUhJOh3gjgfI8K0T/dCYMdw3uNVSyldyEl
         BjDbNDRiu+Lm2FNeqWcZwtULcL2qQbhnpWrCrcTWZ7ZApY7yxVgeXVbrQYQMfbPJZjue
         sfFZvi+bq2rdfxYb7QgFo8Hu/Rv3YPnnaGBnlD5OsYaom86BNlH3nDA48Fl8X2GrO1Sa
         0o5o5Ch112wuXZio957+YNOx8pEVZ4K323liMA/r9FqiR4Bd5YnXOijZUNMv+hpGXg+H
         IPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785974329; x=1786579129;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PePWY/6PIWyyrB9SgDwqHOt+dBc+vzsaBzL5xWWfyzY=;
        b=NJrrmxNDYkvQ99VU4tYQFaboUbb5jpKmTRVhqb0w+CvAToB7imB+SeG5aDmw0uVMSQ
         vV3D0EXq11XtSZSCRRDhKc2QMCsgcTQ0rgs0o8vfkwOig3nfy2K5uWKFq5UOfNPUBL0O
         l46qG/k7VP/O0iNnSwMaEhn4K9fo0KwOt4JQPxXn5QOjzP7Pyl6pxgHD9SBivwBDXzZR
         Rqivm7HdQfpO8DWGAIwWxIv0ceFUkwz0WpXmj7PpbYGK3DLnjdLwOgnNzT69H1JlwSg1
         dbdnS85ePFicuZEvB6kOvuAQpML8CUTEhShcIg8eOORzyfetbMLdr0Hn8zi554qEsDH7
         2yfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7G62Vhe24Mj2oV2TStJuzYsFgnVukI2sDpCBC44civWJldsoRdOPuC2egpNoTssjBPNBERyAzfu44XjG6QXSn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0y71R6JZwSOlZcW2yQECyS8NgaVa5m54XVWSC+b1NY5UAQ047
	BTzNzBYwoJm1w1oqbddgRgsujKciCKfcsHAfoOJZAGufgWquDRaK2y8aimOIOeMibeeW2m1e+zZ
	38qtKEVoksI1DN0V+MX+sMkQ6R2ylItR/mxBLKeXf
X-Gm-Gg: AR+sD10iotT3vogQEUbWdDDVt9qlvFYm7nuJpWBOO/+nozNJUu0o7ScAddqXFrT+1ow
	t3ueSdXgI7EDyqiPTaFC9nQd250h7xkcar2rul1rhGml6Rn50wHYoqoU0YHJIrq/g3dQS4BXULp
	E9I0FEceDtb4ZPE62LretEYr+PQOwCy9faHAN7MSlGQ3/tEaFdrBN5cGK/SCsAX/9f+3UQ4msAZ
	vZfYfS0s0iKkWDMDR/CuAW6lsQZw35BXwiVbORykCVZqB8WeK6wfb3IbmcrtqgZwuuND8QvOMf2
	qr8mBYkYxwu7hFkukTXq6BmmJdPxuWemFqJqvm1h5k92ZhGK517E4dGy
X-Received: by 2002:a05:622a:134b:b0:528:3186:5799 with SMTP id
 d75a77b69052e-52cfbf29554mr6078101cf.10.1785974328936; Wed, 05 Aug 2026
 16:58:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805151043.237233-1-acme@kernel.org> <anNl0O0EEwLP2baH@x1>
In-Reply-To: <anNl0O0EEwLP2baH@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Aug 2026 16:58:37 -0700
X-Gm-Features: AUfX_mzV6LpoMehWoDntX_UR9CKn6RBQBtZ6W4r6Nb9qG0qLVyBXCWbsyq-3fXs
Message-ID: <CAP-5=fXj1xp+7vwnhGzPnLwxm8jT3WSkJe972fF2Rq9CM5ioxQ@mail.gmail.com>
Subject: Re: [PATCHES v8 0/2] perf c2c hardening
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 9:33=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Wed, Aug 05, 2026 at 12:10:41PM -0300, Arnaldo Carvalho de Melo wrote:
> > Hi,
>
> >       Please consider merging,
>
> > Two hardening fixes for perf c2c found by the sashiko-bot AI reviewer.
>
> This short series is finally completely Sashiko clean:
>
> https://sashiko.dev/#/patchset/20260805151043.237233-1-acme%40kernel.org

With:
https://github.com/sashiko-dev/sashiko/pull/363
I thought we'd start getting positive emails. Perhaps we're waiting
for the server to rebuild or reboot.

Thanks,
Ian

> - Arnaldo
