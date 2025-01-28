Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872532BAE3;
	Tue, 28 Jan 2025 00:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738024771; cv=none; b=QbGPj/7hkFoX+7+6v5FAf9uVD/2t0A634aNOoZE0CgOkQo6Byb777ngIPI6Y0HFoCH7xLLcPXxTDBp5FSiWXqBBvds2TMoSB5/V0JAwrrVeSQALZn3pbe9FGvQVIQLe7/LGenAy6znNJjFV93Bp+qYo0xKf3gg/DJ6Kx3OC79Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738024771; c=relaxed/simple;
	bh=SWg4M7m7csdoZxz2HThKEi4kzFELmpesoVcb7vFck1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QthOcyi9BvbKGjN8EqS0d1uMP7FG8YA/tzgW4ggES6HCbGnCse7ZO1SowfzGNtLWBxJV7kZW6jIdH6PUZo29evGWK18BMo/wg5qGsoYU9IomJTxI+gCLgf+SJgacxQVWgHk6EKuRVCf9NzxqjYDBiErMKkQQHUcKT2W0TwEwo3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMtQyjCd; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMtQyjCd"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee86a1a92dso7023729a91.1;
        Mon, 27 Jan 2025 16:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738024769; x=1738629569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAgfBMRMuQ31m8XjjfQ9sTmzDan/koQPxudlymQ+wTQ=;
        b=TMtQyjCdb/WTujFTrr1D/jSKeygzqnGIBhAPzmGVlvhR8kIxze7Vj1xcR5XCg6dClc
         9LtggXZ9FSAk1asXisGjnnNgTo1wxFCSt93FFYlhftykEAri4Enwyrlm/iP93BVRXE/Z
         HOZv4B7Wn3zzA26ANU85SwUwN3SODoAvzRF6LrHGzrmoO4iB72iDY9o2utzfdJ+WTVA1
         ZJqdzrO0scsX2M7BJodDoDb4VtE8FEH3llH2sD7gnEg40xGKnNeLUReDRAt7mvXMt7L3
         sbXYG8/+zRFZLcZvlbeHgubWV4uq58U1/3NU7KawNkZY+POBkLg2eEl6PZNqmWp7TVeR
         HQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738024769; x=1738629569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAgfBMRMuQ31m8XjjfQ9sTmzDan/koQPxudlymQ+wTQ=;
        b=DrNgpAMLlLBd5qaL+sxc29BuW30w4SazY51PLYHAVmJgNjIR36WJEnBpWpUW/vudJJ
         3Qe8ST+c4fYfzsHE6tKyQO3uAhiN8gBaXOQYF34jZx9uCaexO6OcQ5lkFeEwolyDBVuB
         0aaQxW0se7cYjwVpdQpBD8rR3PONbnoxm+RvPxexUHaSO0KIVRqQ14AzHBxZGqxlF9Jm
         VFUcLDJ+ZPOh5OS7Qpqn1pWURtfiLBpqUI97PDjaeaQBnghPpt+lHQf9jaZezsRY4CJH
         8qEn9KV8mutNULoGzldf8BUpJdpm8ELAWkiU5JWwOAdj0QGfk23N2Ui6xaJ9/qY550ui
         VY9g==
X-Forwarded-Encrypted: i=1; AJvYcCU7N6TGYUGcB0d90IhJofQuJz4PpsCFujyLM4u6CKLk+3UPR0Oe/PEDxIzNVrgGnTVBF9mMwXUjsNkceivP4fqToA==@vger.kernel.org, AJvYcCV14BNZKto7szTtaltL8oicjRuCDX8FiIQfn8KWWE00QcUJUHwZwFYM2nkumlFVEhs2iliFLGZPw74Fp/sac5Z1ng==@vger.kernel.org, AJvYcCWam6Gp70hSZO1C1A4tv4S3A+tfqW+4EmXKsxCpzrv3b1TDq3Se8RXCUc98hJHvbbZR88HBNDHQ0Gs2VemBGIYrdS1V@vger.kernel.org, AJvYcCXkQfuaMHRD9/TwvtT4HklJ4c1YSR0d5Fr14atq+JNxhox82MXQiWgUAQNHR32M0BA50y06fg6YJEURnK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjdSq0Hna7r2WvDDnyicgrk8WyTWbMWnllHOZQBelFMYPCWfVW
	k1Bvt047O4EijG8ccpwHoprAXsakt00OUN0bYJ0VPXTNXjBSrBv+zranZjMhDV1oq8bFa4zqbBI
	EfhBu3PfQW4rhoELFC8AiJYu2bZQ+tQ==
