Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EC21AA3D3
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jul 2024 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365085; cv=none; b=h/IORnChsXbHnrLIGw94BLYFpAn5UvG848zzfCQPelgn3Wr4L9YdGPwBK6NfElRTvVwMREaSwIw5p9MYpqQoZZ82XLLr4b2yW8PG1JxbfOsgdL8QK3UoxRd9jE9uA33VlQSYYIEq/OMSMxTC+GcIsex03F3jQNYCHUVGkRXlZsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365085; c=relaxed/simple;
	bh=VMo6dJ3VB1Wck/pVQoQP4ZQEKTvKYZgqJTl1Y9nCodQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fg5RAo/RDyEqnHSwwjsaybJEoQhpZxr9K02FVOLuR2V0XIp4oBxtz6UFX6SUSJJvlQnw95rg9fR3RnfS9GbRPQUVXg2Z7Cyk14tIbuLyVjkKyD32UYZr2nulJ/4xH0mn704GsQ2b5TFkH88qYxgZLYAidU6an4JP8qV0/aCqii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vJv2LP6j; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vJv2LP6j"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3993fddea13so15625ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Jul 2024 11:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722365083; x=1722969883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMo6dJ3VB1Wck/pVQoQP4ZQEKTvKYZgqJTl1Y9nCodQ=;
        b=vJv2LP6jzu3seQNjb+u6AqUE1PxDQ2cWZ2sd+P+hfSXmNxLCQntB4yCe67/jwMPu4g
         CB7VcHyw+3+mf7bFEbB9tG2sKTtqe3ZgH38u0VD5vBP6PUM4xwYsWs33LVVRaWm211eK
         NRLLEaM/rY/kQ7qkUr3DKc1thrUr4dUruAezC3JM/fsXTDiStC4AsnLqo+932jhierqg
         tk39X9n538B0vKjq+OPhat1x2oBUr2QcKvTqyCVpbQnOakVcBD60wKzWZQcQx5vHz2Ma
         lG+zlvwEfbL0iSs0EBBoAngaDksCVJDvEwHbUPpQEc7h6bYypxF7YgDxuvC7UodtgIZQ
         PsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722365083; x=1722969883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMo6dJ3VB1Wck/pVQoQP4ZQEKTvKYZgqJTl1Y9nCodQ=;
        b=mxgJgHZTl27hbRPmYkuQ+WLcE0PYHYj7y/vDjgdW9yckSAO5AHAT1iyPHcMyA7JcRX
         XedPNA01clZGbQ7hN3L4TTVABifFyc+vE//FY0ZuVw9wvWSJ0is68gilVljEfLSCtErO
         T41xiOZ97apENl9nDt+sG49OKXmcBUt38Kzf54Rzts8eeIqquByyNtCd0KgakRL8FVlc
         cR4n7QbwZhW1d9TeqBIUxFRb9LoWmC+d1t7VCRZfHA/LVeGfaX8Tn5WkAzJiWxNxiGQa
         zM2PxSfVl2k+l9l8a1v4JJbcES+TYYs+IagNaIQUCQZSsdvu94Hu2ePfZx7arv9m/Zvk
         JlvA==
X-Forwarded-Encrypted: i=1; AJvYcCV8qwKVlZKzvl89ldAHW0csR2AYTzDd7T0Nt/xC6JEYO0QGGDBRAyDFL8LwBLVr23kfaM/WJgAALAZJgqXKIgVinfi38Q4ixhEfs+bcX9/Cyg==
X-Gm-Message-State: AOJu0YwZMhF0XLRaZsMtVdppm5d1k8OHQ3hDIDq2b3OvrSighsaS84ZX
	ol1pvhPUcxXUbwhC6s0EX2OKywLeIkfNxokoNeIC+5VlHuQCzWhaVogT0N8d8nmyCi/iSgRBxT+
	Xmp5S0PKwGYOuz2A0hP2vDduKRyGSnaSfn/ac
X-Google-Smtp-Source: AGHT+IE2wTVpq6cTfrCc/sBL3n6RSYHPW4pheFE23rgwAanUdG4Sec3KPIhfIFDfexy9QxLlmajHM8oKJmxn3lUgjTo=
X-Received: by 2002:a05:6e02:178e:b0:396:de95:2c6f with SMTP id
 e9e14a558f8ab-39b0ee2f3a3mr391325ab.14.1722365083218; Tue, 30 Jul 2024
 11:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522204254.1841420-1-weilin.wang@intel.com>
 <CAP-5=fUtp_vd=EeeesXPR=nsm0VOZoyXico=EVWobOEYsxq27g@mail.gmail.com> <CAP-5=fXOTmMyPx_tQPoCfCP35E1o6YSyZde58ojyU1PLJBt96A@mail.gmail.com>
In-Reply-To: <CAP-5=fXOTmMyPx_tQPoCfCP35E1o6YSyZde58ojyU1PLJBt96A@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Jul 2024 11:44:32 -0700
Message-ID: <CAP-5=fWu09Oy0bYjqW921NXgh33GOeCZ-J_tQ9PqPHT7XpY4DA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] perf test: make metric validation test return
 early when there is no metric supported on the test system
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, weilin.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 3:25=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, May 24, 2024 at 6:26=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Wed, May 22, 2024 at 1:43=E2=80=AFPM <weilin.wang@intel.com> wrote:
> > >
> > > From: Weilin Wang <weilin.wang@intel.com>
> > >
> > > Add a check to return the metric validation test early when perf list=
 metric
> > > does not output any metric. This would happen when NO_JEVENTS=3D1 is =
set or in a
> > > system that there is no metric supported.
> > >
> > >
> > > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> >
> > Tested-by: Ian Rogers <irogers@google.com>
>
> Ping.

Ping.

Thanks,
Ian
