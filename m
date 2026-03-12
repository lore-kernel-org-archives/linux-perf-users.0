Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095A53EFD12
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335940; cv=none; b=B3VSxIyzCSnlY+QrMlS65acpgu6tLf7AqTb1JMfA9Af95mUYaz4MnXrgGeaCcC2fJg3L5UPS7TuQyrYbfkH0pzBiVk4XsOptYxrdAOhatTqQZD/yRN/ADCFAN94R9gN3CeOU6q4HvFE+wCBWQ6MOo1yEfb1Pft8ICy0F7zzWI24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335940; c=relaxed/simple;
	bh=2DyJ8lnC1ffswG3cfvrH8ldY+pLM26LTaV++/K7wf+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZde2h/W/L/dGORYZ8ZVnvmp7QshNSnFkEAoxJyR2WNEFgdMIauI+z5KkSDA6bpObkSF4rGUjkNSi6yhfry/u2M5oxMcQ0xrf1Q49OEq74Z33aY5r9zoe/tzGgbSyBNjuMdryl4YILMycx4VtQAN5DfgG5GufSUmhcBpNxc/TKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PLmLD7/D; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PLmLD7/D"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-126ea4e9697so632c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773335937; x=1773940737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QQrPOJ4IgTYDp8ptNQZ8cyDSS7gullqrxNuyd+nPtUw=;
        b=PLmLD7/D+t22xX5KdyOIcTYY63ORAymEu4eJ5drtPthX61O9c6Q3uqJ4VOQ7+uzL+h
         pkgtSIg/weiJESI+hqA8DNrJh147UawUyAcRAMjL2ZXb735aXU9tDtg9HI/w/rmI2Hyx
         R1azu6sWMgHrdZDOT+45+olTl4p5GDYJdPK/VUSyJt2Fe/vQ0m/PGnA7sn0RnQlzviGh
         jYtr49PEG7eYV7CBhafYjxjsXVSa2D4qqQ87/bNGevE92RXKMCkUIJiUCvpZOu/JiMw5
         wqEWeC0+QygYgEcIoFSvlpwQY/f403v654A9yVd69TXvDXEGmzSyIO953KRMxXVR6LLb
         wlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773335937; x=1773940737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQrPOJ4IgTYDp8ptNQZ8cyDSS7gullqrxNuyd+nPtUw=;
        b=mWISVGGvLymsdSbs7f8XMchEX/8q7pF1vr09oh3TYpKYEzrhKhibgvWTc1Kau01DJs
         us2rrcpeJAWxeROSxfmK8TF1wXqIsbbeKSmlgGwF/g+BIEKSJMidS7MiGhlsmhb7+1cB
         dVwPiv+uXElZNqUOEWrxGg7KBsZUZTuvyteCbOsuzhqZn2CDAAf/lSSXdLujellPNK7D
         6Oip2pZRJz4ECB50RuybD+z40cWmGPBXRlzf8YeycPWqsSn7OW3VaO6hk3T3v5bQwvGy
         GrUYaDoBCPd37EEtLiDDRMSErzVdCp5x8gfDzbUFMYZAK/Amx1vfmUgtLH+XDsimUWuD
         nYJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkc0M51jMINOlQ7m1bCbW9wHl6aznUvJ7Cfg5BtK1jRfJHnBO+cjIip7mLLM6J8uTL7K57PrxQ4KNg/sgiGCVm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+rGr0xFEi2D1y6DoHYC8ikVl2+HodLfK5o7j1rO8AAHlaxwRV
	b7Bht4ZDOZ50IBHZ34b07r3cWitjAVWa+iujPJB1+7knapV4OMPRCjZTRJNYGTouVQ==