X-Gm-Gg: ASbGncvFISXvuhi53Zru4k/nmZhF6PBDS64L2rfNSrnqSjo49xat8WrRWEs4RvPNSdI
	Wzzy0idUHmJyPMEbcUSA/kH2hGFfJSbWl8Httjj/1qOaW4i6HWOD22iuvpmrlCq4EqBnJVB/7tJ
	F+DQ==
X-Google-Smtp-Source: AGHT+IFOUWw1pJ0UIe8pJHggBCsjyzILnFVDhkL5d5OHgqcRAb7naTuv3JBUOHml1GEKrVcZwBN7EUv01ay8z3USgzU=
X-Received: by 2002:a05:6a00:4615:b0:72d:9ec5:928 with SMTP id
 d2e1a72fcca58-72dafae8f21mr56702980b3a.22.1738024768755; Mon, 27 Jan 2025
 16:39:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737511963.git.jpoimboe@kernel.org> <73229250c0279667f617c3d6da121c6621164e4d.1737511963.git.jpoimboe@kernel.org>
 <CAEf4BzYLqmhb11F8X96Ac03YErf2WrHq8D5EA_f-488ij9-jnw@mail.gmail.com> <20250124220045.hduc3az4neoutebq@jpoimboe>
In-Reply-To: <20250124220045.hduc3az4neoutebq@jpoimboe>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jan 2025 16:39:15 -0800
X-Gm-Features: AWEUYZmBlptNN8TiQpmdjuh5N0qs7Edt8J66vOT8wyHaN5K1gVC6sXvN8bwWlrU
Message-ID: <CAEf4BzZXE8boqkjt38=BYUWCJd_bomdcjx2CGX=LPfc59xzz2w@mail.gmail.com>
Subject: Re: [PATCH v4 32/39] perf: Remove get_perf_callchain() 'crosstask' argument
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	Indu Bhagat <indu.bhagat@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, 
	Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org, 
	Jens Remus <jremus@linux.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Weinan Liu <wnliu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 2:00=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org=
> wrote:
>
> On Fri, Jan 24, 2025 at 10:13:23AM -0800, Andrii Nakryiko wrote:
> > On Tue, Jan 21, 2025 at 6:32=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel=
.org> wrote:
> > > @@ -430,10 +429,8 @@ static long __bpf_get_stack(struct pt_regs *regs=
, struct task_struct *task,
> > >         if (task && user && !user_mode(regs))
> > >                 goto err_fault;
> > >
> > > -       /* get_perf_callchain does not support crosstask user stack w=
alking
> > > -        * but returns an empty stack instead of NULL.
> > > -        */
> > > -       if (crosstask && user) {
> > > +       /* get_perf_callchain() does not support crosstask stack walk=
ing */
> > > +       if (crosstask) {
> >
> > crosstask stack trace is supported for kernel stack traces (see
> > get_callchain_entry_for_task() call), so this is breaking that case
>
> Oh I see, thanks.
>
> BTW, that seems dubious, does it do anything to ensure the task isn't
> running?   Otherwise the unwind is going to be a wild ride.

Yeah, I think it's very speculative and doesn't pause the task in any
way (just makes sure it doesn't go away). We just rely on
stack_trace_save_tsk() -> arch_stack_walk(), which just optimistically
tries to unwind, it seems.

It's still useful and if the user is prepared to handle a potentially
garbage stack trace, why not. People do similar thing for user space
stack trace (with custom BPF code), and it's very useful (even if not
"reliable" by any means).


>
> --
> Josh
