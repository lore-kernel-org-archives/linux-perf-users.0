Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D81156F3B
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jan 2025 05:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736920774; cv=none; b=bmUUSilOOPOFJTElNsKx4Kmit31Om1ATla9k0dXPM8rZ3vHWCuFdhq654lbRgS73rPlHBUNEZeQH4wFFNdDg7LhmUXM/EfG5HNQpBOrqeOU+sYoRM6G+QA0gDDiA3y5VxfbKFMfRRQb50VhrhhxCK4gI7RCp4/A6SUHCWkpfRlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736920774; c=relaxed/simple;
	bh=rlVqFqt5b5PbBK+sPSd5LvYCW3B7SEKmkHalOkDKcKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rT3a4Xc0oKR1jBBtZ9Vrhnih0iu255iYIcWNRPSBPmGNKpb3G9o/jjf6XSMyhFKejOFVg+I8VdR+SCXDwrioVyCbc2hGDKlOjNbVtiz1nA2c6afz2V4fLEW5rYQu5zkuvoVhTeP+Z8KtHOaD7JDEvgfH0Ty8T1OdvQPiIAATU3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XWSTtxSy; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XWSTtxSy"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3ce82195aa0so112335ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 21:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736920772; x=1737525572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlVqFqt5b5PbBK+sPSd5LvYCW3B7SEKmkHalOkDKcKM=;
        b=XWSTtxSyqZ7BM8ds25MMfnA3kL2E/zWBNYdlXw96nB+GRbgkqkKDqk0ydQHfmol2dd
         /6CqeeBzUrYGZ17OAX6XUjvZw4SU0+YX+icaY1P/Ql+sbziuipuU0mM0Za87E7VoboVN
         7MrT876q53QZe/DPU4i6OdPMKCthFnuHVUsFIxM/yRolYCi4f5L7x97JvpW/ucBTcE3s
         ZiijT5z1VswD2wDCbcU/hHSeOwMiaINC5LzkXY5ao9aB5DVyy39dpwOSlVIKDmIFnBWh
         IkUmYCmRsm7VwKBd7YlIykaXwCUqtjzcjp+zv7ylhiv07ck7tUApUFTbxavpUYIJwClu
         fE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736920772; x=1737525572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlVqFqt5b5PbBK+sPSd5LvYCW3B7SEKmkHalOkDKcKM=;
        b=th+8MNTOVFCeREDg/LujfWqJYME208srSdZAsFH23oPKZkO74CplRX55fUwTyWkGCP
         XyA8qM+Z6qIMf1HZWoPCyxvI7Z07kB5vp28glX0CFQdFsnJ8jYqzp54Pg7qutEc7agmx
         UL/OK9zTyALk7PeBtTk/cQnYjNuJIoXRWdpwh1Og5WmoLNUMtMDP7lM5eIprUsVOU5j1
         4Csq0u6deuhPKr0NnSTL/ztrUmMlE6Ph7S/+qCj/iXsGLNnGemgxDcIuBugmAfRlhfhh
         4O6pWkDmDn500cPms6U3vh6G+0xFT0yzO9qPwlbq4FAoXHIrVAoFVT/V9taDOFsBYXaG
         hbUw==
X-Forwarded-Encrypted: i=1; AJvYcCXpJdJKf5ESMo3XQ0iH4ytk1w7Rpar+Qzuws19BU0omzvTK5Rfj4dcdJXhi8W8FAseOtTAxj22H/9BbJqNgg1yJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxT6JKLD329dwSMddDbCmdMIsqXGqPr/vGTYWRyNwoNSBTLBkAw
	rPK9TD4A0xO6x9ez4Z35ZaCqRZ9gG4RHhST9tUUxmm72jNJAnZ8FvorSt+LQ40PrH2avQY2KwMy
	1HMyJEyz03avHbYADty+8s1B06P/UgFp8I2hz
X-Gm-Gg: ASbGncu+upfugO3G7NiFUsNW1O72pCQnxrxt+/hP0JOPLk9CnenJ9suXl40Goh896jn
	z0DLDyybH2hAGATZl9BccMu0kmyDTOX74ALBMUDs=
