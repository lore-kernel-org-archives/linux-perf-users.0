Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE2523E320
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Oct 2025 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760083093; cv=none; b=T6VtOhuWT60AYb21Pb7nnbpfjNkG7UxpurZrxi0xzavMj4yWcsZ2sjMiJaHK95T/9mbQEYR95DkZSpxeRaD0IlrRKGjsm7Erz3OjIoWhPbK1joJAqhkt41KH0R4FvOFf1Pom3S039iGmuBYWxDQu/p3uGvi/mv9/LyRxudBTQOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760083093; c=relaxed/simple;
	bh=/EqQHNRDCS2YqzBq0RkItK1pvs5vi0KLmvOMTFqnmTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzL+xLt/tl8sT9UAo9VBAl4K2jKWoXdVgWbOT1itYUxCA96Zkn5xX+UP0ptzEwGepPhSf1aTUaZc/qRrZ2HtlEHJEwjecPFT+BGdGH9+0FZMvv2eOmY54p2IM94Tib97IegAaPDdJjyu/WoVJaoF4FyYVmsUcEsRPiTO/ShWDIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnpTac5Z; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnpTac5Z"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6093f8f71dso1091893a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Oct 2025 00:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760083091; x=1760687891; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Nucw4E7LkwzxjCbFb3F737DKijbeBN9zMwZ0PDOoZQ=;
        b=LnpTac5ZvTS/UYEVB7W5KdB+cWLKdYtewYzALu7433gOuYAcGX1oFy0Q19ip8xcFCa
         VPvqP8SCUx+/XjNgHL8vB33TujuA0mC2YoXnFFaGf/K6hmYJQSStvsPkmYHDHvwWGBB9
         H25tihr2gvHnD9+QUe7VqDsb4j4ikRlvsXp8WF71t3vbG8l1ehFojIQi9pYHpBP7W6/A
         vqU5elROKHmEcCx+LOrpJDHvz4jqYqj6ZObpvjQ2rw6SyAsHiWwVY1K5mSEmwywqFgpO
         xN/78d3SCni1185cDyOSCn+FmZXFwCwbuKfofh82uNWMtcsHZ4vfgd8JPfiDTxs1PC8C
         1iDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760083091; x=1760687891;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Nucw4E7LkwzxjCbFb3F737DKijbeBN9zMwZ0PDOoZQ=;
        b=O9kopbmJeEh5XZMT+yB2DeobDt5+1PO5maHrmx/3FsNsyToow/wX28ifYy23tz5EgH
         SA595MCvIEY9K7K8IE45eBQfrN57qpz4ihZuY3ZBzihd5MxgMz24QpGeqCQ4eVFoamig
         roYM4L5ingYv4cnzu27fXpcOJBgaSM4mztBVs+RRMMAIwPC1/oD58MDnv5NBW9cfzMz4
         ofP6A3sjB93cpcaSnHT+Y/ro8mIqElXkOmYX+ZIP/YrdTG+adYO2dc0MpLGlfg8dgjDM
         7oJ813bjxTb36Ev9DlXYiBZuqzlPL+Tze+Oxgr7YyvdE8vtbCZnnjWRTRvgOL+Rv29ps
         wPTg==
X-Forwarded-Encrypted: i=1; AJvYcCVjflqO+WG+sYY/k3/RxXvoAbSrvyuKdl1nyQDvgoPLzsp+NX5wJ2I4QKL8Dvr2N4ROH1iC6983wqropOkIJjkj@vger.kernel.org
X-Gm-Message-State: AOJu0YyfF2LSGaQbvCDReb0wPgYkoM0yY31a5ASG+Ya0qV0+Hk4hGLDD
	9eSLTqMGsIek5GGEWjBE42+U60W299yW1qUyssDgWAaxzgWYEnh4XSjf
X-Gm-Gg: ASbGncs/+WSRrgMDWM9xDFXbNpCpH6/4iJ2DfTn/coEbZ0fs3E14TcZl1B4e00g4YRt
	5dcWzb3TBVjqTqB1LS3wINPMjnFxfs8ppHuElNK8nIGvLugYQRsT3KkIp5kq/UVM//f7MQ/ogwX
	BmKLkB88aARvLotnv65urCfmmsgm71cZ9HVwJQrKfrujCkAWzPFR7cXIDV17T/STlzgYgg8SjKa
	bY9VXbTxfLBKQnRBsi2vaNQK131dsfXtzTbNlPaGY5p55YnWCeQwEIycUy2TP6dxLw1FbS8Qc4U
	9nz0dCvdA3CkrjwK9Rj91qjP3eGGAUzLfmAFlyvl5TDeU8BIgU3ewQtMD0f4TWT9v2ufgJQs+ms
	fAVsWcGVXhy10/gSjqJEso3KYFXnYM1sGDdoDbq0mAki5TzKwpHxyxqzYUDEmdl1cNiI=
