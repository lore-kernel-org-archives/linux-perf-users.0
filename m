Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BDE15CD7D;
	Mon, 19 Aug 2024 20:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724098436; cv=none; b=j3c9PP6vGkHHE3kHZzVdvKeU6V73TiF1elYe+HRgllT/Ucf+Ga4/JVKF62nRDpsYcQ4j/ftPg3OyT6deWQLOvdWnFxzktlE/lHd47fgMjGU5w045MyVczxG/C5LdHBzkB0Ay/w5AxYl+/ZOG17o2qKFrWScl7cgbUB7SvHhNi20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724098436; c=relaxed/simple;
	bh=M9uXg93L5yDIbs1p1UszwZ5/EDy/jp0lYk/y50EU13M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+a95ROnl2eAOZ+ucdouNRz5lFa8Lyg9T/uEwjP8fsE2hx3R9GcRwcLCmRq/Hq9Xq4I3qcSG/aJJRXqjNbNUkH9i3HbDXT3CYyQrRHHUCH7uORIjs3GJ0g4GrgfH+a4xJaJgB5fCVEEZsw9M7wPQxIb1CuKBAvapufP9rMc7Qqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7c3ebba7fbbso3702176a12.1;
        Mon, 19 Aug 2024 13:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724098434; x=1724703234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVLAp+x08r3C0Oaaue1WkB4sZ342wBkS+4HWzyJIOPU=;
        b=Vrxtux413WfZBsK4pejA3ooCCu6T4A4KKZjubS6qviIjs7m8QaV73Pcnhyc9BArowR
         iRL1jlYtklpmA5+e8h58diu3yQ7qRuTV5XVQYm/IkCJOyT6r8zVgC9zwl5dNmw8oy3B4
         F21kr3h5Tphzquw77w7TVU+l/dBUIXsnB0PRYZ34yknwrU/ZspYUg4gRLgHjntSkyjKT
         Ch+1LQD/A8aV4GrQi5yKIqaMkRY/sBDHQOMl1WXFbia86NiQT8awMZfLv/HVfo7ulntC
         7LAHfrLAv5kzoc/jA50IVMgEkvjvD24CdRT4z71Wfz18Q91MPq6ycOpU8xj8w6kq4Iqa
         US6w==
X-Forwarded-Encrypted: i=1; AJvYcCV2jdzJzWAV4kkZNRjleZh4viGZk7UEFAtm9cKqzBQFdqZZbiyJTZyYXwvzc6ZoaAyF+sq2+V+kIRGRIHTMcUNX1A==@vger.kernel.org, AJvYcCWIa1w1dlMtpCUvbzmpk3S+iiM/CVnuiVsFZpKa6+7QctldsorTVYiEgL6IfTU/fp6eQrXu1wOsBEbUd7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgIgRtlxAyruU41UI1MTM6tR/MKy3o7Vzo3n7BUw26IcoWGc3V
	O2Shh0/8yqTT7Bj6CS7mATSmf9bJMALlQEh2SsgeXNCDyYPSHdrgmE5I03RDd5MA0gDqV8AwXnr
	uPJfEFXrrhiEamkTTtNkP5W5dFxY=
X-Google-Smtp-Source: AGHT+IGAhWI+IerFVi2+pOAA1I38csOzhRWzqnh3ZofL9A3cbKLdN5ZVPDphyrwf7ldy4qiZ4v1E1ZiZd3kBCFlw9PU=
X-Received: by 2002:a17:90a:f289:b0:2d3:cc31:5fdc with SMTP id
 98e67ed59e1d1-2d3dfc1f58dmr13399880a91.5.1724098434395; Mon, 19 Aug 2024
 13:13:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819033016.2427235-1-yangjihong@bytedance.com>
In-Reply-To: <20240819033016.2427235-1-yangjihong@bytedance.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 19 Aug 2024 13:13:43 -0700
Message-ID: <CAM9d7cjAVXAqDrT72vjpZvfccaGAZnw_jie5Qz5yX5vSfVWRMw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] perf sched timehist: Add --show-prio & --prio option
To: Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	james.clark@arm.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 8:30=E2=80=AFPM Yang Jihong <yangjihong@bytedance.c=
om> wrote:
>
> This patch set adds --show-prio and --prio to show and filter task priori=
ties.
> Sometimes may only be interested in the scheduling of certain tasks
> (such as RT tasks). Support for analyzing events of tasks with given prio=
rity(ies)
> only.
>
> Both options are disabled by default, consistent with the original behavi=
or.
>
> Changes since v1:
>  - Rebase based on the latest perf-tools-next branch.
>  - Enhance documentation's --prio entry, add a description of how to use =
multiple priorities. (suggested-by Namhyung)
>
> Yang Jihong (2):
>   perf sched timehist: Add --show-prio option
>   perf sched timehist: Add --prio option

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
>  tools/perf/Documentation/perf-sched.txt |   9 ++
>  tools/perf/builtin-sched.c              | 163 +++++++++++++++++++++++-
>  2 files changed, 165 insertions(+), 7 deletions(-)
>
> --
> 2.25.1
>