X-Google-Smtp-Source: AGHT+IHBg1ajtFILhg3PDaii2Pqov0rFvX3gYQwJ51SbACz+bbRTQzxLlrEUlksbOTiP+aNRiGyUubVx0wAvBNAc0rI=
X-Received: by 2002:a05:6e02:2198:b0:3a7:e04b:1fe2 with SMTP id
 e9e14a558f8ab-3ce85f28f4emr1418955ab.7.1736920771585; Tue, 14 Jan 2025
 21:59:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACT4Y+b4WYa9TSqKtDKTJNgXth1U30=KddutfSdp5gmXVOV_jA@mail.gmail.com>
 <20250113134022.2545894-1-dvyukov@google.com> <Z4XDJyvjiie3howF@google.com> <CACT4Y+b96xynNaZoBHP72-4tJM5Nzo3MBRW19_E7JsMKRWYCzg@mail.gmail.com>
In-Reply-To: <CACT4Y+b96xynNaZoBHP72-4tJM5Nzo3MBRW19_E7JsMKRWYCzg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 14 Jan 2025 21:59:20 -0800
X-Gm-Features: AbW1kvZdm7AP-s9xOaEKatTh_GbirwkvheheaxCx1sSWP2rb60_neJEATYmd7gg
Message-ID: <CAP-5=fWHivx7Q6okMwYOs=65MZr40RjE16tgatMX0hjkCfrwfw@mail.gmail.com>
Subject: Re: [PATCH v2] perf report: Add wall-clock and parallelism profiling
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eranian@google.com, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	chu howard <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 12:27=E2=80=AFAM Dmitry Vyukov <dvyukov@google.com>=
 wrote:
[snip]
> FWIW I've also considered and started implementing a different
> approach where the kernel would count parallelism level for each
> context and write it out with samples:
> https://github.com/dvyukov/linux/commit/56ee1f638ac1597a800a30025f711ab49=
6c1a9f2
> Then sched_in/out would need to do atomic inc/dec on a global counter.
> Not sure how hard it is to make all corner cases work there, I dropped
> it half way b/c the perf record post-processing looked like a better
> approach.

Nice. Just to focus on this point and go off on something of a
tangent. I worry a little about perf_event_sample_format where we've
used 25 out of the 64 bits of sample_type. Perhaps there will be a
sample_type2 in the future. For the code and data page size it seems
the same information could come from mmap events. You have a similar
issue. I was thinking of another similar issue, adding information
about the number of dirty pages in a VMA. I wonder if there is a
better way to organize these things, rather than just keep using up
bits in the perf_event_sample_format. For example, we could have a
code page size software event that when in a leader sampling group
with a hardware event with a sample IP provides the code page size
information of the leader event's sample IP. We have loads of space in
the types and config values to have an endless number of such events
and maybe the value could be generated by a BPF program for yet more
flexibility. What these events would mean without a leader sample
event I'm not sure.

Wrt wall clock time, Howard Chu has done some work advancing off-CPU
sampling. Wall clock time being off CPU plus on CPU. We need to do
something to move forward the default flags/options for perf record,
for example, we don't enable build ID mmap events by default causing
the whole perf.data file to be scanned looking to add build ID events
for the dsos with samples in them. One option that could be a default
could be off-CPU profiling, and when permissions deny the BPF approach
we can fallback on using events. If these events are there by default
then it makes sense to hook them up in perf report.

Wrt perf report, I keep trying to push the python support in perf
forward. These unmerged changes show an event being parsed, and ring
buffer based sampling in a reasonably small number of lines of code in
a way not dissimilar to a perf command line:
https://lore.kernel.org/lkml/20250109075108.7651-12-irogers@google.com/
Building a better UI on top of this in python means there are some
reasonable frameworks that can be leveraged, I particularly like the
look of textual:
https://github.com/textualize/textual-demo
which imo would move things a lot further forward than UI stuff in C
and slang/stdio.

Sorry for all this tangential stuff, I like the work and will try to
delve into specifics later.

Thanks,
Ian