X-Gm-Gg: ATEYQzyQBAwNsWtisfQGe12UEuVmcj552j8dxQtdv0IFTJVEBI4AXzEFzununGJl6TH
	QUK/DuuBKk9yzOEQT7nUTCNheN6s2aKK7+WtxW4PMcqP1MjeNctnWW/+F0VUHJM/Ki3OcCuEJ/Z
	NUc/gJEn6tX4FYzGSe70JYJVzQpsjW485V+tsVmoPpXGCYONK7S9PfHZInVJB7naUxTKt3XxSV/
	VsMXN+r6ocqLtMlqCTNx04dY6KtZ2a9fOOXaj5RxcmcvtFLe8WjBoKci3pb6WVhMpW/KKCpr3MO
	7mnRguAjcalIT5vi0f1OALqHyvGbyUixYDh5sbKdFmqzTIOZ2w+pyFnqFZ8pcbIHtpVHRC9W9XE
	RlI4SZgc1F/ukrAijpX1LCvKKeNf/rS0QOAi2l35eecPMEusJqnaxYI/Q1/xuRRALaikscNswb8
	96ZY1Bgb4YJ0T5rEqlmVSFTzxjg6uK8UEz6eO4gsYS5Mebi6fHpJtyG0xH0Jkrsw==
X-Received: by 2002:a05:701b:4294:20b0:11a:4c75:a45b with SMTP id a92af1059eb24-128f43a0537mr6681c88.10.1773335936173;
        Thu, 12 Mar 2026 10:18:56 -0700 (PDT)
Received: from google.com (154.52.125.34.bc.googleusercontent.com. [34.125.52.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8aa4ff66sm7182541eec.19.2026.03.12.10.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 10:18:55 -0700 (PDT)
Date: Thu, 12 Mar 2026 17:18:51 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Kees Cook <kees@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Jens Remus <jremus@linux.ibm.com>, Juergen Gross <jgross@suse.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	David Kaplan <david.kaplan@amd.com>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	James Morse <james.morse@arm.com>, Thomas Huth <thuth@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	Will McVicker <willmcvicker@google.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] static_call: use CFI-compliant return0 stubs
Message-ID: <abL1e8o3Geqj2aec@google.com>
References: <20260309223156.GA73501@google.com>
 <20260311225822.1565895-1-cmllamas@google.com>
 <20260311231406.GZ606826@noisy.programming.kicks-ass.net>
 <abIFwSF1RqhC96C2@google.com>
 <742d77a8-3c53-4814-9dd6-81e8317cd829@app.fastmail.com>
 <20260312080740.GC606826@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312080740.GC606826@noisy.programming.kicks-ass.net>

On Thu, Mar 12, 2026 at 09:07:40AM +0100, Peter Zijlstra wrote:
> On Thu, Mar 12, 2026 at 08:40:11AM +0100, Ard Biesheuvel wrote:
> > So far, we have managed to avoid the blessings of objtool on arm64,
> > and the complexity associated with the inline patching is not really
> > justified, given that on arm64, there is not really a need to avoid
> > indirect calls (and as Peter says, we might end up with them anyway)
> > 
> > A while ago, I had a stab at implementing the out-of-line variety [0],
> > but nobody cared enough to even respond. It is rather concise, and
> > localised to arm64, so it is something we might consider for
> > CONFIG_CFI builds. It is essentially the same sequence that arm64 uses
> > for trampolines between modules and the kernel if they are out of
> > direct branching range, with some .rodata patching to change the
> > target. (arm64 basically only permits code patching without stopping
> > the machine when it involves patching branch opcodes into NOPS or vice
> > versa).

Great! I'll go read your implementation then.

> > Doing so for only CONFIG_CFI makes sense because it removes the CFI
> > overhead for all static calls, although it adds back some overhead for
> > the trampoline. But there is currently no need to do this
> > unconditionally.
> 
> Right, so your v3 is very simple and straight forward, and should work
> as an end run around the CFI issue, by effectively doing that indirect
> tail call in the trampoline outside of the compiler generated software
> cfi things.
> 
> And I think I like your thing better because it handles all possible
> cases, not just the ret0 oddity and isn't in fact much larger.

SGTM, I'll switch over to testing Ard's patch.

Thanks,
Carlos Llamas
