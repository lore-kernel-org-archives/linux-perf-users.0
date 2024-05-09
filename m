Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF391494B4;
	Thu,  9 May 2024 05:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715231303; cv=none; b=DS36HP3dghJwLOVfZsfHZje+x3yxUc+sl6jm0GSNQBBACkc0NndkE9bi7eMbT6qEe9IjWsBLN29Ub/q0Tc4IceBi/A6uvOszWhVvVm1odgcUi/kBnYRPYooMLsYRI2J2FTze0YNnpVJZeymKBj2NSOI5xP83m9xhHjgynxXqJfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715231303; c=relaxed/simple;
	bh=YZYM2CEf8uF3eNWleBd8V23QDnmsujeg+l05B7XGpos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEpHdYfVhLHY2S413cFitaoSFcWWmr2t+/fhcAXnKC+iHlmlXK2YDyza69w9RbORwmnhet94uferbglhkgishiXFzmjq7LIxF1juGF9jCsGAtPTmKcMECZ16ZyciemhvKb8mSkaAfvtLSrOb9Afjw7zQIFLwp3LyEBVBCpQUMF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f453d2c5a1so484456b3a.2;
        Wed, 08 May 2024 22:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715231301; x=1715836101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwMe+/sDHvAVGtTIX3MapIIEfVLTv/14jv9BLJ1rN/g=;
        b=fIK4A+tg0L+o7FTBy86+r9UE39wNtbCZ7gMdON+nxylFz3jjIDaaEJqJzY2w/FcAgl
         lWeHbkBPxoHHOyPFCfLEAeScaUJZz43F29KI1mV0AIg+T6JmTX5dutN1eMwjNQRAYlNC
         +PVlTXBs8pVNv9vNqGAabR+XLyJtQOioXnsWuZ5IC9QjMqF1KaPQ1Ntm/KzHqrQh21Ky
         BQzwqFySDd1DZT99nGcaCFMPRURo98601HChpwfispKLO0VYmsI5siCQquv5o4r3bBdP
         QHo3L2Nkz/CXK6gVp6xHXJLth9mX5URS3TLkcdYtj7Q3dkuyTSqCdiFz/M/KND0EWS+N
         OGFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT75mwEcBl0iXkSfke+0ivJaYA0QD0sPmKxisWPYkQCKEctAGnlr8GHZ4KFs/mAcVowpilarc692zDRyCSsYiZAGbfIjnj60FBGvKvF7TgKwrX5dOZH3FxQ7XOSDyyEr72QTEIlpfONQMNxYkAxA==
X-Gm-Message-State: AOJu0Yxpc85qaRmMeQ6X9hrF/L4G/Y/ZF6ZFAWpfEC+RNF8uJtENl4S5
	g6ANgwEgG7OBF6khZYWaNYbnx3sMUlGOGzHjIP7k5fcOBanc4OO9OKO45p8/n5H6/ggxMAaoEsS
	uTHIcCHWF9oXuzpe285JcIADAuvQ=
X-Google-Smtp-Source: AGHT+IFqm2U3yXtg/ZYc5/6d6UOHoDN7bEJnNOA970nvjSewNnc5HjBRr7m++V9HmQFJfrHNC9mngcmYUma/XowNJJc=
X-Received: by 2002:a05:6a21:a108:b0:1a7:60d8:a6dd with SMTP id
 adf61e73a8af0-1afc8dc8605mr5316420637.53.1715231301105; Wed, 08 May 2024
 22:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508060427.417-1-ravi.bangoria@amd.com>
In-Reply-To: <20240508060427.417-1-ravi.bangoria@amd.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 8 May 2024 22:08:09 -0700
Message-ID: <CAM9d7cgFKcHXeTXxax7GRCK__0U3HUnG3Ls09GpnD8FipyJk1A@mail.gmail.com>
Subject: Re: [RFC 0/4] perf sched: Introduce schedstat tool
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	irogers@google.com, swapnil.sapkal@amd.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, rostedt@goodmis.org, 
	vincent.guittot@linaro.org, bristot@redhat.com, adrian.hunter@intel.com, 
	james.clark@arm.com, kan.liang@linux.intel.com, gautham.shenoy@amd.com, 
	kprateek.nayak@amd.com, juri.lelli@redhat.com, yangjihong@bytedance.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	santosh.shukla@amd.com, ananth.narayan@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ravi,

On Tue, May 7, 2024 at 11:05=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> MOTIVATION
> ----------
>
> Existing `perf sched` is quite exhaustive and provides lot of insights
> into scheduler behavior but it quickly becomes impractical to use for
> long running or scheduler intensive workload. For ex, `perf sched record`
> has ~7.77% overhead on hackbench (with 25 groups each running 700K loops
> on a 2-socket 128 Cores 256 Threads 3rd Generation EPYC Server), and it
> generates huge 56G perf.data for which perf takes ~137 mins to prepare
> and write it to disk [1].

Right, this is painful.

>
> Unlike `perf sched record`, which hooks onto set of scheduler tracepoints
> and generates samples on a tracepoint hit, `perf sched schedstat record`
> takes snapshot of the /proc/schedstat file before and after the workload,
> i.e. there is zero interference on workload run. Also, it takes very
> minimal time to parse /proc/schedstat, convert it into perf samples and
> save those samples into perf.data file. Result perf.data file is much
> smaller. So, overall `perf sched schedstat record` is much more light-
> weight compare to `perf sched record`.

Nice work!

>
> We, internally at AMD, have been using this (a variant of this, known as
> "sched-scoreboard"[2]) and found it to be very useful to analyse impact
> of any scheduler code changes[3][4].
>
> Please note that, this is not a replacement of perf sched record/report.
> The intended users of the new tool are scheduler developers, not regular
> users.

Great, I think it's very useful.

>
> USAGE
> -----
>
>   # perf sched schedstat record
>   # perf sched schedstat report

Hmm. I think we can remove the duplication in 'sched'. :)
Given you are thinking of taskstat, how about making it
'cpustat' instead?

Also I think it'd be easier if you also provide 'live' mode so that
users can skip record + report steps and run the workload
directly like uftrace does. :)

Something like this

  # perf sched cpustat  myworkload
  (result here ...)

Thanks,
Namhyung

>
> Note: Although perf schedstat tool supports workload profiling syntax
> (i.e. -- <workload> ), the recorded profile is still systemwide since
> the /proc/schedstat is a systemwide file.
