Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274FD2690D1
	for <linux-perf-users@vger.kernel.org>; Sat, 20 Sep 2025 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758381717; cv=none; b=nP/o38XHsJMzOR2pV8/nWCckR85UWWfNnRwTb7h9cv2VnViPd40Aw8SCxEr4WziqspZdYJEBTS+vtxA8xJzLsBVvqGo2r1tg9yr3P7rgZWI7qZY/gjTFPJUcIzJ4WMseF1VGYZzE2fw9z7o/IFoK31tB0Jwisw3+W9W/wbnq58U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758381717; c=relaxed/simple;
	bh=h0efYwyS1D9GFBtrlwzfjgxaYyPsK2aqGzprSfxOlnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGNj+eYrj8Rp2Mk9JNPI5MKzend2yqbHtXVhoJdIISy78y/DmmgPhcfQy0yrOdEsy5kp96UG5jHa91ih7TduSE+WriNnzxtE2X4GAZMNBxHGjx7n7AN1bCOK/2JBHcXnQSZo6L0Io7e72ctUtRLsGz6nMx+N0NjEKjH5Ws4Y1eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lyidlSsg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lyidlSsg"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2699ed6d473so136215ad.0
        for <linux-perf-users@vger.kernel.org>; Sat, 20 Sep 2025 08:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758381715; x=1758986515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzSfuN4ySsQ+PKnoyw+8j2RW5W6RFIOOb6AK4pRniuk=;
        b=lyidlSsgCfzbjhoTCDIlX5zJ8espl6AqDv2pSpvVdBMtlNYmzFagScHxsOk4yYnTQt
         1nfSdwuklYBDT8WhEj5rK/1wt5rDVImgScW9xFR1eiDGDO8VlKt8GJXFlU89lDQkJXo1
         HkBWnts4UF2NR6gLziZzqmRbVum1e1pJBdVsGjvrLYBYPe07VqMVGGAoJTppWazAIggb
         CwJD7rpv7m/7y1pG5rx97c8pUOwMr3ryyTtv/TTY47JxepZjEV5vysnHFnWx2zhHwXLQ
         C6x3e4Jwbhh7AYjoq7ymUacmlZNeYdZJXdfnQEW/AbkAkd3sllhdQrWfCUxcoPfbfRDL
         RDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758381715; x=1758986515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzSfuN4ySsQ+PKnoyw+8j2RW5W6RFIOOb6AK4pRniuk=;
        b=PgiagWYi6Azs/+MUrl/ntyueHRaLEmaarZOSn8AkKLPtdYvWQ7N5wY3+/83OnxhWyv
         FxLTukf0rCZtcDGXV2RUGiloUjenVcyn4q0AJ52KN2ogmilmq4e0/W2GV5WVxtIDYj1I
         q8HYv6L2mOF/1pi/Mdks5WfihLbTOCsgY1b9NAa6uKd+2rdC/IprOGLZ+O3PRnLJN9F1
         5E9nbqf7ENfLyvrm7eh/NSPbCYtHqQDQndyIWZZB8LVLF6YANON24dmydxaZTfXCO7HQ
         rDxU7C2UNtavclfs+gu2P3CqS5Ut36QiXeYhqgFuJ0+XGW7YSvf4/9doGeZQ/Rn4TF+2
         RwTw==
X-Forwarded-Encrypted: i=1; AJvYcCX2rqUu91Fmowm3R8UZhm6X4j8n8YXPEaYNOFR7k1EY2TjL7RXmpNC5F54wDZMdxaWwI4MU6A9dqfZ8FTQ/iLYP@vger.kernel.org
X-Gm-Message-State: AOJu0YwlGFM/xDJwbmW6TyVUrzB+Kw7yTUeRG0mmgZZ6YqGN27z1w1A9
	VVQ+IPELo6Iqm5BO9Yf7pB+0eAEfHQ1FJ0mS/2zPmatVqPcV9Ip+D1SMyCABzCcXOey/cQaEYN6
	LyzIac+eKJisu0f/3EcmbTLtDPtJoRgGHx/eecSaCFrY7ID28HRXljW20Bbw=
X-Gm-Gg: ASbGncspKpO7+y7YpCIcigCZEDddkwEMpX+5udgWucS9ZorUDZMp5/yasDG6/UVeFgU
	AszjHuB/uIPsThhk+0m+LtMBHGFLBOdEhjbGtrU0y3FHKVk0eQ/5q3H+3clNh/XvtMbLHNctEKF
	cKCbYJu3UIzVmpLa0/SKo4Hlwrpo5nkoS7YwSEVDgFLQc6k1Gl6kk50LgWdSqUiUo6jQqC+yy6C
	zK+VTSu8ZF9qCO3wwE=
X-Google-Smtp-Source: AGHT+IEr1FIc/Nik60TRugyW5gXEwBcRlDr2YkbHBuRoSn1HZFneVz18uNgmFQQbl+4SXTtxbEw3W8ZkU5use8iFF0Y=
X-Received: by 2002:a17:902:d48c:b0:26d:a02f:b046 with SMTP id
 d9443c01a7336-26da02fb6bdmr4759615ad.11.1758381715073; Sat, 20 Sep 2025
 08:21:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250914182900.1960567-1-irogers@google.com> <aM3BCr9DbBxnL5rV@x1>
In-Reply-To: <aM3BCr9DbBxnL5rV@x1>
From: Ian Rogers <irogers@google.com>
Date: Sat, 20 Sep 2025 08:21:43 -0700
X-Gm-Features: AS18NWDtI_oOLHkLFF04XHuxlAZBdaoDT_OrbL1bV8YQ9TRtspsJbnXhNRPxs4k
Message-ID: <CAP-5=fXOMLLFmn_06nBGjzbeD4=TLGPExP+K8x_pNRqKO-z-KQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Test fixes and debug logging
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Chun-Tse Shao <ctshao@google.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 1:46=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Sun, Sep 14, 2025 at 11:28:56AM -0700, Ian Rogers wrote:
> > Testing in a hypervisor guest showed some issues that these patches
> > try to address, or improve the debug situation upon.
> >
> > Ian Rogers (4):
> >   perf test: Be tolerant of missing json metric none value
> >   perf parse-events: Add debug logging to perf_event
> >   perf test: Don't fail if user rdpmc returns 0 when disabled
> >   perf stat-shadow: Display metric-only for 0 counters
>
> Thanks, applied to perf-tools-next,

Thanks Arnaldo,

there was some follow up in:
https://lore.kernel.org/lkml/20250914182140.1958530-1-irogers@google.com/
I think I've also noticed that logging introducing newlines that
impacts the tests column counts. I'll take a further look as we tried
to harden against that with an output file option.

Thanks,
Ian
