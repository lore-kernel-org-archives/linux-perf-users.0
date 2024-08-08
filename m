Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699F48003F
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Aug 2024 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132863; cv=none; b=B4rhRfY15gRP51bD2zms4QPJ5Fv7FO+gbVeNy2wFl219nNsf4pf+wyM+Hymtb+TK5MN8swiP5Qml1afT3LqRa6nu+E/uAB1RvM3M07EsBz/kfZBK+YtRp1MAM9lDATwH9MhWT2lxv5nrNyRcmfKsusNxXeegNMFsIti/FheTrPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132863; c=relaxed/simple;
	bh=VBqbzIbROQvyEHT5bw53ddnDLfUpvA9+eMFijb3vQRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xqn9/wB4sJjqlwUAwwHMbtCMh9XtbqUC1rYj6nnYVbOfTsaeVvEJ9EEeIONcw6betcEN4KI8aFSVaeVvuArJtM4lv5gbMccCSIbW0unlQGXAJ/Mdul9JiRbEKDvXhv+tvgWgEHwL9WvRfB51Et+d2XJClsVCdE86rhYGp8Lg5Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XTXm0nYR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XTXm0nYR"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fd657c9199so180325ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Aug 2024 09:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723132862; x=1723737662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBqbzIbROQvyEHT5bw53ddnDLfUpvA9+eMFijb3vQRM=;
        b=XTXm0nYRJ/gsnxFuKDFajhPgnHq6iAWoQNxR9NIhpQUjVbspruSEp3Mp8ZoEPrQRmi
         05k5mlgPzClVihHD3TSO1LpFaU6SvbmwXVeDawYyObl0EEY4+5Ba65Q7bQTYaNdKOcuz
         tKkw1ct+GJY7E5wmJ9eyo2Q/zsVffNUFwmx3Q6DHii9xNpBrv+EQby15sxUcFKfXAuiu
         mpxyFEZW6I8rlqsMuVcb09heoi3lmWfZNNRpb2Yi1ftGqestZmkBkZ5xoHFe4Weq8TcO
         Pcuh/io6MMUECVnP90QCgj9iqmjo4kqjVttLz6c1jRys8YZb8PlOR+gBJSpGf3vRQXQb
         7Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723132862; x=1723737662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBqbzIbROQvyEHT5bw53ddnDLfUpvA9+eMFijb3vQRM=;
        b=cLSCdiggr5cUw+Oc0zj6PfxDqZFUWR2Gb4lqw9WGma8FvbLxwqiXoG+CUmarICyJEZ
         0Nlbb8WR+fWa7O0ry+45utCSIWtMqJQA7IwkN37hG5RWjg6/GL1IrgDmvM86odtil3X/
         XBH/Msh0q1CqY0mCS3L3F2MgDGcQ7gI9C3JzIG+iVKo4E6zqvhFoY2mtt1l51nKMSMeB
         VB83jIS4oYkPWPPVqfc2iHmffDfLfC2Gz/4IwSNjVWQ33eO/cg4/U1Fkaqbv6dNanfEO
         V6gaIpWyPCHzC2ct5hTJw2l8pMvngdOjgLVoPdwsA9S1gbOFxW3KVOo/zhdaRrELMISU
         IDog==
X-Forwarded-Encrypted: i=1; AJvYcCXVVQT32ipfsFmpyjMqNVL8H+JiiesCXi3HRPYymBsAxIHM1ExlFfBO5y1jA79ULlDWuyLGIhXZvLOXCUJYx2xT+cE16Kddfi8Ov7q/NmdjZA==
X-Gm-Message-State: AOJu0Yx/GxcCRGwWhIAJBSwOsO5MpOuMHoU2ylujTijmKaFTqU+uvYiy
	9oGT+0oTft4bWa2Vrm6uE3GEcnBqnevAMQmO4iW4zU8KL6rBjJECnuhfJ6qBa9nd+qVYsXVdT9y
	rXA7/qQndXlloNmZqIydNU826nvSj2mEWWHZB
X-Google-Smtp-Source: AGHT+IFDrJ4UOWHw7eb6E44AFhKuYAr1VjOccg30ydUAzQ770g93E+SKdMbs/I0NNZ8zJmUujgBHwL2YqpUlyOixnag=
X-Received: by 2002:a17:903:2346:b0:1fc:548f:6533 with SMTP id
 d9443c01a7336-200947f57bamr2996385ad.3.1723132861330; Thu, 08 Aug 2024
 09:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808054644.1286065-1-irogers@google.com> <20240808054644.1286065-2-irogers@google.com>
 <ZrTXftup0H46R8WK@x1>
In-Reply-To: <ZrTXftup0H46R8WK@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 8 Aug 2024 09:00:49 -0700
Message-ID: <CAP-5=fUq+yNNyg4Xn6aOoEBiXwJfO6CNCz8JhaA2jAxQg+MKKQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf test: Add set of perf record LBR tests
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Anne Macedo <retpolanne@posteo.net>, Changbin Du <changbin.du@huawei.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 7:34=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
[snip]
> -if [ ! -f /sys/devices/cpu/caps/branches ]
> +if [ ! -f /sys/devices/cpu/caps/branches -a ! -f /sys/devices/cpu_core/c=
aps/branches ]

Adding this lgtm, thanks for testing.

Ian
