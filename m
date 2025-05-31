Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EBA610D;
	Sat, 31 May 2025 00:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748649651; cv=none; b=TUp/5A6lTdfGaK4ERIWLEcH/DDCibRXnYg16hLxllOxAMYQZ7XRvLxidTalfbuGefQtkr2aszfnu9bUY+CCMnVEVE6QUeMKlbUDxJdB4zfy57HTT4LxcWmrOK06ZBbx1e++FhBfQlxxbxOBlI+9OOSb+xtvPneDKfwYrwZJtq04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748649651; c=relaxed/simple;
	bh=cIU4rJEV3PzYfeAvMqrDFhPSSw49dpItRym8Lmw7BVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YESixz7PaL/a9/5h1hR1eG0PR0jXdUVy537Nve8c+41Z+BfWH11VPe+UI4yWzdjVYRSJNwhReOU2Ra5L20wyIOFAmAiACwB91E/U9KE0Ny3swOYPFk68cxuXiCGuFZ57ZTKRjRKylSKoUkVHClu4E7asMtHDuG06kZIIka/rpVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MB+139uo; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MB+139uo"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70e5e6ab7b8so24452957b3.1;
        Fri, 30 May 2025 17:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748649649; x=1749254449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPJb86Hq4WNDSKvt4LG+mezjyW3VTAGngdOKgYawd4E=;
        b=MB+139uo8ofSIMpwsNQhWaOLeMmTN8c9ItalTKNzKhcKsu813pAVIcQ2mEEgR2o1z9
         k8CgOL95kcjOPhAyBH45t/qf9OEZJglTS3Rey6B8W7V/WHw1j1uu+xYBD/qSI4pD7rHj
         e4s2RKfcYv6JFCSKdQnNqH8RxEvPPgsUMpNPSF47JPZKwO6YOk/qg+vtN8DXe1V10HUv
         9jfYWoJFRGXI3dRlPs8Mzp3WNAxQfErkFP5dZeHxnO6WeXHEBLMzESqGUG9my/LQKxj/
         RmZxTZysyci23Lq5hhi1UOhXNw9Rcc9esQPJkxyFjQHqYaFocECp+55cRIR6sbbjutmT
         FYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748649649; x=1749254449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPJb86Hq4WNDSKvt4LG+mezjyW3VTAGngdOKgYawd4E=;
        b=tPLnBnKC57Lb1t5M5pUCjLi+XHwNq/mMnzIf/fkeSSsGDGsN18ZZQ+ZqqCa1PW2nI3
         NWJJeW24OE2EUzlG10rk7rQXwSe2Nt6c8uDxKfGw0lSGkb7N4BqJbOQVI8XG9xf4LD1P
         c0OXLBLJb7ySO7em4JAyVjDcw2bZdG6wHST1DT3wC6l7cTy5/dfu+sb5MvyvIUXdFAyW
         0KSBXrUyzmHLB6pKC61olyqbHhGZ+lh6g6mrhDhEbBlInIw3sdg4ZI8Jrzhw2Y7gFWsc
         S8eg4gYG9SpD04lpvSX1MlwjEc4XYEJtHMg+iCnRKI2Svg/bN+di797o2VQE4xn+iRYp
         +TOw==
X-Forwarded-Encrypted: i=1; AJvYcCVSBhW9Jfh+S0QsrIs6g9ANAF2LarjPOsj39XdBMKYOiBEsf5gEBr+NvNczq5Fsu7OPi5Y0Yaa+fVZVJA+XL9ePTw==@vger.kernel.org, AJvYcCXG2v+SLpmmCZdnmhMlEgB9oaXimk9d98X2JlHuVA5XOiTx0geL9Jy91+dpRsD+FFYWfI0rdrnCGOtKbmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/oQVOp7vpD9BsJ888/0yQt4ab+Rf51ZmTQBqNnIdmK9wqnMJq
	AVwTTXXzB3KysN1bJABAhX4X28V23RNoolhaGfbNxyDybgW0in24wvr1evsxfQoH/Xy7zXU4ibn
	04tfGTrPsv76Vtt7F67Yq3ik9fV85yfg=
X-Gm-Gg: ASbGncvE2g17VJdY15Hgxy3Y1cqWDtki0aygsEhZnynVfMDzh5X8PEeRxA1BRiDBpNJ
	y6ugCegSk10sZObBf1TLQDi70HHAFbAk1S8z97QrNjNUtr3GVkaTsPyJiLCzvPsYSXubMeF91YU
	0oU8e4c5cZCciY23jRxEoi9nqDrn2iFOW/1CdZdEEJsQ==
