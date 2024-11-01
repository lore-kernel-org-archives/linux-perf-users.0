Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7E413B7A3;
	Fri,  1 Nov 2024 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484361; cv=none; b=rvGCnQYhmd/74/WQnI/MnczTbDYwqyXaB/Xy+Cr2ZgjjrXQ9r5emYc17i40y4GmzfEp8r4pA2p1cH8/klqYl3n2zoSTCuehp0KY55vra8O4QQVjtelDw7CNqac/r5yHGN2XHMZe1iWmRSjN+AtZuZyqgNStn3PnJ/y0tlPyFJYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484361; c=relaxed/simple;
	bh=CZLlXdBbIDY8h5RsqUNyq0Wx7XCP97oTJn4ahgLhtoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UznvMLWfjszQLI7no5kqzBvs78b8TPZmdg7E/mAItTGV+XaSWTjonh0bpe6lFrAUSjKW9sjBEt6zjB8Wcaj/NpuCopyupGr+txQ3P52zr4ROxU6VfTGfEKzKT3Spp5Yq0ahy+klzR2iFOK3pam4xS+3DWyo1NzjJdS8EnqWJcNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaTcdR1+; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaTcdR1+"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2ad9825a7so1710409a91.0;
        Fri, 01 Nov 2024 11:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730484360; x=1731089160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZLlXdBbIDY8h5RsqUNyq0Wx7XCP97oTJn4ahgLhtoI=;
        b=WaTcdR1+Lyp0KiqD/VjzQZpHZbP6IyvqpxQK1My0pUc0mT+6EugPiRu/owg5GsWvT/
         oMErS5jH1i6Q41Oo6TbdbKmOSTitRk3MMUsUJSg2Y3M9QME4khVsKkddzdlDf8Y66sZk
         IS2UsZM4K7oz3n1sogE46V1YP5TzVyFfCpxjzMQklmsv291V3JW+FwOrXcZ8X2l887CJ
         3ueJtYu0iluIUD4m2zmt+eoZ+8sIBS/V4RTjymH6zN3yHPqvNrzXXK4VxWIEDjA8rFdf
         SdO51LdtJat+Iro3bghNnUAbICCKi4pmiXjI3PsEKG1zR6QRqXVr1jtG7Jfqxn8r/jjJ
         1SIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730484360; x=1731089160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZLlXdBbIDY8h5RsqUNyq0Wx7XCP97oTJn4ahgLhtoI=;
        b=IgKk7njZQyAZQ8a2K+FWv16Q3SpluA4I7WTfaXdWB2DdUp/u6RNrpc5+CxCgPFiHeJ
         LXnS57abRjb5r7Jt3TjL7Zpb8JecpxSZ01543CSOuoHHbxtl1BVMjoJVrdujrG+TfrEM
         TEzBX4HXUttvV3Baozlen7dUB+mMKGB+m6AEb434u8+h5+k7AuSCBX4EX7ok9swqBnWt
         JVbivVTfaRraZF48sQXS6/fo+EgXpc3EM1tEHIdMqfqSHdliV0iSuAIbbjjrJXgUeA2j
         ipensJHRtwBDkmbH8U1UaMpNBEWKzeU27x0rNCwYFJ2aigbAfYu87G0ETdoTD48vZ06A
         a9Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVNEe79MIRvSYXgsNxMT5gjJhhIPFVpQjsXKQv3oiReyS+EasLg4G82rOBHBGyZge1/cxqvsu6HD31ok9ZinEDL7Q==@vger.kernel.org, AJvYcCVievtgQcjLi5r+nDpxKr60llwtCZBKZqW4BqY/oMQgeJN2rkU9MAoZ4UQSLrWCJo09mr6iBsHnULGrOsI=@vger.kernel.org, AJvYcCWMB0vNgU2KygDyO1wcPskJltpS3K+DOJxhOmAOlBtZJC6w15QQg3EweVLchT7YRQtt4EsgLlHwyFzLik3ViTHgDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj2ckd9ka2naMtuyQEC1XcYYJz5KU6tqqFAH6A3A//Nzff1G92
	nd5602tUL1tNtyc+lyGz+Z+TK/N5/xb28mQq0HMJG8H2OWqCswUzuTEXTnYqohpPf3wwCoc/nmY
	aQSMcTjG8vQREAJoTIgVJXJ7ev3Q=
X-Google-Smtp-Source: AGHT+IHXFd4v8n1IslBh0Yu0NspCzbBAKSE2UgMHzD8/lXtUpb9I/huSrX/AqdUys1/uF/QUQmCS0KqQciYZBEu7Czk=
X-Received: by 2002:a17:90a:9a8c:b0:2c9:9658:d704 with SMTP id
 98e67ed59e1d1-2e8f11dcf62mr21331111a91.40.1730484359699; Fri, 01 Nov 2024
 11:05:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730150953.git.jpoimboe@kernel.org> <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
 <CAEf4BzY3xJ=W2qPD8i6UbSB=zNqpiA1gSd+SC3wKxQAJWjeHhA@mail.gmail.com>
 <20241030061043.eo2vuqgsoqmjytjr@treble.attlocal.net> <CAEf4BzYd5OT9COBS4va435jqMzkjvvAHbe55AR6giv8pitUvAg@mail.gmail.com>
 <20241031231320.h2hwns367e5byvyy@jpoimboe> <CAEf4BzZksT=GTs268KBiCsYxUcvWz5KUghjKQQR8OxGdoBt=6A@mail.gmail.com>
 <20241101174119.qso5fdln2chdflav@jpoimboe>
In-Reply-To: <20241101174119.qso5fdln2chdflav@jpoimboe>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Nov 2024 11:05:47 -0700
Message-ID: <CAEf4BzYCwvm0PTpoB7L5xKMaFTVUqNo8VuMHy7sRwpc4opXJzw@mail.gmail.com>
Subject: Re: [PATCH v3 11/19] unwind: Add deferred user space unwinding API
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	Indu Bhagat <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, 
	Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org, 
	Jens Remus <jremus@linux.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 10:41=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Thu, Oct 31, 2024 at 04:28:08PM -0700, Andrii Nakryiko wrote:
> > So all task_structs on the system using 104 bytes more, *permanently*
>
> Either way it's permanent, we don't know when to free it until the task
> struct is freed...
>

I'm not sure if we are arguing for the sake of arguing at this point
:) Yes, for *those tasks* for which we at least once requested stack
trace, that memory will stay, sure. But there are normally tons of
threads that are almost completely idle and/or use so little CPU, that
they won't ever be caught in the profiler, so their stack trace will
never be requested.

Sure, you can come up with a use case where you'll just go over each
task and ask for stack trace for each of them, but that's not a common
case.

So, sorry, but no, I don't agree that these are equivalent things.
Lazy memory allocation is a must, IMO.

> > and *unconditionally*, is not a concern
>
> Of course it's a concern, that's why we're looking for something
> better...
>
> > but lazy GFP_ATOMIC allocation when you actually need it is?
>
> We don't want to dip into the GFP_ATOMIC emergency reserves, those are
> kept for more important things.
>
> Actually, I think I can just use GFP_NOWAIT here.

Whatever semantics works for being called from NMI (even if it can fail).

>
> --
> Josh
