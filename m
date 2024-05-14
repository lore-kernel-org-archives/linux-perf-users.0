Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B7EA29
	for <linux-perf-users@vger.kernel.org>; Tue, 14 May 2024 00:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715647495; cv=none; b=JVV87WVZHW1CfDkROpgNlGEl3m24hJahnkCAfCTaqaq124M5CVGt//wokEp0/p9Iyy3kPZjnk878Br8XrcPheZlHrqerNpZGl4IqN5l052tc//ju82jSfwYbtqHB4m7Nt4p10F5E65D36E7vu6XxnRAR2LG6NpXQtrDmv/yHRpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715647495; c=relaxed/simple;
	bh=hotnGKFFWEqENC+OuBeDoezU0EopsSKXL0Drl1zpfWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7q6hZYXmnxZU3tViSTGNHYbiwro6mc43phhZvXi05Q7NatcCI1P/iLJc6lzilpawAw8D8v+I0FOGVgQoyvmEVZvQywVi9OUvpV7+YGKneB1LTxm4MtK0ZqK3mLYOM4F/zBBj5C1P8JgueNUvoaPL0HyIntc7lUwWwXmuXqX36g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GY8sk2GU; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GY8sk2GU"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43dfa9a98d2so417301cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 17:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715647492; x=1716252292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6RmozACYy8ltoFttbF2c05dcjbPjMeLrBXKWJdWEQs=;
        b=GY8sk2GUF1MxwkOx9d5q2RMERQhJDNwfa2RZV5f/TaSLjwr+lqlsFXl7i34WfiAu92
         QfL36vtEf5GGYeIJBUYv0zbcEL65OvcB+Im4g9yHO+2vQ1RQpHKDXwfloYDIOCjtDfD2
         zo4XB0EiUuQbViu6MC/FWCvR/WNtRcvaZluQHvROz/lKxCqZ5Stk1ZTZfTpIHVoawrib
         BBP2WxSDOp2lbAe504tIfQQe3nVNEmamSMrid7CdyWkL2ke9ZmMpJ/zt06QRzj/E3WQh
         7AEO0ZSPw+dl1ynPZXVl+rBwDlKzX8fulX4yXnYaKAGJhHgGiTsr2BcFKvatrHaSvQGm
         iVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715647492; x=1716252292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6RmozACYy8ltoFttbF2c05dcjbPjMeLrBXKWJdWEQs=;
        b=LLN330g4Pt970g9Uk6iuQ7/SBzHn70moL/mc8DQ8oA7Bdi8NXgg5PGZkUNqat6fOFN
         XFSBRltphH+FR/I6UDzqaBjWgQ5ISt288NgYy8TbRB9ph1rWylAeycBK+67uLKQlJ2Lc
         dkltGaFDH4CNFIT6KeE/TypaI3sOeqETouEhZMeWKaF88/0tNyBJAc/htSsDNjcVthwI
         yd/nEu9L3kE2NqHtDtID0+yhS8Zgg2z/EqJyZpWsjfIKW5TXXVeRFaDzJCNYuPRFO93e
         ZOATpD5rcDtPEBgzlVUzJ97peCQwkcYYCZH+MQ4lT2uO0X6foya77ivt7bG0VQ9wzPtK
         JuVw==
X-Forwarded-Encrypted: i=1; AJvYcCWFFs0Nn7tLQeuQQnnE0hyaxvObSkc4sUW/Bgw/wtCokoj7oxGL0gE1XBpoLc2n/pOIDr0mTHem7142PeXKqo9Y01TbA4eYNDxdFMpJj54EhQ==
X-Gm-Message-State: AOJu0YwB87XBU+gfWI0Af2jxr/vSCNwyI4OdBxxoY90A35b68BYJ4cA+
	9BXkztSUlCV15jRa//AZo4I9qNzI4+EA/KOe3WCVJ+9pOVxIxJ794s7EGxJA/vxPIQ3mxEDqYKH
	wLsR/Gv1cgUS4Fj9TwETd8nKKEw9MeaNrcB5khRkLvauGJUrUMA==
X-Google-Smtp-Source: AGHT+IFNr4DUzcObxLrqd5Hy13a9Cu8+6IFvv0t+v2kKTE3AbueEhLmbtAk0f5+wF3jlpBQn8ErwjC3VJNPPbIocpho=
X-Received: by 2002:a05:622a:1b1e:b0:43d:eeb1:fd4e with SMTP id
 d75a77b69052e-43e092249fdmr6540261cf.0.1715647492443; Mon, 13 May 2024
 17:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513192439.18473-1-rdunlap@infradead.org>
In-Reply-To: <20240513192439.18473-1-rdunlap@infradead.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 May 2024 17:44:41 -0700
Message-ID: <CAP-5=fX020He2fdmm-tzFY383tSaaOB4q6OBzEtFHgXOW+S00w@mail.gmail.com>
Subject: Re: [PATCH] perf Documentation: clarify sysfs event names characters
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 12:24=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Specify that perf event names in sysfs must not contain mixed lower and
> upper case characters and that they may contain numbers, ".", "_",
> or "-" as well.
>
> Fixes: 785623ee855e ("perf Document: Sysfs event names must be lower or u=
pper case")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: linux-perf-users@vger.kernel.org

Reviewed-by: Ian Rogers <irogers@google.com>

Looks good to me! Thanks,
Ian

> ---
>  Documentation/ABI/testing/sysfs-bus-event_source-devices-events |   10 +=
+++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff -- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events=
 b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> --- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> @@ -37,11 +37,13 @@ Description:        Per-pmu performance monitor
>                 performance monitoring event supported by the <pmu>. The =
name
>                 of the file is the name of the event.
>
> -               As performance monitoring event names are case
> -               insensitive in the perf tool, the perf tool only looks
> -               for lower or upper case event names in sysfs to avoid
> +               As performance monitoring event names are case insensitiv=
e
> +               in the perf tool, the perf tool only looks for all lower
> +               case or all upper case event names in sysfs to avoid
>                 scanning the directory. It is therefore required the
> -               name of the event here is either lower or upper case.
> +               name of the event here is either completely lower or uppe=
r
> +               case, with no mixed-case characters. Numbers, '.', '_', a=
nd
> +               '-' are also allowed.
>
>                 File contents:
>