X-Google-Smtp-Source: AGHT+IEPyuLhSLHkXG6WJzCAeyG/vrZUuV9j9e4k4Y81H5Z0PDz8DOepANj0Ak33uPiNDbMk60z4rZx65swrJndifNU=
X-Received: by 2002:a05:690c:c0b:b0:70e:2a04:c768 with SMTP id
 00721157ae682-70f97e9b96cmr78339537b3.14.1748649648856; Fri, 30 May 2025
 17:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529065537.529937-1-howardchu95@gmail.com> <aDpBTLoeOJ3NAw_-@google.com>
In-Reply-To: <aDpBTLoeOJ3NAw_-@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 30 May 2025 17:00:38 -0700
X-Gm-Features: AX0GCFsCmdUxSSdrpaZTMmTf7Dx-dvC86JWXGqYw0M3vC6ZjScciY6SKcijK2Lc
Message-ID: <CAH0uvojGoLX6mpK9wA1cw-EO-y_fUmdndAU8eZ1pa70Lc_rvvw@mail.gmail.com>
Subject: Re: [RFC PATCH v1] perf trace: Mitigate failures in parallel perf
 trace instances
To: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, acme@kernel.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	peterz@infradead.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Fri, May 30, 2025 at 4:37=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> (Adding tracing folks)

(That's so convenient wow)

>
> On Wed, May 28, 2025 at 11:55:36PM -0700, Howard Chu wrote:
> > perf trace utilizes the tracepoint utility, the only filter in perf
> > trace is a filter on syscall type. For example, if perf traces only
> > openat, then it filters all the other syscalls, such as readlinkat,
> > readv, etc.
> >
> > This filtering is flawed. Consider this case: two perf trace
> > instances are running at the same time, trace instance A tracing
> > readlinkat, trace instance B tracing openat. When an openat syscall
> > enters, it triggers both BPF programs (sys_enter) in both perf trace
> > instances, these kernel functions will be executed:
> >
> > perf_syscall_enter
> >   perf_call_bpf_enter
> >     trace_call_bpf
> >       bpf_prog_run_array
> >
> > In bpf_prog_run_array:
> > ~~~
> > while ((prog =3D READ_ONCE(item->prog))) {
> >       run_ctx.bpf_cookie =3D item->bpf_cookie;
> >       ret &=3D run_prog(prog, ctx);
> >       item++;
> > }
> > ~~~
> >
> > I'm not a BPF expert, but by tinkering I found that if one of the BPF
> > programs returns 0, there will be no tracepoint sample. That is,
> >
> > (Is there a sample?) =3D ProgRetA & ProgRetB & ProgRetC
> >
> > Where ProgRetA is the return value of one of the BPF programs in the BP=
F
> > program array.
> >
> > Go back to the case, when two perf trace instances are tracing two
> > different syscalls, again, A is tracing readlinkat, B is tracing openat=
,
> > when an openat syscall enters, it triggers the sys_enter program in
> > instance A, call it ProgA, and the sys_enter program in instance B,
> > ProgB, now ProgA will return 0 because ProgA cares about readlinkat onl=
y,
> > even though ProgB returns 1; (Is there a sample?) =3D ProgRetA (0) &
> > ProgRetB (1) =3D 0. So there won't be a tracepoint sample in B's output=
,
> > when there really should be one.
>
> Sounds like a bug.  I think it should run bpf programs attached to the
> current perf_event only.  Isn't it the case for tracepoint + perf + bpf?

I really can't answer that question.

>
> >
> > I also want to point out that openat and readlinkat have augmented
> > output, so my example might not be accurate, but it does explain the
> > current perf-trace-in-parallel dilemma.
> >
> > Now for augmented output, it is different. When it calls
> > bpf_perf_event_output, there is a sample. There won't be no ProgRetA &
> > ProgRetB... thing. So I will send another RFC patch to enable
> > parallelism using this feature. Also, augmented_output creates a sample
> > on it's own, so returning 1 will create a duplicated sample, when
> > augmented, just return 0 instead.
>
> Yes, it's bpf-output and tracepoint respectively.  Maybe we should
> always return 1 not to drop syscalls unintentionally and perf can
> discard duplicated samples.

I like this.

>
> Another approach would be return 0 always and use bpf-output for
> unaugmented syscalls too.  But I'm afraid it'd affect other perf tools
> using tracepoints.

Yep.

>
> >
> > Is this approach perfect? Absolutely not, there will likely be some
> > performance overhead on the kernel side. It is just a quick dirty fix
> > that makes perf trace run in parallel without failing. This patch is an
> > explanation on the reason of failures and possibly, a link used in a
> > nack comment.
>
> Thanks for your work, but I'm afraid it'd still miss some syscalls as it
> returns 0 sometimes.

My bad... For example this:

if (pid_filter__has(&pids_filtered, getpid()))
   return 0;

This patch is practically meaningless, but it passes the parallel tests.

Thanks,
Howard