X-Google-Smtp-Source: AGHT+IFeywA6gB4/SQbmJGvT2KY5YTMhXWywBtcaIqaAsauF4r7EzLqcGRXLsSas3aRqscvIRrL6Qg==
X-Received: by 2002:a17:903:298e:b0:28e:756c:7082 with SMTP id d9443c01a7336-29027374b38mr134966335ad.15.1760083090502;
        Fri, 10 Oct 2025 00:58:10 -0700 (PDT)
Received: from localhost ([103.121.208.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f070ecsm49587725ad.60.2025.10.10.00.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 00:58:09 -0700 (PDT)
Date: Fri, 10 Oct 2025 15:58:03 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>, Rong Xu <xur@google.com>,
	Naveen N Rao <naveen@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>, Nam Cao <namcao@linutronix.de>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org, llvm@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com, "David S. Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/23] mm/ksw: Introduce real-time KStackWatch
 debugging tool
Message-ID: <aOi8i1Y0decaamaX@mdev>
References: <20251009105650.168917-1-wangjinchao600@gmail.com>
 <20251009175107.ee07228e3253afca5b487316@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251009175107.ee07228e3253afca5b487316@linux-foundation.org>

On Thu, Oct 09, 2025 at 05:51:07PM -0700, Andrew Morton wrote:
> On Thu,  9 Oct 2025 18:55:36 +0800 Jinchao Wang <wangjinchao600@gmail.com> wrote:
> 
> > This patch series introduces KStackWatch, a lightweight debugging tool to detect
> > kernel stack corruption in real time. It installs a hardware breakpoint
> > (watchpoint) at a function's specified offset using `kprobe.post_handler` and
> > removes it in `fprobe.exit_handler`. This covers the full execution window and
> > reports corruption immediately with time, location, and a call stack.
> > 
> > The motivation comes from scenarios where corruption occurs silently in one
> > function but manifests later in another, without a direct call trace linking
> > the two. Such bugs are often extremely hard to debug with existing tools.
> > These scenarios are demonstrated in test 3–5 (silent corruption test, patch 20).
> > 
> > ...
> >
> >  20 files changed, 1809 insertions(+), 62 deletions(-)
> 
> It's obviously a substantial project.  We need to decide whether to add
> this to Linux.
> 
> There are some really important [0/N] changelog details which I'm not
> immediately seeing:

Thanks for the review and questions.

> 
> Am I correct in thinking that it's x86-only?  If so, what's involved in
> enabling other architectures?  Is there any such work in progress?

Currently yes.
There are two architecture-specific dependencies:

- Hardware breakpoint (HWPB) modification in atomic context.
  This has been implemented for x86 in patches 1–3.
  I think it is not a big problem for other architectures.

- Stack canary locating mechanism, which does not work on parisc:
  - Automatic canary discovery scans from the stack base to high memory.
  - This feature is optional; a stack offset address can be provided instead.

Future work could include enabling support for other architectures such
as arm64 and riscv once their hardware breakpoint implementations allow
safe modification in atomic context. I do not currently have the
environment to test those architectures, but the framework was designed
to be generic and can be extended by contributors familiar with them.

> What motivated the work?  Was there some particular class of failures
> which you were persistently seeing and wished to fix more efficiently?
> 
> Has this code (or something like it) been used in production systems? 
> If so, by whom and with what results?

The motivation came from silent stack corruption issues. They occur
rarely but are extremely difficult to debug. I personally encountered
two such bugs which each took weeks to isolate, and I know similar
issues exist in other environments. KStackWatch was developed as a
result of those debugging efforts. It has been used mainly in my own
debugging environment and verified with controlled test cases
(patches 17–21). If it had existed earlier, similar bugs could have
been resolved much faster.

> 
> Has it actually found some kernel bugs yet?  If so, details please.

It was designed to help diagnose bugs whose existence was already known
but whose root cause was difficult to locate. So far it has been used
in my personal environment and can be validated with controlled test
cases in patches 17–21.

> 
> Can this be enabled on production systems?  If so, what is the
> measured runtime overhead?

I believe it can.  The overhead is summarized below.

Without watching:
  - Per-task context: 2 * sizeof(ulong) + 4 bytes (≈20 bytes on x86_64)

With watching:
  - Same per-task context as above
  - One or more preallocated HWBPs (configurable, at least one)
  - Small additional memory for managing HWBP and context state
  - Runtime overhead (measured on x86_64):

       Type                 |   Time (ns)  |  Cycles
       -----------------------------------------------
       entry with watch     |     10892    |   32620
       entry without watch  |       159    |     466
       exit  with watch     |     12541    |   37556
       exit  without watch  |       124    |     369

Would you prefer that I include the measurement code (used to collect the
timing and cycle statistics shown above) in the next version of the patch
set, or submit it separately as an additional patch?

-- 
Jinchao
